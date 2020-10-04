--goldenhero_draw

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  drop_id = 1,    --抽奖库-int 
  type = 2,    --奖品类型-int 
  value = 3,    --奖品类型值-int 
  size = 4,    --奖品数量-int 
  group = 5,    --奖品组数-int 

}

-- key type
local __key_type = {
  drop_id = "int",    --抽奖库-1 
  type = "int",    --奖品类型-2 
  value = "int",    --奖品类型值-3 
  size = "int",    --奖品数量-4 
  group = "int",    --奖品组数-5 

}


-- data
local goldenhero_draw = {
    _data = {
        [1] = {1101,1,150,1,5,},
        [2] = {1102,6,701,5,20,},
        [3] = {1103,6,555,12,10,},
        [4] = {1104,6,556,12,10,},
        [5] = {1105,6,555,12,10,},
        [6] = {1106,1,250,1,5,},
        [7] = {1107,1,350,1,5,},
        [8] = {1108,6,702,5,20,},
        [9] = {1109,6,556,12,10,},
        [10] = {1110,1,450,1,5,},
        [11] = {1111,6,704,5,20,},
        [12] = {1112,1,150,1,5,},
        [13] = {1113,6,157,1,10,},
        [14] = {1114,1,250,1,5,},
        [15] = {1115,6,157,1,10,},
        [16] = {1116,1,350,1,5,},
        [17] = {1117,6,703,5,20,},
        [18] = {1118,1,450,1,5,},
        [19] = {1119,6,555,12,10,},
        [20] = {1120,1,250,1,5,},
        [21] = {1121,6,702,5,20,},
        [22] = {1122,1,350,1,5,},
        [23] = {1123,6,556,12,10,},
        [24] = {1124,1,450,1,5,},
        [25] = {1125,1,150,1,5,},
        [26] = {1126,6,704,5,20,},
        [27] = {1127,6,703,5,20,},
        [28] = {1128,1,250,1,5,},
        [29] = {1129,6,701,5,20,},
        [30] = {1130,1,350,1,5,},
        [31] = {1131,6,157,1,10,},
        [32] = {1132,1,450,1,5,},
        [33] = {1133,6,157,1,10,},
        [34] = {1134,1,150,1,5,},
    }
}

-- index
local __index_drop_id = {
    [1101] = 1,
    [1102] = 2,
    [1103] = 3,
    [1104] = 4,
    [1105] = 5,
    [1106] = 6,
    [1107] = 7,
    [1108] = 8,
    [1109] = 9,
    [1110] = 10,
    [1111] = 11,
    [1112] = 12,
    [1113] = 13,
    [1114] = 14,
    [1115] = 15,
    [1116] = 16,
    [1117] = 17,
    [1118] = 18,
    [1119] = 19,
    [1120] = 20,
    [1121] = 21,
    [1122] = 22,
    [1123] = 23,
    [1124] = 24,
    [1125] = 25,
    [1126] = 26,
    [1127] = 27,
    [1128] = 28,
    [1129] = 29,
    [1130] = 30,
    [1131] = 31,
    [1132] = 32,
    [1133] = 33,
    [1134] = 34,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in goldenhero_draw")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function goldenhero_draw.length()
    return #goldenhero_draw._data
end

-- 
function goldenhero_draw.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function goldenhero_draw.indexOf(index)
    if index == nil or not goldenhero_draw._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/goldenhero_draw.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "goldenhero_draw" )
        return setmetatable({_raw = goldenhero_draw._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = goldenhero_draw._data[index]}, mt)
end

--
function goldenhero_draw.get(drop_id)
    
    return goldenhero_draw.indexOf(__index_drop_id[drop_id])
        
end

--
function goldenhero_draw.set(drop_id, key, value)
    local record = goldenhero_draw.get(drop_id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function goldenhero_draw.index()
    return __index_drop_id
end

return goldenhero_draw