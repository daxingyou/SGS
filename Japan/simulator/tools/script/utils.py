#!/usr/bin/env python
# coding=utf-8

import os
import zipfile
import shutil
import hashlib
import platform
import re
import StringIO
import collections
import ConfigParser
import subprocess
import sys
import getopt
import uuid
import json
import urllib
import base64

from xml.etree import ElementTree as ET
from xml.etree.ElementTree import SubElement
from xml.etree.ElementTree import Element
from xml.etree.ElementTree import ElementTree


def printSplit(name):
    length = len(name)
    length = int((50 - length))
    #print("%s %s" % (name, "-"*length))

def printObject(object, name):
    print("%s = %s" % (name, json.dumps(object, indent=4)))

def getuuid(name):
    return uuid.uuid3(uuid.NAMESPACE_DNS, name)

def byteify(input):
    if isinstance(input, dict):
        return {byteify(key):byteify(value) for key,value in input.iteritems()}
    elif isinstance(input, list):
        return [byteify(element) for element in input]
    elif isinstance(input, unicode):
        return input.encode('utf-8')
    else:
        return input

def getConfigJson(DIR, cfgName):
    bname = os.path.basename(cfgName)
    iniName = os.path.splitext(bname)[0] + ".json"
    cfgPath = os.path.join(DIR, iniName)
    cfg = json.load(open(cfgPath, 'r'))
    #cfg = byteify(cfg)
    return cfg, cfgName, cfgPath

def getJson(cfgPath):
    cfg = json.load(open(cfgPath, 'r'))
    #cfg = byteify(cfg)
    return cfg

def downloadConfig(url, path):
    print("downloadConfig: %s->%s" % (url,path))
    urllib.urlretrieve(url,path)

def getSubDir(ROOT, path):
    if ROOT == path:
        return ""
    return path[len(ROOT) + 1:]

def removeDir(DIR):
    if os.path.exists(DIR):
        shutil.rmtree(DIR)
        
def copyDir(olddir, newdir):
    if os.path.exists(newdir):
        shutil.rmtree(newdir)
    shutil.copytree(olddir,newdir)  

def copyDir2(olddir, newdir):
    for dirpath, dirnames, filenames in os.walk(olddir):
        for filename in filenames:
            fullPath = os.path.join(dirpath, filename)
            if not os.path.isdir(fullPath):
                tempPath = os.path.abspath(os.path.join(newdir, os.path.relpath(fullPath, olddir)))
                tempDir = os.path.dirname(tempPath)
                if not os.path.exists(tempDir):
                    os.makedirs(tempDir)

                if os.path.exists(fullPath):
                    shutil.copy(fullPath, tempPath)


def cleanDir(DIR, ignores):
    print("cleanDir = %s" % DIR)
    lists = os.walk(DIR)
    for root, dirs, files in lists:
        for f in files:
            path = os.path.join(root, f)
            tmp = getSubDir(DIR, path)
            finded = False
            for v in ignores:
                if tmp.startswith(v):
                    finded = True
                    break
            if finded:
                continue
            os.remove(path)
        for d in dirs:
            path = os.path.join(root, d)
            tmp = getSubDir(DIR, path)
            finded = False
            for v in ignores:
                if tmp.startswith(v):
                    finded = True
                    break
            if finded:
                continue
            shutil.rmtree(path)

def removeFile(full_path):
    print("removeFile = %s" % full_path)
    if os.path.isfile(full_path):
        os.remove(full_path)

def checkFileByExtention(ext, path):
    filelist = os.listdir(path)
    for fullname in filelist:
        name, extention = os.path.splitext(fullname)
        if extention == ext:
            return name, fullname
    return (None, None)

def removeFileWithExt(work_dir, ext):
    file_list = os.listdir(work_dir)
    for f in file_list:
        full_path = os.path.join(work_dir, f)
        if os.path.isdir(full_path):
            removeFileWithExt(full_path, ext)
        elif os.path.isfile(full_path):
            name, cur_ext = os.path.splitext(f)
            if cur_ext == ext:
                os.remove(full_path)

def getFilesWithExt(path, ext):
    ret = []
    for dirpath, dirnames, filenames in os.walk(path):
        for filename in filenames:
            if os.path.splitext(filename)[1] == ext:
                ret.append(os.path.join(dirpath, filename))

    return ret

def mkOutDir(DIR_OUT, CLEANUP_FIRST, ignores=[]):
    if os.path.exists(DIR_OUT):
        if CLEANUP_FIRST:
            cleanDir(DIR_OUT, ignores)
            # shutil.rmtree(DIR_OUT)
            # os.makedirs(DIR_OUT)
    else:
        os.makedirs(DIR_OUT)


def formatName(s):
    l = s.split("_")
    ret = ""
    for v in l:
        ret += v[0].upper() + v[1:].lower()
    return ret


def initUtf8():
    import sys
    reload(sys)
    sys.setdefaultencoding('utf8')


def runMain(main, waitWindows=True):
    initUtf8()
    try:
        main()
    except Exception as e:
        print(e)
        import traceback
        traceback.print_exc()
    finally:
        if waitWindows and platform.system() == "Windows":
            print('Press any key to continue...')
            raw_input()


def runShell(cmd, cwd=None, wait=False):
    p = subprocess.Popen(cmd, shell=True, cwd=cwd)
    if wait:
        p.wait()
        if p.returncode:
            raise subprocess.CalledProcessError(
                returncode=p.returncode,
                cmd=cmd)
        return p.returncode
    return 0


def backUpFile(backUp, filename):
    for v in backUp:
        if v["filename"] == filename:
            return
    f = open(filename, "r")
    lines = f.readlines()
    f.close()
    d = collections.OrderedDict()
    d["filename"] = filename
    d["lines"] = lines
    backUp.append(d)


def modifyFile(backUp, filename, func):
    alreadyIn = False
    for v in backUp:
        if v["filename"] == filename:
            alreadyIn = True
            break
    f = open(filename, "r")
    lines = f.readlines()
    f.close()
    f = open(filename, "w")
    for line in lines:
        func(f, line)
    f.close()
    if not alreadyIn:
        d = collections.OrderedDict()
        d["filename"] = filename
        d["lines"] = lines
        backUp.append(d)

def modifyFile1(filename, func):
    f = open(filename, "r")
    lines = f.readlines()
    f.close()
    f = open(filename, "w")
    for line in lines:
        func(f, line)
    f.close()


def restoreFile(backUp):
    for v in backUp:
        filename = v["filename"]
        lines = v["lines"]
        f = open(filename, "w")
        for line in lines:
            f.write(line)
        f.close()


def getExecPath():
    import sys
    if hasattr(sys, "frozen"):
        return os.path.realpath(sys.executable)
    else:
        return os.path.realpath(sys.argv[0])

