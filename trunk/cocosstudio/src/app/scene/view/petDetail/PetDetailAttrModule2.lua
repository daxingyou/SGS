--
-- Author: hedili
-- Date: 2018-01-24 17:24:00
-- 神兽详情 基础属性模块
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PetDetailAttrModule = class("PetDetailAttrModule", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local PetConst = require("app.const.PetConst")
local AttributeConst = require("app.const.AttributeConst")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")

local TWO_BUTTON_POSX = {116.00, 282.93}
local THREE_BUTTON_POSX = {70.00, 200.78, 332.00}

function PetDetailAttrModule:ctor(petUnitData, rangeType)
	self._petUnitData = petUnitData
	self._rangeType = rangeType

	local resource = {
		file = Path.getCSB("PetDetailAttrModule2", "pet"),
		binding = { 
		}
	}
	self:setName("PetDetailAttrModule")
	PetDetailAttrModule.super.ctor(self, resource)
end

function PetDetailAttrModule:onCreate()
	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)

	self._panelBg:setSwallowTouches(false)
	self._nodeTitle2:setName(5)
	self._nodeTitle:setFontSize(22)
	self._nodeTitle:setTitle(Lang.get("hero_detail_title_attr"))
	self._nodeLevel:setFontSize(18)
	ccui.Helper:seekNodeByName(self._nodeLevel, "TextValue"):setFontSize(16) 
	self:update(self._petUnitData)
	self:_arrangePanel()
end

function PetDetailAttrModule:_creatRichText(content)
	-- body
	local label = nil
	-- i18n richtext 
	if Lang.checkLang(Lang.CN) then
		label = ccui.RichText:create()
	else
		label = ccui.RichText:createByI18n()
	end

	label:setRichText(content)
	label:setAnchorPoint(cc.p(0, 1))
	label:ignoreContentAdaptWithSize(false)
	label:setContentSize(cc.size(326-20, 0))

	if Lang.checkLang(Lang.JA) then
		label:setVerticalSpace(9)
	end

	label:formatText()

	return label
end
function PetDetailAttrModule:_arrangePanel(...)
	-- body
	local PetDataHelper = require("app.utils.data.PetDataHelper")
	self._nodeRichDesc:removeAllChildren()
	if self._attrInfo == nil then
		return
	end
	local blessRate = self._attrInfo[AttributeConst.PET_BLESS_RATE] / 1000 * 100
 
	self._panelBg:setContentSize(cc.size(326, self._panelBg:getContentSize().height))  
	local percent = PetDataHelper.getParameterValue("pet_huyou_percent") / 10
	local desc = Lang.get("pet_attr_pend_desc", {num = percent})
	local richContent = PetDataHelper.convertAttrAppendDesc(desc, blessRate)
	local widget = self:_creatRichText(richContent)
	self._nodeRichDesc:addChild(widget)

	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)
end
function PetDetailAttrModule:update(petUnitData)
	local heroConfig = petUnitData:getConfig()
	local level = petUnitData:getLevel() --等级
	local maxLevel = G_UserData:getBase():getLevel()
	local param = {
		unitData = petUnitData
	}

	local attrInfo = UserDataHelper.getPetTotalAttr(param)

	self._attrInfo = attrInfo
	local des = Lang.get("hero_detail_txt_level")
	des = string.gsub(des, ":", ": ")  
	self._nodeLevel:updateUI(des, level, maxLevel)
	self._nodeLevel:setMaxValue("/" .. maxLevel)
	self._nodeAttr1:updateView(AttributeConst.ATK_FINAL, attrInfo[AttributeConst.ATK_FINAL], nil, 4)
	self._nodeAttr2:updateView(AttributeConst.HP_FINAL, attrInfo[AttributeConst.HP_FINAL], nil, 4)
	self._nodeAttr3:updateView(AttributeConst.PD_FINAL, attrInfo[AttributeConst.PD_FINAL], nil, 4)
	self._nodeAttr4:updateView(AttributeConst.MD_FINAL, attrInfo[AttributeConst.MD_FINAL], nil, 4)
	for i = 1, 4 do
		self["_nodeAttr" .. i]:setFontSize(18)
		ccui.Helper:seekNodeByName(self["_nodeAttr"..i], "TextValue"):setFontSize(16)
		-- local str = ccui.Helper:seekNodeByName(self["_nodeAttr"..i], "TextName"):getString() 
		-- str = string.gsub(str, ":", " :")
		-- ccui.Helper:seekNodeByName(self["_nodeAttr"..i], "TextName"):setString(str) 
	end
end
  

return PetDetailAttrModule
