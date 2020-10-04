local EquipJadeHelper = {}
local JadeInfo = require("app.config.jade")

-- 获取最垃圾的合适的玉石详情
function EquipJadeHelper.getMinSuitableJade(equipBaseId, property)
    for i = 1, JadeInfo.length() do
        local config = JadeInfo.indexOf(i)
        if property == config.property then
            local suitableInfo = string.split(config.equipment, "|")
            for i = 1, #suitableInfo do
                if tonumber(suitableInfo[i]) == equipBaseId then
                    return config
                end
            end
        end
    end
end

-- 弹出玉石选择框
function EquipJadeHelper.popupChooseJadeStone(slot, jadeData, equipUnitData, callback, isChange)
    local popupChooseJadeStone = require("app.ui.PopupChooseJadeStone").new(isChange)
    local title = Lang.get("equipment_choose_jade_title1")
    if not jadeData then
        title = Lang.get("equipment_choose_jade_title3")
    end
    popupChooseJadeStone:setTitle(title)
    popupChooseJadeStone:updateUI(slot, jadeData, equipUnitData, callback)
    popupChooseJadeStone:openWithAction()
end

-- 获取装备玉石列表根据是否需要隐藏已经穿戴
function EquipJadeHelper.getEquipJadeListByWear(slot, jadeData, equipUnitData, isWaer)
    local params = {}
    if jadeData then
        params.jadeId = jadeData:getId()
    end
    if slot > 1 then
        params.property = 2
    else
        params.property = 1
    end
    if equipUnitData then
        params.equipBaseId = equipUnitData:getBase_id()
        params.equipId = equipUnitData:getId()
    end
    params.hideWear = isWaer
    local jade = G_UserData:getJade()
    local dataList = jade:getJadeListByEquip(params)
    return dataList
end

function EquipJadeHelper.getRealAttrValue(cfg, level)
    local size = cfg.size
    if cfg.growth > 0 then
        local funcLevelInfo = require("app.config.function_level").get(FunctionConst.FUNC_EQUIP_TRAIN_TYPE3)
        local offsetLevel = level - funcLevelInfo.level
        if offsetLevel > 0 then
            size = size + cfg.growth * offsetLevel
        end
    end
    return size
end

function EquipJadeHelper.isSuitableHero(cfg, heroBaseId)
    local suitableInfo = string.split(cfg.hero, "|")
    if tonumber(suitableInfo[1]) == 999 then
        return true
    end
    for i = 1, #suitableInfo do
        if (tonumber(suitableInfo[i]) == heroBaseId) then
            return true
        end
    end
    return false
end

function EquipJadeHelper.getJadeConfig(id)
    local config = JadeInfo.get(id)
    return config
end

return EquipJadeHelper
