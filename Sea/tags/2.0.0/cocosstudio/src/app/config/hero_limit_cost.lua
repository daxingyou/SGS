--hero_limit_cost

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  limit_level = 1,    --界限等级-int 
  rank = 2,    --突破等级限制-int 
  name_1 = 3,    --材料1名称-string 
  type_1 = 4,    --材料1type-int 
  value_1 = 5,    --材料1value-int 
  size_1 = 6,    --材料1size-int 
  consume_1 = 7,    --材料1每次消耗-int 
  name_2 = 8,    --材料2名称-string 
  type_2 = 9,    --材料2type-int 
  value_2 = 10,    --材料2value-int 
  size_2 = 11,    --材料2size-int 
  consume_2 = 12,    --材料2每次消耗-int 
  name_3 = 13,    --材料3名称-string 
  type_3 = 14,    --材料3type-int 
  value_3 = 15,    --材料3value-int 
  size_3 = 16,    --材料3size-int 
  consume_3 = 17,    --材料3每次消耗-int 
  name_4 = 18,    --材料4名称-string 
  type_4 = 19,    --材料4type-int 
  value_4 = 20,    --材料4value-int 
  size_4 = 21,    --材料4size-int 
  consume_4 = 22,    --材料4每次消耗-int 
  break_name = 23,    --突破消耗名称-string 
  break_type = 24,    --突破消耗类型-int 
  break_value = 25,    --突破消耗子银两-int 
  break_size = 26,    --突破消耗数量-int 

}

-- key type
local __key_type = {
  limit_level = "int",    --界限等级-1 
  rank = "int",    --突破等级限制-2 
  name_1 = "string",    --材料1名称-3 
  type_1 = "int",    --材料1type-4 
  value_1 = "int",    --材料1value-5 
  size_1 = "int",    --材料1size-6 
  consume_1 = "int",    --材料1每次消耗-7 
  name_2 = "string",    --材料2名称-8 
  type_2 = "int",    --材料2type-9 
  value_2 = "int",    --材料2value-10 
  size_2 = "int",    --材料2size-11 
  consume_2 = "int",    --材料2每次消耗-12 
  name_3 = "string",    --材料3名称-13 
  type_3 = "int",    --材料3type-14 
  value_3 = "int",    --材料3value-15 
  size_3 = "int",    --材料3size-16 
  consume_3 = "int",    --材料3每次消耗-17 
  name_4 = "string",    --材料4名称-18 
  type_4 = "int",    --材料4type-19 
  value_4 = "int",    --材料4value-20 
  size_4 = "int",    --材料4size-21 
  consume_4 = "int",    --材料4每次消耗-22 
  break_name = "string",    --突破消耗名称-23 
  break_type = "int",    --突破消耗类型-24 
  break_value = "int",    --突破消耗子银两-25 
  break_size = "int",    --突破消耗数量-26 

}


-- data
local hero_limit_cost = {
    _data = {
        [1] = {0,5,"论语",0,0,720000,5,"左传",6,3,1500,50,"春秋",6,92,9,1,"战国",6,93,9,1,"银两",5,2,1500000,},
        [2] = {1,8,"论语",0,0,1440000,5,"左传",6,3,3000,50,"春秋",6,92,18,1,"战国",6,93,18,1,"银两",5,2,3000000,},
        [3] = {2,10,"论语",0,0,2880000,5,"左传",6,3,6000,50,"春秋",6,92,36,1,"战国",6,93,36,1,"银两",5,2,6000000,},
        [4] = {3,0,"论语",0,0,0,0,"左传",0,0,0,0,"春秋",0,0,0,0,"战国",0,0,0,0,"银两",0,0,0,},
    }
}

-- index
local __index_limit_level = {
    [0] = 1,
    [1] = 2,
    [2] = 3,
    [3] = 4,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in hero_limit_cost")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function hero_limit_cost.length()
    return #hero_limit_cost._data
end

-- 
function hero_limit_cost.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function hero_limit_cost.indexOf(index)
    if index == nil or not hero_limit_cost._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/hero_limit_cost.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "hero_limit_cost" )
        return setmetatable({_raw = hero_limit_cost._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = hero_limit_cost._data[index]}, mt)
end

--
function hero_limit_cost.get(limit_level)
    
    return hero_limit_cost.indexOf(__index_limit_level[limit_level])
        
end

--
function hero_limit_cost.set(limit_level, key, value)
    local record = hero_limit_cost.get(limit_level)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function hero_limit_cost.index()
    return __index_limit_level
end

return hero_limit_cost