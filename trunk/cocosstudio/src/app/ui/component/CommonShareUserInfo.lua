local CommonShareUserInfo = class("CommonShareUserInfo")

local EXPORTED_METHODS = {
    "updateUI",
}

function CommonShareUserInfo:ctor()
	self._target = nil
end

function CommonShareUserInfo:_init()
    self._textServerName = ccui.Helper:seekNodeByName(self._target, "TextServerName")
    self._imageTextPower = ccui.Helper:seekNodeByName(self._target, "Image_text_power")
    self._nodePower = ccui.Helper:seekNodeByName(self._target, "NodePower")
    self._textName = ccui.Helper:seekNodeByName(self._target, "TextName")

    self._label = ccui.Helper:seekNodeByName(self._target, "AtlasLabel_Power")
    self._labelWan  = ccui.Helper:seekNodeByName(self._target, "Image_Wan")

end

function CommonShareUserInfo:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonShareUserInfo:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonShareUserInfo:updateUI()
    self._textName:setString(G_UserData:getBase():getName())
	local serverName =  G_UserData:getBase():getServer_name()
    self._textServerName:setString(serverName)
    
    local power = G_UserData:getBase():getPower()
    local TextHelper = require("app.utils.TextHelper")
    local str,isWan = TextHelper.getAmountTextUI4(power)
    self._label:setString(str)
    self._labelWan:setPositionX(self._label:getContentSize().width)
    self._labelWan:setVisible(isWan)
end

return CommonShareUserInfo