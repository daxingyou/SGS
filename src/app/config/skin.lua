--skin

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  name = 2,    --皮肤名称-string 
  quality = 3,    --品质-int 
  resource = 4,    --资源-string 
  is_work = 5,    --是否生效-int 
  des = 6,    --条件描述-string 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  name = "string",    --皮肤名称-2 
  quality = "int",    --品质-3 
  resource = "string",    --资源-4 
  is_work = "int",    --是否生效-5 
  des = "string",    --条件描述-6 

}


-- data
local skin = {
    version =  1,
    _data = {
        [1] = {1,"桃华",0,"",0,"默认",},
        [2] = {2,"浪漫女仆",1,"",0,"亲密度达到v7获得",},
        [3] = {3,"兔女郎",1,"",0,"亲密度达到v10获得",},
    }
}

-- index
local __index_id = {
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
        assert(key_map[k], "cannot find " .. k .. " in skin")
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
function skin.length()
    return #skin._data
end

-- 
function skin.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function skin.isVersionValid(v)
    if skin.version then
        if v then
            return skin.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function skin.indexOf(index)
    if index == nil or not skin._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/skin.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/skin.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/skin.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "skin" )
                _isDataExist = skin.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "skin" )
                _isBaseExist = skin.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "skin" )
                _isExist = skin.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "skin" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "skin" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = skin._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "skin" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function skin.get(id)
    
    return skin.indexOf(__index_id[id])
        
end

--
function skin.set(id, key, value)
    local record = skin.get(id)
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
function skin.index()
    return __index_id
end

return skin