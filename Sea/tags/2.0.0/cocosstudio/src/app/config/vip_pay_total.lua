--vip_pay_total

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  pay_id = 2,    --充值表ID-int 
  total_value = 3,    --累充值-int 
  is_work = 4,    --生效-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  pay_id = "int",    --充值表ID-2 
  total_value = "int",    --累充值-3 
  is_work = "int",    --生效-4 

}


-- data
local vip_pay_total = {
    _data = {
        [1] = {1,10001,1,1,},
        [2] = {2,10002,1,1,},
        [3] = {3,10003,1,1,},
        [4] = {4,10004,1,1,},
        [5] = {5,10005,1,1,},
        [6] = {6,10006,1,1,},
        [7] = {7,10007,1,1,},
        [8] = {8,10008,1,1,},
        [9] = {9,10021,1,1,},
        [10] = {10,10022,1,1,},
        [11] = {11,10023,1,1,},
        [12] = {12,10024,1,1,},
        [13] = {13,10025,1,1,},
        [14] = {14,10026,1,1,},
        [15] = {15,10027,1,1,},
        [16] = {16,10028,1,1,},
        [17] = {17,10029,1,1,},
        [18] = {18,10030,1,1,},
        [19] = {19,10031,1,1,},
        [20] = {20,10032,1,1,},
        [21] = {21,10033,1,1,},
        [22] = {22,10034,1,1,},
        [23] = {23,10035,1,1,},
        [24] = {24,10036,1,1,},
        [25] = {25,10037,1,1,},
        [26] = {26,10038,1,1,},
        [27] = {27,10039,1,1,},
        [28] = {28,10040,1,1,},
        [29] = {29,10041,1,1,},
        [30] = {30,10042,1,1,},
        [31] = {31,10043,1,1,},
        [32] = {32,10044,1,1,},
        [33] = {33,10045,1,1,},
        [34] = {34,10046,1,1,},
        [35] = {35,10047,1,1,},
        [36] = {36,10048,1,1,},
        [37] = {37,10049,1,1,},
        [38] = {38,10050,1,1,},
        [39] = {39,10051,1,1,},
        [40] = {40,10052,1,1,},
        [41] = {41,10053,1,1,},
        [42] = {42,10054,1,1,},
        [43] = {43,10055,1,1,},
        [44] = {44,10056,1,1,},
        [45] = {45,10057,1,1,},
        [46] = {46,10058,1,1,},
        [47] = {47,10059,1,1,},
        [48] = {48,10060,1,1,},
        [49] = {49,10061,1,1,},
        [50] = {50,10062,1,1,},
        [51] = {51,10063,1,1,},
        [52] = {52,10064,1,1,},
        [53] = {53,10065,1,1,},
        [54] = {54,10066,1,1,},
        [55] = {55,10067,1,1,},
        [56] = {56,10068,1,1,},
        [57] = {57,10069,1,1,},
        [58] = {58,10070,1,1,},
        [59] = {59,10071,1,1,},
        [60] = {60,10072,1,1,},
        [61] = {61,10073,1,1,},
        [62] = {62,10074,1,1,},
        [63] = {63,10075,1,1,},
        [64] = {64,10076,1,1,},
        [65] = {65,10077,1,1,},
        [66] = {66,10078,1,1,},
        [67] = {67,10079,1,1,},
        [68] = {68,30001,1,1,},
        [69] = {69,30002,1,1,},
        [70] = {70,30003,1,1,},
        [71] = {71,30004,1,1,},
        [72] = {72,30005,1,1,},
        [73] = {73,30006,1,1,},
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
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in vip_pay_total")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function vip_pay_total.length()
    return #vip_pay_total._data
end

-- 
function vip_pay_total.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function vip_pay_total.indexOf(index)
    if index == nil or not vip_pay_total._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/vip_pay_total.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "vip_pay_total" )
        return setmetatable({_raw = vip_pay_total._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = vip_pay_total._data[index]}, mt)
end

--
function vip_pay_total.get(id)
    
    return vip_pay_total.indexOf(__index_id[id])
        
end

--
function vip_pay_total.set(id, key, value)
    local record = vip_pay_total.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function vip_pay_total.index()
    return __index_id
end

return vip_pay_total