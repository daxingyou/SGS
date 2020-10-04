--guild_flag

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --颜色id-int 
  color = 2,    --旗帜颜色-string 

}

-- key type
local __key_type = {
  id = "int",    --颜色id-1 
  color = "string",    --旗帜颜色-2 

}


-- data
local guild_flag = {
    version =  1,
    _data = {
        [1] = {1,"img_guild_huoyue_b02",},
        [2] = {2,"img_guild_huoyue_b03",},
        [3] = {3,"img_guild_huoyue_b04",},
        [4] = {4,"img_guild_huoyue_b05",},
        [5] = {5,"img_guild_huoyue_b06",},
        [6] = {6,"img_guild_huoyue_b02",},
        [7] = {7,"img_guild_huoyue_b03",},
        [8] = {8,"img_guild_huoyue_b04",},
        [9] = {9,"img_guild_huoyue_b05",},
        [10] = {10,"img_guild_huoyue_b06",},
    }
}

-- index
local __index_id = {
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
        assert(key_map[k], "cannot find " .. k .. " in guild_flag")
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
function guild_flag.length()
    return #guild_flag._data
end

-- 
function guild_flag.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_flag.isVersionValid(v)
    if guild_flag.version then
        if v then
            return guild_flag.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_flag.indexOf(index)
    if index == nil or not guild_flag._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_flag.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_flag.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_flag.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_flag" )
                _isDataExist = guild_flag.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_flag" )
                _isBaseExist = guild_flag.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_flag" )
                _isExist = guild_flag.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_flag" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_flag" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_flag._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_flag" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_flag.get(id)
    
    return guild_flag.indexOf(__index_id[id])
        
end

--
function guild_flag.set(id, key, value)
    local record = guild_flag.get(id)
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
function guild_flag.index()
    return __index_id
end

return guild_flag