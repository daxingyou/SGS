--guild_war_bg

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  battlefield_type = 1,    --对应战场类型-int 
  pic_name = 2,    --背景名称-string 
  infeed_num = 3,    --横向图片数量-int 
  endwise_num = 4,    --纵向图片数量-int 

}

-- key type
local __key_type = {
  battlefield_type = "int",    --对应战场类型-1 
  pic_name = "string",    --背景名称-2 
  infeed_num = "int",    --横向图片数量-3 
  endwise_num = "int",    --纵向图片数量-4 

}


-- data
local guild_war_bg = {
    version =  1,
    _data = {
        [1] = {1,"guildwar_bg_1",4,1,},
        [2] = {2,"guildwar_bg_2",4,1,},
        [3] = {3,"guildwar_bg_3",4,2,},
    }
}

-- index
local __index_battlefield_type = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_war_bg")
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
function guild_war_bg.length()
    return #guild_war_bg._data
end

-- 
function guild_war_bg.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_war_bg.isVersionValid(v)
    if guild_war_bg.version then
        if v then
            return guild_war_bg.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_war_bg.indexOf(index)
    if index == nil or not guild_war_bg._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_war_bg.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_war_bg.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_war_bg.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_war_bg" )
                _isDataExist = guild_war_bg.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_war_bg" )
                _isBaseExist = guild_war_bg.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_war_bg" )
                _isExist = guild_war_bg.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_war_bg" )
        local main_key = __main_key_map[index]
		local index_key = "__index_battlefield_type"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_war_bg" )
        local main_key = __main_key_map[index]
		local index_key = "__index_battlefield_type"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_war_bg._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_war_bg" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_war_bg.get(battlefield_type)
    
    return guild_war_bg.indexOf(__index_battlefield_type[battlefield_type])
        
end

--
function guild_war_bg.set(battlefield_type, key, value)
    local record = guild_war_bg.get(battlefield_type)
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
function guild_war_bg.index()
    return __index_battlefield_type
end

return guild_war_bg