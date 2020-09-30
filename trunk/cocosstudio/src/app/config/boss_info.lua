--boss_info

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  monster_team_id = 2,    --怪物组id-int 
  weight = 3,    --出现权重-int 
  name = 4,    --名称-string 
  hero_id = 5,    --武将id-int 
  silk_bag = 6,    --对应紫锦囊-int 
  silk_bag101 = 7,    --对应橙锦囊1-int 
  silk_bag102 = 8,    --对应橙锦囊2-int 
  image = 9,    --名称图片-string 
  cartoon = 10,    --出场动画-string 
  current_image = 11,    --活动未开启时形象-string 
  boss_bubble = 12,    --boss对话-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  monster_team_id = "int",    --怪物组id-2 
  weight = "int",    --出现权重-3 
  name = "string",    --名称-4 
  hero_id = "int",    --武将id-5 
  silk_bag = "int",    --对应紫锦囊-6 
  silk_bag101 = "int",    --对应橙锦囊1-7 
  silk_bag102 = "int",    --对应橙锦囊2-8 
  image = "string",    --名称图片-9 
  cartoon = "string",    --出场动画-10 
  current_image = "string",    --活动未开启时形象-11 
  boss_bubble = "string",    --boss对话-12 

}


-- data
local boss_info = {
    version =  1,
    _data = {
        [1] = {1,5300001,50,"军师司马懿",101,1108,1223,1220,"txt_boss_lvbu01","0","img_boss_zhangjiao","1401|1402|1403|1404",},
        [2] = {2,5300002,50,"小霸王孙策",301,1103,1203,1222,"txt_boss_sunce01","0","img_boss_zhangjiao","1401|1402|1403|1404",},
        [3] = {3,5300003,50,"常山赵子龙",201,1101,1202,1216,"txt_boss_zhaoyun01","0","img_boss_zhangjiao","1401|1402|1403|1404",},
        [4] = {4,5300004,50,"玄天左慈",401,1104,1204,1221,"txt_boss_caocao01","0","img_boss_zhangjiao","1401|1402|1403|1404",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in boss_info")
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
function boss_info.length()
    return #boss_info._data
end

-- 
function boss_info.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function boss_info.isVersionValid(v)
    if boss_info.version then
        if v then
            return boss_info.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function boss_info.indexOf(index)
    if index == nil or not boss_info._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/boss_info.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/boss_info.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/boss_info.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "boss_info" )
                _isDataExist = boss_info.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "boss_info" )
                _isBaseExist = boss_info.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "boss_info" )
                _isExist = boss_info.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "boss_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "boss_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = boss_info._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "boss_info" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function boss_info.get(id)
    
    return boss_info.indexOf(__index_id[id])
        
end

--
function boss_info.set(id, key, value)
    local record = boss_info.get(id)
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
function boss_info.index()
    return __index_id
end

return boss_info