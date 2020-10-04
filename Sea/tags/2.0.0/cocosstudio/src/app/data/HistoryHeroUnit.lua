
local BaseData = require("app.data.BaseData")
local HistoryHeroUnit = class("HistoryHeroUnit", BaseData)


local schema = {}
schema["id"]				= {"number", 0}
schema["system_id"] 		= {"number", 0} 
schema["break_through"] 	= {"number", 0} 
schema["materials"]         = {"table", {}} -- 当前穿戴装备

HistoryHeroUnit.schema = schema
function HistoryHeroUnit:ctor(properties)
    HistoryHeroUnit.super.ctor(self)
    if properties then
        self:initData(properties)
    end
end

function HistoryHeroUnit:clear()
end

function HistoryHeroUnit:reset()
end

function HistoryHeroUnit:initData(msg)
    self:setProperties(msg)
end

function HistoryHeroUnit:updateID(id)
    self:setId(id)
end

function HistoryHeroUnit:updateSystemId(systemId)
    self:setSystem_id(systemId)
end

function HistoryHeroUnit:updateBreakThrough(breakThrough)
    self:setBreak_through(breakThrough)
end

--是否能养成
function HistoryHeroUnit:isCanTrain()
	return true
end

return HistoryHeroUnit