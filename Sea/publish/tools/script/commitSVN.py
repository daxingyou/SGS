#!/usr/bin/env python
# coding=utf-8

import pexpect
import os
import sys
import utils
import shutil
import getopt
from argparse import ArgumentParser
def main(cfgFile=None):
    #
    parser = ArgumentParser(description="res")
    parser.add_argument("-p", "--path", dest="path")
    (args, unkonw) = parser.parse_known_args(sys.argv[1:])

    svnInfo = utils.getSVNInfo()
    
    dirPublish = args.path

    # commit
    cmd = "svn status %s" % os.path.abspath(dirPublish)
    print(cmd)
    output = os.popen(cmd).read()
    print(output)
    svnLines = output.splitlines()
    for v in svnLines:
        filePath = v[8:]
        if v.find("!",0,7) != -1:
            cmd = "svn delete %s" % filePath
            print(cmd)
            os.popen(cmd)

        if v.find("?",0,7) != -1:
            cmd = "svn add %s" % filePath
            print(cmd)
            os.popen(cmd)


    cmd = "svn commit --username %s --password %s -m \"提交自动构建APP\" %s" % (svnInfo["n"], svnInfo["p"], os.path.abspath(dirPublish))
    cmd_pirnt = "svn commit -m \"提交自动构建APP\" %s" % (os.path.abspath(dirPublish))
    print(cmd_pirnt)
    output = os.popen(cmd).read()
    print(output)


    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")

if __name__ == '__main__':
    utils.runMain(main)
