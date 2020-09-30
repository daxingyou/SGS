--return_award

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  level = 2,    --等级-int 
  vip1 = 3,    --vip1-int 
  vip2 = 4,    --vip2-int 
  vip3 = 5,    --vip3-int 
  vip4 = 6,    --vip4-int 
  vip5 = 7,    --vip5-int 
  vip6 = 8,    --vip6-int 
  vip7 = 9,    --vip7-int 
  vip8 = 10,    --vip8-int 
  vip9 = 11,    --vip9-int 
  vip10 = 12,    --vip10-int 
  vip11 = 13,    --vip11-int 
  vip12 = 14,    --vip12-int 
  vip13 = 15,    --vip13-int 
  vip14 = 16,    --vip14-int 
  vip15 = 17,    --vip15-int 
  vip16 = 18,    --vip16-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  level = "int",    --等级-2 
  vip1 = "int",    --vip1-3 
  vip2 = "int",    --vip2-4 
  vip3 = "int",    --vip3-5 
  vip4 = "int",    --vip4-6 
  vip5 = "int",    --vip5-7 
  vip6 = "int",    --vip6-8 
  vip7 = "int",    --vip7-9 
  vip8 = "int",    --vip8-10 
  vip9 = "int",    --vip9-11 
  vip10 = "int",    --vip10-12 
  vip11 = "int",    --vip11-13 
  vip12 = "int",    --vip12-14 
  vip13 = "int",    --vip13-15 
  vip14 = "int",    --vip14-16 
  vip15 = "int",    --vip15-17 
  vip16 = "int",    --vip16-18 

}


-- data
local return_award = {
    version =  1,
    _data = {
        [1] = {1,10,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [2] = {2,20,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [3] = {3,30,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [4] = {4,35,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [5] = {5,40,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [6] = {6,45,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [7] = {7,50,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [8] = {8,55,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [9] = {9,60,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [10] = {10,65,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [11] = {11,68,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [12] = {12,70,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [13] = {13,73,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [14] = {14,76,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [15] = {15,78,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [16] = {16,80,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [17] = {17,82,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [18] = {18,84,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [19] = {19,86,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [20] = {20,88,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [21] = {21,90,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [22] = {22,92,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [23] = {23,94,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [24] = {24,96,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [25] = {25,97,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [26] = {26,98,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [27] = {27,99,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [28] = {28,100,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [29] = {29,101,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [30] = {30,102,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [31] = {31,103,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [32] = {32,104,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [33] = {33,105,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [34] = {34,106,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [35] = {35,107,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [36] = {36,108,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [37] = {37,109,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [38] = {38,110,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [39] = {39,111,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [40] = {40,112,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [41] = {41,113,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [42] = {42,114,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [43] = {43,115,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [44] = {44,116,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [45] = {45,117,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [46] = {46,118,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [47] = {47,119,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
        [48] = {48,120,60,120,150,400,600,1200,2000,4000,5000,7000,10000,18000,27000,40000,60000,90000,},
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
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
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
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in return_award")
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
function return_award.length()
    return #return_award._data
end

-- 
function return_award.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function return_award.isVersionValid(v)
    if return_award.version then
        if v then
            return return_award.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function return_award.indexOf(index)
    if index == nil or not return_award._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/return_award.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/return_award.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/return_award.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "return_award" )
                _isDataExist = return_award.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "return_award" )
                _isBaseExist = return_award.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "return_award" )
                _isExist = return_award.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "return_award" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "return_award" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = return_award._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "return_award" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function return_award.get(id)
    
    return return_award.indexOf(__index_id[id])
        
end

--
function return_award.set(id, key, value)
    local record = return_award.get(id)
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
function return_award.index()
    return __index_id
end

return return_award