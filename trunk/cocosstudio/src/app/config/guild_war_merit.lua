--guild_war_merit

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  merit_min = 2,    --积分下限-int 
  merit_max = 3,    --积分上限-int 
  type = 4,    --类型-int 
  value = 5,    --值-int 
  size = 6,    --数量-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  merit_min = "int",    --积分下限-2 
  merit_max = "int",    --积分上限-3 
  type = "int",    --类型-4 
  value = "int",    --值-5 
  size = "int",    --数量-6 

}


-- data
local guild_war_merit = {
    version =  1,
    _data = {
        [1] = {1,0,99,6,115,1,},
        [2] = {2,100,199,6,115,2,},
        [3] = {3,200,399,6,115,3,},
        [4] = {4,400,599,6,115,4,},
        [5] = {5,600,9999,6,115,5,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_war_merit")
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
function guild_war_merit.length()
    return #guild_war_merit._data
end

-- 
function guild_war_merit.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_war_merit.isVersionValid(v)
    if guild_war_merit.version then
        if v then
            return guild_war_merit.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_war_merit.indexOf(index)
    if index == nil or not guild_war_merit._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_war_merit.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_war_merit.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_war_merit.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_war_merit" )
                _isDataExist = guild_war_merit.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_war_merit" )
                _isBaseExist = guild_war_merit.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_war_merit" )
                _isExist = guild_war_merit.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_war_merit" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_war_merit" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_war_merit._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_war_merit" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_war_merit.get(id)
    
    return guild_war_merit.indexOf(__index_id[id])
        
end

--
function guild_war_merit.set(id, key, value)
    local record = guild_war_merit.get(id)
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
function guild_war_merit.index()
    return __index_id
end

return guild_war_merit