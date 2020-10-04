--treasure_limit_cost

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  limit_level = 1,    --界限等级-int 
  refine = 2,    --精炼等级限制-int 
  name_1 = 3,    --材料1名称-string 
  exp = 4,    --需要经验-int 
  consume_1 = 5,    --材料1每次消耗-int 
  name_2 = 6,    --材料2名称-string 
  type_2 = 7,    --材料2type-int 
  value_2 = 8,    --材料2value-int 
  size_2 = 9,    --材料2size-int 
  consume_2 = 10,    --材料2每次消耗-int 
  name_3 = 11,    --材料3名称-string 
  type_3 = 12,    --材料3type-int 
  value_3 = 13,    --材料3value-int 
  size_3 = 14,    --材料3size-int 
  consume_3 = 15,    --材料3每次消耗-int 
  name_4 = 16,    --材料4名称-string 
  type_4 = 17,    --材料4type-int 
  value_4 = 18,    --材料4value-int 
  size_4 = 19,    --材料4size-int 
  consume_4 = 20,    --材料4每次消耗-int 
  break_name = 21,    --突破消耗名称-string 
  break_type = 22,    --突破消耗类型-int 
  break_value = 23,    --突破消耗子银两-int 
  break_size = 24,    --突破消耗数量-int 

}

-- key type
local __key_type = {
  limit_level = "int",    --界限等级-1 
  refine = "int",    --精炼等级限制-2 
  name_1 = "string",    --材料1名称-3 
  exp = "int",    --需要经验-4 
  consume_1 = "int",    --材料1每次消耗-5 
  name_2 = "string",    --材料2名称-6 
  type_2 = "int",    --材料2type-7 
  value_2 = "int",    --材料2value-8 
  size_2 = "int",    --材料2size-9 
  consume_2 = "int",    --材料2每次消耗-10 
  name_3 = "string",    --材料3名称-11 
  type_3 = "int",    --材料3type-12 
  value_3 = "int",    --材料3value-13 
  size_3 = "int",    --材料3size-14 
  consume_3 = "int",    --材料3每次消耗-15 
  name_4 = "string",    --材料4名称-16 
  type_4 = "int",    --材料4type-17 
  value_4 = "int",    --材料4value-18 
  size_4 = "int",    --材料4size-19 
  consume_4 = "int",    --材料4每次消耗-20 
  break_name = "string",    --突破消耗名称-21 
  break_type = "int",    --突破消耗类型-22 
  break_value = "int",    --突破消耗子银两-23 
  break_size = "int",    --突破消耗数量-24 

}


-- data
local treasure_limit_cost = {
    _data = {
        [1] = {0,0,"天工",2000000,5,"开物",6,10,2000,50,"春秋",6,92,18,1,"战国",6,93,18,1,"银两",5,2,12000000,},
        [2] = {1,0,"天工",0,0,"开物",0,0,0,0,"春秋",0,0,0,0,"战国",0,0,0,0,"银两",0,0,0,},
    }
}

-- index
local __index_limit_level = {
    [0] = 1,
    [1] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in treasure_limit_cost")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function treasure_limit_cost.length()
    return #treasure_limit_cost._data
end

-- 
function treasure_limit_cost.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function treasure_limit_cost.indexOf(index)
    if index == nil or not treasure_limit_cost._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/treasure_limit_cost.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "treasure_limit_cost" )
        return setmetatable({_raw = treasure_limit_cost._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = treasure_limit_cost._data[index]}, mt)
end

--
function treasure_limit_cost.get(limit_level)
    
    return treasure_limit_cost.indexOf(__index_limit_level[limit_level])
        
end

--
function treasure_limit_cost.set(limit_level, key, value)
    local record = treasure_limit_cost.get(limit_level)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function treasure_limit_cost.index()
    return __index_limit_level
end

return treasure_limit_cost