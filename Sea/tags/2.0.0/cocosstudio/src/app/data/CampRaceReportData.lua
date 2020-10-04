local BaseData = require("app.data.BaseData")
local CampRaceReportData = class("CampRaceReportData", BaseData)

local schema = {}
schema["id"] = {"number", 0}
schema["camp"] = {"number", 0}
schema["pos1"] = {"number", 0}
schema["pos2"] = {"number", 0}
schema["win_pos"] = {"number", 0}
schema["first_hand"] = {"number", 0}
schema["left_power"] = {"number", 0}
schema["left_heros"] = {"table", {}}
schema["right_power"] = {"number", 0}
schema["right_heros"] = {"table", {}}
schema["report_id"] = {"number", 0}
CampRaceReportData.schema = schema

function CampRaceReportData:ctor(properties)
    CampRaceReportData.super.ctor(self, properties)
end

function CampRaceReportData:clear()
	
end

function CampRaceReportData:reset()
	
end

return CampRaceReportData