--sgs_linkage_param

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  direction = 2,    --类型-string 
  key = 3,    --参数名称-string 
  content = 4,    --参数内容-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  direction = "string",    --类型-2 
  key = "string",    --参数名称-3 
  content = "int",    --参数内容-4 

}


-- data
local sgs_linkage_param = {
    version =  1,
    _data = {
        [1] = {1,"ss2mjz","sgs_linkage_time",100,},
        [2] = {2,"ss2mjz","sgs_linkage_overtime",8,},
        [3] = {3,"mjz2ss","sgs_linkage_time",100,},
        [4] = {4,"mjz2ss","sgs_linkage_overtime",8,},
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
        assert(key_map[k], "cannot find " .. k .. " in sgs_linkage_param")
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
function sgs_linkage_param.length()
    return #sgs_linkage_param._data
end

-- 
function sgs_linkage_param.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function sgs_linkage_param.isVersionValid(v)
    if sgs_linkage_param.version then
        if v then
            return sgs_linkage_param.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function sgs_linkage_param.indexOf(index)
    if index == nil or not sgs_linkage_param._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/sgs_linkage_param.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/sgs_linkage_param.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/sgs_linkage_param.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "sgs_linkage_param" )
                _isDataExist = sgs_linkage_param.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "sgs_linkage_param" )
                _isBaseExist = sgs_linkage_param.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "sgs_linkage_param" )
                _isExist = sgs_linkage_param.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "sgs_linkage_param" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "sgs_linkage_param" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = sgs_linkage_param._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "sgs_linkage_param" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function sgs_linkage_param.get(id)
    
    return sgs_linkage_param.indexOf(__index_id[id])
        
end

--
function sgs_linkage_param.set(id, key, value)
    local record = sgs_linkage_param.get(id)
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
function sgs_linkage_param.index()
    return __index_id
end

return sgs_linkage_param