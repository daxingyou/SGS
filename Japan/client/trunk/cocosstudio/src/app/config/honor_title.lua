--honor_title

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  state = 2,    --国家-int 
  limit_level = 3,    --限制等级-int 
  day = 4,    --开服天数-int 
  resource = 5,    --资源-string 
  rank = 6,    --排序优先级-int 
  time_type = 7,    --时间类型-int 
  time_value = 8,    --时间类型值-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  state = "int",    --国家-2 
  limit_level = "int",    --限制等级-3 
  day = "int",    --开服天数-4 
  resource = "string",    --资源-5 
  rank = "int",    --排序优先级-6 
  time_type = "int",    --时间类型-7 
  time_value = "int",    --时间类型值-8 

}


-- data
local honor_title = {
    version =  1,
    _data = {
        [1] = {1,0,40,3,"img_title01",1,1,1,},
        [2] = {2,1,50,6,"img_title02a",2,1,7,},
        [3] = {3,2,50,6,"img_title02b",2,1,7,},
        [4] = {4,3,50,6,"img_title02c",2,1,7,},
        [5] = {5,4,50,6,"img_title02d",2,1,7,},
        [6] = {6,0,1,0,"img_title03",99,1,999,},
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

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in honor_title")
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
function honor_title.length()
    return #honor_title._data
end

-- 
function honor_title.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function honor_title.isVersionValid(v)
    if honor_title.version then
        if v then
            return honor_title.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function honor_title.indexOf(index)
    if index == nil or not honor_title._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/honor_title.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/honor_title.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/honor_title.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "honor_title" )
                _isDataExist = honor_title.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "honor_title" )
                _isBaseExist = honor_title.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "honor_title" )
                _isExist = honor_title.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "honor_title" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "honor_title" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = honor_title._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "honor_title" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function honor_title.get(id)
    
    return honor_title.indexOf(__index_id[id])
        
end

--
function honor_title.set(id, key, value)
    local record = honor_title.get(id)
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
function honor_title.index()
    return __index_id
end

return honor_title