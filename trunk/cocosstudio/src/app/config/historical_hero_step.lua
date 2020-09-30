--historical_hero_step

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  step = 2,    --阶数-int 
  atk = 3,    --攻击-int 
  hp = 4,    --生命-int 
  pdef = 5,    --物防-int 
  mdef = 6,    --法防-int 
  power = 7,    --假战力-int 
  type_1 = 8,    --消耗1类型-int 
  value_1 = 9,    --消耗1类型值-int 
  step_1 = 10,    --消耗1阶数-int 
  size_1 = 11,    --消耗1数量-int 
  type_2 = 12,    --消耗2类型-int 
  value_2 = 13,    --消耗2类型值-int 
  step_2 = 14,    --消耗2阶数-int 
  size_2 = 15,    --消耗2数量-int 
  type_3 = 16,    --消耗3类型-int 
  value_3 = 17,    --消耗3类型值-int 
  step_3 = 18,    --消耗3阶数-int 
  size_3 = 19,    --消耗3数量-int 
  skill_type1 = 20,    --技能属性1类型-int 
  skill_size1 = 21,    --技能属性1数值-int 
  skill_id = 22,    --技能id-int 
  skill_round = 23,    --技能触发点-int 
  skill_front = 24,    --技能表现时机（前端）-int 
  skill_effectid = 25,    --技能表现EFFECT-int 
  description = 26,    --技能描述-string 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  step = "int",    --阶数-2 
  atk = "int",    --攻击-3 
  hp = "int",    --生命-4 
  pdef = "int",    --物防-5 
  mdef = "int",    --法防-6 
  power = "int",    --假战力-7 
  type_1 = "int",    --消耗1类型-8 
  value_1 = "int",    --消耗1类型值-9 
  step_1 = "int",    --消耗1阶数-10 
  size_1 = "int",    --消耗1数量-11 
  type_2 = "int",    --消耗2类型-12 
  value_2 = "int",    --消耗2类型值-13 
  step_2 = "int",    --消耗2阶数-14 
  size_2 = "int",    --消耗2数量-15 
  type_3 = "int",    --消耗3类型-16 
  value_3 = "int",    --消耗3类型值-17 
  step_3 = "int",    --消耗3阶数-18 
  size_3 = "int",    --消耗3数量-19 
  skill_type1 = "int",    --技能属性1类型-20 
  skill_size1 = "int",    --技能属性1数值-21 
  skill_id = "int",    --技能id-22 
  skill_round = "int",    --技能触发点-23 
  skill_front = "int",    --技能表现时机（前端）-24 
  skill_effectid = "int",    --技能表现EFFECT-25 
  description = "string",    --技能描述-26 

}


-- data
local historical_hero_step = {
    version =  1,
    _data = {
        [1] = {101,1,3000,45000,3000,3000,960000,14,101,0,1,0,0,0,0,0,0,0,0,14,50,10000020,1,1,3001,"护佑武将的生命额外增加5%",},
        [2] = {101,2,6000,90000,6000,6000,1920000,0,0,0,0,0,0,0,0,0,0,0,0,14,100,10000120,1,1,3001,"护佑武将的生命额外增加5%",},
        [3] = {102,1,3000,45000,3000,3000,960000,14,102,0,1,0,0,0,0,0,0,0,0,19,50,10010020,1,1,3002,"护佑武将的伤害额外增加5%",},
        [4] = {102,2,6000,90000,6000,6000,1920000,0,0,0,0,0,0,0,0,0,0,0,0,19,100,10010120,1,1,3002,"护佑武将的伤害额外增加5%",},
        [5] = {103,1,3000,45000,3000,3000,960000,14,103,0,1,0,0,0,0,0,0,0,0,8,50,10020020,1,1,3003,"护佑武将的攻击额外增加5%",},
        [6] = {103,2,6000,90000,6000,6000,1920000,0,0,0,0,0,0,0,0,0,0,0,0,8,100,10020120,1,1,3003,"护佑武将的攻击额外增加5%",},
        [7] = {104,1,3000,45000,3000,3000,960000,14,104,0,1,0,0,0,0,0,0,0,0,20,50,10030020,1,1,3004,"护佑武将的伤害减免额外增加5%",},
        [8] = {104,2,6000,90000,6000,6000,1920000,0,0,0,0,0,0,0,0,0,0,0,0,20,100,10030120,1,1,3004,"护佑武将的伤害减免额外增加5%",},
        [9] = {201,1,9000,135000,9000,9000,3600000,14,201,0,1,0,0,0,0,0,0,0,0,0,0,10010030,3,2,3005,"护佑武将受到其他武将的直接伤害额外降低9%，受到异常（麻痹，眩晕，沉默，灼烧，中毒，虚弱，压制，铁索，击飞）效果的概率降低12%",},
        [10] = {201,2,18000,270000,18000,18000,7200000,13,101,2,1,13,102,2,1,13,103,2,1,0,0,10010130,3,2,3005,"护佑武将受到异常（麻痹，眩晕，沉默，灼烧，中毒，虚弱，压制，铁索，击飞）效果的概率额外降低24%",},
        [11] = {201,3,36000,540000,36000,36000,10800000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10010230,3,2,3005,"护佑武将受到异常（麻痹，眩晕，沉默，灼烧，中毒，虚弱，压制，铁索，击飞）效果的概率额外降低24%",},
        [12] = {202,1,9000,135000,9000,9000,3600000,14,202,0,1,0,0,0,0,0,0,0,0,0,0,10020030,2,2,3006,"护佑武将所造成的伤害及治疗额外增加9%，暴击伤害额外增加24%",},
        [13] = {202,2,18000,270000,18000,18000,7200000,13,101,2,1,13,102,2,1,13,104,2,1,0,0,10020130,2,2,3006,"护佑武将的暴击伤害额外增加24%",},
        [14] = {202,3,36000,540000,36000,36000,10800000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10020230,2,2,3006,"护佑武将的暴击伤害额外增加24%",},
        [15] = {203,1,9000,135000,9000,9000,3600000,14,203,0,1,0,0,0,0,0,0,0,0,0,0,10030030,4,4,3007,"护佑武将受到己方青龙，朱雀，玄武施加的有益效果时，效果额外再增加25%（怒气无额外增加）",},
        [16] = {203,2,18000,270000,18000,18000,7200000,13,101,2,1,13,103,2,1,13,104,2,1,0,0,10030130,4,4,3007,"护佑武将受到己方青龙，朱雀，玄武施加的有益效果时，效果额外再增加25%（怒气额外增加1）",},
        [17] = {203,3,36000,540000,36000,36000,10800000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10030230,4,4,3007,"护佑武将受到己方青龙，朱雀，玄武施加的有益效果时，效果额外再增加25%（怒气额外增加1）",},
        [18] = {204,1,9000,135000,9000,9000,3600000,14,204,0,1,0,0,0,0,0,0,0,0,52,360,10040030,3,2,3008,"护佑武将受到武将的直接伤害时，100%几率清除自身1个灼烧或中毒状态",},
        [19] = {204,2,18000,270000,18000,18000,7200000,13,102,2,1,13,103,2,1,13,104,2,1,52,360,10040130,3,2,3008,"护佑武将受到武将的直接伤害时，额外有50%的几率清除自身1个压制或虚弱状态",},
        [20] = {204,3,36000,540000,36000,36000,10800000,0,0,0,0,0,0,0,0,0,0,0,0,52,360,10040230,3,2,3008,"护佑武将受到武将的直接伤害时，额外有50%的几率清除自身1个压制或虚弱状态",},
    }
}

-- index
local __index_id_step = {
    ["101_1"] = 1,
    ["101_2"] = 2,
    ["102_1"] = 3,
    ["102_2"] = 4,
    ["103_1"] = 5,
    ["103_2"] = 6,
    ["104_1"] = 7,
    ["104_2"] = 8,
    ["201_1"] = 9,
    ["201_2"] = 10,
    ["201_3"] = 11,
    ["202_1"] = 12,
    ["202_2"] = 13,
    ["202_3"] = 14,
    ["203_1"] = 15,
    ["203_2"] = 16,
    ["203_3"] = 17,
    ["204_1"] = 18,
    ["204_2"] = 19,
    ["204_3"] = 20,

}

-- index mainkey map
local __main_key_map = {
    [1] = "101_1",
    [2] = "101_2",
    [3] = "102_1",
    [4] = "102_2",
    [5] = "103_1",
    [6] = "103_2",
    [7] = "104_1",
    [8] = "104_2",
    [9] = "201_1",
    [10] = "201_2",
    [11] = "201_3",
    [12] = "202_1",
    [13] = "202_2",
    [14] = "202_3",
    [15] = "203_1",
    [16] = "203_2",
    [17] = "203_3",
    [18] = "204_1",
    [19] = "204_2",
    [20] = "204_3",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in historical_hero_step")
        if _lang ~= "cn" and _isDataExist  and t._data_key_map[k] then
            return t._data[t._data_key_map[k]]
        end
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[key_map[k]]
    end
}

-- 
function historical_hero_step.length()
    return #historical_hero_step._data
end

-- 
function historical_hero_step.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function historical_hero_step.isVersionValid(v)
    if historical_hero_step.version then
        if v then
            return historical_hero_step.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function historical_hero_step.indexOf(index)
    if index == nil or not historical_hero_step._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/historical_hero_step.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/historical_hero_step.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/historical_hero_step.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "historical_hero_step" )
                _isDataExist = historical_hero_step.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "historical_hero_step" )
                _isBaseExist = historical_hero_step.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero_step" )
                _isExist = historical_hero_step.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "historical_hero_step" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id_step"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero_step" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id_step"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = historical_hero_step._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "historical_hero_step" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function historical_hero_step.get(id,step)
    
    local k = id .. '_' .. step
    return historical_hero_step.indexOf(__index_id_step[k])
        
end

--
function historical_hero_step.set(id,step, key, value)
    local record = historical_hero_step.get(id,step)
    if record then
        if _lang ~= "cn" and _isDataExist then
            local keyIndex =  record._data_key_map[key]
            if keyIndex then
                record._data[keyIndex] = value
                return
            end
        end
        if _lang ~= "cn" and _isExist then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
                return
            end
        end
        local keyIndex = record._raw_key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function historical_hero_step.index()
    return __index_id_step
end

return historical_hero_step