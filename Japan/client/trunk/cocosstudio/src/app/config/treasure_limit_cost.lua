--treasure_limit_cost

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  limit_level = 1,    --界限等级-int 
  refine = 2,    --精炼等级限制-int 
  function_id = 3,    --function表的ID-int 
  name_1 = 4,    --材料1名称-string 
  exp = 5,    --需要经验-int 
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
  limit_level = "int",    --界限等级-1 
  refine = "int",    --精炼等级限制-2 
  function_id = "int",    --function表的ID-3 
  name_1 = "string",    --材料1名称-4 
  exp = "int",    --需要经验-5 
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
local treasure_limit_cost = {
    version =  1,
    _data = {
        [1] = {0,0,124,"天工",2000000,5,"开物",6,10,2000,50,"春秋",6,92,18,1,"战国",6,93,18,1,"银两",5,2,12000000,},
        [2] = {1,0,125,"天工",3000000,5,"开物",6,10,3000,50,"礼记",6,555,9,1,"周易",6,556,9,1,"银两",5,2,18000000,},
        [3] = {2,0,0,"天工",0,0,"开物",0,0,0,0,"春秋",0,0,0,0,"战国",0,0,0,0,"银两",0,0,0,},
    }
}

-- index
local __index_limit_level = {
    [0] = 1,
    [1] = 2,
    [2] = 3,

}

-- index mainkey map
local __main_key_map = {
    [1] = 0,
    [2] = 1,
    [3] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in treasure_limit_cost")
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
function treasure_limit_cost.isVersionValid(v)
    if treasure_limit_cost.version then
        if v then
            return treasure_limit_cost.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function treasure_limit_cost.indexOf(index)
    if index == nil or not treasure_limit_cost._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/treasure_limit_cost.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/treasure_limit_cost.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/treasure_limit_cost.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "treasure_limit_cost" )
                _isDataExist = treasure_limit_cost.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "treasure_limit_cost" )
                _isBaseExist = treasure_limit_cost.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "treasure_limit_cost" )
                _isExist = treasure_limit_cost.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "treasure_limit_cost" )
        local main_key = __main_key_map[index]
		local index_key = "__index_limit_level"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "treasure_limit_cost" )
        local main_key = __main_key_map[index]
		local index_key = "__index_limit_level"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = treasure_limit_cost._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "treasure_limit_cost" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function treasure_limit_cost.get(limit_level)
    
    return treasure_limit_cost.indexOf(__index_limit_level[limit_level])
        
end

--
function treasure_limit_cost.set(limit_level, key, value)
    local record = treasure_limit_cost.get(limit_level)
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
function treasure_limit_cost.index()
    return __index_limit_level
end

return treasure_limit_cost