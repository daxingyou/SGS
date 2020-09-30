--avatar_gold_normal_activity

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --排序-int 
  type = 2,    --类型-int 
  value = 3,    --类型值-int 
  size = 4,    --数量-int 

}

-- key type
local __key_type = {
  id = "int",    --排序-1 
  type = "int",    --类型-2 
  value = "int",    --类型值-3 
  size = "int",    --数量-4 

}


-- data
local avatar_gold_normal_activity = {
    version =  1,
    _data = {
        [1] = {1,9,0,1,},
        [2] = {2,6,92,1,},
        [3] = {3,6,93,1,},
        [4] = {4,6,703,1,},
        [5] = {5,6,704,1,},
        [6] = {6,6,721,1,},
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
        assert(key_map[k], "cannot find " .. k .. " in avatar_gold_normal_activity")
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
function avatar_gold_normal_activity.length()
    return #avatar_gold_normal_activity._data
end

-- 
function avatar_gold_normal_activity.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function avatar_gold_normal_activity.isVersionValid(v)
    if avatar_gold_normal_activity.version then
        if v then
            return avatar_gold_normal_activity.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function avatar_gold_normal_activity.indexOf(index)
    if index == nil or not avatar_gold_normal_activity._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/avatar_gold_normal_activity.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/avatar_gold_normal_activity.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/avatar_gold_normal_activity.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "avatar_gold_normal_activity" )
                _isDataExist = avatar_gold_normal_activity.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "avatar_gold_normal_activity" )
                _isBaseExist = avatar_gold_normal_activity.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "avatar_gold_normal_activity" )
                _isExist = avatar_gold_normal_activity.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "avatar_gold_normal_activity" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "avatar_gold_normal_activity" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = avatar_gold_normal_activity._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "avatar_gold_normal_activity" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function avatar_gold_normal_activity.get(id)
    
    return avatar_gold_normal_activity.indexOf(__index_id[id])
        
end

--
function avatar_gold_normal_activity.set(id, key, value)
    local record = avatar_gold_normal_activity.get(id)
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
function avatar_gold_normal_activity.index()
    return __index_id
end

return avatar_gold_normal_activity