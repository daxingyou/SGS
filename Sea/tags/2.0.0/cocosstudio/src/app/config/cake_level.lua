--cake_level

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  lv = 1,    --蛋糕等级-int 
  exp = 2,    --经验值-int 
  award_type = 3,    --奖励type-int 
  award_value = 4,    --奖励value-int 
  award_size = 5,    --奖励size-int 
  cake_pic = 6,    --蛋糕资源名称-string 

}

-- key type
local __key_type = {
  lv = "int",    --蛋糕等级-1 
  exp = "int",    --经验值-2 
  award_type = "int",    --奖励type-3 
  award_value = "int",    --奖励value-4 
  award_size = "int",    --奖励size-5 
  cake_pic = "string",    --蛋糕资源名称-6 

}


-- data
local cake_level = {
    _data = {
        [1] = {1,24000,0,0,0,"img_cake06",},
        [2] = {2,48000,5,31,500,"img_cake07",},
        [3] = {3,72000,5,31,500,"img_cake08",},
        [4] = {4,96000,5,31,500,"img_cake09",},
        [5] = {5,120000,5,31,500,"img_cake10",},
        [6] = {6,144000,5,31,500,"img_cake11",},
        [7] = {7,168000,5,31,500,"img_cake12",},
        [8] = {8,192000,5,31,500,"img_cake13",},
        [9] = {9,216000,5,31,500,"img_cake14",},
        [10] = {10,0,5,31,500,"img_cake15",},
    }
}

-- index
local __index_lv = {
    [1] = 1,
    [10] = 10,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in cake_level")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function cake_level.length()
    return #cake_level._data
end

-- 
function cake_level.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cake_level.indexOf(index)
    if index == nil or not cake_level._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/cake_level.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cake_level" )
        return setmetatable({_raw = cake_level._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = cake_level._data[index]}, mt)
end

--
function cake_level.get(lv)
    
    return cake_level.indexOf(__index_lv[lv])
        
end

--
function cake_level.set(lv, key, value)
    local record = cake_level.get(lv)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function cake_level.index()
    return __index_lv
end

return cake_level