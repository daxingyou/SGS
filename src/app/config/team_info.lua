--team_info

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  function_id = 2,    --活动类型(function_id)-int 
  target = 3,    --具体目标-string 
  refuse_time = 4,    --拒绝组队邀请时间-int 
  agree_time = 5,    --同意转让队长时间-int 
  refuse_join_time = 6,    --拒绝入队申请时间-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  function_id = "int",    --活动类型(function_id)-2 
  target = "string",    --具体目标-3 
  refuse_time = "int",    --拒绝组队邀请时间-4 
  agree_time = "int",    --同意转让队长时间-5 
  refuse_join_time = "int",    --拒绝入队申请时间-6 

}


-- data
local team_info = {
    version =  1,
    _data = {
        [1] = {1,860,"1|2|3",10,10,60,},
    }
}

-- index
local __index_id = {
    [1] = 1,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in team_info")
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
function team_info.length()
    return #team_info._data
end

-- 
function team_info.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function team_info.isVersionValid(v)
    if team_info.version then
        if v then
            return team_info.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function team_info.indexOf(index)
    if index == nil or not team_info._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/team_info.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/team_info.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/team_info.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "team_info" )
                _isDataExist = team_info.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "team_info" )
                _isBaseExist = team_info.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "team_info" )
                _isExist = team_info.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "team_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "team_info" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = team_info._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "team_info" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function team_info.get(id)
    
    return team_info.indexOf(__index_id[id])
        
end

--
function team_info.set(id, key, value)
    local record = team_info.get(id)
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
function team_info.index()
    return __index_id
end

return team_info