--new_answer_reward

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --回答-int 
  right_type1 = 2,    --答对奖励类型1-int 
  right_resource1 = 3,    --答对奖励资源1-int 
  right_size1 = 4,    --答对奖励数量1-int 
  right_type2 = 5,    --答对奖励类型2-int 
  right_resource2 = 6,    --答对奖励资源2-int 
  right_size2 = 7,    --答对奖励数量2-int 

}

-- key type
local __key_type = {
  id = "int",    --回答-1 
  right_type1 = "int",    --答对奖励类型1-2 
  right_resource1 = "int",    --答对奖励资源1-3 
  right_size1 = "int",    --答对奖励数量1-4 
  right_type2 = "int",    --答对奖励类型2-5 
  right_resource2 = "int",    --答对奖励资源2-6 
  right_size2 = "int",    --答对奖励数量2-7 

}


-- data
local new_answer_reward = {
    _data = {
        [1] = {1,5,13,200,5,18,20,},
        [2] = {2,5,13,100,5,18,10,},
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
        assert(__key_map[k], "cannot find " .. k .. " in new_answer_reward")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function new_answer_reward.length()
    return #new_answer_reward._data
end

-- 
function new_answer_reward.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function new_answer_reward.indexOf(index)
    if index == nil or not new_answer_reward._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/new_answer_reward.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "new_answer_reward" )
        return setmetatable({_raw = new_answer_reward._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = new_answer_reward._data[index]}, mt)
end

--
function new_answer_reward.get(id)
    
    return new_answer_reward.indexOf(__index_id[id])
        
end

--
function new_answer_reward.set(id, key, value)
    local record = new_answer_reward.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function new_answer_reward.index()
    return __index_id
end

return new_answer_reward