--parameter_redpacket_rain

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  key = 2,    --参数名称-string 
  content = 3,    --参数内容-string 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  key = "string",    --参数名称-2 
  content = "string",    --参数内容-3 

}


-- data
local parameter_redpacket_rain = {
    _data = {
        [1] = {1,"entrance_show_time","600",},
        [2] = {2,"open_countdown","5",},
        [3] = {3,"open_continue","30",},
        [4] = {4,"close_countdown","0",},
        [5] = {5,"redpacket_disappear","0.01",},
        [6] = {6,"type_propotion_big","1000|0|0",},
        [7] = {7,"type_propotion_small","1000|0|0",},
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
        assert(__key_map[k], "cannot find " .. k .. " in parameter_redpacket_rain")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function parameter_redpacket_rain.length()
    return #parameter_redpacket_rain._data
end

-- 
function parameter_redpacket_rain.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function parameter_redpacket_rain.indexOf(index)
    if index == nil or not parameter_redpacket_rain._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/parameter_redpacket_rain.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "parameter_redpacket_rain" )
        return setmetatable({_raw = parameter_redpacket_rain._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = parameter_redpacket_rain._data[index]}, mt)
end

--
function parameter_redpacket_rain.get(id)
    
    return parameter_redpacket_rain.indexOf(__index_id[id])
        
end

--
function parameter_redpacket_rain.set(id, key, value)
    local record = parameter_redpacket_rain.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function parameter_redpacket_rain.index()
    return __index_id
end

return parameter_redpacket_rain