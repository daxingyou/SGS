--historical_hero_map

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  name = 2,    --图鉴名称-string 
  hero_1 = 3,    --名将1-int 
  hero_2 = 4,    --名将2-int 
  attr_type_1 = 5,    --属性类型1-int 
  attr_value_1 = 6,    --属性值1-int 
  attr_type_2 = 7,    --属性类型2-int 
  attr_value_2 = 8,    --属性值2-int 
  attr_type_3 = 9,    --属性类型3-int 
  attr_value_3 = 10,    --属性值3-int 
  attr_type_4 = 11,    --属性类型4-int 
  attr_value_4 = 12,    --属性值4-int 
  power = 13,    --假战力-int 
  show = 14,    --是否显示-int 
  show_day = 15,    --达到开服天数显示-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  name = "string",    --图鉴名称-2 
  hero_1 = "int",    --名将1-3 
  hero_2 = "int",    --名将2-4 
  attr_type_1 = "int",    --属性类型1-5 
  attr_value_1 = "int",    --属性值1-6 
  attr_type_2 = "int",    --属性类型2-7 
  attr_value_2 = "int",    --属性值2-8 
  attr_type_3 = "int",    --属性类型3-9 
  attr_value_3 = "int",    --属性值3-10 
  attr_type_4 = "int",    --属性类型4-11 
  attr_value_4 = "int",    --属性值4-12 
  power = "int",    --假战力-13 
  show = "int",    --是否显示-14 
  show_day = "int",    --达到开服天数显示-15 

}


-- data
local historical_hero_map = {
    version =  1,
    _data = {
        [1] = {1001,"剑胆琴心",101,102,1,1000,7,100000,0,0,0,0,1000000,1,1,},
        [2] = {1002,"文韬武略",103,104,1,1000,7,100000,0,0,0,0,1000000,1,1,},
        [3] = {2001,"秦皇汉武",201,202,1,1000,7,100000,0,0,0,0,2000000,1,50,},
    }
}

-- index
local __index_id = {
    [1001] = 1,
    [1002] = 2,
    [2001] = 3,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1001,
    [2] = 1002,
    [3] = 2001,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in historical_hero_map")
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
function historical_hero_map.length()
    return #historical_hero_map._data
end

-- 
function historical_hero_map.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function historical_hero_map.isVersionValid(v)
    if historical_hero_map.version then
        if v then
            return historical_hero_map.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function historical_hero_map.indexOf(index)
    if index == nil or not historical_hero_map._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/historical_hero_map.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/historical_hero_map.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/historical_hero_map.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "historical_hero_map" )
                _isDataExist = historical_hero_map.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "historical_hero_map" )
                _isBaseExist = historical_hero_map.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero_map" )
                _isExist = historical_hero_map.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "historical_hero_map" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero_map" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = historical_hero_map._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "historical_hero_map" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function historical_hero_map.get(id)
    
    return historical_hero_map.indexOf(__index_id[id])
        
end

--
function historical_hero_map.set(id, key, value)
    local record = historical_hero_map.get(id)
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
function historical_hero_map.index()
    return __index_id
end

return historical_hero_map