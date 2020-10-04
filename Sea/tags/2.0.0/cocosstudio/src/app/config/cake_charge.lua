--cake_charge

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  type1 = 2,    --奖励type-int 
  value1 = 3,    --奖励value-int 
  size1 = 4,    --奖励size-int 
  type2 = 5,    --奖励type-int 
  value2 = 6,    --奖励value-int 
  size2 = 7,    --奖励size-int 
  award1 = 8,    --奖励1图片名称-string 
  award2 = 9,    --奖励1图片名称-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  type1 = "int",    --奖励type-2 
  value1 = "int",    --奖励value-3 
  size1 = "int",    --奖励size-4 
  type2 = "int",    --奖励type-5 
  value2 = "int",    --奖励value-6 
  size2 = "int",    --奖励size-7 
  award1 = "string",    --奖励1图片名称-8 
  award2 = "string",    --奖励1图片名称-9 

}


-- data
local cake_charge = {
    _data = {
        [1] = {10109,6,571,6,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [2] = {10110,6,571,30,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [3] = {10112,6,571,98,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [4] = {10113,6,571,198,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [5] = {10115,6,571,488,0,0,0,"img_prop_cream","img_prop_yuanbao",},
        [6] = {10116,6,571,648,0,0,0,"img_prop_cream","img_prop_yuanbao",},
    }
}

-- index
local __index_id = {
    [10109] = 1,
    [10110] = 2,
    [10112] = 3,
    [10113] = 4,
    [10115] = 5,
    [10116] = 6,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in cake_charge")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function cake_charge.length()
    return #cake_charge._data
end

-- 
function cake_charge.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cake_charge.indexOf(index)
    if index == nil or not cake_charge._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/cake_charge.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cake_charge" )
        return setmetatable({_raw = cake_charge._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = cake_charge._data[index]}, mt)
end

--
function cake_charge.get(id)
    
    return cake_charge.indexOf(__index_id[id])
        
end

--
function cake_charge.set(id, key, value)
    local record = cake_charge.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function cake_charge.index()
    return __index_id
end

return cake_charge