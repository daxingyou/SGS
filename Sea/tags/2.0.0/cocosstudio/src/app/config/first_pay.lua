--first_pay

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  charge = 2,    --充值额度-int 
  type_1 = 3,    --奖励类型1-int 
  value_1 = 4,    --类型值1-int 
  size_1 = 5,    --数量1-int 
  type_2 = 6,    --奖励类型2-int 
  value_2 = 7,    --类型值2-int 
  size_2 = 8,    --数量2-int 
  type_3 = 9,    --奖励类型3-int 
  value_3 = 10,    --类型值3-int 
  size_3 = 11,    --数量3-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  charge = "int",    --充值额度-2 
  type_1 = "int",    --奖励类型1-3 
  value_1 = "int",    --类型值1-4 
  size_1 = "int",    --数量1-5 
  type_2 = "int",    --奖励类型2-6 
  value_2 = "int",    --类型值2-7 
  size_2 = "int",    --数量2-8 
  type_3 = "int",    --奖励类型3-9 
  value_3 = "int",    --类型值3-10 
  size_3 = "int",    --数量3-11 

}


-- data
local first_pay = {
    _data = {
        [1] = {1,1,2,305,1,6,3,288,5,1,288,},
        [2] = {2,98,2,406,1,6,21,10,6,20,10,},
        [3] = {3,298,6,105,1,6,109,1,5,1,588,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in first_pay")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function first_pay.length()
    return #first_pay._data
end

-- 
function first_pay.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function first_pay.indexOf(index)
    if index == nil or not first_pay._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/first_pay.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "first_pay" )
        return setmetatable({_raw = first_pay._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = first_pay._data[index]}, mt)
end

--
function first_pay.get(id)
    
    return first_pay.indexOf(__index_id[id])
        
end

--
function first_pay.set(id, key, value)
    local record = first_pay.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function first_pay.index()
    return __index_id
end

return first_pay