--bout_info

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  point = 2,    --阵位点-int 
  point_type = 3,    --阵位类型-int 
  attribute_type_1 = 4,    --属性类型-int 
  attribute_value_1 = 5,    --属性值-int 
  position = 6,    --阵位坐标-string 
  all_combat = 7,    --假战力-int 
  cost_hero1 = 8,    --消耗武将1-int 
  cost_hero1_num = 9,    --消耗武将1数量-int 
  cost_hero2 = 10,    --消耗武将2-int 
  cost_hero2_num = 11,    --消耗武将2数量-int 
  cost_hero3 = 12,    --消耗武将3-int 
  cost_hero3_num = 13,    --消耗武将3数量-int 
  cost_yubi = 14,    --消耗玉璧-int 
  point_name = 15,    --阵位名字-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  point = "int",    --阵位点-2 
  point_type = "int",    --阵位类型-3 
  attribute_type_1 = "int",    --属性类型-4 
  attribute_value_1 = "int",    --属性值-5 
  position = "string",    --阵位坐标-6 
  all_combat = "int",    --假战力-7 
  cost_hero1 = "int",    --消耗武将1-8 
  cost_hero1_num = "int",    --消耗武将1数量-9 
  cost_hero2 = "int",    --消耗武将2-10 
  cost_hero2_num = "int",    --消耗武将2数量-11 
  cost_hero3 = "int",    --消耗武将3-12 
  cost_hero3_num = "int",    --消耗武将3数量-13 
  cost_yubi = "int",    --消耗玉璧-14 
  point_name = "string",    --阵位名字-15 

}


-- data
local bout_info = {
    version =  1,
    _data = {
        [1] = {1,1,1,7,15000,"907|462",720000,107,2,108,2,111,2,0,"先锋",},
        [2] = {1,2,1,6,1000,"1005|323",720000,207,2,208,2,210,2,0,"中军",},
        [3] = {1,3,1,18,80,"928|174",720000,309,2,310,2,307,2,0,"后翼",},
        [4] = {1,4,1,17,80,"561|174",720000,407,2,408,2,410,2,0,"后翼",},
        [5] = {1,5,1,5,1000,"484|324",720000,109,2,110,2,106,2,0,"中军",},
        [6] = {1,6,1,1,2000,"577|462",720000,205,2,206,2,209,2,0,"先锋",},
        [7] = {1,7,2,14,60,"741|321",720000,0,0,0,0,0,0,500,"大将",},
        [8] = {2,1,1,1,2000,"616|395",720000,308,2,307,2,312,2,0,"前锋",},
        [9] = {2,2,1,7,15000,"870|395",720000,405,2,406,2,412,2,0,"前锋",},
        [10] = {2,3,1,5,1000,"483|325",720000,111,2,112,2,105,2,0,"锋翼",},
        [11] = {2,4,1,6,1000,"1004|325",720000,211,2,212,2,207,2,0,"锋翼",},
        [12] = {2,5,1,15,80,"345|251",720000,306,2,305,2,311,2,0,"锋尾",},
        [13] = {2,6,1,16,80,"1149|251",720000,411,2,412,2,409,2,0,"锋尾",},
        [14] = {2,7,2,8,60,"742|462",720000,0,0,0,0,0,0,500,"锋矢",},
        [15] = {3,1,1,1,3000,"660|464",1080000,301,2,302,3,304,3,0,"天位",},
        [16] = {3,2,1,7,22500,"824|462",1080000,103,2,104,3,109,3,0,"天位",},
        [17] = {3,3,1,6,1500,"397|325",1080000,303,2,304,3,306,3,0,"地位",},
        [18] = {3,4,1,5,1500,"1093|325",1080000,101,2,102,3,106,3,0,"地位",},
        [19] = {3,5,1,17,120,"563|172",1080000,201,2,202,3,212,3,0,"人位",},
        [20] = {3,6,1,18,120,"933|173",1080000,401,2,402,3,407,3,0,"人位",},
        [21] = {3,7,2,14,90,"741|321",1080000,0,0,0,0,0,0,1000,"上将",},
        [22] = {4,1,1,1,3000,"494|463",1080000,403,2,404,3,406,3,0,"日光",},
        [23] = {4,2,1,7,22500,"990|462",1080000,201,2,202,3,206,3,0,"日光",},
        [24] = {4,3,1,6,1500,"397|326",1080000,203,2,204,3,210,3,0,"月华",},
        [25] = {4,4,1,5,1500,"1093|326",1080000,301,2,302,3,308,3,0,"月华",},
        [26] = {4,5,1,15,120,"611|251",1080000,101,2,102,3,104,3,0,"星彩",},
        [27] = {4,6,1,16,120,"877|252",1080000,401,2,402,3,409,3,0,"星彩",},
        [28] = {4,7,2,8,90,"741|321",1080000,0,0,0,0,0,0,1000,"寰宇",},
        [29] = {5,1,1,1,10000,"433|249",3600000,450,1,401,2,410,3,0,"摇光",},
        [30] = {5,2,1,5,5000,"570|324",3600000,351,1,303,2,311,3,0,"开阳",},
        [31] = {5,3,1,6,5000,"700|394",3600000,151,1,103,2,112,3,0,"玉衡",},
        [32] = {5,4,1,7,75000,"830|325",3600000,251,1,203,2,204,3,0,"天权",},
        [33] = {5,5,1,17,400,"966|250",3600000,150,1,101,2,110,3,0,"天玑",},
        [34] = {5,6,1,18,400,"1090|324",3600000,451,1,403,2,408,3,0,"天璇",},
        [35] = {5,7,2,20,300,"1071|461",3600000,0,0,0,0,0,0,2000,"天枢",},
        [36] = {6,1,1,1,10000,"494|465",3600000,350,1,301,2,310,3,0,"惊门",},
        [37] = {6,2,1,5,5000,"522|249",3600000,252,1,201,2,209,3,0,"生门",},
        [38] = {6,3,1,15,400,"617|400",3600000,352,1,303,2,312,3,0,"休门",},
        [39] = {6,4,1,16,400,"878|246",3600000,152,1,103,2,105,3,0,"伤门",},
        [40] = {6,5,1,6,5000,"954|395",3600000,250,1,203,2,211,3,0,"杜门",},
        [41] = {6,6,1,7,75000,"1018|178",3600000,452,1,403,2,405,3,0,"景门",},
        [42] = {6,7,2,19,300,"741|321",3600000,0,0,0,0,0,0,2000,"开门",},
    }
}

-- index
local __index_id_point = {
    ["1_1"] = 1,
    ["1_2"] = 2,
    ["1_3"] = 3,
    ["1_4"] = 4,
    ["1_5"] = 5,
    ["1_6"] = 6,
    ["1_7"] = 7,
    ["2_1"] = 8,
    ["2_2"] = 9,
    ["2_3"] = 10,
    ["2_4"] = 11,
    ["2_5"] = 12,
    ["2_6"] = 13,
    ["2_7"] = 14,
    ["3_1"] = 15,
    ["3_2"] = 16,
    ["3_3"] = 17,
    ["3_4"] = 18,
    ["3_5"] = 19,
    ["3_6"] = 20,
    ["3_7"] = 21,
    ["4_1"] = 22,
    ["4_2"] = 23,
    ["4_3"] = 24,
    ["4_4"] = 25,
    ["4_5"] = 26,
    ["4_6"] = 27,
    ["4_7"] = 28,
    ["5_1"] = 29,
    ["5_2"] = 30,
    ["5_3"] = 31,
    ["5_4"] = 32,
    ["5_5"] = 33,
    ["5_6"] = 34,
    ["5_7"] = 35,
    ["6_1"] = 36,
    ["6_2"] = 37,
    ["6_3"] = 38,
    ["6_4"] = 39,
    ["6_5"] = 40,
    ["6_6"] = 41,
    ["6_7"] = 42,

}

-- index mainkey map
local __main_key_map = {
    [1] = "1_1",
    [2] = "1_2",
    [3] = "1_3",
    [4] = "1_4",
    [5] = "1_5",
    [6] = "1_6",
    [7] = "1_7",
    [8] = "2_1",
    [9] = "2_2",
    [10] = "2_3",
    [11] = "2_4",
    [12] = "2_5",
    [13] = "2_6",
    [14] = "2_7",
    [15] = "3_1",
    [16] = "3_2",
    [17] = "3_3",
    [18] = "3_4",
    [19] = "3_5",
    [20] = "3_6",
    [21] = "3_7",
    [22] = "4_1",
    [23] = "4_2",
    [24] = "4_3",
    [25] = "4_4",
    [26] = "4_5",
    [27] = "4_6",
    [28] = "4_7",
    [29] = "5_1",
    [30] = "5_2",
    [31] = "5_3",
    [32] = "5_4",
    [33] = "5_5",
    [34] = "5_6",
    [35] = "5_7",
    [36] = "6_1",
    [37] = "6_2",
    [38] = "6_3",
    [39] = "6_4",
    [40] = "6_5",
    [41] = "6_6",
    [42] = "6_7",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in bout_info")
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
function bout_info.length()
    return #bout_info._data
end

-- 
function bout_info.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function bout_info.isVersionValid(v)
    if bout_info.version then
        if v then
            return bout_info.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function bout_info.indexOf(index)
    if index == nil or not bout_info._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/bout_info.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/bout_info.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/bout_info.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "bout_info" )
                _isDataExist = bout_info.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "bout_info" )
                _isBaseExist = bout_info.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "bout_info" )
                _isExist = bout_info.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "bout_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id_point"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "bout_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id_point"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = bout_info._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "bout_info" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function bout_info.get(id,point)
    
    local k = id .. '_' .. point
    return bout_info.indexOf(__index_id_point[k])
        
end

--
function bout_info.set(id,point, key, value)
    local record = bout_info.get(id,point)
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
function bout_info.index()
    return __index_id_point
end

return bout_info