--
-- Author: Liangxu
-- Date: 2017-9-16 15:49:24
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local InstrumentDetailYokeNode = class("InstrumentDetailYokeNode", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")

function InstrumentDetailYokeNode:ctor(instrumentData)
	self._instrumentData = instrumentData

	local resource = {
		file = Path.getCSB("InstrumentDetailYokeNode", "instrument"),
		binding = {
			
		},
	}
	InstrumentDetailYokeNode.super.ctor(self, resource)
end

function InstrumentDetailYokeNode:onCreate()
	--i18n
	self:_dealByI18n()
	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)
	self._nodeTitle:setFontSize(24)
	self._nodeTitle:setTitle(Lang.get("instrument_detail_title_yoke"))

	local baseId = self._instrumentData:getBase_id()
	local heroBaseId = G_UserData:getInstrument():getHeroBaseId(baseId)
	local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)
	self._nodeIcon:updateUI(heroBaseId)
	local heroName = UserDataHelper.getHeroConfig(heroBaseId).name
	self._textName:setString(heroName)
	self._textName:setColor(heroParam.icon_color)
	require("yoka.utils.UIHelper").updateTextOutlineByGold(self._textName, heroParam)

	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_INSTRUMENT, baseId)
	local des = self:_createYokeDes(param.name)
	self._textDes:setString(des)
	local isActive = G_UserData:getBattleResource():isInstrumentInBattleWithBaseId(baseId)
	local color = isActive and Colors.SYSTEM_TARGET_RED or Colors.BRIGHT_BG_TWO
	self._textDes:setColor(color)
end

function InstrumentDetailYokeNode:_createYokeDes(name)
	local des = Lang.get("instrument_detail_yoke_des", {name = name})
	local instrumentId = self._instrumentData:getBase_id()
	local attrInfo = UserDataHelper.getYokeAttrWithInstrumentId(instrumentId)

	for i, one in ipairs(attrInfo) do
		local name, value = TextHelper.getAttrBasicText(one.attrId, one.attrValue)
		local txt = name.."+"..value
		if i ~= #attrInfo then
			-- i18n change punc
			if not Lang.checkLang(Lang.CN) then
				txt = txt..","
			else
				txt = txt.."，"
			end
		end
		des = des..txt
	end

	return des
end

--i18n
function InstrumentDetailYokeNode:_dealByI18n()
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		self._textDes:setFontSize(18)
	end
end

return InstrumentDetailYokeNode