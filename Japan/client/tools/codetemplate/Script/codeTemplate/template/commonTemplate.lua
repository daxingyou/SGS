-- Author: ${USER_NAME}
-- Date:${DATE}
-- Describle：

local ${FILENAME} = class("${FILENAME}")

local EXPORTED_METHODS = {

}

function ${FILENAME}:ctor()
	self._target = nil
end

function ${FILENAME}:_init()
	-- self._xxxxx = ccui.Helper:seekNodeByName(self._target, "xxxx")
end

function ${FILENAME}:bind(target)
	self._target = target
	self:_init()
	cc.setmethods(target, self, EXPORTED_METHODS)
end

function ${FILENAME}:unbind(target)
	cc.unsetmethods(target, EXPORTED_METHODS)
end

return ${FILENAME}