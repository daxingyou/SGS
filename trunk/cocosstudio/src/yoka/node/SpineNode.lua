-- i18n ja mouth
local scheduler = require("cocos.framework.scheduler")

local SpineNode = class("SpineNode", function()
	return cc.Node:create()
end)

local fileUtils = cc.FileUtils:getInstance()
local PrioritySignal = require("yoka.event.PrioritySignal")

--
function SpineNode:ctor(scale, size, setGray)
    self:enableNodeEvents()
    self:setCascadeOpacityEnabled(true)
    self:setCascadeColorEnabled(true)

    -- i18n ja mouth
    self._spinePoints   = {}

    self._timeScale = 1
	self._spine = nil
    self._animationName = nil
    self._animationLoop = nil
    self._scale = scale or 1
    self._size = size
    self._registerSpineEventHandler = false
    self._setGray = setGray

    self.signalLoad = PrioritySignal.new("string")
    self.signalStart = PrioritySignal.new("string")
    self.signalEnd = PrioritySignal.new("string")
    self.signalComplet = PrioritySignal.new("string")
    self.signalEvent = PrioritySignal.new("string")
end

--
function SpineNode:setSize(size)
    self._size = size
    if self._spine then
        self._spine:setContentSize(self._size)
        self._spine:setAnchorPoint(cc.p(0.5, 0))
    end
end

-- i18n ja mouth
function SpineNode:setAsset(path,callback)
    -- i18n ja mouth
    self:_removeSpinePointHandler()
    self:_removeSpinePoints()
    -- reset
    self:_unregisterSpineEvent()
    self:removeAllChildren(true)
    self._animationName = nil
    self._animationLoop = nil
    self._spine = nil

    -- load
    local ret = G_SpineManager:addSpineAsync(path, self._scale, function () 
        local spineAni = G_SpineManager:createSkeleton(path)
        assert(spineAni, "Could not load the spine with path: "..tostring(path))
		--i18n
        if spineAni and not tolua.isnull(self) then
            spineAni:setToSetupPose()

            self:addChild(spineAni)
            self._spine = spineAni

            if self._setGray then
                local ShaderHalper = require("app.utils.ShaderHelper")
                ShaderHalper.filterNode(self._spine, "gray")
            end
           

            if self._size then
                self:setSize(self._size)
            end


            self:_registerSpineEvent()

            if self._animationName ~= nil then
                self:setAnimation(self._animationName, self._animationLoop)
            end

            self._spine:setTimeScale(self._timeScale)
            self.signalLoad:dispatch("load")

            -- i18n ja mouth
            if callback then
                callback()
            end
        end
    end, self)

end

-- function SpineNode:applyShader(shaderName)
--     local ShaderHalper = require("app.utils.ShaderHelper")
--     ShaderHalper.filterNode(spine, shaderName)
-- end

--
function SpineNode:_registerSpineEvent()
    if self._spine then
        if not self._registerSpineEventHandler then
            self._registerSpineEventHandler = true
        
            --
            self._spine:registerSpineEventHandler(function (event)
                self.signalStart:dispatch(event.trackIndex)
            end, sp.EventType.ANIMATION_START)

            --
            self._spine:registerSpineEventHandler(function (event)
                self.signalEnd:dispatch(event.trackIndex)
            end, sp.EventType.ANIMATION_END)
            
            --
            self._spine:registerSpineEventHandler(function (event)
                self.signalComplet:dispatch(event.trackIndex, 
                                            event.loopCount)
            end, sp.EventType.ANIMATION_COMPLETE)

            --
            self._spine:registerSpineEventHandler(function (event)
                self.signalEvent:dispatch(event.trackIndex, 
                                            event.eventData.name, 
                                            event.eventData.intValue, 
                                            event.eventData.floatValue, 
                                            event.eventData.stringValue)
            end, sp.EventType.ANIMATION_EVENT)
        end
    end
end

--
function SpineNode:_unregisterSpineEvent()
    if self._registerSpineEventHandler then
        self._registerSpineEventHandler = false
        if self._spine then
            self._spine:unregisterSpineEventHandler(sp.EventType.ANIMATION_START)

            --
            self._spine:unregisterSpineEventHandler(sp.EventType.ANIMATION_END)
            
            --
            self._spine:unregisterSpineEventHandler(sp.EventType.ANIMATION_COMPLETE)

            --
            self._spine:unregisterSpineEventHandler(sp.EventType.ANIMATION_EVENT)
        end
    end
end

--
function SpineNode:onEnter()
    self:_registerSpineEvent()
end

--
function SpineNode:onExit()
    self:_unregisterSpineEvent()
    G_SpineManager:removeSpineLoadHandlerByTarget(self)
end

--
function SpineNode:onCleanup()
    self:_unregisterSpineEvent()
    G_SpineManager:removeSpineLoadHandlerByTarget(self)
    self._spine = nil

    -- i18n ja mouth
    self:_removeSpinePointHandler()
    self:_removeSpinePoints()
end

--
function SpineNode:getSpine()
    return self._spine
end

--
function SpineNode:resetSkeletonPose()
    if self._spine ~= nil then
        self._spine:setToSetupPose()
        self._spine:clearTracks()
    end
end

--
function SpineNode:removeSelf()
    self:removeFromParent()
end

--
function SpineNode:setAnimation(name, loop, reset)
    self._animationName = name
    self._animationLoop = loop
    if self._spine then
        if reset ~= nil and reset == true then
            self:resetSkeletonPose()
        end
        self._spine:setAnimation(0, name, loop)
        self._spine:update(1/30)
    end
end

--
function SpineNode:setTimeScale(time)
    self._timeScale = time
    if self._spine then
        self._spine:setTimeScale(time)
    end
end

--检查动作是否存在
function SpineNode:isAnimationExist(name)
    if self._spine then
        return self._spine:isAnimationExist(name)
    end
    return false
end

--获得动作长度
function SpineNode:getAnimationDuration(name)
    local duration = self._spine:getAnimationDuration(name)
end

function SpineNode:getAnimationName( ... )
    -- body
    return self._animationName
end

-- i18n ja mouth start
-- 获得spine节点
function SpineNode:getSpinePoint(pointName)
    logWarn("[ SpineNode:getSpinePoint "..tostring(pointName).." ]")

    dump(cc.p(self._spine:getPosition()))

    local node  = display.newNode()
    self._spine:addChild(node)

    table.insert(self._spinePoints,{node = node,pointName = pointName})

    self:_initSpinePointHandler()

    return node
end

function SpineNode:_initSpinePointHandler()
    if not self._spinePointHandler then
        self._spinePointHandler     = scheduler.scheduleUpdateGlobal(handler(self,self._spinePointUpdate))
    end
end

function SpineNode:_removeSpinePointHandler()
    if self._spinePointHandler then
        scheduler.unscheduleGlobal(self._spinePointHandler)
        self._spinePointHandler     = nil
    end
end

function SpineNode:_removeSpinePoints()
    for i, v in ipairs(self._spinePoints) do
        v.node:removeFromParent()
    end

    self._spinePoints   = {}
end

function SpineNode:_spinePointUpdate(dt)

    for i, v in ipairs(self._spinePoints) do
        local node          = v.node
        local pointName     = v.pointName

        local pointInfo     = self._spine:getPointInfo(pointName)
        -- logWarn("[ -------- pos scale rotation --------- ]")
        -- dump(pointInfo)

        local pos       = cc.p(pointInfo[1],pointInfo[2])
        local rotation  = pointInfo[3]
        local scaleX    = pointInfo[4]
        local scaleY    = pointInfo[5]

        node:setRotation(-rotation)

        node:setPosition(pos)
        node:setScale(scaleX,scaleY)
    end
end
-- i18n ja mouth end


return SpineNode