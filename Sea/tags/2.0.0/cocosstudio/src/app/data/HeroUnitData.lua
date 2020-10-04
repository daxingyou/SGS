-- 武将单元数据
-- Author: Liangxu
-- Date: 2017-02-15 16:10:58
--
local BaseData = require("app.data.BaseData")
local HeroUnitData = class("HeroUnitData", BaseData)
local UserDataHelper = require("app.utils.UserDataHelper")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local HeroConst = require("app.const.HeroConst")

local schema = {}
schema["type"] = {"number", TypeConvertHelper.TYPE_HERO}
schema["id"] = {"number", 0} --唯一ID
schema["base_id"] = {"number", 0} --静态表ID
schema["level"] = {"number", 0} --等级
schema["exp"] = {"number", 0} --经验
schema["history_gold"] = {"number", 0} --历史消耗银两
schema["quality"] = {"number", 0} --品质
schema["rank_lv"] = {"number", 0} --突破等级
schema["association"] = {"table", {}} --羁绊Id
schema["awaken_level"] = {"number", 0} --觉醒等级
schema["awaken_slots"] = {"table", {}} --觉醒材料
schema["limit_level"] = {"number", 0} --界限等级
schema["limit_res"] = {"table", {}} --界限资源
schema["config"] = {"table", {}} --配置表信息
schema["gold_res"] = {"table", {}} -- 金将资源
schema["willActivateYokeCount"] = {"number", 0} --将激活的羁绊数量，为了排序中减少计算量，记录此值
HeroUnitData.schema = schema

function HeroUnitData:ctor(properties)
	HeroUnitData.super.ctor(self, properties)

	self._isUserHero = true
end

function HeroUnitData:clear()
end

function HeroUnitData:reset()
end

function HeroUnitData:updateData(data)
	self:backupProperties()

	self:setProperties(data)
	local config = require("app.config.hero").get(data.base_id)
	assert(config, "heroConfig can't find base_id = " .. tostring(data.base_id))
	self:setConfig(config)
end

function HeroUnitData:getPos()
	local heroIds = G_UserData:getTeam():getHeroIds()
	for i, id in ipairs(heroIds) do
		if self:getId() == id then
			return i
		end
	end
	return nil
end

function HeroUnitData:getSecondPos()
	local secondHeroIds = G_UserData:getTeam():getSecondHeroIds()
	for i, id in ipairs(secondHeroIds) do
		if self:getId() == id then
			return i
		end
	end
	return nil
end

--是否是主角
function HeroUnitData:isLeader()
	return self:getConfig().type == 1
end

--是否在阵位上
function HeroUnitData:isInBattle()
	local pos = self:getPos()
	if pos and pos > 0 then
		return true
	else
		return false
	end
end

--是否在援军位上
function HeroUnitData:isInReinforcements()
	local secondPos = self:getSecondPos()
	if secondPos and secondPos > 0 then
		return true
	else
		return false
	end
end

--获取羁绊总数
function HeroUnitData:getYokeTotalCount()
	local totalCount = 0
	local config = self:getConfig()
	for i = 1, HeroConst.HERO_YOKE_MAX do
		local fateId = config["fate_" .. i]
		if fateId > 0 then
			totalCount = totalCount + 1
		end
	end

	return totalCount
end

--获得已激活的羁绊数量
function HeroUnitData:getActivedYokeCount()
	local count = #self:getAssociation()

	return count
end

--根据羁绊Id获取该羁绊是否已激活
function HeroUnitData:isActivatedYoke(fateId)
	local ids = self:getAssociation()
	for i, id in ipairs(ids) do
		if id == fateId then
			return true
		end
	end
	return false
end

--是否激活合击
function HeroUnitData:isActiveJoint(beReplacedId)
	local heroConfig = self:getConfig()
	if heroConfig.skill_3_type ~= 0 then
		local partnerId = heroConfig.skill_3_partner
		if partnerId == beReplacedId then
			return false --如果合击武将是要被替换下来的武将，则不会激活
		end
		local heroIds = G_UserData:getTeam():getHeroIds()
		for i, id in ipairs(heroIds) do
			if id > 0 then
				local unitData = G_UserData:getHero():getUnitDataWithId(id)
				local heroBaseId = AvatarDataHelper.getShowHeroBaseIdByCheck(unitData)
				if heroBaseId == partnerId then
					return true
				end
			end
		end
	end

	return false
end

--是否有过升级
function HeroUnitData:isDidUpgrade()
	if self:isPureGoldHero() then
		return false
	end
	-- if Lang.checkChannel(Lang.CHANNEL_SEA) then
	-- 	return self:getExp() > 0 or self:getLevel() > 1
	-- end
	return self:getLevel() > 1
end

--是否有过突破
function HeroUnitData:isDidBreak()
	return self:getRank_lv() > 0
end

--是否有过觉醒
function HeroUnitData:isDidAwake()
	return self:getAwaken_level() > 0
end

--是否有过界限突破
function HeroUnitData:isDidLimit()
	if self:getLimit_level() > 0 then
		return true
	end
	for key = HeroConst.HERO_LIMIT_COST_KEY_1, HeroConst.HERO_LIMIT_COST_KEY_4 do
		local value = self:getLimitCostCountWithKey(key)
		if value > 0 then --有投入过任何材料都算养成过
			return true
		end
	end
	return false
end

-- 是否有过金养成
function HeroUnitData:isDidGoldRankLv()
	if self:isDidBreak() then
		return true
	end
	local gold_res = self:getGold_res()
	for _, res in pairs(gold_res) do
		if res.Value > 0 then
			return true
		end
	end
	return false
end

--是否养成过
function HeroUnitData:isDidTrain()
	local isDidUpgrade = self:isDidUpgrade()
	local isDidBreak = self:isDidBreak()
	local isDidAwake = self:isDidAwake()
	local isDidLimit = self:isDidLimit()
	local isDidGoldRank = self:isDidGoldRankLv()
	if isDidUpgrade or isDidBreak or isDidAwake or isDidLimit or isDidGoldRank then
		return true
	else
		return false
	end
end

function HeroUnitData:getGoldResValue(costKey)
	local gold_res = self:getGold_res()
	for _, res in pairs(gold_res) do
		if res.Key == costKey then
			return res.Value
		end
	end
	return 0
end

--是否能养成
function HeroUnitData:isCanTrain()
	local type = self:getConfig().type
	if type == 3 then --经验卡不能培养
		return false
	end
	return true
end

--是否能突破
function HeroUnitData:isCanBreak()
	local rankMax = self:getConfig().rank_max
	if rankMax == 0 then
		return false
	end
	return true
end

--是否能觉醒
function HeroUnitData:isCanAwake()
	local awakeMax = self:getConfig().awaken_max
	if awakeMax == 0 then
		return false
	end
	return true
end

--是否能界限突破
function HeroUnitData:isCanLimitBreak()
	local type = self:getConfig().type
	local color = self:getConfig().color
	local limit = self:getConfig().limit
	if type == 2 and color == 5 and limit == 1 then
		return true
	end
	return false
end

--是否已界限突破到3级（到红将）
function HeroUnitData:isDidLimitToRed()
	return self:getLimit_level() == 3
end

--如果武将是主角，获取变身后的武将id
function HeroUnitData:getAvatarToHeroBaseId()
	local heroBaseId = self:getBase_id()
	if self:isLeader() then
		heroBaseId = G_UserData:getBase():getPlayerBaseId()
	end
	return heroBaseId
end

function HeroUnitData:getAvatarToHeroBaseIdByAvatarId(avatarBaseId)
	local heroBaseId = self:getBase_id()
	if self:isLeader() then
		local UserDataHelper = require("app.utils.UserDataHelper")
		heroBaseId = UserDataHelper.convertToBaseIdByAvatarBaseId(avatarBaseId, heroBaseId)
	end
	return heroBaseId
end

--------------------------------------------------
---TODO：因该是通过ID==0来判断
function HeroUnitData:setUserHero(userHero)
	self._isUserHero = userHero
end

function HeroUnitData:isUserHero()
	return self._isUserHero
end

------------------------------------------------------

function HeroUnitData:getLimitCostCountWithKey(key)
	local limitRes = self:getLimit_res()
	for i, info in ipairs(limitRes) do
		if info.Key == key then
			return info.Value
		end
	end
	return 0
end

function HeroUnitData:getLeaderLimitLevel()
	if self:isLeader() and G_UserData:getBase():isEquipAvatar() then --是主角并且穿了变身卡
		local avatarBaseId = G_UserData:getBase():getAvatar_base_id()
		local limit = AvatarDataHelper.getAvatarConfig(avatarBaseId).limit
		if limit == 1 then
			return HeroConst.HERO_LIMIT_MAX_LEVEL
		end
	end
	return self:getLimit_level()
end

function HeroUnitData:isPureGoldHero()
	local isColor = self:getConfig().color == 7
	return isColor and self:getLimit_level() == 0
end

return HeroUnitData
