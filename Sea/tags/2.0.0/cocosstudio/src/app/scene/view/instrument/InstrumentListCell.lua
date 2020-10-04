--
-- Author: Liangxu
-- Date: 2017-9-7 14:22:33
-- 神兵列表Cell
local ListViewCellBase = require("app.ui.ListViewCellBase")
local InstrumentListCell = class("InstrumentListCell", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local AttributeConst = require("app.const.AttributeConst")
local InstrumentConst = require("app.const.InstrumentConst")

function InstrumentListCell:ctor()
	local resource = {
		file = Path.getCSB("InstrumentListCell", "instrument"),
		binding = {
			_buttonAdvance1 = {
				events = {{event = "touch", method = "_onButtonAdvanceClicked1"}}
			},
			_buttonAdvance2 = {
				events = {{event = "touch", method = "_onButtonAdvanceClicked2"}}
			}
		}
	}
	InstrumentListCell.super.ctor(self, resource)
end

function InstrumentListCell:onCreate()
	-- i18n pos lable
	self:_dealPosI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	self._buttonAdvance1:setString(Lang.get("instrument_btn_train"))
	self._buttonAdvance2:setString(Lang.get("instrument_btn_train"))
end

function InstrumentListCell:update(instrumentId1, instrumentId2)
	self._instrumentId1 = instrumentId1
	self._instrumentId2 = instrumentId2

	local function updateCell(index, instrumentId)
		if instrumentId then
			if type(instrumentId) ~= "number" then
				return
			end
			self["_item" .. index]:setVisible(true)
			local data = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
			local baseId = data:getBase_id()
			local level = data:getLevel()
			local limitLevel = data:getLimit_level()

			self["_item" .. index]:updateUI(TypeConvertHelper.TYPE_INSTRUMENT, baseId)
			self["_item" .. index]:getCommonIcon():getIconTemplate():updateUI(baseId, nil, limitLevel)
			self["_item" .. index]:setTouchEnabled(true)
			self["_item" .. index]:setCallBack(handler(self, self["_onClickIcon" .. index]))
			local params = self["_item" .. index]:getCommonIcon():getItemParams()
			self["_item" .. index]:setName(params.name, params.icon_color)
			self["_textRank" .. index]:setString("+" .. level)
			self["_textRank" .. index]:setVisible(level > 0)

			self:_showAttrDes(index, data)

			local heroBaseId = UserDataHelper.getHeroBaseIdWithInstrumentId(data:getId())
			if heroBaseId then
				local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)
				self["_textHeroName" .. index]:setString(heroParam.name)
				self["_textHeroName" .. index]:setColor(heroParam.icon_color)
				require("yoka.utils.UIHelper").updateTextOutlineByGold(self["_textHeroName" .. index], heroParam)
				self["_textHeroName" .. index]:setVisible(true)
			else
				self["_textHeroName" .. index]:setVisible(false)
			end
		else
			self["_item" .. index]:setVisible(false)
		end
	end

	updateCell(1, instrumentId1)
	updateCell(2, instrumentId2)
end

function InstrumentListCell:_showAttrDes(index, data)
	local showAttrIds = {AttributeConst.ATK, AttributeConst.HP} --需要显示的2种属性
	local info = UserDataHelper.getInstrumentAttrInfo(data)

	for i = 1, 2 do
		local attrId = showAttrIds[i]
		local value = info[attrId]
		if value then
			local attrName, attrValue = TextHelper.getAttrBasicText(attrId, value)
			attrName = TextHelper.expandTextByLen(attrName, 4)
			self["_nodeAttr" .. index .. "_" .. i]:updateUI(attrName, "+" .. attrValue)
			self["_nodeAttr" .. index .. "_" .. i]:setValueColor(Colors.BRIGHT_BG_GREEN)
			self["_nodeAttr" .. index .. "_" .. i]:setVisible(true)
		else
			self["_nodeAttr" .. index .. "_" .. i]:setVisible(false)
		end
	end
end

function InstrumentListCell:_onButtonAdvanceClicked1()
	self:dispatchCustomCallback(1)
end

function InstrumentListCell:_onButtonAdvanceClicked2()
	self:dispatchCustomCallback(2)
end

function InstrumentListCell:_onClickIcon1(sender, itemParams)
	local instrumentId = self._instrumentId1
	G_SceneManager:showScene("instrumentDetail", instrumentId, InstrumentConst.INSTRUMENT_RANGE_TYPE_1)
end

function InstrumentListCell:_onClickIcon2(sender, itemParams)
	local instrumentId = self._instrumentId2
	G_SceneManager:showScene("instrumentDetail", instrumentId, InstrumentConst.INSTRUMENT_RANGE_TYPE_1)
end

-- i18n pos lable
function InstrumentListCell:_dealPosI18n()
	if not Lang.checkLang(Lang.CN) then
		self._textHeroName1:setFontSize(
			self._textHeroName1:getFontSize()-2
		)
		self._textHeroName2:setFontSize(
			self._textHeroName2:getFontSize()-2
		)
	end
	
end




return InstrumentListCell