--type_manage

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --资源类型编号-int 
  name = 2,    --名称-string 
  table = 3,    --相关表格-string 
  drop_group = 4,    --掉落分组-int 
  order = 5,    --排序id-int 

}

-- key type
local __key_type = {
  id = "int",    --资源类型编号-1 
  name = "string",    --名称-2 
  table = "string",    --相关表格-3 
  drop_group = "int",    --掉落分组-4 
  order = "int",    --排序id-5 

}


-- data
local type_manage = {
    version =  1,
    _data = {
        [1] = {1,"武将","hero",1,1,},
        [2] = {2,"装备","equipment",2,2,},
        [3] = {3,"宝物","treasure",3,3,},
        [4] = {4,"神兵","instrument",3,4,},
        [5] = {5,"资源","resource",0,5,},
        [6] = {6,"道具","item",0,6,},
        [7] = {7,"碎片","fragment",0,7,},
        [8] = {8,"宝石","gemstone",0,8,},
        [9] = {9,"变身卡","avatar",0,9,},
        [10] = {10,"神兽","pet",0,10,},
        [11] = {11,"锦囊","silkbag",0,11,},
        [12] = {12,"战马","horse",0,12,},
        [13] = {13,"历代名将","historical_hero",0,13,},
        [14] = {14,"历代名将武器","historical_hero_equipment",0,14,},
        [15] = {15,"战马装备","horse_equipment",0,15,},
        [16] = {16,"玉石","jade",0,16,},
        [17] = {17,"头像框","head_frame",0,17,},
        [18] = {18,"称号","title",0,18,},
        [19] = {19,"军团旗帜","guild_true_flag",0,19,},
        [20] = {25,"战法","tactics",0,25,},
        [21] = {50,"主界面背景","main_scene",0,50,},
        [22] = {80,"看板娘皮肤","skin",0,80,},
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
    [25] = 20,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [50] = 21,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [80] = 22,
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
    [20] = 25,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [21] = 50,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [22] = 80,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in type_manage")
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
function type_manage.length()
    return #type_manage._data
end

-- 
function type_manage.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function type_manage.isVersionValid(v)
    if type_manage.version then
        if v then
            return type_manage.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function type_manage.indexOf(index)
    if index == nil or not type_manage._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/type_manage.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/type_manage.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/type_manage.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "type_manage" )
                _isDataExist = type_manage.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "type_manage" )
                _isBaseExist = type_manage.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "type_manage" )
                _isExist = type_manage.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "type_manage" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "type_manage" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = type_manage._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "type_manage" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function type_manage.get(id)
    
    return type_manage.indexOf(__index_id[id])
        
end

--
function type_manage.set(id, key, value)
    local record = type_manage.get(id)
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
function type_manage.index()
    return __index_id
end

return type_manage