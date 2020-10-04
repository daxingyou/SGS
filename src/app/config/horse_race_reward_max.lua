--horse_race_reward_max

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  type = 2,    --奖励type-int 
  value = 3,    --奖励value-int 
  size = 4,    --奖励size上限-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  type = "int",    --奖励type-2 
  value = "int",    --奖励value-3 
  size = "int",    --奖励size上限-4 

}


-- data
local horse_race_reward_max = {
    version =  1,
    _data = {
        [1] = {1,5,28,150,},
        [2] = {2,6,97,5,},
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
        assert(key_map[k], "cannot find " .. k .. " in horse_race_reward_max")
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
function horse_race_reward_max.length()
    return #horse_race_reward_max._data
end

-- 
function horse_race_reward_max.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function horse_race_reward_max.isVersionValid(v)
    if horse_race_reward_max.version then
        if v then
            return horse_race_reward_max.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function horse_race_reward_max.indexOf(index)
    if index == nil or not horse_race_reward_max._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/horse_race_reward_max.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/horse_race_reward_max.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/horse_race_reward_max.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "horse_race_reward_max" )
                _isDataExist = horse_race_reward_max.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "horse_race_reward_max" )
                _isBaseExist = horse_race_reward_max.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "horse_race_reward_max" )
                _isExist = horse_race_reward_max.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "horse_race_reward_max" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "horse_race_reward_max" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = horse_race_reward_max._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "horse_race_reward_max" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function horse_race_reward_max.get(id)
    
    return horse_race_reward_max.indexOf(__index_id[id])
        
end

--
function horse_race_reward_max.set(id, key, value)
    local record = horse_race_reward_max.get(id)
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
function horse_race_reward_max.index()
    return __index_id
end

return horse_race_reward_max