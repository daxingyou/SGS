--pet_map

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  name = 2,    --图鉴名称-string 
  pet1 = 3,    --神兽1-int 
  pet2 = 4,    --神兽2-int 
  pet3 = 5,    --神兽3-int 
  attribute_type_1 = 6,    --属性类型1-int 
  attribute_value_1 = 7,    --属性值1-int 
  attribute_type_2 = 8,    --属性类型2-int 
  attribute_value_2 = 9,    --属性值2-int 
  attribute_type_3 = 10,    --属性类型3-int 
  attribute_value_3 = 11,    --属性值3-int 
  attribute_type_4 = 12,    --属性类型4-int 
  attribute_value_4 = 13,    --属性值4-int 
  attribute_type_5 = 14,    --属性类型5-int 
  attribute_value_5 = 15,    --属性值5-int 
  all_combat = 16,    --总战力-int 
  show = 17,    --是否显示-int 
  show_day = 18,    --达到开服天数显示-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  name = "string",    --图鉴名称-2 
  pet1 = "int",    --神兽1-3 
  pet2 = "int",    --神兽2-4 
  pet3 = "int",    --神兽3-5 
  attribute_type_1 = "int",    --属性类型1-6 
  attribute_value_1 = "int",    --属性值1-7 
  attribute_type_2 = "int",    --属性类型2-8 
  attribute_value_2 = "int",    --属性值2-9 
  attribute_type_3 = "int",    --属性类型3-10 
  attribute_value_3 = "int",    --属性值3-11 
  attribute_type_4 = "int",    --属性类型4-12 
  attribute_value_4 = "int",    --属性值4-13 
  attribute_type_5 = "int",    --属性类型5-14 
  attribute_value_5 = "int",    --属性值5-15 
  all_combat = "int",    --总战力-16 
  show = "int",    --是否显示-17 
  show_day = "int",    --达到开服天数显示-18 

}


-- data
local pet_map = {
    _data = {
        [1] = {1,"钟灵毓秀",1,2,0,1,200,7,1500,0,0,0,0,105,60000,60000,1,1,},
        [2] = {2,"霁风朗月",3,4,0,46,60,1,320,7,2400,0,0,105,240000,240000,1,1,},
        [3] = {3,"水火不容",3,6,0,46,100,1,640,7,4800,0,0,105,480000,480000,1,21,},
        [4] = {4,"月舞神殇",4,6,0,47,100,1,640,7,4800,0,0,105,480000,480000,1,21,},
        [5] = {5,"漫天烽火",8,3,0,47,100,1,640,7,4800,0,0,105,480000,480000,1,21,},
        [6] = {6,"绝天龙牙",8,6,0,46,120,1,1280,7,9600,0,0,105,960000,960000,1,21,},
        [7] = {7,"楚竹惊鸾",9,4,0,47,120,1,640,7,4800,0,0,105,480000,480000,1,21,},
        [8] = {8,"天外行云",9,8,0,46,100,1,1280,7,9600,0,0,105,960000,960000,1,21,},
        [9] = {9,"惊雷炎火",5,3,0,46,100,1,640,7,4800,0,0,105,480000,480000,1,10,},
        [10] = {10,"森罗万象",5,4,0,47,100,1,640,7,4800,0,0,105,480000,480000,1,10,},
        [11] = {11,"霞姿月韵",10,9,0,46,120,1,1280,7,9600,0,0,105,960000,960000,1,50,},
        [12] = {12,"清风霁月",10,5,0,47,120,1,1280,7,9600,0,0,105,960000,960000,1,50,},
        [13] = {13,"红煌流星",7,10,0,46,120,1,1280,7,9600,0,0,105,960000,960000,1,50,},
        [14] = {14,"绝云烈日",7,5,0,47,120,1,1280,7,9600,0,0,105,960000,960000,1,50,},
        [15] = {15,"破炎",11,7,0,46,120,1,1280,7,9600,0,0,105,960000,960000,1,999,},
        [16] = {16,"破云",11,5,0,47,120,1,1280,7,9600,0,0,105,960000,960000,1,999,},
        [17] = {17,"逢凶化吉",12,11,0,46,120,1,1280,7,9600,0,0,105,960000,960000,1,999,},
        [18] = {18,"地火天雷",12,10,0,47,120,1,1280,7,9600,0,0,105,960000,960000,1,999,},
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
        assert(__key_map[k], "cannot find " .. k .. " in pet_map")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function pet_map.length()
    return #pet_map._data
end

-- 
function pet_map.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function pet_map.indexOf(index)
    if index == nil or not pet_map._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/pet_map.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "pet_map" )
        return setmetatable({_raw = pet_map._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = pet_map._data[index]}, mt)
end

--
function pet_map.get(id)
    
    return pet_map.indexOf(__index_id[id])
        
end

--
function pet_map.set(id, key, value)
    local record = pet_map.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function pet_map.index()
    return __index_id
end

return pet_map