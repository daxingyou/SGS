--qin_monster

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --boss序号-int 
  small_weight = 2,    --普通怪权重-int 
  big_weight = 3,    --精英怪权重-int 
  small_reward = 4,    --普通怪奖励组-int 
  big_reward = 5,    --精英怪奖励组-int 
  small2_reward = 6,    --同军团普通怪奖励-int 
  big2_reward = 7,    --同军团精英怪奖励-int 
  point_id_1 = 8,    --对应怪物点id-int 
  point_id_2 = 9,    --对应站台点类型-int 
  point_id_3 = 10,    --对应挂机点类型-int 
  point_id_4 = 11,    --对应pk点类型-int 
  small_name = 12,    --普通怪物名称-string 
  big_name = 13,    --精英怪物名称-string 
  small_color = 14,    --普通怪物品质-int 
  big_color = 15,    --精英怪物品质-int 
  small_image = 16,    --普通怪形象-int 
  big_image = 17,    --精英怪形象-int 
  small_time = 18,    --普通怪动作时间（实际/1000）-int 
  big_time = 19,    --精英怪动作时间（实际/1000）-int 
  small_die = 20,    --普通怪死亡动作时间（实际/1000）-int 
  big_die = 21,    --精英怪死亡动作时间（实际/1000）-int 

}

-- key type
local __key_type = {
  id = "int",    --boss序号-1 
  small_weight = "int",    --普通怪权重-2 
  big_weight = "int",    --精英怪权重-3 
  small_reward = "int",    --普通怪奖励组-4 
  big_reward = "int",    --精英怪奖励组-5 
  small2_reward = "int",    --同军团普通怪奖励-6 
  big2_reward = "int",    --同军团精英怪奖励-7 
  point_id_1 = "int",    --对应怪物点id-8 
  point_id_2 = "int",    --对应站台点类型-9 
  point_id_3 = "int",    --对应挂机点类型-10 
  point_id_4 = "int",    --对应pk点类型-11 
  small_name = "string",    --普通怪物名称-12 
  big_name = "string",    --精英怪物名称-13 
  small_color = "int",    --普通怪物品质-14 
  big_color = "int",    --精英怪物品质-15 
  small_image = "int",    --普通怪形象-16 
  big_image = "int",    --精英怪形象-17 
  small_time = "int",    --普通怪动作时间（实际/1000）-18 
  big_time = "int",    --精英怪动作时间（实际/1000）-19 
  small_die = "int",    --普通怪死亡动作时间（实际/1000）-20 
  big_die = "int",    --精英怪死亡动作时间（实际/1000）-21 

}


-- data
local qin_monster = {
    _data = {
        [1] = {1,98,2,800,810,830,840,401,301,501,601,"先秦甲士","皇陵梦魇",3,5,10002,10001,1866,1833,1100,1200,},
        [2] = {2,98,2,800,810,830,840,402,302,502,602,"先秦甲士","皇陵梦魇",3,5,10002,10001,1866,1833,1100,1200,},
        [3] = {3,98,2,800,810,830,840,403,303,503,603,"先秦甲士","皇陵梦魇",3,5,10002,10001,1866,1833,1100,1200,},
        [4] = {4,98,2,802,812,832,842,404,304,504,604,"先秦徒兵","皇陵梦魇",3,5,10003,10001,1433,1833,1033,1200,},
        [5] = {5,98,2,802,812,832,842,405,305,505,605,"先秦徒兵","皇陵梦魇",3,5,10003,10001,1433,1833,1033,1200,},
        [6] = {6,98,2,802,812,832,842,406,306,506,606,"先秦徒兵","皇陵梦魇",3,5,10003,10001,1433,1833,1033,1200,},
        [7] = {7,98,2,801,811,831,841,407,307,507,607,"先秦车兵","皇陵梦魇",3,5,10004,10001,2566,1833,833,1200,},
        [8] = {8,98,2,801,811,831,841,408,308,508,608,"先秦车兵","皇陵梦魇",3,5,10004,10001,2566,1833,833,1200,},
        [9] = {9,98,2,801,811,831,841,409,309,509,609,"先秦车兵","皇陵梦魇",3,5,10004,10001,2566,1833,833,1200,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in qin_monster")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function qin_monster.length()
    return #qin_monster._data
end

-- 
function qin_monster.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function qin_monster.indexOf(index)
    if index == nil or not qin_monster._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/qin_monster.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "qin_monster" )
        return setmetatable({_raw = qin_monster._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = qin_monster._data[index]}, mt)
end

--
function qin_monster.get(id)
    
    return qin_monster.indexOf(__index_id[id])
        
end

--
function qin_monster.set(id, key, value)
    local record = qin_monster.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function qin_monster.index()
    return __index_id
end

return qin_monster