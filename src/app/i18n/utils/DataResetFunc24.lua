
local DataResetFunc24 = {}


function DataResetFunc24._FUNC_WELFARE()
    local returnFunc = function(...)
        G_UserData:getActivityMonthCard():resetData()
	end
	return returnFunc
end

--i18n ja 
function DataResetFunc24._FUNC_RECHARGE()
    local returnFunc = function(...)
		G_UserData:getPosterGirl():c2sGetPosterGirlRewardInfo()
	end
	return returnFunc
end

return DataResetFunc24
