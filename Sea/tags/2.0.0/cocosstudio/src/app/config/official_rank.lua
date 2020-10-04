--official_rank

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  name = 2,    --晋升名称-string 
  color = 3,    --主角品质-int 
  change_id = 4,    --是否更换id-int 
  combat_demand = 5,    --战力需求-int 
  type_1 = 6,    --道具1类型-int 
  value_1 = 7,    --道具1-int 
  size_1 = 8,    --道具1数量-int 
  type_2 = 9,    --道具2类型-int 
  value_2 = 10,    --道具2-int 
  size_2 = 11,    --道具2数量-int 
  attribute_type1 = 12,    --属性1类型-int 
  attribute_value1 = 13,    --属性1类型值-int 
  attribute_type2 = 14,    --属性2类型-int 
  attribute_value2 = 15,    --属性2类型值-int 
  attribute_type3 = 16,    --属性3类型-int 
  attribute_value3 = 17,    --属性3类型值-int 
  attribute_type4 = 18,    --属性4类型-int 
  attribute_value4 = 19,    --属性4类型值-int 
  all_combat = 20,    --总战力-int 
  picture = 21,    --图片-string 
  text_1 = 22,    --主界面提示文本-string 
  text_2 = 23,    --晋升提示文本-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  name = "string",    --晋升名称-2 
  color = "int",    --主角品质-3 
  change_id = "int",    --是否更换id-4 
  combat_demand = "int",    --战力需求-5 
  type_1 = "int",    --道具1类型-6 
  value_1 = "int",    --道具1-7 
  size_1 = "int",    --道具1数量-8 
  type_2 = "int",    --道具2类型-9 
  value_2 = "int",    --道具2-10 
  size_2 = "int",    --道具2数量-11 
  attribute_type1 = "int",    --属性1类型-12 
  attribute_value1 = "int",    --属性1类型值-13 
  attribute_type2 = "int",    --属性2类型-14 
  attribute_value2 = "int",    --属性2类型值-15 
  attribute_type3 = "int",    --属性3类型-16 
  attribute_value3 = "int",    --属性3类型值-17 
  attribute_type4 = "int",    --属性4类型-18 
  attribute_value4 = "int",    --属性4类型值-19 
  all_combat = "int",    --总战力-20 
  picture = "string",    --图片-21 
  text_1 = "string",    --主界面提示文本-22 
  text_2 = "string",    --晋升提示文本-23 

}


-- data
local official_rank = {
    _data = {
        [1] = {0,"平民",2,0,1000,6,22,1,0,0,0,1,0,5,0,6,0,7,0,0,"guanxianming_1","本次晋升新增主角缘分：防御中册—防御加成+70%","新增主角缘分：防御中册—防御加成+70%",},
        [2] = {1,"护军",3,1,100000,6,22,2,0,0,0,1,480,5,240,6,240,7,3600,12000,"guanxianming_2","","",},
        [3] = {2,"司马",3,0,160000,6,22,4,6,23,2,1,720,5,360,6,360,7,5400,36000,"guanxianming_3","本次晋升新增主角缘分：生命下册—生命加成+80%","新增主角缘分：生命下册—生命加成+80%",},
        [4] = {3,"都尉",4,1,320000,6,22,5,6,23,4,1,1280,5,640,6,640,7,9600,64000,"guanxianming_4","","",},
        [5] = {4,"校尉",4,0,1600000,6,22,5,6,24,4,1,1600,5,800,6,800,7,12000,120000,"guanxianming_5","","",},
        [6] = {5,"太守",4,0,4800000,6,22,8,6,24,8,1,2240,5,1120,6,1120,7,16800,360000,"guanxianming_6","","",},
        [7] = {6,"刺史",4,0,10800000,6,22,8,6,25,6,1,2880,5,1440,6,1440,7,21600,720000,"guanxianming_7","本次晋升新增主角缘分：攻击下册—攻击加成+70%","新增主角缘分：攻击下册—攻击加成+70%",},
        [8] = {7,"中郎将",5,1,18000000,6,22,10,6,25,12,1,3840,5,1920,6,1920,7,28800,1200000,"guanxianming_8","","",},
        [9] = {8,"京兆尹",5,0,27000000,6,22,10,6,26,8,1,4960,5,2480,6,2480,7,37200,2100000,"guanxianming_9","","",},
        [10] = {9,"尚书令",5,0,45000000,6,22,12,6,26,16,1,6240,5,3120,6,3120,7,46800,3200000,"guanxianming_10","","",},
        [11] = {10,"卫将军",5,0,60000000,6,22,12,6,27,12,1,7840,5,3920,6,3920,7,58800,5600000,"guanxianming_11","","",},
        [12] = {11,"大都督",6,1,81000000,6,22,15,6,27,24,1,9920,5,4960,6,4960,7,74400,7200000,"guanxianming_12","","",},
        [13] = {12,"大将军",6,0,0,0,0,0,0,0,0,1,12160,5,6080,6,6080,7,91200,10800000,"guanxianming_13","","",},
    }
}

-- index
local __index_id = {
    [0] = 1,
    [1] = 2,
    [10] = 11,
    [11] = 12,
    [12] = 13,
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
        assert(__key_map[k], "cannot find " .. k .. " in official_rank")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function official_rank.length()
    return #official_rank._data
end

-- 
function official_rank.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function official_rank.indexOf(index)
    if index == nil or not official_rank._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/official_rank.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "official_rank" )
        return setmetatable({_raw = official_rank._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = official_rank._data[index]}, mt)
end

--
function official_rank.get(id)
    
    return official_rank.indexOf(__index_id[id])
        
end

--
function official_rank.set(id, key, value)
    local record = official_rank.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function official_rank.index()
    return __index_id
end

return official_rank