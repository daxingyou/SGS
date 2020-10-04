--
-- Author: Liangxu
-- Date: 2018-11-5
-- 神兵界限详情弹框
local PopupBase = require("app.ui.PopupBase")
local PopupInstrumentLimitDetail = class("PopupInstrumentLimitDetail", PopupBase)
local InstrumentLimitDetailAttrNode = require("app.scene.view.instrumentTrain.InstrumentLimitDetailAttrNode")
local InstrumentLimitDetailTalentNode = require("app.scene.view.instrumentTrain.InstrumentLimitDetailTalentNode")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local InstrumentDataHelper = require("app.utils.data.InstrumentDataHelper")
local InstrumentConst = require("app.const.InstrumentConst")

function PopupInstrumentLimitDetail:ctor(instrumentUnitData)
	self._instrumentUnitData = instrumentUnitData

	local resource = {
		file = Path.getCSB("PopupLimitDetail", "hero"),
		binding = {
			_buttonClose = {
				events = {{event = "touch", method = "_onButtonClose"}}
			},
		}
	}
	PopupInstrumentLimitDetail.super.ctor(self, resource)
end

function PopupInstrumentLimitDetail:onCreate()
	self._textTitle:setString(Lang.get("limit_break_title"))
end

function PopupInstrumentLimitDetail:onEnter()
	local baseId = self._instrumentUnitData:getBase_id()
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_INSTRUMENT, baseId)
	self._textName1:setString(param.name)
	self._textName2:setString(param.name)
	self._textName1:setColor(Colors.getColor(5))
	self._textName2:setColor(Colors.getColor(6))
	self:_updateList()
end

function PopupInstrumentLimitDetail:onExit()
	
end

function PopupInstrumentLimitDetail:_updateList()
	self._listView:removeAllChildren()
	local module1 = self:_buildAttrModule()
	local module2 = self:_buildTalentModule()
	self._listView:pushBackCustomItem(module1)
	self._listView:pushBackCustomItem(module2)
	self._listView:doLayout()
end

function PopupInstrumentLimitDetail:_buildAttrModule()
	local instrumentUnitData = self._instrumentUnitData
	local info = self._instrumentUnitData:getConfig()
	local templateId1 = info.cost
	local rankInfo = InstrumentDataHelper.getInstrumentRankConfig(info.instrument_rank_1, InstrumentConst.INSTRUMENT_LIMIT_MAX_LEVEL)
	local templateId2 = rankInfo.rank_size
	local level = rankInfo.level
	local attrModule = InstrumentLimitDetailAttrNode.new(level, templateId1, templateId2)
	return attrModule
end

function PopupInstrumentLimitDetail:_buildTalentModule()
	local instrumentUnitData = self._instrumentUnitData
	local info = self._instrumentUnitData:getConfig()
	local templateId1 = info.cost
	local templateId2 = InstrumentDataHelper.getInstrumentRankConfig(info.instrument_rank_1, InstrumentConst.INSTRUMENT_LIMIT_MAX_LEVEL).rank_size
	local talentModule = InstrumentLimitDetailTalentNode.new(instrumentUnitData, templateId1, templateId2)
	return talentModule
end

function PopupInstrumentLimitDetail:_onButtonClose()
	self:close()
end

return PopupInstrumentLimitDetail
