# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""A utility to program Chrome OS devices' firmware using servo.

This utility expects the DUT to be connected to a servo device. This allows us
to put the DUT into the required state and to actually program the DUT's
firmware using FTDI, USB and/or serial interfaces provided by servo.

Servo state is preserved across the programming process.
"""

import logging
import os

from autotest_lib.server.cros.faft.config.config import Config as FAFTConfig


class ProgrammerError(Exception):
    """Local exception class wrapper."""
    pass


class _BaseProgrammer(object):
    """Class implementing base programmer services.

    Private attributes:
      _servo: a servo object controlling the servo device
      _servo_prog_state: a tuple of strings of "<control>:<value>" pairs,
                         listing servo controls and their required values for
                         programming
      _servo_saved_state: a list of the same elements as _servo_prog_state,
                          those which need to be restored after programming
      _program_cmd: a string, the shell command to run on the servo host
                    to actually program the firmware. Dependent on
                    firmware/hardware type, set by subclasses.
    """

    def __init__(self, servo, req_list):
        """Base constructor.
        @param servo: a servo object controlling the servo device
        @param req_list: a list of strings, names of the utilities required
                         to be in the path for the programmer to succeed
        """
        self._servo = servo
        self._servo_prog_state = ()
        self._servo_saved_state = []
        self._program_cmd = ''
        # These will fail if the utilities are not available, we want the
        # failure happen before run_once() is invoked.
        self._servo.system('which %s' % ' '.join(req_list))


    def _set_servo_state(self):
        """Set servo for programming, while saving the current state."""
        logging.debug("Setting servo state for programming")
        for item in self._servo_prog_state:
            key, value = item.split(':')
            present = self._servo.get(key)
            if present != value:
                self._servo_saved_state.append('%s:%s' % (key, present))
            self._servo.set(key, value)


    def _restore_servo_state(self):
        """Restore previously saved servo state."""
        logging.debug("Restoring servo state after programming")
        self._servo_saved_state.reverse()  # Do it in the reverse order.
        for item in self._servo_saved_state:
            key, value = item.split(':')
            self._servo.set(key, value)


    def program(self):
        """Program the firmware as configured by a subclass."""
        self._set_servo_state()
        try:
            logging.debug("Programmer command: %s", self._program_cmd)
            self._servo.system(self._program_cmd)
        finally:
            self._restore_servo_state()


class FlashromProgrammer(_BaseProgrammer):
    """Class for programming AP flashrom."""

    def __init__(self, servo):
        """Configure required servo state."""
        super(FlashromProgrammer, self).__init__(servo, ['flashrom',])
        self._fw_path = None
        self._tmp_path = '/tmp'
        self._fw_main = os.path.join(self._tmp_path, 'fw_main')
        self._ro_vpd = os.path.join(self._tmp_path, 'ro_vpd')
        self._rw_vpd = os.path.join(self._tmp_path, 'rw_vpd')
        self._gbb = os.path.join(self._tmp_path, 'gbb')


    def program(self):
        """Program the firmware but preserve VPD and HWID."""
        assert self._fw_path is not None
        self._set_servo_state()
        try:
            vpd_sections = [('RW_VPD', self._rw_vpd), ('RO_VPD', self._ro_vpd)]
            gbb_section = [('GBB', self._gbb)]

            # Save needed sections from current firmware
            for section in vpd_sections + gbb_section:
                self._servo.system(' '.join([
                    'flashrom', '-V', '-p', 'ft2232_spi:type=servo-v2',
                    '-r', self._fw_main, '-i', '%s:%s' % section]))

            # Pack the saved VPD into new firmware
            self._servo.system('cp %s %s' % (self._fw_path, self._fw_main))
            img_size = self._servo.system_output(
                    "stat -c '%%s' %s" % self._fw_main)
            pack_cmd = ['flashrom',
                    '-p', 'dummy:image=%s,size=%s,emulate=VARIABLE_SIZE' % (
                        self._fw_main, img_size),
                    '-w', self._fw_main]
            for section in vpd_sections:
                pack_cmd.extend(['-i', '%s:%s' % section])
            self._servo.system(' '.join(pack_cmd))

            # Read original HWID. The output format is:
            #    hardware_id: RAMBI TEST A_A 0128
            gbb_hwid_output = self._servo.system_output(
                    'gbb_utility -g --hwid %s' % self._gbb)
            original_hwid = gbb_hwid_output.split(':', 1)[1].strip()

            # Write HWID to new firmware
            self._servo.system("gbb_utility -s --hwid='%s' %s" %
                    (original_hwid, self._fw_main))

            # Flash the new firmware
            self._servo.system(' '.join([
                'flashrom', '-V', '-p', 'ft2232_spi:type=servo-v2',
                '-w', self._fw_main]))
        finally:
            self._restore_servo_state()


    def prepare_programmer(self, path):
        """Prepare programmer for programming.

        @param path: a string, name of the file containing the firmware image.
        @param board: a string, used to find servo voltage setting.
        """
        faft_config = FAFTConfig(self._servo.get_board())
        self._fw_path = path
        self._servo_prog_state = (
            'spi2_vref:%s' % faft_config.wp_voltage,
            'spi2_buf_en:on',
            'spi2_buf_on_flex_en:on',
            'spi_hold:off',
            'cold_reset:on',
            )


class FlashECProgrammer(_BaseProgrammer):
    """Class for programming AP flashrom."""

    def __init__(self, servo):
        """Configure required servo state."""
        super(FlashECProgrammer, self).__init__(servo, ['flash_ec',])
        self._servo = servo


    def prepare_programmer(self, image):
        """Prepare programmer for programming.

        @param image: string with the location of the image file
        """
        # TODO: need to not have port be hardcoded
        self._program_cmd = 'flash_ec --board=%s --image=%s --port=%s' % (
            self._servo.get_board(), image, '9999')


class ProgrammerV2(object):
    """Main programmer class which provides programmer for BIOS and EC."""

    def __init__(self, servo):
        self._servo = servo
        self._bios_programmer = self._factory_bios(self._servo)
        self._ec_programmer = self._factory_ec(self._servo)


    def _factory_bios(self, servo):
        """Instantiates and returns (bios, ec) programmers for the board.

        @param servo: A servo object.

        @return A programmer for ec. If the programmer is not supported
            for the board, None will be returned.
        """
        _bios_prog = None
        _board = servo.get_board()

        servo_prog_state = [
            'spi2_buf_en:on',
            'spi2_buf_on_flex_en:on',
            'spi_hold:off',
            'cold_reset:on',
            ]

        logging.debug('Setting up BIOS programmer for board: %s', _board)
        if _board in ('daisy_spring', 'rambi', 'pit', 'spring',
                      'snow', 'daisy', 'monroe', 'panther', 'beltino',
                      'bolt', 'slippy', 'falco', 'link', 'stumpy',
                      'lumpy', 'parrot', 'stout', 'butterfly', 'alex',
                      'zgb', 'mario'):
            _bios_prog = FlashromProgrammer(servo)
        else:
            logging.warn('No BIOS programmer found for board: %s', _board)

        return _bios_prog


    def _factory_ec(self, servo):
        """Instantiates and returns ec programmer for the board.

        @param servo: A servo object.

        @return A programmer for ec. If the programmer is not supported
            for the board, None will be returned.
        """
        _ec_prog = None
        _board = servo.get_board()

        logging.debug('Setting up EC programmer for board: %s', _board)
        if _board in ('daisy', 'kirby', 'pit', 'puppy', 'snow',
                      'spring', 'discovery', 'nyan', 'bolt', 'samus',
                      'falco', 'peppy', 'rambi', 'slippy', 'link'):
            _ec_prog = FlashECProgrammer(servo)
        else:
            logging.warn('No EC programmer found for board: %s', _board)

        return _ec_prog


    def program_bios(self, image):
        """Programs the DUT with provide bios image.

        @param image: (required) location of bios image file.

        """
        self._bios_programmer.prepare_programmer(image)
        self._bios_programmer.program()

    def program_ec(self, image):
        """Programs the DUT with provide ec image.

        @param image: (required) location of ec image file.

        """
        self._ec_programmer.prepare_programmer(image)
        self._ec_programmer.program()