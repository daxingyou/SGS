--graincar_route

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --路线id-int 
  start = 2,    --出发点-int 
  point_1 = 3,    --途经点1-int 
  point_2 = 4,    --途经点2-int 
  point_3 = 5,    --途经点3-int 
  point_4 = 6,    --途经点4-int 
  point_5 = 7,    --途经点5-int 
  point_6 = 8,    --途经点6-int 
  point_7 = 9,    --途经点7-int 
  point_8 = 10,    --途经点8-int 
  point_9 = 11,    --途经点9-int 
  point_10 = 12,    --途经点10-int 
  point_11 = 13,    --途经点11-int 
  point_12 = 14,    --途经点12-int 

}

-- key type
local __key_type = {
  id = "int",    --路线id-1 
  start = "int",    --出发点-2 
  point_1 = "int",    --途经点1-3 
  point_2 = "int",    --途经点2-4 
  point_3 = "int",    --途经点3-5 
  point_4 = "int",    --途经点4-6 
  point_5 = "int",    --途经点5-7 
  point_6 = "int",    --途经点6-8 
  point_7 = "int",    --途经点7-9 
  point_8 = "int",    --途经点8-10 
  point_9 = "int",    --途经点9-11 
  point_10 = "int",    --途经点10-12 
  point_11 = "int",    --途经点11-13 
  point_12 = "int",    --途经点12-14 

}


-- data
local graincar_route = {
    version =  1,
    _data = {
        [1] = {1,110,106,105,102,204,201,100,301,302,303,307,306,310,},
        [2] = {2,110,106,107,103,102,101,100,301,304,309,308,310,0,},
        [3] = {3,110,108,109,104,101,100,301,302,305,306,310,0,0,},
        [4] = {4,110,106,107,103,102,101,100,201,202,203,207,208,210,},
        [5] = {5,110,106,105,102,101,100,301,302,202,205,206,210,0,},
        [6] = {6,110,108,109,104,101,100,201,204,209,208,210,0,0,},
        [7] = {7,210,208,207,203,202,201,100,101,102,103,107,106,110,},
        [8] = {8,210,206,205,202,302,301,100,101,102,105,106,110,0,},
        [9] = {9,210,208,209,204,201,100,101,104,109,108,110,0,0,},
        [10] = {10,210,208,207,203,202,201,100,301,302,303,307,306,310,},
        [11] = {11,210,208,209,204,201,100,101,104,304,309,308,310,0,},
        [12] = {12,210,206,205,202,201,100,301,302,305,306,310,0,0,},
        [13] = {13,310,306,307,303,302,301,100,201,204,102,105,106,110,},
        [14] = {14,310,308,309,304,301,100,101,102,103,107,106,110,0,},
        [15] = {15,310,306,305,302,301,100,101,104,109,108,110,0,0,},
        [16] = {16,310,306,307,303,302,301,100,201,202,203,207,208,210,},
        [17] = {17,310,308,309,304,104,101,100,201,204,209,208,210,0,},
        [18] = {18,310,306,305,302,301,100,201,202,205,206,210,0,0,},
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
    [17] = 17,
    [18] = 18,
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
    [17] = 17,
    [18] = 18,
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
        assert(key_map[k], "cannot find " .. k .. " in graincar_route")
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
function graincar_route.length()
    return #graincar_route._data
end

-- 
function graincar_route.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function graincar_route.isVersionValid(v)
    if graincar_route.version then
        if v then
            return graincar_route.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function graincar_route.indexOf(index)
    if index == nil or not graincar_route._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/graincar_route.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/graincar_route.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/graincar_route.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "graincar_route" )
                _isDataExist = graincar_route.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "graincar_route" )
                _isBaseExist = graincar_route.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "graincar_route" )
                _isExist = graincar_route.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "graincar_route" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "graincar_route" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = graincar_route._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "graincar_route" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function graincar_route.get(id)
    
    return graincar_route.indexOf(__index_id[id])
        
end

--
function graincar_route.set(id, key, value)
    local record = graincar_route.get(id)
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
function graincar_route.index()
    return __index_id
end

return graincar_route