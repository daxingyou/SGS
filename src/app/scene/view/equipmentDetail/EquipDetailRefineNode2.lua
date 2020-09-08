--
-- Author: Liangxu
-- Date: 2017-04-12 17:40:19
-- 装备详情 精炼模块
local ListViewCellBase = require("app.ui.ListViewCellBase")
local EquipDetailRefineNode = class("EquipDetailRefineNode", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local UIHelper = require("yoka.utils.UIHelper")
local EquipTrainHelper = require("app.scene.view.equipTrain.EquipTrainHelper")
local EquipConst = require("app.const.EquipConst")
local ParameterIDConst = require("app.const.ParameterIDConst")

function EquipDetailRefineNode:ctor(equipData, rangeType, isFromLimitUp)
	self._equipData = equipData
	self._isFromLimitUp = isFromLimitUp or false
	self._rangeType = rangeType or EquipConst.EQUIP_RANGE_TYPE_1

	local resource = {
		file = Path.getCSB("EquipDetailDynamicModule2", "equipment"),
		binding = {}
	}
	EquipDetailRefineNode.super.ctor(self, resource)
end

function EquipDetailRefineNode:onCreate()
	local title = self:_createTitle()
	self._listView:pushBackCustomItem(title)

	local level = self:_createLevelDes()
	self._listView:pushBackCustomItem(level)

	self:_addAttrDes()

	local master, line = self:_createMasterInfo()
	if master then
		self._listView:pushBackCustomItem(master)
	end

	self._listView:doLayout()
	local contentSize = self._listView:getInnerContainerSize()
	contentSize.height = contentSize.height  
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)
end

function EquipDetailRefineNode:_createTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg2", "common"))
	title:setFontSize(22)
	title:setTitle(Lang.get("equipment_detail_title_refine"))
	local widget = ccui.Widget:create()
	local titleSize = cc.size(self._listView:getContentSize().width, 50)
	widget:setContentSize(titleSize)
	title:setPosition(titleSize.width / 2, 30)
	widget:addChild(title)

	return widget
end

function EquipDetailRefineNode:_createLevelDes()
	local widget = ccui.Widget:create()

	local node = CSHelper.loadResourceNode(Path.getCSB("CommonDesValue", "common"))
	local des = Lang.get("equipment_detail_refine_level")
	des = string.gsub(des, ":", ": ")  
	local value = self._equipData:getR_level()
	local ratio = require("app.config.parameter").get(ParameterIDConst.MAX_EQUIPMENT_REFINE_LEVEL).content / 1000
	local max = math.floor(G_UserData:getBase():getLevel() * ratio)
	local color = value < max and Colors.BRIGHT_BG_ONE or Colors.BRIGHT_BG_GREEN

	node:setFontSize(16)
	ccui.Helper:seekNodeByName(node, "TextDes"):setFontSize(18)
	node:updateUI(des, value, max)
	node:setValueColor(color)
	node:setMaxColor(color)
	node:setPosition(10, 20)
	widget:addChild(node)
	widget:setContentSize(cc.size(self._listView:getContentSize().width, 30))

	return widget
end

function EquipDetailRefineNode:_addAttrDes()
	local attrInfo = UserDataHelper.getEquipRefineAttr(self._equipData)
	for k, value in pairs(attrInfo) do
		local widget = ccui.Widget:create()
		local name, value = TextHelper.getAttrBasicText(k, value)
		name = TextHelper.expandTextByLen(name, 4)
		local node = CSHelper.loadResourceNode(Path.getCSB("CommonDesValue", "common"))
		node:setFontSize(20)
		-- i18n change punc
		if not Lang.checkLang(Lang.CN) then
			node:updateUI(name..":", value)
		else
			node:updateUI(name.."：", value)
		end
		node:setPosition(10, 20)
		widget:addChild(node)
		widget:setContentSize(cc.size(self._listView:getContentSize().width, 30))
		node:setFontSize(16)
		ccui.Helper:seekNodeByName(node, "TextDes"):setFontSize(18)
		self._listView:pushBackCustomItem(widget)
	end
end

function EquipDetailRefineNode:_createMasterInfo()
	local pos = self._equipData:getPos()
	local info = UserDataHelper.getMasterEquipRefineInfo(pos)
	local level = info.curMasterLevel
	if level <= 0 then
		return nil
	end

	local widget = ccui.Widget:create()
	local master = CSHelper.loadResourceNode(Path.getCSB("CommonMasterInfoNode", "common"))
	local title = Lang.get("equipment_datail_refine_master", {level = level})
	local attrInfo = info.curAttr
	local line = master:updateUI(title, attrInfo)
	ccui.Helper:seekNodeByName(master, "TextName"):setFontSize(18)
	ccui.Helper:seekNodeByName(master, "TextName"):setPositionX(10)  

	for i = 1, 4 do
		local attar = ccui.Helper:seekNodeByName(master, "FileNodeAttr"..i)
		attar:setPositionX(10)  
		attar:setFontSize(18)
		ccui.Helper:seekNodeByName(attar, "TextValue"):setFontSize(16)
	end

	local pos = {
		[1] = {26, 55, 70-5},  -- FileNodeAttr1  TextName  _panelBg
		[2] = {55, 25, 85, 95},
		[3] = {85, 55, 25, 115, 130-5},
		[4] = {115, 85, 55, 25, 145, 160}
	}

	local desInfo = TextHelper.getAttrInfoBySort(attrInfo)
	local lineNum = math.ceil(#desInfo)
	self._panelBg = ccui.Helper:seekNodeByName(master, "PanelBg")
	
	self._panelBg:setContentSize(cc.size(326, pos[lineNum][lineNum+2]))
	ccui.Helper:seekNodeByName(master, "TextName"):setPositionY(pos[lineNum][lineNum+1])  
	for index = 1, lineNum do
		ccui.Helper:seekNodeByName(master, "FileNodeAttr"..index):setPositionY(pos[lineNum][index])  
	end

	-- if lineNum == 1 then 
	-- 	self._panelBg:setContentSize(cc.size(326, 70))
	-- 	ccui.Helper:seekNodeByName(master, "TextName"):setPositionY(55)  
	-- 	ccui.Helper:seekNodeByName(master, "FileNodeAttr1"):setPositionY(26)  
	-- elseif lineNum == 2 then 
	-- 	self._panelBg:setContentSize(cc.size(326, 100-5))
	-- 	ccui.Helper:seekNodeByName(master, "TextName"):setPositionY(85)  
	-- 	ccui.Helper:seekNodeByName(master, "FileNodeAttr1"):setPositionY(55)  
	-- 	ccui.Helper:seekNodeByName(master, "FileNodeAttr2"):setPositionY(25)  
	-- elseif lineNum == 3 then
	-- 	self._panelBg:setContentSize(cc.size(326, 130))
	-- 	ccui.Helper:seekNodeByName(master, "TextName"):setPositionY(115)  
	-- 	ccui.Helper:seekNodeByName(master, "FileNodeAttr1"):setPositionY(85)  
	-- 	ccui.Helper:seekNodeByName(master, "FileNodeAttr2"):setPositionY(55)  
	-- 	ccui.Helper:seekNodeByName(master, "FileNodeAttr3"):setPositionY(25)  
	-- elseif lineNum == 4 then
	-- 	self._panelBg:setContentSize(cc.size(326, 160))
	-- 	ccui.Helper:seekNodeByName(master, "TextName"):setPositionY(145)  
	-- 	ccui.Helper:seekNodeByName(master, "FileNodeAttr1"):setPositionY(115)  
	-- 	ccui.Helper:seekNodeByName(master, "FileNodeAttr2"):setPositionY(85)  
	-- 	ccui.Helper:seekNodeByName(master, "FileNodeAttr3"):setPositionY(55)  
	-- 	ccui.Helper:seekNodeByName(master, "FileNodeAttr4"):setPositionY(25)  
	-- end


	widget:addChild(master)  
	local size = master:getContentSize()  
	widget:setContentSize(cc.size(size.width, self._panelBg:getContentSize().height))
	return widget, line
end
  
 

return EquipDetailRefineNode
