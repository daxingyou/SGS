--阵容按钮小红点逻辑


local TeamVeiwMainRP = {}
local FunctionConst = require("app.const.FunctionConst")
local RedPointHelper = require("app.data.RedPointHelper")

--箭头相关的
local arrowFuncId = {
    FunctionConst.FUNC_EQUIP_TRAIN_TYPE1,
    FunctionConst.FUNC_EQUIP_TRAIN_TYPE2,
    FunctionConst.FUNC_TREASURE_TRAIN_TYPE1,
    FunctionConst.FUNC_TREASURE_TRAIN_TYPE2,
    FunctionConst.FUNC_TREASURE_TRAIN_TYPE3,
}

--红点相关的
local redPointFuncId = {
    FunctionConst.FUNC_EQUIP,
    FunctionConst.FUNC_TREASURE,
    FunctionConst.FUNC_INSTRUMENT,
    FunctionConst.FUNC_HORSE,
    FunctionConst.FUNC_HERO_TRAIN_TYPE1,
    FunctionConst.FUNC_HERO_TRAIN_TYPE2,
    FunctionConst.FUNC_HERO_TRAIN_TYPE3,
    FunctionConst.FUNC_HERO_TRAIN_TYPE4,
    FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE1,
    FunctionConst.FUNC_HORSE_TRAIN,
    FunctionConst.FUNC_HERO_KARMA,
    FunctionConst.FUNC_HERO_CHANGE,
    FunctionConst.FUNC_AVATAR,
    FunctionConst.FUNC_EQUIP_TRAIN_TYPE3
}

TeamVeiwMainRP.getRedPoint = function()
    local function checkEquipRP(pos)
        local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP, "posRP", pos)
        return reach
    end

    local function checkTreasureRP(pos)
        local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_TREASURE, "posRP", pos)
        return reach
    end

    local function checkInstrumentRP(pos)
        local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
        if heroId > 0 then
            local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
            local heroBaseId = unitData:getBase_id()
            local param = {pos = pos, heroBaseId = heroBaseId}
            local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_INSTRUMENT, "posRP", param)
            return reach
        end
        return false
    end

    local function checkHorseRP(pos)
        local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
        if heroId > 0 then
            local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
            local heroBaseId = unitData:getBase_id()
            local param = {pos = pos, heroBaseId = heroBaseId}
            local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_HORSE, "posRP", param)
            return reach
        end
        return false
    end 

    local function checkHeroUpgrade(pos)
        local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
        local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HERO_TRAIN_TYPE1, heroUnitData)
        return reach
    end

    local function checkHeroBreak(pos)
        local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
        local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HERO_TRAIN_TYPE2, heroUnitData)
        return reach
    end

    local function checkHeroAwake(pos)
        local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
        local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HERO_TRAIN_TYPE3, heroUnitData)
        return reach
    end

    local function checkHeroLimit(pos)
        local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
        local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HERO_TRAIN_TYPE4, heroUnitData)
        return reach
    end

    local function checkEquipStrengthen(pos)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_EQUIP_TRAIN_TYPE1, pos)
        return reach
    end

    local function checkEquipRefine(pos)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_EQUIP_TRAIN_TYPE2, pos)
        return reach
    end

    local function checkTreasureUpgrade(pos)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_TREASURE_TRAIN_TYPE1, pos)
        return reach
    end

    local function checkTreasureRefine(pos)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_TREASURE_TRAIN_TYPE2, pos)
        return reach
    end

    local function checkTreasureLimit(pos)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_TREASURE_TRAIN_TYPE3, pos)
        return reach
    end

    local function checkInstrumentAdvance(pos)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE1, pos)
        return reach
    end

    local function checkHorseUpStar(pos)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HORSE_TRAIN, pos)
        return reach
    end

    local function checkKarma(pos)
        local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
        local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HERO_KARMA, heroUnitData)
        return reach
    end

    local function checkHeroChange(pos)
        local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
        local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HERO_CHANGE, heroUnitData)
        return reach
    end

    local function checkAvatar(pos)
        if pos ~= 1 then
            return false
        end
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_AVATAR)
        return reach
    end

    local function checkEquipJade(pos)
        local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_EQUIP_TRAIN_TYPE3, pos)
        return reach
    end

    local checkFuncs = {
        [FunctionConst.FUNC_EQUIP] = checkEquipRP,
        [FunctionConst.FUNC_TREASURE] = checkTreasureRP,
        [FunctionConst.FUNC_INSTRUMENT] = checkInstrumentRP,
        [FunctionConst.FUNC_HORSE] = checkHorseRP,
        [FunctionConst.FUNC_HERO_TRAIN_TYPE1] = checkHeroUpgrade,
        [FunctionConst.FUNC_HERO_TRAIN_TYPE2] = checkHeroBreak,
        [FunctionConst.FUNC_HERO_TRAIN_TYPE3] = checkHeroAwake,
        [FunctionConst.FUNC_HERO_TRAIN_TYPE4] = checkHeroLimit,
        [FunctionConst.FUNC_EQUIP_TRAIN_TYPE1] = checkEquipStrengthen,
        [FunctionConst.FUNC_EQUIP_TRAIN_TYPE2] = checkEquipRefine,
        [FunctionConst.FUNC_TREASURE_TRAIN_TYPE1] = checkTreasureUpgrade,
        [FunctionConst.FUNC_TREASURE_TRAIN_TYPE2] = checkTreasureRefine,
        [FunctionConst.FUNC_TREASURE_TRAIN_TYPE3] = checkTreasureLimit,
        [FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE1] = checkInstrumentAdvance,
        [FunctionConst.FUNC_HORSE_TRAIN] = checkHorseUpStar,
        [FunctionConst.FUNC_HERO_KARMA] = checkKarma,
        [FunctionConst.FUNC_HERO_CHANGE] = checkHeroChange,
        [FunctionConst.FUNC_AVATAR] = checkAvatar,
        [FunctionConst.FUNC_EQUIP_TRAIN_TYPE3] = checkEquipJade,
    }


    local checkFuncs = {
        [FunctionConst.FUNC_EQUIP] = checkEquipRP,
        [FunctionConst.FUNC_TREASURE] = checkTreasureRP,
        [FunctionConst.FUNC_INSTRUMENT] = checkInstrumentRP,
        [FunctionConst.FUNC_HORSE] = checkHorseRP,
        [FunctionConst.FUNC_HERO_TRAIN_TYPE1] = checkHeroUpgrade,
        [FunctionConst.FUNC_HERO_TRAIN_TYPE2] = checkHeroBreak,
        [FunctionConst.FUNC_HERO_TRAIN_TYPE3] = checkHeroAwake,
        [FunctionConst.FUNC_HERO_TRAIN_TYPE4] = checkHeroLimit,
        [FunctionConst.FUNC_EQUIP_TRAIN_TYPE1] = checkEquipStrengthen,
        [FunctionConst.FUNC_EQUIP_TRAIN_TYPE2] = checkEquipRefine,
        [FunctionConst.FUNC_TREASURE_TRAIN_TYPE1] = checkTreasureUpgrade,
        [FunctionConst.FUNC_TREASURE_TRAIN_TYPE2] = checkTreasureRefine,
        [FunctionConst.FUNC_TREASURE_TRAIN_TYPE3] = checkTreasureLimit,
        [FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE1] = checkInstrumentAdvance,
        [FunctionConst.FUNC_HORSE_TRAIN] = checkHorseUpStar,
        [FunctionConst.FUNC_HERO_KARMA] = checkKarma,
        [FunctionConst.FUNC_HERO_CHANGE] = checkHeroChange,
        [FunctionConst.FUNC_AVATAR] = checkAvatar,
        [FunctionConst.FUNC_EQUIP_TRAIN_TYPE3] = checkEquipJade,
    }
    
    local heroIdList = G_UserData:getTeam():getHeroIdsInBattle()
    for i, value in ipairs(heroIdList) do

        -- 装备宝物提示箭头检测
        for j, funcId in ipairs(arrowFuncId) do
            local func = checkFuncs[funcId]
            if func then
                local reach = func(i)
                if reach then
                  return true
                end
            end
        end

        -- 红点检测
        for j, funcId in ipairs(redPointFuncId) do
            local func = checkFuncs[funcId]
            if func then
                local reach = func(i)
                if reach then
                    return true 
                end
            end
        end

    end

    return false  -- 无可显示红点
end

return TeamVeiwMainRP