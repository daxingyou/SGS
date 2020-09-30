--guild_stage_target_reward

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  box_id = 1,    --宝箱id-int 
  need_point = 2,    --需要积分-int 
  drop = 3,    --掉落组id-int 

}

-- key type
local __key_type = {
  box_id = "int",    --宝箱id-1 
  need_point = "int",    --需要积分-2 
  drop = "int",    --掉落组id-3 

}


-- data
local guild_stage_target_reward = {
    version =  1,
    _data = {
        [1] = {1,50,7101,},
        [2] = {2,100,7102,},
        [3] = {3,150,7103,},
        [4] = {4,200,7104,},
    }
}

-- index
local __index_box_id = {
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
        assert(key_map[k], "cannot find " .. k .. " in guild_stage_target_reward")
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
function guild_stage_target_reward.length()
    return #guild_stage_target_reward._data
end

-- 
function guild_stage_target_reward.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_stage_target_reward.isVersionValid(v)
    if guild_stage_target_reward.version then
        if v then
            return guild_stage_target_reward.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_stage_target_reward.indexOf(index)
    if index == nil or not guild_stage_target_reward._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_stage_target_reward.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_stage_target_reward.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_stage_target_reward.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_stage_target_reward" )
                _isDataExist = guild_stage_target_reward.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_stage_target_reward" )
                _isBaseExist = guild_stage_target_reward.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_stage_target_reward" )
                _isExist = guild_stage_target_reward.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_stage_target_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_box_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_stage_target_reward" )
        local main_key = __main_key_map[index]
		local index_key = "__index_box_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_stage_target_reward._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_stage_target_reward" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_stage_target_reward.get(box_id)
    
    return guild_stage_target_reward.indexOf(__index_box_id[box_id])
        
end

--
function guild_stage_target_reward.set(box_id, key, value)
    local record = guild_stage_target_reward.get(box_id)
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
function guild_stage_target_reward.index()
    return __index_box_id
end

return guild_stage_target_reward