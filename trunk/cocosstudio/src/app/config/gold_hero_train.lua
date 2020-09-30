--gold_hero_train

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  limit_level = 1,    --养成等级-int 
  name_1 = 2,    --材料1名称-string 
  cost_hero = 3,    --同名武将消耗量-int 
  consume_hero = 4,    --同名武将每次消耗-int 
  name_2 = 5,    --材料2名称-string 
  type_2 = 6,    --材料2type-int 
  value_2 = 7,    --材料2value-int 
  size_2 = 8,    --材料2size-int 
  consume_2 = 9,    --材料2每次消耗-int 
  name_3 = 10,    --材料3名称-string 
  type_3 = 11,    --材料3type-int 
  value_3 = 12,    --材料3value-int 
  size_3 = 13,    --材料3size-int 
  consume_3 = 14,    --材料3每次消耗-int 
  name_4 = 15,    --材料4名称-string 
  type_4 = 16,    --材料4type-int 
  value_4 = 17,    --材料4value-int 
  size_4 = 18,    --材料4size-int 
  consume_4 = 19,    --材料4每次消耗-int 
  break_name = 20,    --突破消耗名称-string 
  break_type = 21,    --突破消耗类型-int 
  break_value = 22,    --突破消耗子银两-int 
  break_size = 23,    --突破消耗数量-int 

}

-- key type
local __key_type = {
  limit_level = "int",    --养成等级-1 
  name_1 = "string",    --材料1名称-2 
  cost_hero = "int",    --同名武将消耗量-3 
  consume_hero = "int",    --同名武将每次消耗-4 
  name_2 = "string",    --材料2名称-5 
  type_2 = "int",    --材料2type-6 
  value_2 = "int",    --材料2value-7 
  size_2 = "int",    --材料2size-8 
  consume_2 = "int",    --材料2每次消耗-9 
  name_3 = "string",    --材料3名称-10 
  type_3 = "int",    --材料3type-11 
  value_3 = "int",    --材料3value-12 
  size_3 = "int",    --材料3size-13 
  consume_3 = "int",    --材料3每次消耗-14 
  name_4 = "string",    --材料4名称-15 
  type_4 = "int",    --材料4type-16 
  value_4 = "int",    --材料4value-17 
  size_4 = "int",    --材料4size-18 
  consume_4 = "int",    --材料4每次消耗-19 
  break_name = "string",    --突破消耗名称-20 
  break_type = "int",    --突破消耗类型-21 
  break_value = "int",    --突破消耗子银两-22 
  break_size = "int",    --突破消耗数量-23 

}


-- data
local gold_hero_train = {
    version =  1,
    _data = {
        [1] = {0,"天",1,1,"治国",0,0,2500000,20,"修身",6,3,3200,300,"齐家",6,40,2000,200,"银两",5,2,4800000,},
        [2] = {1,"天",1,1,"治国",0,0,5000000,40,"修身",6,3,6400,300,"齐家",6,40,10000,500,"银两",5,2,9600000,},
        [3] = {2,"天",2,1,"治国",0,0,10000000,80,"修身",6,3,12000,480,"齐家",6,40,50000,2000,"银两",5,2,18000000,},
        [4] = {3,"天",3,1,"治国",0,0,20000000,120,"修身",6,3,25000,1000,"齐家",6,40,200000,8000,"银两",5,2,36000000,},
        [5] = {4,"天",4,1,"治国",0,0,40000000,200,"修身",6,3,50000,1250,"齐家",6,40,800000,20000,"银两",5,2,72000000,},
        [6] = {5,"天",0,0,"治国",0,0,0,0,"修身",0,0,0,0,"齐家",0,0,0,0,"银两",0,0,0,},
    }
}

-- index
local __index_limit_level = {
    [0] = 1,
    [1] = 2,
    [2] = 3,
    [3] = 4,
    [4] = 5,
    [5] = 6,

}

-- index mainkey map
local __main_key_map = {
    [1] = 0,
    [2] = 1,
    [3] = 2,
    [4] = 3,
    [5] = 4,
    [6] = 5,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in gold_hero_train")
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
function gold_hero_train.length()
    return #gold_hero_train._data
end

-- 
function gold_hero_train.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function gold_hero_train.isVersionValid(v)
    if gold_hero_train.version then
        if v then
            return gold_hero_train.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function gold_hero_train.indexOf(index)
    if index == nil or not gold_hero_train._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/gold_hero_train.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/gold_hero_train.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/gold_hero_train.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "gold_hero_train" )
                _isDataExist = gold_hero_train.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "gold_hero_train" )
                _isBaseExist = gold_hero_train.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "gold_hero_train" )
                _isExist = gold_hero_train.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "gold_hero_train" )
        local main_key = __main_key_map[index]
		local index_key = "__index_limit_level"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "gold_hero_train" )
        local main_key = __main_key_map[index]
		local index_key = "__index_limit_level"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = gold_hero_train._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "gold_hero_train" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function gold_hero_train.get(limit_level)
    
    return gold_hero_train.indexOf(__index_limit_level[limit_level])
        
end

--
function gold_hero_train.set(limit_level, key, value)
    local record = gold_hero_train.get(limit_level)
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
function gold_hero_train.index()
    return __index_limit_level
end

return gold_hero_train