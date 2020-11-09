--formula

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  formula = 2,    --公式-string 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  formula = "string",    --公式-2 

}


-- data
local formula = {
    version =  1,
    _data = {
        [1] = {1,"(($ATK$*9+$PD$*27+$MD$*27+$HP$*1)*($HURT$+$HURT_RED$+$PVP_HURT$+$PVP_HURT_RED$+$HIT$+$NO_HIT$+$CRIT$+$NO_CRIT$+$CRIT_HURT$+$CRIT_HURT_RED$))/5+$TALENT_POWER$",},
        [2] = {2,"$HERO_POWER$+$OFFICIAL_POWER$",},
        [3] = {3,"((#ATK#*9+#PD#*27+#MD#*27+#HP#*1)*(#HURT#+#HURT_RED#+#PVP_HURT#+#PVP_HURT_RED#+#HIT#+#NO_HIT#+#CRIT#+#NO_CRIT#+#CRIT_HURT#+#CRIT_HURT_RED#))/5+#TALENT_POWER#+#OFFICIAL_POWER#/6+#AVATAR_POWER#/6+#PET_POWER#/6+#SILKBAG_POWER#+#AVATAR_EQUIP_POWER#+#TREE_POWER#/6+#HORSE_POWER#+#JADE_POWER#+#HISTORICAL_HERO_POWER#+#TACTICS_POWER#",},
        [4] = {4,"(#ATK#*9+#PD#*27+#MD#*27+#HP#*1)/5*2.5+#PET_INITIAL_POWER#",},
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
        assert(key_map[k], "cannot find " .. k .. " in formula")
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
function formula.length()
    return #formula._data
end

-- 
function formula.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function formula.isVersionValid(v)
    if formula.version then
        if v then
            return formula.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function formula.indexOf(index)
    if index == nil or not formula._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/formula.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/formula.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/formula.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "formula" )
                _isDataExist = formula.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "formula" )
                _isBaseExist = formula.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "formula" )
                _isExist = formula.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "formula" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "formula" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = formula._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "formula" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function formula.get(id)
    
    return formula.indexOf(__index_id[id])
        
end

--
function formula.set(id, key, value)
    local record = formula.get(id)
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
function formula.index()
    return __index_id
end

return formula