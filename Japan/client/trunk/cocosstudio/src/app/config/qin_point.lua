--qin_point

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  point_id = 1,    --id（类型坑点）-int 
  point_type = 2,    --类型-int 
  Exclude = 3,    --坑点-int 
  name = 4,    --皇陵内位置-string 
  mid_point = 5,    --中心点坐标-string 
  range = 6,    --宽高-string 
  offset_mid1 = 7,    --相对中心点位置1-string 
  offset_mid2 = 8,    --相对中心点位置2-string 
  offset_mid3 = 9,    --相对中心点位置3-string 
  click_region = 10,    --点击区域宽高-string 

}

-- key type
local __key_type = {
  point_id = "int",    --id（类型坑点）-1 
  point_type = "int",    --类型-2 
  Exclude = "int",    --坑点-3 
  name = "string",    --皇陵内位置-4 
  mid_point = "string",    --中心点坐标-5 
  range = "string",    --宽高-6 
  offset_mid1 = "string",    --相对中心点位置1-7 
  offset_mid2 = "string",    --相对中心点位置2-8 
  offset_mid3 = "string",    --相对中心点位置3-9 
  click_region = "string",    --点击区域宽高-10 

}


-- data
local qin_point = {
    version =  1,
    _data = {
        [1] = {101,1,1,"","2110|1193","240|140","","","","250|250",},
        [2] = {201,2,1,"","2992|1122","140|60","","","","250|250",},
        [3] = {202,2,2,"","2514|1336","140|60","","","","250|250",},
        [4] = {203,2,3,"","2884|1548","140|60","","","","250|250",},
        [5] = {204,2,4,"","2518|1752","140|60","","","","250|250",},
        [6] = {205,2,5,"","2124|1572","140|60","","","","250|250",},
        [7] = {206,2,6,"","1685|1339","140|60","","","","250|250",},
        [8] = {207,2,7,"","1211|1122","140|60","","","","250|250",},
        [9] = {208,2,8,"","1629|938","140|60","","","","250|250",},
        [10] = {209,2,9,"","2102|723","140|60","","","","250|250",},
        [11] = {210,2,10,"","2571|936","140|60","","","","250|250",},
        [12] = {211,2,11,"","2863|819","140|60","","","","250|250",},
        [13] = {212,2,12,"","3264|1039","140|60","","","","250|250",},
        [14] = {301,3,1,"先秦皇陵·上","3409|1356","125|90","","","","250|250",},
        [15] = {302,3,2,"先秦皇陵·上","3006|1804","125|90","","","","250|250",},
        [16] = {303,3,3,"先秦皇陵·上","2302|1906","125|90","","","","250|250",},
        [17] = {304,3,4,"先秦皇陵·中","1180|1588","125|90","","","","250|250",},
        [18] = {305,3,5,"先秦皇陵·中","949|1027","125|90","","","","250|250",},
        [19] = {306,3,6,"先秦皇陵·中","1241|658","125|90","","","","250|250",},
        [20] = {307,3,7,"先秦皇陵·下","2050|440","125|90","","","","250|250",},
        [21] = {308,3,8,"先秦皇陵·下","3088|463","125|90","","","","250|250",},
        [22] = {309,3,9,"先秦皇陵·下","3537|891","125|90","","","","250|250",},
        [23] = {401,4,1,"先秦皇陵·上","3749|1511","","","","","500|300",},
        [24] = {402,4,2,"先秦皇陵·上","3330|1960","","","","","500|300",},
        [25] = {403,4,3,"先秦皇陵·上","1999|2062","","","","","500|300",},
        [26] = {404,4,4,"先秦皇陵·中","885|1750","","","","","500|300",},
        [27] = {405,4,5,"先秦皇陵·中","631|1181","","","","","500|300",},
        [28] = {406,4,6,"先秦皇陵·中","940|537","","","","","500|300",},
        [29] = {407,4,7,"先秦皇陵·下","2343|308","","","","","500|300",},
        [30] = {408,4,8,"先秦皇陵·下","3380|335","","","","","500|300",},
        [31] = {409,4,9,"先秦皇陵·下","3830|764","","","","","500|300",},
        [32] = {501,5,1,"先秦皇陵·上","3749|1511","130|80","-206|23","76|-94","207|25","300|100",},
        [33] = {502,5,2,"先秦皇陵·上","3330|1960","130|80","-206|23","76|-94","207|25","300|100",},
        [34] = {503,5,3,"先秦皇陵·上","1999|2062","130|80","-206|23","-72|-94","207|25","300|100",},
        [35] = {504,5,4,"先秦皇陵·中","885|1750","130|80","-215|20","-83|-95","203|31","300|100",},
        [36] = {505,5,5,"先秦皇陵·中","631|1181","130|80","-215|20","-83|-95","203|31","300|100",},
        [37] = {506,5,6,"先秦皇陵·中","940|537","130|80","-170|60","-105|-85","170|-60","300|100",},
        [38] = {507,5,7,"先秦皇陵·下","2343|308","130|80","-200|-19","7|-102","227|-8","300|100",},
        [39] = {508,5,8,"先秦皇陵·下","3380|335","130|80","-205|11","2|-77","217|17","300|100",},
        [40] = {509,5,9,"先秦皇陵·下","3830|764","130|80","-200|-19","7|-102","227|-8","300|100",},
        [41] = {601,6,1,"先秦皇陵·上","3749|1511","120|80","-122|59","-45|-103","138|63","300|100",},
        [42] = {602,6,2,"先秦皇陵·上","3330|1960","120|80","-122|59","-45|-103","138|63","300|100",},
        [43] = {603,6,3,"先秦皇陵·上","1999|2062","120|80","-122|59","-45|-103","138|63","300|100",},
        [44] = {604,6,4,"先秦皇陵·中","885|1750","120|80","-159|59","7|-97","152|67","300|100",},
        [45] = {605,6,5,"先秦皇陵·中","631|1181","120|80","-159|59","7|-97","152|67","300|100",},
        [46] = {606,6,6,"先秦皇陵·中","940|537","120|80","-159|59","7|-97","152|67","300|100",},
        [47] = {607,6,7,"先秦皇陵·下","2343|308","120|80","-124|-55","106|-71","140|51","300|100",},
        [48] = {608,6,8,"先秦皇陵·下","3380|335","120|80","-124|-55","106|-71","140|51","300|100",},
        [49] = {609,6,9,"先秦皇陵·下","3830|764","120|80","-124|-55","106|-71","140|51","300|100",},
    }
}

-- index
local __index_point_id = {
    [101] = 1,
    [201] = 2,
    [202] = 3,
    [203] = 4,
    [204] = 5,
    [205] = 6,
    [206] = 7,
    [207] = 8,
    [208] = 9,
    [209] = 10,
    [210] = 11,
    [211] = 12,
    [212] = 13,
    [301] = 14,
    [302] = 15,
    [303] = 16,
    [304] = 17,
    [305] = 18,
    [306] = 19,
    [307] = 20,
    [308] = 21,
    [309] = 22,
    [401] = 23,
    [402] = 24,
    [403] = 25,
    [404] = 26,
    [405] = 27,
    [406] = 28,
    [407] = 29,
    [408] = 30,
    [409] = 31,
    [501] = 32,
    [502] = 33,
    [503] = 34,
    [504] = 35,
    [505] = 36,
    [506] = 37,
    [507] = 38,
    [508] = 39,
    [509] = 40,
    [601] = 41,
    [602] = 42,
    [603] = 43,
    [604] = 44,
    [605] = 45,
    [606] = 46,
    [607] = 47,
    [608] = 48,
    [609] = 49,

}

-- index mainkey map
local __main_key_map = {
    [1] = 101,
    [2] = 201,
    [3] = 202,
    [4] = 203,
    [5] = 204,
    [6] = 205,
    [7] = 206,
    [8] = 207,
    [9] = 208,
    [10] = 209,
    [11] = 210,
    [12] = 211,
    [13] = 212,
    [14] = 301,
    [15] = 302,
    [16] = 303,
    [17] = 304,
    [18] = 305,
    [19] = 306,
    [20] = 307,
    [21] = 308,
    [22] = 309,
    [23] = 401,
    [24] = 402,
    [25] = 403,
    [26] = 404,
    [27] = 405,
    [28] = 406,
    [29] = 407,
    [30] = 408,
    [31] = 409,
    [32] = 501,
    [33] = 502,
    [34] = 503,
    [35] = 504,
    [36] = 505,
    [37] = 506,
    [38] = 507,
    [39] = 508,
    [40] = 509,
    [41] = 601,
    [42] = 602,
    [43] = 603,
    [44] = 604,
    [45] = 605,
    [46] = 606,
    [47] = 607,
    [48] = 608,
    [49] = 609,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in qin_point")
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
function qin_point.length()
    return #qin_point._data
end

-- 
function qin_point.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function qin_point.isVersionValid(v)
    if qin_point.version then
        if v then
            return qin_point.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function qin_point.indexOf(index)
    if index == nil or not qin_point._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/qin_point.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/qin_point.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/qin_point.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "qin_point" )
                _isDataExist = qin_point.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "qin_point" )
                _isBaseExist = qin_point.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "qin_point" )
                _isExist = qin_point.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "qin_point" )
        local main_key = __main_key_map[index]
		local index_key = "__index_point_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "qin_point" )
        local main_key = __main_key_map[index]
		local index_key = "__index_point_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = qin_point._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "qin_point" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function qin_point.get(point_id)
    
    return qin_point.indexOf(__index_point_id[point_id])
        
end

--
function qin_point.set(point_id, key, value)
    local record = qin_point.get(point_id)
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
function qin_point.index()
    return __index_point_id
end

return qin_point