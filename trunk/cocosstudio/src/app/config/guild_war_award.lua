--guild_war_award

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  day_min = 2,    --开服天数min-int 
  day_max = 3,    --开服天数max-int 
  type_1 = 4,    --类型1-int 
  value_1 = 5,    --类型值1-int 
  size_1 = 6,    --数量1-int 
  type_2 = 7,    --类型2-int 
  value_2 = 8,    --类型值2-int 
  size_2 = 9,    --数量2-int 
  type_3 = 10,    --类型3-int 
  value_3 = 11,    --类型值3-int 
  size_3 = 12,    --数量3-int 
  type_4 = 13,    --类型4-int 
  value_4 = 14,    --类型值4-int 
  size_4 = 15,    --数量4-int 
  type_5 = 16,    --类型5-int 
  value_5 = 17,    --类型值5-int 
  size_5 = 18,    --数量5-int 
  type_6 = 19,    --类型6-int 
  value_6 = 20,    --类型值6-int 
  size_6 = 21,    --数量6-int 
  type_7 = 22,    --类型7-int 
  value_7 = 23,    --类型值7-int 
  size_7 = 24,    --数量7-int 
  type_8 = 25,    --类型8-int 
  value_8 = 26,    --类型值8-int 
  size_8 = 27,    --数量8-int 
  type_9 = 28,    --类型9-int 
  value_9 = 29,    --类型值9-int 
  size_9 = 30,    --数量9-int 
  type_10 = 31,    --类型10-int 
  value_10 = 32,    --类型值10-int 
  size_10 = 33,    --数量10-int 
  type_11 = 34,    --类型11-int 
  value_11 = 35,    --类型值11-int 
  size_11 = 36,    --数量11-int 
  type_12 = 37,    --类型12-int 
  value_12 = 38,    --类型值12-int 
  size_12 = 39,    --数量12-int 
  type_13 = 40,    --类型13-int 
  value_13 = 41,    --类型值13-int 
  size_13 = 42,    --数量13-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  day_min = "int",    --开服天数min-2 
  day_max = "int",    --开服天数max-3 
  type_1 = "int",    --类型1-4 
  value_1 = "int",    --类型值1-5 
  size_1 = "int",    --数量1-6 
  type_2 = "int",    --类型2-7 
  value_2 = "int",    --类型值2-8 
  size_2 = "int",    --数量2-9 
  type_3 = "int",    --类型3-10 
  value_3 = "int",    --类型值3-11 
  size_3 = "int",    --数量3-12 
  type_4 = "int",    --类型4-13 
  value_4 = "int",    --类型值4-14 
  size_4 = "int",    --数量4-15 
  type_5 = "int",    --类型5-16 
  value_5 = "int",    --类型值5-17 
  size_5 = "int",    --数量5-18 
  type_6 = "int",    --类型6-19 
  value_6 = "int",    --类型值6-20 
  size_6 = "int",    --数量6-21 
  type_7 = "int",    --类型7-22 
  value_7 = "int",    --类型值7-23 
  size_7 = "int",    --数量7-24 
  type_8 = "int",    --类型8-25 
  value_8 = "int",    --类型值8-26 
  size_8 = "int",    --数量8-27 
  type_9 = "int",    --类型9-28 
  value_9 = "int",    --类型值9-29 
  size_9 = "int",    --数量9-30 
  type_10 = "int",    --类型10-31 
  value_10 = "int",    --类型值10-32 
  size_10 = "int",    --数量10-33 
  type_11 = "int",    --类型11-34 
  value_11 = "int",    --类型值11-35 
  size_11 = "int",    --数量11-36 
  type_12 = "int",    --类型12-37 
  value_12 = "int",    --类型值12-38 
  size_12 = "int",    --数量12-39 
  type_13 = "int",    --类型13-40 
  value_13 = "int",    --类型值13-41 
  size_13 = "int",    --数量13-42 

}


-- data
local guild_war_award = {
    version =  1,
    _data = {
        [1] = {1,1,23,11,1313,1,11,1314,1,11,1224,1,11,1225,1,11,1227,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [2] = {2,24,999,11,1313,1,11,1314,1,11,1224,1,11,1225,1,11,1227,1,6,81,1,6,92,1,6,93,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_war_award")
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
function guild_war_award.length()
    return #guild_war_award._data
end

-- 
function guild_war_award.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_war_award.isVersionValid(v)
    if guild_war_award.version then
        if v then
            return guild_war_award.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_war_award.indexOf(index)
    if index == nil or not guild_war_award._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_war_award.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_war_award.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_war_award.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_war_award" )
                _isDataExist = guild_war_award.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_war_award" )
                _isBaseExist = guild_war_award.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_war_award" )
                _isExist = guild_war_award.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_war_award" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_war_award" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_war_award._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_war_award" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_war_award.get(id)
    
    return guild_war_award.indexOf(__index_id[id])
        
end

--
function guild_war_award.set(id, key, value)
    local record = guild_war_award.get(id)
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
function guild_war_award.index()
    return __index_id
end

return guild_war_award