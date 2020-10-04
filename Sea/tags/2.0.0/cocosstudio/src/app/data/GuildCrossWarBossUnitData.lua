-- @Author  panhoa
-- @Date  2.18.2019
-- @Role 

local BaseData = require("app.data.BaseData")
local GuildCrossWarBossUnitData = class("GuildCrossWarBossUnitData", BaseData)
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local GuildCrossWarHelper = require("app.scene.view.guildCrossWar.GuildCrossWarHelper")


local schema = {}
schema["id"]                = {"number", 0}     --据点ID
schema["hp"]                = {"number", 0}     --据点boss血量
schema["max_hp"]            = {"number", 0}     --据点boss最大血量
schema["config"]            = {"table", {}}     --据点Boss配置

GuildCrossWarBossUnitData.schema = schema
function GuildCrossWarBossUnitData:ctor(properties)
    GuildCrossWarBossUnitData.super.ctor(self, properties)
end

function GuildCrossWarBossUnitData:clear()
end

function GuildCrossWarBossUnitData:reset()
end

-- @Role    Update Data
function GuildCrossWarBossUnitData:updateData(data)
    self:setProperties(data)
end

-- @Role    Get Boss's State
function GuildCrossWarBossUnitData:getCurState()
    local function getState( ... )
        
        if self:getHp() == self:getMax_hp() and self:getMax_hp() > 0 then
            print("getState 111")
            return GuildCrossWarConst.BOSS_STATE_IDLE, 
                        Lang.get("guild_cross_war_bossstate_2")
        elseif self:getHp() > 0 and self:getHp() < self:getMax_hp() then
            print("getState 222")
            return GuildCrossWarConst.BOSS_STATE_PK,
                        Lang.get("guild_cross_war_bossstate_2")
        elseif self:getHp() <= 0 then
            print("getState 333")
            return GuildCrossWarConst.BOSS_STATE_DEATH,
                        Lang.get("guild_cross_war_bossstate_2")
        end
    end

    print("GuildCrossWarBossUnitData:getCurState 111")
    dump(self:getHp())
    dump(self:getMax_hp())
    local state, _ = GuildCrossWarHelper.getCurCrossWarStage()

    dump(state)
    if GuildCrossWarConst.ACTIVITY_STAGE_1 == state then
        print("GuildCrossWarBossUnitData:getCurState 222")
        return GuildCrossWarConst.BOSS_STATE_IDLE,
                        Lang.get("guild_cross_war_bossstate_1")
    elseif GuildCrossWarConst.ACTIVITY_STAGE_2 == state then
        print("GuildCrossWarBossUnitData:getCurState 333")
        local curState, strDesc = getState()
        dump(curState)
       return curState, strDesc
    else
        print("GuildCrossWarBossUnitData:getCurState 444")
        return GuildCrossWarConst.BOSS_STATE_DEATH, ""
    end
end


return GuildCrossWarBossUnitData