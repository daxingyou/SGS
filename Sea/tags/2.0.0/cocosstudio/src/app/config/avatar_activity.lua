--avatar_activity

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  drop_id = 1,    --掉落id-int 
  Batch = 2,    --对应批次-int 
  Background = 3,    --玄天宝诰背景-int 
  drop_type = 4,    --抽取消耗类型-int 
  drop_value = 5,    --抽取消耗道具-int 
  drop_size = 6,    --抽取消耗数量-int 
  day_free = 7,    --每日免费次数-int 
  type_1 = 8,    --类型1-int 
  value_1 = 9,    --类型值1-int 
  size_1 = 10,    --数量1-int 
  type_2 = 11,    --类型2-int 
  value_2 = 12,    --类型值2-int 
  size_2 = 13,    --数量2-int 
  type_3 = 14,    --类型3-int 
  value_3 = 15,    --类型值3-int 
  size_3 = 16,    --数量3-int 
  type_4 = 17,    --类型4-int 
  value_4 = 18,    --类型值4-int 
  size_4 = 19,    --数量4-int 
  type_5 = 20,    --类型5-int 
  value_5 = 21,    --类型值5-int 
  size_5 = 22,    --数量5-int 
  type_6 = 23,    --类型6-int 
  value_6 = 24,    --类型值6-int 
  size_6 = 25,    --数量6-int 
  type_7 = 26,    --类型7-int 
  value_7 = 27,    --类型值7-int 
  size_7 = 28,    --数量7-int 
  type_8 = 29,    --类型8-int 
  value_8 = 30,    --类型值8-int 
  size_8 = 31,    --数量8-int 
  type_9 = 32,    --类型9-int 
  value_9 = 33,    --类型值9-int 
  size_9 = 34,    --数量9-int 
  type_10 = 35,    --类型10-int 
  value_10 = 36,    --类型值10-int 
  size_10 = 37,    --数量10-int 
  type_11 = 38,    --类型11-int 
  value_11 = 39,    --类型值11-int 
  size_11 = 40,    --数量11-int 
  type_12 = 41,    --类型12-int 
  value_12 = 42,    --类型值12-int 
  size_12 = 43,    --数量12-int 
  type_13 = 44,    --类型13-int 
  value_13 = 45,    --类型值13-int 
  size_13 = 46,    --数量13-int 
  type_14 = 47,    --类型14-int 
  value_14 = 48,    --类型值14-int 
  size_14 = 49,    --数量14-int 

}

-- key type
local __key_type = {
  drop_id = "int",    --掉落id-1 
  Batch = "int",    --对应批次-2 
  Background = "int",    --玄天宝诰背景-3 
  drop_type = "int",    --抽取消耗类型-4 
  drop_value = "int",    --抽取消耗道具-5 
  drop_size = "int",    --抽取消耗数量-6 
  day_free = "int",    --每日免费次数-7 
  type_1 = "int",    --类型1-8 
  value_1 = "int",    --类型值1-9 
  size_1 = "int",    --数量1-10 
  type_2 = "int",    --类型2-11 
  value_2 = "int",    --类型值2-12 
  size_2 = "int",    --数量2-13 
  type_3 = "int",    --类型3-14 
  value_3 = "int",    --类型值3-15 
  size_3 = "int",    --数量3-16 
  type_4 = "int",    --类型4-17 
  value_4 = "int",    --类型值4-18 
  size_4 = "int",    --数量4-19 
  type_5 = "int",    --类型5-20 
  value_5 = "int",    --类型值5-21 
  size_5 = "int",    --数量5-22 
  type_6 = "int",    --类型6-23 
  value_6 = "int",    --类型值6-24 
  size_6 = "int",    --数量6-25 
  type_7 = "int",    --类型7-26 
  value_7 = "int",    --类型值7-27 
  size_7 = "int",    --数量7-28 
  type_8 = "int",    --类型8-29 
  value_8 = "int",    --类型值8-30 
  size_8 = "int",    --数量8-31 
  type_9 = "int",    --类型9-32 
  value_9 = "int",    --类型值9-33 
  size_9 = "int",    --数量9-34 
  type_10 = "int",    --类型10-35 
  value_10 = "int",    --类型值10-36 
  size_10 = "int",    --数量10-37 
  type_11 = "int",    --类型11-38 
  value_11 = "int",    --类型值11-39 
  size_11 = "int",    --数量11-40 
  type_12 = "int",    --类型12-41 
  value_12 = "int",    --类型值12-42 
  size_12 = "int",    --数量12-43 
  type_13 = "int",    --类型13-44 
  value_13 = "int",    --类型值13-45 
  size_13 = "int",    --数量13-46 
  type_14 = "int",    --类型14-47 
  value_14 = "int",    --类型值14-48 
  size_14 = "int",    --数量14-49 

}


-- data
local avatar_activity = {
    _data = {
        [1] = {1,1,1,6,85,1,2,6,84,1,5,1,58,5,24,1,5,1,88,6,83,1,5,1,58,5,1,666,5,24,1,5,1,58,5,24,1,5,1,88,5,24,1,5,1,188,5,1,58,},
        [2] = {2,2,1,6,85,1,2,6,84,1,5,1,58,5,24,1,5,1,88,6,83,1,5,1,58,5,1,666,5,24,1,5,1,58,5,24,1,5,1,88,5,24,1,5,1,188,5,1,58,},
        [3] = {3,3,2,6,85,1,2,6,147,1,5,1,88,6,83,1,5,1,88,6,84,1,5,1,58,5,1,666,5,24,1,5,1,58,5,24,1,5,1,58,5,24,1,5,1,188,5,1,58,},
        [4] = {4,4,2,6,85,1,2,6,147,1,5,1,88,6,83,1,5,1,88,6,84,1,5,1,58,5,1,666,5,24,1,5,1,58,5,24,1,5,1,58,5,24,1,5,1,188,5,1,58,},
        [5] = {5,5,2,6,85,1,2,6,147,1,5,1,88,6,83,1,5,1,88,6,84,1,5,1,58,5,1,666,5,24,1,5,1,58,5,24,1,5,1,58,5,24,1,5,1,188,5,1,58,},
        [6] = {6,6,2,6,85,1,2,6,147,1,5,1,88,6,83,1,5,1,88,6,84,1,5,1,58,5,1,666,5,24,1,5,1,58,5,24,1,5,1,58,5,24,1,5,1,188,5,1,58,},
        [7] = {7,7,2,6,85,1,2,6,147,1,5,1,88,6,83,1,5,1,88,6,84,1,5,1,58,5,1,666,5,24,1,5,1,58,5,24,1,5,1,58,5,24,1,5,1,188,5,1,58,},
    }
}

-- index
local __index_drop_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in avatar_activity")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function avatar_activity.length()
    return #avatar_activity._data
end

-- 
function avatar_activity.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function avatar_activity.indexOf(index)
    if index == nil or not avatar_activity._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/avatar_activity.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "avatar_activity" )
        return setmetatable({_raw = avatar_activity._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = avatar_activity._data[index]}, mt)
end

--
function avatar_activity.get(drop_id)
    
    return avatar_activity.indexOf(__index_drop_id[drop_id])
        
end

--
function avatar_activity.set(drop_id, key, value)
    local record = avatar_activity.get(drop_id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function avatar_activity.index()
    return __index_drop_id
end

return avatar_activity