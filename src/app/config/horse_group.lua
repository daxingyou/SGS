--horse_group

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  name = 2,    --图鉴名称-string 
  horse1 = 3,    --战马1-int 
  horse2 = 4,    --战马2-int 
  attribute_type_1 = 5,    --属性类型1-int 
  attribute_value_1 = 6,    --属性值1-int 
  attribute_type_2 = 7,    --属性类型2-int 
  attribute_value_2 = 8,    --属性值2-int 
  attribute_type_3 = 9,    --属性类型3-int 
  attribute_value_3 = 10,    --属性值3-int 
  attribute_type_4 = 11,    --属性类型4-int 
  attribute_value_4 = 12,    --属性值4-int 
  all_combat = 13,    --假战力-int 
  show_day = 14,    --达到开服天数显示-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  name = "string",    --图鉴名称-2 
  horse1 = "int",    --战马1-3 
  horse2 = "int",    --战马2-4 
  attribute_type_1 = "int",    --属性类型1-5 
  attribute_value_1 = "int",    --属性值1-6 
  attribute_type_2 = "int",    --属性类型2-7 
  attribute_value_2 = "int",    --属性值2-8 
  attribute_type_3 = "int",    --属性类型3-9 
  attribute_value_3 = "int",    --属性值3-10 
  attribute_type_4 = "int",    --属性类型4-11 
  attribute_value_4 = "int",    --属性值4-12 
  all_combat = "int",    --假战力-13 
  show_day = "int",    --达到开服天数显示-14 

}


-- data
local horse_group = {
    version =  1,
    _data = {
        [1] = {1,"绿影摇青",1,2,1,200,7,1500,0,0,0,0,60000,1,},
        [2] = {2,"采黄掷枣",3,4,1,200,7,1500,0,0,0,0,60000,1,},
        [3] = {3,"露从夜白",5,6,1,800,7,6000,0,0,0,0,240000,1,},
        [4] = {4,"碧染红林",7,8,1,800,7,6000,0,0,0,0,240000,1,},
        [5] = {5,"庭飞白雪",9,5,1,1000,7,7500,20,50,0,0,480000,1,},
        [6] = {6,"崖生紫云",10,6,1,1000,7,7500,19,50,0,0,480000,1,},
        [7] = {7,"玉脂红胭",11,7,1,1000,7,7500,20,50,0,0,480000,1,},
        [8] = {8,"月照碧影",12,8,1,1000,7,7500,19,50,0,0,480000,1,},
        [9] = {11,"电光火石",15,7,1,1000,7,7500,19,50,0,0,480000,1,},
        [10] = {12,"月明星稀",16,8,1,1000,7,7500,20,50,0,0,480000,1,},
        [11] = {14,"黑白分明",17,5,1,1000,7,7500,20,50,0,0,480000,1,},
        [12] = {9,"拂霜吹雪",9,10,1,1200,7,9000,20,80,11,120,960000,1,},
        [13] = {10,"红阑夜火",11,12,1,1200,7,9000,19,80,8,120,960000,1,},
        [14] = {13,"烈火迅雷",16,15,1,1200,7,9000,19,80,8,120,960000,1,},
        [15] = {15,"截然不同",17,16,1,1200,7,9000,19,80,8,120,960000,1,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 13,
    [11] = 9,
    [12] = 10,
    [13] = 14,
    [14] = 11,
    [15] = 15,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 12,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [13] = 10,
    [9] = 11,
    [10] = 12,
    [14] = 13,
    [11] = 14,
    [15] = 15,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [12] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in horse_group")
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
function horse_group.length()
    return #horse_group._data
end

-- 
function horse_group.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function horse_group.isVersionValid(v)
    if horse_group.version then
        if v then
            return horse_group.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function horse_group.indexOf(index)
    if index == nil or not horse_group._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/horse_group.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/horse_group.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/horse_group.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "horse_group" )
                _isDataExist = horse_group.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "horse_group" )
                _isBaseExist = horse_group.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "horse_group" )
                _isExist = horse_group.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "horse_group" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "horse_group" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = horse_group._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "horse_group" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function horse_group.get(id)
    
    return horse_group.indexOf(__index_id[id])
        
end

--
function horse_group.set(id, key, value)
    local record = horse_group.get(id)
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
function horse_group.index()
    return __index_id
end

return horse_group