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
import linecache

from xml.etree import ElementTree as ET
from xml.etree.ElementTree import SubElement
from xml.etree.ElementTree import Element
from xml.etree.ElementTree import ElementTree

def checkCode(msg):
    if platform.system() == "Windows":
        return msg.encode('gbk','ignore')
    else:
        return msg

def getSVNInfo():
    # info = urllib.urlopen('http://10.235.102.201/client')
    # return json.loads(base64.b64decode(info.read()))
    info = {}
    file = "/Users/hw/.svn_info"
    info["n"] = linecache.getline(file, 1).strip()
    info["p"] = linecache.getline(file, 2).strip()
    return info

def printSplit(name):
    length = len(name)
    length = int((100 - length))
    print(checkCode("\033[31m%s %s\033[34m" % (name, "-"*length)))

def printFile(file, name):
    length = len(name)
    length = int((100 - length) / 2)
    print(checkCode("\033[35m%s%s%s\033[0m" % (">"*length, name, "<"*length)))
    f = open(file, 'r')
    print checkCode(f.read())
    f.close()
    print(checkCode("\033[35m%s%s%s\033[0m" % (">"*length, name, "<"*length)))

def printObject(object, name):
    print(checkCode("%s = %s" % (name, json.dumps(object, indent=4))))

def getuuid(name):
    return uuid.uuid3(uuid.NAMESPACE_DNS, name)

def getConfig(DIR):
    opts, args = getopt.getopt(sys.argv[1:], "c:")
    cfgName = "config"
    for op, value in opts:
        if op == "-c":
            cfgName = value

    bname = os.path.basename(cfgName)
    iniName = os.path.splitext(bname)[0] + ".ini"
    cfgPath = os.path.join(DIR, iniName)
    cfg = ConfigParser.ConfigParser()
    cfg.read(cfgPath)
    return cfg, cfgName, cfgPath

def byteify(input):
    if isinstance(input, dict):
        return {byteify(key):byteify(value) for key,value in input.iteritems()}
    elif isinstance(input, list):
        return [byteify(element) for element in input]
    elif isinstance(input, unicode):
        return input.encode('utf-8')
    else:
        return input

def getOptions():
    optConfig = ""
    optPath = ""
    optOut = ""
    options,args = getopt.getopt(sys.argv[1:], "c:p:o:", ["config=","path=","out="])
    for name, value in options:
        if name in ("-c","--config"):
            optConfig = value
        if name in ("-p","--path"):
            optPath = os.path.realpath(value)
        if name in ("-o","--out"):
            optOut = os.path.realpath(value)
    print("option: optConfig=%s, optPath=%s, optOut=%s" % (optConfig, optPath, optOut)) 
    return optConfig, optPath, optOut

def getConfigJson(DIR, cfgName):
    bname = os.path.basename(cfgName)
    iniName = os.path.splitext(bname)[0] + ".json"
    cfgPath = os.path.join(DIR, iniName)
    cfg = json.load(open(cfgPath, 'r'))
    cfg = byteify(cfg)
    return cfg, cfgName, cfgPath

def getVersionConfig(DIR, cfgDir):
    cfgPath = os.path.join(DIR, cfgDir, "version.json")
    cfg = json.load(open(cfgPath, 'r'))
    cfg = byteify(cfg)
    return cfg

def getAppConfig(DIR, cfgDir, cfgName):
    iniName = os.path.splitext(os.path.basename(cfgName))[0] + ".json"
    cfgPath = os.path.join(DIR, cfgDir, iniName)
    cfg = json.load(open(cfgPath, 'r'))
    cfg = byteify(cfg)
    return cfg

def getJson(cfgPath):
    cfg = json.load(open(cfgPath, 'r'))
    cfg = byteify(cfg)
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
    print("copyDir", olddir, newdir)
    if os.path.exists(newdir):
        shutil.rmtree(newdir)
    shutil.copytree(olddir,newdir)  

def copyDir2(olddir, newdir):
    print("copyDir2", olddir, newdir)
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

def removeFileWithKey(work_dir, key, is_loop=False):
    file_list = os.listdir(work_dir)
    for f in file_list:
        full_path = os.path.join(work_dir, f)
        if os.path.isdir(full_path) and is_loop:
            removeFileWithKey(work_dir, key, is_loop)
        if os.path.isfile(full_path):
            if f.find(str(key)) != -1:
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


def modifyConfigLua(backUp, filename, version, server, gateway, config, rolelist):
    
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*VERSION_RES[\s\t]*=.*", "VERSION_RES = \"%s\"" % version, line))
    )

    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*SERVERLIST_URL[\s\t]*=.*", "SERVERLIST_URL = \"%s\"" % server, line))
    )

    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*GATEWAYLIST_URL[\s\t]*=.*", "GATEWAYLIST_URL = \"%s\"" % gateway, line))
    )

    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*CONFIG_URL[\s\t]*=.*", "CONFIG_URL = \"%s\"" % config, line))
    )

    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*ROLELIST_URL[\s\t]*=.*", "ROLELIST_URL = \"%s\"" % rolelist, line))
    )


    printFile(filename, os.path.basename(filename))


def modifyDevelopLua(backUp, filename, guide, jumpBattle, fakeReport, speedBattle, recharge, token, version, server, gateway, config, gameop, op, rolelist):
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*CONFIG_TUTORIAL_ENABLE[\s\t]*=.*", "CONFIG_TUTORIAL_ENABLE = %s" % guide, line))
    )
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*CONFIG_SHOW_STORY_CHAT[\s\t]*=.*", "CONFIG_SHOW_STORY_CHAT = %s" % guide, line))
    )
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*CONFIG_JUMP_BATTLE_ENABLE[\s\t]*=.*", "CONFIG_JUMP_BATTLE_ENABLE = %s" % jumpBattle, line))
    )
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*CONFIG_FAKE_REPORT_ENABLE[\s\t]*=.*", "CONFIG_FAKE_REPORT_ENABLE = %s" % fakeReport, line))
    )
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*CONFIG_SHOW_SPEED_ADJUST[\s\t]*=.*", "CONFIG_SHOW_SPEED_ADJUST = %s" % speedBattle, line))
    )
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*RECHARGE_TEST_URL[\s\t]*=.*", "RECHARGE_TEST_URL = \"%s\"" % recharge, line))
    )
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*TOKEN_KEY[\s\t]*=.*", "TOKEN_KEY = \"%s\"" % token, line))
    )
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*VERSION_RES[\s\t]*=.*", "VERSION_RES = \"%s\"" % version, line))
    )

    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*SERVERLIST_URL[\s\t]*=.*", "SERVERLIST_URL = \"%s\"" % server, line))
    )

    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*GATEWAYLIST_URL[\s\t]*=.*", "GATEWAYLIST_URL = \"%s\"" % gateway, line))
    )

    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*CONFIG_URL[\s\t]*=.*", "CONFIG_URL = \"%s\"" % config, line))
    )

    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*SPECIFIC_GAME_OP_ID[\s\t]*=.*", "SPECIFIC_GAME_OP_ID = \"%s\"" % gameop, line))
    )

    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*SPECIFIC_OP_ID[\s\t]*=.*", "SPECIFIC_OP_ID = \"%s\"" % op, line))
    )

    # 添加多语言路径处理
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*LANG_URL[\s\t]*=.*", "LANG_URL = \"%s\"" % " ", line))
    )
    # 添加多语言路径处理
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*ROLELIST_URL[\s\t]*=.*", "ROLELIST_URL = \"%s\"" % rolelist, line))
    )

    printFile(filename, os.path.basename(filename))


def modifyMainLua(backUp, filename, version):
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*VERSION_RUN[\s\t]*=.*", "VERSION_RUN = %s" % version, line))
    )

    printFile(filename, os.path.basename(filename))

def modifyLangLua(backUp, filename, lang, channel=None, langList=None):
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*Lang.lang[\s\t]*=.*", "Lang.lang = \"%s\"" % lang, line))
    )
    if channel != None:
        modifyFile(backUp, filename, lambda f, line:
            f.write(re.sub("[\s\t]*Lang.channel[\s\t]*=.*", "Lang.channel = \"%s\"" % channel, line))
        )
    else:
        modifyFile(backUp, filename, lambda f, line:
            f.write(re.sub("[\s\t]*Lang.channel[\s\t]*=.*", "Lang.channel = \"%s\"" % lang, line))
        )
    if langList != None:
        modifyFile(backUp, filename, lambda f, line:
            f.write(re.sub("[\s\t]*Lang.mathLang[\s\t]*=.*", "Lang.mathLang = \"%s\"" % "|".join(langList), line))
        )
    printFile(filename, os.path.basename(filename))

def modifyAppDelegate(backUp, filename, version ,path=None):
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*#define APP_VERSION_CODE.*",
                        "#define APP_VERSION_CODE %s" % version, line))
    )
    if path == "smart":
        modifyFile(backUp, filename, lambda f, line:
            f.write(re.sub("[\s\t]*bool AppDelegate::isSmart =.*",
                            "bool AppDelegate::isSmart = true;", line))
        )
    #
    # modifyFile(backUp, filename, lambda f, line:
    #     f.write(re.sub("[\s\t]*.*setPackageFileName.*",
    #                     "    fileStorage->setPackageFileName(\"%s\");" % filen, line))
    # )

    printFile(filename, os.path.basename(filename))

def modifyAppController(backUp, filename, pushID, pushKey):
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*.*initWithLaunchOptions.*",
                        "    [UPushManager initWithLaunchOptions:launchOptions appId:@\"%s\" appKey:@\"%s\" delegate:self];" % (pushID, pushKey), line))
    )
    
    printFile(filename, os.path.basename(filename))


def luacompile(inPath, outPath, compileLua, bit64):
    cmd = "cocos luacompile -s %s -d %s" % (inPath, outPath)
    if not compileLua:
        cmd = "%s --disable-compile" % cmd

    if bit64:
        cmd = "%s --bytecode-64bit" % cmd

    # if encrypt:
    #     cmd = "%s -e -k %s -b %s" % (cmd, key, sign)

    print(cmd)
    output = os.popen(cmd).read()

    removeFileWithExt(outPath, ".lua")

    return output

def PackFileUpdate(path, package, compress, encrypt, ext):
    dirExec = os.path.dirname(getExecPath())

    cmd = os.path.join(dirExec, "..", "external", "PackFile_0612")
    if package:
        cmd = "%s -s" % cmd 

    cmd = "%s -p %s" % (cmd, path)

    if compress:
        cmd = "%s -c" % cmd

    if encrypt:
        cmd = "%s -e" % cmd

    cmd = "%s %s" % (cmd, ext)
    print(cmd)
    output = os.popen(cmd).read()

    return output

def PackFile(intPath, outPath, package, compress, encrypt, filename, maxSize):
    dirExec = os.path.dirname(getExecPath())

    cmd = os.path.join(dirExec, "..", "external", "PackFile")
    if package:
        cmd = "%s -s" % cmd 

    cmd = "%s -p %s -o %s" % (cmd, intPath, outPath)

    if compress:
        cmd = "%s -c" % cmd

    if encrypt:
        cmd = "%s -e" % cmd

    cmd = "%s -f %s -m %s" % (cmd, filename, maxSize)
    print(cmd)
    output = os.popen(cmd).read()

    return output


def copySvnFiles(output, inPath, outPath):
    ret = []
    svnLines = output.splitlines()
    for v in svnLines:
        if v.find("A",0,7) != -1 or v.find("M",0,7) != -1:
            filePath = v[8:]
            fullPath = os.path.abspath(os.path.join(inPath, filePath))
            if not os.path.isdir(fullPath):
                tempPath = os.path.abspath(os.path.join(outPath, filePath))
                tempDir = os.path.dirname(tempPath)
                if not os.path.exists(tempDir):
                    os.makedirs(tempDir)

                if os.path.exists(fullPath):
                    shutil.copy(fullPath, tempPath)
                    ret.append(filePath)
                    #print("%s -> %s" % (fullPath, tempPath))
    
    return ret

def getDiffFiles(path1, path2):
    ret = {}
    jsonVersion1 = getJson(path1)
    jsonVersion2 = getJson(path2)
    
    dirSubPath = ["audio", "src", "res"]
    for subPath in dirSubPath:
        retFiles = []
        ret[subPath] = retFiles
        jsonSubFile1 = jsonVersion1[subPath]
        jsonSubFile2 = jsonVersion2[subPath]
        for filekey in jsonSubFile2.keys():
            if not jsonSubFile1.has_key(filekey) or jsonSubFile1[filekey] != jsonSubFile2[filekey]:
                retFiles.append(filekey)

    return ret

def getDiffFilesMatchLang(path1, path2, lang=None):
    ret = {}
    jsonVersion1 = getJson(path1)
    jsonVersion2 = getJson(path2)
    
    dirSubPath = ["audio", "src", "res"]
    dirResSubPath = ["base"]
    dirSrcSubPath = ["extends", "utils"]
    for subPath in dirSubPath:
        retFiles = []
        ret[subPath] = retFiles
        jsonSubFile1 = jsonVersion1[subPath]
        jsonSubFile2 = jsonVersion2[subPath]
        for filekey in jsonSubFile2.keys():
            if not jsonSubFile1.has_key(filekey) or jsonSubFile1[filekey] != jsonSubFile2[filekey]:
                # 音频目录 cn为基础
                if subPath == "audio":
                    if (lang+"/" in filekey or "cn/" in filekey) :
                        retFiles.append(filekey)
                        print "getDiffFilesMatchLangList audio file = %s" % filekey 
                    continue                
                # 筛选多语言目录
                if str("i18n/") in filekey:
                    if subPath == "res":
                        for subResPath in dirResSubPath:
                            if str("i18n/"+subResPath+"/") in filekey:
                                retFiles.append(filekey)
                                print "getDiffFilesWithLang file = %s" % filekey 
                        if str("i18n/"+lang+"/") in filekey:
                                retFiles.append(filekey)
                                print "getDiffFilesWithLang file = %s" % filekey 
                    if subPath == "src":
                        for subSrcPath in dirSrcSubPath:
                            if str("i18n/"+subSrcPath+"/") in filekey:
                                retFiles.append(filekey)
                                print "getDiffFilesWithLang file = %s" % filekey 
                        if str("i18n/"+lang+"/") in filekey:
                                retFiles.append(filekey)
                                print "getDiffFilesWithLang file = %s" % filekey 
                        if str("i18n/init.") in filekey:
                                retFiles.append(filekey)
                                print "getDiffFilesWithLang file = %s" % filekey 
                else:
                    retFiles.append(filekey)
    return ret

def getDiffFilesMatchLangList(path1, path2, langList):
    ret = {}
    jsonVersion1 = getJson(path1)
    jsonVersion2 = getJson(path2)
    
    dirSubPath = ["audio", "src", "res"]
    dirResSubPath = ["base"]
    dirSrcSubPath = ["extends", "utils"]
    for subPath in dirSubPath:
        retFiles = []
        ret[subPath] = retFiles
        jsonSubFile1 = jsonVersion1[subPath]
        jsonSubFile2 = jsonVersion2[subPath]
        for filekey in jsonSubFile2.keys():
            if not jsonSubFile1.has_key(filekey) or jsonSubFile1[filekey] != jsonSubFile2[filekey]:
                for lang in langList:
                    if not filekey in retFiles:
                        # 音频目录 cn为基础
                        if subPath == "audio":
                            if (lang+"/" in filekey or "cn/" in filekey) :
                                retFiles.append(filekey)
                                print "getDiffFilesMatchLangList audio file = %s" % filekey 
                            continue
                        # 筛选多语言目录
                        if str("i18n/") in filekey:
                            if subPath == "res":
                                for subResPath in dirResSubPath:
                                    if str("i18n/"+subResPath+"/") in filekey:
                                        retFiles.append(filekey)
                                        print "getDiffFilesMatchLangList file = %s" % filekey 
                                if str("i18n/"+lang+"/") in filekey:
                                        retFiles.append(filekey)
                                        print "getDiffFilesMatchLangList file = %s" % filekey 
                            if subPath == "src":
                                for subSrcPath in dirSrcSubPath:
                                    if str("i18n/"+subSrcPath+"/") in filekey:
                                        retFiles.append(filekey)
                                        print "getDiffFilesMatchLangList file = %s" % filekey 
                                if str("i18n/"+lang+"/") in filekey:
                                        retFiles.append(filekey)
                                        print "getDiffFilesMatchLangList file = %s" % filekey 
                                if str("i18n/init.") in filekey:
                                        retFiles.append(filekey)
                                        print "getDiffFilesMatchLangList file = %s" % filekey 
                        else:
                            retFiles.append(filekey)
    return ret

def getDiffFilesWithLang(path1, path2, lang):
    ret = {}
    jsonVersion1 = getJson(path1)
    jsonVersion2 = getJson(path2)
    
    dirSubPath = ["audio", "src", "res"]
    for subPath in dirSubPath:
        retFiles = []
        ret[subPath] = retFiles
        jsonSubFile1 = jsonVersion1[subPath]
        jsonSubFile2 = jsonVersion2[subPath]
        for filekey in jsonSubFile2.keys():
            if not jsonSubFile1.has_key(filekey) or jsonSubFile1[filekey] != jsonSubFile2[filekey]:
                if subPath == "audio" and lang+"/" in filekey:
                    retFiles.append(filekey)
                if str("i18n/"+lang+"/") in filekey:
                    print "getDiffFilesWithLang file = %s" % filekey
                    retFiles.append(filekey)

    return ret

def geLangFiles(path, lang):
    ret = {}
    jsonVersion = getJson(path)
    
    dirSubPath = ["audio", "src", "res"]
    for sub in dirSubPath:
        retFiles = []
        ret[sub] = retFiles
        jsonSubFile = jsonVersion[sub]
        for filekey in jsonSubFile.keys():
            if sub == "audio" and lang+"/" in filekey:
                retFiles.append(filekey)
            if str("i18n/"+lang+"/") in filekey:
                retFiles.append(filekey)

    return ret


def getLangList(path):
    langList = []
    print("getLangList path = %s" % path)
    lists = os.walk(path)
    for root, dirs, files in lists:
        for d in dirs:
            dirPath = os.path.join(path, d)
            if os.path.exists(dirPath) and d != "cn" and d != "base":
                langList.append( str(d) )
    return langList

def getMathLangList(matchStr):
    matchLangList =  matchStr.split("|")
    print("getMathLangList str = %s" % matchStr)
    return matchLangList

        
def copyDiffFiles(output, inPath, outPath):
    # print("copyDiffFiles", output, inPath, outPath)
    ret = []
    for filePath in output:
        fullPath = os.path.abspath(os.path.join(inPath, filePath))
        if not os.path.isdir(fullPath):
            tempPath = os.path.abspath(os.path.join(outPath, filePath))
            tempDir = os.path.dirname(tempPath)
            if not os.path.exists(tempDir):
                os.makedirs(tempDir)

            if os.path.exists(fullPath):
                shutil.copy(fullPath, tempPath)
                ret.append(filePath)
                #print("%s -> %s" % (fullPath, tempPath))
            else:
                name, cur_ext = os.path.splitext(fullPath)
                if cur_ext == ".lua":
                    fullPath = name + ".luac"
                    if os.path.exists(fullPath):
                        name, cur_ext = os.path.splitext(tempPath)
                        tempPath = name + ".luac"
                        shutil.copy(fullPath, tempPath)
                        ret.append(filePath)
    
    return ret


def mergeManifest(targetManifest, sdkManifest):

    """
        Merge sdk SdkManifest.xml to the apk AndroidManifest.xml
    """

    if not os.path.exists(targetManifest) or not os.path.exists(sdkManifest):
        print("the manifest file is not exists.targetManifest:%s;sdkManifest:%s", targetManifest, sdkManifest)
        return False

    androidNS = 'http://schemas.android.com/apk/res/android'
    ET.register_namespace('android', androidNS)
    targetTree = ET.parse(targetManifest)
    targetRoot = targetTree.getroot()

    ET.register_namespace('android', androidNS)
    sdkTree = ET.parse(sdkManifest)
    sdkRoot = sdkTree.getroot()

    f = open(targetManifest)
    targetContent = f.read()
    f.close()


    permissionConfigNode = sdkRoot.find('permissionConfig')
    if permissionConfigNode != None and len(permissionConfigNode) > 0:
        for child in list(permissionConfigNode):
            key = '{' + androidNS + '}name'
            val = child.get(key)
            if val != None and len(val) > 0:
                attrIndex = targetContent.find(val)
                if -1 == attrIndex:
                    targetRoot.append(child)


    appConfigNode = sdkRoot.find('applicationConfig')
    appNode = targetRoot.find('application')

    if appConfigNode != None:

        appKeyWord = appConfigNode.get('keyword')

        # exists = appKeyWord != None and len(appKeyWord.strip()) > 0 and targetContent.find(appKeyWord) != -1

        # if not exists:
        #remove keyword check...
        for child in list(appConfigNode):
            targetRoot.find('application').append(child)

    targetTree.write(targetManifest, 'UTF-8')

    return True

def versionNumber(version):
   versions = version.split('.')
   ret = 0
   ret = ret + int(versions[0]) * 10000
   ret = ret + int(versions[1]) * 100
   ret = ret + int(versions[2]) * 1
   return ret

def modifyDevelopLuaSwitchLang(backUp, filename, switch):
    modifyFile(backUp, filename, lambda f, line:
        f.write(re.sub("[\s\t]*CONFIG_SHOW_SWITCH_LANGUAGE[\s\t]*=.*", "CONFIG_SHOW_SWITCH_LANGUAGE = %s" % switch, line))
    )

def luacompileNew(inPath, outPath, compileLua, bit64):
    cmd = "-s %s -d %s" % (inPath, outPath)
    if not compileLua:
        cmd = "%s --disable-compile" % cmd

    if bit64:
        cmd = "%s --bytecode-64bit" % cmd

    from luaCompile import CCPluginLuaCompile
    CCPluginLuaCompile = CCPluginLuaCompile()
    CCPluginLuaCompile.run(cmd.split(),None)

    removeFileWithExt(outPath, ".lua")

    return ""

def chmod777(path):
    os.popen("chmod 777 %s" % (path)).read()