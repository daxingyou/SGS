--device

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  key = 1,    --型号描述-string 
  offset = 2,    --偏移量-int 
  mask = 3,    --遮罩-string 

}

-- key type
local __key_type = {
  key = "string",    --型号描述-1 
  offset = "int",    --偏移量-2 
  mask = "string",    --遮罩-3 

}


-- data
local device = {
    _data = {
        [1] = {"iPhone10,3",50,"iphonex.png",},
        [2] = {"iPhone10,6",50,"iphonex.png",},
    }
}

-- index
local __index_key = {
    ["iPhone10,3"] = 1,
    ["iPhone10,6"] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in device")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function device.length()
    return #device._data
end

-- 
function device.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function device.indexOf(index)
    if index == nil or not device._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/device.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "device" )
        return setmetatable({_raw = device._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = device._data[index]}, mt)
end

--
function device.get(key)
    
    return device.indexOf(__index_key[key])
        
end

--
function device.set(key, key, value)
    local record = device.get(key)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function device.index()
    return __index_key
end

return device