--
-- Author: Liangxu
-- Date: 2017-05-05 15:33:37
-- 宝物单元数据
local BaseData = require("app.data.BaseData")
local TreasureUnitData = class("TreasureUnitData", BaseData)
local ParameterIDConst = require("app.const.ParameterIDConst")
local TreasureConst = require("app.const.TreasureConst")
local Parameter = require("app.config.parameter")

local schema = {}
schema["id"] 			= {"number", 0} --唯一Id
schema["base_id"] 		= {"number", 0} --静态Id
schema["user_id"] 		= {"number", 0} --玩家Id
schema["level"] 		= {"number", 0} --当前等级
schema["exp"] 			= {"number", 0} --当前经验
schema["history_gold"]  = {"number", 0} --强化消耗银币
schema["refine_level"] 	= {"number", 0} --精炼等级
schema["limit_cost"]	= {"number", 0} --界限突破等级
schema["materials"]		= {"table", {}} --界限资源
schema["recycle_materials"] = {"table", {}} --界限回收材料
schema["config"] 		= {"table", {}} --配置表信息
schema["yokeRelation"] 	= {"boolean", false} --是否有羁绊关系
TreasureUnitData.schema = schema

function TreasureUnitData:ctor(properties)
	TreasureUnitData.super.ctor(self, properties)
end

function TreasureUnitData:clear()
	
end

function TreasureUnitData:reset()
	
end

function TreasureUnitData:updateData(data)
	self:setProperties(data)
	local config = require("app.config.treasure").get(data.base_id)
	assert(config, "treasure config can not find id = "..tostring(data.base_id))
	self:setConfig(config)
end

function TreasureUnitData:getPos()
	local id = self:getId()
	local data = G_UserData:getBattleResource():getTreasureDataWithId(id)
	if data then
		return data:getPos()
	else
		return nil
	end
end

function TreasureUnitData:getSlot()
	local id = self:getId()
	local data = G_UserData:getBattleResource():getTreasureDataWithId(id)
	if data then
		return data:getSlot()
	else
		return nil
	end
end

function TreasureUnitData:isInBattle()
	local id = self:getId()
	local data = G_UserData:getBattleResource():getTreasureDataWithId(id)
	if data == nil then
		return false
	else
		return true
	end
end

function TreasureUnitData:getMaxStrLevel()
	local ratio = Parameter.get(ParameterIDConst.MAX_TREASURE_LEVEL).content / 1000
	local addLevel = 0
	local limitLevel = self:getLimit_cost()
	if limitLevel >= TreasureConst.TREASURE_LIMIT_RED_LEVEL then
		addLevel = TreasureConst.getAddStrLevelByLimit()
	end
	local maxLevel = math.floor(G_UserData:getBase():getLevel() * ratio) + addLevel
	return maxLevel
end

function TreasureUnitData:getMaxRefineLevel()
	local ratio = Parameter.get(ParameterIDConst.MAX_TREASURE_REFINE).content / 1000
	local addLevel = 0
	local limitLevel = self:getLimit_cost()
	if limitLevel >= TreasureConst.TREASURE_LIMIT_RED_LEVEL then
		addLevel = TreasureConst.getAddRefineLevelByLimit()
	end
	local maxLevel = math.floor(G_UserData:getBase():getLevel() * ratio) + addLevel
	return maxLevel
end

--获取同名卡Id
function TreasureUnitData:getSameCardId()
	local sameCardId = self:getBase_id()
	local limitLevel = self:getLimit_cost()
	if limitLevel == TreasureConst.TREASURE_LIMIT_RED_LEVEL then --说明是橙升红宝物，要用橙色胚子
		sameCardId = G_UserData:getTreasure():getLimitSrcId(sameCardId)
	end
	return sameCardId
end

--是否能界限突破
function TreasureUnitData:isCanLimitBreak()
	return self:getConfig().limit_able == 1
end

--是否强化过
function TreasureUnitData:isDidStrengthen()
	-- if Lang.checkChannel(Lang.CHANNEL_SEA) then
	-- 	return self:getExp() > 0 or self:getLevel() > 1
	-- end
	return self:getLevel() > 1
end

--是否精炼过
function TreasureUnitData:isDidRefine()
	return self:getRefine_level() > 0
end

--是否界限过
function TreasureUnitData:isDidLimit()
	if self:getLimit_cost() > 0 then
		return true
	end
	for key = TreasureConst.TREASURE_LIMIT_COST_KEY_1, TreasureConst.TREASURE_LIMIT_COST_KEY_4 do
		local value = self:getLimitCostCountWithKey(key)
		if value > 0 then --有投入过任何材料都算养成过
			return true
		end
	end
	return false
end

--是否养成过
function TreasureUnitData:isDidTrain()
	local isDidStrengthen = self:isDidStrengthen()
	local isDidRefine = self:isDidRefine()
	local isDidLimit = self:isDidLimit()
	if isDidStrengthen or isDidRefine or isDidLimit then
		return true
	else
		return false
	end
end

--是否能培养
function TreasureUnitData:isCanTrain()
	local treasureType = self:getConfig().treasure_type
	if treasureType == 0 then --type为0的不能
		return false
	end

	return true
end

function TreasureUnitData:isUserTreasure()
	return self:getId() ~= 0 
end

function TreasureUnitData:getLimitCostCountWithKey(key)
	local limitRes = self:getMaterials()
	for i, value in ipairs(limitRes) do
		if i == key then
			return value
		end
	end
	return 0
end

return TreasureUnitData