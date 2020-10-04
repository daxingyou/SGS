
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


return DataResetFunc
