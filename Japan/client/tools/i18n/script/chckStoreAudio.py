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

def getList(xlsxFile,indexList):
    xlsxList = utils.readXlsxFile2(xlsxFile)
    txtList = []
    length = len(xlsxList)
    for idx in range(0, length):
        sheetList = xlsxList[idx]
        for sheet in list(sheetList):
            if len(indexList)>1:
                line = []
                for index in list(indexList):
                    txt = sheet[index]
                    print("getList line txt = %s" % txt)
                    line.append(txt)
                txtList.append(line)
            else:
                txt = sheet[indexList[0]]
                txtList.append(txt)        
                print("getList  txt = %s" % txt)

    return txtList


def main(cfgFile=None):
    
    dirScript           = os.path.dirname(utils.getExecPath())
    dirConfig           = os.path.join(dirScript, "..", "config")
    dirMD5              = os.path.join(dirScript, "..", "md5")
    dirMD5              = os.path.join(dirScript, "..", "md5")
    dirTags            = os.path.join(dirScript, "..", "..", "..", "tags")
    dirClient           = os.path.join(dirScript, "..", "..", "..", "trunk")

    # tools/config
    dirSysText = os.path.join(dirScript, "..", "sysText")

    dirSource = os.path.join(dirClient, "2.14.0", "cocosstudio","audio","ja","voice")

    dirStoryAudio = os.path.join(dirScript, "..", "sysText","story_audio")
    dirStoryAudio_source = os.path.join(dirScript, "..", "sysText","story_audio","source")
    dirStoryAudio_exists = os.path.join(dirScript, "..", "sysText","story_audio","exists")
    dirStoryAudio_not_exists = os.path.join(dirScript, "..", "sysText","story_audio","no_use")
    
    xlsxFile = "story_audio.xlsx"

    mp3_suffix = ".mp3"

    utils.cleanDir(dirStoryAudio,[])
    utils.mkOutDir(dirStoryAudio_source,True)
    utils.mkOutDir(dirStoryAudio_exists, True)
    utils.mkOutDir(dirStoryAudio_not_exists, True)

    utils.copyDir(dirSource,dirStoryAudio_source)

    sysTextList = getList( os.path.join(dirSysText, xlsxFile),[0] )

    exists = []
    not_exists = []

    for audio in list(sysTextList):
        audioFile  = audio + mp3_suffix
        if os.path.exists( os.path.join(dirStoryAudio_source, audioFile) ):
            exists.append([audioFile])
            utils.copyFile(os.path.join(dirStoryAudio_source, audioFile) ,os.path.join(dirStoryAudio_exists, audioFile))
            utils.removeFile(os.path.join(dirStoryAudio_source, audioFile))
        else:
            not_exists.append([audioFile])

    utils.copyDir(dirStoryAudio_source, dirStoryAudio_not_exists)

    utils.writeCsvFile(exists, os.path.join(dirStoryAudio, "story_audio_exists.csv"),["name"])
    utils.writeCsvFile(not_exists, os.path.join(dirStoryAudio, "story_audio_no_use.csv"),["name"])

    utils.removeDir(dirStoryAudio_source)
    pass





if __name__ == "__main__":
    utils.runMain(main)
