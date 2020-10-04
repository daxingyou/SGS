-- Author: hedili
-- Date:2018-04-19 14:10:18
-- Describle：跨服军团战boss， 该boss死亡之后，玩家才能移动出去
local ViewBase = require("app.ui.ViewBase")
local GuildCrossWarMonsterAvatar = class("GuildCrossWarMonsterAvatar", ViewBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local GuildCrossWarAvatar = import(".GuildCrossWarAvatar")
local GuildCrossWarHelper = import(".GuildCrossWarHelper")
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local StateMachine = require("app.utils.StateMachine")

GuildCrossWarMonsterAvatar.MAX_AVATAR_SIZE = 3

GuildCrossWarMonsterAvatar.CREATE_STATE = "Create"
GuildCrossWarMonsterAvatar.INIT_STATE = "Init"
GuildCrossWarMonsterAvatar.STAND_STATE = "Stand" --等待状态
GuildCrossWarMonsterAvatar.ATTACK_STATE = "Attack" --打boss，与掠夺
GuildCrossWarMonsterAvatar.REBORN_STATE = "ReBorn" --死亡状态


function GuildCrossWarMonsterAvatar:ctor(pointId)
    --csb bind var name
    self._commonHeroAvatar = nil
    self._avatarName = nil
    self._currState = 0
    self._monsterId = pointId
    local resource = {
        file = Path.getCSB("GuildCrossWarMonsterAvatar", "guildCrossWar"),
    
    }
    GuildCrossWarMonsterAvatar.super.ctor(self, resource)
end



function GuildCrossWarMonsterAvatar:_initStateMachine(defaultState)
    if self._stateMachine then
        return
    end
    local cfg = {
        ["defaultState"] = GuildCrossWarMonsterAvatar.CREATE_STATE,
        ["stateChangeCallback"] = handler(self, self._stateChangeCallback),
        ["state"] = {
            [GuildCrossWarMonsterAvatar.CREATE_STATE] = {
                ["nextState"] = {
                    [GuildCrossWarMonsterAvatar.INIT_STATE] = {
                    },
                },
            },
            [GuildCrossWarMonsterAvatar.INIT_STATE] = {
                ["nextState"] = {
                    [GuildCrossWarMonsterAvatar.STAND_STATE] = {
                    },
                    [GuildCrossWarMonsterAvatar.REBORN_STATE] = {
                    },
                    [GuildCrossWarMonsterAvatar.ATTACK_STATE] = {
                    },
                },
                ["didEnter"] = handler(self, self._didEnterInit)
            },
            [GuildCrossWarMonsterAvatar.STAND_STATE] = {
                ["nextState"] = {
                    [GuildCrossWarMonsterAvatar.ATTACK_STATE] = {
                    },
                },
                ["didEnter"] = handler(self, self._didEnterStand),
                ["didExit"] = handler(self, self._didWillExitStand)
            },
            [GuildCrossWarMonsterAvatar.ATTACK_STATE] = {
                ["nextState"] = {
                    [GuildCrossWarMonsterAvatar.STAND_STATE] = {
                    },
                    [GuildCrossWarMonsterAvatar.REBORN_STATE] = {
                    },
                },
                ["didEnter"] = handler(self, self._didEnterAttack),
                ["willExit"] = handler(self, self._didWillExitAttack),
            },
            
            [GuildCrossWarMonsterAvatar.REBORN_STATE] = {
                ["nextState"] = {
                    [GuildCrossWarMonsterAvatar.STAND_STATE] = {
                        ["transition"] = handler(self, self._transitionRebornToStand),
                        ["stopTransition"] = handler(self, self._stopTransitionRebornToStand),
                    },
                    [GuildCrossWarMonsterAvatar.ATTACK_STATE] = {
                        ["transition"] = handler(self, self._transitionRebornToStand),
                        ["stopTransition"] = handler(self, self._stopTransitionRebornToStand),
                    },
                },
                ["didEnter"] = handler(self, self._didEnterReborn),
                ["willExit"] = handler(self, self._didWillExitReborn),
            },
        
        }
    }
    
    self._stateMachine = StateMachine.new(cfg)
end


-- Describle：
function GuildCrossWarMonsterAvatar:onCreate()
    
    self:_initStateMachine()
    self._nodeEffect:setVisible(false)
    self._touchPanel:addClickEventListenerEx(handler(self, self.onClickMonster))
    
    self:switchState(GuildCrossWarMonsterAvatar.INIT_STATE)
end

function GuildCrossWarMonsterAvatar:switchState(state, params, isForceStop)
    self._stateMachine:switchState(state, params, isForceStop)
end

function GuildCrossWarMonsterAvatar:onClickMonster(sender)
-- body
end


function GuildCrossWarMonsterAvatar:updateUI()
end

function GuildCrossWarMonsterAvatar:setAction(...)
    -- body
    self._commonHeroAvatar:setAction(...)
end

function GuildCrossWarMonsterAvatar:showShadow(...)
    -- body
    self._commonHeroAvatar:showShadow(...)
end

function GuildCrossWarMonsterAvatar:setAniTimeScale(...)
    -- body
    self._commonHeroAvatar:setAniTimeScale(...)
end

function GuildCrossWarMonsterAvatar:turnBack(...)
    self._commonHeroAvatar:turnBack(...)
end

function GuildCrossWarMonsterAvatar:_didEnterInit()
    logWarn("GuildCrossWarMonsterAvatar _didEnterInit")
end

function GuildCrossWarMonsterAvatar:_stateChangeCallback(newState, oldState)
    logWarn(string.format("GuildCrossWarMonsterAvatar _stateChangeCallback newState[%s], oldState[%s]", newState, oldState))
end

function GuildCrossWarMonsterAvatar:_didEnterStand()

end

function GuildCrossWarMonsterAvatar:_didWillExitStand(nextState)
    logWarn(" GuildCrossWarMonsterAvatar:_didWillExitStand")
end

function GuildCrossWarMonsterAvatar:_didEnterAttack()
    logWarn("GuildCrossWarMonsterAvatar:_didEnterAttack")
    self:playAttackAction()
end

function GuildCrossWarMonsterAvatar:_didWillExitAttack(...)
    -- body
    logWarn("GuildCrossWarMonsterAvatar:_didWillExitAttack")
end



function GuildCrossWarMonsterAvatar:_didEnterReborn()
end


function GuildCrossWarMonsterAvatar:_stopTransitionRebornToStand()

end

function GuildCrossWarMonsterAvatar:_didWillExitReborn()

end

function GuildCrossWarMonsterAvatar:_transitionRebornToStand(finishFunc)
    self._nodeRole:setVisible(true)
end

function GuildCrossWarMonsterAvatar:getCurState()
    return self._stateMachine:getCurState()
end

function GuildCrossWarMonsterAvatar:canSwitchToState(nextState, isForceStop)
    return self._stateMachine:canSwitchToState(nextState, isForceStop)
end

function GuildCrossWarMonsterAvatar:_saveSwitchState(state, params)
    logWarn(" GuildCrossWarMonsterAvatar:_saveSwitchState   " .. state)
    if self:canSwitchToState(state, isForceStop) then
        self._stateMachine:switchState(state, params, true)
    end
end

--同步服务器信息
function GuildCrossWarMonsterAvatar:synServerInfo()
-- body
end

return GuildCrossWarMonsterAvatar
