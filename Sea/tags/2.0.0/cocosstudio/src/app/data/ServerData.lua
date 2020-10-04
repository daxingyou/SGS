local BaseData = require("app.data.BaseData")
local ServerData = class("ServerData", BaseData)

local schema = {}

schema["name"] 		= {"string", ""}
schema["status"] 	= {"number", 0}
schema["server"] 	= {"number", 0}
schema["opentime"] 	= {"string", ""}
schema["hide"]		= {"boolean", false}

ServerData.schema = schema

--
function ServerData:ctor(properties)
	ServerData.super.ctor(self, properties)
end

return ServerData