
local CommonSkipLayer = class("CommonSkipLayer")

local EXPORTED_METHODS = {
    "addClickEventListenerEx",
}

function CommonSkipLayer:ctor()
    self._target = nil
    self._callback = nil
    self._downloadName = nil
end

function CommonSkipLayer:_init()
    self._buttonShare = ccui.Helper:seekNodeByName(self._target, "ButtonShare")
   
end

function CommonSkipLayer:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonSkipLayer:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end


function CommonSkipLayer:addClickEventListenerEx(callback)
    self._buttonShare:addClickEventListenerEx(callback)
end

return CommonSkipLayer