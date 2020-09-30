--mine_way

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  pit_id = 1,    --矿坑id-int 
  move_pit = 2,    --迁移方向-int 
  mid_point = 3,    --中点-string 

}

-- key type
local __key_type = {
  pit_id = "int",    --矿坑id-1 
  move_pit = "int",    --迁移方向-2 
  mid_point = "string",    --中点-3 

}


-- data
local mine_way = {
    version =  1,
    _data = {
        [1] = {100,201,"1266|626",},
        [2] = {100,101,"1385|749",},
        [3] = {100,301,"1530|624",},
        [4] = {101,100,"1385|749",},
        [5] = {101,102,"1274|833",},
        [6] = {101,104,"1519|823",},
        [7] = {102,101,"1274|833",},
        [8] = {102,103,"1285|877",},
        [9] = {102,105,"998|1001",},
        [10] = {102,204,"1066|666",},
        [11] = {103,102,"1285|877",},
        [12] = {103,107,"1388|1143",},
        [13] = {104,101,"1519|823",},
        [14] = {104,109,"1800|1025",},
        [15] = {104,304,"1700|834",},
        [16] = {105,102,"998|1001",},
        [17] = {105,106,"999|1182",},
        [18] = {106,105,"999|1182",},
        [19] = {106,107,"1160|1166",},
        [20] = {106,110,"1222|1222",},
        [21] = {107,103,"1388|1143",},
        [22] = {107,106,"1160|1166",},
        [23] = {108,109,"1688|1220",},
        [24] = {108,110,"1548|1277",},
        [25] = {109,104,"1800|1025",},
        [26] = {109,108,"1688|1220",},
        [27] = {110,106,"1222|1222",},
        [28] = {110,108,"1548|1277",},
        [29] = {201,100,"1266|626",},
        [30] = {201,202,"1000|517",},
        [31] = {201,204,"900|555",},
        [32] = {202,201,"1000|517",},
        [33] = {202,203,"868|464",},
        [34] = {202,205,"1055|338",},
        [35] = {202,302,"1370|388",},
        [36] = {203,202,"868|464",},
        [37] = {203,207,"601|377",},
        [38] = {204,201,"900|555",},
        [39] = {204,209,"782|700",},
        [40] = {204,102,"1066|666",},
        [41] = {205,202,"1055|338",},
        [42] = {205,206,"659|166",},
        [43] = {206,205,"659|166",},
        [44] = {206,210,"354|303",},
        [45] = {207,203,"601|377",},
        [46] = {207,208,"416|595",},
        [47] = {208,207,"416|595",},
        [48] = {208,209,"501|666",},
        [49] = {208,210,"366|600",},
        [50] = {209,204,"782|700",},
        [51] = {209,208,"501|666",},
        [52] = {210,206,"354|303",},
        [53] = {210,208,"366|600",},
        [54] = {301,100,"1530|624",},
        [55] = {301,304,"1855|669",},
        [56] = {301,302,"1702|509",},
        [57] = {302,301,"1702|509",},
        [58] = {302,303,"1884|388",},
        [59] = {302,305,"1723|315",},
        [60] = {302,202,"1370|388",},
        [61] = {303,302,"1884|388",},
        [62] = {303,307,"2181|400",},
        [63] = {304,301,"1855|669",},
        [64] = {304,309,"1992|666",},
        [65] = {304,104,"1700|834",},
        [66] = {305,302,"1723|315",},
        [67] = {305,306,"2034|100",},
        [68] = {306,305,"2034|100",},
        [69] = {306,307,"2300|290",},
        [70] = {306,310,"2600|325",},
        [71] = {307,303,"2181|400",},
        [72] = {307,306,"2300|290",},
        [73] = {308,309,"2275|724",},
        [74] = {308,310,"2400|569",},
        [75] = {309,304,"1992|666",},
        [76] = {309,308,"2275|724",},
        [77] = {310,306,"2600|325",},
        [78] = {310,308,"2400|569",},
    }
}

-- index
local __index_pit_id_move_pit = {
    ["100_101"] = 2,
    ["100_201"] = 1,
    ["100_301"] = 3,
    ["101_100"] = 4,
    ["101_102"] = 5,
    ["101_104"] = 6,
    ["102_101"] = 7,
    ["102_103"] = 8,
    ["102_105"] = 9,
    ["102_204"] = 10,
    ["103_102"] = 11,
    ["103_107"] = 12,
    ["104_101"] = 13,
    ["104_109"] = 14,
    ["104_304"] = 15,
    ["105_102"] = 16,
    ["105_106"] = 17,
    ["106_105"] = 18,
    ["106_107"] = 19,
    ["106_110"] = 20,
    ["107_103"] = 21,
    ["107_106"] = 22,
    ["108_109"] = 23,
    ["108_110"] = 24,
    ["109_104"] = 25,
    ["109_108"] = 26,
    ["110_106"] = 27,
    ["110_108"] = 28,
    ["201_100"] = 29,
    ["201_202"] = 30,
    ["201_204"] = 31,
    ["202_201"] = 32,
    ["202_203"] = 33,
    ["202_205"] = 34,
    ["202_302"] = 35,
    ["203_202"] = 36,
    ["203_207"] = 37,
    ["204_102"] = 40,
    ["204_201"] = 38,
    ["204_209"] = 39,
    ["205_202"] = 41,
    ["205_206"] = 42,
    ["206_205"] = 43,
    ["206_210"] = 44,
    ["207_203"] = 45,
    ["207_208"] = 46,
    ["208_207"] = 47,
    ["208_209"] = 48,
    ["208_210"] = 49,
    ["209_204"] = 50,
    ["209_208"] = 51,
    ["210_206"] = 52,
    ["210_208"] = 53,
    ["301_100"] = 54,
    ["301_302"] = 56,
    ["301_304"] = 55,
    ["302_202"] = 60,
    ["302_301"] = 57,
    ["302_303"] = 58,
    ["302_305"] = 59,
    ["303_302"] = 61,
    ["303_307"] = 62,
    ["304_104"] = 65,
    ["304_301"] = 63,
    ["304_309"] = 64,
    ["305_302"] = 66,
    ["305_306"] = 67,
    ["306_305"] = 68,
    ["306_307"] = 69,
    ["306_310"] = 70,
    ["307_303"] = 71,
    ["307_306"] = 72,
    ["308_309"] = 73,
    ["308_310"] = 74,
    ["309_304"] = 75,
    ["309_308"] = 76,
    ["310_306"] = 77,
    ["310_308"] = 78,

}

-- index mainkey map
local __main_key_map = {
    [2] = "100_101",
    [1] = "100_201",
    [3] = "100_301",
    [4] = "101_100",
    [5] = "101_102",
    [6] = "101_104",
    [7] = "102_101",
    [8] = "102_103",
    [9] = "102_105",
    [10] = "102_204",
    [11] = "103_102",
    [12] = "103_107",
    [13] = "104_101",
    [14] = "104_109",
    [15] = "104_304",
    [16] = "105_102",
    [17] = "105_106",
    [18] = "106_105",
    [19] = "106_107",
    [20] = "106_110",
    [21] = "107_103",
    [22] = "107_106",
    [23] = "108_109",
    [24] = "108_110",
    [25] = "109_104",
    [26] = "109_108",
    [27] = "110_106",
    [28] = "110_108",
    [29] = "201_100",
    [30] = "201_202",
    [31] = "201_204",
    [32] = "202_201",
    [33] = "202_203",
    [34] = "202_205",
    [35] = "202_302",
    [36] = "203_202",
    [37] = "203_207",
    [40] = "204_102",
    [38] = "204_201",
    [39] = "204_209",
    [41] = "205_202",
    [42] = "205_206",
    [43] = "206_205",
    [44] = "206_210",
    [45] = "207_203",
    [46] = "207_208",
    [47] = "208_207",
    [48] = "208_209",
    [49] = "208_210",
    [50] = "209_204",
    [51] = "209_208",
    [52] = "210_206",
    [53] = "210_208",
    [54] = "301_100",
    [56] = "301_302",
    [55] = "301_304",
    [60] = "302_202",
    [57] = "302_301",
    [58] = "302_303",
    [59] = "302_305",
    [61] = "303_302",
    [62] = "303_307",
    [65] = "304_104",
    [63] = "304_301",
    [64] = "304_309",
    [66] = "305_302",
    [67] = "305_306",
    [68] = "306_305",
    [69] = "306_307",
    [70] = "306_310",
    [71] = "307_303",
    [72] = "307_306",
    [73] = "308_309",
    [74] = "308_310",
    [75] = "309_304",
    [76] = "309_308",
    [77] = "310_306",
    [78] = "310_308",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in mine_way")
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
function mine_way.length()
    return #mine_way._data
end

-- 
function mine_way.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function mine_way.isVersionValid(v)
    if mine_way.version then
        if v then
            return mine_way.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function mine_way.indexOf(index)
    if index == nil or not mine_way._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/mine_way.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/mine_way.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/mine_way.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "mine_way" )
                _isDataExist = mine_way.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "mine_way" )
                _isBaseExist = mine_way.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "mine_way" )
                _isExist = mine_way.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "mine_way" )
        local main_key = __main_key_map[index]
		local index_key = "__index_pit_id_move_pit"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "mine_way" )
        local main_key = __main_key_map[index]
		local index_key = "__index_pit_id_move_pit"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = mine_way._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "mine_way" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function mine_way.get(pit_id,move_pit)
    
    local k = pit_id .. '_' .. move_pit
    return mine_way.indexOf(__index_pit_id_move_pit[k])
        
end

--
function mine_way.set(pit_id,move_pit, key, value)
    local record = mine_way.get(pit_id,move_pit)
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
function mine_way.index()
    return __index_pit_id_move_pit
end

return mine_way