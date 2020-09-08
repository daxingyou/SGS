--avatar_gold_card

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --排序-int 
  country = 2,    --阵营-int 
  type = 3,    --类型-int 
  value = 4,    --类型值-int 

}

-- key type
local __key_type = {
  id = "int",    --排序-1 
  country = "int",    --阵营-2 
  type = "int",    --类型-3 
  value = "int",    --类型值-4 

}


-- data
local avatar_gold_card = {
    version =  1,
    _data = {
        [1] = {1,1,9,1150,},
        [2] = {2,1,9,1151,},
        [3] = {3,1,9,1152,},
        [4] = {4,1,9,1153,},
        [5] = {5,2,9,1250,},
        [6] = {6,2,9,1251,},
        [7] = {7,2,9,1252,},
        [8] = {8,2,9,1253,},
        [9] = {9,3,9,1350,},
        [10] = {10,3,9,1351,},
        [11] = {11,3,9,1352,},
        [12] = {12,3,9,1353,},
        [13] = {13,4,9,1450,},
        [14] = {14,4,9,1451,},
        [15] = {15,4,9,1452,},
        [16] = {16,4,9,1453,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
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
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
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
        assert(key_map[k], "cannot find " .. k .. " in avatar_gold_card")
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
function avatar_gold_card.length()
    return #avatar_gold_card._data
end

-- 
function avatar_gold_card.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function avatar_gold_card.isVersionValid(v)
    if avatar_gold_card.version then
        if v then
            return avatar_gold_card.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function avatar_gold_card.indexOf(index)
    if index == nil or not avatar_gold_card._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/avatar_gold_card.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/avatar_gold_card.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/avatar_gold_card.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "avatar_gold_card" )
                _isDataExist = avatar_gold_card.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "avatar_gold_card" )
                _isBaseExist = avatar_gold_card.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "avatar_gold_card" )
                _isExist = avatar_gold_card.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "avatar_gold_card" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "avatar_gold_card" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = avatar_gold_card._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "avatar_gold_card" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function avatar_gold_card.get(id)
    
    return avatar_gold_card.indexOf(__index_id[id])
        
end

--
function avatar_gold_card.set(id, key, value)
    local record = avatar_gold_card.get(id)
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
function avatar_gold_card.index()
    return __index_id
end

return avatar_gold_card