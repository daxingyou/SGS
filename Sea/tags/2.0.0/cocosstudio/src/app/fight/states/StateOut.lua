--站在场外的状态
local StateIdle = require("app.fight.states.StateIdle")
local StateOut = class("StateOut", StateIdle)

local FightConfig = require("app.fight.Config")

function StateOut:ctor(entity, buffConfig)
    StateOut.super.ctor(self, entity)
end

function StateOut:start()
    StateOut.super.start(self)
end

return StateOut