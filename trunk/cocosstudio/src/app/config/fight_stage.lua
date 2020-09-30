--fight_stage

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --阶段-int 
  first = 2,    --先后手（1-先手,2-后手,3-双方）-int 
  action = 3,    --行动（1-选人,2-ban人,3-等待）-int 
  number = 4,    --人数-int 
  time = 5,    --时间（秒）-int 

}

-- key type
local __key_type = {
  id = "int",    --阶段-1 
  first = "int",    --先后手（1-先手,2-后手,3-双方）-2 
  action = "int",    --行动（1-选人,2-ban人,3-等待）-3 
  number = "int",    --人数-4 
  time = "int",    --时间（秒）-5 

}


-- data
local fight_stage = {
    version =  1,
    _data = {
        [1] = {1,2,1,1,47,},
        [2] = {2,1,1,2,45,},
        [3] = {3,2,1,2,45,},
        [4] = {4,1,1,2,45,},
        [5] = {5,2,1,2,45,},
        [6] = {6,1,1,2,45,},
        [7] = {7,2,1,1,45,},
        [8] = {8,3,3,0,10,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in fight_stage")
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
function fight_stage.length()
    return #fight_stage._data
end

-- 
function fight_stage.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function fight_stage.isVersionValid(v)
    if fight_stage.version then
        if v then
            return fight_stage.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function fight_stage.indexOf(index)
    if index == nil or not fight_stage._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/fight_stage.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/fight_stage.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/fight_stage.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "fight_stage" )
                _isDataExist = fight_stage.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "fight_stage" )
                _isBaseExist = fight_stage.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "fight_stage" )
                _isExist = fight_stage.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "fight_stage" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "fight_stage" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = fight_stage._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "fight_stage" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function fight_stage.get(id)
    
    return fight_stage.indexOf(__index_id[id])
        
end

--
function fight_stage.set(id, key, value)
    local record = fight_stage.get(id)
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
function fight_stage.index()
    return __index_id
end

return fight_stage