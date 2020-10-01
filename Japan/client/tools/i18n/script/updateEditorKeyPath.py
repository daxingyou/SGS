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

def getShortPath(path):
    paths = path.split('/')
    shortPath = ""
    for idx in xrange(1,len(paths)):
        if idx == 1:
            shortPath = paths[idx]
        else:
            shortPath = shortPath + "/" + paths[idx]
    print(shortPath)
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

    dirProject = os.path.abspath(dirCocosstudio)

    ui3CommonPath = os.path.join(dirProject,"res","i18n",basePath,"ui3") #通用资源目录
    ui3OverSeaPath = os.path.join(dirProject,"res","i18n",lang,"ui3") #海外资源目录
    ui3LocalPath = os.path.join(dirProject,"res","ui3") #本地资源目录

    iconCommonPath = os.path.join(dirProject,"res","i18n",basePath,"icon") #通用资源目录
    iconOverSeaPath = os.path.join(dirProject,"res","i18n",lang,"icon") #海外资源目录
    iconLocalPath = os.path.join(dirProject,"res","icon") #本地资源目录


    curJsonPath = os.path.join(dirProject,"res","i18n",lang,"json")#海外资源目录
    json_file = "editor_key.json"
    
    imageMap = {}
    #遍历本地资源目录查看是否有对应的海外资源
    for dirpath, dirnames, filenames in os.walk(ui3LocalPath):
        for filename in filenames:
            filepath = os.path.join(dirpath,filename)
            newpath = filepath.replace(dirProject+os.path.sep,"")
            newpath = newpath.replace("\\","/")
            shortValue = getShortPath(newpath)
            findMatch = False 
            shortValue_pre,shortValue_ext = os.path.splitext(shortValue)
            img_format_map = {'.png':['.png','.jpg'],'.jpg':['.jpg','.png'],'.fnt':['.fnt']}
            if not img_format_map.has_key(shortValue_ext):
                continue
            pass
            for format_name in img_format_map[shortValue_ext]:
                commonSeaPath = "res/i18n/"+basePath+"/"+shortValue_pre+format_name
                if os.path.exists(dirProject+os.path.sep + commonSeaPath):
                    imageMap[newpath] = commonSeaPath
                    findMatch = True
                pass
                overSeaPath = "res/i18n/"+lang+"/"+shortValue_pre+format_name
                if os.path.exists(dirProject+os.path.sep + overSeaPath):
                    imageMap[newpath] = overSeaPath
                    findMatch = True
                pass
                if findMatch:
                    break
                pass
            pass
        pass
    pass

    for dirpath, dirnames, filenames in os.walk(iconLocalPath):
        for filename in filenames:
            filepath = os.path.join(dirpath,filename)
            newpath = filepath.replace(dirProject+os.path.sep,"")
            newpath = newpath.replace("\\","/")
            shortValue = getShortPath(newpath)
            findMatch = False 
            shortValue_pre,shortValue_ext = os.path.splitext(shortValue)
            img_format_map = {'.png':['.png','.jpg'],'.jpg':['.jpg','.png'],'.fnt':['.fnt']}
            if not img_format_map.has_key(shortValue_ext):
                continue
            pass
            for format_name in img_format_map[shortValue_ext]:
                commonSeaPath = "res/i18n/"+basePath+"/"+shortValue_pre+format_name
                if os.path.exists(dirProject+os.path.sep + commonSeaPath):
                    imageMap[newpath] = commonSeaPath
                    findMatch = True
                pass
                overSeaPath = "res/i18n/"+lang+"/"+shortValue_pre+format_name
                if os.path.exists(dirProject+os.path.sep + overSeaPath):
                    imageMap[newpath] = overSeaPath
                    findMatch = True
                pass
                if findMatch:
                    break
                pass
            pass
        pass
    pass
   
    txt_json_data, name, jsonPath = utils.readJsonFile(curJsonPath, json_file)
    new_txt_json_data = {}
    for key,value in txt_json_data.items():
        if not key.startswith("res") or key.startswith("res/fonts/"):
            new_txt_json_data[key] = value
        
    #合并，写入editor_key.json
    resultMap = {}
    resultMap.update(new_txt_json_data)
    resultMap.update(imageMap)
    json_path = os.path.join(dirVersion, json_file)
    writeJsonFile(resultMap, json_path)

def list_dir(path):
    result_dir = []
    for dirpath, dirnames, filenames in os.walk(path):
        result_dir.extend(dirnames)
        break
    return result_dir



# tools/script
dirExec = os.path.dirname(utils.getExecPath())
dirDocTranslate = os.path.join(dirExec, "..","..","..","..","doc","tags" )


window = Tkinter.Tk()

import sys
reload(sys)
sys.setdefaultencoding('utf-8')

window.title('导出JsonLua')
window.geometry('600x520')

titleTxt = Tkinter.Label(window, text='翻译图片映射', font=('Arial', 14), width=30, height=2)
titleTxt.pack()

versionTxt = Tkinter.Label(window, text='设置版本号',width=40, height=1, font=('Arial', 10), bg='gray')
versionTxt.pack()
verIdx = Tkinter.IntVar()
verIdx.set(0)
VersionDirs = list_dir(dirDocTranslate)#os.listdir(dirDocTranslate)
VersionDirs.append('trunk')
for index in range(len(VersionDirs)):
    Tkinter.Radiobutton(window,text=VersionDirs[index],variable=verIdx,value=index).pack()
    
langsList = ["kr","tw","vn","cn"]
langTxt = Tkinter.Label(window, text='设置语言',width=40, height=1, font=('Arial', 10), bg='gray')
langTxt.pack()
langIdx = Tkinter.IntVar()
langIdx.set(0)
for index in range(len(langsList)):
    lBtn = Tkinter.Radiobutton(window,text=langsList[index],variable=langIdx,value=index).pack()


def onStartBtn():
  
    dirSysText = os.path.join(dirExec, "..", "sysText")

    targetVersion = VersionDirs[verIdx.get()]
    targetLang = langsList[langIdx.get()]
    outDirName = targetVersion+"_"+targetLang+"_"+str(datetime.date.today())
    outDir = os.path.abspath(os.path.join(dirSysText, outDirName))
   
    if targetVersion != 'trunk':
        dirProject = os.path.join(dirExec, "..","..","..","..","client","tags",targetVersion )
    else:
        dirProject = os.path.join(dirExec, "..","..","..","..","client","trunk" )
    pass


    dirCocosstudio = os.path.join(dirProject,"cocosstudio")
    generateEditorKeyPath(targetVersion,outDir,dirCocosstudio,targetLang)



startBtn = Tkinter.Button(window, text='开始导出', font=('Arial', 16), width=20, height=1, command=onStartBtn)
startBtn.pack(pady=10)


window.mainloop()
