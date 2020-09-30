--
-- Author: JerryHe
-- Date: 2017-03-23 17:18:28
-- 战马图鉴Cell中的Icon
-- 
local HorseKarmaCellIcon = class("HorseKarmaCellIcon")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function HorseKarmaCellIcon:ctor(target)
	self._target = target
	self:_init()
end

function HorseKarmaCellIcon:_init()
	self._fileNodeIcon = ccui.Helper:seekNodeByName(self._target, "FileNodeIcon")
	cc.bind(self._fileNodeIcon, "CommonHorseIcon")
	self._fileNodeIcon:setCallBack(handler(self, self._onClickIcon))
	self._fileNodeIcon:setTouchEnabled(true)

	self._textName = ccui.Helper:seekNodeByName(self._target, "TextName")

	-- i18n pos lable
	self:_dealPosByI18n()
end

function HorseKarmaCellIcon:updateIcon(heroBaseId, isDark)
	self._heroBaseId = heroBaseId
	self._isDark = isDark
	self._fileNodeIcon:updateUI(heroBaseId)
	self._fileNodeIcon:setIconMask(isDark)

	local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HORSE, heroBaseId)
	self._textName:setString(heroParam.name)
	self._textName:setColor(heroParam.icon_color)
	-- self._textName:enableOutline(heroParam.icon_color_outline)
end

function HorseKarmaCellIcon:_onClickIcon()
	local itemParam = self._fileNodeIcon:getItemParams()
	local PopupItemGuider = require("app.ui.PopupItemGuider").new(Lang.get("way_type_get"))
    PopupItemGuider:updateUI(TypeConvertHelper.TYPE_HORSE, itemParam.cfg.id)
    PopupItemGuider:openWithAction()
end

-- i18n pos lable
function HorseKarmaCellIcon:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		self._textName:setFontSize(self._textName:getFontSize()-2)
		self._textName:getVirtualRenderer():setMaxLineWidth(84)
	--	self._textName:getVirtualRenderer():setLineSpacing(-5)
		self._textName:setAnchorPoint(cc.p(0.5,1))
		self._textName:setPositionY(self._textName:getPositionY()+8)
		self._textName:setTextVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM )
		--self._textName:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER  )
	end
end

return HorseKarmaCellIcon