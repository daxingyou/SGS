--guild_cross_war_auction_content

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  reward_id = 2,    --奖励组id-int 
  auction_full_tab = 3,    --所属全服拍卖页签-int 
  group = 4,    --掉落组-int 
  produce_number1 = 5,    --掉落数量*1000（实际掉落程序除以1000再计算）-int 
  order = 6,    --排序-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  reward_id = "int",    --奖励组id-2 
  auction_full_tab = "int",    --所属全服拍卖页签-3 
  group = "int",    --掉落组-4 
  produce_number1 = "int",    --掉落数量*1000（实际掉落程序除以1000再计算）-5 
  order = "int",    --排序-6 

}


-- data
local guild_cross_war_auction_content = {
    version =  1,
    _data = {
        [1] = {1,101,5,1,1500,1,},
        [2] = {2,102,5,1,1430,1,},
        [3] = {3,103,5,1,1350,1,},
        [4] = {4,104,5,1,1280,1,},
        [5] = {5,105,5,1,1200,1,},
        [6] = {6,106,5,1,1130,1,},
        [7] = {7,107,5,1,1050,1,},
        [8] = {8,108,5,1,980,1,},
        [9] = {9,109,5,1,900,1,},
        [10] = {10,110,5,1,830,1,},
        [11] = {11,111,5,1,750,1,},
        [12] = {12,112,5,1,640,1,},
        [13] = {13,113,5,1,540,1,},
        [14] = {14,114,5,1,450,1,},
        [15] = {15,115,5,1,360,1,},
        [16] = {16,116,5,1,280,1,},
        [17] = {17,117,5,1,210,1,},
        [18] = {18,118,5,1,0,1,},
        [19] = {19,119,5,1,0,1,},
        [20] = {20,120,5,1,0,1,},
        [21] = {21,121,5,1,0,1,},
        [22] = {64,201,10,2,6000,1,},
        [23] = {65,202,10,2,5700,1,},
        [24] = {66,203,10,2,5400,1,},
        [25] = {67,204,10,2,5100,1,},
        [26] = {68,205,10,2,4800,1,},
        [27] = {69,206,10,2,4500,1,},
        [28] = {70,207,10,2,4200,1,},
        [29] = {71,208,10,2,3900,1,},
        [30] = {72,209,10,2,3600,1,},
        [31] = {73,210,10,2,3300,1,},
        [32] = {74,211,10,2,3000,1,},
        [33] = {75,212,10,2,2600,1,},
        [34] = {76,213,10,2,2200,1,},
        [35] = {77,214,10,2,1800,1,},
        [36] = {78,215,10,2,1400,1,},
        [37] = {79,216,10,2,1100,1,},
        [38] = {80,217,10,2,800,1,},
        [39] = {81,218,10,2,600,1,},
        [40] = {82,219,10,2,0,1,},
        [41] = {83,220,10,2,0,1,},
        [42] = {84,221,10,2,0,1,},
        [43] = {85,301,10,3,5100,1,},
        [44] = {86,302,10,3,4800,1,},
        [45] = {87,303,10,3,4600,1,},
        [46] = {88,304,10,3,4300,1,},
        [47] = {89,305,10,3,4100,1,},
        [48] = {90,306,10,3,3800,1,},
        [49] = {91,307,10,3,3500,1,},
        [50] = {92,308,10,3,3300,1,},
        [51] = {93,309,10,3,3000,1,},
        [52] = {94,310,10,3,2800,1,},
        [53] = {95,311,10,3,2500,1,},
        [54] = {96,312,10,3,2200,1,},
        [55] = {97,313,10,3,1900,1,},
        [56] = {98,314,10,3,1500,1,},
        [57] = {99,315,10,3,1200,1,},
        [58] = {100,316,10,3,900,1,},
        [59] = {101,317,10,3,700,1,},
        [60] = {102,318,10,3,500,1,},
        [61] = {103,319,10,3,0,1,},
        [62] = {104,320,10,3,0,1,},
        [63] = {105,321,10,3,0,1,},
        [64] = {106,401,4,4,3000,1,},
        [65] = {107,402,4,4,2900,1,},
        [66] = {108,403,4,4,2700,1,},
        [67] = {109,404,4,4,2600,1,},
        [68] = {110,405,4,4,2400,1,},
        [69] = {111,406,4,4,2300,1,},
        [70] = {112,407,4,4,2100,1,},
        [71] = {113,408,4,4,2000,1,},
        [72] = {114,409,4,4,1800,1,},
        [73] = {115,410,4,4,1700,1,},
        [74] = {116,411,4,4,1500,1,},
        [75] = {117,412,4,4,1300,1,},
        [76] = {118,413,4,4,1100,1,},
        [77] = {119,414,4,4,900,1,},
        [78] = {120,415,4,4,700,1,},
        [79] = {121,416,4,4,600,1,},
        [80] = {122,417,4,4,400,1,},
        [81] = {123,418,4,4,300,1,},
        [82] = {124,419,4,4,0,1,},
        [83] = {125,420,4,4,0,1,},
        [84] = {126,421,4,4,0,1,},
        [85] = {127,501,6,5,2000,1,},
        [86] = {128,502,6,5,1900,1,},
        [87] = {129,503,6,5,1800,1,},
        [88] = {130,504,6,5,1700,1,},
        [89] = {131,505,6,5,1600,1,},
        [90] = {132,506,6,5,1500,1,},
        [91] = {133,507,6,5,1400,1,},
        [92] = {134,508,6,5,1300,1,},
        [93] = {135,509,6,5,1200,1,},
        [94] = {136,510,6,5,1100,1,},
        [95] = {137,511,6,5,1000,1,},
        [96] = {138,512,6,5,900,1,},
        [97] = {139,513,6,5,800,1,},
        [98] = {140,514,6,5,600,1,},
        [99] = {141,515,6,5,500,1,},
        [100] = {142,516,6,5,400,1,},
        [101] = {143,517,6,5,300,1,},
        [102] = {144,518,6,5,0,1,},
        [103] = {145,519,6,5,0,1,},
        [104] = {146,520,6,5,0,1,},
        [105] = {147,521,6,5,0,1,},
        [106] = {148,601,6,6,5000,1,},
        [107] = {149,602,6,6,4800,1,},
        [108] = {150,603,6,6,4500,1,},
        [109] = {151,604,6,6,4300,1,},
        [110] = {152,605,6,6,4000,1,},
        [111] = {153,606,6,6,3800,1,},
        [112] = {154,607,6,6,3500,1,},
        [113] = {155,608,6,6,3300,1,},
        [114] = {156,609,6,6,3000,1,},
        [115] = {157,610,6,6,2800,1,},
        [116] = {158,611,6,6,2500,1,},
        [117] = {159,612,6,6,2300,1,},
        [118] = {160,613,6,6,1800,1,},
        [119] = {161,614,6,6,1500,1,},
        [120] = {162,615,6,6,1300,1,},
        [121] = {163,616,6,6,1000,1,},
        [122] = {164,617,6,6,800,1,},
        [123] = {165,618,6,6,0,1,},
        [124] = {166,619,6,6,0,1,},
        [125] = {167,620,6,6,0,1,},
        [126] = {168,621,6,6,0,1,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [100] = 58,
    [101] = 59,
    [102] = 60,
    [103] = 61,
    [104] = 62,
    [105] = 63,
    [106] = 64,
    [107] = 65,
    [108] = 66,
    [109] = 67,
    [11] = 11,
    [110] = 68,
    [111] = 69,
    [112] = 70,
    [113] = 71,
    [114] = 72,
    [115] = 73,
    [116] = 74,
    [117] = 75,
    [118] = 76,
    [119] = 77,
    [12] = 12,
    [120] = 78,
    [121] = 79,
    [122] = 80,
    [123] = 81,
    [124] = 82,
    [125] = 83,
    [126] = 84,
    [127] = 85,
    [128] = 86,
    [129] = 87,
    [13] = 13,
    [130] = 88,
    [131] = 89,
    [132] = 90,
    [133] = 91,
    [134] = 92,
    [135] = 93,
    [136] = 94,
    [137] = 95,
    [138] = 96,
    [139] = 97,
    [14] = 14,
    [140] = 98,
    [141] = 99,
    [142] = 100,
    [143] = 101,
    [144] = 102,
    [145] = 103,
    [146] = 104,
    [147] = 105,
    [148] = 106,
    [149] = 107,
    [15] = 15,
    [150] = 108,
    [151] = 109,
    [152] = 110,
    [153] = 111,
    [154] = 112,
    [155] = 113,
    [156] = 114,
    [157] = 115,
    [158] = 116,
    [159] = 117,
    [16] = 16,
    [160] = 118,
    [161] = 119,
    [162] = 120,
    [163] = 121,
    [164] = 122,
    [165] = 123,
    [166] = 124,
    [167] = 125,
    [168] = 126,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [64] = 22,
    [65] = 23,
    [66] = 24,
    [67] = 25,
    [68] = 26,
    [69] = 27,
    [7] = 7,
    [70] = 28,
    [71] = 29,
    [72] = 30,
    [73] = 31,
    [74] = 32,
    [75] = 33,
    [76] = 34,
    [77] = 35,
    [78] = 36,
    [79] = 37,
    [8] = 8,
    [80] = 38,
    [81] = 39,
    [82] = 40,
    [83] = 41,
    [84] = 42,
    [85] = 43,
    [86] = 44,
    [87] = 45,
    [88] = 46,
    [89] = 47,
    [9] = 9,
    [90] = 48,
    [91] = 49,
    [92] = 50,
    [93] = 51,
    [94] = 52,
    [95] = 53,
    [96] = 54,
    [97] = 55,
    [98] = 56,
    [99] = 57,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
    [58] = 100,
    [59] = 101,
    [60] = 102,
    [61] = 103,
    [62] = 104,
    [63] = 105,
    [64] = 106,
    [65] = 107,
    [66] = 108,
    [67] = 109,
    [11] = 11,
    [68] = 110,
    [69] = 111,
    [70] = 112,
    [71] = 113,
    [72] = 114,
    [73] = 115,
    [74] = 116,
    [75] = 117,
    [76] = 118,
    [77] = 119,
    [12] = 12,
    [78] = 120,
    [79] = 121,
    [80] = 122,
    [81] = 123,
    [82] = 124,
    [83] = 125,
    [84] = 126,
    [85] = 127,
    [86] = 128,
    [87] = 129,
    [13] = 13,
    [88] = 130,
    [89] = 131,
    [90] = 132,
    [91] = 133,
    [92] = 134,
    [93] = 135,
    [94] = 136,
    [95] = 137,
    [96] = 138,
    [97] = 139,
    [14] = 14,
    [98] = 140,
    [99] = 141,
    [100] = 142,
    [101] = 143,
    [102] = 144,
    [103] = 145,
    [104] = 146,
    [105] = 147,
    [106] = 148,
    [107] = 149,
    [15] = 15,
    [108] = 150,
    [109] = 151,
    [110] = 152,
    [111] = 153,
    [112] = 154,
    [113] = 155,
    [114] = 156,
    [115] = 157,
    [116] = 158,
    [117] = 159,
    [16] = 16,
    [118] = 160,
    [119] = 161,
    [120] = 162,
    [121] = 163,
    [122] = 164,
    [123] = 165,
    [124] = 166,
    [125] = 167,
    [126] = 168,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [2] = 2,
    [20] = 20,
    [21] = 21,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [22] = 64,
    [23] = 65,
    [24] = 66,
    [25] = 67,
    [26] = 68,
    [27] = 69,
    [7] = 7,
    [28] = 70,
    [29] = 71,
    [30] = 72,
    [31] = 73,
    [32] = 74,
    [33] = 75,
    [34] = 76,
    [35] = 77,
    [36] = 78,
    [37] = 79,
    [8] = 8,
    [38] = 80,
    [39] = 81,
    [40] = 82,
    [41] = 83,
    [42] = 84,
    [43] = 85,
    [44] = 86,
    [45] = 87,
    [46] = 88,
    [47] = 89,
    [9] = 9,
    [48] = 90,
    [49] = 91,
    [50] = 92,
    [51] = 93,
    [52] = 94,
    [53] = 95,
    [54] = 96,
    [55] = 97,
    [56] = 98,
    [57] = 99,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_cross_war_auction_content")
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
function guild_cross_war_auction_content.length()
    return #guild_cross_war_auction_content._data
end

-- 
function guild_cross_war_auction_content.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_cross_war_auction_content.isVersionValid(v)
    if guild_cross_war_auction_content.version then
        if v then
            return guild_cross_war_auction_content.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_cross_war_auction_content.indexOf(index)
    if index == nil or not guild_cross_war_auction_content._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_cross_war_auction_content.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_cross_war_auction_content.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_cross_war_auction_content.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_auction_content" )
                _isDataExist = guild_cross_war_auction_content.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_auction_content" )
                _isBaseExist = guild_cross_war_auction_content.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_auction_content" )
                _isExist = guild_cross_war_auction_content.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_auction_content" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_auction_content" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_cross_war_auction_content._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_auction_content" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_cross_war_auction_content.get(id)
    
    return guild_cross_war_auction_content.indexOf(__index_id[id])
        
end

--
function guild_cross_war_auction_content.set(id, key, value)
    local record = guild_cross_war_auction_content.get(id)
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
function guild_cross_war_auction_content.index()
    return __index_id
end

return guild_cross_war_auction_content