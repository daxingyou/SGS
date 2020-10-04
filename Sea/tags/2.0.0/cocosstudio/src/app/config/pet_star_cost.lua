--pet_star_cost

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  star = 1,    --星级-int 
  color = 2,    --品质-int 
  lv = 3,    --需要神兽等级-int 
  card = 4,    --同名卡数量-int 
  potential_card = 5,    --消耗界限突破前神兽数量-int 
  type_1 = 6,    --材料1type-int 
  value_1 = 7,    --材料1value-int 
  size_1 = 8,    --材料1size-int 
  type_2 = 9,    --材料2type-int 
  value_2 = 10,    --材料2value-int 
  size_2 = 11,    --材料2size-int 
  type_3 = 12,    --材料3type-int 
  value_3 = 13,    --材料3value-int 
  size_3 = 14,    --材料3size-int 

}

-- key type
local __key_type = {
  star = "int",    --星级-1 
  color = "int",    --品质-2 
  lv = "int",    --需要神兽等级-3 
  card = "int",    --同名卡数量-4 
  potential_card = "int",    --消耗界限突破前神兽数量-5 
  type_1 = "int",    --材料1type-6 
  value_1 = "int",    --材料1value-7 
  size_1 = "int",    --材料1size-8 
  type_2 = "int",    --材料2type-9 
  value_2 = "int",    --材料2value-10 
  size_2 = "int",    --材料2size-11 
  type_3 = "int",    --材料3type-12 
  value_3 = "int",    --材料3value-13 
  size_3 = "int",    --材料3size-14 

}


-- data
local pet_star_cost = {
    _data = {
        [1] = {0,2,20,1,0,6,32,50,5,2,100000,0,0,0,},
        [2] = {1,2,40,1,0,6,32,100,5,2,200000,0,0,0,},
        [3] = {2,2,60,1,0,6,32,200,5,2,400000,0,0,0,},
        [4] = {3,2,80,1,0,6,32,300,5,2,600000,0,0,0,},
        [5] = {4,2,100,1,0,6,32,400,5,2,800000,0,0,0,},
        [6] = {5,2,0,0,0,0,0,0,0,0,0,0,0,0,},
        [7] = {0,3,20,1,0,6,32,50,5,2,100000,0,0,0,},
        [8] = {1,3,40,1,0,6,32,100,5,2,200000,0,0,0,},
        [9] = {2,3,60,1,0,6,32,200,5,2,400000,0,0,0,},
        [10] = {3,3,80,1,0,6,32,300,5,2,600000,0,0,0,},
        [11] = {4,3,100,1,0,6,32,400,5,2,800000,0,0,0,},
        [12] = {5,3,0,0,0,0,0,0,0,0,0,0,0,0,},
        [13] = {0,4,20,1,0,6,32,100,5,2,150000,0,0,0,},
        [14] = {1,4,40,1,0,6,32,200,5,2,300000,0,0,0,},
        [15] = {2,4,60,1,0,6,32,400,5,2,600000,0,0,0,},
        [16] = {3,4,80,1,0,6,32,500,5,2,900000,0,0,0,},
        [17] = {4,4,100,1,0,6,32,700,5,2,1200000,0,0,0,},
        [18] = {5,4,0,0,0,0,0,0,0,0,0,0,0,0,},
        [19] = {0,5,20,1,0,6,32,500,5,2,200000,0,0,0,},
        [20] = {1,5,40,1,0,6,32,1000,5,2,400000,0,0,0,},
        [21] = {2,5,60,1,0,6,32,1800,5,2,800000,0,0,0,},
        [22] = {3,5,80,1,0,6,32,2700,5,2,1200000,0,0,0,},
        [23] = {4,5,100,1,0,6,32,3600,5,2,1600000,0,0,0,},
        [24] = {5,5,0,0,0,0,0,0,0,0,0,0,0,0,},
        [25] = {0,6,20,3,1,6,32,3300,5,2,1400000,0,0,0,},
        [26] = {1,6,40,0,1,6,32,1500,5,2,480000,0,0,0,},
        [27] = {2,6,60,0,1,6,32,2700,5,2,960000,0,0,0,},
        [28] = {3,6,80,0,1,6,32,4000,5,2,1440000,6,711,1,},
        [29] = {4,6,100,0,1,6,32,5400,5,2,1920000,6,711,1,},
        [30] = {5,6,0,0,0,0,0,0,0,0,0,0,0,0,},
    }
}

-- index
local __index_star_color = {
    ["0_2"] = 1,
    ["0_3"] = 7,
    ["0_4"] = 13,
    ["0_5"] = 19,
    ["0_6"] = 25,
    ["1_2"] = 2,
    ["1_3"] = 8,
    ["1_4"] = 14,
    ["1_5"] = 20,
    ["1_6"] = 26,
    ["2_2"] = 3,
    ["2_3"] = 9,
    ["2_4"] = 15,
    ["2_5"] = 21,
    ["2_6"] = 27,
    ["3_2"] = 4,
    ["3_3"] = 10,
    ["3_4"] = 16,
    ["3_5"] = 22,
    ["3_6"] = 28,
    ["4_2"] = 5,
    ["4_3"] = 11,
    ["4_4"] = 17,
    ["4_5"] = 23,
    ["4_6"] = 29,
    ["5_2"] = 6,
    ["5_3"] = 12,
    ["5_4"] = 18,
    ["5_5"] = 24,
    ["5_6"] = 30,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in pet_star_cost")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function pet_star_cost.length()
    return #pet_star_cost._data
end

-- 
function pet_star_cost.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pet_star_cost.indexOf(index)
    if index == nil or not pet_star_cost._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/pet_star_cost.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pet_star_cost" )
        return setmetatable({_raw = pet_star_cost._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = pet_star_cost._data[index]}, mt)
end

--
function pet_star_cost.get(star,color)
    
    local k = star .. '_' .. color
    return pet_star_cost.indexOf(__index_star_color[k])
        
end

--
function pet_star_cost.set(star,color, key, value)
    local record = pet_star_cost.get(star,color)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function pet_star_cost.index()
    return __index_star_color
end

return pet_star_cost