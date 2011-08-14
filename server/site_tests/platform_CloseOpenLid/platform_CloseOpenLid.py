# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

from autotest_lib.server.cros import servo_test

class platform_CloseOpenLid(servo_test.ServoTest):
    """Uses servo to send the host to sleep and wake back up.

    Uses pwr_button and lid_open gpios in various combinations.
    """
    version = 1


    def run_once(self, host):
        self.assert_ping()

        # lid only
        self.servo.lid_close()
        self.assert_pingfail()
        self.servo.lid_open()
        self.servo.pass_devmode()
        self.wait_for_client()

        # pwr_button and open lid
        self.servo.power_long_press()
        self.assert_pingfail()
        self.servo.lid_close()
        self.servo.lid_open()
        self.servo.pass_devmode()
        self.wait_for_client()
