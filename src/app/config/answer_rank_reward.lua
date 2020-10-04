--answer_rank_reward

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  answer_rank_min = 2,    --军团排名min-int 
  answer_rank_max = 3,    --军团排名max-int 
  reward_type1 = 4,    --奖励类型1-int 
  reward_value1 = 5,    --奖励类型值1-int 
  reward_size1 = 6,    --奖励数量1-int 
  reward_type2 = 7,    --奖励类型2-int 
  reward_value2 = 8,    --奖励类型值2-int 
  reward_size2 = 9,    --奖励数量2-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  answer_rank_min = "int",    --军团排名min-2 
  answer_rank_max = "int",    --军团排名max-3 
  reward_type1 = "int",    --奖励类型1-4 
  reward_value1 = "int",    --奖励类型值1-5 
  reward_size1 = "int",    --奖励数量1-6 
  reward_type2 = "int",    --奖励类型2-7 
  reward_value2 = "int",    --奖励类型值2-8 
  reward_size2 = "int",    --奖励数量2-9 

}


-- data
local answer_rank_reward = {
    version =  1,
    _data = {
        [1] = {1,1,1,5,13,1000,0,0,0,},
        [2] = {2,2,5,5,13,800,0,0,0,},
        [3] = {3,6,10,5,13,600,0,0,0,},
        [4] = {4,11,50,5,13,400,0,0,0,},
        [5] = {5,51,9999,5,13,200,0,0,0,},
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
        assert(key_map[k], "cannot find " .. k .. " in answer_rank_reward")
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
function answer_rank_reward.length()
    return #answer_rank_reward._data
end

-- 
function answer_rank_reward.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function answer_rank_reward.isVersionValid(v)
    if answer_rank_reward.version then
        if v then
            return answer_rank_reward.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function answer_rank_reward.indexOf(index)
    if index == nil or not answer_rank_reward._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/answer_rank_reward.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/answer_rank_reward.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/answer_rank_reward.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "answer_rank_reward" )
                _isDataExist = answer_rank_reward.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "answer_rank_reward" )
                _isBaseExist = answer_rank_reward.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "answer_rank_reward" )
                _isExist = answer_rank_reward.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "answer_rank_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "answer_rank_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = answer_rank_reward._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "answer_rank_reward" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function answer_rank_reward.get(id)
    
    return answer_rank_reward.indexOf(__index_id[id])
        
end

--
function answer_rank_reward.set(id, key, value)
    local record = answer_rank_reward.get(id)
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
function answer_rank_reward.index()
    return __index_id
end

return answer_rank_reward