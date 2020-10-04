--horse_race_reward_max

local _lang = "cn"
local _isExist = false

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

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in horse_race_reward_max")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
function horse_race_reward_max.indexOf(index)
    if index == nil or not horse_race_reward_max._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/horse_race_reward_max.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "horse_race_reward_max" )
        return setmetatable({_raw = horse_race_reward_max._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = horse_race_reward_max._data[index]}, mt)
end

--
function horse_race_reward_max.get(id)
    
    return horse_race_reward_max.indexOf(__index_id[id])
        
end

--
function horse_race_reward_max.set(id, key, value)
    local record = horse_race_reward_max.get(id)
    if record then
        local keyIndex = __key_map[key]
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