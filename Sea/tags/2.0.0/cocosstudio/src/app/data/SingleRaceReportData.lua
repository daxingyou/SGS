
--跨服个人竞技战报数据
local BaseData = require("app.data.BaseData")
local SingleRaceReportData = class("SingleRaceReportData", BaseData)
local SingleRaceConst = require("app.const.SingleRaceConst")

local schema = {}
schema["position"] = {"number", 0}
schema["battle_no"] = {"number", 0}
schema["atk_user"] = {"number", 0}
schema["def_user"] = {"number", 0}
schema["win_user"] = {"number", 0}
schema["first_hand"] = {"number", 0}
schema["atk_power"] = {"number", 0}
schema["def_power"] = {"number", 0}
schema["atk_heros"] = {"table", {}}
schema["def_heros"] = {"table", {}}
schema["report_id"] = {"number", 0}
schema["winnerSide"] = {"number", 0}
SingleRaceReportData.schema = schema

function SingleRaceReportData:ctor(properties)
	SingleRaceReportData.super.ctor(self, properties)
end

function SingleRaceReportData:clear()
	
end

function SingleRaceReportData:reset()
	
end

function SingleRaceReportData:updateData(data)
	self:setProperties(data)
	local userId1 = self:getAtk_user()
	local userId2 = self:getDef_user()
	local winUserId = self:getWin_user()
	if winUserId == userId1 then
		self:setWinnerSide(SingleRaceConst.REPORT_SIDE_1)
	elseif winUserId == userId2 then
		self:setWinnerSide(SingleRaceConst.REPORT_SIDE_2)
	end
end

return SingleRaceReportData