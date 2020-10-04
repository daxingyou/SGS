--好友邀请活动数据类
--@Author:Conley
local ActivityBaseData = import(".ActivityBaseData")
local BaseData = require("app.data.BaseData")
local friend_invite = require("app.config.friend_invite")
local ActivityConst = require("app.const.ActivityConst")
local DinnerConst = require("app.const.DinnerConst")
local ActivityFriendInviteData = class("ActivityFriendInviteData", BaseData)
local TimeConst = require("app.const.TimeConst")
local friend_invite = require("app.config.friend_invite")

 
local schema = {}
--schema["inviteDatas"] 	 = {"table", {}}  
schema["code"] 	        = {"string", ""} -- 邀请码
schema["becode"] 	    = {"string", ""} -- 被邀请码
schema["day"] 	   		= {"number", 0}  -- 被邀请码
schema["rewardid"] 	   		= {"table", {}}  -- 奖励列表
schema["userInviteInfo"]    = {"table", {}}  -- 邀请信息列表
schema["baseActivityData"] 	= {"table", {}}	 --基本活动数据  

ActivityFriendInviteData.schema = schema
ActivityFriendInviteData.INVITE_END_TIME = 56000  --开服后多少天该活动消失
function ActivityFriendInviteData:ctor(properties)
	ActivityFriendInviteData.super.ctor(self, properties)


	local activityBaseData = ActivityBaseData.new()
	activityBaseData:initData({id = ActivityConst.ACT_ID_FRIEND_INVITE  })
	self:setBaseActivityData(activityBaseData)

	self._s2cWriteInviteListener = G_NetworkManager:add(MessageIDConst.ID_S2C_WriteInvite, handler(self, self._s2cGetWriteInvite))
	self._s2cMyInviteInfListener = G_NetworkManager:add(MessageIDConst.ID_S2C_MyInviteInfo, handler(self, self._s2cMyInviteInfo))
	self._s2cInviteRewardListener = G_NetworkManager:add(MessageIDConst.ID_S2C_InviteReward, handler(self, self._s2cInviteReward))
end

-- 清除
function ActivityFriendInviteData:clear()
	ActivityFriendInviteData.super.clear(self)
	self._s2cWriteInviteListener:remove()
	self._s2cWriteInviteListener = nil

	self._s2cMyInviteInfListener:remove()
	self._s2cMyInviteInfListener = nil

	self._s2cInviteRewardListener:remove()
	self._s2cInviteRewardListener = nil

 

	self:getBaseActivityData():clear()
end

-- 重置
function ActivityFriendInviteData:reset()
	ActivityFriendInviteData.super.reset(self)
	self:getBaseActivityData():reset()

	-- self._unitDataList = {}
	-- self._todayUnitDataList =  
end
 
function ActivityFriendInviteData:_makeKey(day,id)
	return tostring(day).."_"..id
end 

function ActivityFriendInviteData:_s2cGetWriteInvite(id,message)
	-- if message.ret ~= MessageErrorConst.RET_OK then
	-- 	return
	-- end

	--self:setBecode(rawget(message, "becode") or "")
	G_SignalManager:dispatch(SignalConst.EVENT_WELFARE_WRITE_INVITE,id,message)
end

function ActivityFriendInviteData:_s2cMyInviteInfo(id,message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
	self:getBaseActivityData():setHasData(true)
  
	self:setCode(rawget(message, "code") or "")    
	self:setBecode(rawget(message, "becode") or "")
	self:setDay(rawget(message, "day") or 0)   
	self:setRewardid(rawget(message, "rewardid") or {})   
	self:setUserInviteInfo(rawget(message, "info") or {})   
	
	G_SignalManager:dispatch(SignalConst.EVENT_WELFARE_FRIEND_INVITE_INFO,id,message)  
	G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE,FunctionConst.FUNC_WELFARE,{actId = ActivityConst.ACT_ID_FRIEND_INVITE})
end
 
function ActivityFriendInviteData:_s2cInviteReward(id,message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end

	self:setRewardid(rawget(message, "rewardid") or {})  
	G_SignalManager:dispatch(SignalConst.EVENT_WELFARE_INVITE_REWARD,id,message)
end
 
function ActivityFriendInviteData:c2sGetWriteInvite(code)
	G_NetworkManager:send(MessageIDConst.ID_C2S_WriteInvite, {code = code})
end

-- 请求邀请码信息
function ActivityFriendInviteData:c2sMyInviteInfo()
	G_NetworkManager:send(MessageIDConst.ID_C2S_MyInviteInfo, {})
end

-- 请求奖励
function ActivityFriendInviteData:c2sInviteReward(id) 
 
	G_NetworkManager:send(MessageIDConst.ID_C2S_InviteReward, {id = id})
end

--通过ID，拉取对应活动服务器数据
function ActivityFriendInviteData:pullData()
	logWarn("pullData    ActivityFriendInviteData ")
	self:c2sMyInviteInfo() 
end

function ActivityFriendInviteData:hasRedPoint()
	local cfg = {}
	local getCfg = function ()
		local len = friend_invite.length()
		for i = 1, len do
			local info = friend_invite.indexOf(i)
			cfg[info.id] = info
		end
	end
	getCfg() --配表信息
	local tab1 = {} 
	local tab2 = {}
	for index = 1, #cfg do
		if cfg[index].tab == 1 then
			table.insert(tab1, cfg[index])	
		elseif cfg[index].tab == 2 then   
			table.insert(tab2, cfg[index])	
		end	
	end

	-- 邀请信息有可领取时
	for index = 1, #tab1 do
		local id = tab1[index].id
		if self:_isHaveGetRewardCode(id) == false then
			if self:_isUnReceiveState(id) then
				return true
			end
		end
	end

	if self:getBecode() == "" then 
		return false
	end
	-- 受邀信息有可领取
	for i=1, #tab2 do
		if self:_isHaveGetRewardCode(tab2[i].id) == false then
			if i == 1 then
				return true
			elseif i>=2 and i<=4 and self:getDay() >= tab2[i].require_value1 then 
				return true
			elseif i>=5 and i<=7 and G_UserData:getBase():getLevel() >= tab2[i].require_value1 then 
				return true
			end
		end
	end

	return false
end

function ActivityFriendInviteData:_isHaveGetRewardCode(id)
	local rewardid = self:getRewardid()
	for key, value in pairs(rewardid) do
		if value == id then
			return true
		end
	end
	return false
end

function ActivityFriendInviteData:_isUnReceiveState(id)
	local userInviteInfo =  self:getUserInviteInfo()
	local info = friend_invite.get(id)
	if id <= 3 then
		return #userInviteInfo >= info.require_value1
	elseif id > 3 and id < 7 then
		local bNum = #userInviteInfo >= info.require_value1
		-- 等级
		local nNum = 0
		local bLevel = false 
		for index = 1, #userInviteInfo do
			if userInviteInfo[index].level >=  info.require_value2 then
				nNum = nNum + 1
			end
		end
		if nNum >= info.require_value1 then
			bLevel = true
		end

		return (bNum and bLevel)
	elseif id >= 7 and id <= 9 then
		local bNum = #userInviteInfo >= info.require_value1
		-- 战力
		local nNum = 0
		local bPower = false 
		for index = 1, #userInviteInfo do
			if userInviteInfo[index].power >= info.require_value2 then
				nNum = nNum + 1
			end
		end
		if nNum >= info.require_value1 then
			bPower = true
		end
	
		return (bNum and bPower)
	end	
end
 
function ActivityFriendInviteData:isOpen()
	local openServerDay = G_UserData:getBase():getOpenServerDayNum()
	local Parameter = require("app.config.parameter")
	local info = Parameter.get(ActivityFriendInviteData.INVITE_END_TIME)  
	if openServerDay > tonumber(info.content) then
		return false
	end
	return true
end

 

return ActivityFriendInviteData
 
 