#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
import os.path
import shutil
from  xml.dom import  minidom


def get_xmlnode(node,name):
	return node.getElementsByTagName(name)
	

def createNode(f,xml_node,nodeName):
	node_ele=doc_xml.createElement(nodeName)
	node=xml_node.appendChild(node_ele)
	node.setAttribute("Name",f)


def createProjectNode(f,newdir,xml_node):
	file_ele=doc_xml.createElement("Project")
	csd_file=open(newdir,"r")
	csd_doc=minidom.parse(csd_file)
	csd_type=csd_doc.documentElement.getElementsByTagName("PropertyGroup")[0].getAttribute("Type")
	csd_file.close()
	file_node=xml_node.appendChild(file_ele)
	file_node.setAttribute("Name",f)
	file_node.setAttribute("Type",csd_type)


def createPlistNode(f,newdir,xml_node):
	#<PlistImageFolder PListFile="number_effect_green.plist" Name=".number_effect_green_PList.Dir">
	#<PlistImageFile Name="szp_43.png" Key="szp_43.png" />
	plist_ele=doc_xml.createElement("PlistImageFolder")
	plist_node=xml_node.appendChild(plist_ele)
	plist_node.setAttribute("PListFile",f)
	plist_node.setAttribute("Name","."+os.path.splitext(f)[0]+"_PList.Dir")
	plist_file=open(newdir,"r")
	plist_doc=minidom.parse(plist_file)
	plist_file.close()
	plist_root_node=plist_doc.getElementsByTagName("plist")[0]
	dict1=plist_root_node.getElementsByTagName("dict")[0]
	dict2=dict1.getElementsByTagName("dict")[0]
	childs=dict2.getElementsByTagName("key")
	for node in childs:
		key_value=node.childNodes[0].data
		if len(key_value.split(".png"))>1:
			key_ele=doc_xml.createElement("PlistImageFile")
			key_node=plist_node.appendChild(key_ele)
			key_node.setAttribute("Name",key_value)
			key_node.setAttribute("Key",key_value)


def getAllFiles(rootDir,xml_node,ff):
	dirs=os.listdir(rootDir)
	for f in dirs:
		newdir = os.path.join(rootDir, f)
		if os.path.isdir(newdir):
			print f
			if len(f.split("."))==1:
				if ff.has_key(f):
					continue

				folder_ele=doc_xml.createElement("Folder")
				folder_node=xml_node.appendChild(folder_ele)
				folder_node.setAttribute("Name",f)
				getAllFiles(newdir,folder_node,ff)
				if not folder_node.hasChildNodes():
					xml_node.removeChild(folder_node)
		else:
			ext=os.path.splitext(f)[1]
			ext=ext.lower()
			file_ele=""
			if  ext == '.png' or ext == ".jpg":
				createNode(f,xml_node,"Image")
			elif ext == ".mp3":
				createNode(f,xml_node,"Audio")
			elif ext == ".ttf":
				createNode(f,xml_node,"TTF")
			elif ext == ".fnt":
				createNode(f,xml_node,"Fnt")
			elif ext == ".csd":
				createProjectNode(f,newdir,xml_node)
			elif ext == ".plist":
				print f
				createPlistNode(f,newdir,xml_node)


def getCocosFiles(rootDir, xml_node):
	folder_ele=doc_xml.createElement("Folder")
	folder_node=xml_node.appendChild(folder_ele)
	folder_node.setAttribute("Name",os.path.join("..", "res"))
	getAllFiles(rootDir,folder_node)


root_path 			= os.getcwd()
cocos_dir 			= os.path.join(root_path, "cocosstudio")
ccs_path			= os.path.join(root_path, "cocos.ccs")
template_ccs_path 	= os.path.join(cocos_dir, "template.xml")
cfg_path 			= os.path.join(root_path, "cocos.cfg")
template_cfg_path 	= os.path.join(cocos_dir, "template.cfg")
print(root_path)

ccs_file = open(ccs_path,"w")
ccs_temp = open(template_ccs_path)
doc_xml = minidom.parse(ccs_temp)
ccs_temp.close()
root_node = get_xmlnode(doc_xml.documentElement,"RootFolder")[0]

ff = {"particle":True}
getAllFiles(cocos_dir,root_node,ff)

doc_xml.writexml(ccs_file, "\t", "\t", "\n", "utf-8")
ccs_file.close()

shutil.copyfile(template_cfg_path, cfg_path) 











