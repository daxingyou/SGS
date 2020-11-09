--return_lv

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序列-int 
  lv_gap = 2,    --参考等级-int 
  lvup_price = 3,    --升级价格-int 
  vip_pay_id = 4,    --价格id-int 

}

-- key type
local __key_type = {
  id = "int",    --序列-1 
  lv_gap = "int",    --参考等级-2 
  lvup_price = "int",    --升级价格-3 
  vip_pay_id = "int",    --价格id-4 

}


-- data
local return_lv = {
    version =  1,
    _data = {
        [1] = {1,5,30,10126,},
        [2] = {2,10,98,10127,},
        [3] = {3,20,198,10128,},
        [4] = {4,999,648,10129,},
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
        assert(key_map[k], "cannot find " .. k .. " in return_lv")
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
function return_lv.length()
    return #return_lv._data
end

-- 
function return_lv.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function return_lv.isVersionValid(v)
    if return_lv.version then
        if v then
            return return_lv.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function return_lv.indexOf(index)
    if index == nil or not return_lv._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/return_lv.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/return_lv.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/return_lv.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "return_lv" )
                _isDataExist = return_lv.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "return_lv" )
                _isBaseExist = return_lv.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "return_lv" )
                _isExist = return_lv.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "return_lv" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "return_lv" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = return_lv._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "return_lv" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function return_lv.get(id)
    
    return return_lv.indexOf(__index_id[id])
        
end

--
function return_lv.set(id, key, value)
    local record = return_lv.get(id)
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
function return_lv.index()
    return __index_id
end

return return_lv