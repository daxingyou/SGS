--explore_treasure

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --章节-int 
  discover1_type = 2,    --奇遇1类型id-int 
  discover1_icon = 3,    --奇遇1图标-int 
  discover1_rewardtype = 4,    --奇遇1奖励类型-int 
  discover1_rewardid = 5,    --奇遇1奖励id-int 
  discover1_rewardsize = 6,    --奇遇1奖励数量-int 
  discover2_type = 7,    --奇遇2类型id-int 
  discover2_icon = 8,    --奇遇2图标-int 
  discover2_rewardtype = 9,    --奇遇2奖励类型-int 
  discover2_rewardid = 10,    --奇遇2奖励id-int 
  discover2_rewardsize = 11,    --奇遇2奖励数量-int 
  discover3_type = 12,    --奇遇3类型id-int 
  discover3_icon = 13,    --奇遇3图标-int 
  discover3_rewardtype = 14,    --奇遇3奖励类型-int 
  discover3_rewardid = 15,    --奇遇3奖励id-int 
  discover3_rewardsize = 16,    --奇遇3奖励数量-int 
  discover4_type = 17,    --奇遇4类型id-int 
  discover4_icon = 18,    --奇遇4图标-int 
  discover4_rewardtype = 19,    --奇遇4奖励类型-int 
  discover4_rewardid = 20,    --奇遇4奖励id-int 
  discover4_rewardsize = 21,    --奇遇4奖励数量-int 
  discover5_type = 22,    --奇遇5类型id-int 
  discover5_icon = 23,    --奇遇5图标-int 
  discover5_rewardtype = 24,    --奇遇5奖励类型-int 
  discover5_rewardid = 25,    --奇遇5奖励id-int 
  discover5_rewardsize = 26,    --奇遇5奖励数量-int 

}

-- key type
local __key_type = {
  id = "int",    --章节-1 
  discover1_type = "int",    --奇遇1类型id-2 
  discover1_icon = "int",    --奇遇1图标-3 
  discover1_rewardtype = "int",    --奇遇1奖励类型-4 
  discover1_rewardid = "int",    --奇遇1奖励id-5 
  discover1_rewardsize = "int",    --奇遇1奖励数量-6 
  discover2_type = "int",    --奇遇2类型id-7 
  discover2_icon = "int",    --奇遇2图标-8 
  discover2_rewardtype = "int",    --奇遇2奖励类型-9 
  discover2_rewardid = "int",    --奇遇2奖励id-10 
  discover2_rewardsize = "int",    --奇遇2奖励数量-11 
  discover3_type = "int",    --奇遇3类型id-12 
  discover3_icon = "int",    --奇遇3图标-13 
  discover3_rewardtype = "int",    --奇遇3奖励类型-14 
  discover3_rewardid = "int",    --奇遇3奖励id-15 
  discover3_rewardsize = "int",    --奇遇3奖励数量-16 
  discover4_type = "int",    --奇遇4类型id-17 
  discover4_icon = "int",    --奇遇4图标-18 
  discover4_rewardtype = "int",    --奇遇4奖励类型-19 
  discover4_rewardid = "int",    --奇遇4奖励id-20 
  discover4_rewardsize = "int",    --奇遇4奖励数量-21 
  discover5_type = "int",    --奇遇5类型id-22 
  discover5_icon = "int",    --奇遇5图标-23 
  discover5_rewardtype = "int",    --奇遇5奖励类型-24 
  discover5_rewardid = "int",    --奇遇5奖励id-25 
  discover5_rewardsize = "int",    --奇遇5奖励数量-26 

}


-- data
local explore_treasure = {
    _data = {
        [1] = {1,11,101,3,101,1,12,0,7,0,0,13,0,3,0,0,14,0,7,0,1,15,0,3,0,1,},
        [2] = {2,11,111,3,111,1,12,0,7,0,0,13,0,3,0,0,14,0,7,0,1,15,0,3,0,1,},
        [3] = {3,11,102,3,102,1,12,0,7,0,0,13,0,3,0,0,14,0,7,0,1,15,0,3,0,1,},
        [4] = {4,11,112,3,112,1,12,0,7,0,0,13,0,3,0,0,14,0,7,0,1,15,0,3,0,1,},
        [5] = {5,11,101,3,101,1,12,0,7,0,0,13,0,3,0,0,14,0,7,0,1,15,0,3,0,1,},
        [6] = {6,11,111,3,111,1,12,201,7,3201,1,13,201,3,201,1,14,0,7,0,1,15,0,3,0,1,},
        [7] = {7,11,102,3,102,1,12,211,7,3211,1,13,211,3,211,1,14,0,7,0,1,15,0,3,0,1,},
        [8] = {8,11,112,3,112,1,12,202,7,3202,1,13,202,3,202,1,14,0,7,0,1,15,0,3,0,1,},
        [9] = {9,11,101,3,101,1,12,212,7,3212,1,13,212,3,212,1,14,0,7,0,1,15,0,3,0,1,},
        [10] = {10,11,111,3,111,1,12,203,7,3203,1,13,203,3,203,1,14,301,7,3301,1,15,301,3,301,1,},
        [11] = {11,11,102,3,102,1,12,213,7,3213,1,13,213,3,213,1,14,311,7,3311,1,15,311,3,311,1,},
        [12] = {12,11,112,3,112,1,12,201,7,3201,1,13,201,3,201,1,14,302,7,3302,1,15,302,3,302,1,},
        [13] = {13,11,101,3,101,1,12,211,7,3211,1,13,211,3,211,1,14,312,7,3312,1,15,312,3,312,1,},
        [14] = {14,11,111,3,111,1,12,202,7,3202,1,13,202,3,202,1,14,303,7,3303,1,15,303,3,303,1,},
        [15] = {15,11,102,3,102,1,12,212,7,3212,1,13,212,3,212,1,14,313,7,3313,1,15,313,3,313,1,},
        [16] = {16,11,112,3,112,1,12,203,7,3203,1,13,203,3,203,1,14,304,7,3304,1,15,304,3,304,1,},
        [17] = {17,11,101,3,101,1,12,213,7,3213,1,13,213,3,213,1,14,314,7,3314,1,15,314,3,314,1,},
        [18] = {18,11,111,3,111,1,12,201,7,3201,1,13,201,3,201,1,14,301,7,3301,1,15,301,3,301,1,},
        [19] = {19,11,102,3,102,1,12,211,7,3211,1,13,211,3,211,1,14,311,7,3311,1,15,311,3,311,1,},
        [20] = {20,11,112,3,112,1,12,202,7,3202,1,13,202,3,202,1,14,302,7,3302,1,15,302,3,302,1,},
        [21] = {21,11,101,3,101,1,12,212,7,3212,1,13,212,3,212,1,14,312,7,3312,1,15,312,3,312,1,},
        [22] = {22,11,111,3,111,1,12,203,7,3203,1,13,203,3,203,1,14,303,7,3303,1,15,303,3,303,1,},
        [23] = {23,11,102,3,102,1,12,213,7,3213,1,13,213,3,213,1,14,313,7,3313,1,15,313,3,313,1,},
        [24] = {24,11,112,3,112,1,12,201,7,3201,1,13,201,3,201,1,14,304,7,3304,1,15,304,3,304,1,},
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
        assert(__key_map[k], "cannot find " .. k .. " in explore_treasure")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function explore_treasure.length()
    return #explore_treasure._data
end

-- 
function explore_treasure.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function explore_treasure.indexOf(index)
    if index == nil or not explore_treasure._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/explore_treasure.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "explore_treasure" )
        return setmetatable({_raw = explore_treasure._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = explore_treasure._data[index]}, mt)
end

--
function explore_treasure.get(id)
    
    return explore_treasure.indexOf(__index_id[id])
        
end

--
function explore_treasure.set(id, key, value)
    local record = explore_treasure.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function explore_treasure.index()
    return __index_id
end

return explore_treasure