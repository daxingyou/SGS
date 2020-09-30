--
-- Author: Liangxu
-- Date: 2018-3-5 10:57:19
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local SilkbagListCell = class("SilkbagListCell", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local SilkbagDataHelper = require("app.utils.data.SilkbagDataHelper")
local SilkbagConst = require("app.const.SilkbagConst")

function SilkbagListCell:ctor()
	local resource = {
		file = Path.getCSB("SilkbagListCell", "silkbag"),
		binding = {
			_button = {
				events = {{event = "touch", method = "_onButtonClicked"}}
			}
		}
	}
	SilkbagListCell.super.ctor(self, resource)
end

function SilkbagListCell:onCreate()
	-- i18n pos lable
	self:_dealPosByI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	self._button:setString(Lang.get("silkbag_btn_wear"))
end

function SilkbagListCell:update(silkbagId, heroBaseId, heroRank, isInstrumentMaxLevel, curPos, heroLimit, heroRedLimit)
	local unitData = G_UserData:getSilkbag():getUnitDataWithId(silkbagId)
	local info = unitData:getConfig()
	local baseId = unitData:getBase_id()

	local nameStr = info.only == SilkbagConst.ONLY_TYPE_1 and Lang.get("silkbag_only_tip", {name = info.name}) or info.name
	local btnStr = ""

	self._fileNodeIcon:unInitUI()
	self._fileNodeIcon:initUI(TypeConvertHelper.TYPE_SILKBAG, baseId)
	local isEffect =
		SilkbagDataHelper.isEffectiveSilkBagToHero(baseId, heroBaseId, heroRank, isInstrumentMaxLevel, heroLimit, heroRedLimit)
	local isCanWear = unitData:isCanWearWithPos(curPos)
	local isShowMark = isEffect and isCanWear
	self._imageMark:setVisible(isShowMark)
	local params = self._fileNodeIcon:getItemParams()
	self._textName:setString(nameStr)
	self._textName:setColor(params.icon_color)
	require("yoka.utils.UIHelper").updateTextOutline(self._textName, params)

	local heroUnitData = unitData:getHeroDataOfWeared()
	if heroUnitData then
		local baseId = heroUnitData:getBase_id()
		local limitLevel = heroUnitData:getLimit_level()
		local limitRedLevel = heroUnitData:getLimit_rtg()
		local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, baseId, nil, nil, limitLevel, limitRedLevel)
		self._textHeroName:setVisible(true)
		self._textHeroName:setString(heroParam.cfg.name)
		self._textHeroName:setColor(heroParam.icon_color)
		require("yoka.utils.UIHelper").updateTextOutline(self._textHeroName, heroParam)
		
		self._button:setString(Lang.get("silkbag_btn_grab"))
		self._button:switchToHightLight()
	else
		self._textHeroName:setVisible(false)
		self._button:setString(Lang.get("silkbag_btn_wear"))
		self._button:switchToNormal()
	end
end

function SilkbagListCell:_onButtonClicked()
	self:dispatchCustomCallback(1)
end

-- i18n pos lable
function SilkbagListCell:_dealPosByI18n()
	if Lang.checkLang(Lang.VN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        self._textName:setVisible(false)
	end

	-- i18n ja pos
	if Lang.checkLang(Lang.JA) then
		self._textHeroName:setAnchorPoint(cc.p(0, 0.5))
		self._textName:setPositionX(self._textName:getPositionX() - 4)
		self._textHeroName:setFontSize(self._textHeroName:getFontSize() - 1.5)
		self._textHeroName:setPosition(self._textName:getPositionX(), self._textName:getPositionY() - 53)
		self._button:setPositionX(self._button:getPositionX() + 2)
	end
end


return SilkbagListCell