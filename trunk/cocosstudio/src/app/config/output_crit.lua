--output_crit

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

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
    version =  1,
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

-- index mainkey map
local __main_key_map = {
    [1] = 101,
    [2] = 102,
    [3] = 103,
    [4] = 104,
    [5] = 105,
    [6] = 106,
    [7] = 107,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in output_crit")
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
function output_crit.isVersionValid(v)
    if output_crit.version then
        if v then
            return output_crit.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function output_crit.indexOf(index)
    if index == nil or not output_crit._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/output_crit.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/output_crit.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/output_crit.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "output_crit" )
                _isDataExist = output_crit.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "output_crit" )
                _isBaseExist = output_crit.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "output_crit" )
                _isExist = output_crit.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "output_crit" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "output_crit" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = output_crit._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "output_crit" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function output_crit.get(id)
    
    return output_crit.indexOf(__index_id[id])
        
end

--
function output_crit.set(id, key, value)
    local record = output_crit.get(id)
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
function output_crit.index()
    return __index_id
end

return output_crit