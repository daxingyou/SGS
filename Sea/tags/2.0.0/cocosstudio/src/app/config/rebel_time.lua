--rebel_time

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --时间段id-int 
  start_time = 2,    --开始时间-int 
  over_time = 3,    --结束时间-int 
  cost = 4,    --消耗-int 

}

-- key type
local __key_type = {
  id = "int",    --时间段id-1 
  start_time = "int",    --开始时间-2 
  over_time = "int",    --结束时间-3 
  cost = "int",    --消耗-4 

}


-- data
local rebel_time = {
    _data = {
        [1] = {1,43200,50400,1,},
        [2] = {2,64800,72000,1,},
        [3] = {3,79200,86400,1,},
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
        assert(__key_map[k], "cannot find " .. k .. " in rebel_time")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function rebel_time.length()
    return #rebel_time._data
end

-- 
function rebel_time.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function rebel_time.indexOf(index)
    if index == nil or not rebel_time._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/rebel_time.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "rebel_time" )
        return setmetatable({_raw = rebel_time._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = rebel_time._data[index]}, mt)
end

--
function rebel_time.get(id)
    
    return rebel_time.indexOf(__index_id[id])
        
end

--
function rebel_time.set(id, key, value)
    local record = rebel_time.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function rebel_time.index()
    return __index_id
end

return rebel_time