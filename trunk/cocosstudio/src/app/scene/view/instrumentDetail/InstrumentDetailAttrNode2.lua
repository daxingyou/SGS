--
-- Author: Liangxu
-- Date: 2017-9-16 14:13:03
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local InstrumentDetailAttrNode = class("InstrumentDetailAttrNode", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local InstrumentTrainHelper = require("app.scene.view.instrumentTrain.InstrumentTrainHelper")
local AttributeConst = require("app.const.AttributeConst")
local InstrumentConst = require("app.const.InstrumentConst")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")

function InstrumentDetailAttrNode:ctor(instrumentData, rangeType)
	self._instrumentData = instrumentData
	self._rangeType = rangeType

	local resource = {
		file = Path.getCSB("InstrumentDetailAttrNode2", "instrument"),
		binding = { 
		},
	}
	InstrumentDetailAttrNode.super.ctor(self, resource)
end

function InstrumentDetailAttrNode:onCreate()
	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)
	self._titleName:setName(3)
	self._nodeTitle:setFontSize(22)
	self._nodeTitle:setTitle(Lang.get("instrument_detail_title_attr"))

	local des = Lang.get("instrument_detail_advance_level")
	des = string.gsub(des, ":", ": ")  
	local value = self._instrumentData:getLevel()
	local max = self._instrumentData:getAdvanceMaxLevel()
	local color = value < max and Colors.BRIGHT_BG_ONE or Colors.BRIGHT_BG_GREEN
	self._nodeLevel:setFontSize(16)
	ccui.Helper:seekNodeByName(self._nodeLevel, "TextDes"):setFontSize(18)
	self._nodeLevel:updateUI(des, value, max)
	self._nodeLevel:setValueColor(color)
	self._nodeLevel:setMaxColor(color)

	self:_updateAttrDes() 
end

function InstrumentDetailAttrNode:_updateAttrDes()
	local attrInfo = UserDataHelper.getInstrumentAttrInfo(self._instrumentData)
	local desInfo = TextHelper.getAttrInfoBySort(attrInfo)
	for i = 1, 4 do
		local info = desInfo[i]
		if info then
			self["_nodeAttr"..i]:updateView(info.id, info.value, nil, 4)
			self["_nodeAttr"..i]:setVisible(true)
		else
			self["_nodeAttr"..i]:setVisible(false)
		end
		self["_nodeAttr"..i]:setFontSize(18)
		ccui.Helper:seekNodeByName(self["_nodeAttr"..i], "TextValue"):setFontSize(16)
		local str = ccui.Helper:seekNodeByName(self["_nodeAttr"..i], "TextName"):getString() 
		str = string.gsub(str, ":", " :")
		ccui.Helper:seekNodeByName(self["_nodeAttr"..i], "TextName"):setString(str) 
	end
end
 
return InstrumentDetailAttrNode