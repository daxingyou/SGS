--hero_limit_size

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --武将id-int 
  name = 2,    --武将名称-string 
  limit_level = 3,    --界限突破等级-int 
  type_1 = 4,    --属性1类型-int 
  size_1 = 5,    --属性1数值-int 
  type_2 = 6,    --属性2类型-int 
  size_2 = 7,    --属性2数值-int 
  type_3 = 8,    --属性3类型-int 
  size_3 = 9,    --属性3数值-int 
  type_4 = 10,    --属性4类型-int 
  size_4 = 11,    --属性4数值-int 

}

-- key type
local __key_type = {
  id = "int",    --武将id-1 
  name = "string",    --武将名称-2 
  limit_level = "int",    --界限突破等级-3 
  type_1 = "int",    --属性1类型-4 
  size_1 = "int",    --属性1数值-5 
  type_2 = "int",    --属性2类型-6 
  size_2 = "int",    --属性2数值-7 
  type_3 = "int",    --属性3类型-8 
  size_3 = "int",    --属性3数值-9 
  type_4 = "int",    --属性4类型-10 
  size_4 = "int",    --属性4数值-11 

}


-- data
local hero_limit_size = {
    _data = {
        [1] = {111,"曹丕",0,0,0,0,0,0,0,0,0,},
        [2] = {111,"曹丕",1,1,240,5,60,6,70,7,1360,},
        [3] = {111,"曹丕",2,1,2230,5,520,6,630,7,12660,},
        [4] = {111,"曹丕",3,1,5500,5,1280,6,1540,7,31200,},
        [5] = {205,"关羽",0,0,0,0,0,0,0,0,0,},
        [6] = {205,"关羽",1,1,240,5,70,6,60,7,1360,},
        [7] = {205,"关羽",2,1,2230,5,630,6,520,7,12660,},
        [8] = {205,"关羽",3,1,5500,5,1540,6,1280,7,31200,},
        [9] = {308,"甘宁",0,0,0,0,0,0,0,0,0,},
        [10] = {308,"甘宁",1,1,240,5,70,6,60,7,1360,},
        [11] = {308,"甘宁",2,1,2230,5,630,6,520,7,12660,},
        [12] = {308,"甘宁",3,1,5500,5,1540,6,1280,7,31200,},
        [13] = {411,"袁绍",0,0,0,0,0,0,0,0,0,},
        [14] = {411,"袁绍",1,1,200,5,70,6,60,7,1500,},
        [15] = {411,"袁绍",2,1,1860,5,630,6,520,7,14010,},
        [16] = {411,"袁绍",3,1,4570,5,1540,6,1280,7,34540,},
    }
}

-- index
local __index_id_limit_level = {
    ["111_0"] = 1,
    ["111_1"] = 2,
    ["111_2"] = 3,
    ["111_3"] = 4,
    ["205_0"] = 5,
    ["205_1"] = 6,
    ["205_2"] = 7,
    ["205_3"] = 8,
    ["308_0"] = 9,
    ["308_1"] = 10,
    ["308_2"] = 11,
    ["308_3"] = 12,
    ["411_0"] = 13,
    ["411_1"] = 14,
    ["411_2"] = 15,
    ["411_3"] = 16,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in hero_limit_size")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function hero_limit_size.length()
    return #hero_limit_size._data
end

-- 
function hero_limit_size.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function hero_limit_size.indexOf(index)
    if index == nil or not hero_limit_size._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/hero_limit_size.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "hero_limit_size" )
        return setmetatable({_raw = hero_limit_size._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = hero_limit_size._data[index]}, mt)
end

--
function hero_limit_size.get(id,limit_level)
    
    local k = id .. '_' .. limit_level
    return hero_limit_size.indexOf(__index_id_limit_level[k])
        
end

--
function hero_limit_size.set(id,limit_level, key, value)
    local record = hero_limit_size.get(id,limit_level)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function hero_limit_size.index()
    return __index_id_limit_level
end

return hero_limit_size