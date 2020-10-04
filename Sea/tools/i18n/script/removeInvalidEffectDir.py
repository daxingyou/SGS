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
from distutils.version import LooseVersion

 
def removeInvalidDir(DIR):
    # print("removeInvalidDir = %s" % DIR)
    lists = os.walk(DIR)
    deep = 0
    for root, dirs, files in lists:
        for d in dirs:
            # print("dir: = %s" % d)
            names = d.split(".")
            # utils.printObject(names,"dirs :")
            rmPath = os.path.join(root, d)
            if names[0] == "" and names[-1] == "Dir":
                # print("%srm:%s" % ( "    " * deep,rmPath) )
                print("removeInvalidDir = %s" % rmPath)
                shutil.rmtree(rmPath)
            else:
                removeInvalidDir(rmPath)
                pass
            

def main(cfgFile=None):

    dirScript           = os.path.dirname(utils.getExecPath())
    dirConfig           = os.path.join(dirScript, "..", "config")
    dirMD5              = os.path.join(dirScript, "..", "md5")
    dirTags            = os.path.join(dirScript, "..", "..", "..", "tags")
    dirClient           = os.path.join(dirScript, "..", "..", "..", "trunk")

    dirList = []
    dirList.append(dirClient)
 
    for filename  in os.listdir(dirClient):
        path = os.path.join(dirClient,filename)
        dirList.append(path)
        
    for filename  in os.listdir(dirTags):
        path = os.path.join(dirTags,filename)
        dirList.append(path)
        
    for dirPath in dirList:
        dirProject = os.path.join(dirPath, "cocosstudio")
        if os.path.exists(dirProject):
            print("------------- remove project = %s --------------" % dirProject)
            dirRes = os.path.join(dirProject, "res")
            removeInvalidDir(dirRes)



if __name__ == "__main__":
    utils.runMain(main)
