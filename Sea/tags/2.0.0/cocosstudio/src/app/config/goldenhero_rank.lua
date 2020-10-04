--goldenhero_rank

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  order = 1,    --排序-int 
  rank_type = 2,    --排行奖励类型-int 
  rank_min = 3,    --名次min-int 
  rank_max = 4,    --名次max-int 
  involvement = 5,    --是否显示参与奖-int 
  type_1 = 6,    --类型1-int 
  value_1 = 7,    --类型值1-int 
  size_1 = 8,    --数量1-int 
  type_2 = 9,    --类型2-int 
  value_2 = 10,    --类型值2-int 
  size_2 = 11,    --数量2-int 
  type_3 = 12,    --类型3-int 
  value_3 = 13,    --类型值3-int 
  size_3 = 14,    --数量3-int 
  type_4 = 15,    --类型4-int 
  value_4 = 16,    --类型值4-int 
  size_4 = 17,    --数量4-int 
  type_5 = 18,    --类型5-int 
  value_5 = 19,    --类型值5-int 
  size_5 = 20,    --数量5-int 
  type_6 = 21,    --类型6-int 
  value_6 = 22,    --类型值6-int 
  size_6 = 23,    --数量6-int 
  type_7 = 24,    --类型7-int 
  value_7 = 25,    --类型值7-int 
  size_7 = 26,    --数量7-int 
  type_8 = 27,    --类型8-int 
  value_8 = 28,    --类型值8-int 
  size_8 = 29,    --数量8-int 
  type_9 = 30,    --类型9-int 
  value_9 = 31,    --类型值9-int 
  size_9 = 32,    --数量9-int 
  type_10 = 33,    --类型10-int 
  value_10 = 34,    --类型值10-int 
  size_10 = 35,    --数量10-int 

}

-- key type
local __key_type = {
  order = "int",    --排序-1 
  rank_type = "int",    --排行奖励类型-2 
  rank_min = "int",    --名次min-3 
  rank_max = "int",    --名次max-4 
  involvement = "int",    --是否显示参与奖-5 
  type_1 = "int",    --类型1-6 
  value_1 = "int",    --类型值1-7 
  size_1 = "int",    --数量1-8 
  type_2 = "int",    --类型2-9 
  value_2 = "int",    --类型值2-10 
  size_2 = "int",    --数量2-11 
  type_3 = "int",    --类型3-12 
  value_3 = "int",    --类型值3-13 
  size_3 = "int",    --数量3-14 
  type_4 = "int",    --类型4-15 
  value_4 = "int",    --类型值4-16 
  size_4 = "int",    --数量4-17 
  type_5 = "int",    --类型5-18 
  value_5 = "int",    --类型值5-19 
  size_5 = "int",    --数量5-20 
  type_6 = "int",    --类型6-21 
  value_6 = "int",    --类型值6-22 
  size_6 = "int",    --数量6-23 
  type_7 = "int",    --类型7-24 
  value_7 = "int",    --类型值7-25 
  size_7 = "int",    --数量7-26 
  type_8 = "int",    --类型8-27 
  value_8 = "int",    --类型值8-28 
  size_8 = "int",    --数量8-29 
  type_9 = "int",    --类型9-30 
  value_9 = "int",    --类型值9-31 
  size_9 = "int",    --数量9-32 
  type_10 = "int",    --类型10-33 
  value_10 = "int",    --类型值10-34 
  size_10 = "int",    --数量10-35 

}


-- data
local goldenhero_rank = {
    _data = {
        [1] = {1,1,1,1,0,18,30,1,17,21,1,6,167,1,6,170,2,5,32,120000,6,10,50000,6,19,100000,0,0,0,0,0,0,0,0,0,},
        [2] = {2,1,2,2,0,18,29,1,17,21,1,6,167,1,6,170,1,5,32,90000,6,10,40000,6,19,80000,0,0,0,0,0,0,0,0,0,},
        [3] = {3,1,3,3,0,18,29,1,17,21,1,6,167,1,6,170,1,5,32,60000,6,10,30000,6,19,60000,0,0,0,0,0,0,0,0,0,},
        [4] = {4,1,4,10,0,18,29,1,17,20,1,6,167,1,6,169,80,5,32,32000,6,10,20000,6,19,40000,0,0,0,0,0,0,0,0,0,},
        [5] = {5,1,11,30,0,18,29,1,17,20,1,6,169,40,5,32,16000,6,10,15000,6,19,30000,0,0,0,0,0,0,0,0,0,0,0,0,},
        [6] = {6,1,31,100,0,6,169,20,5,32,8000,6,10,10000,6,19,20000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [7] = {7,1,101,99999,1,5,32,3200,6,10,5000,6,19,10000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [8] = {8,2,1,1,0,18,28,1,17,19,1,6,168,1,6,170,1,5,32,30000,6,10,20000,6,19,40000,0,0,0,0,0,0,0,0,0,},
        [9] = {9,2,2,2,0,17,19,1,6,168,1,6,169,120,5,32,20000,6,10,15000,6,19,30000,0,0,0,0,0,0,0,0,0,0,0,0,},
        [10] = {10,2,3,3,0,17,19,1,6,168,1,6,169,80,5,32,15000,6,10,10000,6,19,20000,0,0,0,0,0,0,0,0,0,0,0,0,},
        [11] = {11,2,4,10,0,17,19,1,6,169,40,5,32,8000,6,10,5000,6,19,10000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [12] = {12,2,11,30,0,6,169,20,5,32,6000,6,10,2500,6,19,5000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [13] = {13,2,31,100,0,6,169,10,5,32,4000,6,10,1250,6,19,2500,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
        [14] = {14,2,101,99999,1,5,32,2000,6,10,500,6,19,1000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},
    }
}

-- index
local __index_order = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [2] = 2,
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
        assert(__key_map[k], "cannot find " .. k .. " in goldenhero_rank")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function goldenhero_rank.length()
    return #goldenhero_rank._data
end

-- 
function goldenhero_rank.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function goldenhero_rank.indexOf(index)
    if index == nil or not goldenhero_rank._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/goldenhero_rank.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "goldenhero_rank" )
        return setmetatable({_raw = goldenhero_rank._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = goldenhero_rank._data[index]}, mt)
end

--
function goldenhero_rank.get(order)
    
    return goldenhero_rank.indexOf(__index_order[order])
        
end

--
function goldenhero_rank.set(order, key, value)
    local record = goldenhero_rank.get(order)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function goldenhero_rank.index()
    return __index_order
end

return goldenhero_rank