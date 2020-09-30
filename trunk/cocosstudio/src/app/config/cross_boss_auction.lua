--cross_boss_auction

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  day_min = 2,    --天数min-int 
  day_max = 3,    --天数max-int 
  people_min = 4,    --参与人数min-int 
  people_max = 5,    --参与人数max-int 
  rank_min_1 = 6,    --排名区间1min-int 
  rank_max_1 = 7,    --排名区间1max-int 
  reward_id1 = 8,    --奖励组id1-int 
  rank_min_2 = 9,    --排名区间2min-int 
  rank_max_2 = 10,    --排名区间2max-int 
  reward_id2 = 11,    --奖励组id2-int 
  rank_min_3 = 12,    --排名区间3min-int 
  rank_max_3 = 13,    --排名区间3max-int 
  reward_id3 = 14,    --奖励组id3-int 
  rank_min_4 = 15,    --排名区间4min-int 
  rank_max_4 = 16,    --排名区间4max-int 
  reward_id4 = 17,    --奖励组id4-int 
  rank_min_5 = 18,    --排名区间5min-int 
  rank_max_5 = 19,    --排名区间5max-int 
  reward_id5 = 20,    --奖励组id5-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  day_min = "int",    --天数min-2 
  day_max = "int",    --天数max-3 
  people_min = "int",    --参与人数min-4 
  people_max = "int",    --参与人数max-5 
  rank_min_1 = "int",    --排名区间1min-6 
  rank_max_1 = "int",    --排名区间1max-7 
  reward_id1 = "int",    --奖励组id1-8 
  rank_min_2 = "int",    --排名区间2min-9 
  rank_max_2 = "int",    --排名区间2max-10 
  reward_id2 = "int",    --奖励组id2-11 
  rank_min_3 = "int",    --排名区间3min-12 
  rank_max_3 = "int",    --排名区间3max-13 
  reward_id3 = "int",    --奖励组id3-14 
  rank_min_4 = "int",    --排名区间4min-15 
  rank_max_4 = "int",    --排名区间4max-16 
  reward_id4 = "int",    --奖励组id4-17 
  rank_min_5 = "int",    --排名区间5min-18 
  rank_max_5 = "int",    --排名区间5max-19 
  reward_id5 = "int",    --奖励组id5-20 

}


-- data
local cross_boss_auction = {
    version =  1,
    _data = {
        [1] = {1,1,9999,40,100,1,9999,101,0,0,0,0,0,0,0,0,0,0,0,0,},
        [2] = {2,1,9999,38,39,1,9999,102,0,0,0,0,0,0,0,0,0,0,0,0,},
        [3] = {3,1,9999,36,37,1,9999,103,0,0,0,0,0,0,0,0,0,0,0,0,},
        [4] = {4,1,9999,34,35,1,9999,104,0,0,0,0,0,0,0,0,0,0,0,0,},
        [5] = {5,1,9999,32,33,1,9999,105,0,0,0,0,0,0,0,0,0,0,0,0,},
        [6] = {6,1,9999,30,31,1,9999,106,0,0,0,0,0,0,0,0,0,0,0,0,},
        [7] = {7,1,9999,28,29,1,9999,107,0,0,0,0,0,0,0,0,0,0,0,0,},
        [8] = {8,1,9999,26,27,1,9999,108,0,0,0,0,0,0,0,0,0,0,0,0,},
        [9] = {9,1,9999,24,25,1,9999,109,0,0,0,0,0,0,0,0,0,0,0,0,},
        [10] = {10,1,9999,22,23,1,9999,110,0,0,0,0,0,0,0,0,0,0,0,0,},
        [11] = {11,1,9999,20,21,1,9999,111,0,0,0,0,0,0,0,0,0,0,0,0,},
        [12] = {12,1,9999,18,19,1,9999,112,0,0,0,0,0,0,0,0,0,0,0,0,},
        [13] = {13,1,9999,16,17,1,9999,113,0,0,0,0,0,0,0,0,0,0,0,0,},
        [14] = {14,1,9999,14,15,1,9999,114,0,0,0,0,0,0,0,0,0,0,0,0,},
        [15] = {15,1,9999,12,13,1,9999,115,0,0,0,0,0,0,0,0,0,0,0,0,},
        [16] = {16,1,9999,10,11,1,9999,116,0,0,0,0,0,0,0,0,0,0,0,0,},
        [17] = {17,1,9999,8,9,1,9999,117,0,0,0,0,0,0,0,0,0,0,0,0,},
        [18] = {18,1,9999,6,7,1,9999,118,0,0,0,0,0,0,0,0,0,0,0,0,},
        [19] = {19,1,9999,4,5,1,9999,119,0,0,0,0,0,0,0,0,0,0,0,0,},
        [20] = {20,1,9999,2,3,1,9999,120,0,0,0,0,0,0,0,0,0,0,0,0,},
        [21] = {21,1,9999,0,1,1,9999,121,0,0,0,0,0,0,0,0,0,0,0,0,},
        [22] = {22,1,39,40,100,1,9999,201,0,0,0,0,0,0,0,0,0,0,0,0,},
        [23] = {23,1,39,38,39,1,9999,202,0,0,0,0,0,0,0,0,0,0,0,0,},
        [24] = {24,1,39,36,37,1,9999,203,0,0,0,0,0,0,0,0,0,0,0,0,},
        [25] = {25,1,39,34,35,1,9999,204,0,0,0,0,0,0,0,0,0,0,0,0,},
        [26] = {26,1,39,32,33,1,9999,205,0,0,0,0,0,0,0,0,0,0,0,0,},
        [27] = {27,1,39,30,31,1,9999,206,0,0,0,0,0,0,0,0,0,0,0,0,},
        [28] = {28,1,39,28,29,1,9999,207,0,0,0,0,0,0,0,0,0,0,0,0,},
        [29] = {29,1,39,26,27,1,9999,208,0,0,0,0,0,0,0,0,0,0,0,0,},
        [30] = {30,1,39,24,25,1,9999,209,0,0,0,0,0,0,0,0,0,0,0,0,},
        [31] = {31,1,39,22,23,1,9999,210,0,0,0,0,0,0,0,0,0,0,0,0,},
        [32] = {32,1,39,20,21,1,9999,211,0,0,0,0,0,0,0,0,0,0,0,0,},
        [33] = {33,1,39,18,19,1,9999,212,0,0,0,0,0,0,0,0,0,0,0,0,},
        [34] = {34,1,39,16,17,1,9999,213,0,0,0,0,0,0,0,0,0,0,0,0,},
        [35] = {35,1,39,14,15,1,9999,214,0,0,0,0,0,0,0,0,0,0,0,0,},
        [36] = {36,1,39,12,13,1,9999,215,0,0,0,0,0,0,0,0,0,0,0,0,},
        [37] = {37,1,39,10,11,1,9999,216,0,0,0,0,0,0,0,0,0,0,0,0,},
        [38] = {38,1,39,8,9,1,9999,217,0,0,0,0,0,0,0,0,0,0,0,0,},
        [39] = {39,1,39,6,7,1,9999,218,0,0,0,0,0,0,0,0,0,0,0,0,},
        [40] = {40,1,39,4,5,1,9999,219,0,0,0,0,0,0,0,0,0,0,0,0,},
        [41] = {41,1,39,2,3,1,9999,220,0,0,0,0,0,0,0,0,0,0,0,0,},
        [42] = {42,1,39,0,1,1,9999,221,0,0,0,0,0,0,0,0,0,0,0,0,},
        [43] = {43,40,9999,40,100,1,9999,301,0,0,0,0,0,0,0,0,0,0,0,0,},
        [44] = {44,40,9999,38,39,1,9999,302,0,0,0,0,0,0,0,0,0,0,0,0,},
        [45] = {45,40,9999,36,37,1,9999,303,0,0,0,0,0,0,0,0,0,0,0,0,},
        [46] = {46,40,9999,34,35,1,9999,304,0,0,0,0,0,0,0,0,0,0,0,0,},
        [47] = {47,40,9999,32,33,1,9999,305,0,0,0,0,0,0,0,0,0,0,0,0,},
        [48] = {48,40,9999,30,31,1,9999,306,0,0,0,0,0,0,0,0,0,0,0,0,},
        [49] = {49,40,9999,28,29,1,9999,307,0,0,0,0,0,0,0,0,0,0,0,0,},
        [50] = {50,40,9999,26,27,1,9999,308,0,0,0,0,0,0,0,0,0,0,0,0,},
        [51] = {51,40,9999,24,25,1,9999,309,0,0,0,0,0,0,0,0,0,0,0,0,},
        [52] = {52,40,9999,22,23,1,9999,310,0,0,0,0,0,0,0,0,0,0,0,0,},
        [53] = {53,40,9999,20,21,1,9999,311,0,0,0,0,0,0,0,0,0,0,0,0,},
        [54] = {54,40,9999,18,19,1,9999,312,0,0,0,0,0,0,0,0,0,0,0,0,},
        [55] = {55,40,9999,16,17,1,9999,313,0,0,0,0,0,0,0,0,0,0,0,0,},
        [56] = {56,40,9999,14,15,1,9999,314,0,0,0,0,0,0,0,0,0,0,0,0,},
        [57] = {57,40,9999,12,13,1,9999,315,0,0,0,0,0,0,0,0,0,0,0,0,},
        [58] = {58,40,9999,10,11,1,9999,316,0,0,0,0,0,0,0,0,0,0,0,0,},
        [59] = {59,40,9999,8,9,1,9999,317,0,0,0,0,0,0,0,0,0,0,0,0,},
        [60] = {60,40,9999,6,7,1,9999,318,0,0,0,0,0,0,0,0,0,0,0,0,},
        [61] = {61,40,9999,4,5,1,9999,319,0,0,0,0,0,0,0,0,0,0,0,0,},
        [62] = {62,40,9999,2,3,1,9999,320,0,0,0,0,0,0,0,0,0,0,0,0,},
        [63] = {63,40,9999,0,1,1,9999,321,0,0,0,0,0,0,0,0,0,0,0,0,},
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
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in cross_boss_auction")
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
function cross_boss_auction.length()
    return #cross_boss_auction._data
end

-- 
function cross_boss_auction.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cross_boss_auction.isVersionValid(v)
    if cross_boss_auction.version then
        if v then
            return cross_boss_auction.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cross_boss_auction.indexOf(index)
    if index == nil or not cross_boss_auction._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cross_boss_auction.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cross_boss_auction.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cross_boss_auction.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cross_boss_auction" )
                _isDataExist = cross_boss_auction.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cross_boss_auction" )
                _isBaseExist = cross_boss_auction.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cross_boss_auction" )
                _isExist = cross_boss_auction.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cross_boss_auction" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cross_boss_auction" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cross_boss_auction._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cross_boss_auction" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cross_boss_auction.get(id)
    
    return cross_boss_auction.indexOf(__index_id[id])
        
end

--
function cross_boss_auction.set(id, key, value)
    local record = cross_boss_auction.get(id)
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
function cross_boss_auction.index()
    return __index_id
end

return cross_boss_auction