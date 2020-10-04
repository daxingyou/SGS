--output_crit

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --索引id-int 
  time_1 = 2,    --不暴击-int 
  time_2 = 3,    --1.5倍-int 
  time_3 = 4,    --2倍-int 
  time_4 = 5,    --3倍-int 
  time_5 = 6,    --5倍-int 
  time_6 = 7,    --10倍-int 

}

-- key type
local __key_type = {
  id = "int",    --索引id-1 
  time_1 = "int",    --不暴击-2 
  time_2 = "int",    --1.5倍-3 
  time_3 = "int",    --2倍-4 
  time_4 = "int",    --3倍-5 
  time_5 = "int",    --5倍-6 
  time_6 = "int",    --10倍-7 

}


-- data
local output_crit = {
    _data = {
        [1] = {101,0,500,1000,2000,5000,10000,},
        [2] = {102,0,500,1000,2000,5000,10000,},
        [3] = {103,0,500,1000,2000,5000,10000,},
        [4] = {104,0,500,1000,2000,5000,10000,},
        [5] = {105,0,500,1000,2000,5000,10000,},
        [6] = {106,0,500,1000,2000,5000,10000,},
        [7] = {107,0,500,1000,2000,5000,10000,},
    }
}

-- index
local __index_id = {
    [101] = 1,
    [102] = 2,
    [103] = 3,
    [104] = 4,
    [105] = 5,
    [106] = 6,
    [107] = 7,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in output_crit")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function output_crit.length()
    return #output_crit._data
end

-- 
function output_crit.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function output_crit.indexOf(index)
    if index == nil or not output_crit._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/output_crit.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "output_crit" )
        return setmetatable({_raw = output_crit._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = output_crit._data[index]}, mt)
end

--
function output_crit.get(id)
    
    return output_crit.indexOf(__index_id[id])
        
end

--
function output_crit.set(id, key, value)
    local record = output_crit.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function output_crit.index()
    return __index_id
end

return output_crit