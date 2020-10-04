#!/usr/bin/python
# -*- coding: utf-8 -*-

import os,sys,math,json

from PIL import Image
SCRIPT_PATH = os.path.abspath(os.path.split(sys.argv[0])[0]);
if len(sys.argv) < 2:
    print "input image path"

def splitImage(srcImage):
    outputDir = os.path.dirname(srcImage)
    baseNameArray = os.path.splitext(os.path.basename(srcImage))
    baseName = baseNameArray[0]
    extName = baseNameArray[1]
    print(outputDir, baseName, extName)

    img = Image.open(srcImage)
    print img.size
    width = img.size[0]
    height = img.size[1]
    if width < 1024 and height < 1024:
        return

    row = int(math.ceil(width/1024.0))
    column = int(math.ceil(height/1024.0))
    maxIndex = int(row * column)
    
    jsonDict = {}
    jsonDict["width"] = width
    jsonDict["height"] = height
    jsonDict["row"] = row
    jsonDict["column"] = column
    jsonDict["children"] = []

    for i in range(maxIndex):
        x = int(i % row)
        y = int(math.floor(i/row))
        left = x * 1024
        top = y * 1024
        right = left + 1024
        bottom = top + 1024
        if right > width:
            right = width
        if bottom > height:
            bottom = height

        temp = img.crop((left, top, right, bottom))
        imageName = "%s___%d%s"%(baseName, i, extName)
        print(imageName)
        outputName = os.path.join(outputDir, imageName)
        temp.save(outputName)
        jsonDict["children"].append({
            "name":imageName,
            "x":left,
            "y":height - bottom
        })
    jsonStr = json.dumps(jsonDict)
    pFile = open(os.path.join(outputDir, baseName + ".json"), "w")
    pFile.write(jsonStr)
    pFile.close()

argvNum = len(sys.argv)

for i in range(1, argvNum):
    splitImage(sys.argv[i])

