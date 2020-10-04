#!/usr/bin/env python
# -*- coding: utf-8 -*-

import utils
import os
import sys
import string
import re
import json
from xml.etree import ElementTree as ET
from xml.dom import minidom

class UserData(object):
    _instance = None
    _luaComponentDict = {}
    _protoDict = {}

    def __new__(cls, *args, **kw):
        if not cls._instance:
            cls._instance = super(UserData, cls).__new__(cls, *args, **kw)
            # cls._instance._parseLuaComponent()
        return cls._instance

    def _matchLuaComponent(self, str):
        matchObj = re.match(
            r'.*cc\.register\s*\(\s*"\s*(\w*)\s*"\s*,\s*import\s*\(\s*"\s*\.\s*(\w*)\s*".*', str)
        if matchObj:
            groups = matchObj.groups()
            if groups and len(groups) >= 2:
                self._luaComponentDict[groups[0]] = groups[1]

    # def _parseLuaComponent(self):
    #     global LUA_COMPONENT_PAHT
    #     # print LUA_COMPONENT_PAHT
    #     pFile = open(LUA_COMPONENT_PAHT)
    #     lines = pFile.readlines()
    #     for line in lines:
    #         self._matchLuaComponent(line)
    #     pFile.close()

    def getComponentType(self, tp):
        if self._luaComponentDict.has_key(tp):
            return self._luaComponentDict[tp]
        else:
            return ""
            #error("can not find lua component %s"%tp)

# csd 解析
class ParseCsd(object):
    def __init__(self):
        super(ParseCsd, self).__init__()
        self.__nodeList = []

    def load(self,csd_path):
        self.__csdPath = csd_path
        self.__tree = ET.parse(csd_path)
        self.__rootNode = self.__tree.getroot()
        self.__nodeList = []
        self.__nodeMap = {}
        self._findAllNode(self.__rootNode, self.__nodeList,"")

    def _findAllNode(self, parentNode, nodeArr, path):
        nodeList = parentNode.findall("./AbstractNodeData")
        _pathMap = self.__nodeMap

        for node in nodeList:
            if node.attrib.has_key("Name"):
                _pathMap[node] = str(path) + "/" + str(node.attrib["Name"])
            else:
                _pathMap[node] = str(path) + "/" + ""
            nodeArr.append(node)
        for node in list(parentNode):
            if self.__nodeMap.has_key(parentNode):
               _path = self.__nodeMap[parentNode]
            else:
                _path = ""  
            self._findAllNode(node, nodeArr, _path)

    def getNodePath(self, name):
        node = self.getNode(name)
        return self.__nodeMap[node]

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
                    utils.error(
                        "%s: can not find FileData node attrib Path" % self.__csdPath)
            else:
                utils.error("%s: can not find FileData node" % self.__csdPath)
        return typeName

    def _isTextNode(self, ctype):
        return ctype == "TextObjectData"
        # return ctype == "TextObjectData" or ctype == "ButtonObjectData"

    def _getNodeText(self, node):
        typeName = node.attrib["ctype"]
        isTextNode = self._isTextNode(typeName)
        text = ""
        if not isTextNode:
            return ""
        if typeName == "TextObjectData" and node.attrib["LabelText"]:
            text = node.attrib["LabelText"]
        # elif typeName == "ButtonObjectData" and node.attrib["ButtonText"] != None:
        #     text = node.attrib["ButtonText"]
        return text

    def _setNodeText(self, node, text):
        ctype = node.attrib["ctype"]
        isTextNode = self._isTextNode(node.attrib["ctype"])
        if not isTextNode:
            return
        if ctype == "TextObjectData" and node.attrib["LabelText"]:
            # node.attrib["LabelText"] = text
            node.set("LabelText", text)
        # elif typeName == "ButtonObjectData" and node.attrib["ButtonText"] != None:
        #     node.attrib["ButtonText"] = text

    def getNode(self, name, nodePath=None):
        for node in self.__nodeList:
            if node.attrib.has_key("Name") and str(node.attrib["Name"]) == str(name):
                if nodePath:
                    if self.__nodeMap[node] == nodePath:
                        return node
                else:    
                    return node
        return None

    def _getNodeList(self, name):
        ret = []
        for node in self.__nodeList:
            if node.attrib.has_key("Name") and str(node.attrib["Name"]) == str(name):
                ret.append(node)
                # return node
        _len = len(ret)        
        if _len == 0:
            return None 
        if _len > 0:
            return ret

    def getNodeText(self, name, nodePath=None):
        node = self.getNode(name, nodePath)
        if node != None:
            return self._getNodeText(node)
        else:
            # utils.info("%s: getNodeText() can not find FileData node" % name)
            utils.error("%s: getNodeText() can not find FileData node" % name)
            return ""

    def setNodeText(self, nodeName, nodeText, nodePath=None):
        # nodeList = self._getNodeList(nodeName)
        # if nodeList != None:
        #     print(self.__csdPath + "   nodename:" + nodeName + "  len: " + str( len(nodeList) ) )
        #     for node in nodeList:
        #         self._setNodeText(node, nodeText)
        node = self.getNode(nodeName, nodePath)
        if node != None :
            self._setNodeText(node, nodeText)
        else:
            # utils.info("%s: can not find FileData node" % nodeName)
            utils.error("%s: can not find FileData node" % nodeName)
            pass

    def getXmlTree(self):
        return self.__tree

    def save(self, path=None):
        if path == None or path == "":
            path = self.__csdPath

        self.__tree.write(path)

    def getTextDict(self):
        textArr = []
        for node in self.__nodeList:
            if node.attrib.has_key("Name"):
                name = node.attrib["Name"]
                typeName = node.attrib["ctype"]
                if name != None and len(name) >= 1 and self._isTextNode(typeName):
                    nodeText = self._getNodeText(node)
                    if len(nodeText) > 0 and utils.isMathChinese(nodeText) == True and nodeText.encode('UTF-8').isdigit() != True:
                        textArr.append({"name": name, "text": nodeText, "path": self.__nodeMap[node]})
                        # textArr.append({name: nodeText})
            else:
                utils.error("%s: can not find node attrib Name" %
                            self.__csdPath)
        return textArr

    def getVarDict(self):
        varDict = {}
        for node in self.__nodeList:
            if node.attrib.has_key("Name"):
                name = node.attrib["Name"]
                if name != None and len(name) >= 1 and self._isCsbVar(name):
                    if varDict.has_key(name):
                        utils.error("%s: has two equal var name: %s" %
                                    (self.__csdPath, name))
                    else:
                        varDict[name] = self._getTypeName(node)
            else:
                utils.error("%s: can not find node attrib Name" %
                            self.__csdPath)
        return varDict

