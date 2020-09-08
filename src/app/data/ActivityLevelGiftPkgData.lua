--等级礼包活动数据类
--@Author:Conley
local ActivityBaseData = import(".ActivityBaseData")
local ActivityConst = require("app.const.ActivityConst")
local ActivityLevelGiftConfig = require("app.config.act_level_discount")
local VipPayConfig = require("app.config.vip_pay")
local LevelPkgConst = require("app.const.LevelPkgConst")--i18n ja
local BaseData = require("app.data.BaseData")


--=======================================================
local ActivityLevelGiftPkgUnitData =  class("ActivityLevelGiftPkgData", BaseData)
local schema = {}
schema["config"] 	= {"table", {}}--基本活动数据
schema["id"] 	= {"number",0}--
schema["start_time"] 	= {"number",0}
schema["is_buy"] 	= {"bool",false}
schema["vipConfig"] 	= {"table", {}}
ActivityLevelGiftPkgUnitData.schema = schema

function ActivityLevelGiftPkgUnitData:ctor(properties)
	ActivityLevelGiftPkgUnitData.super.ctor(self, properties)
end

function ActivityLevelGiftPkgUnitData:isReachUnLockLevel()
	
	local config = self:getConfig()
	if Lang.checkUI("ui4") then
		if config.condition == LevelPkgConst.CONDITION_LEVEL then
			local curLevel = G_UserData:getBase():getLevel()
			logWarn("level now： " .. curLevel.." xxxxxxxxxx target: "..config.require_value)
			if curLevel >= config.require_value then
				return true
			end
		elseif config.condition == LevelPkgConst.CONDITION_STAGE then 
			local chapterData = G_UserData:getChapter():getGlobalChapterById(config.require_value)   --对应章节数据
			if chapterData and chapterData:isLastStagePass()  then
				return true
			end
			--[[
			if G_UserData:getStage():isStageOpen(config.require_value) then
				return true
			end
			]]
		elseif config.condition == LevelPkgConst.CONDITION_EXPLORE then
			local pass = G_UserData:getExplore():isExplorePass(config.require_value)
			if pass then
				return true
			end
		elseif config.condition == LevelPkgConst.CONDITION_POWER then
			local curPower = G_UserData:getBase():getPower() 
			logWarn("power now： " .. curPower.." xxxxxxxxxx target: "..config.require_value)
			if curPower >= config.require_value then
				return true
			end
		end
		
	else
		local curLevel = G_UserData:getBase():getLevel()
		if curLevel >= config.unlock_level then
			return true
		end
	end
	
	return false
end

function ActivityLevelGiftPkgUnitData:isReachShowLevel()
	if Lang.checkUI("ui4") then
		return self:isReachUnLockLevel()
	end
	local curLevel = G_UserData:getBase():getLevel()
	local config = self:getConfig()
	if curLevel >= config.show_level then
		return true
	end
	return fasle
end

function ActivityLevelGiftPkgUnitData:getLimitTime()
	local config = self:getConfig()
	local hour = 60 * 60
	return config.time_limit * hour
end

function ActivityLevelGiftPkgUnitData:isTimeOut()
	local curTime = G_ServerTime:getTime()
	local startTime = self:getStart_time()
	local endTime = startTime + self:getLimitTime()
	if startTime ~= 0 then
		local leftTime = endTime - curTime
		return leftTime < 0 , endTime
	else
		return true , endTime
	end
end


--=======================================================

--=======================================================
local ActivityLevelGiftPkgData = class("ActivityLevelGiftPkgData", BaseData)
local schema = {}
schema["baseActivityData"] 	= {"table", {}}--基本活动数据
ActivityLevelGiftPkgData.schema = schema

function ActivityLevelGiftPkgData:ctor(properties)
	ActivityLevelGiftPkgData.super.ctor(self, properties)

	local activityBaseData = ActivityBaseData.new()
	activityBaseData:initData({id = ActivityConst.ACT_ID_LEVEL_GIFT_PKG  })
	self:setBaseActivityData(activityBaseData)

	self._signalRecvGetActLevelDiscount = G_NetworkManager:add(MessageIDConst.ID_S2C_GetActLevelDiscount, handler(self, self._s2cGetActLevelDiscount))
	self._signalRecvActLevelDiscountAward = G_NetworkManager:add(MessageIDConst.ID_S2C_ActLevelDiscountAward, handler(self, self._s2cActLevelDiscountAward))

	self._signalUserLevelUpdate = G_SignalManager:add(SignalConst.EVENT_USER_LEVELUP, handler(self, self._onEventUserLevelUpdate))
	self._isNeedCleanTodayTag = false
	self:_initUnitData()

end

function ActivityLevelGiftPkgData:pullData()
	return self:checkDataDirty() --i18n ja add
end

-- 清除
function ActivityLevelGiftPkgData:clear()
	self._signalRecvGetActLevelDiscount:remove()
	self._signalRecvGetActLevelDiscount = nil

	self._signalRecvActLevelDiscountAward:remove()
	self._signalRecvActLevelDiscountAward = nil

	self._signalUserLevelUpdate:remove()
	self._signalUserLevelUpdate = nil

	self._isNeedCleanTodayTag = false
end

-- 重置
function ActivityLevelGiftPkgData:reset()
	self._isNeedCleanTodayTag = false
end

function ActivityLevelGiftPkgData:canBuy()
	for _, v in ipairs(self._unitDatas)do
		if v:isReachUnLockLevel() and not v:getIs_buy() and not v:isTimeOut() then
			return true
		end
	end
	return false
end

function ActivityLevelGiftPkgData:hasRedPoint()
	self:_clearTodayClickRedPointShowFlag()
	local showed = G_UserData:getRedPoint():isTodayShowedRedPointByFuncId(
		FunctionConst.FUNC_WELFARE,{actId = ActivityConst.ACT_ID_LEVEL_GIFT_PKG}
    )
	if showed then
		return false
	end

	return self:canBuy()
end

--当等级提升的时候 如果可以购买新的
function ActivityLevelGiftPkgData:_onEventUserLevelUpdate()
	self._isNeedCleanTodayTag = true


end

function ActivityLevelGiftPkgData:_clearTodayClickRedPointShowFlag()
	if not self._isNeedCleanTodayTag then
		return
	end
	self._isNeedCleanTodayTag = false
	if Lang.checkUI("ui4") then
		return
	end
	local curLevel = G_UserData:getBase():getLevel()
	for _, v in ipairs(self._unitDatas)do
		local config = v:getConfig()
		if curLevel == config.unlock_level then
			if v:isReachUnLockLevel() and not v:getIs_buy() and not v:isTimeOut() then
				G_UserData:getRedPoint():clearRedPointShowFlag(
					FunctionConst.FUNC_WELFARE,{actId = ActivityConst.ACT_ID_LEVEL_GIFT_PKG}
				)
				return
			end
		end
	end
end

function ActivityLevelGiftPkgData:_initUnitData()
	self._unitDatas = {}
	local indexs = ActivityLevelGiftConfig.index()
	for _, v in pairs(indexs) do
		self:_updateUnitData(v)
	end
end


function ActivityLevelGiftPkgData:_updateUnitData(id, data)
	local unitData
	if not self._unitDatas[id] then
		unitData = ActivityLevelGiftPkgUnitData.new()
		self._unitDatas[id] = unitData
		local config = ActivityLevelGiftConfig.indexOf(id)
		assert(config ~= nil, string.format("can not find level gift id = %s", id or "nil"))
		unitData:setConfig(config)
		unitData:setId(id)
		local vipConfig = VipPayConfig.get(config.good_id)
		assert(vipConfig ~= nil, string.format("can not find level gift id = %s", config.good_id or "nil"))
		unitData:setVipConfig(vipConfig)
	end
	unitData = self._unitDatas[id]
	if data then
		unitData:setStart_time(data.start_time)
		unitData:setIs_buy(data.buy > 0)

		--当满足等级后 咩有购买 时间到了  应该要刷新小红点
		if data.start_time ~= 0 then
			G_ServiceManager:registerOneAlarmClock("WELFARE_LEVEL_GIFT"..id, data.start_time + unitData:getLimitTime() + 1, function()
				G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE, FunctionConst.FUNC_WELFARE)
			end)
		end
	end
end


function ActivityLevelGiftPkgData:c2sGetActLevelDiscount()
	G_NetworkManager:send(MessageIDConst.ID_C2S_GetActLevelDiscount, {

	})
end
-- Describle：
function ActivityLevelGiftPkgData:_s2cGetActLevelDiscount(id, message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
	--i18n ja
 	local unitList = G_UserData:getActivityLevelGiftPkg():getListViewData()
	local unitMap = {}
	for k,v in ipairs(unitList) do
		unitMap[v:getId()] = v
	end
	--check data
	local level_discount = rawget(message, "level_discount")
	if level_discount then
		for _, v in pairs(level_discount) do
			self:_updateUnitData(v.id, v)
		end
	end
	--i18n ja
	local newAddUnitList = {}
	local newUnitList = G_UserData:getActivityLevelGiftPkg():getListViewData()
	for k,v in ipairs(newUnitList) do
		if not unitMap[v:getId()] then
			table.insert(newAddUnitList,v)
		end
	end
	print("ActivityLevelGiftPkgData _s2cGetActLevelDiscount")
	G_SignalManager:dispatch(SignalConst.EVENT_WELFARE_LEVEL_GIFT_INFO,newAddUnitList)--i18n ja add param
	G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_UPDATE, FunctionConst.FUNC_WELFARE)
	G_SignalManager:dispatch(SignalConst.EVENT_MAIN_CITY_CHECK_BTNS, FunctionConst.FUNC_LEVEL_GIFTPKG)-- i18n ja
end

function ActivityLevelGiftPkgData:_s2cActLevelDiscountAward(id, message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
	--check data
	local awards = rawget(message, "awards")
	if awards then
		G_SignalManager:dispatch(SignalConst.EVENT_WELFARE_LEVEL_GIFT_AWARD, awards)
	end
end

function ActivityLevelGiftPkgData:checkDataDirty()
	local datas = {}
	for _, v in ipairs(self._unitDatas)do
		if v:isReachUnLockLevel() and v:getStart_time() == 0 then
			self:c2sGetActLevelDiscount()
			return true --i18n ja add
		end
	end
	return false --i18n ja add
end



function ActivityLevelGiftPkgData:getListViewData()
	local datas = {}
	for _, v in ipairs(self._unitDatas)do
		-- appstore 送审状态 全部显示
		if G_ConfigManager:isAppstore()  then
			if not Lang.checkUI("ui4") then--i18n ja
				table.insert(datas, v)
			end
		else
			local isTimeOut = v:isTimeOut()
			-- 达到显示等级并且没有购买
			if v:isReachShowLevel() and not v:getIs_buy()  then
				if not v:isReachUnLockLevel() then --没达到解锁等级
					logWarn("ssssssssssssssss")
					table.insert(datas, v)
				elseif not isTimeOut then --没超时
					logWarn("ggggggggggggggggggg")
					table.insert(datas, v)
				else
					
					logWarn("oooooooooooo")
				end
			end
		end
	end

	if Lang.checkUI("ui4") then
		table.sort(datas, function(a, b)
			local aConfig = a:getConfig()
			local bConfig = b:getConfig()
			local aUnlockLevel = aConfig.require_value
			local bUnlockLevel = bConfig.require_value
			if aUnlockLevel == bUnlockLevel then
				return a:getId() < b:getId()
			else
				return aUnlockLevel < bUnlockLevel
			end
		end)
	else
		table.sort(datas, function(a, b)
			local aConfig = a:getConfig()
			local bConfig = b:getConfig()
			local aUnlockLevel = aConfig.unlock_level
			local bUnlockLevel = bConfig.unlock_level
			if aUnlockLevel == bUnlockLevel then
				return a:getId() < b:getId()
			else
				return aUnlockLevel < bUnlockLevel
			end
		end)		
	end
	return datas
end


--i18n ja
function ActivityLevelGiftPkgData:getListViewDataByCondition(condition,conditionValue)
	local datas = {}
	for _, v in ipairs(self._unitDatas)do
		local config = v:getConfig()
		if config.condition == condition and config.require_value == conditionValue then
			-- appstore 送审状态 全部显示
			if G_ConfigManager:isAppstore() then
				if not Lang.checkUI("ui4") then--i18n ja
					table.insert(datas, v)
				end
			else
				local isTimeOut = v:isTimeOut()
				-- 达到显示等级并且没有购买
				if v:isReachShowLevel() and not v:getIs_buy()  then
					if not v:isReachUnLockLevel() then --没达到解锁等级
						table.insert(datas, v)
					elseif not isTimeOut then --没超时
						table.insert(datas, v)
					end
				end
			end
		end
	end
	table.sort(datas, function(a, b)
		local aConfig = a:getConfig()
		local bConfig = b:getConfig()
		local aUnlockLevel = aConfig.require_value
		local bUnlockLevel = bConfig.require_value
		if aUnlockLevel == bUnlockLevel then
			return a:getId() < b:getId()
		else
			return aUnlockLevel < bUnlockLevel
		end
	end)
	return datas
end


return ActivityLevelGiftPkgData
