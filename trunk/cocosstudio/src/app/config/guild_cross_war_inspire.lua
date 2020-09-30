--guild_cross_war_inspire

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --索引id-int 
  type = 2,    --鼓舞类型-int 
  level = 3,    --鼓舞等级-int 
  value = 4,    --攻击/防御加成值-int 
  cost = 5,    --鼓舞消耗-int 

}

-- key type
local __key_type = {
  id = "int",    --索引id-1 
  type = "int",    --鼓舞类型-2 
  level = "int",    --鼓舞等级-3 
  value = "int",    --攻击/防御加成值-4 
  cost = "int",    --鼓舞消耗-5 

}


-- data
local guild_cross_war_inspire = {
    version =  1,
    _data = {
        [1] = {1,1,1,1,2000,},
        [2] = {2,1,2,2,2000,},
        [3] = {3,1,3,3,2000,},
        [4] = {101,2,1,1,2000,},
        [5] = {102,2,2,2,2000,},
        [6] = {103,2,3,3,2000,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [101] = 4,
    [102] = 5,
    [103] = 6,
    [2] = 2,
    [3] = 3,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [4] = 101,
    [5] = 102,
    [6] = 103,
    [2] = 2,
    [3] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_cross_war_inspire")
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
function guild_cross_war_inspire.length()
    return #guild_cross_war_inspire._data
end

-- 
function guild_cross_war_inspire.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_cross_war_inspire.isVersionValid(v)
    if guild_cross_war_inspire.version then
        if v then
            return guild_cross_war_inspire.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_cross_war_inspire.indexOf(index)
    if index == nil or not guild_cross_war_inspire._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_cross_war_inspire.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_cross_war_inspire.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_cross_war_inspire.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_inspire" )
                _isDataExist = guild_cross_war_inspire.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_inspire" )
                _isBaseExist = guild_cross_war_inspire.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_inspire" )
                _isExist = guild_cross_war_inspire.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_inspire" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_inspire" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_cross_war_inspire._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_inspire" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_cross_war_inspire.get(id)
    
    return guild_cross_war_inspire.indexOf(__index_id[id])
        
end

--
function guild_cross_war_inspire.set(id, key, value)
    local record = guild_cross_war_inspire.get(id)
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
function guild_cross_war_inspire.index()
    return __index_id
end

return guild_cross_war_inspire