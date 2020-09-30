--guild_support

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  color = 1,    --捐献武将品质-int 
  guild_lv = 2,    --需要军团等级-int 
  launch_max = 3,    --最多可发起次数-int 
  times = 4,    --可获捐次数-int 
  contribution = 5,    --援助获得贡献-int 
  experience = 6,    --援助获得声望-int 

}

-- key type
local __key_type = {
  color = "int",    --捐献武将品质-1 
  guild_lv = "int",    --需要军团等级-2 
  launch_max = "int",    --最多可发起次数-3 
  times = "int",    --可获捐次数-4 
  contribution = "int",    --援助获得贡献-5 
  experience = "int",    --援助获得声望-6 

}


-- data
local guild_support = {
    version =  1,
    _data = {
        [1] = {4,1,3,5,200,0,},
        [2] = {5,1,3,5,200,0,},
        [3] = {6,6,2,2,500,0,},
    }
}

-- index
local __index_color = {
    [4] = 1,
    [5] = 2,
    [6] = 3,

}

-- index mainkey map
local __main_key_map = {
    [1] = 4,
    [2] = 5,
    [3] = 6,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_support")
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
function guild_support.length()
    return #guild_support._data
end

-- 
function guild_support.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_support.isVersionValid(v)
    if guild_support.version then
        if v then
            return guild_support.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_support.indexOf(index)
    if index == nil or not guild_support._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_support.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_support.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_support.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_support" )
                _isDataExist = guild_support.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_support" )
                _isBaseExist = guild_support.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_support" )
                _isExist = guild_support.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_support" )
        local main_key = __main_key_map[index]
		local index_key = "__index_color"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_support" )
        local main_key = __main_key_map[index]
		local index_key = "__index_color"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_support._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_support" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_support.get(color)
    
    return guild_support.indexOf(__index_color[color])
        
end

--
function guild_support.set(color, key, value)
    local record = guild_support.get(color)
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
function guild_support.index()
    return __index_color
end

return guild_support