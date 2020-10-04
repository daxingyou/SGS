--qin_monster

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --boss序号-int 
  small_weight = 2,    --普通怪权重-int 
  big_weight = 3,    --精英怪权重-int 
  small_reward = 4,    --低级怪奖励组1-int 
  big_reward = 5,    --低级精英怪奖励组1-int 
  small2_reward = 6,    --低级同军团普通怪奖励1-int 
  big2_reward = 7,    --低级同军团精英怪奖励1-int 
  small3_reward = 8,    --高级普通怪奖励组2-int 
  big3_reward = 9,    --高级精英怪奖励组2-int 
  small4_reward = 10,    --高级同军团普通怪奖励2-int 
  big4_reward = 11,    --高级同军团精英怪奖励2-int 
  point_id_1 = 12,    --对应怪物点id-int 
  point_id_2 = 13,    --对应站台点类型-int 
  point_id_3 = 14,    --对应挂机点类型-int 
  point_id_4 = 15,    --对应pk点类型-int 
  small_name = 16,    --普通怪物名称-string 
  big_name = 17,    --精英怪物名称-string 
  small_color = 18,    --普通怪物品质-int 
  big_color = 19,    --精英怪物品质-int 
  small_image = 20,    --普通怪形象-int 
  big_image = 21,    --精英怪形象-int 
  small_time = 22,    --普通怪动作时间（实际/1000）-int 
  big_time = 23,    --精英怪动作时间（实际/1000）-int 
  small_die = 24,    --普通怪死亡动作时间（实际/1000）-int 
  big_die = 25,    --精英怪死亡动作时间（实际/1000）-int 

}

-- key type
local __key_type = {
  id = "int",    --boss序号-1 
  small_weight = "int",    --普通怪权重-2 
  big_weight = "int",    --精英怪权重-3 
  small_reward = "int",    --低级怪奖励组1-4 
  big_reward = "int",    --低级精英怪奖励组1-5 
  small2_reward = "int",    --低级同军团普通怪奖励1-6 
  big2_reward = "int",    --低级同军团精英怪奖励1-7 
  small3_reward = "int",    --高级普通怪奖励组2-8 
  big3_reward = "int",    --高级精英怪奖励组2-9 
  small4_reward = "int",    --高级同军团普通怪奖励2-10 
  big4_reward = "int",    --高级同军团精英怪奖励2-11 
  point_id_1 = "int",    --对应怪物点id-12 
  point_id_2 = "int",    --对应站台点类型-13 
  point_id_3 = "int",    --对应挂机点类型-14 
  point_id_4 = "int",    --对应pk点类型-15 
  small_name = "string",    --普通怪物名称-16 
  big_name = "string",    --精英怪物名称-17 
  small_color = "int",    --普通怪物品质-18 
  big_color = "int",    --精英怪物品质-19 
  small_image = "int",    --普通怪形象-20 
  big_image = "int",    --精英怪形象-21 
  small_time = "int",    --普通怪动作时间（实际/1000）-22 
  big_time = "int",    --精英怪动作时间（实际/1000）-23 
  small_die = "int",    --普通怪死亡动作时间（实际/1000）-24 
  big_die = "int",    --精英怪死亡动作时间（实际/1000）-25 

}


-- data
local qin_monster = {
    version =  1,
    _data = {
        [1] = {1,985,15,800,810,820,830,800,813,820,833,401,301,501,601,"先秦甲士","皇陵梦魇",3,5,10002,10001,1866,1833,1100,1200,},
        [2] = {2,985,15,800,810,820,830,800,813,820,833,402,302,502,602,"先秦甲士","皇陵梦魇",3,5,10002,10001,1866,1833,1100,1200,},
        [3] = {3,985,15,800,810,820,830,800,813,820,833,403,303,503,603,"先秦甲士","皇陵梦魇",3,5,10002,10001,1866,1833,1100,1200,},
        [4] = {4,985,15,802,812,822,832,802,815,822,835,404,304,504,604,"先秦徒兵","皇陵梦魇",3,5,10003,10001,1433,1833,1033,1200,},
        [5] = {5,985,15,802,812,822,832,802,815,822,835,405,305,505,605,"先秦徒兵","皇陵梦魇",3,5,10003,10001,1433,1833,1033,1200,},
        [6] = {6,985,15,802,812,822,832,802,815,822,835,406,306,506,606,"先秦徒兵","皇陵梦魇",3,5,10003,10001,1433,1833,1033,1200,},
        [7] = {7,985,15,801,811,821,831,801,814,821,834,407,307,507,607,"先秦车兵","皇陵梦魇",3,5,10004,10001,2566,1833,833,1200,},
        [8] = {8,985,15,801,811,821,831,801,814,821,834,408,308,508,608,"先秦车兵","皇陵梦魇",3,5,10004,10001,2566,1833,833,1200,},
        [9] = {9,985,15,801,811,821,831,801,814,821,834,409,309,509,609,"先秦车兵","皇陵梦魇",3,5,10004,10001,2566,1833,833,1200,},
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

-- index mainkey map
local __main_key_map = {
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
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in qin_monster")
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
function qin_monster.isVersionValid(v)
    if qin_monster.version then
        if v then
            return qin_monster.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function qin_monster.indexOf(index)
    if index == nil or not qin_monster._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/qin_monster.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/qin_monster.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/qin_monster.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "qin_monster" )
                _isDataExist = qin_monster.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "qin_monster" )
                _isBaseExist = qin_monster.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "qin_monster" )
                _isExist = qin_monster.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "qin_monster" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "qin_monster" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = qin_monster._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "qin_monster" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function qin_monster.get(id)
    
    return qin_monster.indexOf(__index_id[id])
        
end

--
function qin_monster.set(id, key, value)
    local record = qin_monster.get(id)
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
function qin_monster.index()
    return __index_id
end

return qin_monster