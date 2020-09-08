--equipment_level_critical

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  templet = 1,    --装备模板-int 
  critical1_level = 2,    --暴击1倍数-int 
  critical1_chance = 3,    --暴击1概率-int 
  critical2_level = 4,    --暴击2倍数-int 
  critical2_chance = 5,    --暴击2概率-int 
  critical3_level = 6,    --暴击3倍数-int 
  critical3_chance = 7,    --暴击3概率-int 

}

-- key type
local __key_type = {
  templet = "int",    --装备模板-1 
  critical1_level = "int",    --暴击1倍数-2 
  critical1_chance = "int",    --暴击1概率-3 
  critical2_level = "int",    --暴击2倍数-4 
  critical2_chance = "int",    --暴击2概率-5 
  critical3_level = "int",    --暴击3倍数-6 
  critical3_chance = "int",    --暴击3概率-7 

}


-- data
local equipment_level_critical = {
    version =  1,
    _data = {
        [1] = {1,1,65,2,25,3,10,},
        [2] = {2,1,65,2,25,3,10,},
        [3] = {3,1,65,2,25,3,10,},
        [4] = {4,1,65,2,25,3,10,},
    }
}

-- index
local __index_templet = {
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
        assert(key_map[k], "cannot find " .. k .. " in equipment_level_critical")
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
function equipment_level_critical.length()
    return #equipment_level_critical._data
end

-- 
function equipment_level_critical.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function equipment_level_critical.isVersionValid(v)
    if equipment_level_critical.version then
        if v then
            return equipment_level_critical.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function equipment_level_critical.indexOf(index)
    if index == nil or not equipment_level_critical._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/equipment_level_critical.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/equipment_level_critical.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/equipment_level_critical.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "equipment_level_critical" )
                _isDataExist = equipment_level_critical.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "equipment_level_critical" )
                _isBaseExist = equipment_level_critical.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "equipment_level_critical" )
                _isExist = equipment_level_critical.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "equipment_level_critical" )
        local main_key = __main_key_map[index]
		local index_key = "__index_templet"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "equipment_level_critical" )
        local main_key = __main_key_map[index]
		local index_key = "__index_templet"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = equipment_level_critical._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "equipment_level_critical" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function equipment_level_critical.get(templet)
    
    return equipment_level_critical.indexOf(__index_templet[templet])
        
end

--
function equipment_level_critical.set(templet, key, value)
    local record = equipment_level_critical.get(templet)
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
function equipment_level_critical.index()
    return __index_templet
end

return equipment_level_critical