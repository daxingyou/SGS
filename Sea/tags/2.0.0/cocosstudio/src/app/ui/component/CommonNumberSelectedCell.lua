-- Author: zhanglinsen
-- Date:2018-10-12 17:04:59
-- Describle：

local CommonNumberSelectedCell = class("CommonNumberSelectedCell")

local EXPORTED_METHODS = {
    "updateUI",
    "updateState",
	"getIndex",
	"setCallBack"
}

function CommonNumberSelectedCell:ctor()

	self._target = nil
	self._index = nil
	self._callBack = nil
end

function CommonNumberSelectedCell:_init()
	self._textNum = ccui.Helper:seekNodeByName(self._target, "TextNum")


end

function CommonNumberSelectedCell:bind(target)
	self._target = target
	self:_init()
	cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonNumberSelectedCell:unbind(target)
	cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonNumberSelectedCell:updateUI(numberData)
	self._textNum:setString( numberData )
	self._index = numberData
end

function CommonNumberSelectedCell:updateState(stateData)
	if not stateData then return end
	self._textNum:setOpacity( stateData.alpha * 255 )
	self._textNum:setFontSize( stateData.fontSize )
end

function CommonNumberSelectedCell:getIndex()
	return self._index
end

function CommonNumberSelectedCell:setCallBack(callback)
	self._callBack = callback
end

return CommonNumberSelectedCell