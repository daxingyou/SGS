--synthesis

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  type = 2,    --合成类型-int 
  des = 3,    --合成类型文本-string 
  level = 4,    --开启等级-int 
  condition_type = 5,    --条件类型-int 
  condition_value = 6,    --条件值-int 
  syn_type = 7,    --合成物品类型-int 
  syn_value = 8,    --合成物品-int 
  syn_size = 9,    --合成物品数量-int 
  cost_type = 10,    --合成消耗类型-int 
  cost_value = 11,    --合成消耗货币-int 
  cost_size = 12,    --合成消耗数量-int 
  material_type_1 = 13,    --合成材料类型1-int 
  material_value_1 = 14,    --合成材料1-int 
  material_size_1 = 15,    --合成材料数量1-int 
  material_type_2 = 16,    --合成材料类型2-int 
  material_value_2 = 17,    --合成材料2-int 
  material_size_2 = 18,    --合成材料数量2-int 
  material_type_3 = 19,    --合成材料类型3-int 
  material_value_3 = 20,    --合成材料3-int 
  material_size_3 = 21,    --合成材料数量3-int 
  material_type_4 = 22,    --合成材料类型4-int 
  material_value_4 = 23,    --合成材料4-int 
  material_size_4 = 24,    --合成材料数量4-int 
  material_type_5 = 25,    --合成材料类型5-int 
  material_value_5 = 26,    --合成材料5-int 
  material_size_5 = 27,    --合成材料数量5-int 
  material_type_6 = 28,    --合成材料类型6-int 
  material_value_6 = 29,    --合成材料6-int 
  material_size_6 = 30,    --合成材料数量6-int 
  material_type_7 = 31,    --合成材料类型7-int 
  material_value_7 = 32,    --合成材料7-int 
  material_size_7 = 33,    --合成材料数量7-int 
  material_type_8 = 34,    --合成材料类型8-int 
  material_value_8 = 35,    --合成材料8-int 
  material_size_8 = 36,    --合成材料数量8-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  type = "int",    --合成类型-2 
  des = "string",    --合成类型文本-3 
  level = "int",    --开启等级-4 
  condition_type = "int",    --条件类型-5 
  condition_value = "int",    --条件值-6 
  syn_type = "int",    --合成物品类型-7 
  syn_value = "int",    --合成物品-8 
  syn_size = "int",    --合成物品数量-9 
  cost_type = "int",    --合成消耗类型-10 
  cost_value = "int",    --合成消耗货币-11 
  cost_size = "int",    --合成消耗数量-12 
  material_type_1 = "int",    --合成材料类型1-13 
  material_value_1 = "int",    --合成材料1-14 
  material_size_1 = "int",    --合成材料数量1-15 
  material_type_2 = "int",    --合成材料类型2-16 
  material_value_2 = "int",    --合成材料2-17 
  material_size_2 = "int",    --合成材料数量2-18 
  material_type_3 = "int",    --合成材料类型3-19 
  material_value_3 = "int",    --合成材料3-20 
  material_size_3 = "int",    --合成材料数量3-21 
  material_type_4 = "int",    --合成材料类型4-22 
  material_value_4 = "int",    --合成材料4-23 
  material_size_4 = "int",    --合成材料数量4-24 
  material_type_5 = "int",    --合成材料类型5-25 
  material_value_5 = "int",    --合成材料5-26 
  material_size_5 = "int",    --合成材料数量5-27 
  material_type_6 = "int",    --合成材料类型6-28 
  material_value_6 = "int",    --合成材料6-29 
  material_size_6 = "int",    --合成材料数量6-30 
  material_type_7 = "int",    --合成材料类型7-31 
  material_value_7 = "int",    --合成材料7-32 
  material_size_7 = "int",    --合成材料数量7-33 
  material_type_8 = "int",    --合成材料类型8-34 
  material_value_8 = "int",    --合成材料8-35 
  material_size_8 = "int",    --合成材料数量8-36 

}


-- data
local synthesis = {
    version =  1,
    _data = {
        [1] = {1,1,0,120,0,0,6,723,1,5,2,5000000,6,23,4,6,24,4,6,25,4,6,26,4,6,27,4,0,0,0,0,0,0,0,0,0,},
        [2] = {2,1,0,120,0,0,6,724,1,5,2,8000000,6,23,2,6,24,2,6,25,2,6,26,2,6,27,2,6,723,1,0,0,0,0,0,0,},
        [3] = {3,2,0,999,0,0,6,45,1,5,2,1800000,6,41,3,6,44,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [4] = {4,2,0,999,0,0,6,46,1,5,2,2400000,6,42,1,6,43,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [5] = {5,3,0,120,3,11,6,505,1,5,2,1800000,6,501,2,6,502,1,6,503,1,6,504,1,0,0,0,0,0,0,0,0,0,0,0,0,},
        [6] = {6,3,0,120,3,11,6,515,1,5,2,1800000,6,511,2,6,512,1,6,513,1,6,514,1,0,0,0,0,0,0,0,0,0,0,0,0,},
        [7] = {7,3,0,120,3,11,6,535,1,5,2,1800000,6,531,2,6,532,1,6,533,1,6,534,1,0,0,0,0,0,0,0,0,0,0,0,0,},
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
        assert(key_map[k], "cannot find " .. k .. " in synthesis")
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
function synthesis.length()
    return #synthesis._data
end

-- 
function synthesis.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function synthesis.isVersionValid(v)
    if synthesis.version then
        if v then
            return synthesis.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function synthesis.indexOf(index)
    if index == nil or not synthesis._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/synthesis.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/synthesis.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/synthesis.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "synthesis" )
                _isDataExist = synthesis.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "synthesis" )
                _isBaseExist = synthesis.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "synthesis" )
                _isExist = synthesis.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "synthesis" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "synthesis" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = synthesis._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "synthesis" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function synthesis.get(id)
    
    return synthesis.indexOf(__index_id[id])
        
end

--
function synthesis.set(id, key, value)
    local record = synthesis.get(id)
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
function synthesis.index()
    return __index_id
end

return synthesis