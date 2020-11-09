--boss_people_xy

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  x = 2,    --x-int 
  y = 3,    --y-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  x = "int",    --x-2 
  y = "int",    --y-3 

}


-- data
local boss_people_xy = {
    version =  1,
    _data = {
        [1] = {1,114,-12,},
        [2] = {2,-45,-39,},
        [3] = {3,9,-100,},
        [4] = {4,12,69,},
        [5] = {5,-166,-2,},
        [6] = {6,-150,-110,},
        [7] = {7,-96,100,},
        [8] = {8,-238,65,},
        [9] = {9,-288,-44,},
        [10] = {10,-191,168,},
        [11] = {11,-351,-115,},
        [12] = {12,-478,-147,},
        [13] = {13,0,0,},
        [14] = {14,0,0,},
        [15] = {15,0,0,},
        [16] = {100,460,-32,},
        [17] = {200,-183,137,},
        [18] = {201,38,40,},
        [19] = {202,-103,-29,},
        [20] = {203,-250,-106,},
        [21] = {204,-235,20,},
        [22] = {205,-517,-57,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [100] = 16,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [2] = 2,
    [200] = 17,
    [201] = 18,
    [202] = 19,
    [203] = 20,
    [204] = 21,
    [205] = 22,
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
    [16] = 100,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [2] = 2,
    [17] = 200,
    [18] = 201,
    [19] = 202,
    [20] = 203,
    [21] = 204,
    [22] = 205,
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
        assert(key_map[k], "cannot find " .. k .. " in boss_people_xy")
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
function boss_people_xy.length()
    return #boss_people_xy._data
end

-- 
function boss_people_xy.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function boss_people_xy.isVersionValid(v)
    if boss_people_xy.version then
        if v then
            return boss_people_xy.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function boss_people_xy.indexOf(index)
    if index == nil or not boss_people_xy._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/boss_people_xy.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/boss_people_xy.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/boss_people_xy.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "boss_people_xy" )
                _isDataExist = boss_people_xy.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "boss_people_xy" )
                _isBaseExist = boss_people_xy.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "boss_people_xy" )
                _isExist = boss_people_xy.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "boss_people_xy" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "boss_people_xy" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = boss_people_xy._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "boss_people_xy" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function boss_people_xy.get(id)
    
    return boss_people_xy.indexOf(__index_id[id])
        
end

--
function boss_people_xy.set(id, key, value)
    local record = boss_people_xy.get(id)
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
function boss_people_xy.index()
    return __index_id
end

return boss_people_xy