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
import Tkinter, tkFileDialog, tkMessageBox
import subprocess

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

# 生成编辑器文本翻译 editor_key.json
def generateEditorKey(targetVersion,xlsxFile,dirXlsx,dirVersion,lang="vn"):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    generateFile = "editor_key.json"
    sysJsonData = xlsxToJson(sysTextList,lang,True)
    sysJsonData = writeFontToEditorKey(targetVersion,sysJsonData, lang)
    # editorLangJson = json.dumps(sysJsonData, ensure_ascii=False, indent=4)
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
    utils.mkOutDir(dirVersion, False)
    writeJson(sysJsonData, generateFile, dirVersion)
    return sysJsonData

# 生成特效引用文本翻译 effect_key.json
def generateEffectKey(xlsxFile,dirXlsx,dirVersion,lang="vn"):
    sysTextList = utils.readXlsxFile(dirXlsx, xlsxFile)
    generateFile = "effect_key.json"
    sysJsonData = xlsxToJson(sysTextList,lang,True)
    # editorLangJson = json.dumps(sysJsonData, ensure_ascii=False, indent=4)
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
    utils.mkOutDir(dirVersion, False)
    writeLua(sysLuaList, luaFile, dirVersion)
    # print "dirVersion: " + str(dirVersion)
    # print "luaFile: " + str(luaFile)
    # print "sysLuaList: " + str(sysLuaList)

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

def generateEditorKeyPath(targetVersion,dirVersion,dirCocosstudio,lang="vn"):
    basePath = "base"
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






# tools/script
dirExec = os.path.dirname(utils.getExecPath())
# develop
dirProject = os.path.join(dirExec, "..", "..", "cocosstudio")
# tools/config
dirConfig = os.path.join(dirExec, "..", "config")

dirSysText = os.path.join(dirExec, "..", "sysText")

dirDocTranslate = os.path.join(dirExec, "..","..","..","..","doc","translate" )


window = Tkinter.Tk()

import sys
reload(sys)
sys.setdefaultencoding('utf-8')

window.title('导出JsonLua')
window.geometry('600x520')

titleTxt = Tkinter.Label(window, text='Excel导出游戏资源', font=('Arial', 14), width=30, height=2)
titleTxt.pack()

versionTxt = Tkinter.Label(window, text='设置版本号',width=40, height=1, font=('Arial', 10), bg='gray')
versionTxt.pack()
verIdx = Tkinter.IntVar()
verIdx.set(0)
VersionDirs = os.listdir(dirDocTranslate)
for index in range(len(VersionDirs)):
    Tkinter.Radiobutton(window,text=VersionDirs[index],variable=verIdx,value=index).pack()
    
langsList = ["kr","tw","vn","cn"]
langTxt = Tkinter.Label(window, text='设置语言',width=40, height=1, font=('Arial', 10), bg='gray')
langTxt.pack()
langIdx = Tkinter.IntVar()
langIdx.set(0)
for index in range(len(langsList)):
    lBtn = Tkinter.Radiobutton(window,text=langsList[index],variable=langIdx,value=index).pack()

langTxt = Tkinter.Label(window, text='设置存放Editor.xlsx、UiTxt.xlsx、\nEffect.xlsx、LangTemplate.xlsx文件的目录',width=30, height=2, font=('Arial', 10), bg='gray')
langTxt.pack()

frame = Tkinter.Frame(window)
frame.pack()
frame_l = Tkinter.Frame(frame)
frame_r = Tkinter.Frame(frame)
frame_l.pack(side='left')
frame_r.pack(side='right')

excelVar = Tkinter.StringVar()
excelVar.set('')
excelEntry = Tkinter.Entry(frame_l,width=50, textvariable = excelVar).pack(pady=5)
def onExcel():
    path = tkFileDialog.askdirectory()
    if len(path) > 0:
        excelVar.set(path)
excelBtn = Tkinter.Button(frame_r, text='打开目录...', font=('Arial', 8), width=10, height=1, command=onExcel)
excelBtn.pack(pady=5)

editorFileName = "Editor.xlsx"
uiFileName = "UiTxt.xlsx"
effectFileName = "Effect.xlsx"
langTemplateFileName = "LangTemplate.xlsx"

def onStartBtn():
    targetVersion = VersionDirs[verIdx.get()]
    targetLang = langsList[langIdx.get()]
    outDirName = targetVersion+"_"+targetLang+"_"+str(datetime.date.today())
    outDir = os.path.abspath(os.path.join(dirSysText, outDirName))
    outDirVar.set(outDir)
    dirProject = os.path.join(dirExec, "..","..","..","..","client","tags",targetVersion )
    if not os.path.exists(dirProject):
        dirProject = os.path.join(dirExec, "..","..","..","..","client","trunk" )
    hasCorrectDir = False
    resultDesc = "发现Excel文件"

    excelDir = excelVar.get()
    editorDir = os.path.join(excelDir,editorFileName)
    uiTxtDir = os.path.join(excelDir,uiFileName)
    effectrDir = os.path.join(excelDir,effectFileName)
    langTemplateDir = os.path.join(excelDir,langTemplateFileName)
    if os.path.exists(editorDir):
        generateEditorKey(targetVersion,editorFileName, excelDir, outDir, targetLang)
        dirCocosstudio = os.path.join(dirProject,"cocosstudio")
        generateEditorKeyPath(targetVersion,outDir,dirCocosstudio,targetLang)
        hasCorrectDir = True
        resultDesc = resultDesc + " " + editorFileName
    if os.path.exists(uiTxtDir):
        generateTextKey(uiFileName, excelDir, outDir, targetLang)
        hasCorrectDir = True
        resultDesc = resultDesc + " " + uiFileName
    if os.path.exists(effectrDir):
        generateEffectKey(effectFileName, excelDir, outDir,targetLang)
        hasCorrectDir = True
        resultDesc = resultDesc + " " + effectFileName
    if os.path.exists(langTemplateDir):
        generateLangTemplate(langTemplateFileName, excelDir, outDir, targetLang)
        hasCorrectDir = True
        resultDesc = resultDesc + " " + langTemplateFileName

    if hasCorrectDir == True:
        tkMessageBox.showinfo('Success',resultDesc + "\n输出目录："+outDir, parent=window)
    else:
        tkMessageBox.showinfo('Warning',"请先设置正确的Excel目录", parent=window)

startBtn = Tkinter.Button(window, text='开始导出', font=('Arial', 16), width=20, height=1, command=onStartBtn)
startBtn.pack(pady=10)

outDirVar = Tkinter.StringVar()
outDirTxt = Tkinter.Label(window, text='',width=60, height=1, font=('Arial', 8),textvariable=outDirVar)
outDirTxt.pack()

def getEnvironmentVariable(var):
    try:
        value = os.environ[var]
    except Exception:
        tkMessageBox.showinfo('Warning',var+"环境变量未设置", parent=window)
        print "check_environment_variable %s not found"%var
    return value

def onCheckBtn():
    luaFile = os.path.join(outDirVar.get(),"LangTemplate.lua")
    if os.path.exists(luaFile):
        consoleRoot = getEnvironmentVariable("COCOS_CONSOLE_ROOT")
        luajitDir = os.path.join(consoleRoot,"..","plugins","plugin_luacompile","bin","32bit")
        luajit = "luajit-win32.exe"
        luacFile = luaFile+'c'
        cmd = 'cd /D %s && %s -b %s %s' % (luajitDir,luajit,luaFile,luacFile)
        print cmd
        try:
            ret = subprocess.check_output(cmd,
                            stderr = subprocess.STDOUT,
                            shell = True)
            tkMessageBox.showinfo('Success',"语法正确", parent=window)
        except subprocess.CalledProcessError, exc:
            print 'returncode:', exc.returncode
            print 'output:', exc.output
            tkMessageBox.showinfo('Success',"语法错误"+exc.output, parent=window)
    else:
        tkMessageBox.showinfo('Warning',"未找到LangTemplate.lua", parent=window)

checkBtn = Tkinter.Button(window, text='LuaTemplate.lua语法检查', font=('Arial', 10), width=20, height=1, command=onCheckBtn)
checkBtn.pack()


window.mainloop()
# if __name__ == "__main__":
    # utils.runMain(main)
