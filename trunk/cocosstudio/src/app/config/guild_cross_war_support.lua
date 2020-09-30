--guild_cross_war_support

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  level = 1,    --支援等级-int 
  support = 2,    --升到下级需要支援人数-int 
  soldiers = 3,    --兵力值-int 

}

-- key type
local __key_type = {
  level = "int",    --支援等级-1 
  support = "int",    --升到下级需要支援人数-2 
  soldiers = "int",    --兵力值-3 

}


-- data
local guild_cross_war_support = {
    version =  1,
    _data = {
        [1] = {1,50,100,},
        [2] = {2,100,105,},
        [3] = {3,200,110,},
        [4] = {4,99999,120,},
    }
}

-- index
local __index_level = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_cross_war_support")
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
function guild_cross_war_support.length()
    return #guild_cross_war_support._data
end

-- 
function guild_cross_war_support.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_cross_war_support.isVersionValid(v)
    if guild_cross_war_support.version then
        if v then
            return guild_cross_war_support.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_cross_war_support.indexOf(index)
    if index == nil or not guild_cross_war_support._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_cross_war_support.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_cross_war_support.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_cross_war_support.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_support" )
                _isDataExist = guild_cross_war_support.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_support" )
                _isBaseExist = guild_cross_war_support.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_support" )
                _isExist = guild_cross_war_support.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_support" )
        local main_key = __main_key_map[index]
		local index_key = "__index_level"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_support" )
        local main_key = __main_key_map[index]
		local index_key = "__index_level"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_cross_war_support._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_support" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_cross_war_support.get(level)
    
    return guild_cross_war_support.indexOf(__index_level[level])
        
end

--
function guild_cross_war_support.set(level, key, value)
    local record = guild_cross_war_support.get(level)
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
function guild_cross_war_support.index()
    return __index_level
end

return guild_cross_war_support