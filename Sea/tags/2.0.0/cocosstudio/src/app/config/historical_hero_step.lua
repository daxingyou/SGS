--historical_hero_step

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  step = 2,    --阶数-int 
  atk = 3,    --全体攻击-int 
  hp = 4,    --全体生命-int 
  pdef = 5,    --全体物防-int 
  mdef = 6,    --全体法防-int 
  power = 7,    --假战力-int 
  type_1 = 8,    --消耗1类型-int 
  value_1 = 9,    --消耗1类型值-int 
  size_1 = 10,    --消耗1数量-int 
  type_2 = 11,    --消耗2类型-int 
  value_2 = 12,    --消耗2类型值-int 
  size_2 = 13,    --消耗2数量-int 
  type_3 = 14,    --消耗3类型-int 
  value_3 = 15,    --消耗3类型值-int 
  size_3 = 16,    --消耗3数量-int 
  skill_type1 = 17,    --技能属性1类型-int 
  skill_size1 = 18,    --技能属性1数值-int 
  skill_id = 19,    --技能id-int 
  description = 20,    --技能描述-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  step = "int",    --阶数-2 
  atk = "int",    --全体攻击-3 
  hp = "int",    --全体生命-4 
  pdef = "int",    --全体物防-5 
  mdef = "int",    --全体法防-6 
  power = "int",    --假战力-7 
  type_1 = "int",    --消耗1类型-8 
  value_1 = "int",    --消耗1类型值-9 
  size_1 = "int",    --消耗1数量-10 
  type_2 = "int",    --消耗2类型-11 
  value_2 = "int",    --消耗2类型值-12 
  size_2 = "int",    --消耗2数量-13 
  type_3 = "int",    --消耗3类型-14 
  value_3 = "int",    --消耗3类型值-15 
  size_3 = "int",    --消耗3数量-16 
  skill_type1 = "int",    --技能属性1类型-17 
  skill_size1 = "int",    --技能属性1数值-18 
  skill_id = "int",    --技能id-19 
  description = "int",    --技能描述-20 

}


-- data
local historical_hero_step = {
    _data = {
        [1] = {101,1,2400,17200,1200,1200,1000000,14,101,1,0,0,0,0,0,0,14,50,10000020,0,},
        [2] = {101,2,3600,26000,1800,1800,2000000,0,0,0,0,0,0,0,0,0,14,100,10000120,0,},
        [3] = {102,1,2400,17200,1200,1200,1000000,14,102,1,0,0,0,0,0,0,19,50,10010020,0,},
        [4] = {102,2,3600,26000,1800,1800,2000000,0,0,0,0,0,0,0,0,0,19,100,10010120,0,},
        [5] = {103,1,2400,17200,1200,1200,1000000,14,103,1,0,0,0,0,0,0,8,50,10020020,0,},
        [6] = {103,2,3600,26000,1800,1800,2000000,0,0,0,0,0,0,0,0,0,8,100,10020120,0,},
        [7] = {104,1,2400,17200,1200,1200,1000000,14,104,1,0,0,0,0,0,0,11,50,10030020,0,},
        [8] = {104,2,3600,26000,1800,1800,2000000,0,0,0,0,0,0,0,0,0,11,100,10030120,0,},
        [9] = {201,1,2400,17200,1200,1200,1000000,14,201,1,0,0,0,0,0,0,19,120,10010030,0,},
        [10] = {201,2,3600,26000,1800,1800,2000000,13,101,1,13,102,1,13,103,1,19,120,10010130,0,},
        [11] = {201,3,5200,38600,2600,2600,3000000,0,0,0,0,0,0,0,0,0,19,120,10010230,0,},
        [12] = {202,1,2400,17200,1200,1200,1000000,14,202,1,0,0,0,0,0,0,19,120,10010030,0,},
        [13] = {202,2,3600,26000,1800,1800,2000000,13,101,1,13,102,1,13,104,1,19,120,10010130,0,},
        [14] = {202,3,5200,38600,2600,2600,3000000,0,0,0,0,0,0,0,0,0,19,120,10010230,0,},
        [15] = {203,1,2400,17200,1200,1200,1000000,14,203,1,0,0,0,0,0,0,0,0,20301,0,},
        [16] = {203,2,3600,26000,1800,1800,2000000,13,101,1,13,103,1,13,104,1,0,0,20302,0,},
        [17] = {203,3,5200,38600,2600,2600,3000000,0,0,0,0,0,0,0,0,0,0,0,20303,0,},
        [18] = {204,1,2400,17200,1200,1200,1000000,14,204,1,0,0,0,0,0,0,0,0,20401,0,},
        [19] = {204,2,3600,26000,1800,1800,2000000,13,102,1,13,103,1,13,104,1,0,0,20402,0,},
        [20] = {204,3,5200,38600,2600,2600,3000000,0,0,0,0,0,0,0,0,0,0,0,20403,0,},
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

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in historical_hero_step")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
function historical_hero_step.indexOf(index)
    if index == nil or not historical_hero_step._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/historical_hero_step.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero_step" )
        return setmetatable({_raw = historical_hero_step._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = historical_hero_step._data[index]}, mt)
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
        local keyIndex = __key_map[key]
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