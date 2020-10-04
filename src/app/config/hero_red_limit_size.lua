--hero_red_limit_size

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --武将id-int 
  name = 2,    --武将名称-string 
  limit_red_level = 3,    --界限突破等级-int 
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
  limit_red_level = "int",    --界限突破等级-3 
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
local hero_red_limit_size = {
    version =  1,
    _data = {
        [1] = {101,"司马懿",0,0,0,0,0,0,0,0,0,},
        [2] = {101,"司马懿",1,1,6700,5,2700,6,3200,7,45200,},
        [3] = {101,"司马懿",2,1,10000,5,4000,6,4800,7,67800,},
        [4] = {101,"司马懿",3,1,15000,5,6000,6,7200,7,101700,},
        [5] = {101,"司马懿",4,1,22600,5,9000,6,10800,7,152500,},
        [6] = {201,"赵云",0,0,0,0,0,0,0,0,0,},
        [7] = {201,"赵云",1,1,6700,5,3200,6,2700,7,45200,},
        [8] = {201,"赵云",2,1,10000,5,4800,6,4000,7,67800,},
        [9] = {201,"赵云",3,1,15000,5,7200,6,6000,7,101700,},
        [10] = {201,"赵云",4,1,22600,5,10800,6,9000,7,152500,},
        [11] = {301,"孙策",0,0,0,0,0,0,0,0,0,},
        [12] = {301,"孙策",1,1,6700,5,3200,6,2700,7,45200,},
        [13] = {301,"孙策",2,1,10000,5,4800,6,4000,7,67800,},
        [14] = {301,"孙策",3,1,15000,5,7200,6,6000,7,101700,},
        [15] = {301,"孙策",4,1,22600,5,10800,6,9000,7,152500,},
        [16] = {403,"吕布",0,0,0,0,0,0,0,0,0,},
        [17] = {403,"吕布",1,1,6700,5,3200,6,2700,7,45200,},
        [18] = {403,"吕布",2,1,10000,5,4800,6,4000,7,67800,},
        [19] = {403,"吕布",3,1,15000,5,7200,6,6000,7,101700,},
        [20] = {403,"吕布",4,1,22600,5,10800,6,9000,7,152500,},
        [21] = {103,"曹操",0,0,0,0,0,0,0,0,0,},
        [22] = {103,"曹操",1,1,6200,5,3000,6,2900,7,46800,},
        [23] = {103,"曹操",2,1,9400,5,4400,6,4300,7,70100,},
        [24] = {103,"曹操",3,1,14100,5,6700,6,6500,7,105200,},
        [25] = {103,"曹操",4,1,21100,5,10000,6,9700,7,157800,},
        [26] = {203,"诸葛亮",0,0,0,0,0,0,0,0,0,},
        [27] = {203,"诸葛亮",1,1,6200,5,2900,6,3000,7,46800,},
        [28] = {203,"诸葛亮",2,1,9400,5,4300,6,4400,7,70100,},
        [29] = {203,"诸葛亮",3,1,14100,5,6500,6,6700,7,105200,},
        [30] = {203,"诸葛亮",4,1,21100,5,9700,6,10000,7,157800,},
        [31] = {303,"周瑜",0,0,0,0,0,0,0,0,0,},
        [32] = {303,"周瑜",1,1,6700,5,2700,6,3200,7,45200,},
        [33] = {303,"周瑜",2,1,10000,5,4000,6,4800,7,67800,},
        [34] = {303,"周瑜",3,1,15000,5,6000,6,7200,7,101700,},
        [35] = {303,"周瑜",4,1,22600,5,9000,6,10800,7,152500,},
        [36] = {401,"左慈",0,0,0,0,0,0,0,0,0,},
        [37] = {401,"左慈",1,1,6200,5,2900,6,3000,7,46800,},
        [38] = {401,"左慈",2,1,9400,5,4300,6,4400,7,70100,},
        [39] = {401,"左慈",3,1,14100,5,6500,6,6700,7,105200,},
        [40] = {401,"左慈",4,1,21100,5,9700,6,10000,7,157800,},
    }
}

-- index
local __index_id_limit_red_level = {
    ["101_0"] = 1,
    ["101_1"] = 2,
    ["101_2"] = 3,
    ["101_3"] = 4,
    ["101_4"] = 5,
    ["103_0"] = 21,
    ["103_1"] = 22,
    ["103_2"] = 23,
    ["103_3"] = 24,
    ["103_4"] = 25,
    ["201_0"] = 6,
    ["201_1"] = 7,
    ["201_2"] = 8,
    ["201_3"] = 9,
    ["201_4"] = 10,
    ["203_0"] = 26,
    ["203_1"] = 27,
    ["203_2"] = 28,
    ["203_3"] = 29,
    ["203_4"] = 30,
    ["301_0"] = 11,
    ["301_1"] = 12,
    ["301_2"] = 13,
    ["301_3"] = 14,
    ["301_4"] = 15,
    ["303_0"] = 31,
    ["303_1"] = 32,
    ["303_2"] = 33,
    ["303_3"] = 34,
    ["303_4"] = 35,
    ["401_0"] = 36,
    ["401_1"] = 37,
    ["401_2"] = 38,
    ["401_3"] = 39,
    ["401_4"] = 40,
    ["403_0"] = 16,
    ["403_1"] = 17,
    ["403_2"] = 18,
    ["403_3"] = 19,
    ["403_4"] = 20,

}

-- index mainkey map
local __main_key_map = {
    [1] = "101_0",
    [2] = "101_1",
    [3] = "101_2",
    [4] = "101_3",
    [5] = "101_4",
    [21] = "103_0",
    [22] = "103_1",
    [23] = "103_2",
    [24] = "103_3",
    [25] = "103_4",
    [6] = "201_0",
    [7] = "201_1",
    [8] = "201_2",
    [9] = "201_3",
    [10] = "201_4",
    [26] = "203_0",
    [27] = "203_1",
    [28] = "203_2",
    [29] = "203_3",
    [30] = "203_4",
    [11] = "301_0",
    [12] = "301_1",
    [13] = "301_2",
    [14] = "301_3",
    [15] = "301_4",
    [31] = "303_0",
    [32] = "303_1",
    [33] = "303_2",
    [34] = "303_3",
    [35] = "303_4",
    [36] = "401_0",
    [37] = "401_1",
    [38] = "401_2",
    [39] = "401_3",
    [40] = "401_4",
    [16] = "403_0",
    [17] = "403_1",
    [18] = "403_2",
    [19] = "403_3",
    [20] = "403_4",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in hero_red_limit_size")
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
function hero_red_limit_size.length()
    return #hero_red_limit_size._data
end

-- 
function hero_red_limit_size.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function hero_red_limit_size.isVersionValid(v)
    if hero_red_limit_size.version then
        if v then
            return hero_red_limit_size.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function hero_red_limit_size.indexOf(index)
    if index == nil or not hero_red_limit_size._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/hero_red_limit_size.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/hero_red_limit_size.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/hero_red_limit_size.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "hero_red_limit_size" )
                _isDataExist = hero_red_limit_size.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "hero_red_limit_size" )
                _isBaseExist = hero_red_limit_size.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "hero_red_limit_size" )
                _isExist = hero_red_limit_size.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "hero_red_limit_size" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id_limit_red_level"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "hero_red_limit_size" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id_limit_red_level"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = hero_red_limit_size._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "hero_red_limit_size" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function hero_red_limit_size.get(id,limit_red_level)
    
    local k = id .. '_' .. limit_red_level
    return hero_red_limit_size.indexOf(__index_id_limit_red_level[k])
        
end

--
function hero_red_limit_size.set(id,limit_red_level, key, value)
    local record = hero_red_limit_size.get(id,limit_red_level)
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
function hero_red_limit_size.index()
    return __index_id_limit_red_level
end

return hero_red_limit_size