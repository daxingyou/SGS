local BaseData = require("app.data.BaseData")
local HistoryHeroWeaponUnit = class("HistoryHeroWeaponUnit", BaseData)

local schema = {}
schema["id"] 			            = {"number", 0}
schema["num"]                       = {"number", 0}

HistoryHeroWeaponUnit.schema = schema

function HistoryHeroWeaponUnit:ctor(properties)
    HistoryHeroWeaponUnit.super.ctor(self, properties)
    if properties then
        self:initData(properties)
    end
end

function HistoryHeroWeaponUnit:clear()
end

function HistoryHeroWeaponUnit:reset()	
end

function HistoryHeroWeaponUnit:initData(msg)	
    self:setProperties(msg)
end

return HistoryHeroWeaponUnit