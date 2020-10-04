var jsonBaseName = "";
var animationType = 0;

(function ($, window) {
    $(document).ready(function () {
        $("#header_menu_toolbar").buttonset();
    });

})(jQuery, window);



function parseJson(jsondata,filename)
{
	var obj = eval('(' + jsondata + ')');
	var rootList = [];
	var childList = [];
	var header = {};
	var indexId = 1;
	header.id = indexId;
	header.filename = filename;
	header.animationname = "";
	header.children = childList;
	var childHeader = {};
	
	indexId = indexId+10-1;
	var animationDict = obj.animations;
	 for ( var p in animationDict )
	 {
	 	indexId++;
	 	childHeader = {};
	 	childHeader.id = indexId;
	 	childHeader.filename = "";
	 	childHeader.animationname = p;
	 	childList.push(childHeader)
	 }


	rootList.push(header);

	$('#tt').treegrid('loadData',rootList);
	fillPropertyGrid();
}


var globleProperty = {};


function fillPropertyGrid()
{
	var Gridobj = {};
	var rows = [];

	globleProperty.mX = '0.5';
	globleProperty.mY = '0.5';
	globleProperty.mAX = '0.5';
	globleProperty.mAY = '0.5';
	globleProperty.mS = '1';

	globleProperty.eX = '0.5';
	globleProperty.eY = '0.5';
	globleProperty.eAX = '0.5';
	globleProperty.eAY = '0.5';
	globleProperty.eS = '1';
	
	Gridobj.rows = rows;
	rows.push({"name":"位置.X","value":"0.5","group":"模型属性","editor":"text"});
	rows.push({"name":"位置.Y","value":"0.5","group":"模型属性","editor":"text"});
	rows.push({"name":"锚点.X","value":"0.5","group":"模型属性","editor":"text"});
	rows.push({"name":"锚点.Y","value":"0.5","group":"模型属性","editor":"text"});
	rows.push({"name":"缩放","value":"1","group":"模型属性","editor":"text"});
	rows.push({"name":"位置.X","value":"0.5","group":"特效属性","editor":"text"});
	rows.push({"name":"位置.Y","value":"0.5","group":"特效属性","editor":"text"});
	rows.push({"name":"锚点.X","value":"0.5","group":"特效属性","editor":"text"});
	rows.push({"name":"锚点.Y","value":"0.5","group":"特效属性","editor":"text"});
	rows.push({"name":"缩放","value":"1","group":"特效属性","editor":"text"});
	Gridobj.total = rows.length;
	$('#pg').propertygrid('loadData',Gridobj);
}

function onPropertyGridEdit(rowIndex, rowData, changes)
{
	if(rowData.group == "模型属性")
	{
		if(rowData.name == "位置.X")
		{
			globleProperty.mX = rowData.value;
			debuger.call('run_code', ['0', '0',"aniLayer:setModulePos("+globleProperty.mX+","+globleProperty.mY+")"]);
		}
		else if(rowData.name == "位置.Y")
		{
			globleProperty.mY = rowData.value;
			debuger.call('run_code', ['0', '0',"aniLayer:setModulePos("+globleProperty.mX+","+globleProperty.mY+")"]);
		}
		else if(rowData.name == "锚点.X")
		{
			globleProperty.mAX = rowData.value;
			debuger.call('run_code', ['0', '0',"aniLayer:setModuleAnchorPoint("+globleProperty.mAX+","+globleProperty.mAY+")"]);
		}
		else if(rowData.name == "锚点.Y")
		{
			globleProperty.mAY = rowData.value;
			debuger.call('run_code', ['0', '0',"aniLayer:setModuleAnchorPoint("+globleProperty.mAX+","+globleProperty.mAY+")"]);
		}
		else if(rowData.name == "缩放")
		{
			globleProperty.mS = rowData.value;
			debuger.call('run_code', ['0', '0',"aniLayer:setModuleScale("+globleProperty.mS+")"]);
		}
	}
	else
	{
		if(rowData.name == "位置.X")
		{
			globleProperty.eX = rowData.value;
			debuger.call('run_code', ['0', '0',"aniLayer:setEffectPos("+globleProperty.eX+","+globleProperty.eY+")"]);
		}
		else if(rowData.name == "位置.Y")
		{
			globleProperty.eY = rowData.value;
			debuger.call('run_code', ['0', '0',"aniLayer:setEffectPos("+globleProperty.eX+","+globleProperty.eY+")"]);
		}
		else if(rowData.name == "锚点.X")
		{
			globleProperty.eAX = rowData.value;
			debuger.call('run_code', ['0', '0',"aniLayer:setEffectAnchorPoint("+globleProperty.eAX+","+globleProperty.eAY+")"]);
		}
		else if(rowData.name == "锚点.Y")
		{
			globleProperty.eAY = rowData.value;
			debuger.call('run_code', ['0', '0',"aniLayer:setEffectAnchorPoint("+globleProperty.eAX+","+globleProperty.eAY+")"]);
		}
		else if(rowData.name == "缩放")
		{
			globleProperty.eS = rowData.value;
			debuger.call('run_code', ['0', '0',"aniLayer:setEffectScale("+globleProperty.eS+")"]);
		}
	}

}

function onTreeTouch(row)
{
	if(row.animationname == null || row.animationname.length == 0) return;
	if(window.debuger)
	{
		if(animationType == 1)
			debuger.call('run_code', ['0', '0',"aniLayer:runAnimation('"+row.animationname+"')"]);
		if(animationType == 2)
			debuger.call('run_code', ['0', '0',"sceneLayer:runAnimation('"+row.animationname+"')"]);
	}
	
}

function onSkillTouch(row)
{
	if(row.skillid == null || row.skillid.length == 0) return;
	if(window.debuger)
	{
		if(animationType == 2)
			debuger.call('run_code', ['0', '0',"sceneLayer:playSkill("+row.skillid+")"]);
	}
}


function dlgSceneOK()
{
	$('#dlg').dialog('close')
	var sceneid  = $('#tbx_sceneid').textbox('getText')
	var actorid = $('#tbx_actor').textbox('getText')
	if(sceneid.length == 0) return;
	if(window.debuger)
	{
        debuger.call('run_code', ['0', '0',"require('utils.loader').simpleReload()"]);
		debuger.call('run_code', ['0', '0',"sceneLayer = utils.createMapScene("+sceneid+","+actorid+")"]);
		debuger.call('run_code', ['0', '0',"display.replaceScene(sceneLayer)"]);
	}	

	animationType = 2;

}

function laodScene(item)
{
	if(item.name == "scene")
	{
		$('#tbx_sceneid').textbox('setText','740001')
		$('#tbx_actor').textbox('setText','244104')
		$('#dlg').dialog('open')
	}
}

function createSpine(spineName)
{
	if(window.debuger)
	{
		var current = debuger.getCurrentPath();
		var spineJsonFile = spineName;
		var contentnow = debuger.getFileContent(spineJsonFile);
		parseJson(contentnow,spineName);
	}

}

function loadSkill(skillData)
{
	var obj = eval('(' + skillData + ')');
	var rootList = [];
	var indexId = 1;

	 for ( var p in obj )
	 {
	 	indexId++;
	 	childHeader = {};
	 	childHeader.id = indexId;
	 	childHeader.skillid = obj[p].skillid;
	 	childHeader.skillname = obj[p].skillname;
	 	rootList.push(childHeader)
	 }


	$('#skill').treegrid('loadData',rootList);
}

function filpHander(item)
{
	if(globleProperty.mX  == null) return;
	if(item.name=="yFilp")
	{
		if(animationType ==1)
			debuger.call('run_code', ['0', '0',"sceneLayer:setFlippedY()"]);
		if(animationType ==2)
			debuger.call('run_code', ['0', '0',"sceneLayer:setFlippedY()"]);
	}
	if(item.name=="xFilp")
	{
		if(animationType ==1)
			debuger.call('run_code', ['0', '0',"sceneLayer:setFlippedX()"]);
		if(animationType ==2)
			debuger.call('run_code', ['0', '0',"sceneLayer:setFlippedX()"]);
	}
	if(item.name=="yTxFilp")
	{
		if(animationType ==1)
			debuger.call('run_code', ['0', '0',"sceneLayer:setTxFlippedY()"]);
		if(animationType ==2)
			debuger.call('run_code', ['0', '0',"sceneLayer:setTxFlippedY()"]);
	}
	if(item.name=="xTxFilp")
	{
		if(animationType ==1)
			debuger.call('run_code', ['0', '0',"sceneLayer:setTxFlippedX()"]);
		if(animationType ==2)
			debuger.call('run_code', ['0', '0',"sceneLayer:setTxFlippedX()"]);
	}
}

function setCamera(item)
{
	if(globleProperty.mX  == null) return;
	if(item.name == "setCameraFrontBound") {
		debuger.call('run_code', ['0', '0',"sceneLayer:setCameraFrontBound()"]);
	} else if(item.name == "setCameraBackBound") {
		debuger.call('run_code', ['0', '0',"sceneLayer:setCameraBackBound()"]);
	}
}

function menuHandler(item)
{
	if(item.name == "openfile")
	{
		if(window.debuger)
		{
			var current = debuger.getCurrentPath();
			var content = debuger.openSelectFileDlg("open spine json","*.json");
			if(content.length == 0 ) return;
			jsonBaseName = debuger.getDirFileBaseName(content);
			var jsonPath = debuger.getDirFilePath(content);

			debuger.copyFileToPath(jsonPath+"/"+jsonBaseName+".json",current+"/"+jsonBaseName+".json",true);
			debuger.copyFileToPath(jsonPath+"/"+jsonBaseName+".atlas",current+"/"+jsonBaseName+".atlas",true);
			debuger.copyFileToPath(jsonPath+"/"+jsonBaseName+".png",current+"/"+jsonBaseName+".png",true);

			var contentnow = debuger.getFileContent(content);
			parseJson(contentnow,jsonBaseName+".json");

			//debuger.call('run_code', ['0', '0', "aniLayer:BuildModule('"+jsonBaseName+".json"+"','"+jsonBaseName+".atlas"+"')"]);
			debuger.call('run_code', ['0', '0',"aniLayer = require('app.scenes.AnimationLayer').new()"]);
			debuger.call('run_code', ['0', '0',"aniLayer:BuildModule('"+jsonBaseName+".json"+"','"+jsonBaseName+".atlas"+"')"]);

		}
		else
		{
			alert("window.debuger not exist");
		}
	}

	if(item.name == "loadBackPic")
	{
		if(globleProperty.mX  == null) return;
		if(window.debuger)
		{
			var current = debuger.getCurrentPath();
			var content = debuger.openSelectFileDlg("打开背景图片","*.jpg *.png");
			if(content.length == 0 ) return;
			picBaseName = debuger.getDirFileBaseName(content);
			var picPath = debuger.getDirFilePath(content);
			var picfix = "";
			if(content.substring(content.length-3) == "jpg")
				picfix = ".jpg";
			else
				picfix = ".png";

			debuger.copyFileToPath(picPath+"/"+picBaseName+picfix,current+"/"+picBaseName+picfix,true);

			debuger.call('run_code', ['0', '0',"aniLayer:setBackPic('"+picBaseName+picfix+"')"]);

		}
		else
		{
			alert("window.debuger not exist");
		}
	}

	animationType = 1;

}


