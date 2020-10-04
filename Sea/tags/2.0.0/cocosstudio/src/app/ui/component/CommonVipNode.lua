
local CommonVipNode = class("CommonVipNode")

local EXPORTED_METHODS = {
    "setString",
    "alignCenter",
    "getWidth",--i18n 
}

function CommonVipNode:ctor()
	self._target = nil
end

function CommonVipNode:_init()
	self._imageVip = ccui.Helper:seekNodeByName(self._target, "Image_vip")
	self._textVip1 = ccui.Helper:seekNodeByName(self._target, "Text_vip_1")
    self._textVip2 = ccui.Helper:seekNodeByName(self._target, "Text_vip_2")
    if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        self._imageVip:ignoreContentAdaptWithSize(true)
    end
end

function CommonVipNode:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonVipNode:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonVipNode:setString(vip)
    local num = tonumber(vip)
    if num < 10 then
        self._textVip1:setVisible(true)
        self._textVip2:setVisible(false)
        self._textVip1:setString(tostring(num))
    else
        self._textVip1:setVisible(true)
        self._textVip2:setVisible(true)  
        self._textVip1:setString( tostring(math.floor( num / 10) )) 
        self._textVip2:setString(tostring(num % 10))
    end
    -- i18n change lable
    if not Lang.checkLang(Lang.CN) then
        self:_updatePosI18n()
    end
end

function CommonVipNode:alignCenter()

end



-- i18n change lable
function CommonVipNode:_updatePosI18n()
	if Lang.checkLang(Lang.TW) then
	elseif not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")

        logWarn("xxxddd "..self._imageVip:getContentSize().width)
        self._textVip1:setPositionX(self._imageVip:getPositionX() - 8 + self._imageVip:getContentSize().width)
        self._textVip2:setPositionX(self._textVip1:getPositionX() - 4 + self._textVip1:getContentSize().width)
	end
end



-- i18n change lable
function CommonVipNode:getWidth()
    local width = self._imageVip:getContentSize().width 
    if self._textVip1:isVisible() then
        width = width + self._textVip1:getContentSize().width - 8
        if Lang.checkLang(Lang.TW) then
            width = width + 8
        end
    end
    if self._textVip2:isVisible() then
        width = width + self._textVip2:getContentSize().width - 4
        if Lang.checkLang(Lang.TW) then
            width = width + 4
        end
    end
    return width
end

return CommonVipNode
