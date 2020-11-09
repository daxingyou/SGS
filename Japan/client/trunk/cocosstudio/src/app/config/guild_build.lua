--guild_build

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  key = 2,    --参数名称-string 
  time = 3,    --每日建设次数-int 
  legion_capital = 4,    --获得军团资金-int 
  contribution = 5,    --获得个人贡献-int 
  need_people = 6,    --需要人数-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  key = "string",    --参数名称-2 
  time = "int",    --每日建设次数-3 
  legion_capital = "int",    --获得军团资金-4 
  contribution = "int",    --获得个人贡献-5 
  need_people = "int",    --需要人数-6 

}


-- data
local guild_build = {
    version =  1,
    _data = {
        [1] = {1,"single_build",1,100,200,1,},
        [2] = {2,"cooperate_build",1,500,1000,5,},
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
        assert(key_map[k], "cannot find " .. k .. " in guild_build")
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
function guild_build.length()
    return #guild_build._data
end

-- 
function guild_build.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_build.isVersionValid(v)
    if guild_build.version then
        if v then
            return guild_build.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_build.indexOf(index)
    if index == nil or not guild_build._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_build.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_build.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_build.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_build" )
                _isDataExist = guild_build.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_build" )
                _isBaseExist = guild_build.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_build" )
                _isExist = guild_build.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_build" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_build" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_build._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_build" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_build.get(id)
    
    return guild_build.indexOf(__index_id[id])
        
end

--
function guild_build.set(id, key, value)
    local record = guild_build.get(id)
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
function guild_build.index()
    return __index_id
end

return guild_build