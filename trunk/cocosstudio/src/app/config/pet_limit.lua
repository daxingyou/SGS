--pet_limit

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  limit_id = 1,    --界限ID-int 
  name_1 = 2,    --材料1名称-string 
  type_1 = 3,    --材料1type-int 
  value_1 = 4,    --材料1value-int 
  size_1 = 5,    --材料1size-int 
  consume_1 = 6,    --材料1每次消耗-int 
  name_2 = 7,    --材料2名称-string 
  type_2 = 8,    --材料2type-int 
  value_2 = 9,    --材料2value-int 
  size_2 = 10,    --材料2size-int 
  consume_2 = 11,    --材料2每次消耗-int 
  name_3 = 12,    --材料3名称-string 
  type_3 = 13,    --材料3type-int 
  value_3 = 14,    --材料3value-int 
  size_3 = 15,    --材料3size-int 
  consume_3 = 16,    --材料3每次消耗-int 
  name_4 = 17,    --材料4名称-string 
  type_4 = 18,    --材料4type-int 
  value_4 = 19,    --材料4value-int 
  size_4 = 20,    --材料4size-int 
  consume_4 = 21,    --材料4每次消耗-int 
  break_name = 22,    --突破消耗名称-string 
  break_type = 23,    --突破消耗类型-int 
  break_value = 24,    --突破消耗子银两-int 
  break_size = 25,    --突破消耗数量-int 

}

-- key type
local __key_type = {
  limit_id = "int",    --界限ID-1 
  name_1 = "string",    --材料1名称-2 
  type_1 = "int",    --材料1type-3 
  value_1 = "int",    --材料1value-4 
  size_1 = "int",    --材料1size-5 
  consume_1 = "int",    --材料1每次消耗-6 
  name_2 = "string",    --材料2名称-7 
  type_2 = "int",    --材料2type-8 
  value_2 = "int",    --材料2value-9 
  size_2 = "int",    --材料2size-10 
  consume_2 = "int",    --材料2每次消耗-11 
  name_3 = "string",    --材料3名称-12 
  type_3 = "int",    --材料3type-13 
  value_3 = "int",    --材料3value-14 
  size_3 = "int",    --材料3size-15 
  consume_3 = "int",    --材料3每次消耗-16 
  name_4 = "string",    --材料4名称-17 
  type_4 = "int",    --材料4type-18 
  value_4 = "int",    --材料4value-19 
  size_4 = "int",    --材料4size-20 
  consume_4 = "int",    --材料4每次消耗-21 
  break_name = "string",    --突破消耗名称-22 
  break_type = "int",    --突破消耗类型-23 
  break_value = "int",    --突破消耗子银两-24 
  break_size = "int",    --突破消耗数量-25 

}


-- data
local pet_limit = {
    version =  1,
    _data = {
        [1] = {1,"治国",0,0,10631200,50,"修身",6,32,18000,1000,"齐家",6,559,1,1,"齐家",6,559,1,1,"银两",5,2,6000000,},
    }
}

-- index
local __index_limit_id = {
    [1] = 1,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in pet_limit")
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
function pet_limit.length()
    return #pet_limit._data
end

-- 
function pet_limit.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pet_limit.isVersionValid(v)
    if pet_limit.version then
        if v then
            return pet_limit.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function pet_limit.indexOf(index)
    if index == nil or not pet_limit._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/pet_limit.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/pet_limit.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/pet_limit.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "pet_limit" )
                _isDataExist = pet_limit.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "pet_limit" )
                _isBaseExist = pet_limit.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "pet_limit" )
                _isExist = pet_limit.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "pet_limit" )
        local main_key = __main_key_map[index]
		local index_key = "__index_limit_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pet_limit" )
        local main_key = __main_key_map[index]
		local index_key = "__index_limit_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = pet_limit._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "pet_limit" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function pet_limit.get(limit_id)
    
    return pet_limit.indexOf(__index_limit_id[limit_id])
        
end

--
function pet_limit.set(limit_id, key, value)
    local record = pet_limit.get(limit_id)
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
function pet_limit.index()
    return __index_limit_id
end

return pet_limit