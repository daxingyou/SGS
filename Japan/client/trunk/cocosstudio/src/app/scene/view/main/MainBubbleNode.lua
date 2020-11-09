local ViewBase = require("app.ui.ViewBase")
local MainBubbleNode = class("MainBubbleNode", ViewBase)

local cdTime = 5
local showTime = 5

function MainBubbleNode:ctor( )
    self._startTime = 0
    self._endTime = 0

    local resource = {
		file = Path.getCSB("MainBubbleNode", "main"),
		binding = {
		}
	}

	MainBubbleNode.super.ctor(self, resource)

end


function MainBubbleNode:onCreate()
    self._bubbleText:setString(Lang.get("Main_Bubble_Text"))
    local width = self._bubbleText:getContentSize().width + 35
    local height = self._bubbleBg:getContentSize().height
    self._bubbleBg:setContentSize(cc.size(width,height))
end

function MainBubbleNode:onEnter()
    self:_startRefreshHandler()   

    self._startTime = 0
    self._endTime = 0

    self:_resetCD()
    
    self:setVisible(false)
end

function MainBubbleNode:onExit()
    self:_endRefreshHandler()
end

function MainBubbleNode:_startRefreshHandler()
	local SchedulerHelper = require("app.utils.SchedulerHelper")
	if self._refreshHandler ~= nil then
        return
	end
	self._refreshHandler = SchedulerHelper.newSchedule(handler(self,self._onRefreshTick),1)
end

function MainBubbleNode:_endRefreshHandler()
	local SchedulerHelper = require("app.utils.SchedulerHelper")
	if self._refreshHandler ~= nil then
		SchedulerHelper.cancelSchedule(self._refreshHandler)
		self._refreshHandler = nil
	end
end

function MainBubbleNode:_isBubbleVisible()
    local time = G_ServerTime:getTime()
    if time >= self._startTime and time <= self._endTime then
        return true
    else
        return false
    end
end


function MainBubbleNode:_resetCD()
    local time = G_ServerTime:getTime()
    if time > self._endTime then
        self._startTime = time + cdTime
        self._endTime = self._startTime + showTime
    end
end


function MainBubbleNode:_onRefreshTick(dt)
    local visible = self:_isBubbleVisible()
    self:setVisible(visible)
    self:_resetCD()
end

return MainBubbleNode