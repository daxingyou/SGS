--cake_daily

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  type = 1,    --活动类型-int 
  daily = 2,    --天数-int 
  type_1 = 3,    --物品1type-int 
  id_1 = 4,    --物品1id-int 
  size_1 = 5,    --物品1size-int 
  type_2 = 6,    --物品2type-int 
  id_2 = 7,    --物品2id-int 
  size_2 = 8,    --物品2size-int 
  type_3 = 9,    --物品3type-int 
  id_3 = 10,    --物品3id-int 
  size_3 = 11,    --物品3size-int 
  type_4 = 12,    --物品4type-int 
  id_4 = 13,    --物品4id-int 
  size_4 = 14,    --物品4size-int 
  type_5 = 15,    --物品5type-int 
  id_5 = 16,    --物品5id-int 
  size_5 = 17,    --物品5size-int 

}

-- key type
local __key_type = {
  type = "int",    --活动类型-1 
  daily = "int",    --天数-2 
  type_1 = "int",    --物品1type-3 
  id_1 = "int",    --物品1id-4 
  size_1 = "int",    --物品1size-5 
  type_2 = "int",    --物品2type-6 
  id_2 = "int",    --物品2id-7 
  size_2 = "int",    --物品2size-8 
  type_3 = "int",    --物品3type-9 
  id_3 = "int",    --物品3id-10 
  size_3 = "int",    --物品3size-11 
  type_4 = "int",    --物品4type-12 
  id_4 = "int",    --物品4id-13 
  size_4 = "int",    --物品4size-14 
  type_5 = "int",    --物品5type-15 
  id_5 = "int",    --物品5id-16 
  size_5 = "int",    --物品5size-17 

}


-- data
local cake_daily = {
    version =  1,
    _data = {
        [1] = {1,1,5,1,666,6,43,1,6,42,1,5,31,500,6,570,200,},
        [2] = {1,2,5,1,666,6,43,1,6,42,1,5,31,500,6,570,200,},
        [3] = {1,3,5,1,666,6,43,1,6,42,1,5,31,500,6,570,200,},
        [4] = {2,1,5,1,666,6,43,1,6,42,1,5,31,500,6,573,200,},
        [5] = {2,2,5,1,666,6,43,1,6,42,1,5,31,500,6,573,200,},
        [6] = {2,3,5,1,666,6,43,1,6,42,1,5,31,500,6,573,200,},
        [7] = {3,1,5,1,666,6,43,1,6,42,1,5,31,500,6,576,200,},
        [8] = {3,2,5,1,666,6,43,1,6,42,1,5,31,500,6,576,200,},
        [9] = {3,3,5,1,666,6,43,1,6,42,1,5,31,500,6,576,200,},
        [10] = {4,1,5,1,666,6,43,1,6,42,1,5,31,500,6,579,200,},
        [11] = {4,2,5,1,666,6,43,1,6,42,1,5,31,500,6,579,200,},
        [12] = {4,3,5,1,666,6,43,1,6,42,1,5,31,500,6,579,200,},
    }
}

-- index
local __index_type_daily = {
    ["1_1"] = 1,
    ["1_2"] = 2,
    ["1_3"] = 3,
    ["2_1"] = 4,
    ["2_2"] = 5,
    ["2_3"] = 6,
    ["3_1"] = 7,
    ["3_2"] = 8,
    ["3_3"] = 9,
    ["4_1"] = 10,
    ["4_2"] = 11,
    ["4_3"] = 12,

}

-- index mainkey map
local __main_key_map = {
    [1] = "1_1",
    [2] = "1_2",
    [3] = "1_3",
    [4] = "2_1",
    [5] = "2_2",
    [6] = "2_3",
    [7] = "3_1",
    [8] = "3_2",
    [9] = "3_3",
    [10] = "4_1",
    [11] = "4_2",
    [12] = "4_3",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in cake_daily")
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
function cake_daily.length()
    return #cake_daily._data
end

-- 
function cake_daily.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cake_daily.isVersionValid(v)
    if cake_daily.version then
        if v then
            return cake_daily.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cake_daily.indexOf(index)
    if index == nil or not cake_daily._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cake_daily.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cake_daily.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cake_daily.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cake_daily" )
                _isDataExist = cake_daily.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cake_daily" )
                _isBaseExist = cake_daily.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cake_daily" )
                _isExist = cake_daily.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cake_daily" )
        local main_key = __main_key_map[index]
		local index_key = "__index_type_daily"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cake_daily" )
        local main_key = __main_key_map[index]
		local index_key = "__index_type_daily"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cake_daily._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cake_daily" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cake_daily.get(type,daily)
    
    local k = type .. '_' .. daily
    return cake_daily.indexOf(__index_type_daily[k])
        
end

--
function cake_daily.set(type,daily, key, value)
    local record = cake_daily.get(type,daily)
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
function cake_daily.index()
    return __index_type_daily
end

return cake_daily