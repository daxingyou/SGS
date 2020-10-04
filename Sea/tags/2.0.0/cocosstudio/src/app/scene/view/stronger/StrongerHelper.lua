
-- Author: hedili
-- Date:2018-01-09 16:11:00
-- Describle：


local StrongerHelper = {}

function StrongerHelper.getFuncLevelList()
	local FunctionCheck = require("app.utils.logic.FunctionCheck")
	local retList = {}
	local playerLevel = G_UserData:getBase():getLevel()
	local function_level = require("app.config.function_level")
	for i = 1, function_level.length() do
		
		local cfgData = function_level.indexOf(i)
		if cfgData.preview_show == 1 and G_UserData:getBase():getLevel() >= cfgData.preview_level then
			local saveTable = {}
			saveTable.funcData = cfgData
			saveTable.isOpen = FunctionCheck.funcIsOpened(cfgData.function_id)
			table.insert( retList, saveTable )
		end

	end

	table.sort(retList, function(a, b) 
		if a.isOpen ~= b.isOpen then
			return b.isOpen
		end
		return a.funcData.level < b.funcData.level
	end)

	return retList
end

function StrongerHelper.getBubbleList( ... )
	-- body
	local retList = {}


	local function filterFunc(cfgData)
		if cfgData.id == 0 then
			return false
		end
		local playerLevel = G_UserData:getBase():getLevel()
		local FunctionCheck = require("app.utils.logic.FunctionCheck")
		if cfgData.function_level_id > 0 then
			if FunctionCheck.funcIsOpened(cfgData.function_level_id) == true 
				and cfgData.upgrade_level <= playerLevel  then

					local percent =  StrongerHelper.getPercent( cfgData )
					if percent < 100 then
						return false
					end
			end
		end
		return true
	end

	local recommend_upgrade = require("app.config.recommend_upgrade")
	for i = 1, recommend_upgrade.length() do
		local cfgData = recommend_upgrade.indexOf(i)
		if filterFunc(cfgData) == false then
			table.insert(retList, cfgData.bubble_id)
		end
	end
	return retList
end

function StrongerHelper.getRecommendUpgradeList()
	local FunctionCheck = require("app.utils.logic.FunctionCheck")
	local retList = {}
	local playerLevel = G_UserData:getBase():getLevel()
	local recommend_upgrade = require("app.config.recommend_upgrade")
	for i = 1, recommend_upgrade.length() do
		local saveTable = {}
		local cfgData = recommend_upgrade.indexOf(i)
		if cfgData.function_level_id > 0 then
			if FunctionCheck.funcIsOpened(cfgData.function_level_id) == true and 
				cfgData.upgrade_level <= playerLevel  then
					saveTable.cfgData = cfgData
					saveTable.funcData = require("app.config.function_level").get(cfgData.function_level_id)
					saveTable.percent = StrongerHelper.getPercent( cfgData )
					table.insert( retList, saveTable )
			end
		end

	end
	return retList
end

function StrongerHelper.getPercent( cfgData )
	-- body
	local avgLevel = StrongerHelper["getAvgLevel"..cfgData.id]()
	if avgLevel == nil or avgLevel == "nan" then
		avgLevel = 0
	end
	local playerLevel = G_UserData:getBase():getLevel()
	local str = Lang.getTxt(cfgData.upgrade_percent, {LEVEL = playerLevel})
	local func1 = loadstring("return "..str)
	local percent = math.floor( func1() )

	return math.floor(  (avgLevel / percent) * 100 )
end



--上阵武将（不含主角）等级平均值
function StrongerHelper.getAvgLevel1( ... )
	-- body
	local UserDataHepler = require("app.utils.UserDataHelper")
	return UserDataHepler.getHeroInBattleAverageLevel()

end


--上阵武将（含主角）突破等级平均值
function StrongerHelper.getAvgLevel2( ... )
	-- body
	local UserDataHepler = require("app.utils.UserDataHelper")
	return UserDataHepler.getHeroInBattleAverageRank()

end


--上阵武将（含主角）觉醒等级平均值
function StrongerHelper.getAvgLevel3( ... )
	-- body
	local UserDataHepler = require("app.utils.UserDataHelper")
	return UserDataHepler.getHeroInBattleAverageAwakeLevel()
end


--所有已穿戴装备的平均强化等级
function StrongerHelper.getAvgLevel4( ... )
	-- body
	local UserDataHepler = require("app.utils.UserDataHelper")
	return UserDataHepler.getEquipInBattleAverageStr()
end


--所有已穿戴装备的平均精炼等级
function StrongerHelper.getAvgLevel5( ... )
	-- body
	local UserDataHepler = require("app.utils.UserDataHelper")
	return UserDataHepler.getEquipInBattleAverageRefine()
end

--所有已穿戴宝物的平均强化等级
function StrongerHelper.getAvgLevel6( ... )
	-- body
	local UserDataHepler = require("app.utils.UserDataHelper")
	return UserDataHepler.getTreasureInBattleAverageStr()
end

--所有已穿戴宝物的平均精炼等级
function StrongerHelper.getAvgLevel7( ... )
	-- body
	local UserDataHepler = require("app.utils.UserDataHelper")
	return UserDataHepler.getTreasureInBattleAverageRefine()
end


--所有已穿戴神兵的平均进阶等级
function StrongerHelper.getAvgLevel8( ... )
	-- body
	local UserDataHepler = require("app.utils.UserDataHelper")
	return UserDataHepler.getInstrumentInBattleAverageAdvance()
end

return StrongerHelper