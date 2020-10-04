--
-- Author: Liangxu
-- Date: 2018-8-13
-- 武将界限详情弹框
local PopupBase = require("app.ui.PopupBase")
local PopupLimitDetail = class("PopupLimitDetail", PopupBase)
local HeroLimitDetailAttrNode = require("app.scene.view.heroTrain.HeroLimitDetailAttrNode")
local HeroLimitDetailTalentNode = require("app.scene.view.heroTrain.HeroLimitDetailTalentNode")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function PopupLimitDetail:ctor(heroUnitData)
	self._heroUnitData = heroUnitData

	local resource = {
		file = Path.getCSB("PopupLimitDetail", "hero"),
		binding = {
			_buttonClose = {
				events = {{event = "touch", method = "_onButtonClose"}}
			},
		}
	}
	PopupLimitDetail.super.ctor(self, resource)
end

function PopupLimitDetail:onCreate()
	self._textTitle:setString(Lang.get("limit_break_title"))
	
end

function PopupLimitDetail:onEnter()
	local baseId = self._heroUnitData:getBase_id()
	local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, baseId)
	self._textName1:setString(heroParam.name)
	self._textName2:setString(heroParam.name)
	self._textName1:setColor(Colors.getColor(5))
	self._textName2:setColor(Colors.getColor(6))
	self:_updateList()
end

function PopupLimitDetail:onExit()
	
end

function PopupLimitDetail:_updateList()
	self._listView:removeAllChildren()
	local module1 = self:_buildAttrModule()
	local module2 = self:_buildTalentModule()
	self._listView:pushBackCustomItem(module1)
	self._listView:pushBackCustomItem(module2)
	self._listView:doLayout()
end

function PopupLimitDetail:_buildAttrModule()
	local heroUnitData = self._heroUnitData
	local limitLevel1 = 0
	local limitLevel2 = 3
	local attrModule = HeroLimitDetailAttrNode.new(heroUnitData, limitLevel1, limitLevel2)
	return attrModule
end

function PopupLimitDetail:_buildTalentModule()
	local heroUnitData = self._heroUnitData
	local limitLevel1 = 0
	local limitLevel2 = 3
	local talentModule = HeroLimitDetailTalentNode.new(heroUnitData, limitLevel1, limitLevel2)
	return talentModule
end

function PopupLimitDetail:_onButtonClose()
	self:close()
end

return PopupLimitDetail
