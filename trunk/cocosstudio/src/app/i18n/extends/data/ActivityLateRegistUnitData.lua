
local BaseData = require("app.data.BaseData")
local ActivityLateRegistUnitData = class("ActivityLateRegistUnitData", BaseData)
local schema = {}
schema["config"] 		= {"table", {}}--补偿配置
schema["taskValue"] 	= {"number", 0}--任务进度值
schema["received"] 		= {"boolean", false}--已领取

ActivityLateRegistUnitData.schema = schema

function ActivityLateRegistUnitData:ctor(properties)
	ActivityLateRegistUnitData.super.ctor(self, properties)
    self._rewardItems = {}
end

-- 清除
function ActivityLateRegistUnitData:clear()
end

-- 重置
function ActivityLateRegistUnitData:reset()
end


function ActivityLateRegistUnitData:initData(config,taskValue,rewardIds)
	self:setConfig(config)
	self:setTaskValue(taskValue)
	for i,v in ipairs(rewardIds) do
		if config.id == v then
			self:setReceived(true)
			break
		end
	end
	self._rewardItems = self:_makeItems(config,"",3)

	dump(self._rewardItems)
end

function ActivityLateRegistUnitData:_makeItems(data,keyName,maxNum)
    local itemsList = {}
    for k = 1,maxNum ,1 do
        local type = data[keyName.."type_"..k]
        if type and type ~= 0 then
            local value = data[keyName.."value_"..k]  or 0
            local size = data[keyName.."size_"..k]  or 0
            table.insert(itemsList,{type = type,value = value, size  = size})
        end
    end
    return itemsList
end

--返回类型
function ActivityLateRegistUnitData:getTaskType()
	return self:getConfig().task_type
end

--返回Id
function ActivityLateRegistUnitData:getId()
    return self:getConfig().id
end

--返回按钮文本
function ActivityLateRegistUnitData:getButtonTxt()
    return self:getConfig().button_txt
end

--是否显示进度
function ActivityLateRegistUnitData:getShowRate()
    return self:getConfig().show_rate
end

--排序
function ActivityLateRegistUnitData:getOrder()
    return self:getConfig().order
end

function ActivityLateRegistUnitData:getRewardItems()
    return self._rewardItems
end

--转换param1成Number值
--@return:转换失败返回0
function ActivityLateRegistUnitData:getParamOneValue()
    return tonumber(self:getConfig().task_value) or 0
end

--返回任务进度的最大值
function ActivityLateRegistUnitData:getTaskMaxValue()
	local value = self:getParamOneValue()
    return value
end

--是否满足领取条件
function ActivityLateRegistUnitData:isReachReceiveCondition()
	if self:getTaskValue() >= self:getTaskMaxValue() then
		return true
	end
	return false
end

--是否可以领取
function ActivityLateRegistUnitData:isCanReceive()
	return not self:isReceived()
end

function ActivityLateRegistUnitData:getDescription()
	local taskDes = self:getConfig().name
	local condition = string.format(taskDes,self:getTaskMaxValue())
	return condition
end

function ActivityLateRegistUnitData:getProgressTitle()
    return Lang.get("customactivity_text_progress")
end

--@return：当前进度、最大值
function ActivityLateRegistUnitData:getProgressValue()
	local value01 =  self:getTaskValue() --当前进度
	local value02 = self:getTaskMaxValue()   --完成所需次数
	local onlyShowMax = false--只显示最大值

	value01 =  value01 > value02 and value02 or value01

	return value01,value02,onlyShowMax
end

return ActivityLateRegistUnitData
