local BaseData = require("app.data.BaseData")
local SliencedUserData = class("ChapterData", BaseData)

local schema = {}
schema["user_id"] 			                    = {"number", 0}
schema["end_time"] 			                    = {"number", 0}

SliencedUserData.schema = schema

function SliencedUserData:ctor(properties)
    SliencedUserData.super.ctor(self, properties)
end

function SliencedUserData:clear()
end

function SliencedUserData:reset()
end

function SliencedUserData:updateData(data)
	self:setProperties(data)
end


return SliencedUserData
