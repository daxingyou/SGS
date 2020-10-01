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
    print("cleanDir = %s" % DIR)
    lists = os.walk(DIR)
    deep = 0
    for root, dirs, files in lists:
        for d in dirs:
            # print("dir: = %s" % d)
            names = d.split(".")
            # utils.printObject(names,"dirs :")
            if names[0] == "" and names[-1] == "Dir":
                rmPath = os.path.join(root, d)
                print("%srm:%s" % ( "    " * deep,rmPath) )
                shutil.rmtree(rmPath)
            

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
            print("------------- 删除tags = %s --------------" % dirProject)
            #dirVnEffect = os.path.join(dirProject, "res")
            #removeInvalidDir(dirVnEffect)
            dirEffect = os.path.join(dirProject,"res","effect")
            removeInvalidDir(dirEffect)
            # dirVnEffect = os.path.join(dirProject, "res","i18n","vn","effect")
            dirVnEffect = os.path.join(dirProject, "res","i18n","vn","effect")
            removeInvalidDir(dirVnEffect)
            dirEffect = os.path.join(dirProject, "res","i18n","tw","effect")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res","i18n","cn","effect")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res","i18n","base","effect")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res","i18n","ja","effect")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res","ui3","text")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res", "ja", "ui3","text")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res","i18n", "ja", "ui3","text")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res", "vn", "ui3","text")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res","i18n", "vn", "ui3","text")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res","i18n","zh","effect")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res", "i18n","zh", "ui3","text")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res","i18n", "vn", "ui3","text")
            removeInvalidDir(dirEffect)
            dirEffect = os.path.join(dirProject, "res","effect")
            removeInvalidDir(dirEffect)




if __name__ == "__main__":
    utils.runMain(main)
