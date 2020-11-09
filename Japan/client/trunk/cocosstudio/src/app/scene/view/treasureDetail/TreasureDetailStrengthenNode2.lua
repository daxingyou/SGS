--
-- Author: Liangxu
-- Date: 2017-05-09 11:13:39
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local TreasureDetailStrengthenNode = class("TreasureDetailStrengthenNode", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local UIHelper = require("yoka.utils.UIHelper")
local TreasureTrainHelper = require("app.scene.view.treasureTrain.TreasureTrainHelper")
local TreasureConst = require("app.const.TreasureConst")
local ParameterIDConst = require("app.const.ParameterIDConst")

function TreasureDetailStrengthenNode:ctor(treasureData, rangeType)
	self._treasureData = treasureData
	self._rangeType = rangeType

	local resource = {
		file = Path.getCSB("TreasureDetailDynamicModule2", "treasure"),
		binding = {

		},
	}
	self:setName("TreasureDetailStrengthenNode")
	TreasureDetailStrengthenNode.super.ctor(self, resource)
end

function TreasureDetailStrengthenNode:onCreate()
	local equipTitle = self:_createEquipTitle()
	self._listView:pushBackCustomItem(equipTitle)

	local title = self:_createTitle()
	self._listView:pushBackCustomItem(title)

	local level = self:_createLevelDes()
	self._listView:pushBackCustomItem(level)

	local attr = self:_createAttrDes()
	self._listView:pushBackCustomItem(attr)

	local master, line = self:_createMasterDes()
	if master then
		self._listView:pushBackCustomItem(master)
	end

	self._listView:doLayout()
	local contentSize = self._listView:getInnerContainerSize()
	contentSize.height = contentSize.height 
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)
end

function TreasureDetailStrengthenNode:_createEquipTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitle2", "common"))
	-- title:setFontSize(18)
    -- ccui.Helper:seekNodeByName(title, "ImageBase"):loadTexture( Path.getTextTeam("img_com_board_zrd4") )
	-- ccui.Helper:seekNodeByName(title, "ImageBase"):setContentSize(cc.size(self._listView:getContentSize().width, 40))
	-- --名字
	-- local treasureData = self._treasureData
	-- local treasureBaseId = treasureData:getBase_id()
	-- local TypeConvertHelper = require("app.utils.TypeConvertHelper")
	-- local treasureParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_TREASURE, treasureBaseId)
	-- local treasureName = treasureParam.name
 
	-- local rLevel = treasureData:getRefine_level()
	-- if rLevel > 0 then
	-- 	treasureName = treasureName.."+"..rLevel
	-- end
	-- title:setTitle(treasureName) 
	-- title:setTitleColor(treasureParam.icon_color)  
	title:setName(2)
	
	local widget = ccui.Widget:create()
	local titleSize = cc.size(self._listView:getContentSize().width, 40)  
	widget:setContentSize(titleSize)
	title:setPosition(titleSize.width / 2, 20)
	widget:addChild(title)
	return widget
end

function TreasureDetailStrengthenNode:_createTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg2", "common"))
	title:setFontSize(22)
	title:setTitle(Lang.get("treasure_detail_title_strengthen"))
	local widget = ccui.Widget:create()
	local titleSize = cc.size(self._listView:getContentSize().width, 50)
	widget:setContentSize(titleSize)
	title:setPosition(titleSize.width / 2, 30)
	widget:addChild(title)

	return widget
end

function TreasureDetailStrengthenNode:_createLevelDes()
	local widget = ccui.Widget:create()

	local node = CSHelper.loadResourceNode(Path.getCSB("CommonDesValue", "common"))
	local des = Lang.get("treasure_detail_strengthen_level")
	des = string.gsub(des, ":", " : ")  
	local value = self._treasureData:getLevel()
	local max = self._treasureData:getMaxStrLevel()
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

function TreasureDetailStrengthenNode:_createAttrDes()
	local widget = ccui.Widget:create()

	local attrInfo = UserDataHelper.getTreasureStrengthenAttr(self._treasureData) or {}
	for k, value in pairs(attrInfo) do
		local name, value = TextHelper.getAttrBasicText(k, value)
		name = TextHelper.expandTextByLen(name, 4)
		local node = CSHelper.loadResourceNode(Path.getCSB("CommonDesValue", "common"))
 
		-- i18n change punc
		if not Lang.checkLang(Lang.CN) then
			node:updateUI(name..": ", value)
		else
			node:updateUI(name.."：", value)
		end
		node:setPosition(10, 20)
		widget:addChild(node)
		node:setFontSize(16)
		ccui.Helper:seekNodeByName(node, "TextDes"):setFontSize(18)
		break
	end
	widget:setContentSize(cc.size(self._listView:getContentSize().width, 30))
	return widget
end

function TreasureDetailStrengthenNode:_createMasterDes()
	local pos = self._treasureData:getPos()
	local info = UserDataHelper.getMasterTreasureUpgradeInfo(pos)
	local level = info.curMasterLevel
	if level <= 0 then
		return nil
	end

	local widget = ccui.Widget:create()
	local master = CSHelper.loadResourceNode(Path.getCSB("CommonMasterInfoNode", "common"))
	local title = Lang.get("treasure_datail_strengthen_master", {level = level})
	local attrInfo = info.curAttr
	local line = master:updateUI(title, attrInfo)
	widget:addChild(master)
	local size = master:getContentSize()
	widget:setContentSize(size)

	for i = 1, 4 do
		local attar = ccui.Helper:seekNodeByName(master, "FileNodeAttr"..i)
		attar:setDesColor(Colors.BRIGHT_BG_GREEN)
		attar:setPositionX(attar:getPositionX()-14)  
		attar:setFontSize(18)
		ccui.Helper:seekNodeByName(attar, "TextValue"):setFontSize(16)
	end
	ccui.Helper:seekNodeByName(master, "TextName"):setPositionX(10)
	ccui.Helper:seekNodeByName(master, "TextName"):setFontSize(18)
	return widget, line
end 

return TreasureDetailStrengthenNode