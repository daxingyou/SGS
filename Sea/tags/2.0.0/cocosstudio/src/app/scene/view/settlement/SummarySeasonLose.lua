-- @Author panhoa
-- @Date 9.10.2018
-- @Role 

local SummaryLoseBase = require("app.scene.view.settlement.SummaryLoseBase")
local SummarySeasonLose = class("SummarySeasonLose", SummaryLoseBase)


function SummarySeasonLose:ctor(battleData, callback)
    self._battleData = battleData
    SummarySeasonLose.super.ctor(self,battleData,callback)
end

function SummarySeasonLose:onEnter()
    SummarySeasonLose.super.onEnter(self)
    self:_createAnimation()
end

function SummarySeasonLose:onExit()
    G_UserData:getSeasonSport():c2sFightsEntrance()
    SummarySeasonLose.super.onExit(self)
end

function SummarySeasonLose:_createAnimation(rootNode)
    local EffectGfxNode = require("app.effect.EffectGfxNode")
    local function effectFunction(effect)
        if string.find(effect, "effect_") then
            local subEffect = EffectGfxNode.new(effect)
            subEffect:play()
            return subEffect
        else
            return self:_createActionNode(effect)    
        end
    end
    local function eventFunction(event)
        if event == "finish" then
            self:_createContinueNode()
        end
    end
    G_EffectGfxMgr:createPlayMovingGfx( self, "moving_jfail", effectFunction, eventFunction , false )
end

function SummarySeasonLose:_createActionNode(effect)
    if effect == "fail_txt_tishengzhanli" then
        return self:_createText()
    elseif effect == "fail_icon1" then
        return self:_createLoseNode(1)
    elseif effect == "fail_icon2" then
        return self:_createLoseNode(2)
    elseif effect == "fail_icon3" then
        return self:_createLoseNode(3)
    elseif effect == "fail_icon4" then
        return self:_createLoseNode(4)
    elseif effect == "fail_txt_huode" then
        return self:_createText("txt_sys_reward02")
    elseif effect == "moving_jwin_huode_1" then
        local text = " "--Lang.get("txt_sys_promote01")
        local fontColor = Colors.getSummaryLineColor()
        local label = cc.Label:createWithTTF(text, Path.getFontW8(), 24)
        label:setColor(fontColor)
        return label
        --return self:_createLosePic()
    elseif effect == "moving_jwin_huode_2" then
        local text = " "--Lang.get("txt_sys_promote01")
        local fontColor = Colors.getSummaryLineColor()
        local label = cc.Label:createWithTTF(text, Path.getFontW8(), 24)
        label:setColor(fontColor)
        return label
        --return self:_createLoseNode(1)
    elseif effect == "shibai" then
        return self:_createLosePic()    
    end
end


return SummarySeasonLose