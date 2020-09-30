--comment

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  level = 2,    --开启等级-int 
  type = 3,    --物品类型-int 
  value = 4,    --类型值-int 
  size = 5,    --数量-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  level = "int",    --开启等级-2 
  type = "int",    --物品类型-3 
  value = "int",    --类型值-4 
  size = "int",    --数量-5 

}


-- data
local comment = {
    version =  1,
    _data = {
        [1] = {1,18,5,1,100,},
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
        assert(key_map[k], "cannot find " .. k .. " in comment")
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
function comment.length()
    return #comment._data
end

-- 
function comment.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function comment.isVersionValid(v)
    if comment.version then
        if v then
            return comment.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function comment.indexOf(index)
    if index == nil or not comment._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/comment.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/comment.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/comment.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "comment" )
                _isDataExist = comment.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "comment" )
                _isBaseExist = comment.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "comment" )
                _isExist = comment.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "comment" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "comment" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = comment._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "comment" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function comment.get(id)
    
    return comment.indexOf(__index_id[id])
        
end

--
function comment.set(id, key, value)
    local record = comment.get(id)
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
function comment.index()
    return __index_id
end

return comment