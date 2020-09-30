--seven_days_admin

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  day = 1,    --天数-int 
  sheet = 2,    --页签编号-int 
  name = 3,    --页签名称-string 
  type = 4,    --页签形式-int 

}

-- key type
local __key_type = {
  day = "int",    --天数-1 
  sheet = "int",    --页签编号-2 
  name = "string",    --页签名称-3 
  type = "int",    --页签形式-4 

}


-- data
local seven_days_admin = {
    version =  1,
    _data = {
        [1] = {1,1,"每日福利",1,},
        [2] = {1,2,"主线副本",1,},
        [3] = {1,3,"装备强化",1,},
        [4] = {1,4,"半价抢购",2,},
        [5] = {2,1,"每日福利",1,},
        [6] = {2,2,"游历和竞技",1,},
        [7] = {2,3,"宝物升级",1,},
        [8] = {2,4,"半价抢购",2,},
        [9] = {3,1,"每日福利",1,},
        [10] = {3,2,"过关斩将",1,},
        [11] = {3,3,"装备精炼",1,},
        [12] = {3,4,"半价抢购",2,},
        [13] = {4,1,"每日福利",1,},
        [14] = {4,2,"南蛮入侵",1,},
        [15] = {4,3,"神兵进阶",1,},
        [16] = {4,4,"半价抢购",2,},
        [17] = {5,1,"每日福利",1,},
        [18] = {5,2,"武将商店",1,},
        [19] = {5,3,"升级和突破",1,},
        [20] = {5,4,"半价抢购",2,},
        [21] = {6,1,"每日福利",1,},
        [22] = {6,2,"军团BOSS",1,},
        [23] = {6,3,"宝物精炼",1,},
        [24] = {6,4,"半价抢购",2,},
        [25] = {7,1,"每日福利",1,},
        [26] = {7,2,"总战力",1,},
        [27] = {7,3,"名将册",1,},
        [28] = {7,4,"半价抢购",2,},
    }
}

-- index
local __index_day_sheet = {
    ["1_1"] = 1,
    ["1_2"] = 2,
    ["1_3"] = 3,
    ["1_4"] = 4,
    ["2_1"] = 5,
    ["2_2"] = 6,
    ["2_3"] = 7,
    ["2_4"] = 8,
    ["3_1"] = 9,
    ["3_2"] = 10,
    ["3_3"] = 11,
    ["3_4"] = 12,
    ["4_1"] = 13,
    ["4_2"] = 14,
    ["4_3"] = 15,
    ["4_4"] = 16,
    ["5_1"] = 17,
    ["5_2"] = 18,
    ["5_3"] = 19,
    ["5_4"] = 20,
    ["6_1"] = 21,
    ["6_2"] = 22,
    ["6_3"] = 23,
    ["6_4"] = 24,
    ["7_1"] = 25,
    ["7_2"] = 26,
    ["7_3"] = 27,
    ["7_4"] = 28,

}

-- index mainkey map
local __main_key_map = {
    [1] = "1_1",
    [2] = "1_2",
    [3] = "1_3",
    [4] = "1_4",
    [5] = "2_1",
    [6] = "2_2",
    [7] = "2_3",
    [8] = "2_4",
    [9] = "3_1",
    [10] = "3_2",
    [11] = "3_3",
    [12] = "3_4",
    [13] = "4_1",
    [14] = "4_2",
    [15] = "4_3",
    [16] = "4_4",
    [17] = "5_1",
    [18] = "5_2",
    [19] = "5_3",
    [20] = "5_4",
    [21] = "6_1",
    [22] = "6_2",
    [23] = "6_3",
    [24] = "6_4",
    [25] = "7_1",
    [26] = "7_2",
    [27] = "7_3",
    [28] = "7_4",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in seven_days_admin")
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
function seven_days_admin.length()
    return #seven_days_admin._data
end

-- 
function seven_days_admin.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function seven_days_admin.isVersionValid(v)
    if seven_days_admin.version then
        if v then
            return seven_days_admin.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function seven_days_admin.indexOf(index)
    if index == nil or not seven_days_admin._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/seven_days_admin.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/seven_days_admin.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/seven_days_admin.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "seven_days_admin" )
                _isDataExist = seven_days_admin.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "seven_days_admin" )
                _isBaseExist = seven_days_admin.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "seven_days_admin" )
                _isExist = seven_days_admin.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "seven_days_admin" )
        local main_key = __main_key_map[index]
		local index_key = "__index_day_sheet"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "seven_days_admin" )
        local main_key = __main_key_map[index]
		local index_key = "__index_day_sheet"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = seven_days_admin._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "seven_days_admin" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function seven_days_admin.get(day,sheet)
    
    local k = day .. '_' .. sheet
    return seven_days_admin.indexOf(__index_day_sheet[k])
        
end

--
function seven_days_admin.set(day,sheet, key, value)
    local record = seven_days_admin.get(day,sheet)
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
function seven_days_admin.index()
    return __index_day_sheet
end

return seven_days_admin