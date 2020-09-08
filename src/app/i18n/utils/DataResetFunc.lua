
local DataResetFunc = {}

function DataResetFunc._FUNC_ACHIEVEMENT()
	local returnFunc = function(...)
        G_UserData:getDailyMission():c2sGetDailyTaskInfo()
        G_UserData:getAchievement():c2sGetAchievementInfo()
	end
	return returnFunc
end

function DataResetFunc._FUNC_HORSE_RACE()
    local returnFunc = function(...)
        G_UserData:getHorseRace():c2sWarHorseRideInfo()
	end
	return returnFunc
end

function DataResetFunc._FUNC_GUILD_CREATE()
    local returnFunc = function(...)
        G_UserData:getGuild():c2sGetUserGuild()
	end
	return returnFunc
end

function DataResetFunc._FUNC_MINE_CRAFT_PRIVILEGE()
    local returnFunc = function(...)
		G_UserData:getRechargeData():pullData()
	end
	return returnFunc
end

--i18n ja 非FunctionConst
function DataResetFunc._FUNC_MONTH_CARD()
    local returnFunc = function(...)
		G_UserData:getActivityMonthCard():pullData()
	end
	return returnFunc
end

--i18n ja 非FunctionConst
function DataResetFunc._FUNC_LUXURY_GIFT()
    local returnFunc = function(...)
		G_UserData:getActivityLuxuryGiftPkg():pullData()
	end
	return returnFunc
end

--i18n ja 非FunctionConst
function DataResetFunc._FUNC_LEVEL_GIFT()
    local returnFunc = function(...)
		G_UserData:getActivityLevelGiftPkg():pullData()
	end
	return returnFunc
end

--i18n ja 非FunctionConst
function DataResetFunc._FUNC_OPEN_SERVER_FUND()
    local returnFunc = function(...)
		G_UserData:getActivityOpenServerFund():pullData()
	end
	return returnFunc
end

--i18n ja 
function DataResetFunc._FUNC_RECHARGE()
    local returnFunc = function(...)
		G_UserData:getShops():c2sGetShopInfo(ShopConst.VIP_EXCHANGE_SHOP)
		G_UserData:getPosterGirl():c2sGetPosterGirlRewardInfo()
	end
	return returnFunc
end

return DataResetFunc
