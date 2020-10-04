--historical_hero_equipment

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  color = 2,    --品质-int 
  name = 3,    --名称-string 
  res_id = 4,    --资源id-int 
  fragment_id = 5,    --碎片id-int 
  short_description = 6,    --装备短描述-string 
  long_description = 7,    --装备详细描述-string 
  historical_hero = 8,    --适用名将-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  color = "int",    --品质-2 
  name = "string",    --名称-3 
  res_id = "int",    --资源id-4 
  fragment_id = "int",    --碎片id-5 
  short_description = "string",    --装备短描述-6 
  long_description = "string",    --装备详细描述-7 
  historical_hero = "int",    --适用名将-8 

}


-- data
local historical_hero_equipment = {
    version =  1,
    _data = {
        [1] = {101,4,"号钟古琴",101,0,"高渐离专属装备，增加护佑武将生命","高渐离专属兵器，额外增加高渐离护佑武将生命5%",101,},
        [2] = {102,4,"惊龙利刃",102,0,"阿珂专属装备，增加护佑武将伤害","阿轲专属兵器，额外增加阿轲护佑武将伤害5%",102,},
        [3] = {103,4,"寒光银枪",103,0,"韩信专属装备，增加护佑武将攻击","韩信专属兵器，额外增加韩信护佑武将攻击5%",103,},
        [4] = {104,4,"凌虚御笔",104,0,"张良专属装备，增加护佑武将免伤","张良专属兵器，额外增加张良护佑武将免伤5%",104,},
        [5] = {201,5,"定秦长剑",201,140001,"秦始皇专属装备，减免受到的直接伤害","秦始皇专属兵器，护佑武将受到其他武将的直接伤害额外降低9%，受到异常（麻痹，眩晕，沉默，灼烧，中毒，虚弱，压制，铁索，击飞）效果的概率降低12%",201,},
        [6] = {202,5,"八服汉剑",202,140002,"汉武帝专属装备，增加护佑武将伤害","汉武帝专属兵器，额外增加汉武帝护佑武将伤害以及治疗9%，暴击伤害24%",202,},
        [7] = {203,5,"霸王长枪",203,140003,"项羽专属装备，增加己方神兽效果","项羽专属兵器，护佑武将受到己方青龙，朱雀，玄武施加的有益效果时，效果额外再增加25%（怒气无额外增加）",203,},
        [8] = {204,5,"含光琵琶",204,140004,"虞姬专属装备，护佑武将清除异常","护佑武将受到武将的直接伤害时，100%几率清除自身1个灼烧或中毒状态",204,},
    }
}

-- index
local __index_id = {
    [101] = 1,
    [102] = 2,
    [103] = 3,
    [104] = 4,
    [201] = 5,
    [202] = 6,
    [203] = 7,
    [204] = 8,

}

-- index mainkey map
local __main_key_map = {
    [1] = 101,
    [2] = 102,
    [3] = 103,
    [4] = 104,
    [5] = 201,
    [6] = 202,
    [7] = 203,
    [8] = 204,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in historical_hero_equipment")
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
function historical_hero_equipment.length()
    return #historical_hero_equipment._data
end

-- 
function historical_hero_equipment.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function historical_hero_equipment.isVersionValid(v)
    if historical_hero_equipment.version then
        if v then
            return historical_hero_equipment.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function historical_hero_equipment.indexOf(index)
    if index == nil or not historical_hero_equipment._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/historical_hero_equipment.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/historical_hero_equipment.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/historical_hero_equipment.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "historical_hero_equipment" )
                _isDataExist = historical_hero_equipment.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "historical_hero_equipment" )
                _isBaseExist = historical_hero_equipment.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero_equipment" )
                _isExist = historical_hero_equipment.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "historical_hero_equipment" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero_equipment" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = historical_hero_equipment._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "historical_hero_equipment" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function historical_hero_equipment.get(id)
    
    return historical_hero_equipment.indexOf(__index_id[id])
        
end

--
function historical_hero_equipment.set(id, key, value)
    local record = historical_hero_equipment.get(id)
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
function historical_hero_equipment.index()
    return __index_id
end

return historical_hero_equipment