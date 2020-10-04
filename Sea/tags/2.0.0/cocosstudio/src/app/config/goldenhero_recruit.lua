--goldenhero_recruit

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  order = 1,    --排序-int 
  hero = 2,    --金将id-int 

}

-- key type
local __key_type = {
  order = "int",    --排序-1 
  hero = "int",    --金将id-2 

}


-- data
local goldenhero_recruit = {
    _data = {
        [1] = {1,150,},
        [2] = {2,150,},
        [3] = {3,150,},
        [4] = {4,150,},
        [5] = {5,150,},
        [6] = {6,150,},
        [7] = {7,150,},
        [8] = {8,150,},
        [9] = {9,150,},
        [10] = {10,150,},
        [11] = {11,150,},
        [12] = {12,150,},
        [13] = {13,150,},
        [14] = {14,150,},
        [15] = {15,150,},
        [16] = {16,150,},
        [17] = {17,150,},
        [18] = {18,150,},
        [19] = {19,150,},
        [20] = {20,150,},
        [21] = {21,150,},
        [22] = {22,250,},
        [23] = {23,250,},
        [24] = {24,250,},
        [25] = {25,250,},
        [26] = {26,250,},
        [27] = {27,250,},
        [28] = {28,250,},
        [29] = {29,250,},
        [30] = {30,250,},
        [31] = {31,250,},
        [32] = {32,250,},
        [33] = {33,250,},
        [34] = {34,250,},
        [35] = {35,250,},
        [36] = {36,250,},
        [37] = {37,250,},
        [38] = {38,250,},
        [39] = {39,250,},
        [40] = {40,250,},
        [41] = {41,250,},
        [42] = {42,250,},
        [43] = {43,350,},
        [44] = {44,350,},
        [45] = {45,350,},
        [46] = {46,350,},
        [47] = {47,350,},
        [48] = {48,350,},
        [49] = {49,350,},
        [50] = {50,350,},
        [51] = {51,350,},
        [52] = {52,350,},
        [53] = {53,350,},
        [54] = {54,350,},
        [55] = {55,350,},
        [56] = {56,350,},
        [57] = {57,350,},
        [58] = {58,350,},
        [59] = {59,350,},
        [60] = {60,350,},
        [61] = {61,350,},
        [62] = {62,350,},
        [63] = {63,350,},
        [64] = {64,450,},
        [65] = {65,450,},
        [66] = {66,450,},
        [67] = {67,450,},
        [68] = {68,450,},
        [69] = {69,450,},
        [70] = {70,450,},
        [71] = {71,450,},
        [72] = {72,450,},
        [73] = {73,450,},
        [74] = {74,450,},
        [75] = {75,450,},
        [76] = {76,450,},
        [77] = {77,450,},
        [78] = {78,450,},
        [79] = {79,450,},
        [80] = {80,450,},
        [81] = {81,450,},
        [82] = {82,450,},
        [83] = {83,450,},
        [84] = {84,450,},
    }
}

-- index
local __index_order = {
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
    [63] = 63,
    [64] = 64,
    [65] = 65,
    [66] = 66,
    [67] = 67,
    [68] = 68,
    [69] = 69,
    [7] = 7,
    [70] = 70,
    [71] = 71,
    [72] = 72,
    [73] = 73,
    [74] = 74,
    [75] = 75,
    [76] = 76,
    [77] = 77,
    [78] = 78,
    [79] = 79,
    [8] = 8,
    [80] = 80,
    [81] = 81,
    [82] = 82,
    [83] = 83,
    [84] = 84,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in goldenhero_recruit")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function goldenhero_recruit.length()
    return #goldenhero_recruit._data
end

-- 
function goldenhero_recruit.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function goldenhero_recruit.indexOf(index)
    if index == nil or not goldenhero_recruit._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/goldenhero_recruit.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "goldenhero_recruit" )
        return setmetatable({_raw = goldenhero_recruit._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = goldenhero_recruit._data[index]}, mt)
end

--
function goldenhero_recruit.get(order)
    
    return goldenhero_recruit.indexOf(__index_order[order])
        
end

--
function goldenhero_recruit.set(order, key, value)
    local record = goldenhero_recruit.get(order)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function goldenhero_recruit.index()
    return __index_order
end

return goldenhero_recruit