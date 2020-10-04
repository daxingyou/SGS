--qin_reward

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  reward = 2,    --奖励组-int 
  type = 3,    --类型-int 
  value = 4,    --类型值id-int 
  size = 5,    --数量-int 
  produce_number1 = 6,    --产出组1数量-int 
  produce_probability1 = 7,    --产出组1权重-int 
  produce_number2 = 8,    --产出组2数量-int 
  produce_probability2 = 9,    --产出组2权重-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  reward = "int",    --奖励组-2 
  type = "int",    --类型-3 
  value = "int",    --类型值id-4 
  size = "int",    --数量-5 
  produce_number1 = "int",    --产出组1数量-6 
  produce_probability1 = "int",    --产出组1权重-7 
  produce_number2 = "int",    --产出组2数量-8 
  produce_probability2 = "int",    --产出组2权重-9 

}


-- data
local qin_reward = {
    _data = {
        [1] = {1,11,6,92,1,1,125,0,875,},
        [2] = {2,41,6,92,1,1,125,0,875,},
        [3] = {3,71,6,92,1,1,125,0,875,},
        [4] = {4,110,6,154,1,1,100,0,0,},
        [5] = {5,110,6,155,1,1,100,0,0,},
        [6] = {6,110,6,156,1,1,100,0,0,},
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

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in qin_reward")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function qin_reward.length()
    return #qin_reward._data
end

-- 
function qin_reward.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function qin_reward.indexOf(index)
    if index == nil or not qin_reward._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/qin_reward.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "qin_reward" )
        return setmetatable({_raw = qin_reward._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = qin_reward._data[index]}, mt)
end

--
function qin_reward.get(id)
    
    return qin_reward.indexOf(__index_id[id])
        
end

--
function qin_reward.set(id, key, value)
    local record = qin_reward.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function qin_reward.index()
    return __index_id
end

return qin_reward