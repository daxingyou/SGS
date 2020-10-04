--function_strengthen

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  level_min = 2,    --等级上限-int 
  level_max = 3,    --等级下限-int 
  function_1 = 4,    --功能1-int 
  function_2 = 5,    --功能2-int 
  function_3 = 6,    --功能3-int 
  function_4 = 7,    --功能4-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  level_min = "int",    --等级上限-2 
  level_max = "int",    --等级下限-3 
  function_1 = "int",    --功能1-4 
  function_2 = "int",    --功能2-5 
  function_3 = "int",    --功能3-6 
  function_4 = "int",    --功能4-7 

}


-- data
local function_strengthen = {
    version =  1,
    _data = {
        [1] = {1,1,10,11,130,131,132,},
        [2] = {2,11,20,11,130,131,132,},
        [3] = {3,21,30,11,130,131,132,},
        [4] = {4,31,40,11,130,131,132,},
        [5] = {5,41,50,11,130,131,132,},
        [6] = {6,51,60,11,130,131,132,},
        [7] = {7,61,70,11,130,131,132,},
        [8] = {8,71,80,11,130,131,132,},
        [9] = {9,81,90,11,130,131,132,},
        [10] = {10,91,100,11,130,131,132,},
        [11] = {11,101,999,11,130,131,132,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
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
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in function_strengthen")
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
function function_strengthen.length()
    return #function_strengthen._data
end

-- 
function function_strengthen.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function function_strengthen.isVersionValid(v)
    if function_strengthen.version then
        if v then
            return function_strengthen.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function function_strengthen.indexOf(index)
    if index == nil or not function_strengthen._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/function_strengthen.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/function_strengthen.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/function_strengthen.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "function_strengthen" )
                _isDataExist = function_strengthen.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "function_strengthen" )
                _isBaseExist = function_strengthen.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "function_strengthen" )
                _isExist = function_strengthen.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "function_strengthen" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "function_strengthen" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = function_strengthen._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "function_strengthen" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function function_strengthen.get(id)
    
    return function_strengthen.indexOf(__index_id[id])
        
end

--
function function_strengthen.set(id, key, value)
    local record = function_strengthen.get(id)
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
function function_strengthen.index()
    return __index_id
end

return function_strengthen