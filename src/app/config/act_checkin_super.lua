--act_checkin_super

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  level = 1,    --等级-int 
  type_1 = 2,    --类型1-int 
  value_1 = 3,    --类型值1-int 
  size_1 = 4,    --数量1-int 
  type_2 = 5,    --类型2-int 
  value_2 = 6,    --类型值2-int 
  size_2 = 7,    --数量2-int 
  type_3 = 8,    --类型3-int 
  value_3 = 9,    --类型值3-int 
  size_3 = 10,    --数量3-int 
  type_4 = 11,    --类型4-int 
  value_4 = 12,    --类型值4-int 
  size_4 = 13,    --数量4-int 
  type_5 = 14,    --类型5-int 
  value_5 = 15,    --类型值5-int 
  size_5 = 16,    --数量5-int 
  type_6 = 17,    --类型6-int 
  value_6 = 18,    --类型值6-int 
  size_6 = 19,    --数量6-int 
  type_7 = 20,    --类型7-int 
  value_7 = 21,    --类型值7-int 
  size_7 = 22,    --数量7-int 
  type_8 = 23,    --类型8-int 
  value_8 = 24,    --类型值8-int 
  size_8 = 25,    --数量8-int 
  type_9 = 26,    --类型9-int 
  value_9 = 27,    --类型值9-int 
  size_9 = 28,    --数量9-int 

}

-- key type
local __key_type = {
  level = "int",    --等级-1 
  type_1 = "int",    --类型1-2 
  value_1 = "int",    --类型值1-3 
  size_1 = "int",    --数量1-4 
  type_2 = "int",    --类型2-5 
  value_2 = "int",    --类型值2-6 
  size_2 = "int",    --数量2-7 
  type_3 = "int",    --类型3-8 
  value_3 = "int",    --类型值3-9 
  size_3 = "int",    --数量3-10 
  type_4 = "int",    --类型4-11 
  value_4 = "int",    --类型值4-12 
  size_4 = "int",    --数量4-13 
  type_5 = "int",    --类型5-14 
  value_5 = "int",    --类型值5-15 
  size_5 = "int",    --数量5-16 
  type_6 = "int",    --类型6-17 
  value_6 = "int",    --类型值6-18 
  size_6 = "int",    --数量6-19 
  type_7 = "int",    --类型7-20 
  value_7 = "int",    --类型值7-21 
  size_7 = "int",    --数量7-22 
  type_8 = "int",    --类型8-23 
  value_8 = "int",    --类型值8-24 
  size_8 = "int",    --数量8-25 
  type_9 = "int",    --类型9-26 
  value_9 = "int",    --类型值9-27 
  size_9 = "int",    --数量9-28 

}


-- data
local act_checkin_super = {
    version =  1,
    _data = {
        [1] = {50,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [2] = {51,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [3] = {52,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [4] = {53,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [5] = {54,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [6] = {55,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [7] = {56,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [8] = {57,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [9] = {58,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [10] = {59,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [11] = {60,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [12] = {61,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [13] = {62,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [14] = {63,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [15] = {64,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [16] = {65,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [17] = {66,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [18] = {67,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [19] = {68,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [20] = {69,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [21] = {70,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [22] = {71,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [23] = {72,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [24] = {73,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [25] = {74,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [26] = {75,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [27] = {76,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [28] = {77,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [29] = {78,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [30] = {79,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [31] = {80,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [32] = {81,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [33] = {82,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [34] = {83,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [35] = {84,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,0,0,0,0,0,0,0,0,0,},
        [36] = {85,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [37] = {86,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [38] = {87,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [39] = {88,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [40] = {89,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [41] = {90,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [42] = {91,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [43] = {92,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [44] = {93,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [45] = {94,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [46] = {95,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [47] = {96,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [48] = {97,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [49] = {98,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [50] = {99,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [51] = {100,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [52] = {101,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [53] = {102,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [54] = {103,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [55] = {104,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [56] = {105,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [57] = {106,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [58] = {107,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [59] = {108,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [60] = {109,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [61] = {110,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [62] = {111,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [63] = {112,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [64] = {113,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [65] = {114,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [66] = {115,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [67] = {116,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [68] = {117,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [69] = {118,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [70] = {119,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
        [71] = {120,6,63,50,6,73,40,6,5,50,6,3,500,6,19,500,6,10,50,6,40,500,0,0,0,0,0,0,},
    }
}

-- index
local __index_level = {
    [100] = 51,
    [101] = 52,
    [102] = 53,
    [103] = 54,
    [104] = 55,
    [105] = 56,
    [106] = 57,
    [107] = 58,
    [108] = 59,
    [109] = 60,
    [110] = 61,
    [111] = 62,
    [112] = 63,
    [113] = 64,
    [114] = 65,
    [115] = 66,
    [116] = 67,
    [117] = 68,
    [118] = 69,
    [119] = 70,
    [120] = 71,
    [50] = 1,
    [51] = 2,
    [52] = 3,
    [53] = 4,
    [54] = 5,
    [55] = 6,
    [56] = 7,
    [57] = 8,
    [58] = 9,
    [59] = 10,
    [60] = 11,
    [61] = 12,
    [62] = 13,
    [63] = 14,
    [64] = 15,
    [65] = 16,
    [66] = 17,
    [67] = 18,
    [68] = 19,
    [69] = 20,
    [70] = 21,
    [71] = 22,
    [72] = 23,
    [73] = 24,
    [74] = 25,
    [75] = 26,
    [76] = 27,
    [77] = 28,
    [78] = 29,
    [79] = 30,
    [80] = 31,
    [81] = 32,
    [82] = 33,
    [83] = 34,
    [84] = 35,
    [85] = 36,
    [86] = 37,
    [87] = 38,
    [88] = 39,
    [89] = 40,
    [90] = 41,
    [91] = 42,
    [92] = 43,
    [93] = 44,
    [94] = 45,
    [95] = 46,
    [96] = 47,
    [97] = 48,
    [98] = 49,
    [99] = 50,

}

-- index mainkey map
local __main_key_map = {
    [51] = 100,
    [52] = 101,
    [53] = 102,
    [54] = 103,
    [55] = 104,
    [56] = 105,
    [57] = 106,
    [58] = 107,
    [59] = 108,
    [60] = 109,
    [61] = 110,
    [62] = 111,
    [63] = 112,
    [64] = 113,
    [65] = 114,
    [66] = 115,
    [67] = 116,
    [68] = 117,
    [69] = 118,
    [70] = 119,
    [71] = 120,
    [1] = 50,
    [2] = 51,
    [3] = 52,
    [4] = 53,
    [5] = 54,
    [6] = 55,
    [7] = 56,
    [8] = 57,
    [9] = 58,
    [10] = 59,
    [11] = 60,
    [12] = 61,
    [13] = 62,
    [14] = 63,
    [15] = 64,
    [16] = 65,
    [17] = 66,
    [18] = 67,
    [19] = 68,
    [20] = 69,
    [21] = 70,
    [22] = 71,
    [23] = 72,
    [24] = 73,
    [25] = 74,
    [26] = 75,
    [27] = 76,
    [28] = 77,
    [29] = 78,
    [30] = 79,
    [31] = 80,
    [32] = 81,
    [33] = 82,
    [34] = 83,
    [35] = 84,
    [36] = 85,
    [37] = 86,
    [38] = 87,
    [39] = 88,
    [40] = 89,
    [41] = 90,
    [42] = 91,
    [43] = 92,
    [44] = 93,
    [45] = 94,
    [46] = 95,
    [47] = 96,
    [48] = 97,
    [49] = 98,
    [50] = 99,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in act_checkin_super")
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
function act_checkin_super.length()
    return #act_checkin_super._data
end

-- 
function act_checkin_super.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_checkin_super.isVersionValid(v)
    if act_checkin_super.version then
        if v then
            return act_checkin_super.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function act_checkin_super.indexOf(index)
    if index == nil or not act_checkin_super._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/act_checkin_super.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/act_checkin_super.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/act_checkin_super.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "act_checkin_super" )
                _isDataExist = act_checkin_super.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "act_checkin_super" )
                _isBaseExist = act_checkin_super.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "act_checkin_super" )
                _isExist = act_checkin_super.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "act_checkin_super" )
        local main_key = __main_key_map[index]
		local index_key = "__index_level"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_checkin_super" )
        local main_key = __main_key_map[index]
		local index_key = "__index_level"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = act_checkin_super._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "act_checkin_super" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function act_checkin_super.get(level)
    
    return act_checkin_super.indexOf(__index_level[level])
        
end

--
function act_checkin_super.set(level, key, value)
    local record = act_checkin_super.get(level)
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
function act_checkin_super.index()
    return __index_level
end

return act_checkin_super