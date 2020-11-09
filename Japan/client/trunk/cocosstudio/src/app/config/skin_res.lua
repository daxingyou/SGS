--skin_res

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --资源id-int 
  icon = 2,    --头像-int 
  show_res = 3,    --秀皮肤-string 
  story_res = 4,    --皮肤图片-string 
  spine_res = 5,    --皮肤形象-string 

}

-- key type
local __key_type = {
  id = "int",    --资源id-1 
  icon = "int",    --头像-2 
  show_res = "string",    --秀皮肤-3 
  story_res = "string",    --皮肤图片-4 
  spine_res = "string",    --皮肤形象-5 

}


-- data
local skin_res = {
    version =  1,
    _data = {
        [1] = {1,1,"img_skinshow1","img_huan1","123",},
        [2] = {2,2,"img_skinshow2","img_huan2","123nvpu",},
        [3] = {3,3,"img_skinshow3","img_huan3","123tunvlang",},
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
        assert(key_map[k], "cannot find " .. k .. " in skin_res")
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
function skin_res.length()
    return #skin_res._data
end

-- 
function skin_res.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function skin_res.isVersionValid(v)
    if skin_res.version then
        if v then
            return skin_res.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function skin_res.indexOf(index)
    if index == nil or not skin_res._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/skin_res.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/skin_res.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/skin_res.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "skin_res" )
                _isDataExist = skin_res.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "skin_res" )
                _isBaseExist = skin_res.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "skin_res" )
                _isExist = skin_res.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "skin_res" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "skin_res" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = skin_res._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "skin_res" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function skin_res.get(id)
    
    return skin_res.indexOf(__index_id[id])
        
end

--
function skin_res.set(id, key, value)
    local record = skin_res.get(id)
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
function skin_res.index()
    return __index_id
end

return skin_res