--sgs_linkage_2

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  type = 2,    --类型-int 
  value = 3,    --类型值-int 
  mission_description = 4,    --说明-string 
  reward_type = 5,    --奖励类型-int 
  reward_value = 6,    --奖励类型值-int 
  reward_size = 7,    --奖励数量-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  type = "int",    --类型-2 
  value = "int",    --类型值-3 
  mission_description = "string",    --说明-4 
  reward_type = "int",    --奖励类型-5 
  reward_value = "int",    --奖励类型值-6 
  reward_size = "int",    --奖励数量-7 

}


-- data
local sgs_linkage_2 = {
    version =  1,
    _data = {
        [1] = {1,1,15,"升到#num#级",5,2,10000,},
        [2] = {2,1,31,"升到#num#级",6,63,10,},
        [3] = {3,1,50,"升到#num#级",6,73,20,},
        [4] = {4,2,1,"任意充值",6,3,100,},
        [5] = {5,2,30,"累充#num#元",6,7,1,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in sgs_linkage_2")
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
function sgs_linkage_2.length()
    return #sgs_linkage_2._data
end

-- 
function sgs_linkage_2.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function sgs_linkage_2.isVersionValid(v)
    if sgs_linkage_2.version then
        if v then
            return sgs_linkage_2.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function sgs_linkage_2.indexOf(index)
    if index == nil or not sgs_linkage_2._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/sgs_linkage_2.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/sgs_linkage_2.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/sgs_linkage_2.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "sgs_linkage_2" )
                _isDataExist = sgs_linkage_2.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "sgs_linkage_2" )
                _isBaseExist = sgs_linkage_2.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "sgs_linkage_2" )
                _isExist = sgs_linkage_2.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "sgs_linkage_2" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "sgs_linkage_2" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = sgs_linkage_2._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "sgs_linkage_2" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function sgs_linkage_2.get(id)
    
    return sgs_linkage_2.indexOf(__index_id[id])
        
end

--
function sgs_linkage_2.set(id, key, value)
    local record = sgs_linkage_2.get(id)
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
function sgs_linkage_2.index()
    return __index_id
end

return sgs_linkage_2