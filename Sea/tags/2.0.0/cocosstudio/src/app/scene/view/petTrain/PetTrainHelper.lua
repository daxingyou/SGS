--
-- Author: hedili
-- Date: 2018-01-30 19:43:01
-- 神兽培养帮助类
local PetTrainHelper = {}
local UserDataHelper = require("app.utils.UserDataHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")

--升星突然描述
function PetTrainHelper.createBreakDesc(petUnitData)
	-- body
	local label = nil
	if UserDataHelper.isReachStarLimit(petUnitData) then
		label = cc.Label:createWithTTF(Lang.get("pet_break_txt_all_unlock"), Path.getCommonFont(), 22)
		label:setMaxLineWidth(334)
		label:setAnchorPoint(cc.p(0.5, 1))
	else
		local starLevel = petUnitData:getStar() + 1
		local petStarConfig = UserDataHelper.getPetStarConfig(petUnitData:getBase_id(), starLevel)
		local talentName = petStarConfig.talent_name
		local talentDes = petStarConfig.talent_description
		local breakDes = Lang.get("pet_break_txt_break_des", {rank = starLevel})
		local talentInfo =
			Lang.get(
			"pet_break_txt_talent_des",
			{
				name = talentName,
				des = talentDes,
				breakDes = breakDes
			}
		)
		if Lang.checkLang(Lang.CN) then
			label = ccui.RichText:createWithContent(talentInfo)
		else
			label = ccui.RichText:createByI18n()
			local content = json.decode(talentInfo)
			assert(content, "Invalid json string: "..tostring(content).." with name: "..tostring(jsonContent))
			for k,v in ipairs(content) do
				v.fontSize = 18
			end
			label:setRichText(content)
		end

		
		label:setAnchorPoint(cc.p(0.5, 1))
		label:ignoreContentAdaptWithSize(false)
		if Lang.checkLang(Lang.CN) then
			label:setContentSize(cc.size(334, 0))
		else
			
			if Lang.checkLang(Lang.TH) then
				label:setVerticalSpace(5)
			else
				label:setVerticalSpace(0)
			end
			label:setContentSize(cc.size(374, 0))
		end
		label:formatText()
	end
	return label
end

-- 获取界限突破消耗材料
function PetTrainHelper.getCurLimitCostInfo()
	local petId = G_UserData:getPet():getCurPetId()
	local petUnitData = G_UserData:getPet():getUnitDataWithId(petId)
	return PetTrainHelper.getLimitCostInfo(petUnitData)
end

function PetTrainHelper.getLimitCostInfo(petUnitData)
	local LimitCostConst = require("app.const.LimitCostConst")
	local TypeConvertHelper = require("app.utils.TypeConvertHelper")
	local costInfo = {}

	local Paramter = require("app.config.parameter")
	local config = Paramter.get(652)
	assert(config, "paramter not found config by " .. 652)
	costInfo["value_" .. LimitCostConst.LIMIT_COST_KEY_2] = tonumber(config.content)
	costInfo["consume_" .. LimitCostConst.LIMIT_COST_KEY_2] = 1
	costInfo["type_" .. LimitCostConst.LIMIT_COST_KEY_2] = TypeConvertHelper.TYPE_ITEM
	costInfo["size_" .. LimitCostConst.LIMIT_COST_KEY_2] = PetTrainHelper.getLimitCostItemMaxNums()

	local config1 = Paramter.get(653)
	assert(config1, "paramter not found config by " .. 653)
	costInfo["coin_size"] = tonumber(config1.content)

	return costInfo
end

-- 获取可以用于界限突破的神兽数量
function PetTrainHelper.getCanConsumePetNums(baseId)
	local result = G_UserData:getPet():getSameCardCountWithBaseId(baseId)
	return #result
end

-- 是否可以进行界限突破
function PetTrainHelper.canLimit(petUnit)
	local isCan = true
	isCan = isCan and PetTrainHelper.canEnterLimit(petUnit)
	isCan = isCan and petUnit:getStar() >= PetTrainHelper.getCanLimitMinStar()
	local materials = petUnit:getMaterials()
	local isCan = isCan and #materials > 0
	isCan = isCan and materials[1] >= 1
	return isCan
end

function PetTrainHelper.petStarCanLimit(petUnit)
	return petUnit:getStar() >= PetTrainHelper.getCanLimitMinStar()
end

-- 是否可以进入界限突破
function PetTrainHelper.canEnterLimit(petUnit)
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	local isOpen = LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_PET_TRAIN_TYPE3)
	local config = petUnit:getConfig()
	return (config.potential_after > 0 or config.potential_before > 0) and isOpen
end

-- 界限突破之后的等级
function PetTrainHelper.limitAfterLevel(petUnit)
	local curLevel = petUnit:getLevel()
	local color = petUnit:getConfig().color
	local curAllExp = 0
	for lv = 1, curLevel - 1 do
		local exp = require("app.config.pet_exp").get(lv, color).exp
		assert(exp, "pet_exp not found exp by " .. lv .. " " .. color)
		curAllExp = curAllExp + exp
	end
	local afterLevel = 1
	local afterColor = color + 1
	while true do
		local exp = require("app.config.pet_exp").get(afterLevel, afterColor).exp
		assert(exp, "pet_exp not found exp by " .. afterLevel .. " " .. afterColor)
		if curAllExp > exp then
			curAllExp = curAllExp - exp
			afterLevel = afterLevel + 1
		else
			break
		end
	end
	return afterLevel
end

-- 可以界限突破的最小星级
function PetTrainHelper.getCanLimitMinStar()
	local Paramter = require("app.config.parameter")
	local config = Paramter.get(650)
	assert(config, "paramter not found config by " .. 650)
	return tonumber(config.content)
end

-- 界限突破降星度
function PetTrainHelper.limitReduceStar(curStar)
	local Paramter = require("app.config.parameter")
	local config = Paramter.get(651)
	assert(config, "paramter not found config by " .. 651)
	local content = string.split(config.content, ",")
	local step = {}
	for i, value in ipairs(content) do
		step[i] = string.split(value, "|")
	end
	dump(step)

	for i, value in ipairs(step) do
		if tonumber(step[i][1]) == curStar then
			return tonumber(step[i][2])
		end
	end
	return 0
end

function PetTrainHelper.getLimitCostItemMaxNums()
	local Paramter = require("app.config.parameter")
	local config = Paramter.get(654)
	assert(config, "paramter not found config by " .. 654)
	return tonumber(config.content)
end

-- 获取当前正在界限突破的神兽数据
function PetTrainHelper.getCurLimitPetUnit()
	local petId = G_UserData:getPet():getCurPetId()
	local petUnitData = G_UserData:getPet():getUnitDataWithId(petId)
	return petUnitData
end

function PetTrainHelper.getCurTabSize()
	local PetConst = require("app.const.PetConst")
	local curHeroId = G_UserData:getPet():getCurPetId()
	local curPetData = G_UserData:getPet():getUnitDataWithId(curHeroId)
	local canEnter = PetTrainHelper.canEnterLimit(curPetData)
	local tabsize = PetConst.MAX_TRAIN_TAB - 1
	if canEnter then
		tabsize = PetConst.MAX_TRAIN_TAB
	end
	return tabsize
end

return PetTrainHelper
