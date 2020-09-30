--return_time

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  day_min = 2,    --天数下限-int 
  day_max = 3,    --天数上限-int 
  day_last = 4,    --持续时间-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  day_min = "int",    --天数下限-2 
  day_max = "int",    --天数上限-3 
  day_last = "int",    --持续时间-4 

}


-- data
local return_time = {
    version =  1,
    _data = {
        [1] = {1,3,13,7,},
        [2] = {2,14,28,7,},
        [3] = {3,29,42,7,},
        [4] = {4,43,9999,7,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in return_time")
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
function return_time.length()
    return #return_time._data
end

-- 
function return_time.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function return_time.isVersionValid(v)
    if return_time.version then
        if v then
            return return_time.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function return_time.indexOf(index)
    if index == nil or not return_time._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/return_time.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/return_time.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/return_time.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "return_time" )
                _isDataExist = return_time.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "return_time" )
                _isBaseExist = return_time.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "return_time" )
                _isExist = return_time.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "return_time" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "return_time" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = return_time._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "return_time" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function return_time.get(id)
    
    return return_time.indexOf(__index_id[id])
        
end

--
function return_time.set(id, key, value)
    local record = return_time.get(id)
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
function return_time.index()
    return __index_id
end

return return_time