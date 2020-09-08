--mine_route

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  point_start = 1,    --起点id-int 
  point_end = 2,    --终点id-int 
  district = 3,    --所在区域-int 
  point = 4,    --曲线点-string 

}

-- key type
local __key_type = {
  point_start = "int",    --起点id-1 
  point_end = "int",    --终点id-2 
  district = "int",    --所在区域-3 
  point = "string",    --曲线点-4 

}


-- data
local mine_route = {
    version =  1,
    _data = {
        [1] = {100,102,1,"184|23",},
        [2] = {101,105,1,"-25|115",},
        [3] = {102,101,1,"273|91",},
        [4] = {103,102,1,"301|-54",},
        [5] = {104,103,1,"-28|-120",},
        [6] = {105,104,1,"-246|-19",},
        [7] = {200,201,2,"243|25",},
        [8] = {201,202,2,"182|-41",},
        [9] = {201,203,2,"-69|62",},
        [10] = {201,204,2,"265|112",},
        [11] = {300,301,3,"41|-41",},
        [12] = {301,302,3,"4|50",},
        [13] = {301,303,3,"302|81",},
        [14] = {301,304,3,"278|-40",},
        [15] = {400,401,4,"172|-50",},
        [16] = {401,402,4,"173|67",},
        [17] = {401,403,4,"-99|-63",},
        [18] = {401,404,4,"-124|30",},
        [19] = {500,501,5,"-49|6",},
        [20] = {501,502,5,"171|-49",},
        [21] = {501,503,5,"-165|-108",},
        [22] = {600,601,6,"256|39",},
        [23] = {601,602,6,"-7|-10",},
        [24] = {601,603,6,"262|-87",},
        [25] = {700,701,7,"189|56",},
        [26] = {701,702,7,"-43|-12",},
        [27] = {701,703,7,"288|-78",},
        [28] = {800,801,8,"-173|-117",},
        [29] = {801,802,8,"5|8",},
        [30] = {801,803,8,"189|-100",},
        [31] = {900,901,9,"205|-95",},
        [32] = {901,902,9,"38|-11",},
        [33] = {901,903,9,"-127|-129",},
        [34] = {1000,1001,10,"-39|69",},
        [35] = {1001,1002,10,"159|63",},
        [36] = {1001,1003,10,"-83|-66",},
        [37] = {202,101,2,"284|-212",},
        [38] = {302,103,3,"-314|54",},
        [39] = {402,104,4,"408|106",},
        [40] = {502,203,5,"286|-36",},
        [41] = {602,204,6,"-126|10",},
        [42] = {702,303,7,"-179|-9",},
        [43] = {802,304,8,"87|47",},
        [44] = {902,403,9,"-48|35",},
        [45] = {1002,404,10,"271|39",},
    }
}

-- index
local __index_point_start_point_end = {
    ["1000_1001"] = 34,
    ["1001_1002"] = 35,
    ["1001_1003"] = 36,
    ["1002_404"] = 45,
    ["100_102"] = 1,
    ["101_105"] = 2,
    ["102_101"] = 3,
    ["103_102"] = 4,
    ["104_103"] = 5,
    ["105_104"] = 6,
    ["200_201"] = 7,
    ["201_202"] = 8,
    ["201_203"] = 9,
    ["201_204"] = 10,
    ["202_101"] = 37,
    ["300_301"] = 11,
    ["301_302"] = 12,
    ["301_303"] = 13,
    ["301_304"] = 14,
    ["302_103"] = 38,
    ["400_401"] = 15,
    ["401_402"] = 16,
    ["401_403"] = 17,
    ["401_404"] = 18,
    ["402_104"] = 39,
    ["500_501"] = 19,
    ["501_502"] = 20,
    ["501_503"] = 21,
    ["502_203"] = 40,
    ["600_601"] = 22,
    ["601_602"] = 23,
    ["601_603"] = 24,
    ["602_204"] = 41,
    ["700_701"] = 25,
    ["701_702"] = 26,
    ["701_703"] = 27,
    ["702_303"] = 42,
    ["800_801"] = 28,
    ["801_802"] = 29,
    ["801_803"] = 30,
    ["802_304"] = 43,
    ["900_901"] = 31,
    ["901_902"] = 32,
    ["901_903"] = 33,
    ["902_403"] = 44,

}

-- index mainkey map
local __main_key_map = {
    [34] = "1000_1001",
    [35] = "1001_1002",
    [36] = "1001_1003",
    [45] = "1002_404",
    [1] = "100_102",
    [2] = "101_105",
    [3] = "102_101",
    [4] = "103_102",
    [5] = "104_103",
    [6] = "105_104",
    [7] = "200_201",
    [8] = "201_202",
    [9] = "201_203",
    [10] = "201_204",
    [37] = "202_101",
    [11] = "300_301",
    [12] = "301_302",
    [13] = "301_303",
    [14] = "301_304",
    [38] = "302_103",
    [15] = "400_401",
    [16] = "401_402",
    [17] = "401_403",
    [18] = "401_404",
    [39] = "402_104",
    [19] = "500_501",
    [20] = "501_502",
    [21] = "501_503",
    [40] = "502_203",
    [22] = "600_601",
    [23] = "601_602",
    [24] = "601_603",
    [41] = "602_204",
    [25] = "700_701",
    [26] = "701_702",
    [27] = "701_703",
    [42] = "702_303",
    [28] = "800_801",
    [29] = "801_802",
    [30] = "801_803",
    [43] = "802_304",
    [31] = "900_901",
    [32] = "901_902",
    [33] = "901_903",
    [44] = "902_403",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in mine_route")
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
function mine_route.length()
    return #mine_route._data
end

-- 
function mine_route.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function mine_route.isVersionValid(v)
    if mine_route.version then
        if v then
            return mine_route.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function mine_route.indexOf(index)
    if index == nil or not mine_route._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/mine_route.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/mine_route.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/mine_route.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "mine_route" )
                _isDataExist = mine_route.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "mine_route" )
                _isBaseExist = mine_route.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "mine_route" )
                _isExist = mine_route.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "mine_route" )
        local main_key = __main_key_map[index]
		local index_key = "__index_point_start_point_end"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "mine_route" )
        local main_key = __main_key_map[index]
		local index_key = "__index_point_start_point_end"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = mine_route._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "mine_route" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function mine_route.get(point_start,point_end)
    
    local k = point_start .. '_' .. point_end
    return mine_route.indexOf(__index_point_start_point_end[k])
        
end

--
function mine_route.set(point_start,point_end, key, value)
    local record = mine_route.get(point_start,point_end)
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
function mine_route.index()
    return __index_point_start_point_end
end

return mine_route