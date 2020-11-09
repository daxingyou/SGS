--cross_minecraft_monster

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  monster_team_id = 2,    --怪物组id-int 
  hp_parameter = 3,    --血量系数-int 
  time_limit = 4,    --击杀时间限制（秒）-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  monster_team_id = "int",    --怪物组id-2 
  hp_parameter = "int",    --血量系数-3 
  time_limit = "int",    --击杀时间限制（秒）-4 

}


-- data
local cross_minecraft_monster = {
    version =  1,
    _data = {
        [1] = {1,5500001,1,600,},
        [2] = {2,5500002,1,600,},
        [3] = {3,5500003,1,600,},
        [4] = {4,5500004,1,600,},
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
        assert(key_map[k], "cannot find " .. k .. " in cross_minecraft_monster")
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
function cross_minecraft_monster.length()
    return #cross_minecraft_monster._data
end

-- 
function cross_minecraft_monster.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function cross_minecraft_monster.isVersionValid(v)
    if cross_minecraft_monster.version then
        if v then
            return cross_minecraft_monster.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function cross_minecraft_monster.indexOf(index)
    if index == nil or not cross_minecraft_monster._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/cross_minecraft_monster.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/cross_minecraft_monster.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/cross_minecraft_monster.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "cross_minecraft_monster" )
                _isDataExist = cross_minecraft_monster.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "cross_minecraft_monster" )
                _isBaseExist = cross_minecraft_monster.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "cross_minecraft_monster" )
                _isExist = cross_minecraft_monster.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "cross_minecraft_monster" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "cross_minecraft_monster" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = cross_minecraft_monster._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "cross_minecraft_monster" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function cross_minecraft_monster.get(id)
    
    return cross_minecraft_monster.indexOf(__index_id[id])
        
end

--
function cross_minecraft_monster.set(id, key, value)
    local record = cross_minecraft_monster.get(id)
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
function cross_minecraft_monster.index()
    return __index_id
end

return cross_minecraft_monster