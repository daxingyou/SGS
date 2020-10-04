--pvpsingle_reward

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --奖励id-int 
  type_1 = 2,    --类型1-int 
  value_1 = 3,    --类型值1-int 
  size_1 = 4,    --数量1-int 
  type_2 = 5,    --类型2-int 
  value_2 = 6,    --类型值2-int 
  size_2 = 7,    --数量2-int 
  type_3 = 8,    --类型3-int 
  value_3 = 9,    --类型值3-int 
  size_3 = 10,    --数量3-int 
  type_4 = 11,    --类型4-int 
  value_4 = 12,    --类型值4-int 
  size_4 = 13,    --数量4-int 
  type_5 = 14,    --类型5-int 
  value_5 = 15,    --类型值5-int 
  size_5 = 16,    --数量5-int 

}

-- key type
local __key_type = {
  id = "int",    --奖励id-1 
  type_1 = "int",    --类型1-2 
  value_1 = "int",    --类型值1-3 
  size_1 = "int",    --数量1-4 
  type_2 = "int",    --类型2-5 
  value_2 = "int",    --类型值2-6 
  size_2 = "int",    --数量2-7 
  type_3 = "int",    --类型3-8 
  value_3 = "int",    --类型值3-9 
  size_3 = "int",    --数量3-10 
  type_4 = "int",    --类型4-11 
  value_4 = "int",    --类型值4-12 
  size_4 = "int",    --数量4-13 
  type_5 = "int",    --类型5-14 
  value_5 = "int",    --类型值5-15 
  size_5 = "int",    --数量5-16 

}


-- data
local pvpsingle_reward = {
    _data = {
        [1] = {1,5,30,4000,0,0,0,0,0,0,0,0,0,0,0,0,},
        [2] = {2,5,30,4800,0,0,0,0,0,0,0,0,0,0,0,0,},
        [3] = {3,5,30,5600,0,0,0,0,0,0,0,0,0,0,0,0,},
        [4] = {4,5,30,6400,0,0,0,0,0,0,0,0,0,0,0,0,},
        [5] = {5,5,30,8000,0,0,0,0,0,0,0,0,0,0,0,0,},
        [6] = {6,5,30,9600,0,0,0,0,0,0,0,0,0,0,0,0,},
        [7] = {7,5,30,3200,0,0,0,0,0,0,0,0,0,0,0,0,},
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
    [7] = 7,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in pvpsingle_reward")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function pvpsingle_reward.length()
    return #pvpsingle_reward._data
end

-- 
function pvpsingle_reward.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pvpsingle_reward.indexOf(index)
    if index == nil or not pvpsingle_reward._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/pvpsingle_reward.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pvpsingle_reward" )
        return setmetatable({_raw = pvpsingle_reward._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = pvpsingle_reward._data[index]}, mt)
end

--
function pvpsingle_reward.get(id)
    
    return pvpsingle_reward.indexOf(__index_id[id])
        
end

--
function pvpsingle_reward.set(id, key, value)
    local record = pvpsingle_reward.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function pvpsingle_reward.index()
    return __index_id
end

return pvpsingle_reward