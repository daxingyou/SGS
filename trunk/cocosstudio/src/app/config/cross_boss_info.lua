--cross_boss_info

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
  camp_1 = 5,    --破招阵营-string 
  camp_2 = 6,    --追击阵营-string 
  hero_id = 7,    --武将id-int 
  red_hero_id = 8,    --红将id-int 
  profile = 9,    --头像-string 
  spine = 10,    --spine资源-string 
  voice1 = 11,    --蓄力状态开始语音-string 
  voice2 = 12,    --破招失败语音-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  monster_team_id = "int",    --怪物组id-2 
  weight = "int",    --出现权重-3 
  name = "string",    --名称-4 
  camp_1 = "string",    --破招阵营-5 
  camp_2 = "string",    --追击阵营-6 
  hero_id = "int",    --武将id-7 
  red_hero_id = "int",    --红将id-8 
  profile = "string",    --头像-9 
  spine = "string",    --spine资源-10 
  voice1 = "string",    --蓄力状态开始语音-11 
  voice2 = "string",    --破招失败语音-12 

}


-- data
local cross_boss_info = {
    version =  1,
    _data = {
        [1] = {1,5500001,50,"子上","1","2|3|4",150,101,"btn_main_enter_crossboss1","1502150","1502150_voice2","1502150_skill",},
        [2] = {2,5500002,50,"水镜","2","1|3|4",250,201,"btn_main_enter_crossboss2","1502250","1502250_voice2","1502250_skill",},
        [3] = {3,5500003,50,"周姬","3","1|2|4",350,301,"btn_main_enter_crossboss3","1502350","1502350_voice2","1502350_skill",},
        [4] = {4,5500004,50,"南华","4","1|2|3",450,401,"btn_main_enter_crossboss4","1502450","1502450_skill","1502450_skill",},
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
        assert(key_map[k], "cannot find " .. k .. " in cross_boss_info")
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
function cross_boss_info.length()
    return #cross_boss_info._data
end

-- 
function cross_boss_info.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cross_boss_info.isVersionValid(v)
    if cross_boss_info.version then
        if v then
            return cross_boss_info.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cross_boss_info.indexOf(index)
    if index == nil or not cross_boss_info._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cross_boss_info.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cross_boss_info.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cross_boss_info.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cross_boss_info" )
                _isDataExist = cross_boss_info.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cross_boss_info" )
                _isBaseExist = cross_boss_info.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cross_boss_info" )
                _isExist = cross_boss_info.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cross_boss_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cross_boss_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cross_boss_info._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cross_boss_info" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cross_boss_info.get(id)
    
    return cross_boss_info.indexOf(__index_id[id])
        
end

--
function cross_boss_info.set(id, key, value)
    local record = cross_boss_info.get(id)
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
function cross_boss_info.index()
    return __index_id
end

return cross_boss_info