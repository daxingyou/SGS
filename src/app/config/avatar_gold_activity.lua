--avatar_gold_activity

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --排序-int 
  country = 2,    --变身卡阵营-int 
  type = 3,    --类型-int 
  value = 4,    --类型值-int 
  size = 5,    --数量-int 

}

-- key type
local __key_type = {
  id = "int",    --排序-1 
  country = "int",    --变身卡阵营-2 
  type = "int",    --类型-3 
  value = "int",    --类型值-4 
  size = "int",    --数量-5 

}


-- data
local avatar_gold_activity = {
    version =  1,
    _data = {
        [1] = {1,1,9,0,1,},
        [2] = {2,2,9,0,1,},
        [3] = {3,3,9,0,1,},
        [4] = {4,4,9,0,1,},
        [5] = {5,5,9,0,1,},
        [6] = {6,0,6,92,1,},
        [7] = {7,0,6,93,1,},
        [8] = {8,0,6,703,1,},
        [9] = {9,0,6,704,1,},
        [10] = {10,0,6,721,1,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [10] = 10,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in avatar_gold_activity")
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
function avatar_gold_activity.length()
    return #avatar_gold_activity._data
end

-- 
function avatar_gold_activity.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function avatar_gold_activity.isVersionValid(v)
    if avatar_gold_activity.version then
        if v then
            return avatar_gold_activity.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function avatar_gold_activity.indexOf(index)
    if index == nil or not avatar_gold_activity._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/avatar_gold_activity.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/avatar_gold_activity.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/avatar_gold_activity.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "avatar_gold_activity" )
                _isDataExist = avatar_gold_activity.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "avatar_gold_activity" )
                _isBaseExist = avatar_gold_activity.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "avatar_gold_activity" )
                _isExist = avatar_gold_activity.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "avatar_gold_activity" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "avatar_gold_activity" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = avatar_gold_activity._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "avatar_gold_activity" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function avatar_gold_activity.get(id)
    
    return avatar_gold_activity.indexOf(__index_id[id])
        
end

--
function avatar_gold_activity.set(id, key, value)
    local record = avatar_gold_activity.get(id)
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
function avatar_gold_activity.index()
    return __index_id
end

return avatar_gold_activity