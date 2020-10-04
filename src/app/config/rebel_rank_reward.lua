--rebel_rank_reward

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --奖励id-int 
  type = 2,    --奖励类型-int 
  rank_min = 3,    --排名下限-int 
  rank_max = 4,    --排名上限-int 
  award_type = 5,    --奖励类型-int 
  award_value = 6,    --参数-int 
  award_size = 7,    --数量-int 

}

-- key type
local __key_type = {
  id = "int",    --奖励id-1 
  type = "int",    --奖励类型-2 
  rank_min = "int",    --排名下限-3 
  rank_max = "int",    --排名上限-4 
  award_type = "int",    --奖励类型-5 
  award_value = "int",    --参数-6 
  award_size = "int",    --数量-7 

}


-- data
local rebel_rank_reward = {
    version =  1,
    _data = {
        [1] = {101,1,1,1,5,8,2500,},
        [2] = {102,1,2,2,5,8,2250,},
        [3] = {103,1,3,3,5,8,2000,},
        [4] = {104,1,4,10,5,8,1750,},
        [5] = {105,1,11,50,5,8,1500,},
        [6] = {106,1,51,2000,5,8,1250,},
        [7] = {201,2,1,1,5,8,2500,},
        [8] = {202,2,2,2,5,8,2250,},
        [9] = {203,2,3,3,5,8,2000,},
        [10] = {204,2,4,10,5,8,1750,},
        [11] = {205,2,11,50,5,8,1500,},
        [12] = {206,2,51,2000,5,8,1250,},
    }
}

-- index
local __index_id = {
    [101] = 1,
    [102] = 2,
    [103] = 3,
    [104] = 4,
    [105] = 5,
    [106] = 6,
    [201] = 7,
    [202] = 8,
    [203] = 9,
    [204] = 10,
    [205] = 11,
    [206] = 12,

}

-- index mainkey map
local __main_key_map = {
    [1] = 101,
    [2] = 102,
    [3] = 103,
    [4] = 104,
    [5] = 105,
    [6] = 106,
    [7] = 201,
    [8] = 202,
    [9] = 203,
    [10] = 204,
    [11] = 205,
    [12] = 206,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in rebel_rank_reward")
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
function rebel_rank_reward.length()
    return #rebel_rank_reward._data
end

-- 
function rebel_rank_reward.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function rebel_rank_reward.isVersionValid(v)
    if rebel_rank_reward.version then
        if v then
            return rebel_rank_reward.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function rebel_rank_reward.indexOf(index)
    if index == nil or not rebel_rank_reward._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/rebel_rank_reward.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/rebel_rank_reward.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/rebel_rank_reward.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "rebel_rank_reward" )
                _isDataExist = rebel_rank_reward.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "rebel_rank_reward" )
                _isBaseExist = rebel_rank_reward.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "rebel_rank_reward" )
                _isExist = rebel_rank_reward.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "rebel_rank_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "rebel_rank_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = rebel_rank_reward._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "rebel_rank_reward" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function rebel_rank_reward.get(id)
    
    return rebel_rank_reward.indexOf(__index_id[id])
        
end

--
function rebel_rank_reward.set(id, key, value)
    local record = rebel_rank_reward.get(id)
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
function rebel_rank_reward.index()
    return __index_id
end

return rebel_rank_reward