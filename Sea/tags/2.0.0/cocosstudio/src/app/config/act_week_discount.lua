--act_week_discount

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  name = 2,    --礼包名称-string 
  vip = 3,    --vip条件-int 
  price_show = 4,    --原价-int 
  price = 5,    --元宝价格-int 
  type = 6,    --物品类型-int 
  value = 7,    --类型值-int 
  size = 8,    --数量-int 
  time = 9,    --次数-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  name = "string",    --礼包名称-2 
  vip = "int",    --vip条件-3 
  price_show = "int",    --原价-4 
  price = "int",    --元宝价格-5 
  type = "int",    --物品类型-6 
  value = "int",    --类型值-7 
  size = "int",    --数量-8 
  time = "int",    --次数-9 

}


-- data
local act_week_discount = {
    _data = {
        [1] = {1,"体力丹",0,125,50,6,1,5,1,},
        [2] = {2,"精力丹",0,125,50,6,2,5,1,},
        [3] = {3,"突破丹",1,200,80,6,3,200,1,},
        [4] = {4,"宝物之魂",2,500,200,5,17,5000,1,},
        [5] = {5,"十年杜康",3,600,240,6,63,30,1,},
        [6] = {6,"将魂",4,1000,400,5,9,1000,1,},
        [7] = {7,"高级精炼石",5,1250,500,6,13,50,1,},
        [8] = {8,"神兵进阶石",6,500,200,6,19,500,1,},
        [9] = {9,"橙色万能神兵",7,1000,400,6,80,2,1,},
        [10] = {10,"金砚台",8,2000,800,6,73,80,1,},
        [11] = {11,"宝物精炼石",9,2000,800,6,10,200,1,},
        [12] = {12,"体力丹",0,125,50,6,1,5,1,},
        [13] = {13,"精力丹",0,125,50,6,2,5,1,},
        [14] = {14,"突破丹",1,200,80,6,3,200,1,},
        [15] = {15,"宝物之魂",2,500,200,5,17,5000,1,},
        [16] = {16,"十年杜康",3,600,240,6,63,30,1,},
        [17] = {17,"将魂",4,1000,400,5,9,1000,1,},
        [18] = {18,"高级精炼石",5,1250,500,6,13,50,1,},
        [19] = {19,"神兵进阶石",6,500,200,6,19,500,1,},
        [20] = {20,"橙色万能神兵",7,1000,400,6,80,2,1,},
        [21] = {21,"宝物精炼石",8,2000,800,6,10,200,1,},
        [22] = {22,"高级精炼石",9,2000,800,6,13,80,1,},
        [23] = {23,"银两",0,100,40,5,2,100000,1,},
        [24] = {24,"体力丹",1,125,50,6,1,5,1,},
        [25] = {25,"精力丹",2,125,50,6,2,5,1,},
        [26] = {26,"突破丹",3,200,80,6,3,200,1,},
        [27] = {27,"十年杜康",4,600,240,6,63,30,1,},
        [28] = {28,"将魂",5,1000,400,5,9,1000,1,},
        [29] = {29,"高级精炼石",6,1250,500,6,13,50,1,},
        [30] = {30,"神兵进阶石",7,2000,800,6,19,200,1,},
        [31] = {31,"橙色万能神兵",8,2000,800,6,80,2,1,},
        [32] = {32,"觉醒丹",9,2000,800,6,40,200,1,},
        [33] = {33,"宝物精炼石",10,2000,800,6,10,200,1,},
        [34] = {34,"银两",0,100,40,5,2,100000,1,},
        [35] = {35,"体力丹",1,125,50,6,1,5,1,},
        [36] = {36,"精力丹",2,125,50,6,2,5,1,},
        [37] = {37,"突破丹",3,200,80,6,3,200,1,},
        [38] = {38,"十年杜康",4,600,240,6,63,30,1,},
        [39] = {39,"将魂",5,1000,400,5,9,1000,1,},
        [40] = {40,"高级精炼石",6,1250,500,6,13,50,1,},
        [41] = {41,"神兵进阶石",7,2000,800,6,19,200,1,},
        [42] = {42,"橙色万能神兵",8,2000,800,6,80,2,1,},
        [43] = {43,"觉醒丹",9,2000,800,6,40,200,1,},
        [44] = {44,"宝物精炼石",10,2000,800,6,10,200,1,},
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
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in act_week_discount")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function act_week_discount.length()
    return #act_week_discount._data
end

-- 
function act_week_discount.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function act_week_discount.indexOf(index)
    if index == nil or not act_week_discount._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/act_week_discount.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "act_week_discount" )
        return setmetatable({_raw = act_week_discount._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = act_week_discount._data[index]}, mt)
end

--
function act_week_discount.get(id)
    
    return act_week_discount.indexOf(__index_id[id])
        
end

--
function act_week_discount.set(id, key, value)
    local record = act_week_discount.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function act_week_discount.index()
    return __index_id
end

return act_week_discount