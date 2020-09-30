--后加入玩家补偿活动数据类

local ActivityBaseData = require("app.data.ActivityBaseData")
local ActivityConst = require("app.const.ActivityConst")
local BaseData = require("app.data.BaseData")
local TimeConst  = require("app.const.TimeConst")
local ActivityLateRegistUnitData  = require("app.i18n.extends.data.ActivityLateRegistUnitData")
local LateRegistConfig = require("app.config.late_regist")

local ActivityLateRegistData = class("ActivityLateRegistData", BaseData)
local schema = {}
schema["baseActivityData"] 	= {"table", {}}--活动基本数据
schema["days"]				= {"table", {}}--日期差列表

ActivityLateRegistData.schema = schema

function ActivityLateRegistData:ctor(properties)
	ActivityLateRegistData.super.ctor(self, properties)
	self._lateRegistUnitDataList = {}
	self._lateRegistFilterData = {}

	self:setResetTime(TimeConst.RESET_TIME_24)

	local activityBaseData = ActivityBaseData.new()
	activityBaseData:initData({id = ActivityConst.ACT_ID_LATE_REGIST  })
	self:setBaseActivityData(activityBaseData)

	self._s2cGetLateRegistTaskInfoListener = G_NetworkManager:add(MessageIDConst.ID_S2C_GetLateRegistTaskInfo, handler(self, self._s2cGetLateRegistTaskInfo))
	self._s2cGetLateRegistTaskAwardListener = G_NetworkManager:add(MessageIDConst.ID_S2C_GetLateRegistTaskAward, handler(self, self._s2cGetLateRegistTaskAward))
	self._s2cUpdateLateRegistTaskInfoListener = G_NetworkManager:add(MessageIDConst.ID_S2C_UpdateLateRegistTaskInfo, handler(self, self._s2cUpdateLateRegistTaskInfo))
end

-- 清除
function ActivityLateRegistData:clear()
	ActivityLateRegistData.super.clear(self)
	self._s2cGetLateRegistTaskInfoListener:remove()
	self._s2cGetLateRegistTaskInfoListener = nil
	self._s2cGetLateRegistTaskAwardListener:remove()
	self._s2cGetLateRegistTaskAwardListener = nil
	self._s2cUpdateLateRegistTaskInfoListener:remove()
	self._s2cUpdateLateRegistTaskInfoListener = nil

	self:getBaseActivityData():clear()
end

-- 重置
function ActivityLateRegistData:reset()
	ActivityLateRegistData.super.reset(self)
	self:getBaseActivityData():reset()
	self._lateRegistUnitDataList = {}
end

-- function ActivityLateRegistData:_createUnitData(tasks)
-- 	for i,w in ipairs(self._lateRegistFilterData) do
-- 		for k,v in ipairs(tasks) do
-- 			if w.task_type == v.type then
-- 				local actDailySigninUnitData = ActivityLateRegistUnitData.new()
-- 				actDailySigninUnitData:initData(w,v.value,v.award_id)
-- 				self._lateRegistUnitDataList[w.id] = actDailySigninUnitData
-- 				break
-- 			end
-- 		end
-- 	end
-- end

function ActivityLateRegistData:_createUnitData(tasks)
	for i,w in ipairs(self._lateRegistFilterData) do
		for k,v in ipairs(tasks) do
			if w.task_type == v.type then
				if self._lateRegistUnitDataList[w.id] then
					self._lateRegistUnitDataList[w.id]:initData(w,v.value,v.award_id)
				else
					local actDailySigninUnitData = ActivityLateRegistUnitData.new()
					actDailySigninUnitData:initData(w,v.value,v.award_id)
					self._lateRegistUnitDataList[w.id] = actDailySigninUnitData
				end
				break
			end
		end
	end
end

function ActivityLateRegistData:_s2cGetLateRegistTaskInfo(id,message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
	self:getBaseActivityData():setHasData(true)
	self:resetTime()
	self:filterData()
	self._lateRegistUnitDataList = {}

	local tasks = rawget(message,"tasks") or {}
	self:_createUnitData(tasks)

	G_SignalManager:dispatch(SignalConst.EVENT_ACT_LATE_REGIST_TASK_INFO,id,message)
	G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE,FunctionConst.FUNC_WELFARE,{actId = ActivityConst.ACT_ID_LATE_REGIST})
end

function ActivityLateRegistData:_s2cGetLateRegistTaskAward(id,message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
	local taskId = rawget(message,"id")
	if taskId then
		self._lateRegistUnitDataList[taskId]:setReceived(true)
	end
	local awards = rawget(message, "awards") or {}

	G_SignalManager:dispatch(SignalConst.EVENT_ACT_LATE_REGIST_AWARD_SUCCESS, awards)
	G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE,FunctionConst.FUNC_WELFARE,{actId = ActivityConst.ACT_ID_LATE_REGIST } )

end

function ActivityLateRegistData:_s2cUpdateLateRegistTaskInfo(id,message)
	-- if message.ret ~= MessageErrorConst.RET_OK then
	-- 	return
	-- end
	local tasks = rawget(message,"tasks") or {}
	self:_createUnitData(tasks)

	G_SignalManager:dispatch(SignalConst.EVENT_ACT_LATE_REGIST_TASK_INFO,id,message)
	G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE,FunctionConst.FUNC_WELFARE,{actId = ActivityConst.ACT_ID_LATE_REGIST} )
end

function ActivityLateRegistData:getAllUnitDatas()
	return self._lateRegistUnitDataList
end

function ActivityLateRegistData:pullData()
	logWarn("pullData    ActivityLateRegistData ")
	G_NetworkManager:send(MessageIDConst.ID_C2S_GetLateRegistTaskInfo, {})
end

function ActivityLateRegistData:resetData()
	self:pullData()
	self:setNotExpire()--避免重复取数据
end

function ActivityLateRegistData:c2sGetLateRegistTaskAward(id)
	G_NetworkManager:send(MessageIDConst.ID_C2S_GetLateRegistTaskAward, {
		id = id
	})
end

function ActivityLateRegistData:_checkRed(data)
	for k,v in pairs(data) do
		local state = v:isCanReceive() and v:isReachReceiveCondition()
		if state then
			return true
		end
	end
	return false
end

function ActivityLateRegistData:hasRedPoint()
	local allUnitData = self:getAllUnitDatas()
	return self:_checkRed(allUnitData)
end

function ActivityLateRegistData:hasRedPointByDay(day)
	local allUnitData = self:getUnitDatasByDay(day,false)
	return self:_checkRed(allUnitData)
end

function ActivityLateRegistData:isOpen()
	return false
end

function ActivityLateRegistData:filterData()
	self._lateRegistFilterData = {}

	local curTime = G_ServerTime:getTime()

	local openTime = G_UserData:getBase():getServer_open_time()
	local openObject = G_ServerTime:getDateObject(openTime)
	local openZeroTime = openTime - openObject.hour*3600 - openObject.min*60 - openObject.sec

	local createTime = G_UserData:getBase():getCreate_time()
    local createObject = G_ServerTime:getDateObject(createTime)
	local createZeroTime = createTime - createObject.hour*3600 - createObject.min*60 - createObject.sec

	if curTime - createZeroTime >= TimeConst.SECONDS_ONE_DAY then
		return
	end

	local deltaDays = math.floor((createTime - openZeroTime) / TimeConst.SECONDS_ONE_DAY)
	print("lkm deltaDays",deltaDays)

	local tempData = {}
	local dayMax = 0
	for i=1, LateRegistConfig.length() do
		local info = LateRegistConfig.indexOf(i)
		local weekdays = string.split(info.week,",")
		local weekDay = G_ServerTime:getDateObject().wday
		weekDay = weekDay -1
		if weekDay == 0 then
			weekDay = 7
		end
		for i,v in ipairs(weekdays) do
			if tonumber(v) == weekDay then
				table.insert(tempData,info)
				if info.day_between > dayMax then
					dayMax = info.day_between
				end
				break
			end
		end
	end

	if deltaDays > dayMax then
		return
	end

	local days = {}
	for i,v in ipairs(tempData) do
		if deltaDays >= v.day_between then
			table.insert(self._lateRegistFilterData,v)
			days[v.day_between] = v.day_between
		end
	end

	self:setDays(table.keys(days))

end

function ActivityLateRegistData:getUnitDatasByDay(day,needSort)
	local list = {}
	for k,v in pairs(self._lateRegistUnitDataList) do
		if v:getConfig().day_between == day then
			table.insert( list, v )
		end
	end

	if needSort then
		local sortFuc = function(item01,item02)
			local canReceive01 = item01:isCanReceive()
			local canReceive02 = item02:isCanReceive()
			if canReceive01 ~= canReceive02 then
				return canReceive01
			end
			local reachCondition01 = item01:isReachReceiveCondition()
			local reachCondition02 = item02:isReachReceiveCondition()
			if reachCondition01 ~= reachCondition02 then
				  return reachCondition01
			end
			return item01:getOrder() < item02:getOrder()
		end
		table.sort(list,sortFuc)
	end

	return list
end

return ActivityLateRegistData