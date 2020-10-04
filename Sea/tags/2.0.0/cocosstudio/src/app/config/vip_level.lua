--vip_level

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  vip_level = 1,    --VIP等级-int 
  vip_exp = 2,    --VIP经验-int 
  price = 3,    --礼包价格-int 
  price_show = 4,    --礼包原价-int 
  show_lv = 5,    --显示控制-int 
  type_1 = 6,    --赠品类型1-int 
  value_1 = 7,    --类型值1-int 
  size_1 = 8,    --数量1-int 
  type_2 = 9,    --赠品类型2-int 
  value_2 = 10,    --类型值2-int 
  size_2 = 11,    --数量2-int 
  type_3 = 12,    --赠品类型3-int 
  value_3 = 13,    --类型值3-int 
  size_3 = 14,    --数量3-int 
  type_4 = 15,    --赠品类型4-int 
  value_4 = 16,    --类型值4-int 
  size_4 = 17,    --数量4-int 
  type_5 = 18,    --赠品类型5-int 
  value_5 = 19,    --类型值5-int 
  size_5 = 20,    --数量5-int 
  type_6 = 21,    --赠品类型6-int 
  value_6 = 22,    --类型值6-int 
  size_6 = 23,    --数量6-int 

}

-- key type
local __key_type = {
  vip_level = "int",    --VIP等级-1 
  vip_exp = "int",    --VIP经验-2 
  price = "int",    --礼包价格-3 
  price_show = "int",    --礼包原价-4 
  show_lv = "int",    --显示控制-5 
  type_1 = "int",    --赠品类型1-6 
  value_1 = "int",    --类型值1-7 
  size_1 = "int",    --数量1-8 
  type_2 = "int",    --赠品类型2-9 
  value_2 = "int",    --类型值2-10 
  size_2 = "int",    --数量2-11 
  type_3 = "int",    --赠品类型3-12 
  value_3 = "int",    --类型值3-13 
  size_3 = "int",    --数量3-14 
  type_4 = "int",    --赠品类型4-15 
  value_4 = "int",    --类型值4-16 
  size_4 = "int",    --数量4-17 
  type_5 = "int",    --赠品类型5-18 
  value_5 = "int",    --类型值5-19 
  size_5 = "int",    --数量5-20 
  type_6 = "int",    --赠品类型6-21 
  value_6 = "int",    --类型值6-22 
  size_6 = "int",    --数量6-23 

}


-- data
local vip_level = {
    _data = {
        [1] = {0,60,0,200,0,6,1,1,6,2,1,5,2,100000,0,0,0,0,0,0,0,0,0,},
        [2] = {1,240,0,500,0,6,23,1,2,303,1,6,2,2,6,5,10,0,0,0,0,0,0,},
        [3] = {2,700,0,1000,0,6,23,1,2,304,1,6,1,2,5,2,150000,0,0,0,0,0,0,},
        [4] = {3,1000,0,1500,0,6,23,2,2,302,1,6,2,3,6,5,20,0,0,0,0,0,0,},
        [5] = {4,3000,0,2000,0,6,23,2,2,301,1,6,1,3,5,2,200000,0,0,0,0,0,0,},
        [6] = {5,5000,0,3000,0,6,24,2,6,7,10,2,403,1,6,21,10,6,20,10,0,0,0,},
        [7] = {6,10000,0,3000,0,6,24,2,6,105,1,2,404,1,6,21,20,6,20,20,0,0,0,},
        [8] = {7,20000,0,3500,0,6,24,2,6,110,1,2,402,1,6,21,40,6,20,40,0,0,0,},
        [9] = {8,20000,0,4000,0,6,24,2,6,110,1,2,401,1,6,21,60,6,20,60,0,0,0,},
        [10] = {9,40000,0,5000,7,6,25,2,6,110,1,2,411,1,6,21,80,6,20,80,0,0,0,},
        [11] = {10,50000,0,5500,8,6,25,2,6,110,1,2,412,1,6,21,100,6,20,100,0,0,0,},
        [12] = {11,150000,0,8000,9,6,25,2,6,110,1,2,410,1,6,21,120,6,20,120,0,0,0,},
        [13] = {12,300000,0,10000,10,6,25,4,6,110,3,2,409,1,6,21,150,6,20,150,0,0,0,},
        [14] = {13,400000,0,12000,11,6,26,2,6,110,3,6,139,2,6,21,200,6,20,200,0,0,0,},
        [15] = {14,800000,0,15000,12,6,26,6,6,110,3,6,139,2,6,148,1,6,44,6,6,43,3,},
        [16] = {15,1200000,0,18000,13,6,27,6,6,110,5,6,139,3,6,148,2,6,44,12,6,43,6,},
        [17] = {16,0,0,0,14,6,27,8,6,110,5,6,157,2,6,148,2,6,44,18,6,43,9,},
    }
}

-- index
local __index_vip_level = {
    [0] = 1,
    [1] = 2,
    [10] = 11,
    [11] = 12,
    [12] = 13,
    [13] = 14,
    [14] = 15,
    [15] = 16,
    [16] = 17,
    [2] = 3,
    [3] = 4,
    [4] = 5,
    [5] = 6,
    [6] = 7,
    [7] = 8,
    [8] = 9,
    [9] = 10,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in vip_level")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function vip_level.length()
    return #vip_level._data
end

-- 
function vip_level.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function vip_level.indexOf(index)
    if index == nil or not vip_level._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/vip_level.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "vip_level" )
        return setmetatable({_raw = vip_level._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = vip_level._data[index]}, mt)
end

--
function vip_level.get(vip_level)
    
    return vip_level.indexOf(__index_vip_level[vip_level])
        
end

--
function vip_level.set(vip_level, key, value)
    local record = vip_level.get(vip_level)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function vip_level.index()
    return __index_vip_level
end

return vip_level