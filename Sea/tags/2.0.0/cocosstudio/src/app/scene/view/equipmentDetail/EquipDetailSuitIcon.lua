--
-- Author: Liangxu
-- Date: 2017-04-12 17:31:13
-- 武将详情 合击里的Icon
local EquipDetailSuitIcon = class("EquipDetailSuitIcon")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function EquipDetailSuitIcon:ctor(target)
	self._target = target

	self._textName = ccui.Helper:seekNodeByName(self._target, "TextName") --装备名称
	self._fileNodeEquip = ccui.Helper:seekNodeByName(self._target, "FileNodeEquip") --Icon
	cc.bind(self._fileNodeEquip, "CommonEquipIcon")
end

function EquipDetailSuitIcon:updateView(equipId, needMask)
	self._fileNodeEquip:updateUI(equipId)
	self._fileNodeEquip:setIconMask(needMask)

	local equipParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_EQUIPMENT, equipId)
	--i18n
	if Lang.checkLang(Lang.TH) then
		local txt = string.gsub( equipParam.name, "·", "·\n")
		self._textName:setString(txt)
	else
		self._textName:setString(equipParam.name)
	end
	self._textName:setColor(equipParam.icon_color)
	require("yoka.utils.UIHelper").updateTextOutline(self._textName, equipParam)
end

function EquipDetailSuitIcon:setIconMask(needMask)
	self._fileNodeEquip:setIconMask(needMask)	
end

return EquipDetailSuitIcon