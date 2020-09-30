--vip_level_price

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  pay_level = 2,    --等级显示-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  pay_level = "int",    --等级显示-2 

}


-- data
local vip_level_price = {
    version =  1,
    _data = {
        [1] = {1,250,},
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
        assert(key_map[k], "cannot find " .. k .. " in vip_level_price")
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
function vip_level_price.length()
    return #vip_level_price._data
end

-- 
function vip_level_price.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function vip_level_price.isVersionValid(v)
    if vip_level_price.version then
        if v then
            return vip_level_price.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function vip_level_price.indexOf(index)
    if index == nil or not vip_level_price._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/vip_level_price.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/vip_level_price.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/vip_level_price.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "vip_level_price" )
                _isDataExist = vip_level_price.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "vip_level_price" )
                _isBaseExist = vip_level_price.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "vip_level_price" )
                _isExist = vip_level_price.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "vip_level_price" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "vip_level_price" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = vip_level_price._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "vip_level_price" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function vip_level_price.get(id)
    
    return vip_level_price.indexOf(__index_id[id])
        
end

--
function vip_level_price.set(id, key, value)
    local record = vip_level_price.get(id)
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
function vip_level_price.index()
    return __index_id
end

return vip_level_price