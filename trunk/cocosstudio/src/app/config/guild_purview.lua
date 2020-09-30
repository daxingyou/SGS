--guild_purview

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --职位-int 
  name = 2,    --职称-string 
  purview = 3,    --权限-string 

}

-- key type
local __key_type = {
  id = "int",    --职位-1 
  name = "string",    --职称-2 
  purview = "string",    --权限-3 

}


-- data
local guild_purview = {
    version =  1,
    _data = {
        [1] = {1,"团长","1|3|4|5|6|7|8|10|11|12|13|14|15|16|17",},
        [2] = {2,"副团长","2|5|6|7|8|9|11|12|15|17",},
        [3] = {3,"长老","2|6|7|9|17",},
        [4] = {4,"成员","2|9",},
    }
}

-- index
local __index_id = {
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
        assert(key_map[k], "cannot find " .. k .. " in guild_purview")
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
function guild_purview.length()
    return #guild_purview._data
end

-- 
function guild_purview.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_purview.isVersionValid(v)
    if guild_purview.version then
        if v then
            return guild_purview.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_purview.indexOf(index)
    if index == nil or not guild_purview._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_purview.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_purview.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_purview.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_purview" )
                _isDataExist = guild_purview.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_purview" )
                _isBaseExist = guild_purview.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_purview" )
                _isExist = guild_purview.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_purview" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_purview" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_purview._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_purview" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_purview.get(id)
    
    return guild_purview.indexOf(__index_id[id])
        
end

--
function guild_purview.set(id, key, value)
    local record = guild_purview.get(id)
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
function guild_purview.index()
    return __index_id
end

return guild_purview