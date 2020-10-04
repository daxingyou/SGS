-- @Author  panhoa
-- @Date  2.18.2019
-- @Role 

local BaseData = require("app.data.BaseData")
local GuildCrossWarPointUnitData = class("GuildCrossWarPointUnitData", BaseData)
local schema = {}


schema["key_point_id"]      = {"number", 0}     --据点id
schema["guild_id"]          = {"number", 0}     --占领公会id
schema["guild_name"]        = {"string", ""}    --占领公会名称
schema["sid"]               = {"number", 0}     --服务器id
schema["sname"]             = {"string", ""}    --服务器名称
schema["action"]            = {"action", 0}     --0 -击败守卫  1- 攻陷据点

GuildCrossWarPointUnitData.schema = schema
function GuildCrossWarPointUnitData:ctor(properties)
    GuildCrossWarPointUnitData.super.ctor(self, properties)
end

function GuildCrossWarPointUnitData:clear()
end

function GuildCrossWarPointUnitData:reset()
end

function GuildCrossWarPointUnitData:updateData(data)
    self:setProperties(data)
end

function GuildCrossWarPointUnitData:isSelfGuild()
    -- body
    return self:getGuild_id() == G_UserData:getGuild():getMyGuildId()
end


return GuildCrossWarPointUnitData