--rebel_time

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

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
    version =  1,
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

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in rebel_time")
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
function rebel_time.isVersionValid(v)
    if rebel_time.version then
        if v then
            return rebel_time.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function rebel_time.indexOf(index)
    if index == nil or not rebel_time._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/rebel_time.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/rebel_time.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/rebel_time.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "rebel_time" )
                _isDataExist = rebel_time.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "rebel_time" )
                _isBaseExist = rebel_time.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "rebel_time" )
                _isExist = rebel_time.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "rebel_time" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "rebel_time" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = rebel_time._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "rebel_time" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function rebel_time.get(id)
    
    return rebel_time.indexOf(__index_id[id])
        
end

--
function rebel_time.set(id, key, value)
    local record = rebel_time.get(id)
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
function rebel_time.index()
    return __index_id
end

return rebel_time