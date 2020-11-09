--return_discount

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  vip_min = 2,    --VIP等级下限-int 
  vip_max = 3,    --VIP等级上限-int 
  day_min = 4,    --流失天数下限-int 
  day_max = 5,    --流失天数上限-int 
  is_work = 6,    --是否生效-int 
  txt = 7,    --显示用文本-string 
  reward_type = 8,    --类型-int 
  vip_pay_id = 9,    --价格id-int 
  price = 10,    --价格-int 
  reward_type1 = 11,    --奖励类型1-int 
  reward_value1 = 12,    --奖励类型值1-int 
  reward_size1 = 13,    --奖励数量1-int 
  reward_type2 = 14,    --奖励类型2-int 
  reward_value2 = 15,    --奖励类型值2-int 
  reward_size2 = 16,    --奖励数量2-int 
  reward_type3 = 17,    --奖励类型3-int 
  reward_value3 = 18,    --奖励类型值3-int 
  reward_size3 = 19,    --奖励数量3-int 
  time = 20,    --领取/购买次数-int 
  is_choose = 21,    --领取方式-int 
  recover = 22,    --刷新方式-int 
  show_money = 23,    --显示条件-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  vip_min = "int",    --VIP等级下限-2 
  vip_max = "int",    --VIP等级上限-3 
  day_min = "int",    --流失天数下限-4 
  day_max = "int",    --流失天数上限-5 
  is_work = "int",    --是否生效-6 
  txt = "string",    --显示用文本-7 
  reward_type = "int",    --类型-8 
  vip_pay_id = "int",    --价格id-9 
  price = "int",    --价格-10 
  reward_type1 = "int",    --奖励类型1-11 
  reward_value1 = "int",    --奖励类型值1-12 
  reward_size1 = "int",    --奖励数量1-13 
  reward_type2 = "int",    --奖励类型2-14 
  reward_value2 = "int",    --奖励类型值2-15 
  reward_size2 = "int",    --奖励数量2-16 
  reward_type3 = "int",    --奖励类型3-17 
  reward_value3 = "int",    --奖励类型值3-18 
  reward_size3 = "int",    --奖励数量3-19 
  time = "int",    --领取/购买次数-20 
  is_choose = "int",    --领取方式-21 
  recover = "int",    --刷新方式-22 
  show_money = "int",    --显示条件-23 

}


-- data
local return_discount = {
    version =  1,
    _data = {
        [1] = {1,0,16,0,9999,1,"累积充值#num#",2,0,4000,6,148,1,6,158,1,6,157,1,1,1,0,0,},
        [2] = {2,0,16,0,9999,1,"累积充值#num#",2,0,7000,6,148,1,6,158,1,6,157,1,1,1,0,4000,},
        [3] = {3,0,16,0,9999,1,"累积充值#num#",2,0,10000,6,148,1,6,158,1,6,157,1,1,1,0,7000,},
        [4] = {4,0,16,3,13,1,"奇珍异宝任选箱",1,10130,30,6,165,5,0,0,0,0,0,0,15,0,0,0,},
        [5] = {5,0,16,3,13,1,"春秋战国任选箱",1,10131,98,6,146,4,0,0,0,0,0,0,5,0,0,0,},
        [6] = {6,0,16,3,13,1,"橙色锦囊任选箱",1,10132,198,6,118,1,0,0,0,0,0,0,10,0,0,0,},
        [7] = {7,0,16,3,13,1,"稀有精炼石",1,10133,98,6,14,70,0,0,0,0,0,0,5,0,0,0,},
        [8] = {8,0,16,3,13,1,"红色万能神兵",1,10134,298,6,81,9,0,0,0,0,0,0,10,0,0,0,},
        [9] = {9,0,16,3,13,1,"红色锦囊任选箱",1,10135,648,6,139,1,0,0,0,0,0,0,5,0,0,0,},
        [10] = {10,0,16,3,13,1,"礼记周易任选箱",1,10136,648,6,162,8,0,0,0,0,0,0,5,0,0,0,},
        [11] = {11,0,16,3,13,1,"原石任选箱",1,10137,648,6,705,1,0,0,0,0,0,0,5,0,0,0,},
        [12] = {12,0,16,14,28,1,"奇珍异宝任选箱",1,10130,30,6,165,5,0,0,0,0,0,0,15,0,0,0,},
        [13] = {13,0,16,14,28,1,"春秋战国任选箱",1,10131,98,6,146,4,0,0,0,0,0,0,5,0,0,0,},
        [14] = {14,0,16,14,28,1,"橙色锦囊任选箱",1,10132,198,6,118,1,0,0,0,0,0,0,10,0,0,0,},
        [15] = {15,0,16,14,28,1,"稀有精炼石",1,10133,98,6,14,70,0,0,0,0,0,0,5,0,0,0,},
        [16] = {16,0,16,14,28,1,"红色万能神兵",1,10134,298,6,81,9,0,0,0,0,0,0,10,0,0,0,},
        [17] = {17,0,16,14,28,1,"红色锦囊任选箱",1,10135,648,6,139,1,0,0,0,0,0,0,5,0,0,0,},
        [18] = {18,0,16,14,28,1,"礼记周易任选箱",1,10136,648,6,162,8,0,0,0,0,0,0,5,0,0,0,},
        [19] = {19,0,16,14,28,1,"原石任选箱",1,10137,648,6,705,1,0,0,0,0,0,0,5,0,0,0,},
        [20] = {20,0,16,29,42,1,"奇珍异宝任选箱",1,10130,30,6,165,5,0,0,0,0,0,0,30,0,0,0,},
        [21] = {21,0,16,29,42,1,"春秋战国任选箱",1,10131,98,6,146,4,0,0,0,0,0,0,10,0,0,0,},
        [22] = {22,0,16,29,42,1,"橙色锦囊任选箱",1,10132,198,6,118,1,0,0,0,0,0,0,20,0,0,0,},
        [23] = {23,0,16,29,42,1,"稀有精炼石",1,10133,98,6,14,70,0,0,0,0,0,0,10,0,0,0,},
        [24] = {24,0,16,29,42,1,"红色万能神兵",1,10134,298,6,81,9,0,0,0,0,0,0,20,0,0,0,},
        [25] = {25,0,16,29,42,1,"红色锦囊任选箱",1,10135,648,6,139,1,0,0,0,0,0,0,10,0,0,0,},
        [26] = {26,0,16,29,42,1,"礼记周易任选箱",1,10136,648,6,162,8,0,0,0,0,0,0,10,0,0,0,},
        [27] = {27,0,16,29,42,1,"原石任选箱",1,10137,648,6,705,1,0,0,0,0,0,0,10,0,0,0,},
        [28] = {28,0,16,43,9999,1,"奇珍异宝任选箱",1,10130,30,6,165,5,0,0,0,0,0,0,45,0,0,0,},
        [29] = {29,0,16,43,9999,1,"春秋战国任选箱",1,10131,98,6,146,4,0,0,0,0,0,0,15,0,0,0,},
        [30] = {30,0,16,43,9999,1,"橙色锦囊任选箱",1,10132,198,6,118,1,0,0,0,0,0,0,30,0,0,0,},
        [31] = {31,0,16,43,9999,1,"稀有精炼石",1,10133,98,6,14,70,0,0,0,0,0,0,15,0,0,0,},
        [32] = {32,0,16,43,9999,1,"红色万能神兵",1,10134,298,6,81,9,0,0,0,0,0,0,30,0,0,0,},
        [33] = {33,0,16,43,9999,1,"红色锦囊任选箱",1,10135,648,6,139,1,0,0,0,0,0,0,15,0,0,0,},
        [34] = {34,0,16,43,9999,1,"礼记周易任选箱",1,10136,648,6,162,8,0,0,0,0,0,0,15,0,0,0,},
        [35] = {35,0,16,43,9999,1,"原石任选箱",1,10137,648,6,705,1,0,0,0,0,0,0,15,0,0,0,},
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
    [4] = 4,
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
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in return_discount")
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
function return_discount.length()
    return #return_discount._data
end

-- 
function return_discount.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function return_discount.isVersionValid(v)
    if return_discount.version then
        if v then
            return return_discount.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function return_discount.indexOf(index)
    if index == nil or not return_discount._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/return_discount.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/return_discount.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/return_discount.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "return_discount" )
                _isDataExist = return_discount.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "return_discount" )
                _isBaseExist = return_discount.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "return_discount" )
                _isExist = return_discount.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "return_discount" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "return_discount" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = return_discount._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "return_discount" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function return_discount.get(id)
    
    return return_discount.indexOf(__index_id[id])
        
end

--
function return_discount.set(id, key, value)
    local record = return_discount.get(id)
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
function return_discount.index()
    return __index_id
end

return return_discount