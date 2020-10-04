local VipConst = require("app.const.VipConst")
local PosterGirlDataHelper = {}

function PosterGirlDataHelper.isHasPosterGirl(id)
    local skinList = G_UserData:getPosterGirl():getSkinList()
    for k,v in ipairs(skinList) do
        if v == id then
            return true
        end
    end
	return false
end

function PosterGirlDataHelper.isEquipPosterGirl(id)
    return G_UserData:getPosterGirl():getWear_skin() == id
end


function PosterGirlDataHelper.getShowPosterList()
    local Skin = require("app.config.skin")
    local skinList = {}
    for i = 1 ,Skin.length() do
        local config = Skin.indexOf(i)
        table.insert(skinList,config)
    end
    return skinList
end

function PosterGirlDataHelper.getPosterGirlReceiveBoxNum(sType)
    local VipConst = require("app.const.VipConst")
    local unitData = G_UserData:getPosterGirl():getPlayUnitDataByType(
        sType
    )
    if unitData then
        return unitData:getTotalIdNum()
    end
    return 0
end


function PosterGirlDataHelper.getPosterGirlBoxInfoList(sType)
    local VipConst = require("app.const.VipConst")
    local VipExpLimit = require("app.config.vip_exp_limit")
    local list = {}
    for k = 1,VipExpLimit.length(),1 do
        local config = VipExpLimit.indexOf(k)
        if config.type ==  sType and 
             config.condition ==  VipConst.VIP_ADD_EXP_CONDITION_ONLINE then
            table.insert(list,{config = config})
        end
    end
    return list
end

function PosterGirlDataHelper.hasReceivePosterGirlBox(sType,id)
    local VipConst = require("app.const.VipConst")
    local unitData = G_UserData:getPosterGirl():getPlayUnitDataByType(
        sType
    )
    if not unitData then
        return false
    end
    return  unitData:hasReceive(id)
end

function PosterGirlDataHelper.getPGReceiveRewardIds(sType)
    local VipConst = require("app.const.VipConst")
    local unitData = G_UserData:getPosterGirl():getPlayUnitDataByType(
        sType
    )
    if not unitData then
        return {}
    end
    local rewardsList = {}
    local rewards = unitData:getReceiveIdList()
    for k,v in pairs(rewards) do
        rewardsList[v] = true
    end
    return rewardsList
end


function PosterGirlDataHelper.getPGCanReceiveNum(sType)
    local VipConst = require("app.const.VipConst")
    local VipExpLimit = require("app.config.vip_exp_limit")
    local list = {}
    for k = 1,VipExpLimit.length(),1 do
        local config = VipExpLimit.indexOf(k)
        if config.type ==  sType and 
             config.condition ==  VipConst.VIP_ADD_EXP_CONDITION_ONLINE then
            table.insert(list,{config = config})
        end
    end
    local onlineTime = G_UserData:getBase():getOnlineTime()
	for k = #list ,1,-1 do
		local data = list[k]
		if onlineTime >= data.config.require_value * 60 then
			return k,#list
		end
	end
    return 0,#list
end


function PosterGirlDataHelper.getPGCanReceiveBoxId(sType)
    
   local boxInfoList = PosterGirlDataHelper.getPosterGirlBoxInfoList(sType)
	local onlineTime = G_UserData:getBase():getOnlineTime()
	for k = #boxInfoList ,1,-1 do
		local data = boxInfoList[k]
		if onlineTime >= data.config.require_value * 60 and 
			not PosterGirlDataHelper.hasReceivePosterGirlBox(sType,
				data.config.id) then
			return k
		end
	end
	return nil
end


return PosterGirlDataHelper
