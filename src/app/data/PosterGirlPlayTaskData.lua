local BaseData = require("app.data.BaseData")
local PosterGirlPlayTaskData = class("PosterGirlPlayTaskData", BaseData)


local schema = {}
schema["type"] = {"number", 0} 
schema["value"] = {"number", 0} 
schema["id"] = {"number", 0} 
schema["receive"] = {"boolean", false} 

PosterGirlPlayTaskData.schema = schema

function PosterGirlPlayTaskData:ctor(properties)
    PosterGirlPlayTaskData.super.ctor(self, properties)
   
end

function PosterGirlPlayTaskData:clear()
end

function PosterGirlPlayTaskData:reset()
end

function PosterGirlPlayTaskData:updateData(id,type,value,isReceive)  
    self:setType(type)
    self:setValue(value)
    self:setId(id)
    self:setReceive(isReceive)
end

function PosterGirlPlayTaskData:getConfig()
    local VipExpLimit = require("app.config.vip_exp_limit")
    local id = self:getId()
    local config =  VipExpLimit.get(id)
    assert(config, "vip_exp_limit not find id "..id)
    return config
end

return PosterGirlPlayTaskData