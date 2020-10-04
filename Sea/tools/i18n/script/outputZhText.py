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
import Tkinter, tkFileDialog, tkMessageBox
import subprocess

def removeInvalidDir(DIR):
    print("cleanDir = %s" % DIR)
    lists = os.walk(DIR)
    for root, dirs, files in lists:
        for d in dirs:
            # print("dir: = %s" % d)
            names = d.split(".")
            utils.printObject(names,"dirs :")
            path = os.path.join(root, d)
            tmp = utils.getSubDir(DIR, path)
            finded = True
            if names[0] == "" and names[-1] == "Dir":
                finded = False
            if finded:
                removeInvalidDir(path)
                continue
            shutil.rmtree(path)

def getDocDirFileList( fileList, docDir ,ignoreChinese=True):
    xlsxList = utils.getFilesWithExt(docDir,".xlsx")
    for xls in xlsxList:
        print("xls = %s" % xls)
        filePath, cur_ext = os.path.splitext(xls)
        fileName =  filePath.split(os.path.sep)[-1]
        # print("fileName xls = %s" % fileName)
        # print("cur_ext xls = %s" % cur_ext)
        inChinese =  utils.isMathChinese(fileName)
        isIgnore =  fileName[0:2] == "~$"
        # inChinese =  utils.isChinese(fileName)
        # print("isIgnore txt = %s" % fileName[0:2])
        # print("isIgnore xls = %s" % isIgnore)
        # print("chinese xls = %s" % inChinese)
        if not isIgnore:
            if ignoreChinese :
                if not inChinese:
                    fileList.append(xls)
            else:
                fileList.append(xls)
            pass

    return fileList

def checkTxtForMap(txt,txtMap,info):
    md5 = utils.getMd5(txt)
    data = None
    if txtMap.has_key(md5):
        data = txtMap[md5]

    if data == None:
        # print("txt = %s" % txt)
        data = {"txt":txt,"num":1,"list":[info]}
        txtMap[md5] = data
    else:
        dataList = data["list"]
        dataList.append(info)
        data["num"] = int(data["num"])+1
        pass    

def getPermission(index,permissionList):
    # print("getPermission index = %s" % index)
    # utils.printObject(permissionList,"permissionList")
    permission = ""
    if index < len(permissionList):
        permission = permissionList[index]
    isPermission = True
    if permission == "Excluded":
        isPermission = False
    return isPermission  


def checkSpecial(str):
    # return re.compile('[a-zA-Z]').search(str)
    txt = str.decode('UTF-8')
    if len(txt) == 4 and re.compile(r'(\d+)星(\d+)阶').search(str):
        return True
    return False

def checkIgnore(str):
    isIgnore = False
    checkIgnoreFunc = lambda str,target: True if len(str) > len(target) and str[0:len(target)] == target else False

    isIgnore = checkIgnoreFunc(str,"=")
    # if not isIgnore:
    #     isIgnore = checkIgnoreFunc(str,"=IF(")
    # if not isIgnore:
    #     isIgnore = checkIgnoreFunc(str,"=VLOOKUP(")

    return isIgnore


def getFileTxtMap(rootMap,filePath):
    xlsxMap = {}
    # xlsxList =  utils.readXlsxFile2(filePath)
    xlsxList =  utils.readXlsxFile2(filePath,True)

    fileTmpPath, cur_ext = os.path.splitext(filePath)
    fileName =  fileTmpPath.split(os.path.sep)[-1]

    # 策划表第四行为权限信息
    permission_index = 3
    # 策划表第五行为id名字
    id_index = 4
    sheet_len = len(xlsxList)
    # 策划表默认只提取第一个
    sheet_len = 1 
    for sheet_index in range(0,sheet_len):
        sheet = xlsxList[sheet_index]
        row_satrt = 0
        # 策划表默认从第六行开始  前五行位配置数据 
        row_satrt = 5 
        # print("sheet_index = %s" % sheet_index)
        # print("sheet = %s" % sheet)
        # continue
        permissionList = sheet[permission_index]
        for row_index in range(row_satrt,len(sheet)):
            row = sheet[row_index]
            for line_index in range(0,len(row)):
                line = row[line_index]
                isNumber = utils.isAllNumber(str(line))
                if not line or isNumber :
                    continue
                isPermission = getPermission(line_index,permissionList)
                inChinese = utils.isMathChinese(str(line))
                isIgnore =  checkIgnore(str(line))
                # print("--------line = %s" % line)
                # print("line_index = %s" % line_index)
                # print("isPermission = %s" % isPermission)
                # print("inChinese = %s" % inChinese)
                # print("isIgnore = %s" % isIgnore)
                if isPermission and inChinese and not isIgnore:
                    info = {"txt":line,"name":fileName,"path":filePath,"sheet":sheet_index,"row":row_index,"line":line_index}
                    checkTxtForMap(line,xlsxMap,info)
                    checkTxtForMap(line,rootMap,info)
                    pass
                pass
            pass
        pass

    # utils.printObject(xlsxMap,filePath+": ")
    
    fileMap = None
    if not rootMap.has_key("_fileMap"):
        rootMap["_fileMap"] = {}
        fileMap = rootMap["_fileMap"]
    else:
        fileMap = rootMap["_fileMap"]
        pass

    fileMap[filePath] = xlsxMap
    # utils.printObject(fileMap,filePath+": ")
    return xlsxMap

def getLocalDataToString(localData):
    localStr = ""
    localMap = {}
    # lcoalList = []
    txt = localData["txt"].decode('UTF-8')
    items = localData["list"]
    for item in items:
        fileName = item["name"]+".xlsx"
        sheet = item["sheet"]
        row = item["row"]
        line = item["line"]
        lcoal = {"row":row,"line":line}
        if not localMap.has_key(fileName):
            localMap[ fileName ] = [ lcoal ]
        else:
            localMap[ fileName ].append( lcoal )
            pass    

    # localStr = json.dumps(localMap, ensure_ascii=False, indent=4)      
    localStr = json.dumps(localMap, ensure_ascii=False)      

    return localStr

def outputFullFileMap(rootMap,outputPath,headers):
    dataList = []
    count = 0
    for k,v in rootMap.items():
        if k != "_fileMpa":
            utils.printObject(k,"-----k")
            if v.has_key("txt") and v.has_key("num"):
                txt = v["txt"].decode('UTF-8')
                utils.printObject(txt,"txt")
                local = getLocalDataToString(v) 
                item = [txt,"",len(txt),v["num"],utils.getMd5(txt),local]
                count = count + len(txt)
                dataList.append(item)
                # utils.printObject(item,"item:")
            else:
                utils.printObject(v,"v")
                pass    
    headers[2] = headers[2] + "(%s)" % count
    utils.writeXlsxFile(dataList,outputPath,headers)


def outputAllFileMap(rootMap,outputPath,headers):
    fileMap = None

    if rootMap.has_key("_fileMap"):
        fileMap = rootMap["_fileMap"]

    if fileMap :
        utils.mkOutDir(outputPath,1)
        sumTxt = headers[2]
        for file_path,file_data in fileMap.items():
            dataList = []
            count = 0
            for k,v in file_data.items():
                # utils.printObject(k,"-----k")
                if v.has_key("txt") and v.has_key("num"):
                    txt = v["txt"].decode('UTF-8')
                    # utils.printObject(txt,"txt")
                    local = getLocalDataToString(v) 
                    item = [txt,"",len(txt),v["num"],utils.getMd5(txt),local]
                    count = count + len(txt)
                    dataList.append(item)
                else:
                    utils.printObject(v,"v")
                    pass

            if count > 0:
                filePath =  file_path.split(os.path.sep)[-1]
                headers[2] = sumTxt + "(%s)" % count
                utils.writeXlsxFile(dataList,os.path.join(outputPath,filePath),headers)


def main(cfgFile=None):
    dirScript           = os.path.dirname(utils.getExecPath())
    dirConfig           = os.path.join(dirScript, "..", "config")
    dirMD5              = os.path.join(dirScript, "..", "md5")
    dirTags             = os.path.join(dirScript, "..", "..", "..", "tags")
    dirClient           = os.path.join(dirScript, "..", "..", "..", "trunk")
    dirDoc              = os.path.join(dirScript, "..", "..", "..", "..", "doc", "tags", "test")
    dirOutputRoot       = os.path.join(dirScript, "..", "..", "..", "..", "doc", "tags")
    dirOutputFile           = os.path.join(dirScript, "..", "..", "..", "..", "doc", "tags", "jp_text")


    rootMap = {}
    print("dirDoc = %s" % dirDoc)
    xlsxFileList = []
    xlsxFileList = getDocDirFileList(xlsxFileList,dirDoc)
    xlsxFileList = [ utils.getFilesWithExt(dirDoc,".xlsx","story_chapter") ]
    # xlsxFileList = [ utils.getFilesWithExt(dirDoc,".xlsx","story_chat") ]
    # xlsxFileList = [ utils.getFilesWithExt(dirDoc,".xlsx","story_stage") ]
    # xlsxFileList = [ utils.getFilesWithExt(dirDoc,".xlsx","title") ]
    # xlsxFileList = [ utils.getFilesWithExt(dirDoc,".xlsx","avatar") ]
    # xlsxFileList = utils.getFilesWithExt(dirDoc,".xlsx")
    utils.printObject(xlsxFileList,"xlsxFileList:")

    for xlsx in xlsxFileList:
        xlsxMap = getFileTxtMap(rootMap,xlsx)
        pass

    rootheaders = ["中文","日文","字数","重复次数","md5","位置信息"]    
    # outputFullFileMap(rootMap,os.path.join(dirOutputRoot,"root_all_data_only1.xlsx"),rootheaders)
    outputAllFileMap(rootMap,dirOutputFile,rootheaders)
    # utils.printObject(rootMap,"rootMap:")

# if __name__ == "__main__":
#     utils.runMain(main)

# ----------------------------------------------------------------------脚本图形化分割线---------------------------------------------------------------------------------

def getExecPath():
    import sys
    if hasattr(sys, "frozen"):
        return os.path.realpath(sys.executable)
    else:
        return os.path.realpath(sys.argv[0])

def getFilesWithName(DIR, name, ext=None):
    if name == None and ext == None:
        return DIR

    if ext == None:
        _list = name.split(".")
        ext = "." + _list[-1]
        name = name[0:(len(name)-len(ext))]
    ret = []
    for dirpath, dirnames, filenames in os.walk(DIR):
        for filename in filenames:
            if os.path.splitext(filename)[0] == name and os.path.splitext(filename)[1] == ext:
                ret.append(os.path.join(dirpath, filename))
    return ret

def byteify(input):
    if isinstance(input, dict):
        return {byteify(key): byteify(value) for key, value in input.iteritems()}
    elif isinstance(input, list):
        return [byteify(element) for element in input]
    elif isinstance(input, unicode):
        return input.encode('utf-8')
    else:
        return input

def writeJsonFile(fileData, fullPath):
    print("writeJsonFile = %s" % fullPath)
    f = open(fullPath, "w")
    with open(fullPath, "w") as f:
        json.dump(fileData, f, ensure_ascii=False, indent=4)
    f.close()

def readJsonFile(DIR, name, ext=None):
    jsonPath = getFilesWithName(DIR, name, ext)[0]
    print("readJsonFile = %s" % jsonPath)
    data = json.load(open(jsonPath, 'r'))
    data = byteify(data)
    return data, name, jsonPath

def writeSetting():
    data = {
        'excelDir':excelVar.get(),
        'outputDir':outputVar.get()
    }
    writeJsonFile(data, os.path.join(dirExec,"setting.json"))

def getSetting():
    if os.path.exists(os.path.join(dirExec,"setting.json")):
        jsonData, name, jsonPath = readJsonFile(dirExec, "setting.json")
        return jsonData
    else:
        return {'outputDir':'','excelDir':''}

def output(isMerge,sourceDir,outputDir):
    dirScript           = os.path.dirname(utils.getExecPath())
    dirConfig           = os.path.join(dirScript, "..", "config")
    dirTags             = os.path.join(dirScript, "..", "..", "..", "tags")
    dirClient           = os.path.join(dirScript, "..", "..", "..", "trunk")
    dirDoc              = os.path.join(dirScript, "..", "..", "..", "..", "doc", "tags", "test")
    dirOutputRoot       = os.path.join(dirScript, "..", "..", "..", "..", "doc", "tags")
    dirOutputFile       = os.path.join(dirScript, "..", "..", "..", "..", "doc", "tags", "jp_text")


    dirDoc = sourceDir
    dirOutputMerge = os.path.join(outputDir,"excel.xlsx")
    dirOutputFile = os.path.join(outputDir,"excel")


    rootMap = {}
    print("dirDoc = %s" % dirDoc)
    xlsxFileList = []
    xlsxFileList = getDocDirFileList(xlsxFileList,dirDoc)
    utils.printObject(xlsxFileList,"xlsxFileList:")

    for xlsx in xlsxFileList:
        xlsxMap = getFileTxtMap(rootMap,xlsx)
        pass

    rootheaders = ["中文","日文","字数","重复次数","md5","位置信息"]    

    if isMerge:
        outputFullFileMap(rootMap,dirOutputMerge,rootheaders)
    else:
        outputAllFileMap(rootMap,dirOutputFile,rootheaders)
        pass



dirExec = os.path.dirname(getExecPath())
settingData = getSetting()
window = Tkinter.Tk()

import sys
reload(sys)
sys.setdefaultencoding('utf-8')

window.title('导出Excel所有中文数据')
window.geometry('600x520')

titleTxt = Tkinter.Label(window, text='Excel导出中文', font=('Arial', 14), width=30, height=2)
titleTxt.pack()

exceTxt = Tkinter.Label(window, text='设置需要 导出中文的Excel文件夹 和 导出后的中文Excel文件夹',width=60, height=1, font=('Arial', 10), bg='gray')
exceTxt.pack()

frame = Tkinter.Frame(window)
frame.pack()
frame_l = Tkinter.Frame(frame)
frame_r = Tkinter.Frame(frame)
frame_l.pack(side='left')
frame_r.pack(side='right')

excelVar = Tkinter.StringVar()
excelVar.set(settingData['excelDir'])
excelEntry = Tkinter.Entry(frame_l,width=40, textvariable = excelVar).pack(pady=5)
def onExcel():
    path = tkFileDialog.askdirectory()
    if len(path) > 0:
        excelVar.set(path)
excelBtn = Tkinter.Button(frame_r, text='中文Excel目录', font=('Arial', 8), width=20, height=1, command=onExcel)
excelBtn.pack(pady=5)


# mergeButton = Tkinter.Checkbutton(window,text="合并导出",).pack()
# mergeButton.select()

mergeList = ["合并导出","单独导出"]
mergeTxt = Tkinter.Label(window, text='设置导出类型',width=40, height=1, font=('Arial', 10), bg='gray')
mergeTxt.pack()
mergeIdx = Tkinter.IntVar()
mergeIdx.set(0)
for index in range(len(mergeList)):
    lBtn = Tkinter.Radiobutton(window,text=mergeList[index],variable=mergeIdx,value=index).pack()

# outputTxt = Tkinter.Label(window, text='设置导出后的中文Excel所在文件夹',width=40, height=1, font=('Arial', 10), bg='gray')
# outputTxt.pack()

outputVar = Tkinter.StringVar()
outputVar.set(settingData['outputDir'])
excelEntry = Tkinter.Entry(frame_l,width=40, textvariable = outputVar).pack(pady=15)
def onOutput():
    path = tkFileDialog.askdirectory()
    if len(path) > 0:
        outputVar.set(path)
excelBtn = Tkinter.Button(frame_r, text='导出Excel目录', font=('Arial', 8), width=20, height=1, command=onOutput)
excelBtn.pack(pady=15)

# sourceDir,outputDir

def onStartBtn():
    writeSetting()
    isMerge = mergeIdx.get() == 0
    sourceDir = excelVar.get()
    outputDir = outputVar.get()

    print 'sourceDir = '+sourceDir
    print 'outputDir = '+outputDir
    if not os.path.exists(sourceDir):
        tkMessageBox.showinfo('Warning',"请先设置正确的Excel文件路径", parent=window)
        return
    if not os.path.exists(outputDir):
        tkMessageBox.showinfo('Warning',"请先设置正确的输出目录", parent=window)
        return

    output(isMerge,sourceDir,outputDir)
    tkMessageBox.showinfo('Success',"导出完成\n输出目录："+outputDir, parent=window)

startBtn = Tkinter.Button(window, text='开始导出', font=('Arial', 16), width=20, height=1, command=onStartBtn)
startBtn.pack(pady=10)

writeSetting()


window.mainloop()