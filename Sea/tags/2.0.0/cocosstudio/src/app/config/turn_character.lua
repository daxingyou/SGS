--turn_character

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  before_character = 2,    --替换前字符-string 
  after_character = 3,    --替换后字符-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  before_character = "string",    --替换前字符-2 
  after_character = "string",    --替换后字符-3 

}


-- data
local turn_character = {
    _data = {
        [1] = {1," "," ",},
        [2] = {2,""," ",},
        [3] = {3,""," ",},
        [4] = {4,""," ",},
        [5] = {5,""," ",},
        [6] = {6,""," ",},
        [7] = {7,"　"," ",},
        [8] = {8," "," ",},
        [9] = {9,"＃","#",},
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
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in turn_character")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function turn_character.length()
    return #turn_character._data
end

-- 
function turn_character.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function turn_character.indexOf(index)
    if index == nil or not turn_character._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/turn_character.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "turn_character" )
        return setmetatable({_raw = turn_character._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = turn_character._data[index]}, mt)
end

--
function turn_character.get(id)
    
    return turn_character.indexOf(__index_id[id])
        
end

--
function turn_character.set(id, key, value)
    local record = turn_character.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function turn_character.index()
    return __index_id
end

return turn_character