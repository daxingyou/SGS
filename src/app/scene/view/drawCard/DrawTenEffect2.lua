local SchedulerHelper = require("app.utils.SchedulerHelper")
local DrawEffectBase = require("app.scene.view.drawCard.DrawEffectBase2")
local DrawTenEffect = class("DrawTenEffect", DrawEffectBase)

local EffectGfxNode = require("app.effect.EffectGfxNode")
local Hero = require("app.config.hero")

DrawTenEffect.TIME_OUT  = 3

function DrawTenEffect:ctor(awards)
    DrawTenEffect.super.ctor(self, awards,  DrawEffectBase.DRAW_TYPE_GOLD)
    self._actionFinishTime = 0
end

function DrawTenEffect:onCreate()
    DrawTenEffect.super.onCreate(self)
end

function DrawTenEffect:onEnter()
    DrawTenEffect.super.onEnter(self)
    local node = self:_createBackEffect()
    self:addChild(node)
    self:play()
end

function DrawTenEffect:onExit()
    DrawTenEffect.super.onEnter(self)
    self:_endCountDown()
    self:_endCountDown2()
end

--滑动触发卡牌特效
function DrawTenEffect:_onFinishTouch(sender, event)
    DrawTenEffect.super._onFinishTouch(self,sender, event)
    if self._isAction then
        return 
    end
    self._actionFinishTime = nil
    self:_endCountDown()
    self:_endCountDown2()
end

function DrawTenEffect:play()
    DrawTenEffect.super.play(self)
    local function effectFunction(effect)
        if string.find(effect,"zhaomu_lingpai_") then
            local strArray = string.split(effect, "_")
            local index = tonumber(strArray[3])
            local card = self:_createCard(index)
            return card
        end  
        return cc.Node:create()
    end
    local function eventFunction(event)
        if event == "finish" then
            self._isAction = false
            self._actionFinishTime = G_ServerTime:getTime()
            self:_startCountDown(DrawTenEffect.TIME_OUT)
          
            local effect = G_EffectGfxMgr:createPlayGfx(self, "effect_lingpai_huaxian")
            --effect:setDouble(0.8)
            effect:setPositionY(-55)
        end
    end
    local effect = G_EffectGfxMgr:createPlayMovingGfx( self, "moving_zhaomu_up", effectFunction, eventFunction , false )
end

function DrawTenEffect:_timeOutCallback()
    if not self._actionFinishTime then
        return 
    end
    local effect = G_EffectGfxMgr:createPlayGfx(self, "effect_lingpai_huaxian")
    --effect:setDouble(0.8)
    effect:setPositionY(-55)
end

function DrawTenEffect:_startCountDown(interval)
    self:_endCountDown()
    if interval > 0 then
        self._countDownHandler = SchedulerHelper.newScheduleOnce(
            function() 
                self:_startCountDown2(DrawTenEffect.TIME_OUT)
                self:_timeOutCallback()
            end, interval)
    end
end

function DrawTenEffect:_endCountDown()
    if self._countDownHandler then
        SchedulerHelper.cancelSchedule(self._countDownHandler)
        self._countDownHandler = nil
    end
end

function DrawTenEffect:_startCountDown2(interval)
    self:_endCountDown2()
    if interval > 0 then
        self._countDownHandler2 = SchedulerHelper.newSchedule(handler(self, self._timeOutCallback), interval)
    end
end

function DrawTenEffect:_endCountDown2()
    if self._countDownHandler2 then
        SchedulerHelper.cancelSchedule(self._countDownHandler2)
        self._countDownHandler2 = nil
    end
end

return DrawTenEffect