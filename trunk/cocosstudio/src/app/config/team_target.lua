--team_target

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  target = 1,    --具体目标-int 
  name = 2,    --名称-string 
  function_id = 3,    --function_id-int 
  level_min = 4,    --等级下限-int 
  level_max = 5,    --等级上限-int 
  people_number = 6,    --组队人数-int 
  agree_activity_time = 7,    --同意加入活动时间-int 

}

-- key type
local __key_type = {
  target = "int",    --具体目标-1 
  name = "string",    --名称-2 
  function_id = "int",    --function_id-3 
  level_min = "int",    --等级下限-4 
  level_max = "int",    --等级上限-5 
  people_number = "int",    --组队人数-6 
  agree_activity_time = "int",    --同意加入活动时间-7 

}


-- data
local team_target = {
    version =  1,
    _data = {
        [1] = {1,"先秦皇陵·上",861,80,120,3,10,},
        [2] = {2,"先秦皇陵·中",862,80,120,3,10,},
        [3] = {3,"先秦皇陵·下",863,80,120,3,10,},
    }
}

-- index
local __index_target = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in team_target")
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
function team_target.length()
    return #team_target._data
end

-- 
function team_target.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function team_target.isVersionValid(v)
    if team_target.version then
        if v then
            return team_target.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function team_target.indexOf(index)
    if index == nil or not team_target._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/team_target.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/team_target.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/team_target.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "team_target" )
                _isDataExist = team_target.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "team_target" )
                _isBaseExist = team_target.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "team_target" )
                _isExist = team_target.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "team_target" )
        local main_key = __main_key_map[index]
		local index_key = "__index_target"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "team_target" )
        local main_key = __main_key_map[index]
		local index_key = "__index_target"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = team_target._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "team_target" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function team_target.get(target)
    
    return team_target.indexOf(__index_target[target])
        
end

--
function team_target.set(target, key, value)
    local record = team_target.get(target)
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
function team_target.index()
    return __index_target
end

return team_target