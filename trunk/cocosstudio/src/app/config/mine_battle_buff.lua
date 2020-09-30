--mine_battle_buff

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  buff_id = 1,    --id-int 
  buff_type = 2,    --类型-int 
  buff_value = 3,    --类型值-int 
  plus_minus = 4,    --加减-int 
  attr_type_1 = 5,    --属性1-int 
  attr_value_1 = 6,    --属性值1-int 
  attr_type_2 = 7,    --属性2-int 
  attr_value_2 = 8,    --属性值2-int 
  buff_name = 9,    --类型名称-string 
  buff_res = 10,    --类型资源-string 
  buff_txt = 11,    --类型描述-string 

}

-- key type
local __key_type = {
  buff_id = "int",    --id-1 
  buff_type = "int",    --类型-2 
  buff_value = "int",    --类型值-3 
  plus_minus = "int",    --加减-4 
  attr_type_1 = "int",    --属性1-5 
  attr_value_1 = "int",    --属性值1-6 
  attr_type_2 = "int",    --属性2-7 
  attr_value_2 = "int",    --属性值2-8 
  buff_name = "string",    --类型名称-9 
  buff_res = "string",    --类型资源-10 
  buff_txt = "string",    --类型描述-11 

}


-- data
local mine_battle_buff = {
    version =  1,
    _data = {
        [1] = {101,1,50,2,19,50,20,50,"疲劳","img_mine_pi","疲劳值50，战斗中伤害降低5%",},
        [2] = {102,1,55,2,19,100,20,100,"疲劳","img_mine_pi","疲劳值55，战斗中伤害降低10%",},
        [3] = {103,1,60,2,19,150,20,150,"疲劳","img_mine_pi","疲劳值60，战斗中伤害降低15%",},
        [4] = {104,1,65,2,19,200,20,200,"疲劳","img_mine_pi","疲劳值65，战斗中伤害降低20%",},
        [5] = {105,1,70,2,19,250,20,250,"疲劳","img_mine_pi","疲劳值70，战斗中伤害降低25%",},
        [6] = {106,1,75,2,19,300,20,300,"疲劳","img_mine_pi","疲劳值75，战斗中伤害降低30%",},
        [7] = {107,1,80,2,19,350,20,350,"疲劳","img_mine_pi","疲劳值80，战斗中伤害降低35%",},
        [8] = {108,1,85,2,19,400,20,400,"疲劳","img_mine_pi","疲劳值85，战斗中伤害降低40%",},
        [9] = {109,1,90,2,19,450,20,450,"疲劳","img_mine_pi","疲劳值90，战斗中伤害降低45%",},
        [10] = {110,1,100,2,19,500,20,500,"疲劳","img_mine_pi","疲劳值100，战斗中伤害降低50%",},
        [11] = {200,2,0,1,20,100,0,0,"霸占","img_mine_ba","所在军团独占当前矿区，战斗中受到的伤害降低10%",},
    }
}

-- index
local __index_buff_id = {
    [101] = 1,
    [102] = 2,
    [103] = 3,
    [104] = 4,
    [105] = 5,
    [106] = 6,
    [107] = 7,
    [108] = 8,
    [109] = 9,
    [110] = 10,
    [200] = 11,

}

-- index mainkey map
local __main_key_map = {
    [1] = 101,
    [2] = 102,
    [3] = 103,
    [4] = 104,
    [5] = 105,
    [6] = 106,
    [7] = 107,
    [8] = 108,
    [9] = 109,
    [10] = 110,
    [11] = 200,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in mine_battle_buff")
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
function mine_battle_buff.length()
    return #mine_battle_buff._data
end

-- 
function mine_battle_buff.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function mine_battle_buff.isVersionValid(v)
    if mine_battle_buff.version then
        if v then
            return mine_battle_buff.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function mine_battle_buff.indexOf(index)
    if index == nil or not mine_battle_buff._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/mine_battle_buff.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/mine_battle_buff.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/mine_battle_buff.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "mine_battle_buff" )
                _isDataExist = mine_battle_buff.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "mine_battle_buff" )
                _isBaseExist = mine_battle_buff.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "mine_battle_buff" )
                _isExist = mine_battle_buff.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "mine_battle_buff" )
        local main_key = __main_key_map[index]
		local index_key = "__index_buff_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "mine_battle_buff" )
        local main_key = __main_key_map[index]
		local index_key = "__index_buff_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = mine_battle_buff._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "mine_battle_buff" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function mine_battle_buff.get(buff_id)
    
    return mine_battle_buff.indexOf(__index_buff_id[buff_id])
        
end

--
function mine_battle_buff.set(buff_id, key, value)
    local record = mine_battle_buff.get(buff_id)
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
function mine_battle_buff.index()
    return __index_buff_id
end

return mine_battle_buff