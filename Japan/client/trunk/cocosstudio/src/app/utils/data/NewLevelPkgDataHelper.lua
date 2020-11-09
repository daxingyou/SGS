local NewLevelPkgDataHelper = {}

function NewLevelPkgDataHelper.getNewLevelPkgRewards(config)
    local rewards = {}
    for k = 1,3 do
        if k == 1 then
            if config["type"] ~= 0 then
                table.insert(rewards, {type = config["type"], value = config["value"], size = config["size"]})
            end
        else
            if config["type"..k] ~= 0 then
                table.insert(rewards, {type = config["type"..k], value = config["value"..k], size = config["size"..k]})
            end
        end
        
    end
    return rewards
end


function NewLevelPkgDataHelper.getNewLevelPkgMainIconData()
    local unitList = G_UserData:getActivityLevelGiftPkg():getListViewData()
    local mainIconData = {main = nil,list = {}}
    for k,v in ipairs(unitList) do
        local config = v:getConfig()
        if not mainIconData[config.condition.."_"..config.require_value] then
            local endTime = v:getStart_time() + v:getLimitTime()
            logWarn("NewLevelPkgDataHelper "..endTime)
            local data = {condition = config.condition,conditionValue =  config.require_value,
                functionId = config.fun_id,endTime = endTime}
            mainIconData[config.condition.."_"..config.require_value] = data
            table.insert(mainIconData.list, data)
            if not mainIconData.main then
                mainIconData.main = data
            elseif data.endTime  < mainIconData.main.endTime then
                mainIconData.main = data
            end
        end
    end
    table.sort(mainIconData.list,function(left,right)
        if left.endTime ~= right.endTime then
            return left.endTime < right.endTime
        elseif left.condition ~= right.condition then
            return left.condition < right.condition
        else
            return left.conditionValue < right.conditionValue
        end
    end)
    return mainIconData
end


return NewLevelPkgDataHelper
