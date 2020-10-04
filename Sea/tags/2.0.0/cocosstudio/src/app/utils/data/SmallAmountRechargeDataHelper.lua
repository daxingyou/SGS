local SmallAmountRechargeDataHelper = {}


function SmallAmountRechargeDataHelper.getSmallAmountRechargeMainIconData()
    local unitList  = G_UserData:getCustomActivity():getShowSmallAmountRechargeActivity()
    local mainIconData = {main = nil,list = {}}
    for k,v in ipairs(unitList) do
        local endTime = v:getAward_time()
        logWarn("SmallAmountRechargeDataHelper "..endTime)
        local data = {actId = v:getAct_id(),functionId = FunctionConst.FUNC_SMALL_AMOUNT_RECHARGE,endTime = endTime}
        mainIconData["k_"..v:getAct_id()] = data
        table.insert(mainIconData.list, data)
        if not mainIconData.main then
            mainIconData.main = data
        elseif data.endTime  < mainIconData.main.endTime then
            mainIconData.main = data
        end
     
    end
    table.sort(mainIconData.list,function(left,right)
        if left.endTime ~= right.endTime then
            return left.endTime < right.endTime
        else
            return left.actId < right.actId
        end
    end)
    return mainIconData
end




function SmallAmountRechargeDataHelper.getSmallAmountRechargeShowListById(actId)
    local actUnitData =  G_UserData:getCustomActivity():getActUnitDataById(actId)
    if not actUnitData then
        return {}
    end
    local dataMap = G_UserData:getCustomActivity():getActTaskUnitDataListById(actId)
    local dataArr = {}
    for k,v in pairs(dataMap) do
        table.insert(dataArr,
        {
            actUnitData = actUnitData,
            actTaskUnitData = v,
            limitTime = actUnitData:getEnd_time()
        }
    )
      
    end
    local sortFuc = function(item01,item02)
        return item01.actTaskUnitData:getSort_num() < item02.actTaskUnitData:getSort_num()
    end
    table.sort(dataArr,sortFuc)
    return  dataArr
end


return SmallAmountRechargeDataHelper
