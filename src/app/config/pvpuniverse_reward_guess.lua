--pvpuniverse_reward_guess

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  award_type_1 = 2,    --奖励类型1-int 
  award_value_1 = 3,    --奖励类型值1-int 
  award_size_1 = 4,    --奖励数量1-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  award_type_1 = "int",    --奖励类型1-2 
  award_value_1 = "int",    --奖励类型值1-3 
  award_size_1 = "int",    --奖励数量1-4 

}


-- data
local pvpuniverse_reward_guess = {
    version =  1,
    _data = {
        [1] = {1,5,35,200,},
        [2] = {2,5,35,200,},
        [3] = {3,5,35,200,},
        [4] = {4,5,35,200,},
        [5] = {5,5,35,400,},
        [6] = {6,5,35,600,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in pvpuniverse_reward_guess")
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
function pvpuniverse_reward_guess.length()
    return #pvpuniverse_reward_guess._data
end

-- 
function pvpuniverse_reward_guess.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pvpuniverse_reward_guess.isVersionValid(v)
    if pvpuniverse_reward_guess.version then
        if v then
            return pvpuniverse_reward_guess.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function pvpuniverse_reward_guess.indexOf(index)
    if index == nil or not pvpuniverse_reward_guess._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/pvpuniverse_reward_guess.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/pvpuniverse_reward_guess.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/pvpuniverse_reward_guess.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "pvpuniverse_reward_guess" )
                _isDataExist = pvpuniverse_reward_guess.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "pvpuniverse_reward_guess" )
                _isBaseExist = pvpuniverse_reward_guess.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "pvpuniverse_reward_guess" )
                _isExist = pvpuniverse_reward_guess.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "pvpuniverse_reward_guess" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pvpuniverse_reward_guess" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = pvpuniverse_reward_guess._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "pvpuniverse_reward_guess" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function pvpuniverse_reward_guess.get(id)
    
    return pvpuniverse_reward_guess.indexOf(__index_id[id])
        
end

--
function pvpuniverse_reward_guess.set(id, key, value)
    local record = pvpuniverse_reward_guess.get(id)
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
function pvpuniverse_reward_guess.index()
    return __index_id
end

return pvpuniverse_reward_guess