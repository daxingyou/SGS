--parameter_redpacket_rain

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

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
    version =  1,
    _data = {
        [1] = {1,"entrance_show_time","1200",},
        [2] = {2,"open_countdown","3",},
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

-- index mainkey map
local __main_key_map = {
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
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in parameter_redpacket_rain")
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
function parameter_redpacket_rain.isVersionValid(v)
    if parameter_redpacket_rain.version then
        if v then
            return parameter_redpacket_rain.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function parameter_redpacket_rain.indexOf(index)
    if index == nil or not parameter_redpacket_rain._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/parameter_redpacket_rain.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/parameter_redpacket_rain.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/parameter_redpacket_rain.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "parameter_redpacket_rain" )
                _isDataExist = parameter_redpacket_rain.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "parameter_redpacket_rain" )
                _isBaseExist = parameter_redpacket_rain.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "parameter_redpacket_rain" )
                _isExist = parameter_redpacket_rain.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "parameter_redpacket_rain" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "parameter_redpacket_rain" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = parameter_redpacket_rain._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "parameter_redpacket_rain" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function parameter_redpacket_rain.get(id)
    
    return parameter_redpacket_rain.indexOf(__index_id[id])
        
end

--
function parameter_redpacket_rain.set(id, key, value)
    local record = parameter_redpacket_rain.get(id)
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
function parameter_redpacket_rain.index()
    return __index_id
end

return parameter_redpacket_rain