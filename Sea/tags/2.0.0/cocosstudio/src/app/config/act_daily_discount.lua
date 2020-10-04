--act_daily_discount

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  pay_type = 2,    --充值档次-int 
  vip_limit = 3,    --VIP限制-int 
  type_1 = 4,    --奖励类型1-int 
  value_1 = 5,    --类型值1-int 
  size_1 = 6,    --数量1-int 
  type_2 = 7,    --奖励类型2-int 
  value_2 = 8,    --类型值2-int 
  size_2 = 9,    --数量2-int 
  type_3 = 10,    --奖励类型3-int 
  value_3 = 11,    --类型值3-int 
  size_3 = 12,    --数量3-int 
  type_4 = 13,    --奖励类型4-int 
  value_4 = 14,    --类型值4-int 
  size_4 = 15,    --数量4-int 
  show_type_1 = 16,    --显示类型1-int 
  show_value_1 = 17,    --显示类型值1-int 
  show_size_1 = 18,    --显示数量1-int 
  show_type_2 = 19,    --显示类型2-int 
  show_value_2 = 20,    --显示类型值2-int 
  show_size_2 = 21,    --显示数量2-int 
  show_type_3 = 22,    --显示类型3-int 
  show_value_3 = 23,    --显示类型值3-int 
  show_size_3 = 24,    --显示数量3-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  pay_type = "int",    --充值档次-2 
  vip_limit = "int",    --VIP限制-3 
  type_1 = "int",    --奖励类型1-4 
  value_1 = "int",    --类型值1-5 
  size_1 = "int",    --数量1-6 
  type_2 = "int",    --奖励类型2-7 
  value_2 = "int",    --类型值2-8 
  size_2 = "int",    --数量2-9 
  type_3 = "int",    --奖励类型3-10 
  value_3 = "int",    --类型值3-11 
  size_3 = "int",    --数量3-12 
  type_4 = "int",    --奖励类型4-13 
  value_4 = "int",    --类型值4-14 
  size_4 = "int",    --数量4-15 
  show_type_1 = "int",    --显示类型1-16 
  show_value_1 = "int",    --显示类型值1-17 
  show_size_1 = "int",    --显示数量1-18 
  show_type_2 = "int",    --显示类型2-19 
  show_value_2 = "int",    --显示类型值2-20 
  show_size_2 = "int",    --显示数量2-21 
  show_type_3 = "int",    --显示类型3-22 
  show_value_3 = "int",    --显示类型值3-23 
  show_size_3 = "int",    --显示数量3-24 

}


-- data
local act_daily_discount = {
    _data = {
        [1] = {1,1,1,5,1,20,6,3,300,5,2,300000,0,0,0,6,23,1,0,0,0,0,0,0,},
        [2] = {2,2,2,5,1,60,6,1,2,6,64,10,0,0,0,6,23,1,0,0,0,0,0,0,},
        [3] = {3,3,3,5,1,120,6,2,2,6,73,15,0,0,0,6,23,1,0,0,0,0,0,0,},
        [4] = {4,1,1,5,1,20,6,3,300,5,2,300000,0,0,0,6,24,1,0,0,0,0,0,0,},
        [5] = {5,2,2,5,1,60,6,1,2,6,74,10,0,0,0,6,24,1,0,0,0,0,0,0,},
        [6] = {6,3,3,5,1,120,6,2,2,6,13,10,0,0,0,6,24,1,0,0,0,0,0,0,},
        [7] = {7,1,1,5,1,20,6,3,300,5,2,500000,0,0,0,6,24,1,0,0,0,0,0,0,},
        [8] = {8,2,2,5,1,60,6,1,2,6,14,10,0,0,0,6,24,1,0,0,0,0,0,0,},
        [9] = {9,3,3,5,1,120,6,2,2,6,80,1,0,0,0,6,24,1,0,0,0,0,0,0,},
        [10] = {10,1,1,5,1,20,6,3,300,5,2,500000,0,0,0,6,25,1,0,0,0,0,0,0,},
        [11] = {11,2,2,5,1,60,6,1,2,6,14,10,0,0,0,6,25,1,0,0,0,0,0,0,},
        [12] = {12,3,3,5,1,120,6,2,2,6,80,1,0,0,0,6,25,1,0,0,0,0,0,0,},
        [13] = {19,1,1,6,85,4,6,3,300,5,2,500000,5,1,20,6,25,1,6,92,1,6,93,1,},
        [14] = {20,2,2,6,95,2,6,1,2,6,14,10,5,1,60,6,25,1,6,92,1,6,93,1,},
        [15] = {21,3,3,6,94,2,6,2,2,6,80,1,5,1,120,6,25,1,6,92,1,6,93,1,},
        [16] = {13,1,1,6,85,4,6,3,300,5,2,500000,5,1,20,6,26,1,6,92,1,6,93,1,},
        [17] = {14,2,2,6,95,2,6,1,2,6,14,10,5,1,60,6,26,1,6,92,1,6,93,1,},
        [18] = {15,3,3,6,94,2,6,2,2,6,14,10,5,1,120,6,26,1,6,92,1,6,93,1,},
        [19] = {16,1,1,6,85,4,6,3,300,5,2,500000,5,1,20,6,27,1,6,92,1,6,93,1,},
        [20] = {17,2,2,6,95,2,6,1,2,6,14,10,5,1,60,6,27,1,6,92,1,6,93,1,},
        [21] = {18,3,3,6,94,2,6,2,2,6,14,10,5,1,120,6,27,1,6,92,1,6,93,1,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 16,
    [14] = 17,
    [15] = 18,
    [16] = 19,
    [17] = 20,
    [18] = 21,
    [19] = 13,
    [2] = 2,
    [20] = 14,
    [21] = 15,
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
        assert(__key_map[k], "cannot find " .. k .. " in act_daily_discount")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function act_daily_discount.length()
    return #act_daily_discount._data
end

-- 
function act_daily_discount.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_daily_discount.indexOf(index)
    if index == nil or not act_daily_discount._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/act_daily_discount.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_daily_discount" )
        return setmetatable({_raw = act_daily_discount._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = act_daily_discount._data[index]}, mt)
end

--
function act_daily_discount.get(id)
    
    return act_daily_discount.indexOf(__index_id[id])
        
end

--
function act_daily_discount.set(id, key, value)
    local record = act_daily_discount.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function act_daily_discount.index()
    return __index_id
end

return act_daily_discount