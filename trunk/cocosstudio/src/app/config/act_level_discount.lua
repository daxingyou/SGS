--act_level_discount

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  condition = 2,    --解锁条件-int 
  require_value = 3,    --条件类型值-int 
  fun_id = 4,    --功能图标id-int 
  time_limit = 5,    --时间限制-int 
  good_id = 6,    --商品id-int 
  good_name = 7,    --商品名称-string 
  rebate_res = 8,    --返利比配置-string 
  type = 9,    --物品类型-int 
  value = 10,    --类型值-int 
  size = 11,    --数量-int 
  type2 = 12,    --物品类型2-int 
  value2 = 13,    --类型值2-int 
  size2 = 14,    --数量2-int 
  type3 = 15,    --物品类型3-int 
  value3 = 16,    --类型值3-int 
  size3 = 17,    --数量3-int 
  is_work = 18,    --是否生效-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  condition = "int",    --解锁条件-2 
  require_value = "int",    --条件类型值-3 
  fun_id = "int",    --功能图标id-4 
  time_limit = "int",    --时间限制-5 
  good_id = "int",    --商品id-6 
  good_name = "string",    --商品名称-7 
  rebate_res = "string",    --返利比配置-8 
  type = "int",    --物品类型-9 
  value = "int",    --类型值-10 
  size = "int",    --数量-11 
  type2 = "int",    --物品类型2-12 
  value2 = "int",    --类型值2-13 
  size2 = "int",    --数量2-14 
  type3 = "int",    --物品类型3-15 
  value3 = "int",    --类型值3-16 
  size3 = "int",    --数量3-17 
  is_work = "int",    --是否生效-18 

}


-- data
local act_level_discount = {
    version =  1,
    _data = {
        [1] = {1,1,30,3104,8,11001,"#num#级礼包","500",5,1,60,6,2,5,6,1,5,1,},
        [2] = {2,1,35,3104,8,11002,"#num#级礼包","750",5,1,305,6,109,1,0,0,0,1,},
        [3] = {3,1,40,3104,8,11003,"#num#级礼包","900",5,1,305,6,14,50,0,0,0,1,},
        [4] = {4,1,46,3104,8,11004,"#num#级礼包","900",5,1,305,6,107,3,6,19,1000,1,},
        [5] = {5,1,50,3104,8,11005,"#num#级礼包","750",5,1,610,6,109,2,0,0,0,1,},
        [6] = {6,1,58,3104,8,11006,"#num#级礼包","1000",5,1,305,11,1220,1,0,0,0,1,},
        [7] = {7,1,58,3104,8,11007,"#num#级礼包","1000",5,1,305,11,1221,1,0,0,0,1,},
        [8] = {8,1,58,3104,8,11008,"#num#级礼包","300",5,1,2870,11,1301,1,0,0,0,1,},
        [9] = {9,1,70,3104,8,11009,"#num#级礼包","600",5,1,6000,6,148,1,0,0,0,1,},
        [10] = {10,1,75,3104,8,11010,"#num#级礼包","1100",5,1,185,6,41,2,0,0,0,1,},
        [11] = {11,1,83,3104,8,11011,"#num#级礼包","500",5,1,1840,6,705,2,5,30,1000,1,},
        [12] = {12,1,85,3104,8,11012,"#num#级礼包","650",5,1,920,6,146,6,0,0,0,1,},
        [13] = {13,1,88,3104,8,11013,"#num#级礼包","650",5,1,920,6,146,6,0,0,0,1,},
        [14] = {14,1,90,3104,8,11014,"#num#级礼包","600",5,1,6000,6,158,1,0,0,0,1,},
        [15] = {15,1,95,3104,8,11015,"#num#级礼包","500",5,1,1840,6,705,2,5,30,1000,1,},
        [16] = {16,1,100,3104,8,11016,"#num#级礼包","650",5,1,920,6,146,6,0,0,0,1,},
        [17] = {17,1,102,3104,8,11017,"#num#级礼包","650",5,1,920,6,146,6,0,0,0,1,},
        [18] = {18,1,104,3104,8,11018,"#num#级礼包","500",5,1,1840,6,705,2,5,30,1000,1,},
        [19] = {19,1,106,3104,8,11019,"#num#级礼包","650",5,1,920,6,146,6,0,0,0,1,},
        [20] = {20,1,108,3104,8,11020,"#num#级礼包","650",5,1,920,6,146,6,0,0,0,1,},
        [21] = {21,2,4,3105,8,12001,"主线#num#关礼包","1000",5,1,305,6,7,10,0,0,0,1,},
        [22] = {22,2,8,3105,8,12002,"主线#num#关礼包","500",5,1,920,6,105,1,0,0,0,1,},
        [23] = {23,2,12,3105,8,12003,"主线#num#关礼包","1000",5,1,305,6,7,10,0,0,0,1,},
        [24] = {24,2,14,3105,8,12004,"主线#num#关礼包","700",5,1,610,6,10002,1,5,10,800,1,},
        [25] = {25,2,16,3105,8,12005,"主线#num#关礼包","500",5,1,920,6,105,1,0,0,0,1,},
        [26] = {26,2,20,3105,8,12006,"主线#num#关礼包","700",5,1,610,6,10002,1,5,10,800,1,},
        [27] = {27,2,24,3105,8,12007,"主线#num#关礼包","1000",5,1,305,6,7,10,0,0,0,1,},
        [28] = {28,2,26,3105,8,12008,"主线#num#关礼包","600",5,1,920,6,10003,1,0,0,0,1,},
        [29] = {29,2,30,3105,8,12009,"主线#num#关礼包","1100",5,1,305,6,80,6,6,19,200,1,},
        [30] = {30,2,34,3105,8,12010,"主线#num#关礼包","1100",5,1,305,6,80,6,6,19,200,1,},
        [31] = {31,2,38,3105,8,12011,"主线#num#关礼包","500",5,1,920,6,105,1,0,0,0,1,},
        [32] = {32,2,40,3105,8,12012,"主线#num#关礼包","750",5,1,1840,6,10004,1,0,0,0,1,},
        [33] = {33,2,42,3105,8,12013,"主线#num#关礼包","1000",5,1,305,11,1205,1,0,0,0,1,},
        [34] = {34,2,45,3105,8,12014,"主线#num#关礼包","500",5,1,2870,6,110,1,6,108,2,1,},
        [35] = {35,2,48,3105,8,12015,"主线#num#关礼包","1100",5,1,305,6,80,6,6,19,200,1,},
        [36] = {36,2,50,3105,8,12016,"主线#num#关礼包","900",5,1,920,6,81,6,6,19,200,1,},
        [37] = {37,2,55,3105,8,12017,"主线#num#关礼包","1100",5,1,920,6,80,18,6,19,500,1,},
        [38] = {38,2,60,3105,8,12018,"主线#num#关礼包","500",5,1,2870,6,110,1,6,81,2,1,},
        [39] = {39,2,65,3105,8,12019,"主线#num#关礼包","900",5,1,920,6,81,6,6,19,200,1,},
        [40] = {40,2,70,3105,8,12020,"主线#num#关礼包","500",5,1,2870,6,110,1,6,81,2,1,},
        [41] = {41,2,75,3105,8,12021,"主线#num#关礼包","900",5,1,920,6,81,6,6,19,200,1,},
        [42] = {42,2,80,3105,8,12022,"主线#num#关礼包","650",5,1,920,6,146,6,0,0,0,1,},
        [43] = {43,3,6,3106,8,13001,"游历#num#关礼包","750",5,1,305,6,109,1,0,0,0,1,},
        [44] = {44,3,8,3106,8,13002,"游历#num#关礼包","750",5,1,185,6,73,50,0,0,0,1,},
        [45] = {45,3,10,3106,8,13003,"游历#num#关礼包","750",5,1,305,6,109,1,0,0,0,1,},
        [46] = {46,3,12,3106,8,13004,"游历#num#关礼包","750",5,1,305,6,109,1,0,0,0,1,},
        [47] = {47,3,14,3106,8,13005,"游历#num#关礼包","750",5,1,610,6,109,2,0,0,0,1,},
        [48] = {48,3,16,3106,8,13006,"游历#num#关礼包","750",5,1,610,6,109,2,0,0,0,1,},
        [49] = {49,3,18,3106,8,13007,"游历#num#关礼包","750",5,1,610,6,109,2,0,0,0,1,},
        [50] = {50,3,20,3106,8,13008,"游历#num#关礼包","750",5,1,610,6,109,2,0,0,0,1,},
        [51] = {51,3,22,3106,8,13009,"游历#num#关礼包","750",5,1,610,6,109,2,0,0,0,1,},
        [52] = {52,3,24,3106,8,13010,"游历#num#关礼包","750",5,1,920,6,109,3,0,0,0,1,},
        [53] = {53,4,160000,3105,8,14001,"战力冲刺礼包","300",5,1,305,6,23,2,5,2,100000,1,},
        [54] = {54,4,320000,3105,8,14002,"战力冲刺礼包","300",5,1,490,6,23,4,0,0,0,1,},
        [55] = {55,4,1600000,3105,8,14003,"战力冲刺礼包","300",5,1,920,6,24,4,0,0,0,1,},
        [56] = {56,4,4800000,3105,8,14004,"战力冲刺礼包","300",5,1,920,6,24,4,0,0,0,1,},
        [57] = {57,4,10800000,3105,8,14005,"战力冲刺礼包","300",5,1,1840,6,25,4,0,0,0,1,},
        [58] = {58,4,18000000,3105,8,14006,"战力冲刺礼包","300",5,1,1840,6,25,4,0,0,0,1,},
        [59] = {59,4,27000000,3105,8,14007,"战力冲刺礼包","300",5,1,4500,6,26,4,0,0,0,1,},
        [60] = {60,4,45000000,3105,8,14008,"战力冲刺礼包","300",5,1,4500,6,26,4,0,0,0,1,},
        [61] = {61,4,60000000,3105,8,14009,"战力冲刺礼包","500",5,1,6000,6,27,5,0,0,0,1,},
        [62] = {62,4,81000000,3105,8,14010,"战力冲刺礼包","500",5,1,6000,6,27,5,0,0,0,1,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
    [22] = 22,
    [23] = 23,
    [24] = 24,
    [25] = 25,
    [26] = 26,
    [27] = 27,
    [28] = 28,
    [29] = 29,
    [3] = 3,
    [30] = 30,
    [31] = 31,
    [32] = 32,
    [33] = 33,
    [34] = 34,
    [35] = 35,
    [36] = 36,
    [37] = 37,
    [38] = 38,
    [39] = 39,
    [4] = 4,
    [40] = 40,
    [41] = 41,
    [42] = 42,
    [43] = 43,
    [44] = 44,
    [45] = 45,
    [46] = 46,
    [47] = 47,
    [48] = 48,
    [49] = 49,
    [5] = 5,
    [50] = 50,
    [51] = 51,
    [52] = 52,
    [53] = 53,
    [54] = 54,
    [55] = 55,
    [56] = 56,
    [57] = 57,
    [58] = 58,
    [59] = 59,
    [6] = 6,
    [60] = 60,
    [61] = 61,
    [62] = 62,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
    [22] = 22,
    [23] = 23,
    [24] = 24,
    [25] = 25,
    [26] = 26,
    [27] = 27,
    [28] = 28,
    [29] = 29,
    [3] = 3,
    [30] = 30,
    [31] = 31,
    [32] = 32,
    [33] = 33,
    [34] = 34,
    [35] = 35,
    [36] = 36,
    [37] = 37,
    [38] = 38,
    [39] = 39,
    [4] = 4,
    [40] = 40,
    [41] = 41,
    [42] = 42,
    [43] = 43,
    [44] = 44,
    [45] = 45,
    [46] = 46,
    [47] = 47,
    [48] = 48,
    [49] = 49,
    [5] = 5,
    [50] = 50,
    [51] = 51,
    [52] = 52,
    [53] = 53,
    [54] = 54,
    [55] = 55,
    [56] = 56,
    [57] = 57,
    [58] = 58,
    [59] = 59,
    [6] = 6,
    [60] = 60,
    [61] = 61,
    [62] = 62,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in act_level_discount")
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
function act_level_discount.length()
    return #act_level_discount._data
end

-- 
function act_level_discount.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_level_discount.isVersionValid(v)
    if act_level_discount.version then
        if v then
            return act_level_discount.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function act_level_discount.indexOf(index)
    if index == nil or not act_level_discount._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/act_level_discount.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/act_level_discount.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/act_level_discount.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "act_level_discount" )
                _isDataExist = act_level_discount.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "act_level_discount" )
                _isBaseExist = act_level_discount.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "act_level_discount" )
                _isExist = act_level_discount.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "act_level_discount" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_level_discount" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = act_level_discount._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "act_level_discount" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function act_level_discount.get(id)
    
    return act_level_discount.indexOf(__index_id[id])
        
end

--
function act_level_discount.set(id, key, value)
    local record = act_level_discount.get(id)
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
function act_level_discount.index()
    return __index_id
end

return act_level_discount