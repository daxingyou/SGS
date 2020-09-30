--device

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

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
    version =  1,
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

-- index mainkey map
local __main_key_map = {
    [1] = "iPhone10,3",
    [2] = "iPhone10,6",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in device")
        if _lang ~= "cn" and _isDataExist  and t._data_key_map[k] then
            return t._data[t._data_key_map[k]]
        end
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[key_map[k]]
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
function device.isVersionValid(v)
    if device.version then
        if v then
            return device.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function device.indexOf(index)
    if index == nil or not device._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/device.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/device.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/device.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "device" )
                _isDataExist = device.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "device" )
                _isBaseExist = device.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "device" )
                _isExist = device.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "device" )
        local main_key = __main_key_map[index]
		local index_key = "__index_key"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "device" )
        local main_key = __main_key_map[index]
		local index_key = "__index_key"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = device._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "device" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function device.get(key)
    
    return device.indexOf(__index_key[key])
        
end

--
function device.set(key, key, value)
    local record = device.get(key)
    if record then
        if _lang ~= "cn" and _isDataExist then
            local keyIndex =  record._data_key_map[key]
            if keyIndex then
                record._data[keyIndex] = value
                return
            end
        end
        if _lang ~= "cn" and _isExist then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
                return
            end
        end
        local keyIndex = record._raw_key_map[key]
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