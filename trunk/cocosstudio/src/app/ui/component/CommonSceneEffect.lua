
local CommonSceneEffect = class("CommonSceneEffect")

local EXPORTED_METHODS = {
    "setScene",
}

function CommonSceneEffect:ctor()
    self._sceneIdOfDay = nil
    self._sceneIdOfNight = nil
    self._currSceneId = nil
end

function CommonSceneEffect:_init()
    self._target:onNodeEvent("exit", function ()
        logWarn("CommonSceneEffect exit .......")
    end)

     self._target:onNodeEvent("enter", function ()
        logWarn("CommonSceneEffect enter .......")
        local MainUIHelper = require("app.scene.view.main.MainUIHelper")
        local isInDayTime = MainUIHelper.isInDaytime()
        if isInDayTime then
            self:_updateScene(self._sceneIdOfDay)
        else
            self:_updateScene(self._sceneIdOfNight)
        end
    end)
end

function CommonSceneEffect:bind(target)
    self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonSceneEffect:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonSceneEffect:setScene(sceneIdOfDay,sceneIdOfNight)
   self._sceneIdOfDay = sceneIdOfDay
   self._sceneIdOfNight = sceneIdOfNight
end

function CommonSceneEffect:_updateScene(sceneId)
	if self._currSceneId ~= sceneId then
		self._currSceneId = sceneId
		self._target:updateSceneId(sceneId)
	end
end

return CommonSceneEffect
