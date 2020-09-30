--boss_award

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  day_min = 2,    --开服天数min-int 
  day_max = 3,    --开服天数max-int 
  reward_type_1 = 4,    --奖励类型1-int 
  reward_type_2 = 5,    --奖励类型2-int 
  reward_type_3 = 6,    --奖励类型3-int 
  reward_type_4 = 7,    --奖励类型4-int 
  type_1 = 8,    --类型1-int 
  value_1 = 9,    --类型值1-int 
  size_1 = 10,    --数量1-int 
  type_2 = 11,    --类型2-int 
  value_2 = 12,    --类型值2-int 
  size_2 = 13,    --数量2-int 
  type_3 = 14,    --类型3-int 
  value_3 = 15,    --类型值3-int 
  size_3 = 16,    --数量3-int 
  type_4 = 17,    --类型4-int 
  value_4 = 18,    --类型值4-int 
  size_4 = 19,    --数量4-int 
  type_5 = 20,    --类型5-int 
  value_5 = 21,    --类型值5-int 
  size_5 = 22,    --数量5-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  day_min = "int",    --开服天数min-2 
  day_max = "int",    --开服天数max-3 
  reward_type_1 = "int",    --奖励类型1-4 
  reward_type_2 = "int",    --奖励类型2-5 
  reward_type_3 = "int",    --奖励类型3-6 
  reward_type_4 = "int",    --奖励类型4-7 
  type_1 = "int",    --类型1-8 
  value_1 = "int",    --类型值1-9 
  size_1 = "int",    --数量1-10 
  type_2 = "int",    --类型2-11 
  value_2 = "int",    --类型值2-12 
  size_2 = "int",    --数量2-13 
  type_3 = "int",    --类型3-14 
  value_3 = "int",    --类型值3-15 
  size_3 = "int",    --数量3-16 
  type_4 = "int",    --类型4-17 
  value_4 = "int",    --类型值4-18 
  size_4 = "int",    --数量4-19 
  type_5 = "int",    --类型5-20 
  value_5 = "int",    --类型值5-21 
  size_5 = "int",    --数量5-22 

}


-- data
local boss_award = {
    version =  1,
    _data = {
        [1] = {1,1,2,2,3,0,0,6,23,1,0,0,0,0,0,0,0,0,0,0,0,0,},
        [2] = {2,3,3,2,3,0,0,6,24,1,6,23,1,0,0,0,0,0,0,0,0,0,},
        [3] = {3,4,6,2,3,4,0,6,24,1,6,23,1,0,0,0,0,0,0,0,0,0,},
        [4] = {4,7,13,2,4,101,102,6,24,1,0,0,0,0,0,0,0,0,0,0,0,0,},
        [5] = {5,14,26,2,4,101,102,6,25,1,6,500,1,0,0,0,0,0,0,0,0,0,},
        [6] = {6,27,39,2,4,101,102,6,25,1,6,501,1,0,0,0,0,0,0,0,0,0,},
        [7] = {7,40,48,2,4,101,102,6,26,1,6,501,1,0,0,0,0,0,0,0,0,0,},
        [8] = {8,49,84,2,4,101,102,6,26,1,6,502,1,0,0,0,0,0,0,0,0,0,},
        [9] = {9,85,117,2,4,101,102,6,26,1,6,503,1,0,0,0,0,0,0,0,0,0,},
        [10] = {10,118,147,2,4,101,102,6,27,1,6,503,1,0,0,0,0,0,0,0,0,0,},
        [11] = {11,148,999,2,4,101,102,6,27,1,6,504,1,0,0,0,0,0,0,0,0,0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
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
    [10] = 10,
    [11] = 11,
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
        assert(key_map[k], "cannot find " .. k .. " in boss_award")
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
function boss_award.length()
    return #boss_award._data
end

-- 
function boss_award.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function boss_award.isVersionValid(v)
    if boss_award.version then
        if v then
            return boss_award.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function boss_award.indexOf(index)
    if index == nil or not boss_award._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/boss_award.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/boss_award.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/boss_award.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "boss_award" )
                _isDataExist = boss_award.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "boss_award" )
                _isBaseExist = boss_award.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "boss_award" )
                _isExist = boss_award.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "boss_award" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "boss_award" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = boss_award._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "boss_award" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function boss_award.get(id)
    
    return boss_award.indexOf(__index_id[id])
        
end

--
function boss_award.set(id, key, value)
    local record = boss_award.get(id)
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
function boss_award.index()
    return __index_id
end

return boss_award