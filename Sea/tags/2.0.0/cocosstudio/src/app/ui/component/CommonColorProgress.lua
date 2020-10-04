
local CommonColorProgress = class("CommonColorProgress")

local EXPORTED_METHODS = {
    "setPercent",
}

function CommonColorProgress:ctor()
	self._target = nil
    self._barGreen = nil
    self._barYellow = nil
    self._barRed = nil
    --self._imageArmyIcon = nil
    self._textPercent = nil
end

function CommonColorProgress:_init()
    self._barGreen = ccui.Helper:seekNodeByName(self._target, "BarGreen")
    self._barYellow = ccui.Helper:seekNodeByName(self._target, "BarYellow")
    self._barRed = ccui.Helper:seekNodeByName(self._target, "BarRed")
    --self._imageArmyIcon = ccui.Helper:seekNodeByName(self._target, "ImageArmyIcon")
    self._textPercent = ccui.Helper:seekNodeByName(self._target, "TextPercent")

    self._barGreen:setVisible(false)
    self._barYellow:setVisible(false)
    self._barRed:setVisible(false)
    --self._imageArmyIcon:setVisible(false)
end

function CommonColorProgress:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonColorProgress:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end


function CommonColorProgress:setPercent(percent,showText,needTotal)
    self._barGreen:setVisible(false)
    self._barYellow:setVisible(false)
    self._barRed:setVisible(false)
    local bar = self._barGreen
    if percent > 25 and percent <= 75 then 
        bar = self._barYellow
    elseif percent <= 25 then 
        bar = self._barRed
    end
    bar:setVisible(true)
    bar:setPercent(percent)


    self._textPercent:setVisible(showText)
    if not showText then
        return
    end

    local strPercent = tostring(percent)
    if needTotal then 
        strPercent = strPercent.." / 100"
    end
    self._textPercent:setString(strPercent)
    local fontColor = Colors.getMinePercentColor(percent)
    self._textPercent:setColor(fontColor.color)
    self._textPercent:enableOutline(fontColor.outlineColor, 2)
end


return CommonColorProgress
