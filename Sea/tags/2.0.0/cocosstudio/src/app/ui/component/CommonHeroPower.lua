--
-- Author: Liangxu
-- Date: 2017-07-12 14:59:05
-- 武将战力控件
local CommonHeroPower = class("CommonHeroPower")
local UserDataHelper = require("app.utils.UserDataHelper")

local EXPORTED_METHODS = {
    "updateUI",
    "getWidth",
	"hideImage",
}

function CommonHeroPower:ctor()
	self._target = nil
end

function CommonHeroPower:_init()
	self._label = ccui.Helper:seekNodeByName(self._target, "Label")
	self._imageCombatValue = ccui.Helper:seekNodeByName(self._target, "ImageCombatValue")

	-- i18n change lable
	if not Lang.checkLang(Lang.CN) then
		local image6 = ccui.Helper:seekNodeByName(self._target, "Image_6")
		if image6 then
			local UIHelper  = require("yoka.utils.UIHelper")	
			UIHelper.swapWithLabel(image6,{
				style = "single_race_2",
				text = Lang.getImgText("txt_camp_06") ,
		    })
end

	end
	
end

function CommonHeroPower:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonHeroPower:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonHeroPower:updateUI(power)
	self._label:setString(power)
end

function CommonHeroPower:getWidth()
	local posX = 50 --数字x轴坐标
	local width = self._label and self._label:getContentSize().width or 0
	return posX + width
end

function CommonHeroPower:hideImage( ... )
	-- body
	self._imageCombatValue:setVisible(false)
end

return CommonHeroPower