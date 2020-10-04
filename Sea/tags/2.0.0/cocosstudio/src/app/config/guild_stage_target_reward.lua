--guild_stage_target_reward

local _lang = "cn"
local _isExist = false

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

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in guild_stage_target_reward")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
function guild_stage_target_reward.indexOf(index)
    if index == nil or not guild_stage_target_reward._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/guild_stage_target_reward.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_stage_target_reward" )
        return setmetatable({_raw = guild_stage_target_reward._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = guild_stage_target_reward._data[index]}, mt)
end

--
function guild_stage_target_reward.get(box_id)
    
    return guild_stage_target_reward.indexOf(__index_box_id[box_id])
        
end

--
function guild_stage_target_reward.set(box_id, key, value)
    local record = guild_stage_target_reward.get(box_id)
    if record then
        local keyIndex = __key_map[key]
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