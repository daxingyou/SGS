--cake_rank

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  cake_type = 1,    --活动类型-int 
  id = 2,    --id-int 
  batch = 3,    --批次-int 
  type = 4,    --类型-int 
  rank_max = 5,    --排名上限-int 
  rank_min = 6,    --排名下限-int 
  drop = 7,    --奖励dropid-int 

}

-- key type
local __key_type = {
  cake_type = "int",    --活动类型-1 
  id = "int",    --id-2 
  batch = "int",    --批次-3 
  type = "int",    --类型-4 
  rank_max = "int",    --排名上限-5 
  rank_min = "int",    --排名下限-6 
  drop = "int",    --奖励dropid-7 

}


-- data
local cake_rank = {
    version =  1,
    _data = {
        [1] = {1,1121,1,2,1,1,1001,},
        [2] = {1,1122,1,2,2,2,1002,},
        [3] = {1,1123,1,2,3,3,1003,},
        [4] = {1,1124,1,2,4,50,1004,},
        [5] = {1,1141,1,4,1,1,1021,},
        [6] = {1,1142,1,4,2,2,1022,},
        [7] = {1,1143,1,4,3,3,1023,},
        [8] = {1,1144,1,4,4,10,1024,},
        [9] = {1,11411,1,4,11,20,1025,},
        [10] = {1,11421,1,4,21,30,1026,},
        [11] = {1,11431,1,4,31,50,1027,},
        [12] = {1,1221,2,2,1,1,1001,},
        [13] = {1,1222,2,2,2,2,1002,},
        [14] = {1,1223,2,2,3,3,1003,},
        [15] = {1,1224,2,2,4,50,1004,},
        [16] = {1,1241,2,4,1,1,1021,},
        [17] = {1,1242,2,4,2,2,1022,},
        [18] = {1,1243,2,4,3,3,1023,},
        [19] = {1,1244,2,4,4,10,1024,},
        [20] = {1,12411,2,4,11,20,1025,},
        [21] = {1,12421,2,4,21,30,1026,},
        [22] = {1,12431,2,4,31,50,1027,},
        [23] = {2,2121,1,2,1,1,1005,},
        [24] = {2,2122,1,2,2,2,1006,},
        [25] = {2,2123,1,2,3,3,1007,},
        [26] = {2,2124,1,2,4,50,1008,},
        [27] = {2,2141,1,4,1,1,1028,},
        [28] = {2,2142,1,4,2,2,1029,},
        [29] = {2,2143,1,4,3,3,1030,},
        [30] = {2,2144,1,4,4,10,1031,},
        [31] = {2,21411,1,4,11,20,1032,},
        [32] = {2,21421,1,4,21,30,1033,},
        [33] = {2,21431,1,4,31,50,1034,},
        [34] = {2,2221,2,2,1,1,1005,},
        [35] = {2,2222,2,2,2,2,1006,},
        [36] = {2,2223,2,2,3,3,1007,},
        [37] = {2,2224,2,2,4,50,1008,},
        [38] = {2,2241,2,4,1,1,1028,},
        [39] = {2,2242,2,4,2,2,1029,},
        [40] = {2,2243,2,4,3,3,1030,},
        [41] = {2,2244,2,4,4,10,1031,},
        [42] = {2,22411,2,4,11,20,1032,},
        [43] = {2,22421,2,4,21,30,1033,},
        [44] = {2,22431,2,4,31,50,1034,},
        [45] = {3,3121,1,2,1,1,1009,},
        [46] = {3,3122,1,2,2,2,1010,},
        [47] = {3,3123,1,2,3,3,1011,},
        [48] = {3,3124,1,2,4,50,1012,},
        [49] = {3,3141,1,4,1,1,1035,},
        [50] = {3,3142,1,4,2,2,1036,},
        [51] = {3,3143,1,4,3,3,1037,},
        [52] = {3,3144,1,4,4,10,1038,},
        [53] = {3,31411,1,4,11,20,1039,},
        [54] = {3,31421,1,4,21,30,1040,},
        [55] = {3,31431,1,4,31,50,1041,},
        [56] = {3,3221,2,2,1,1,1009,},
        [57] = {3,3222,2,2,2,2,1010,},
        [58] = {3,3223,2,2,3,3,1011,},
        [59] = {3,3224,2,2,4,50,1012,},
        [60] = {3,3241,2,4,1,1,1035,},
        [61] = {3,3242,2,4,2,2,1036,},
        [62] = {3,3243,2,4,3,3,1037,},
        [63] = {3,3244,2,4,4,10,1038,},
        [64] = {3,32411,2,4,11,20,1039,},
        [65] = {3,32421,2,4,21,30,1040,},
        [66] = {3,32431,2,4,31,50,1041,},
        [67] = {4,4121,1,2,1,1,1013,},
        [68] = {4,4122,1,2,2,2,1014,},
        [69] = {4,4123,1,2,3,3,1015,},
        [70] = {4,4124,1,2,4,50,1016,},
        [71] = {4,4141,1,4,1,1,1042,},
        [72] = {4,4142,1,4,2,2,1043,},
        [73] = {4,4143,1,4,3,3,1044,},
        [74] = {4,4144,1,4,4,10,1045,},
        [75] = {4,41411,1,4,11,20,1046,},
        [76] = {4,41421,1,4,21,30,1047,},
        [77] = {4,41431,1,4,31,50,1048,},
        [78] = {4,4221,2,2,1,1,1013,},
        [79] = {4,4222,2,2,2,2,1014,},
        [80] = {4,4223,2,2,3,3,1015,},
        [81] = {4,4224,2,2,4,50,1016,},
        [82] = {4,4241,2,4,1,1,1042,},
        [83] = {4,4242,2,4,2,2,1043,},
        [84] = {4,4243,2,4,3,3,1044,},
        [85] = {4,4244,2,4,4,10,1045,},
        [86] = {4,42411,2,4,11,20,1046,},
        [87] = {4,42421,2,4,21,30,1047,},
        [88] = {4,42431,2,4,31,50,1048,},
    }
}

-- index
local __index_cake_type_id = {
    ["1_1121"] = 1,
    ["1_1122"] = 2,
    ["1_1123"] = 3,
    ["1_1124"] = 4,
    ["1_1141"] = 5,
    ["1_11411"] = 9,
    ["1_1142"] = 6,
    ["1_11421"] = 10,
    ["1_1143"] = 7,
    ["1_11431"] = 11,
    ["1_1144"] = 8,
    ["1_1221"] = 12,
    ["1_1222"] = 13,
    ["1_1223"] = 14,
    ["1_1224"] = 15,
    ["1_1241"] = 16,
    ["1_12411"] = 20,
    ["1_1242"] = 17,
    ["1_12421"] = 21,
    ["1_1243"] = 18,
    ["1_12431"] = 22,
    ["1_1244"] = 19,
    ["2_2121"] = 23,
    ["2_2122"] = 24,
    ["2_2123"] = 25,
    ["2_2124"] = 26,
    ["2_2141"] = 27,
    ["2_21411"] = 31,
    ["2_2142"] = 28,
    ["2_21421"] = 32,
    ["2_2143"] = 29,
    ["2_21431"] = 33,
    ["2_2144"] = 30,
    ["2_2221"] = 34,
    ["2_2222"] = 35,
    ["2_2223"] = 36,
    ["2_2224"] = 37,
    ["2_2241"] = 38,
    ["2_22411"] = 42,
    ["2_2242"] = 39,
    ["2_22421"] = 43,
    ["2_2243"] = 40,
    ["2_22431"] = 44,
    ["2_2244"] = 41,
    ["3_3121"] = 45,
    ["3_3122"] = 46,
    ["3_3123"] = 47,
    ["3_3124"] = 48,
    ["3_3141"] = 49,
    ["3_31411"] = 53,
    ["3_3142"] = 50,
    ["3_31421"] = 54,
    ["3_3143"] = 51,
    ["3_31431"] = 55,
    ["3_3144"] = 52,
    ["3_3221"] = 56,
    ["3_3222"] = 57,
    ["3_3223"] = 58,
    ["3_3224"] = 59,
    ["3_3241"] = 60,
    ["3_32411"] = 64,
    ["3_3242"] = 61,
    ["3_32421"] = 65,
    ["3_3243"] = 62,
    ["3_32431"] = 66,
    ["3_3244"] = 63,
    ["4_4121"] = 67,
    ["4_4122"] = 68,
    ["4_4123"] = 69,
    ["4_4124"] = 70,
    ["4_4141"] = 71,
    ["4_41411"] = 75,
    ["4_4142"] = 72,
    ["4_41421"] = 76,
    ["4_4143"] = 73,
    ["4_41431"] = 77,
    ["4_4144"] = 74,
    ["4_4221"] = 78,
    ["4_4222"] = 79,
    ["4_4223"] = 80,
    ["4_4224"] = 81,
    ["4_4241"] = 82,
    ["4_42411"] = 86,
    ["4_4242"] = 83,
    ["4_42421"] = 87,
    ["4_4243"] = 84,
    ["4_42431"] = 88,
    ["4_4244"] = 85,

}

-- index mainkey map
local __main_key_map = {
    [1] = "1_1121",
    [2] = "1_1122",
    [3] = "1_1123",
    [4] = "1_1124",
    [5] = "1_1141",
    [9] = "1_11411",
    [6] = "1_1142",
    [10] = "1_11421",
    [7] = "1_1143",
    [11] = "1_11431",
    [8] = "1_1144",
    [12] = "1_1221",
    [13] = "1_1222",
    [14] = "1_1223",
    [15] = "1_1224",
    [16] = "1_1241",
    [20] = "1_12411",
    [17] = "1_1242",
    [21] = "1_12421",
    [18] = "1_1243",
    [22] = "1_12431",
    [19] = "1_1244",
    [23] = "2_2121",
    [24] = "2_2122",
    [25] = "2_2123",
    [26] = "2_2124",
    [27] = "2_2141",
    [31] = "2_21411",
    [28] = "2_2142",
    [32] = "2_21421",
    [29] = "2_2143",
    [33] = "2_21431",
    [30] = "2_2144",
    [34] = "2_2221",
    [35] = "2_2222",
    [36] = "2_2223",
    [37] = "2_2224",
    [38] = "2_2241",
    [42] = "2_22411",
    [39] = "2_2242",
    [43] = "2_22421",
    [40] = "2_2243",
    [44] = "2_22431",
    [41] = "2_2244",
    [45] = "3_3121",
    [46] = "3_3122",
    [47] = "3_3123",
    [48] = "3_3124",
    [49] = "3_3141",
    [53] = "3_31411",
    [50] = "3_3142",
    [54] = "3_31421",
    [51] = "3_3143",
    [55] = "3_31431",
    [52] = "3_3144",
    [56] = "3_3221",
    [57] = "3_3222",
    [58] = "3_3223",
    [59] = "3_3224",
    [60] = "3_3241",
    [64] = "3_32411",
    [61] = "3_3242",
    [65] = "3_32421",
    [62] = "3_3243",
    [66] = "3_32431",
    [63] = "3_3244",
    [67] = "4_4121",
    [68] = "4_4122",
    [69] = "4_4123",
    [70] = "4_4124",
    [71] = "4_4141",
    [75] = "4_41411",
    [72] = "4_4142",
    [76] = "4_41421",
    [73] = "4_4143",
    [77] = "4_41431",
    [74] = "4_4144",
    [78] = "4_4221",
    [79] = "4_4222",
    [80] = "4_4223",
    [81] = "4_4224",
    [82] = "4_4241",
    [86] = "4_42411",
    [83] = "4_4242",
    [87] = "4_42421",
    [84] = "4_4243",
    [88] = "4_42431",
    [85] = "4_4244",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in cake_rank")
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
function cake_rank.length()
    return #cake_rank._data
end

-- 
function cake_rank.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cake_rank.isVersionValid(v)
    if cake_rank.version then
        if v then
            return cake_rank.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cake_rank.indexOf(index)
    if index == nil or not cake_rank._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cake_rank.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cake_rank.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cake_rank.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cake_rank" )
                _isDataExist = cake_rank.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cake_rank" )
                _isBaseExist = cake_rank.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cake_rank" )
                _isExist = cake_rank.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cake_rank" )
        local main_key = __main_key_map[index]
		local index_key = "__index_cake_type_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cake_rank" )
        local main_key = __main_key_map[index]
		local index_key = "__index_cake_type_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cake_rank._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cake_rank" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cake_rank.get(cake_type,id)
    
    local k = cake_type .. '_' .. id
    return cake_rank.indexOf(__index_cake_type_id[k])
        
end

--
function cake_rank.set(cake_type,id, key, value)
    local record = cake_rank.get(cake_type,id)
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
function cake_rank.index()
    return __index_cake_type_id
end

return cake_rank