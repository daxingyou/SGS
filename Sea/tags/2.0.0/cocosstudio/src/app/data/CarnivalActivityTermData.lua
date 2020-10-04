-- Author: nieming
-- Date:2018-01-12 21:22:30
-- Describle：一个节日狂欢数据里面的一期

local BaseData = require("app.data.BaseData")
local CarnivalActivityTermData = class("CarnivalActivityTermData", BaseData)

local schema = {}
--schema
schema["term"] = {"number", 0}
schema["preview_time"] = {"number", 0}
schema["start_time"] = {"number", 0}
schema["end_time"] = {"number", 0}
schema["award_time"] = {"number", 0}
schema["state"] = {"number", 0}  --状态
schema["stages"] = {"table", {}}  --页签数据
schema["carnival_id"] = {"number", 0}  --主活动id
schema["term_icon"] = {"number", 0}  --icon

CarnivalActivityTermData.schema = schema
function CarnivalActivityTermData:ctor(properties)
	CarnivalActivityTermData.super.ctor(self, properties)

end

function CarnivalActivityTermData:clear()

end

function CarnivalActivityTermData:reset()

end

--一个页签数据
function CarnivalActivityTermData:getStageDataById(id)
	local stages = self:getStages()
	for _, v in pairs(stages) do
		if v:getId() == id then
			return v
		end
	end
end

--检查活动是否可见
function CarnivalActivityTermData:checkActIsVisible()
    return  self:isActInPreviewTime() or
        self:checkActIsInRunRewardTime()
end

function CarnivalActivityTermData:isActInPreviewTime()
	local time = G_ServerTime:getTime()
	local startTime = self:getStart_time()
	local previewTime = self:getPreview_time()
	if previewTime >= startTime then
		return false
	end	
    return time >= previewTime and time < startTime
end

--检查活动是否在活动时间和领奖时间内
function CarnivalActivityTermData:checkActIsInRunRewardTime()
    local time = G_ServerTime:getTime()
	local startTime = self:getStart_time()
	local endTime = self:getEnd_time()
    local awardTime = self:getAward_time()


    --领奖结束时间或活动结束时间为准
    awardTime = endTime > awardTime and endTime or awardTime

    if awardTime > time and startTime <= time then
        return true
    else
        return false
    end
end

return CarnivalActivityTermData
