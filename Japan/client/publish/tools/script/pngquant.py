#!/usr/bin/env python
# coding=utf-8

import os
import zipfile
import hashlib
import platform
import re
import StringIO
import collections
import shutil
import utils
import sys
import getopt
import struct
def main(cfgFile=None):
    # tools/script
    dirExec         = os.path.dirname(utils.getExecPath())
    dirPngquant     = os.path.join(dirExec, "..", "external", "pngquant")

    opts, args = getopt.getopt(sys.argv[1:], "p:")
    path = ""
    for op, value in opts:
        if op == "-p":
            path = value


    for dirpath, dirnames, filenames in os.walk(path):
        #sub = dirpath[len(path):].strip("/\\")
        for filename in filenames:
            if os.path.splitext(filename)[1] == '.png':
                fpath = os.path.join(dirpath, filename)
                cmd = "%s -s 1 -f -o %s %s" % (dirPngquant, fpath, fpath)
                print(cmd)
                utils.runShell(cmd, wait=True)

                    

if __name__ == "__main__":
    utils.runMain(main)
