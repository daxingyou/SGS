--avatar_gold_level

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  level = 1,    --飞升等级-int 
  cost = 2,    --飞升到此等级消耗变身卡数量-int 
  cost_type = 3,    --消耗类型，1任意卡，2同阵营卡-int 
  gold_level = 4,    --对应金将涅槃等级-int 
  red_level = 5,    --对应红升金突破等级-int 

}

-- key type
local __key_type = {
  level = "int",    --飞升等级-1 
  cost = "int",    --飞升到此等级消耗变身卡数量-2 
  cost_type = "int",    --消耗类型，1任意卡，2同阵营卡-3 
  gold_level = "int",    --对应金将涅槃等级-4 
  red_level = "int",    --对应红升金突破等级-5 

}


-- data
local avatar_gold_level = {
    version =  1,
    _data = {
        [1] = {0,0,0,0,5,},
        [2] = {1,1,1,1,8,},
        [3] = {2,2,1,3,10,},
        [4] = {3,3,2,5,12,},
    }
}

-- index
local __index_level = {
    [0] = 1,
    [1] = 2,
    [2] = 3,
    [3] = 4,

}

-- index mainkey map
local __main_key_map = {
    [1] = 0,
    [2] = 1,
    [3] = 2,
    [4] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in avatar_gold_level")
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
function avatar_gold_level.length()
    return #avatar_gold_level._data
end

-- 
function avatar_gold_level.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function avatar_gold_level.isVersionValid(v)
    if avatar_gold_level.version then
        if v then
            return avatar_gold_level.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function avatar_gold_level.indexOf(index)
    if index == nil or not avatar_gold_level._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/avatar_gold_level.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/avatar_gold_level.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/avatar_gold_level.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "avatar_gold_level" )
                _isDataExist = avatar_gold_level.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "avatar_gold_level" )
                _isBaseExist = avatar_gold_level.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "avatar_gold_level" )
                _isExist = avatar_gold_level.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "avatar_gold_level" )
        local main_key = __main_key_map[index]
		local index_key = "__index_level"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "avatar_gold_level" )
        local main_key = __main_key_map[index]
		local index_key = "__index_level"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = avatar_gold_level._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "avatar_gold_level" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function avatar_gold_level.get(level)
    
    return avatar_gold_level.indexOf(__index_level[level])
        
end

--
function avatar_gold_level.set(level, key, value)
    local record = avatar_gold_level.get(level)
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
function avatar_gold_level.index()
    return __index_level
end

return avatar_gold_level