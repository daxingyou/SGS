--horse_equipment

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  name = 2,    --装备名称-string 
  type = 3,    --装备类型-int 
  color = 4,    --品质-int 
  res_id = 5,    --资源id-string 
  description = 6,    --装备描述-string 
  fragment_id = 7,    --碎片id-int 
  attribute_type_1 = 8,    --属性类型1-int 
  attribute_value_1 = 9,    --属性值1-int 
  attribute_type_2 = 10,    --属性类型2-int 
  attribute_value_2 = 11,    --属性值2-int 
  attribute_type_3 = 12,    --属性类型3-int 
  attribute_value_3 = 13,    --属性值3-int 
  attribute_type_4 = 14,    --属性类型4-int 
  attribute_value_4 = 15,    --属性值4-int 
  all_combat = 16,    --假战力-int 
  moving = 17,    --装备特效-string 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  name = "string",    --装备名称-2 
  type = "int",    --装备类型-3 
  color = "int",    --品质-4 
  res_id = "string",    --资源id-5 
  description = "string",    --装备描述-6 
  fragment_id = "int",    --碎片id-7 
  attribute_type_1 = "int",    --属性类型1-8 
  attribute_value_1 = "int",    --属性值1-9 
  attribute_type_2 = "int",    --属性类型2-10 
  attribute_value_2 = "int",    --属性值2-11 
  attribute_type_3 = "int",    --属性类型3-12 
  attribute_value_3 = "int",    --属性值3-13 
  attribute_type_4 = "int",    --属性类型4-14 
  attribute_value_4 = "int",    --属性值4-15 
  all_combat = "int",    --假战力-16 
  moving = "string",    --装备特效-17 

}


-- data
local horse_equipment = {
    version =  1,
    _data = {
        [1] = {101,"白玉马鞍",1,4,"101","白玉制成的马鞍，极为名贵。",150101,7,64500,0,0,0,0,0,0,720000,"0",},
        [2] = {102,"紫金马镫",2,4,"102","紫金镶嵌的马镫，彰显气质。",150102,4,4500,0,0,0,0,0,0,720000,"0",},
        [3] = {103,"银环缰绳",3,4,"103","蓝缎制成的缰绳，尽享丝滑。",150103,1,9000,0,0,0,0,0,0,720000,"0",},
        [4] = {201,"沧海碧蛟鞍",1,5,"201","据说有蛟龙的灵魂附着其上，保佑征战无往不胜。",150201,7,172000,0,0,0,0,0,0,2500000,"0",},
        [5] = {202,"大漠苍狼镫",2,5,"202","有苍狼之灵保佑的马镫，默默守护着主人。",150202,4,12000,0,0,0,0,0,0,2500000,"0",},
        [6] = {203,"烈日腾蛇缰",3,5,"203","牵着附有腾蛇气息的缰绳，骑马时如腾云驾雾一般。",150203,1,24000,0,0,0,0,0,0,2500000,"0",},
    }
}

-- index
local __index_id = {
    [101] = 1,
    [102] = 2,
    [103] = 3,
    [201] = 4,
    [202] = 5,
    [203] = 6,

}

-- index mainkey map
local __main_key_map = {
    [1] = 101,
    [2] = 102,
    [3] = 103,
    [4] = 201,
    [5] = 202,
    [6] = 203,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in horse_equipment")
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
function horse_equipment.length()
    return #horse_equipment._data
end

-- 
function horse_equipment.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function horse_equipment.isVersionValid(v)
    if horse_equipment.version then
        if v then
            return horse_equipment.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function horse_equipment.indexOf(index)
    if index == nil or not horse_equipment._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/horse_equipment.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/horse_equipment.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/horse_equipment.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "horse_equipment" )
                _isDataExist = horse_equipment.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "horse_equipment" )
                _isBaseExist = horse_equipment.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "horse_equipment" )
                _isExist = horse_equipment.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "horse_equipment" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "horse_equipment" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = horse_equipment._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "horse_equipment" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function horse_equipment.get(id)
    
    return horse_equipment.indexOf(__index_id[id])
        
end

--
function horse_equipment.set(id, key, value)
    local record = horse_equipment.get(id)
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
function horse_equipment.index()
    return __index_id
end

return horse_equipment