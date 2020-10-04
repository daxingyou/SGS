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
import json
import struct
import sys
from distutils.version import LooseVersion
from argparse import ArgumentParser

def main(cfgFile=None):
    #
    parser = ArgumentParser(description="res")
    parser.add_argument("-c", "--config", dest="config")
    parser.add_argument("-p", "--project", dest="project")
    (args, unkonw) = parser.parse_known_args(sys.argv[1:])

    # tools/script
    dirExec             = os.path.dirname(utils.getExecPath())
    # tools/config
    dirConfig           = os.path.join(dirExec, "..", "config")
    dirConfigFile       = os.path.join(dirConfig, args.config, "version.json")

    #
    cfgFileVersion      = utils.getVersionConfig(dirConfig, args.config)
    cfgNewVersion       = cfgFileVersion["version"][-1]
    cfgVersionList      = cfgFileVersion["version"]

    if cfgNewVersion["path"] == "trunk":
        dirProject = os.path.join(args.project, "cocosstudio")
    else:
        dirProject = os.path.join(args.project, cfgNewVersion["path"], "cocosstudio")

    #
    svnInfo = utils.getSVNInfo()
    maxVersionCode = cfgNewVersion["name"]
    verList = maxVersionCode.split('.')
    print verList
    if int(verList[2])+1 > 99:
        verList[2] = "0"
        if int(verList[1])+1 > 99:
            verList[1] = "0"
            verList[0] = str(int(verList[0]) + 1)
        else:
            verList[1] = str(int(verList[1]) + 1)
    else:
        verList[2] = str(int(verList[2]) + 1)

    cfgVerNewRes = "%s.%s.%s" %(verList[0], verList[1], verList[2])

    # update max version
    print("\033[31msvnversion -------------------------------------------------------------------------------------\033[34m")
    cmd = "cd %s && svnversion -c |sed 's/^.*://' |sed 's/[A-Z]*$//'" % (dirProject)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)

    newVersion = {}
    newVersion["name"] = cfgVerNewRes
    newVersion["svn"] = int(output)
    newVersion["path"] = cfgNewVersion["path"]
    cfgVersionList.append(newVersion)

    json.dump(cfgFileVersion, open(dirConfigFile, "w"), ensure_ascii=False, indent=4)
    
    cmd = "svn commit --username %s --password %s -m \"%s new version = %s:%s\" %s" % (svnInfo["n"], svnInfo["p"], args.config, cfgVerNewRes, output, os.path.abspath(dirConfigFile))
    print(cmd)
    output = os.popen(cmd).read()
    print(output)


    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")
    
if __name__ == "__main__":
    utils.runMain(main)
