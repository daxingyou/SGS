--guild_base

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  level = 1,    --军团等级-int 
  exp = 2,    --升级经验-int 
  max_member = 3,    --成员上限-int 
  wages_plus = 4,    --军团工资加成值(千分比）-int 

}

-- key type
local __key_type = {
  level = "int",    --军团等级-1 
  exp = "int",    --升级经验-2 
  max_member = "int",    --成员上限-3 
  wages_plus = "int",    --军团工资加成值(千分比）-4 

}


-- data
local guild_base = {
    version =  1,
    _data = {
        [1] = {1,20000,40,1000,},
        [2] = {2,40000,40,1005,},
        [3] = {3,60000,40,1015,},
        [4] = {4,100000,40,1030,},
        [5] = {5,160000,40,1050,},
        [6] = {6,260000,40,1075,},
        [7] = {7,420000,40,1105,},
        [8] = {8,680000,40,1140,},
        [9] = {9,1100000,40,1180,},
        [10] = {10,1780000,40,1225,},
    }
}

-- index
local __index_level = {
    [1] = 1,
    [10] = 10,
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
        assert(key_map[k], "cannot find " .. k .. " in guild_base")
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
function guild_base.length()
    return #guild_base._data
end

-- 
function guild_base.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_base.isVersionValid(v)
    if guild_base.version then
        if v then
            return guild_base.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_base.indexOf(index)
    if index == nil or not guild_base._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_base.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_base.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_base.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_base" )
                _isDataExist = guild_base.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_base" )
                _isBaseExist = guild_base.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_base" )
                _isExist = guild_base.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_base" )
        local main_key = __main_key_map[index]
		local index_key = "__index_level"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_base" )
        local main_key = __main_key_map[index]
		local index_key = "__index_level"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_base._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_base" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_base.get(level)
    
    return guild_base.indexOf(__index_level[level])
        
end

--
function guild_base.set(level, key, value)
    local record = guild_base.get(level)
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
function guild_base.index()
    return __index_level
end

return guild_base