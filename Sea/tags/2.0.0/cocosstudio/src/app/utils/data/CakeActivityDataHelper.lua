
local CakeActivityDataHelper = {}
local CakeActivityConst = require("app.const.CakeActivityConst")
local UTF8 = require("app.utils.UTF8")

function CakeActivityDataHelper.getCakeLevelConfig(id)
	local info = require("app.config.cake_level").get(id)
	assert(info, string.format("cake_level config can not find id = %d", id))
	return info
end

function CakeActivityDataHelper.getCakeTaskConfig(id)
	local info = require("app.config.cake_task").get(id)
	assert(info, string.format("cake_task config can not find id = %d", id))
	return info
end

function CakeActivityDataHelper.getCakeChargeConfig(id)
	local info = require("app.config.cake_charge").get(id)
	assert(info, string.format("cake_charge config can not find id = %d", id))
	return info
end

function CakeActivityDataHelper.getAllServerStageStartTime()
	local startTime1 = G_UserData:getCakeActivity():getActivityStartTime() --本服阶段开始时间
    local endTime1 = startTime1 + CakeActivityConst.CAKE_LOCAL_TIME --本服阶段结束时间
    local startTime2 = endTime1 + CakeActivityConst.CAKE_TIME_GAP --全服阶段开始时间
    return startTime2
end

--活动阶段
function CakeActivityDataHelper.getActStage()
	local startTime1 = G_UserData:getCakeActivity():getActivityStartTime() --本服阶段开始时间
    local endTime1 = startTime1 + CakeActivityConst.CAKE_LOCAL_TIME --本服阶段结束时间
    local startTime2 = endTime1 + CakeActivityConst.CAKE_TIME_GAP --全服阶段开始时间
    local endTime2 = startTime2 + CakeActivityConst.CAKE_CROSS_TIME --全服阶段结束时间
    local showEndTime = endTime2 + CakeActivityConst.CAKE_TIME_LEFT --整个活动结束显示的时间
    local curTime = G_ServerTime:getTime()

    if startTime1 == 0 then
    	return CakeActivityConst.ACT_STAGE_0 --没开活动
    end

	if curTime >= startTime1 and curTime < endTime1 then
		return CakeActivityConst.ACT_STAGE_1, startTime1, endTime1
	elseif curTime >= endTime1 and curTime < startTime2 then
		return CakeActivityConst.ACT_STAGE_2, endTime1, startTime2
	elseif curTime >= startTime2 and curTime < endTime2 then
		return CakeActivityConst.ACT_STAGE_3, startTime2, endTime2
	elseif curTime >= endTime2 and curTime < showEndTime then
		return CakeActivityConst.ACT_STAGE_4, endTime2, showEndTime
	else
		return CakeActivityConst.ACT_STAGE_0, startTime1, showEndTime
	end
end

--是否能捐材料
function CakeActivityDataHelper.isCanGiveMaterial(isShowTip)
	local actStage = CakeActivityDataHelper.getActStage()
	if actStage == CakeActivityConst.ACT_STAGE_0 then
		if isShowTip then
			G_Prompt:showTip(Lang.get("cake_activity_act_end_tip"))
		end
		return false
	elseif actStage == CakeActivityConst.ACT_STAGE_2 then
		if isShowTip then
			G_Prompt:showTip(Lang.get("cake_activity_act_end_tip2"))
		end
		return false
	elseif actStage == CakeActivityConst.ACT_STAGE_4 then
		if isShowTip then
			G_Prompt:showTip(Lang.get("cake_activity_act_end_tip3"))
		end
		return false
	end
	return true
end

--是否能充值买奶油
function CakeActivityDataHelper.isCanRecharge()
	local actStage = CakeActivityDataHelper.getActStage()
	if actStage == CakeActivityConst.ACT_STAGE_0 or actStage == CakeActivityConst.ACT_STAGE_4 then
		G_Prompt:showTip(Lang.get("cake_activity_act_end_tip"))
		return false
	end
	return true
end

--裁剪服务器名称
function CakeActivityDataHelper.formatServerName(serverName, txtLen)
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		local names = string.split(serverName,"-")
		if names[2] then
			serverName = "S-"..names[2]
		end
	end
	txtLen = txtLen or 8 --默认截取8个字符
	local len = UTF8.utf8len(serverName)
	local str = UTF8.utf8sub(serverName, 1, txtLen)
	if len > txtLen then
		str = str..".."
	end
	return str
end

return CakeActivityDataHelper