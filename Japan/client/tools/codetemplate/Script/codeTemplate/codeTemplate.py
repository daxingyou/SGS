#!/usr/bin/python
# -*- coding: utf-8 -*-
import os,sys,string,getpass,time,re,shutil,json
# from optparse import OptionParser
from string import Template
try:
    import xml.etree.ElementTree as ET
except ImportError:
	print "import ElementTree error"

# parser = OptionParser()
# parser.add_option("-u", "--username", dest="userName", help="user name")
# parser.add_option("-p", "--path", dest="client path", help="client path")
# parser.add_option("-v", "--view", dest="viewCsdPath", help="csd file path")
# parser.add_option("-f", "--folder", dest="viewFolderPath", help="csd folder path")
# parser.add_option("-m", "--dataname", dest="viewFolderPath", help="data name")
# parser.add_option("-o", "--output", dest="outputPaht", help="output path")
# (options, args) = parser.parse_args()
# USER_NAME = getpass.getuser()
# print(options)


def error(msg):
    print("error: %s "%msg)
    exit(-1)
def info(msg):
    print("info: %s "%msg)

def getCurTime():
    return time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())

def getVarNameFirstCharUp(name):
    upChar = name[1];
    upName = name[2:];
    return upChar.upper() + upName
def getVarEventFunctionName(name):
    funcName = "_on" + getVarNameFirstCharUp(name)
    return funcName
def getViewType(name):
    length = len(name)
    if length >= 6:
        head = name[0:6]
        if head == "Common":
            return "Common"
    if length >= 4:
        tail = name[len(name) - 4:]
        if tail == "Cell":
            return "ListViewCellBase"
    if length >=5:
        head = name[0:5]
        if head == "Popup":
            return "PopupBase"
    return "ViewBase"

def getBaseClassPath(baseClassName):
    if baseClassName == "PopupBase":
        return "app.ui.PopupBase"
    elif baseClassName == "ListViewCellBase":
        return "app.ui.ListViewCellBase";
    else:
        return "app.ui.ViewBase";
def getCsdMatchLuaPath(csdList, isNotPopUp = None):
    if csdList and len(csdList) >0:
        if csdList[0] == "common":
            if isNotPopUp:
                return "app%sui%scomponent"%(os.path.sep, os.path.sep)
            else:
                return "app%sui" % os.path.sep
        else:
            return os.path.join("app", "scene", "view", os.path.sep.join(csdList))
    else:
        error("get csd match path error")


#========================================

argvLen = len(sys.argv)
USER_NAME = getpass.getuser()
if argvLen < 2:
    error("-v clientPath csdpath username\n -p clientPath protoFilePath dataname protoIDS username")
else:
    FUNCTION_TYPE = 0
    if "-p" == sys.argv[1] :
        #生成Data 模板
        if argvLen < 7:
            error("-p clientPath protoFilePath dataname protoIDS username")
        FUNCTION_TYPE = 1
        CLIENT_PATH = sys.argv[2]
        DATA_PATH = os.path.join(CLIENT_PATH, "src", "app", "data")
        PROTOFILE_PATH = os.path.join(sys.argv[3], "cs.proto")
        DATA_NAME = sys.argv[4]
        DATA_PARAM = sys.argv[5]
        USER_NAME = sys.argv[6]

        if not DATA_NAME or DATA_NAME == "":
            error("please input dataname!")

        info("PROTOFILE_PATH : %s" % PROTOFILE_PATH)
        info("DATA_NAME: %s" % DATA_NAME)
        info("DATA_PARAM : %s" % DATA_PARAM)
    elif "-i" == sys.argv[1]:
        #ui工具获取proto List
        FUNCTION_TYPE = 2
        if argvLen < 3:
            error("-i  protoFilePath ")
        PROTOFILE_PATH = os.path.join(sys.argv[2], "cs.proto")

    else:
        #生成csd 模板
        if argvLen < 4:
            error("-v clientPath csdpath username")
        CLIENT_PATH = sys.argv[2]
        CSD_PATH = sys.argv[3]
        LUA_SRC_PAHT = os.path.join(CLIENT_PATH, "src")
        LUA_COMPONENT_PAHT = os.path.join(LUA_SRC_PAHT, "app", "ui", "component", "init.lua")
        info("LUA_SRC_PAHT : %s" % LUA_SRC_PAHT)
        info("LUA_COMPONENT_PAHT : %s" % LUA_COMPONENT_PAHT)
        USER_NAME = sys.argv[4]

# if not USER_NAME:
#     USER_NAME = getpass.getuser()
SCRIPT_PATH = os.path.abspath(os.path.split(sys.argv[0])[0]);
info("SCRIPT_PATH : %s" % SCRIPT_PATH)
info("USER_NAME : %s" % USER_NAME)
# =================================
# 读取数据
class UserData(object):
    _instance = None
    _luaComponentDict = {}
    _protoDict = {}

    def __new__(cls, *args, **kw):
        if not cls._instance:
            cls._instance = super(UserData, cls).__new__(cls, *args, **kw)
            cls._instance._parseLuaComponent()
        return cls._instance

    def _matchLuaComponent(self, str):
        matchObj = re.match(r'.*cc\.register\s*\(\s*"\s*(\w*)\s*"\s*,\s*import\s*\(\s*"\s*\.\s*(\w*)\s*".*', str)
        if matchObj:
            groups = matchObj.groups()
            if groups and len(groups) >=2:
                self._luaComponentDict[groups[0]] = groups[1]

    def _parseLuaComponent(self):
        global LUA_COMPONENT_PAHT;
        # print LUA_COMPONENT_PAHT
        pFile = open(LUA_COMPONENT_PAHT)
        lines = pFile.readlines()
        for line in lines:
            self._matchLuaComponent(line)
        pFile.close()
    def getComponentType(self, tp):
        if self._luaComponentDict.has_key(tp):
            return self._luaComponentDict[tp]
        else:
            return ""
            #error("can not find lua component %s"%tp)
# csd 解析
class ParseCsd(object):
    def __init__(self, csdPath):
        super(ParseCsd, self).__init__()
        self.__csdPath = csdPath
        tree = ET.parse(csdPath)
        self.__rootNode = tree.getroot()

    def _findAllNode(self, parentNode, nodeArr):
        nodeList = parentNode.findall("./AbstractNodeData")
        for node in nodeList:
            nodeArr.append(node)
        for node in list(parentNode):
            self._findAllNode(node, nodeArr)

    def _isCsbVar(self, name):
        return name[0] == "_" and name != "_resourceNode"

    def _getTypeName(self, node):
        typeName = node.attrib["ctype"]
        typeName = typeName[0:len(typeName)-10]
        if typeName == "ProjectNode":
            fileDataNode = node.find("FileData")
            if fileDataNode != None:
                if fileDataNode.attrib.has_key("Path"):
                    typeName = fileDataNode.attrib["Path"]
                    typeName = os.path.splitext(os.path.basename(typeName))[0]
                    typeName = UserData().getComponentType(typeName)
                else:
                    error("%s: can not find FileData node attrib Path" % self.__csdPath)
            else:
                error("%s: can not find FileData node" % self.__csdPath)
        return typeName
    def getVarDict(self):
        varDict = {}
        nodeArr = []
        self._findAllNode(self.__rootNode, nodeArr)
        for node in nodeArr:
            if node.attrib.has_key("Name"):
                name = node.attrib["Name"]
                if name != None and len(name) >= 2 and self._isCsbVar(name):
                    if varDict.has_key(name):
                        error("%s: has two equal var name: %s" % (self.__csdPath, name))
                    else:
                        varDict[name] = self._getTypeName(node)
            else:
                error("%s: can not find node attrib Name" % self.__csdPath)
        return varDict

class CodeTemplate(object):
    _instance = None
    _templateStr = {}
    def __new__(cls, *args, **kw):
        if not cls._instance:
            cls._instance = super(CodeTemplate, cls).__new__(cls, *args, **kw)
            cls._instance._loadAllTemplate();
        return cls._instance
    # def __init__(self):
    #     print self._templateStr
    def _loadAllTemplate(self):
        global SCRIPT_PATH
        # button Template
        self._loadTemplateFile("button_bindcell",
                               os.path.join(SCRIPT_PATH, "template", "other", "buttonBindingCell.lua"))
        self._loadTemplateFile("button_bind",
                               os.path.join(SCRIPT_PATH, "template", "other", "buttonBinding.lua"))
        self._loadTemplateFile("csd_var_bind",
                               os.path.join(SCRIPT_PATH, "template", "other", "csdBindingVar.lua"))
        self._loadTemplateFile("checkbox_oncreate",
                               os.path.join(SCRIPT_PATH, "template", "other", "checkBoxOnCreate.lua"))
        self._loadTemplateFile("listview_oncreate",
                               os.path.join(SCRIPT_PATH, "template", "other", "listViewOnCreate.lua"))
        self._loadTemplateFile("button_oncreate",
                               os.path.join(SCRIPT_PATH, "template", "other", "buttonOnCreate.lua"))
        self._loadTemplateFile("popup_oncreate",
                               os.path.join(SCRIPT_PATH, "template", "other", "popupOnCreate.lua"))
        # listview Template
        self._loadTemplateFile("listview_default_function",
                               os.path.join(SCRIPT_PATH, "template", "function", "listviewDefaultFunction.lua"))
        # view default function
        self._loadTemplateFile("view_default_function",
                               os.path.join(SCRIPT_PATH, "template", "function", "viewDefaultFunction.lua"))
        # cell view default function
        self._loadTemplateFile("cell_default_function",
                               os.path.join(SCRIPT_PATH, "template", "function", "cellDefaultFunction.lua"))

        # empty function Template
        self._loadTemplateFile("empty_function",
                               os.path.join(SCRIPT_PATH, "template", "function", "emptyFunction.lua"))
        # empty function Template
        self._loadTemplateFile("checkbox_function",
                               os.path.join(SCRIPT_PATH, "template", "function", "checkBoxFunction.lua"))

        # view Template
        self._loadTemplateFile("view",
                               os.path.join(SCRIPT_PATH, "template", "viewTemplate.lua"))

        # common Template
        self._loadTemplateFile("common",
                               os.path.join(SCRIPT_PATH, "template", "commonTemplate.lua"))

        # proto request
        self._loadTemplateFile("proto_request",
                               os.path.join(SCRIPT_PATH, "template", "proto", "request.lua"))
        # proto reponse
        self._loadTemplateFile("proto_response",
                               os.path.join(SCRIPT_PATH, "template", "proto", "response.lua"))

        # proto check data
        self._loadTemplateFile("proto_check_data",
                               os.path.join(SCRIPT_PATH, "template", "proto", "checkData.lua"))
        # proto recv listen
        self._loadTemplateFile("proto_msg_recv",
                               os.path.join(SCRIPT_PATH, "template", "proto", "protoListen.lua"))
        # proto clear listen
        self._loadTemplateFile("proto_clear_msg_recv",
                               os.path.join(SCRIPT_PATH, "template", "proto", "clearListen.lua"))
        # data Template
        self._loadTemplateFile("data",
                               os.path.join(SCRIPT_PATH, "template", "dataTemplate.lua"))

    def _loadTemplateFile(self, key, path):
        if os.path.exists(path):
            pFile = open(path,"r")
            str = pFile.read()
            pFile.close()
            self._templateStr[key] = Template(str)
    #BUTTON_VAR_NAME BUTTON_FUNC_NAME
    def getButtonBindCellString(self, varName):
        # print(varName)
        funcName = getVarEventFunctionName(varName)
        return self._templateStr["button_bindcell"].substitute({
            "VAR_NAME":varName,
            "BUTTON_FUNC_NAME": funcName,
        })

    def getButtonBinding(self, cellList):
        if len(cellList) != 0:
            return self._templateStr["button_bind"].substitute({
                "BUTTON_CELL":"\n".join(cellList)
            })
        return ""

    def getCsdVarBinding(self, varName, varType):
        return self._templateStr["csd_var_bind"].substitute({
            "VAR_NAME": varName,
            "VAR_TYPE": varType,
        })

    def getButtonOnCreate(self, varName):
        return self._templateStr["button_oncreate"].substitute({
            "VAR_NAME": varName
        })
    def getCheckBoxOnCreate(self, varName, funcName):
        return self._templateStr["checkbox_oncreate"].substitute({
            "VAR_NAME": varName,
            "FUNCTION_NAME":funcName
        })
    def getListViewOnCreate(self, listViewName):
            return self._templateStr["listview_oncreate"].substitute({
                "LISTVIEW_NAME": listViewName
            })
    def getPopupOnCreate(self, varName):
            return self._templateStr["popup_oncreate"].substitute({
                "VAR_NAME": varName
            })


    def getListViewFunction(self, fileName, varName):
        listviewName = getVarNameFirstCharUp(varName)
        return self._templateStr["listview_default_function"].substitute({
            "FILENAME": fileName,
            "LISTVIEW_NAME": listviewName,
            "VAR_NAME": varName,
        })

    def getCellDefaultFunction(self, filename, onCreateStr):
        return self._getNormalDefaultFunction("cell_default_function", filename, onCreateStr)

    def getViewDefaultFunction(self, filename, onCreateStr):
       return self._getNormalDefaultFunction("view_default_function", filename, onCreateStr)

    def _getNormalDefaultFunction(self, key, filename, onCreateStr):
        return self._templateStr[key].substitute({
            "FILENAME":filename,
            "ONCREATE_OTHER":onCreateStr
        })


    def getEmptyFunction(self, fileName, functionName):
        return self._templateStr["empty_function"].substitute({
            "FILENAME":fileName,
            "FUNCTION_NAME":functionName,
        })

    def getCheckBoxFunction(self, fileName, functionName):
        return self._templateStr["checkbox_function"].substitute({
            "FILENAME": fileName,
            "FUNCTION_NAME": functionName,
        })

    def getView(self, fileName, sceneName, otherRequire, csbBinding, eventBinding, other):
        global USER_NAME;
        baseClassName = getViewType(fileName)
        return self._templateStr["view"].substitute({
            "USER_NAME": USER_NAME,
            "DATE": getCurTime(),
            "BASE_CLASS_NAME": baseClassName,
            "BASE_CLASS_NAME_PATH": getBaseClassPath(baseClassName),
            "FILENAME": fileName,
            "SCENE_NAME":sceneName,
            "OTHER_REQUIRE": otherRequire,
            "CSB_BINDING": csbBinding,
            "EVENT_BINDING": eventBinding,
            "OTHER": other,

        })
    def getCommon(self, fileName):
        global USER_NAME;
        return self._templateStr["common"].substitute({
            "USER_NAME": USER_NAME,
            "DATE": getCurTime(),
            "FILENAME": fileName
        })

    def getProtoRequest(self, note, paramsNote, fileName, msgName, paramStr, paramListStr):
        return self._templateStr["proto_request"].substitute({
            "NOTE": note,
            "PARAM_NOTE":paramsNote,
            "FILENAME": fileName,
            "MSG_NAME": msgName,
            "PARAMS": paramStr,
            "PARAMS_LIST": paramListStr
        })

    def getProtoResponse(self, note, fileName, msgName, checkData, msgEventName):
        return self._templateStr["proto_response"].substitute({
            "NOTE":note,
            "FILENAME": fileName,
            "MSG_NAME": msgName,
            "CHECK_DATA": checkData,
            "MSG_EVENT_NAME": msgEventName
        })

    def getProtoMsgRecvListen(self, msgName):
        return self._templateStr["proto_request"].substitute({
            "MSG_NAME": msgName
        })

    def getProtoMsgRecvListen(self, msgName):
        return self._templateStr["proto_msg_recv"].substitute({
            "MSG_NAME": msgName
        })
    def getProtoClearMsgRecvListen(self, msgName):
        return self._templateStr["proto_clear_msg_recv"].substitute({
            "MSG_NAME": msgName
        })
    def getProtoCheckData(self, varName):
        return self._templateStr["proto_check_data"].substitute({
            "VAR_NAME": varName
        })

    def getData(self, fileName, protoListen, clearProtoListen, protoFunction):
        global USER_NAME;
        return self._templateStr["data"].substitute({
            "USER_NAME": USER_NAME,
            "DATE": getCurTime(),
            "FILENAME": fileName,
            "PROTO_LISTEN":protoListen,
            "CLEAR_PROTO_LISTEN":clearProtoListen,
            "PROTO_FUNCTION": protoFunction

        })


class ParseProto(object):
    def __init__(self, protoPath):
        # print(protoPath)
        self._msgs = {}
        self._ids = {}
        self._getProtoData(protoPath)
    def _matchIDBegin(self, matchStr):
        matchObj = re.match(r'\s*enum\s*ID\s*{\s*', matchStr)
        if matchObj:
            return True
    def _matchMsgBegin(self, matchStr):
        matchObj = re.match(r'\s*message\s*(\w*)\s*{\s*', matchStr)
        if matchObj:
            groups = matchObj.groups()
            if(groups and len(groups) == 1):
                return groups[0]
    def _matchMsgNote(self, matchStr):
        matchObj = re.match(r'\s*\/\/\s*(.*)', matchStr)
        if matchObj:
            groups = matchObj.groups()
            if(groups and len(groups) == 1):
                return groups[0]
    def _matchEnd(self, matchStr):
        matchObj = re.match(r'\s*}\s*', matchStr)
        if matchObj:
            return True
    def _matchID(self, matchStr):
        matchObj = re.match(r'\s*(ID_[CScs]2[CScs]_\w*)\s*=\s*\d*;\s*', matchStr)
        if matchObj:
            groups = matchObj.groups()
            if(groups and len(groups) == 1):
                return groups[0]
    def _matchVar(self, matchStr):
        matchObj = re.match(r'\s*(\w*)\s*(\w*)\s*(\w*)\s*=\s*\d*;\s*[/]*(.*)', matchStr)
        if matchObj:
            groups = matchObj.groups()
            if (groups and len(groups) == 4):
                return groups

    def _getProtoData(self, protoPath):
        pFile = open(protoPath)
        lines = pFile.readlines()
        pFile.close()
        objBegin = False
        isReadId = True
        curMsgNote = None
        curMsgDict = None
        for line in lines:
            if isReadId:
                if objBegin:
                    id = self._matchID(line)
                    if id:
                        if not self._ids.has_key(id):
                            self._ids[id] = True
                            continue
                    elif self._matchEnd(line):
                        objBegin = False
                        isReadId = False
                        continue
                else:
                    if self._matchIDBegin(line):
                        objBegin = True
                continue
            else:
                if objBegin:
                    varInfo = self._matchVar(line)
                    if varInfo:
                        if curMsgDict:
                            var = {}
                            var["name"] = varInfo[2]
                            var["type1"] = varInfo[0]
                            var["type2"] = varInfo[1]
                            var["note"] = varInfo[3]
                            curMsgDict["vars"][varInfo[0]].append(var)

                    elif self._matchEnd(line):
                        objBegin = False
                        curMsgNote = None
                        curMsgDict = None
                        continue
                else:
                    msgName = self._matchMsgBegin(line)
                    if msgName:
                        objBegin = True
                        if not self._msgs.has_key(msgName):
                            self._msgs[msgName] = {}
                            curMsgDict = self._msgs[msgName]
                            if curMsgNote:
                                curMsgDict["note"] = curMsgNote
                            else:
                                curMsgDict["note"] = ""
                            curMsgDict["vars"] = {}
                            curMsgDict["vars"]["optional"] = []
                            curMsgDict["vars"]["required"] = []
                            curMsgDict["vars"]["repeated"] = []
                        else:
                            error("parse proto error")
                    else:
                        note = self._matchMsgNote(line)
                        if note:
                            curMsgNote = note
    def getData(self, name):
        if self._msgs.has_key(name):
            return self._msgs[name]
    def getIDS(self):
        return self._ids
def matchButton(str):
    matchObj = re.match(r'.*Button.*', str)
    if matchObj:
        return True
    else:
        return False
def matchCommonButton(str):
    matchObj = re.match(r'.*Common.*Button.*', str)
    if matchObj:
        return True
    else:
        return False

def parseCsd(csdPath):
    pathList = string.split(csdPath, os.sep)
    pathLength = len(pathList)
    fileName = os.path.splitext(pathList[pathLength -1])[0]
    outputName = fileName + ".lua"

    targetCsbPathList = []
    isRecord = False
    for i in range(0, pathLength -1):
        if isRecord:
            targetCsbPathList.append(pathList[i])
        else:
            if "csui" == pathList[i]:
                isRecord = True
    sceneName = "/".join(targetCsbPathList)

    baseClassName = getViewType(fileName)
    targetLuaPath = os.path.join(LUA_SRC_PAHT, getCsdMatchLuaPath(targetCsbPathList, baseClassName == "Common"), outputName)
    info("target lua path: %s"%targetLuaPath)
    global SCRIPT_PATH
    tempOutputPath = os.path.join(SCRIPT_PATH, "generate")
    if not os.path.exists(tempOutputPath):
        os.mkdir(tempOutputPath)
    tempOutputFilePath = os.path.join(tempOutputPath, "temp.lua")

    xmlParse = ParseCsd(csdPath)
    varDict = xmlParse.getVarDict()
    template = CodeTemplate()
    csbBindingList = []
    otherList = []
    btnCellList = []

    fileData = None

    if baseClassName == "Common":
        fileData = template.getCommon(fileName)
    else:


        listviewFuncList = []
        buttonFuncList = []
        checkboxFuncList = []

        listViewOnCreate = []
        buttonOnCreate = []
        popupOnCreate = []
        checkboxOnCreate = []

        varKeys = varDict.keys()
        varKeys.sort()
        for k in varKeys:
            varType = varDict[k]
            csbBindingList.append(template.getCsdVarBinding(k, varType))
            if varType == "ListView" or varType == "ScrollView":
                listViewOnCreate.append(template.getListViewOnCreate(getVarNameFirstCharUp(k)))
                listviewFuncList.append(template.getListViewFunction(fileName, k))
            elif varType == "CheckBox":
                checkboxOnCreate.append(template.getCheckBoxOnCreate(k, getVarEventFunctionName(k)))
                checkboxFuncList.append(template.getCheckBoxFunction(fileName, getVarEventFunctionName(k)))
            elif varType == "CommonNormalSmallPop":
                popupOnCreate.append(template.getPopupOnCreate(k))
            elif matchButton(varType):
                if matchCommonButton(varType):
                    buttonOnCreate.append(template.getButtonOnCreate(k))
                btnCellList.append(template.getButtonBindCellString(k));
                buttonFuncList.append(template.getEmptyFunction(fileName, getVarEventFunctionName(k)))



        oncreateList = popupOnCreate + listViewOnCreate + buttonOnCreate + checkboxOnCreate

        if baseClassName == "PopupBase":
            otherList.append(template.getViewDefaultFunction(fileName, "\n".join(oncreateList)))
        elif baseClassName == "ListViewCellBase":
            otherList.append(template.getCellDefaultFunction(fileName, "\n".join(oncreateList)))
        else:
            otherList.append(template.getViewDefaultFunction(fileName, "\n".join(oncreateList)))

        otherList = otherList + buttonFuncList + checkboxFuncList + listviewFuncList

        fileData = template.getView(fileName, sceneName, "", "\n".join(csbBindingList),
                                template.getButtonBinding(btnCellList),  "\n".join(otherList))

    tempFileHead = None
    if os.path.exists(targetLuaPath):
        # error("%s is already exist"%targetLuaPath)
        tempFileHead = "## ERROR: %s is already exist \n"%targetLuaPath
    else:
        info("generate lua file : %s"%targetLuaPath)
        if targetCsbPathList[0] != "common":
            baseCheckPath = os.path.join(LUA_SRC_PAHT, "app", "scene", "view")
            for k in targetCsbPathList:
                baseCheckPath = os.path.join(baseCheckPath, k)
                if not os.path.exists(baseCheckPath):
                    info("mkdir %s"%baseCheckPath)
                    os.mkdir(baseCheckPath)

        pFile = open(targetLuaPath, "w")
        pFile.write(fileData)
        pFile.close()

    pFile = open(tempOutputFilePath, "w")
    if tempFileHead:
        pFile.write(tempFileHead)
    pFile.write("```lua\n")
    pFile.write(fileData)
    pFile.write("\n```")
    pFile.close()

def parseEvent(protoFilePath, dataName, matchStr):
    # print(matchStr)
    template = CodeTemplate()
    proto = ParseProto(protoFilePath)
    reParams = re.compile(r'\s*?([a-zA-Z0-9_\.]+)\s*?')
    reEvents = re.compile(r'.*[CScs]2[CScs]_(\w*).*')
    matchArr = reParams.findall(matchStr)
    if not matchArr:
        matchArr = []

    msgDict = {}
    for i in range(0, len(matchArr)):
        eventArr = reEvents.findall(matchArr[i])
        if eventArr and len(eventArr) == 1:
            if not msgDict.has_key(eventArr[0]):
                msgDict[eventArr[0]] = True
    functionList = []
    recvListen = []
    clearRecvListen = []
    for msgName in msgDict:
        requestDataName = "C2S_" + msgName
        responseDataName = "S2C_" + msgName

        requestData = proto.getData(requestDataName)
        responseData = proto.getData(responseDataName)
        if requestData:
            paramStr = ""
            paramNotes = ""
            paramListStr = ""

            paramList = []
            for k in requestData["vars"]["required"]:
                paramList.append(k)
            for k in requestData["vars"]["optional"]:
                paramList.append(k)
            for k in requestData["vars"]["repeated"]:
                paramList.append(k)
            paramStrList = []
            paramNotesList = []
            paramListStrList = []
            if len(paramList) <= 4:
                for k in paramList:
                    paramStrList.append(" " + k["name"])
                    paramNotesList.append("--	%s  %s"%(k["name"], k["note"]))
                    paramListStrList.append("		%s = %s," % (k["name"], k["name"]))
            paramStr = ",".join(paramStrList)
            paramNotes = "\n".join(paramNotesList)
            paramListStr = "\n".join(paramListStrList)

            functionList.append(template.getProtoRequest(requestData["note"], paramNotes, dataName,
                                                         msgName, paramStr, paramListStr))
        if responseData:
            recvListen.append(template.getProtoMsgRecvListen(msgName))
            clearRecvListen.append(template.getProtoClearMsgRecvListen(msgName))
            msgNameTempArr = re.findall('.*?([A-Z][^A-Z]*).*?', msgName)
            msgNameTempArr2 = []
            msgNameTempArr2.append("EVENT")
            for k in msgNameTempArr:
                msgNameTempArr2.append(k.upper())
            msgNameTempArr2.append("SUCCESS")

            checkDataList = []
            for k in responseData["vars"]["optional"]:
                if k["name"] != "ret":
                    checkDataList.append(template.getProtoCheckData(k["name"]))
            for k in responseData["vars"]["repeated"]:
                checkDataList.append(template.getProtoCheckData(k["name"]))

            functionList.append(template.getProtoResponse(responseData["note"], dataName,
                                                          msgName, "\n".join(checkDataList), "_".join(msgNameTempArr2)))

    fileData = template.getData(dataName, "\n".join(recvListen), "\n".join(clearRecvListen), "\n".join(functionList))

    tempFileHead = None
    dataFilePath = os.path.join(DATA_PATH, dataName + ".lua")
    if os.path.exists(dataFilePath):
        tempFileHead = "## ERROR: %s is already exist \n" % dataFilePath
    else:
        pFile = open(dataFilePath, "w")
        pFile.write(fileData)
        pFile.close()
    tempOutputPath = os.path.join(SCRIPT_PATH, "generate")
    if not os.path.exists(tempOutputPath):
        os.mkdir(tempOutputPath)
    tempOutputFilePath = os.path.join(tempOutputPath, "temp.lua")
    pFile = open(tempOutputFilePath, "w")
    if tempFileHead:
        pFile.write(tempFileHead)
    pFile.write("```lua\n")
    pFile.write(fileData)
    pFile.write("\n```")
    pFile.close()


def getProtoIDS(protoFilePath):
    proto = ParseProto(protoFilePath)
    idsList = []
    for k in proto.getIDS():
        idsList.append("/" + k)
    idsList.sort()
    tempOutputPath = os.path.join(SCRIPT_PATH, "generate")
    if not os.path.exists(tempOutputPath):
        os.mkdir(tempOutputPath)
    tempOutputFilePath = os.path.join(SCRIPT_PATH, "generate","ProtoIDS.json")
    pFile = open(tempOutputFilePath, "w")
    print (json.dump(idsList, pFile))

    # pFile.write(json.dump(idsList))
    pFile.close()

# UserData()
if FUNCTION_TYPE == 1:
    parseEvent(PROTOFILE_PATH, DATA_NAME, DATA_PARAM)
    info("success！")
elif FUNCTION_TYPE == 2:
    getProtoIDS(PROTOFILE_PATH)

    info("success！")
else:
    parseCsd(CSD_PATH)
    info("success！")
