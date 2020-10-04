
local HistoryHeroDataHelper = {}


--历代名将阵位显示数量
function HistoryHeroDataHelper.getHistoryHeroPosShowNum()
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	local showPosNum = 0
	for index = FunctionConst.FUNC_HISTORY_HERO_TEAM_SLOT1, FunctionConst.FUNC_HISTORY_HERO_TEAM_SLOT4 do
		local isShow = LogicCheckHelper.funcIsShow( index )
		if isShow == true then
			showPosNum = showPosNum + 1
		end
	end
	return showPosNum
end


--根据阵位索引获取历代名将状态
function HistoryHeroDataHelper.getHistoryHeroStateWithPos(pos)
	local TeamConst = require("app.const.TeamConst")
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	local isOpen = LogicCheckHelper.funcIsOpened(FunctionConst["FUNC_HISTORY_HERO_TEAM_SLOT"..pos])

	if isOpen then
		local historyHeroIds = G_UserData:getHistoryHero():getHistoryHeroIds()
		if historyHeroIds == nil or historyHeroIds[pos] == nil then
			return TeamConst.STATE_OPEN
		end
		if historyHeroIds[pos] == 0 then
			return TeamConst.STATE_OPEN
		end
		if historyHeroIds[pos] > 0 then
			return TeamConst.STATE_HERO
		end

	else
		return TeamConst.STATE_LOCK
	end
end

-- @Export 		获取历代名将信息
-- @Param		baseId
function HistoryHeroDataHelper.getHistoryHeroInfo(baseId)
	local info = require("app.config.historical_hero").get(baseId)
	assert(info, string.format("historical_hero config can not find id = %d", baseId))
	return info
end

-- @Export 		获取历代名将基础特效
-- @Param		baseId
function HistoryHeroDataHelper.getHistoryHeroEffectWithBaseId(baseId)
	local result = nil
	local info = require("app.config.historical_hero").get(baseId)
	assert(info, string.format("historical_hero config can not find id = %d", baseId))

	if rawget(info, "moving") == nil then
		return nil
	end

	local moving = info.moving
	if moving ~= "0" then
		result = string.split(moving,"|")
	end
	return result
end

-- @Export 		获取历代名将图鉴（历代系统中的
function HistoryHeroDataHelper.getHistoryHeroBookInfo()
	local mapData = {}
	local UserCheck = require("app.utils.logic.UserCheck")
	local length = require("app.config.historical_hero_map").length()
	for index = 1, length do
		local info = require("app.config.historical_hero_map").indexOf(index)
		if tonumber(info.show) == 1 and UserCheck.enoughOpenDay(tonumber(info.show_day)) then
			table.insert(mapData, info)
		end
	end

	table.sort(mapData, function(item1, item2)
		return item1.id < item2.id
	end)
	return mapData
end

-- @Export 		获得突破觉醒信息
-- @Param 	    heroId 名将Id
-- @Param 	    step 突破界限
function HistoryHeroDataHelper.getHistoryHeroStepByHeroId(heroId, step)
	local info = require("app.config.historical_hero_step").get(heroId, step)
	assert(info, string.format("historical_hero_step config can not find id = %d", heroId))
	return info
end

-- @Export 		根据BaseId获取技能ID
-- @Param 		baseId 名将ID
function HistoryHeroDataHelper.getHistoricalSkills(baseId)
	local skillList = {}
	local HeroInfoCfg = HistoryHeroDataHelper.getHistoryHeroInfo(baseId)
	local skillNums = HeroInfoCfg.is_step == 1 and 3 or 2		-- 根据突破获取技能数量
	for index = 1, skillNums do
		table.insert(skillList, HistoryHeroDataHelper.getHistoryHeroStepByHeroId(baseId, index).skill_id)
	end
	return skillList
end

-- @Export 	重生返还
function HistoryHeroDataHelper.getHistoricalHeroRebornPreviewInfo(data)
	local heroCfg = HistoryHeroDataHelper.getHistoryHeroStepByHeroId(data:getSystem_id(), data:getBreak_through() - 1)
	if heroCfg == nil then
		return
	end

	local count = data:getBreak_through() > 2 and 3 or 1
	local result = {}
	for index = 1, count do
		table.insert(result, {type = heroCfg["type_"..index], value = heroCfg["value_"..index], size = heroCfg["size_"..index]})
	end

	return result
end



return HistoryHeroDataHelper
