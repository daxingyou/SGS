local ViewBase = require("app.ui.ViewBase")
local QinTombRemainTimeNode = class("QinTombRemainTimeNode", ViewBase)
local Path = require("app.utils.Path")
local AudioConst = require("app.const.AudioConst")
local QinTombConst = require("app.const.QinTombConst")

function QinTombRemainTimeNode:ctor()
	self._heroIcon1 = nil	--1-6 icon
	self._heroName1 = nil	--1-6 name
	

	local resource = {
		file = Path.getCSB("QinTombRemainTimeNode", "qinTomb"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
		}
	}
	self:setName("QinTombRemainTimeNode")
	QinTombRemainTimeNode.super.ctor(self, resource)
end

function QinTombRemainTimeNode:onCreate()

end

function QinTombRemainTimeNode:_onUpdate( dt )
	
end

function QinTombRemainTimeNode:onEnter()
	self:scheduleUpdateWithPriorityLua(handler(self,self._onUpdate),0)
end

function QinTombRemainTimeNode:onExit()
	self:unscheduleUpdate() 
end



return QinTombRemainTimeNode
