--ten_jade_auction_price

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  price_add = 2,    --价格加值-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  price_add = "int",    --价格加值-2 

}


-- data
local ten_jade_auction_price = {
    version =  1,
    _data = {
        [1] = {0,10,},
        [2] = {1,10,},
        [3] = {2,20,},
        [4] = {3,30,},
        [5] = {4,30,},
        [6] = {5,50,},
        [7] = {6,50,},
        [8] = {7,50,},
        [9] = {8,70,},
        [10] = {9,70,},
        [11] = {10,70,},
        [12] = {11,70,},
        [13] = {12,70,},
        [14] = {13,180,},
        [15] = {14,180,},
        [16] = {15,180,},
        [17] = {16,180,},
        [18] = {17,180,},
        [19] = {18,420,},
        [20] = {19,420,},
        [21] = {20,420,},
        [22] = {21,420,},
        [23] = {22,420,},
        [24] = {23,900,},
        [25] = {24,900,},
        [26] = {25,900,},
        [27] = {26,900,},
        [28] = {27,900,},
        [29] = {28,900,},
        [30] = {29,2250,},
        [31] = {30,2250,},
        [32] = {31,2250,},
        [33] = {32,2250,},
        [34] = {33,2250,},
        [35] = {34,2250,},
        [36] = {35,4500,},
        [37] = {36,4500,},
        [38] = {37,4500,},
        [39] = {38,4500,},
        [40] = {39,4500,},
        [41] = {40,4500,},
        [42] = {41,4500,},
        [43] = {42,9000,},
        [44] = {43,9000,},
        [45] = {44,9000,},
        [46] = {45,9000,},
        [47] = {46,9000,},
        [48] = {47,9000,},
        [49] = {48,9000,},
        [50] = {49,9000,},
        [51] = {50,9000,},
        [52] = {51,15000,},
    }
}

-- index
local __index_id = {
    [0] = 1,
    [1] = 2,
    [10] = 11,
    [11] = 12,
    [12] = 13,
    [13] = 14,
    [14] = 15,
    [15] = 16,
    [16] = 17,
    [17] = 18,
    [18] = 19,
    [19] = 20,
    [2] = 3,
    [20] = 21,
    [21] = 22,
    [22] = 23,
    [23] = 24,
    [24] = 25,
    [25] = 26,
    [26] = 27,
    [27] = 28,
    [28] = 29,
    [29] = 30,
    [3] = 4,
    [30] = 31,
    [31] = 32,
    [32] = 33,
    [33] = 34,
    [34] = 35,
    [35] = 36,
    [36] = 37,
    [37] = 38,
    [38] = 39,
    [39] = 40,
    [4] = 5,
    [40] = 41,
    [41] = 42,
    [42] = 43,
    [43] = 44,
    [44] = 45,
    [45] = 46,
    [46] = 47,
    [47] = 48,
    [48] = 49,
    [49] = 50,
    [5] = 6,
    [50] = 51,
    [51] = 52,
    [6] = 7,
    [7] = 8,
    [8] = 9,
    [9] = 10,

}

-- index mainkey map
local __main_key_map = {
    [1] = 0,
    [2] = 1,
    [11] = 10,
    [12] = 11,
    [13] = 12,
    [14] = 13,
    [15] = 14,
    [16] = 15,
    [17] = 16,
    [18] = 17,
    [19] = 18,
    [20] = 19,
    [3] = 2,
    [21] = 20,
    [22] = 21,
    [23] = 22,
    [24] = 23,
    [25] = 24,
    [26] = 25,
    [27] = 26,
    [28] = 27,
    [29] = 28,
    [30] = 29,
    [4] = 3,
    [31] = 30,
    [32] = 31,
    [33] = 32,
    [34] = 33,
    [35] = 34,
    [36] = 35,
    [37] = 36,
    [38] = 37,
    [39] = 38,
    [40] = 39,
    [5] = 4,
    [41] = 40,
    [42] = 41,
    [43] = 42,
    [44] = 43,
    [45] = 44,
    [46] = 45,
    [47] = 46,
    [48] = 47,
    [49] = 48,
    [50] = 49,
    [6] = 5,
    [51] = 50,
    [52] = 51,
    [7] = 6,
    [8] = 7,
    [9] = 8,
    [10] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in ten_jade_auction_price")
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
function ten_jade_auction_price.length()
    return #ten_jade_auction_price._data
end

-- 
function ten_jade_auction_price.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function ten_jade_auction_price.isVersionValid(v)
    if ten_jade_auction_price.version then
        if v then
            return ten_jade_auction_price.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function ten_jade_auction_price.indexOf(index)
    if index == nil or not ten_jade_auction_price._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/ten_jade_auction_price.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/ten_jade_auction_price.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/ten_jade_auction_price.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "ten_jade_auction_price" )
                _isDataExist = ten_jade_auction_price.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "ten_jade_auction_price" )
                _isBaseExist = ten_jade_auction_price.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "ten_jade_auction_price" )
                _isExist = ten_jade_auction_price.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "ten_jade_auction_price" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "ten_jade_auction_price" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = ten_jade_auction_price._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "ten_jade_auction_price" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function ten_jade_auction_price.get(id)
    
    return ten_jade_auction_price.indexOf(__index_id[id])
        
end

--
function ten_jade_auction_price.set(id, key, value)
    local record = ten_jade_auction_price.get(id)
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
function ten_jade_auction_price.index()
    return __index_id
end

return ten_jade_auction_price