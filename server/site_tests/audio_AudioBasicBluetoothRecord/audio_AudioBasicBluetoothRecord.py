# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""This is a server side bluetooth record test using the Chameleon board."""

import logging
import os
import time, threading

from autotest_lib.client.bin import utils
from autotest_lib.client.common_lib import error
from autotest_lib.client.cros.audio import audio_test_data
from autotest_lib.client.cros.chameleon import audio_test_utils
from autotest_lib.client.cros.chameleon import chameleon_audio_helper
from autotest_lib.client.cros.chameleon import chameleon_audio_ids
from autotest_lib.server.cros.audio import audio_test
from autotest_lib.server.cros.multimedia import remote_facade_factory


class audio_AudioBasicBluetoothRecord(audio_test.AudioTest):
    """Server side bluetooth record audio test.

    This test talks to a Chameleon board and a Cros device to verify
    bluetooth record audio function of the Cros device.

    """
    version = 1
    DELAY_AFTER_DISABLING_MODULE_SECONDS = 30
    DELAY_AFTER_DISCONNECT_SECONDS = 5
    DELAY_AFTER_ENABLING_MODULE_SECONDS = 10
    DELAY_AFTER_RECONNECT_SECONDS = 5
    DELAY_BEFORE_RECORD_SECONDS = 0.5
    RECORD_SECONDS = 9
    SUSPEND_SECONDS = 30
    RESUME_TIMEOUT_SECS = 60
    PRC_RECONNECT_TIMEOUT = 60

    def action_suspend(self, suspend_time=SUSPEND_SECONDS):
        """Calls the host method suspend.

        @param suspend_time: time to suspend the device for.

        """
        self.host.suspend(suspend_time=suspend_time)


    def suspend_resume(self):
        """Performs the suspend/resume"""

        boot_id = self.host.get_boot_id()
        thread = threading.Thread(target=self.action_suspend)
        logging.info("Suspending...")
        thread.start()
        self.host.test_wait_for_sleep(self.SUSPEND_SECONDS / 3)
        logging.info("DUT suspended! Waiting to resume...")
        self.host.test_wait_for_resume(boot_id, self.RESUME_TIMEOUT_SECS)
        logging.info("DUT resumed!")

    def disconnect_connect_bt(self, link):
        """Performs disconnect and connect BT module

        @param link: binder link to control BT adapter

        """

        logging.info("Disconnecting BT module...")
        link.adapter_disconnect_module()
        time.sleep(self.DELAY_AFTER_DISCONNECT_SECONDS)
        audio_test_utils.check_audio_nodes(self.audio_facade,
                                           (None, ['INTERNAL_MIC']))
        logging.info("Connecting BT module...")
        link.adapter_connect_module()
        time.sleep(self.DELAY_AFTER_RECONNECT_SECONDS)


    def disable_enable_bt(self, link):
        """Performs turn off and then on BT module

        @param link: binder link to control BT adapter

        """

        logging.info("Turning off BT module...")
        link.disable_bluetooth_module()
        time.sleep(self.DELAY_AFTER_DISABLING_MODULE_SECONDS)
        audio_test_utils.check_audio_nodes(self.audio_facade,
                                           (None, ['INTERNAL_MIC']))
        logging.info("Turning on BT module...")
        link.enable_bluetooth_module()
        time.sleep(self.DELAY_AFTER_ENABLING_MODULE_SECONDS)
        logging.info("Connecting BT module...")
        link.adapter_connect_module()
        time.sleep(self.DELAY_AFTER_RECONNECT_SECONDS)


    def run_once(self, host, suspend=False,
                 disable=False, disconnect=False):
        """Running Bluetooth basic audio tests

        @param host: device under test host
        @param suspend: suspend flag to enable suspend before play/record
        @param disable: disable flag to disable BT module before play/record
        @param disconnect: disconnect flag to disconnect BT module
            before play/record

        """

        self.host = host
        golden_file = audio_test_data.SIMPLE_FREQUENCY_TEST_FILE

        factory = remote_facade_factory.RemoteFacadeFactory(host)
        self.audio_facade = factory.create_audio_facade()

        chameleon_board = host.chameleon
        chameleon_board.reset()

        widget_factory = chameleon_audio_helper.AudioWidgetFactory(
                factory, host)

        source = widget_factory.create_widget(
            chameleon_audio_ids.ChameleonIds.LINEOUT)
        bluetooth_widget = widget_factory.create_widget(
            chameleon_audio_ids.PeripheralIds.BLUETOOTH_DATA_TX)
        recorder = widget_factory.create_widget(
            chameleon_audio_ids.CrosIds.BLUETOOTH_MIC)

        binder = widget_factory.create_binder(
                source, bluetooth_widget, recorder)

        with chameleon_audio_helper.bind_widgets(binder):

            # Checks the input node selected by Cras is internal microphone.
            # Checks crbug.com/495537 for the reason to lower bluetooth
            # microphone priority.
            audio_test_utils.check_audio_nodes(self.audio_facade,
                                               (None, ['INTERNAL_MIC']))

            # Selects bluetooth mic to be the active input node.
            self.audio_facade.set_selected_node_types([], ['BLUETOOTH'])

            # Checks the node selected by Cras is correct again.
            audio_test_utils.check_audio_nodes(self.audio_facade,
                                               (None, ['BLUETOOTH']))

            # Starts playing, waits for some time, and then starts recording.
            # This is to avoid artifact caused by codec initialization.
            source.set_playback_data(golden_file)

            # Create link to control BT adapter.
            link = binder.get_binders()[1].get_link()

            if disable:
                self.disable_enable_bt(link)
            if disconnect:
                self.disconnect_connect_bt(link)
            if suspend:
                self.suspend_resume()
            utils.poll_for_condition(condition=factory.ready,
                                     timeout=self.PRC_RECONNECT_TIMEOUT,)

            # Select again BT input as default input node is INTERNAL_MIC
            self.audio_facade.set_selected_node_types([], ['BLUETOOTH'])
            audio_test_utils.check_audio_nodes(self.audio_facade,
                                               (None, ['BLUETOOTH']))

            logging.info('Start playing %s on Chameleon',
                         golden_file.path)
            source.start_playback()

            time.sleep(self.DELAY_BEFORE_RECORD_SECONDS)
            logging.info('Start recording from Cros device.')
            recorder.start_recording()

            time.sleep(self.RECORD_SECONDS)

            recorder.stop_recording()
            logging.info('Stopped recording from Cros device.')

            recorder.read_recorded_binary()
            logging.info('Read recorded binary from Chameleon.')

        recorded_file = os.path.join(self.resultsdir, "recorded.raw")
        logging.info('Saving recorded data to %s', recorded_file)
        recorder.save_file(recorded_file)

        # Removes noise by a lowpass filter.
        recorder.lowpass_filter(2000)
        recorded_file = os.path.join(self.resultsdir, "recorded_filtered.raw")
        logging.info('Saving filtered data to %s', recorded_file)
        recorder.save_file(recorded_file)

        # Compares data by frequency. Audio signal recorded by microphone has
        # gone through analog processing and through the air.
        # This suffers from codec artifacts and noise on the path.
        # Comparing data by frequency is more robust than comparing by
        # correlation, which is suitable for fully-digital audio path like USB
        # and HDMI.
        if not chameleon_audio_helper.compare_recorded_result(
                golden_file, recorder, 'frequency'):
            raise error.TestFail(
                    'Recorded file does not match playback file')