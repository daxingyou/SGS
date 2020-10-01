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
import datetime
import getopt
import sys
from distutils.version import LooseVersion

editorFileName = "Editor.xlsx"
uiFileName = "UiTxt.xlsx"
effectFileName = "Effect.xlsx"
langTemplateFileName = "LangTemplate.xlsx"

#参考
#python outputVersionJson.py
#python outputVersionJson.py -v 1.8.0 -l vn
#python outputVersionJson.py --version 1.8.0 --lang vn

def getFolderList(path):
    dirs = os.listdir(path)
    for index in range(len(dirs)):
        print str(index+1)+": "+dirs[index]
    return dirs

def writeFontToEditorKey(targetVersion,versionJson, lang):
    versionJson["res/fonts/Font_W7.ttf"] = "i18n/%s/fonts/Font_W7.ttf" % (lang)
    versionJson["res/fonts/Font_W8.ttf"] = "i18n/%s/fonts/Font_W8.ttf" % (lang)
    versions = targetVersion.split('.')
    bigVersion = int(versions[0])
    if bigVersion >= 2:
        versionJson["res/fonts/Font_W7S.ttf"] = "i18n/%s/fonts/Font_W7.ttf" % (lang)
        versionJson["res/fonts/Font_W8S.ttf"] = "i18n/%s/fonts/Font_W8.ttf" % (lang)
    return versionJson

def getValueLoc(lang):
    vLoc = 3
    if lang.lower() == "cn":
        vLoc = 2
    if lang.lower() == "vn":
        vLoc = 3
    if lang.lower() == "kr":
        vLoc = 4
    if lang.lower() == "tw":
        vLoc = 5
    return vLoc

def xlsxToJson(xlsxList, lang="vn",isPunctuation=False):
    json = {}
    lLoc = 0  # 行号
    kLoc = 1  # key
    vLoc = getValueLoc(lang)
    for xlsx in list(xlsxList):
        line = xlsx[lLoc]
        # utils.printObject(line, "line:")
        if isinstance(line, long):
            printEx( str(xlsx[kLoc]) + ":" + str(xlsx[vLoc]))
            value = str(xlsx[vLoc])
            if not value:
                value = ""
            value = utils.punctuationChinaToEnglish(value,isPunctuation)
            json[str(xlsx[kLoc])] = value
    return json


def writeJson(json_data, json_file, write_path):
    utils.printSplit("写入json : " + json_file)
    json_path = os.path.join(write_path, json_file)
    utils.writeJsonFile(json_data, json_path)
    utils.printObject(json_data, "JSON WRITE:")

# # 生成编辑器文本翻译 editor_key.json
# def generateEditorKey(xlsxFile, dirXlsx, dirVersion):
#     sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
#     editorFile = "editor_key.json"
#     sysEditorJson = xlsxToJson(sysTextList)
#     # editorLangJson = json.dumps(sysEditorJson, ensure_ascii=False, indent=4)
#     dirVersion = os.path.join(dirXlsx, dirVersion)
#     utils.mkOutDir(dirVersion,True)
#     writeJson(sysEditorJson, editorFile, dirVersion)
#     return sysEditorJson

# 生成编辑器文本翻译 editor_key.json
def generateEditorKey(targetVersion,xlsxFile,dirXlsx,dirVersion,lang="vn"):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    generateFile = "editor_key.json"
    sysJsonData = xlsxToJson(sysTextList,lang,True)
    sysJsonData = writeFontToEditorKey(targetVersion,sysJsonData, lang)
    # editorLangJson = json.dumps(sysJsonData, ensure_ascii=False, indent=4)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, True)
    writeJson(sysJsonData, generateFile, dirVersion)
    return sysJsonData

# 生成图片字文本翻译 text_key.json
def generateTextKey(xlsxFile,dirXlsx,dirVersion,lang="vn"):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    generateFile = "text_key.json"
    # utils.printObject(sysTextList, "sysTextList: ")
    sysJsonData = xlsxToJson(sysTextList,lang,True)
    utils.printObject(sysJsonData, "sysJsonData: ")
    # editorLangJson = json.dumps(sysJsonData, ensure_ascii=False, indent=4)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeJson(sysJsonData, generateFile, dirVersion)
    return sysJsonData

# 生成特效引用文本翻译 effect_key.json
def generateEffectKey(xlsxFile,dirXlsx,dirVersion,lang="vn"):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    generateFile = "effect_key.json"
    sysJsonData = xlsxToJson(sysTextList,lang,True)
    # editorLangJson = json.dumps(sysJsonData, ensure_ascii=False, indent=4)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeJson(sysJsonData, generateFile, dirVersion)
    return sysJsonData


def xlsxToLuaTemplate(xlsxList,lang="vn"):
    lines = []
    lLoc = 0  # 行号
    kLoc = 1  # key
    vLoc = getValueLoc(lang)
    xlsxList = xlsxList[0]
    utils.printObject(xlsxList, "xlsxList: ")

    lines.append("local language={}\n")
    # lines.append("language[\"" + "123321" + "\"] = " + "\"456879\"" )

    for xlsx in list(xlsxList):
        line = xlsx[lLoc]
        printEx( "xlsx: " + str(xlsx))
        # utils.printObject(xlsx, "xlsx: ")
        printEx("line: " + str(line))
        printEx("line type: " + str(type(line)))
        printEx(str(xlsx[kLoc]) + ":" + str(xlsx[vLoc]))
        if isinstance(line, long):
            value = xlsx[vLoc]
            if not value:
                value = ""
            # line = "language[\"" + xlsx[kLoc] + "\"] = " + value
            value = utils.punctuationChinaToEnglish(value,False)
            line = "language[ " + xlsx[kLoc] + "] = " + value + "\n"
            lines.append(line)

    lines.append("return language")

    return lines


def writeLua(luaLines, luaFile, writePath):
    fullPath = os.path.join(writePath, luaFile)
    utils.writeFile(luaLines, fullPath)
    utils.printObject(luaLines, "Lua WRITE:")


def generateLangTemplate(xlsxFile, dirXlsx, dirVersion,lang="vn"):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    luaFile = "LangTemplate.lua"
    sysLuaList = xlsxToLuaTemplate(sysTextList,lang)
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)
    writeLua(sysLuaList, luaFile, dirVersion)
    # print "dirVersion: " + str(dirVersion)
    # print "luaFile: " + str(luaFile)
    # print "sysLuaList: " + str(sysLuaList)

def copyFile(src,tgt):
    src = unicode(src,'utf-8')
    if not os.path.exists(src):
        raise Exception(utils.checkCode(src)+" not Exists")
    utils.copyFile(src,tgt)

def copyToSysText(dirDocTranslate,dirSysText,targetVersion):
    targetVersionDir = os.path.join(dirDocTranslate, targetVersion, "翻译项")
    SrcUiTxtFile = os.path.join(targetVersionDir, "ui文本", uiFileName)
    SrcEffectFile = os.path.join(targetVersionDir, "特效文本", effectFileName)
    SrcEditorFile = os.path.join(targetVersionDir, "系统文本", editorFileName)
    SrcLangTemplateFile = os.path.join(targetVersionDir, "系统文本", langTemplateFileName)

    TgtUiTxtFile = os.path.join(dirSysText, uiFileName)
    TgtEffectFile = os.path.join(dirSysText, effectFileName)
    TgtEditorFile = os.path.join(dirSysText, editorFileName)
    TgtLangTemplateFile = os.path.join(dirSysText, langTemplateFileName)

    copyFile(SrcUiTxtFile,TgtUiTxtFile)
    copyFile(SrcEffectFile,TgtEffectFile)
    copyFile(SrcEditorFile,TgtEditorFile)
    copyFile(SrcLangTemplateFile,TgtLangTemplateFile)

def getOptions():
    optVersion = ""
    optLang = ""
    optSvn = False
    options,args = getopt.getopt(sys.argv[1:], "v:l:s", ["version=","lang=","svn"])
    for name, value in options:
        if name in ("-v","--version"):
            optVersion = value
        if name in ("-l","--lang"):
            optLang = value
        if name in ("-s","--svn"):
            optSvn = True
    print("option: optVersion=%s, optLang=%s" % (optVersion, optLang)) 
    return optVersion, optLang, optSvn

def printEx(msg):
    print(utils.checkCode(msg))

def getShortPath(path):
    paths = path.split('/')
    shortPath = ""
    for idx in xrange(3,len(paths)):
        if idx == 3:
            shortPath = paths[idx]
        else:
            shortPath = shortPath + "/" + paths[idx]
    return shortPath

def writeJsonFile(fileData, fullPath):
    print("writeJsonFile = %s" % fullPath)
    f = open(fullPath, "w")
    with open(fullPath, "w") as f:
        json.dump(fileData, f, ensure_ascii=False, indent=4, sort_keys=True)
    f.close()

def generateEditorKeyPath(targetVersion,dirXlsx,dirVersion,dirCocosstudio,lang="vn"):
    basePath = "base"
    dirVersion = os.path.join(dirXlsx, dirVersion)
    utils.mkOutDir(dirVersion, False)

    dirExec = os.path.dirname(utils.getExecPath())
    # dirProject = os.path.join(dirExec, "..", "..", "..", "tags", targetVersion, "cocosstudio")
    dirProject = os.path.abspath(dirCocosstudio)
    ui3Path = os.path.join(dirProject,"res","i18n",basePath,"ui3") #通用资源目录
    curJsonPath = os.path.join(dirProject,"res","i18n",lang,"json")
    json_file = "editor_key.json"
    #遍历通用资源目录获取通用图片列表
    commonlist = []
    for dirpath, dirnames, filenames in os.walk(ui3Path):
        for filename in filenames:
            filepath = os.path.join(dirpath,filename)
            newpath = filepath.replace(dirProject+os.path.sep,"")
            newpath = newpath.replace("\\","/")
            commonlist.append(newpath)

    #遍历当前语言资源目录获取图片列表
    ui3LangPath = os.path.join(dirProject,"res","i18n",lang,"ui3") #当前语言资源目录
    langlist = []
    for dirpath, dirnames, filenames in os.walk(ui3LangPath):
        for filename in filenames:
            filepath = os.path.join(dirpath,filename)
            newpath = filepath.replace(dirProject+os.path.sep,"")
            newpath = newpath.replace("\\","/")
            langlist.append(newpath)

    #访问tags下当前版本当前语言的editor_key.json，过滤出path部分并替换通用图片路径
    json_data, name, jsonPath = utils.readJsonFile(curJsonPath, json_file)
    newMap = {}
    for key,value in json_data.items():
        if key.startswith("res") and not key.startswith("res/fonts/"):
            matchComPath = ""
            shortValue = getShortPath(value)
            for comPath in commonlist:
                shortCom = getShortPath(comPath)
                if shortValue == shortCom:
                    matchComPath = comPath
                    break
            if matchComPath != "":
                matchLangPath = ""
                for langPath in langlist:
                    shortLang = getShortPath(langPath)
                    if shortValue == shortLang:
                        matchLangPath = langPath
                        break
                if matchLangPath != "":
                    newMap[key] = "res/i18n/"+lang+"/"+shortValue
                else:
                    newMap[key] = matchComPath
            else:
                newMap[key] = "res/i18n/"+lang+"/"+shortValue
    #合并，写入editor_key.json
    resultMap = {}
    txt_json_data, name, jsonPath = utils.readJsonFile(dirVersion, json_file)
    resultMap.update(txt_json_data)
    resultMap.update(newMap)
    json_path = os.path.join(dirVersion, json_file)
    writeJsonFile(resultMap, json_path)



def main(cfgFile=None):
    # tools/script
    dirExec = os.path.dirname(utils.getExecPath())
    # develop
    dirProject = os.path.join(dirExec, "..", "..", "cocosstudio")
    # tools/config
    dirConfig = os.path.join(dirExec, "..", "config")

    dirSysText = os.path.join(dirExec, "..", "sysText")

    dirDocTranslate = os.path.join(dirExec, "..","..","..","..","doc","translate" )

    # 获取命令行参数
    optVersion, optLang, optSvn = getOptions()

    # if optPath != "":
    #     dirClient = optPath

    # cfgFile, cfgName, cfgFilePath = utils.getConfigJson(dirConfig, optConfig)

    # cfgNewVersion = cfgFile["version"][-1]
    # cfgVersionList = cfgFile["version"]

    # if cfgNewVersion["path"] == "trunk":
    #     dirProject = os.path.join(dirClient, "cocosstudio")
    # else:
    #     dirProject = os.path.join(
    #         dirClient, cfgNewVersion["path"], "cocosstudio")

    # openSysTxtFile = "系统文本2-越南语.xlsx"
    # generateEditorKey(openSysTxtFile, dirSysText, "2018.12.04")

    # openSysTxtFile = "系统文本1-越南语.xlsx"
    # generateLangTemplate(openSysTxtFile, dirSysText, "2018.12.04")

    if optVersion != "":
        targetVersion = optVersion
    else:
        versions = getFolderList(dirDocTranslate)
        inputs = raw_input("Enter your version index: ")
        targetVersion = versions[int(inputs)-1]
    print "Selected Version is : ", targetVersion

    # 更新svn
    if optSvn == True:
        targetVersionDir = os.path.join(dirDocTranslate, targetVersion)
        svnInfo = utils.getSVNInfo()
        utils.printSplit("更新svn")
        cmd = "svn revert --depth infinity %s" % (targetVersionDir)
        printEx(cmd)
        output = os.popen(cmd).read()
        print(output)

        cmd = "svn update --accept theirs-full --username %s --password %s %s" % (svnInfo["n"], svnInfo["p"], targetVersionDir)
        printEx(cmd)
        output = os.popen(cmd).read()
        print(output)

        cmd = "svn status %s" % (targetVersionDir)
        printEx(cmd)
        output = os.popen(cmd).read()
        print(output)


    copyToSysText(dirDocTranslate,dirSysText,targetVersion)

    dirProject = os.path.join(dirExec, "..","..","..","..","client","tags",targetVersion )
    if not os.path.exists(dirProject):
        dirProject = os.path.join(dirExec, "..","..","..","..","client","trunk" )

    if optLang != "":
        targetLang = optLang
    else:
        i18nDir = os.path.join(dirProject,"cocosstudio","res","i18n")
        langs = getFolderList(i18nDir)
        inputs = raw_input("Enter your lang index: ")
        targetLang = langs[int(inputs)-1]
    print "Selected Lang is : ", targetLang

    outDir = targetVersion+"_"+targetLang+"_"+str(datetime.date.today())
    print outDir

    generateEditorKey(targetVersion,editorFileName, dirSysText, outDir, targetLang.lower())

    generateLangTemplate(langTemplateFileName, dirSysText, outDir, targetLang.lower())

    generateTextKey(uiFileName, dirSysText, outDir, targetLang.lower())

    generateEffectKey(effectFileName, dirSysText, outDir,targetLang.lower())

    dirCocosstudio = os.path.join(dirProject,"cocosstudio")
    generateEditorKeyPath(targetVersion,dirSysText,outDir,dirCocosstudio,targetLang.lower())
    # commit
    if optSvn == True:
        outputDir = os.path.join(dirSysText,outDir)
        if os.path.exists(outputDir):
            cmd = "svn add %s" % outputDir
            print(cmd)
            os.popen(cmd)
            cmd = "svn commit --username %s --password %s -m \"提交翻译文件\" %s" % (svnInfo["n"], svnInfo["p"], outputDir)
            print(cmd)
            output = os.popen(cmd).read()
            print(output)


    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")


if __name__ == "__main__":
    utils.runMain(main)
