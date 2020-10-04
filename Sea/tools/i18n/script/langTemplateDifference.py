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
import lupa
import Tkinter, tkFileDialog, tkMessageBox
from lupa import LuaRuntime
lua = LuaRuntime()
# import sys

# reload(sys) 

# sys.setdefaultencoding('utf-8')

dirExec = os.path.dirname(utils.getExecPath())
luaPath = os.path.join(dirExec,'langTemplateDifference.lua')
resultPath = os.path.join(dirExec,'langTemplate.json')
csvPath = os.path.join(dirExec,'langTemplate.csv')



window = Tkinter.Tk()

window.title('对比LangTemplate.lua')
window.geometry('700x400')

l = Tkinter.Label(window, text='对比LangTemplate.lua生成差异文件', bg='gray', font=('Arial', 14), width=30, height=2)
l.pack()

frame = Tkinter.Frame(window)
frame.pack()
frame_l = Tkinter.Frame(frame)
frame_r = Tkinter.Frame(frame)
frame_l.pack(side='left')
frame_r.pack(side='right')

def chooseOldFile():
	path = tkFileDialog.askopenfilename()
	if len(path) > 0:
		global oldLangTemplate
		oldLangTemplate = path
		oldPathVar.set(oldLangTemplate)

def chooseNewFile():
	path = tkFileDialog.askopenfilename()
	if len(path) > 0:
		global newLangTemplate
		newLangTemplate = path
		newPathVar.set(newLangTemplate)

def chooseOutputFile():
	path = tkFileDialog.askdirectory()
	if len(path) > 0:
		global outputFile
		outputFile = os.path.join(path,'langTemplate.csv')
		outputVar.set(outputFile)

oldText = Tkinter.Label(frame_l, text='设置老版本LangTemplate.lua路径',width=40, height=1, font=('Arial', 10))
oldText.pack()
oldLangTemplate = ""
oldBtn = Tkinter.Button(frame_l, text='old', font=('Arial', 8), width=15, height=1, command=chooseOldFile)
oldBtn.pack()
oldPathVar = Tkinter.StringVar()
oldPath = Tkinter.Label(frame_l, text='', font=('Arial', 8),wraplength = 250, height=3,  textvariable=oldPathVar)
oldPath.pack()

newText = Tkinter.Label(frame_r, text='设置新版本LangTemplate.lua路径',width=40, height=1, font=('Arial', 10))
newText.pack()
newLangTemplate = ""
newBtn = Tkinter.Button(frame_r, text='new', font=('Arial', 8), width=15, height=1, command=chooseNewFile)
newBtn.pack()
newPathVar = Tkinter.StringVar()
newPath = Tkinter.Label(frame_r, text='',  font=('Arial', 8), wraplength = 250, height=3, textvariable=newPathVar)
newPath.pack()

ouotText = Tkinter.Label(window, text='设置输出目录', font=('Arial', 10))
ouotText.pack()
outputFile = ""
outputBtn = Tkinter.Button(window, text='set output folder', font=('Arial', 8), width=25, height=1, command=chooseOutputFile)
outputBtn.pack()
outputVar = Tkinter.StringVar()
outputPath = Tkinter.Label(window, text='',  font=('Arial', 8), textvariable=outputVar)
outputPath.pack()

def pyCallback(resultTab):
	csvTab = []
	for key,value in resultTab.items():
		csvTab.append([key,value.encode('utf-8')])
	csvHead = ["key", "value"]
	utils.writeCsvFile(csvTab, outputFile, csvHead)
	tkMessageBox.showinfo('Success', 'Success！', parent=window)
	window.destroy()

def onStartBtn():
	print "outputFile----"+outputFile
	print "oldLangTemplate----"+oldLangTemplate
	print "newLangTemplate----"+newLangTemplate
	if len(oldLangTemplate) == 0:
		tkMessageBox.showerror('error', '请设置老版本LangTemplate.lua路径', parent=window)
		return
	if len(newLangTemplate) == 0:
		tkMessageBox.showerror('error', '请设置新版本LangTemplate.lua路径', parent=window)
		return
	if len(outputFile) == 0:
		tkMessageBox.showerror('error', '请设置输出目录', parent=window)
		return

	f = open(luaPath, "rU")
	lines = f.readlines()
	f.close()

	luaStr = "\
	function(f, str,resultPath,langPathOld,langPathNew) \
		local tab = assert(load(str)) \
		tab = tab() \
		f(tab(resultPath,langPathOld,langPathNew)) \
	end \
	"

	lua_func = lua.eval(luaStr)
	lua_func(pyCallback, ''.join(lines),resultPath,oldLangTemplate,newLangTemplate)


startBtn = Tkinter.Button(window, text='Start', font=('Arial', 16), width=20, height=1, command=onStartBtn)
startBtn.pack(pady=30)




window.mainloop()


