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
uiCsvName = "UiTxt.csv"
#参考
#python outputVersionJson.py
#python outputVersionJson.py -v 1.8.0 --e True --v
#python outputVersionJson.py --version 1.8.0 --excel True --svn

def getFolderList(path):
    dirs = os.listdir(path)
    for index in range(len(dirs)):
        print str(index+1)+": "+dirs[index]
    return dirs


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


def writeJson(json_data, json_file, write_path):
    utils.printSplit("写入json : " + json_file)
    json_path = os.path.join(write_path, json_file)
    utils.writeJsonFile(json_data, json_path)
    utils.printObject(json_data, "JSON WRITE:")

def xlsxToJson(xlsxList,isPunctuation=False):
    json = {}
    lLoc = 0  # 行号
    kLoc = 1  # key
    for xlsx in list(xlsxList):
        line = xlsx[lLoc]
        if isinstance(line, long):
            json[str(xlsx[kLoc])] = xlsx
    return json


def getJsonList(i18nDir):
    jsonMap = {}
    generateFile = "text_key.json"
    dirs = os.listdir(i18nDir)
    for index in range(len(dirs)):
        if dirs[index] != "base":
            print str(index+1)+": "+dirs[index]
            json_dir = os.path.join(i18nDir,dirs[index],"json")
            json = utils.readJsonFile(json_dir, generateFile)
            jsonMap[dirs[index]] = json[0]
    return jsonMap

def generateXlsxDataFromJsons(jsonMap):
    result = {}
    index = 1L
    for i in jsonMap:
        print i
        vLoc = getValueLoc(i)
        for (key,v) in jsonMap[i].items():
            if key == None or key == "":
                continue
            if not result.has_key(key):
                result[key] = [index,key,"","","",""]
                index = index + 1
            result[key][vLoc] = jsonMap[i][key].replace('\n','\\n') 
    xlsx = []
    index = 1L
    for i in result:
        result[i][0] =  index
        index = index + 1
        xlsx.append(result[i])

    utils.printObject(xlsx, "text_key synthetize:")

    return xlsx

def mergeToXlsx(excelTextList,luaTextList,isUseExcelTranslate):
    excelJson = xlsxToJson(excelTextList)
    lusJson = xlsxToJson(luaTextList)
    for i in lusJson:
        if not excelJson.has_key(i):
            utils.printObject(lusJson[i], "text_key add:")
            excelJson[i] = lusJson[i]
        else:
            for j in range(len(excelJson[i])):
                if isUseExcelTranslate:
                    if excelJson[i][j] == None or excelJson[i][j] == "":
                        excelJson[i][j] = lusJson[i][j]
                else:
                    excelJson[i][j] = lusJson[i][j]
    xlsx = []
    for i in excelJson:
        xlsx.append(excelJson[i])
    #这里排序
    xlsx.sort(key=lambda d:d[1])
    for j in range(len(xlsx)):
         xlsx[j][0] = j + 1
    return xlsx


# 生成图片字文本翻译 text_key.json
def generateTextKey(xlsxFile,dirXlsx,dirVersion,i18nDir,isUseExcelTranslate):

    # 读取所有语言的TextKey,生成List
    # 所有语言List合成一个最多key的List
    # 读取xlsx,生成List
    # 比较两个List，xlsx补充代码list中新增Key或值，两个都有值，以xlsx为准
   
    jsonList = getJsonList(i18nDir)
    
    luaTextList = generateXlsxDataFromJsons(jsonList)
    if not os.path.exists(os.path.join(dirXlsx, xlsxFile)):
        #这里排序
        luaTextList.sort(key=lambda d:d[1])
        for j in range(len(luaTextList)):
            luaTextList[j][0] = j + 1

        dirVersion = os.path.join(dirXlsx, dirVersion)
        utils.mkOutDir(dirVersion, False)

        writeCsv(luaTextList, uiCsvName,None,dirVersion)
    else:
        excelTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
        utils.printObject(excelTextList, "text_key xlsx:")
        xlsxData = mergeToXlsx(excelTextList,luaTextList,isUseExcelTranslate)
    
        dirVersion = os.path.join(dirXlsx, dirVersion)
        utils.mkOutDir(dirVersion, False)

        writeCsv(xlsxData, uiCsvName,None,dirVersion)
     

def writeCsv(csv_data, csv_file, csv_head, write_path):
    utils.printSplit("写入csv : " + csv_file)
    csv_path = os.path.join(write_path, csv_file)
    if not csv_head:
        csv_head = ["序号", "Key", "文本内容", "越南语翻译","韩语翻译","港澳台"]
    utils.writeCsvFile(csv_data, csv_path, csv_head)
    utils.printObject(csv_data, "CSV WRITE:")

def copyFile(src,tgt):
    src = unicode(src,'utf-8')
    if not os.path.exists(src):
        return
        #raise Exception(utils.checkCode(src)+" not Exists")
    utils.copyFile(src,tgt)

def copyToSysText(dirDocTranslate,dirSysText,targetVersion):
    targetVersionDir = os.path.join(dirDocTranslate, targetVersion, "翻译项")
    SrcUiTxtFile = os.path.join(targetVersionDir, "ui文本", uiFileName)
    #SrcEffectFile = os.path.join(targetVersionDir, "特效文本", effectFileName)
    #SrcEditorFile = os.path.join(targetVersionDir, "系统文本", editorFileName)
    #SrcLangTemplateFile = os.path.join(targetVersionDir, "系统文本", langTemplateFileName)

    TgtUiTxtFile = os.path.join(dirSysText, uiFileName)
    #TgtEffectFile = os.path.join(dirSysText, effectFileName)
    #TgtEditorFile = os.path.join(dirSysText, editorFileName)
    #TgtLangTemplateFile = os.path.join(dirSysText, langTemplateFileName)

    copyFile(SrcUiTxtFile,TgtUiTxtFile)
    #copyFile(SrcEffectFile,TgtEffectFile)
    #copyFile(SrcEditorFile,TgtEditorFile)
    #copyFile(SrcLangTemplateFile,TgtLangTemplateFile)

def getOptions():
    optVersion = ""
    optExcel = None
    optSvn = False
    options,args = getopt.getopt(sys.argv[1:], "v:e:s", ["version=","excel=","svn"])
    for name, value in options:
        if name in ("-v","--version"):
            optVersion = value
        if name in ("-e","--excel"):
            optExcel = value == str(True)
        if name in ("-s","--svn"):
            optSvn = True
    print("option: optVersion=%s, optExcel=%s, optSvn=%s" % (optVersion, optExcel , optSvn)) 
    return optVersion, optExcel, optSvn

def printEx(msg):
    print(utils.checkCode(msg))

def writeJsonFile(fileData, fullPath):
    print("writeJsonFile = %s" % fullPath)
    f = open(fullPath, "w")
    with open(fullPath, "w") as f:
        json.dump(fileData, f, ensure_ascii=False, indent=4, sort_keys=True)
    f.close()


def main(cfgFile=None):
    # client\tools\i18n\script
    dirExec = os.path.dirname(utils.getExecPath())

    dirSysText = os.path.join(dirExec, "..", "sysText")

    dirDocTranslate = os.path.join(dirExec, "..","..","..","..","doc","translate" )

    # 获取命令行参数
    optVersion, optExcel, optSvn = getOptions()

    if optVersion != "":
        targetVersion = optVersion
    else:
        versions = getFolderList(dirDocTranslate)
        inputs = raw_input("Enter your version index: ")
        targetVersion = versions[int(inputs)-1]
    print "Selected Version is : ", targetVersion

    isUseExcelTranslate = optExcel
    if isUseExcelTranslate == None:
        print "Is use the translate of excel"
        print str(1)+":YES"
        print str(2)+":NO"
        inputs = raw_input("Enter your select index: ")
        isUseExcelTranslate = int(inputs) == 1
    print "Is use the translate of excel  : " , isUseExcelTranslate


    # 更新翻译表svn
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

    i18nDir = os.path.join(dirProject,"cocosstudio","res","i18n")


    outDir = targetVersion+"_"+str(datetime.date.today())
    print outDir

    generateTextKey(uiFileName, dirSysText, outDir,i18nDir,isUseExcelTranslate)


   
    # commit
    if optSvn == True:
        outputDir = os.path.join(dirSysText,outDir)
        if os.path.exists(outputDir):
            cmd = "svn add %s" % outputDir
            print(cmd)
            os.popen(cmd)
            cmd = "svn commit --username %s --password %s -m \"提交翻译文件\" %s" % (svnInfo["n"], svnInfo["p"], outputDir)
            print(cmd)
            # output = os.popen(cmd).read()
            # print(output)


    print("\033[31mFinish -----------------------------------------------------------------------------------------\033[0m")


if __name__ == "__main__":
    utils.runMain(main)
