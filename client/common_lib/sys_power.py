#!/usr/bin/python

# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Provides utility methods for controlling powerd in ChromiumOS.
"""

import os
from autotest_lib.client.common_lib import utils

SUSPEND_CMD='/usr/bin/powerd_suspend'

def set_state(state):
    """
    Set the system power state to 'state'.
    """
    file('/sys/power/state', 'w').write("%s\n" % state)


def suspend_to_ram():
    """
    Suspend the system to RAM (S3)
    """
    if os.path.exists(SUSPEND_CMD):
        utils.system(SUSPEND_CMD)
    else:
        set_power_state('mem')


def suspend_to_disk():
    """
    Suspend the system to disk (S4)
    """
    set_power_state('disk')

def standby():
    """
    Power-on suspend (S1)
    """
    set_power_state('standby')

