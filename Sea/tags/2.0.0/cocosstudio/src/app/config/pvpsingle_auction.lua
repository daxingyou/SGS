--pvpsingle_auction

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  day_min = 2,    --天数min-int 
  day_max = 3,    --天数max-int 
  people_min = 4,    --人数min-int 
  people_max = 5,    --人数max-int 
  reward_id1 = 6,    --奖励组1-int 
  reward_id2 = 7,    --奖励组2-int 
  reward_id3 = 8,    --奖励组3-int 
  reward_id4 = 9,    --奖励组4-int 
  reward_id5 = 10,    --奖励组5-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  day_min = "int",    --天数min-2 
  day_max = "int",    --天数max-3 
  people_min = "int",    --人数min-4 
  people_max = "int",    --人数max-5 
  reward_id1 = "int",    --奖励组1-6 
  reward_id2 = "int",    --奖励组2-7 
  reward_id3 = "int",    --奖励组3-8 
  reward_id4 = "int",    --奖励组4-9 
  reward_id5 = "int",    --奖励组5-10 

}


-- data
local pvpsingle_auction = {
    _data = {
        [1] = {1,1,9999,1000,9999,101,102,103,104,0,},
        [2] = {2,1,9999,951,999,201,202,203,204,0,},
        [3] = {3,1,9999,901,950,301,302,303,304,0,},
        [4] = {4,1,9999,851,900,401,402,403,404,0,},
        [5] = {5,1,9999,801,850,501,502,503,504,0,},
        [6] = {6,1,9999,751,800,601,602,603,604,0,},
        [7] = {7,1,9999,701,750,701,702,703,704,0,},
        [8] = {8,1,9999,651,700,801,802,803,804,0,},
        [9] = {9,1,9999,601,650,901,902,903,904,0,},
        [10] = {10,1,9999,551,600,1001,1002,1003,1004,0,},
        [11] = {11,1,9999,501,550,1101,1102,1103,1104,0,},
        [12] = {12,1,9999,481,500,1201,1202,1203,1204,0,},
        [13] = {13,1,9999,451,480,1301,1302,1303,1304,0,},
        [14] = {14,1,9999,421,450,1401,1402,1403,1404,0,},
        [15] = {15,1,9999,391,420,1501,1502,1503,1504,0,},
        [16] = {16,1,9999,361,390,1601,1602,1603,1604,0,},
        [17] = {17,1,9999,331,360,1701,1702,1703,1704,0,},
        [18] = {18,1,9999,301,330,1801,1802,1803,1804,0,},
        [19] = {19,1,9999,271,300,1901,1902,1903,1904,0,},
        [20] = {20,1,9999,241,270,2001,2002,2003,2004,0,},
        [21] = {21,1,9999,211,240,2101,2102,2103,2104,0,},
        [22] = {22,1,9999,181,210,2201,2202,2203,2204,0,},
        [23] = {23,1,9999,151,180,2301,2302,2303,2304,0,},
        [24] = {24,1,9999,121,150,2401,2402,2403,2404,0,},
        [25] = {25,1,9999,91,120,2501,2502,2503,2504,0,},
        [26] = {26,1,9999,61,90,2601,2602,2603,2604,0,},
        [27] = {27,1,9999,31,60,2701,2702,2703,2704,0,},
        [28] = {28,1,9999,1,30,2801,2802,2803,2804,0,},
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
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in pvpsingle_auction")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function pvpsingle_auction.length()
    return #pvpsingle_auction._data
end

-- 
function pvpsingle_auction.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pvpsingle_auction.indexOf(index)
    if index == nil or not pvpsingle_auction._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/pvpsingle_auction.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pvpsingle_auction" )
        return setmetatable({_raw = pvpsingle_auction._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = pvpsingle_auction._data[index]}, mt)
end

--
function pvpsingle_auction.get(id)
    
    return pvpsingle_auction.indexOf(__index_id[id])
        
end

--
function pvpsingle_auction.set(id, key, value)
    local record = pvpsingle_auction.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function pvpsingle_auction.index()
    return __index_id
end

return pvpsingle_auction