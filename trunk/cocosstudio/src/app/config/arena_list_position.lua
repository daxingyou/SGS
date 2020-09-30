--arena_list_position

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  position = 1,    --位置编号-int 
  position_x = 2,    --x轴坐标（像素）-int 
  position_y = 3,    --y轴坐标（像素）-int 

}

-- key type
local __key_type = {
  position = "int",    --位置编号-1 
  position_x = "int",    --x轴坐标（像素）-2 
  position_y = "int",    --y轴坐标（像素）-3 

}


-- data
local arena_list_position = {
    version =  1,
    _data = {
        [1] = {1,480,2542,},
        [2] = {2,270,2230,},
        [3] = {3,480,2185,},
        [4] = {4,255,1635,},
        [5] = {5,480,1590,},
        [6] = {6,250,1320,},
        [7] = {7,475,1250,},
        [8] = {8,270,975,},
        [9] = {9,475,930,},
        [10] = {10,235,650,},
        [11] = {11,470,600,},
    }
}

-- index
local __index_position = {
    [1] = 1,
    [10] = 10,
    [11] = 11,
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
        assert(key_map[k], "cannot find " .. k .. " in arena_list_position")
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
function arena_list_position.length()
    return #arena_list_position._data
end

-- 
function arena_list_position.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function arena_list_position.isVersionValid(v)
    if arena_list_position.version then
        if v then
            return arena_list_position.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function arena_list_position.indexOf(index)
    if index == nil or not arena_list_position._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/arena_list_position.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/arena_list_position.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/arena_list_position.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "arena_list_position" )
                _isDataExist = arena_list_position.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "arena_list_position" )
                _isBaseExist = arena_list_position.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "arena_list_position" )
                _isExist = arena_list_position.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "arena_list_position" )
        local main_key = __main_key_map[index]
		local index_key = "__index_position"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "arena_list_position" )
        local main_key = __main_key_map[index]
		local index_key = "__index_position"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = arena_list_position._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "arena_list_position" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function arena_list_position.get(position)
    
    return arena_list_position.indexOf(__index_position[position])
        
end

--
function arena_list_position.set(position, key, value)
    local record = arena_list_position.get(position)
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
function arena_list_position.index()
    return __index_position
end

return arena_list_position