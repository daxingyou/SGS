local ListViewCellBase = require("app.ui.ListViewCellBase")
local HeroLimitDetailAttrNode = class("HeroLimitDetailAttrNode", ListViewCellBase)
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local AttributeConst = require("app.const.AttributeConst")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")

function HeroLimitDetailAttrNode:ctor(heroUnitData, limitLevel1, limitLevel2)
	self._heroUnitData = heroUnitData
	self._limitLevel1 = limitLevel1
	self._limitLevel2 = limitLevel2

	local resource = {
		file = Path.getCSB("HeroLimitDetailAttrNode", "hero"),
		binding = {
			
		},
	}

	HeroLimitDetailAttrNode.super.ctor(self, resource)
end

function HeroLimitDetailAttrNode:onCreate()
	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)
	for i = 1, 2 do
		self:_update(self._heroUnitData, i)
	end
end

function HeroLimitDetailAttrNode:_update(heroUnitData, index)
	self["_nodeTitle"..index]:setFontSize(24)
	self["_nodeTitle"..index]:setTitle(Lang.get("hero_detail_title_attr"))

	local attr1 = HeroDataHelper.getBasicAttrWithLevel(heroUnitData:getConfig(), 1)
	local limitLevel = self["_limitLevel"..index]
	local attr2 = {}
	if limitLevel > 0 then
		local heroBaseId = heroUnitData:getBase_id()
		local rank = 10 --写死10级
		local attrMin = HeroDataHelper.getBreakAttrWithBaseIdAndRank(heroBaseId, rank, 0)
		local attrMax = HeroDataHelper.getBreakAttrWithBaseIdAndRank(heroBaseId, rank, limitLevel)
		for attrType, valueMax in pairs(attrMax) do
			local valueMin = attrMin[attrType]
			local value = valueMax - valueMin
			AttrDataHelper.formatAttr(attr2, attrType, value)
		end
	end
	
	local attr3 = HeroDataHelper.getLimitAttr(heroUnitData, limitLevel)
	local attrInfo = {}
	AttrDataHelper.appendAttr(attrInfo, attr1)
	AttrDataHelper.appendAttr(attrInfo, attr2)
	AttrDataHelper.appendAttr(attrInfo, attr3)
	self["_nodeAttr"..index.."_1"]:updateView(AttributeConst.ATK, attrInfo[AttributeConst.ATK], nil, 4)
	self["_nodeAttr"..index.."_2"]:updateView(AttributeConst.HP, attrInfo[AttributeConst.HP], nil, 4)
	self["_nodeAttr"..index.."_3"]:updateView(AttributeConst.PD, attrInfo[AttributeConst.PD], nil, 4)
	self["_nodeAttr"..index.."_4"]:updateView(AttributeConst.MD, attrInfo[AttributeConst.MD], nil, 4)
end

return HeroLimitDetailAttrNode
