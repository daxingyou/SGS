local BaseData = require("app.data.BaseData")
local PosterGirlPlayUnitData = class("PosterGirlPlayUnitData", BaseData)

local schema = {}
schema["type"] = {"number", 0} 
schema["value"] = {"number", 0} 
schema["totalIdNum"] = {"number", 0} 
PosterGirlPlayUnitData.schema = schema

function PosterGirlPlayUnitData:ctor(properties)
    PosterGirlPlayUnitData.super.ctor(self, properties)
    self._idList = {}
end

function PosterGirlPlayUnitData:clear()
end

function PosterGirlPlayUnitData:reset()
    self._idList = {}
    self:setTotalIdNum(0)
    self:setValue(0)
end

function PosterGirlPlayUnitData:updateData(msg)  
    self:setProperties(msg)
    local rewards = rawget(msg, "rewards") or {}
    local list = {}
    for k,v in ipairs(rewards) do
        list["k_"..v] = v
    end
    logWarn("ssssssssssss"..#rewards)
    self:setTotalIdNum(#rewards)
    logWarn("ssssssssssssss"..self:getTotalIdNum())
    self._idList = list
end

function PosterGirlPlayUnitData:getReceiveIdList()
    return self._idList
end

function PosterGirlPlayUnitData:hasReceive(id)
    return self._idList["k_"..id] ~= nil
end

return PosterGirlPlayUnitData