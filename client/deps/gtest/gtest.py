#!/usr/bin/python

# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

import common, commands, logging, os, shutil
from autotest_lib.client.bin import utils

version = 1

def setup(top_dir):
    # The copy the gtest files from the SYSROOT to the client
    usr_lib = os.environ['SYSROOT'] + '/usr/lib'
    os.chdir(usr_lib)
    utils.run('cp libgtest* ' + top_dir)
    
pwd = os.getcwd()
utils.update_version(pwd + '/src', False, version, setup, pwd)
