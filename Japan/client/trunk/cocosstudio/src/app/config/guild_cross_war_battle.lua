--guild_cross_war_battle

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  type = 1,    --鼓舞类型-int 
  atk_dmg = 2,    --攻方掉血-int 
  def_dmg = 3,    --守方掉血-int 

}

-- key type
local __key_type = {
  type = "int",    --鼓舞类型-1 
  atk_dmg = "int",    --攻方掉血-2 
  def_dmg = "int",    --守方掉血-3 

}


-- data
local guild_cross_war_battle = {
    version =  1,
    _data = {
        [1] = {1,3,15,},
        [2] = {2,12,4,},
    }
}

-- index
local __index_type = {
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
        assert(key_map[k], "cannot find " .. k .. " in guild_cross_war_battle")
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
function guild_cross_war_battle.length()
    return #guild_cross_war_battle._data
end

-- 
function guild_cross_war_battle.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_cross_war_battle.isVersionValid(v)
    if guild_cross_war_battle.version then
        if v then
            return guild_cross_war_battle.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_cross_war_battle.indexOf(index)
    if index == nil or not guild_cross_war_battle._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_cross_war_battle.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_cross_war_battle.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_cross_war_battle.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_battle" )
                _isDataExist = guild_cross_war_battle.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_battle" )
                _isBaseExist = guild_cross_war_battle.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_battle" )
                _isExist = guild_cross_war_battle.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_battle" )
        local main_key = __main_key_map[index]
		local index_key = "__index_type"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_battle" )
        local main_key = __main_key_map[index]
		local index_key = "__index_type"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_cross_war_battle._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_battle" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_cross_war_battle.get(type)
    
    return guild_cross_war_battle.indexOf(__index_type[type])
        
end

--
function guild_cross_war_battle.set(type, key, value)
    local record = guild_cross_war_battle.get(type)
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
function guild_cross_war_battle.index()
    return __index_type
end

return guild_cross_war_battle