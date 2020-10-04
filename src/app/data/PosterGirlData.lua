
local VipConst = require("app.const.VipConst")
local PosterGirlPlayUnitData = require("app.data.PosterGirlPlayUnitData")
local PosterGirlPlayTaskData =  require("app.data.PosterGirlPlayTaskData")
local BaseData = require("app.data.BaseData")
local PosterGirlData = class("PosterGirlData", BaseData)

local schema = {}
schema["wear_skin"] = {"number", 0} 
PosterGirlData.schema = schema

function PosterGirlData:ctor(properties)
	PosterGirlData.super.ctor(self, properties)

	self._signalGetPosterGirl = G_NetworkManager:add(MessageIDConst.ID_S2C_GetPosterGirl, handler(self, self._s2cGetPosterGirl))
	self._signalSetPosterGirlSkin = G_NetworkManager:add(MessageIDConst.ID_S2C_SetPosterGirlSkin, handler(self, self._s2cSetPosterGirlSkin))
	self._signalPlayWithPosterGirl = G_NetworkManager:add(MessageIDConst.ID_S2C_PlayWithPosterGirl, handler(self, self._s2cPlayWithPosterGirl))
	self._signalGetPosterGirlRewardInfo = G_NetworkManager:add(MessageIDConst.ID_S2C_GetPosterGirlRewardInfo, handler(self, self._s2cGetPosterGirlRewardInfo))
	self._signalAllDataReady   = G_SignalManager:add(SignalConst.EVENT_RECV_FLUSH_DATA, handler(self, self._onAllDataReady))                            -- 断线重连
	

	self._skinList = {}
	self._playDataList = {}
	self._taskMap = {}

	self:_initAllTaskData()
end

function PosterGirlData:clear()
	self._signalGetPosterGirl:remove()
	self._signalGetPosterGirl = nil

	self._signalSetPosterGirlSkin:remove()
	self._signalSetPosterGirlSkin = nil

	self._signalPlayWithPosterGirl:remove()
	self._signalPlayWithPosterGirl = nil

	self._signalGetPosterGirlRewardInfo:remove()
	self._signalGetPosterGirlRewardInfo = nil

	self._signalAllDataReady:remove()
	self._signalAllDataReady = nil
	
end

function PosterGirlData:reset()
	self._taskMap = {}
end

function PosterGirlData:_initAllTaskData()
	self._playDataList = {}
	self._taskMap = {}
	local VipExpLimit = require("app.config.vip_exp_limit")
	for k = 1,VipExpLimit.length(),1 do
		local config = VipExpLimit.indexOf(k)
		 local taskData = PosterGirlPlayTaskData.new()
		 taskData:updateData(config.id,config.type,0,false)
		 self._taskMap[config.type.."_"..config.id] = taskData

		if not self._playDataList[config.type] then
			local unitData = PosterGirlPlayUnitData.new()
			unitData:setType(config.type)
			self._playDataList[config.type] = unitData
		end
	end
end


-- @Role    断线重连
function PosterGirlData:_onAllDataReady()
    self:_registerClock()
end



function PosterGirlData:updateData(data)
	if data == nil or type(data) ~= "table" then
		return
	end
	for k,v in ipairs(data) do
		table.insert(self._skinList,v)
    end

    G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_SKIN_UPDATE)
end

function PosterGirlData:_s2cGetPosterGirl(id, message)
    if rawget(message,"wear_skin") then
        self:setWear_skin(rawget(message,"wear_skin"))
    end
    local skins = rawget(message,"skins") or {}
    self._skinList = {}
    self:updateData(skins)

	G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_SKIN_INFO_GET)
end

function PosterGirlData:c2sSetPosterGirlSkin(skin_id)
	G_NetworkManager:send(
		MessageIDConst.ID_C2S_SetPosterGirlSkin,
		{
			skin_id = skin_id,
		}
	)
end

function PosterGirlData:_s2cSetPosterGirlSkin(id, message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
end

function PosterGirlData:c2sPlayWithPosterGirl(taskId,rewards)
	G_NetworkManager:send(
		MessageIDConst.ID_C2S_PlayWithPosterGirl,
		{
			task_id = taskId,
			rewards = rewards or {}
		}
	
	)
end

function PosterGirlData:_s2cPlayWithPosterGirl(id, message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
	G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_BOX_RECEIVE_SUCCESS,message.awards)
end



function PosterGirlData:c2sGetPosterGirlRewardInfo()
	G_NetworkManager:send(
		MessageIDConst.ID_C2S_GetPosterGirlRewardInfo,
		{
		}
	)
end

function PosterGirlData:_s2cGetPosterGirlRewardInfo(id, message)
	local tasks = rawget(message,"tasks") or {}

	for k,v in ipairs(tasks) do

		if self._playDataList[v.type] then
			self._playDataList[v.type]:updateData(v)
		end
		for k,taskId in ipairs(v.rewards) do
			local taskData = self._taskMap[v.type.."_"..taskId]
			if taskData then
				taskData:setReceive(true)
			end
		end
	end

	self:_registerClock()
	
	G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_BOX_INFO_UPDATE)
	G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE, FunctionConst.FUNC_JADE2)
end

function PosterGirlData:_registerClock()
	local getLastUpDateTime = function(type)
		local onlineTime = G_UserData:getBase():getOnlineTime()
		local list = self:getAllTaskDatasByType(type)
		local lastUpdateTime = nil
		for k ,v in ipairs(list) do
			if onlineTime < v:getConfig().require_value * 60 then
				local curTime = G_ServerTime:getTime()
				lastUpdateTime = curTime + v:getConfig().require_value * 60 - onlineTime
				break
			end
		end
		return lastUpdateTime
	end
	local lastTime1 = getLastUpDateTime(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
	local lastTime2 = getLastUpDateTime(VipConst.VIP_ADD_EXP_TYPE_CLICK_POSTER_GIRL)
	local time = 0
	if lastTime1 and lastTime2 then
		time = math.min(lastTime1,lastTime2)
	elseif lastTime1 then
		time = lastTime1
	elseif lastTime2 then
		time = lastTime2
	end
	if time ~= 0 then
		G_ServiceManager:registerOneAlarmClock("PosterGirlData", time, function()
			G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE, FunctionConst.FUNC_JADE2)
		end)
	end	
end


function PosterGirlData:getSkinList()
    return self._skinList
end

function PosterGirlData:getDailyAddVipValue()
	local DailyCountData = require("app.data.DailyCountData")
    return G_UserData:getDailyCount():getCountById(DailyCountData.DAILY_RECORD_ADD_VIP_EXP_PLAY) 
end

function PosterGirlData:getPlayUnitDataByType(type)
    return self._playDataList[type]
end

--有宝箱奖励可以领取
function PosterGirlData:hasRedPoint()

	if self:hasRedPointByType(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD) then
		return true
	end
	if self:hasRedPointByType(VipConst.VIP_ADD_EXP_TYPE_CLICK_POSTER_GIRL) then
		return true
	end
	return false
end

function PosterGirlData:hasRedPointByType(type)
	local onlineTime = G_UserData:getBase():getOnlineTime()
	local list = self:getAllTaskDatasByType(type)
	for k,v in ipairs(list) do
		if not v:isReceive() then
			if onlineTime >= v:getConfig().require_value * 60 then
				return true
			end
		end
	end
	return false
end

function PosterGirlData:getAllTaskDatasByType(type)
    local list = {}
	for k,v in pairs(self._taskMap) do
		if v:getType() == type then
			table.insert(list, v)
		end
    end
    table.sort(list,function(left,right)
        return left:getId() < right:getId()
    end)
    return list
end


return PosterGirlData
