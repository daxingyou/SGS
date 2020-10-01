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
import json

def main(cfgFile=None):
    # tools/script
    dirExec         = os.path.dirname(utils.getExecPath())
    dirPngquant     = os.path.join(dirExec, "..", "external", "pngquant")

    opts, args = getopt.getopt(sys.argv[1:], "p:")
    path = ""
    for op, value in opts:
        if op == "-p":
            path = value

    jsonConfig = []
    for dirpath, dirnames, filenames in os.walk(path):
        #sub = dirpath[len(path):].strip("/\\")
        for filename in filenames:
            if os.path.splitext(filename)[1] == '.png' or os.path.splitext(filename)[1] == '.csb':
                fpath = os.path.join(dirpath, filename)
                fpath = fpath[fpath.find("/res/")+len("/res/"):len(fpath)]
                jsonConfig.append(fpath)
                #jsonConfig[filename] = fpath
            if os.path.splitext(filename)[1] == '.lua':
                fpath = os.path.join(dirpath, os.path.splitext(filename)[0])
                fpath = fpath[fpath.find("/src/")+len("/src/"):len(fpath)]
                fpath = fpath.replace("/", ".")
                jsonConfig.append(fpath)

    configPath = os.path.join(path, "load.json")
    json.dump(jsonConfig, open(configPath, "w"))
                    

if __name__ == "__main__":
    utils.runMain(main)
