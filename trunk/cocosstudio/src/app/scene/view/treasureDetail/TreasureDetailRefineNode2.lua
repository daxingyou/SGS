--
-- Author: Liangxu
-- Date: 2017-05-09 11:15:09
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local TreasureDetailRefineNode = class("TreasureDetailRefineNode", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local UIHelper = require("yoka.utils.UIHelper")
local TreasureTrainHelper = require("app.scene.view.treasureTrain.TreasureTrainHelper")
local TreasureConst = require("app.const.TreasureConst")
local RedPointHelper = require("app.data.RedPointHelper")

function TreasureDetailRefineNode:ctor(treasureData, rangeType)
	self._treasureData = treasureData
	self._rangeType = rangeType

	local resource = {
		file = Path.getCSB("TreasureDetailDynamicModule2", "treasure"),
		binding = {

		},
	}
	TreasureDetailRefineNode.super.ctor(self, resource)
end

function TreasureDetailRefineNode:onCreate()
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
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)
end

function TreasureDetailRefineNode:_createTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg2", "common"))
	title:setFontSize(22)
	title:setTitle(Lang.get("treasure_detail_title_refine"))
	local widget = ccui.Widget:create()
	local titleSize = cc.size(self._listView:getContentSize().width, 50)
	widget:setContentSize(titleSize)
	title:setPosition(titleSize.width / 2, 30)
	widget:addChild(title)

	return widget
end

function TreasureDetailRefineNode:_createLevelDes()
	local widget = ccui.Widget:create()

	local node = CSHelper.loadResourceNode(Path.getCSB("CommonDesValue", "common"))
	local des = Lang.get("treasure_detail_refine_level")
	des = string.gsub(des, ":", ": ")  
	local value = self._treasureData:getRefine_level()
	local max = self._treasureData:getMaxRefineLevel()
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

function TreasureDetailRefineNode:_addAttrDes()
	local attrInfo = UserDataHelper.getTreasureRefineAttr(self._treasureData)
	for k, value in pairs(attrInfo) do
		local widget = ccui.Widget:create()
		local name, value = TextHelper.getAttrBasicText(k, value)
		name = TextHelper.expandTextByLen(name, 4)
		local node = CSHelper.loadResourceNode(Path.getCSB("CommonDesValue", "common"))
		-- i18n change punc
		if not Lang.checkLang(Lang.CN) then
			node:updateUI(name..":", value)
		else
			node:updateUI(name.."：", value)
		end
		node:setPosition(10, 18)
		widget:addChild(node)
		node:setFontSize(16)
		ccui.Helper:seekNodeByName(node, "TextDes"):setFontSize(18)
		widget:setContentSize(cc.size(self._listView:getContentSize().width, 27))
		self._listView:pushBackCustomItem(widget)
	end
end

function TreasureDetailRefineNode:_createMasterInfo()
	local pos = self._treasureData:getPos()
	local info = UserDataHelper.getMasterTreasureRefineInfo(pos)
	local level = info.curMasterLevel
	if level <= 0 then
		return nil
	end

	local widget = ccui.Widget:create()
	local master = CSHelper.loadResourceNode(Path.getCSB("CommonMasterInfoNode", "common"))
	local title = Lang.get("treasure_datail_refine_master", {level = level})
	local attrInfo = info.curAttr
	local line = master:updateUI(title, attrInfo)
	ccui.Helper:seekNodeByName(master, "TextName"):setFontSize(18)
	ccui.Helper:seekNodeByName(master, "TextName"):setPositionX(10)  
	local posTab = {{10, 55}, {10, 25}, {10, -5}, {10, -35}}
	for i = 1, 4 do
		local attar = ccui.Helper:seekNodeByName(master, "FileNodeAttr"..i)
		--ttar:setPositionX(attar:getPositionX()-14)  
		attar:setPosition(posTab[i][1], posTab[i][2]) 
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


 

return TreasureDetailRefineNode