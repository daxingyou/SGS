--draw_point

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  box = 1,    --宝箱-int 
  country = 2,    --阵营-int 
  hero_1 = 3,    --武将1-int 
  hero_2 = 4,    --武将2-int 
  hero_3 = 5,    --武将3-int 
  hero_4 = 6,    --武将4-int 
  hero_5 = 7,    --武将5-int 
  hero_6 = 8,    --武将6-int 
  hero_7 = 9,    --武将7-int 
  hero_8 = 10,    --武将8-int 
  hero_9 = 11,    --武将9-int 
  hero_10 = 12,    --武将10-int 

}

-- key type
local __key_type = {
  box = "int",    --宝箱-1 
  country = "int",    --阵营-2 
  hero_1 = "int",    --武将1-3 
  hero_2 = "int",    --武将2-4 
  hero_3 = "int",    --武将3-5 
  hero_4 = "int",    --武将4-6 
  hero_5 = "int",    --武将5-7 
  hero_6 = "int",    --武将6-8 
  hero_7 = "int",    --武将7-9 
  hero_8 = "int",    --武将8-10 
  hero_9 = "int",    --武将9-11 
  hero_10 = "int",    --武将10-12 

}


-- data
local draw_point = {
    version =  1,
    _data = {
        [1] = {1,1,113,114,115,116,117,118,119,0,0,0,},
        [2] = {1,2,213,214,215,216,217,218,219,0,0,0,},
        [3] = {1,3,313,314,315,316,317,318,319,0,0,0,},
        [4] = {1,4,413,414,415,416,417,418,419,0,0,0,},
        [5] = {2,1,113,114,115,116,117,118,119,0,0,0,},
        [6] = {2,2,213,214,215,216,217,218,219,0,0,0,},
        [7] = {2,3,313,314,315,316,317,318,319,0,0,0,},
        [8] = {2,4,413,414,415,416,417,418,419,0,0,0,},
        [9] = {3,1,102,104,105,106,107,108,109,110,111,112,},
        [10] = {3,2,202,204,205,206,207,208,209,210,211,212,},
        [11] = {3,3,302,304,305,306,307,308,309,310,311,312,},
        [12] = {3,4,402,404,405,406,407,408,409,410,411,412,},
    }
}

-- index
local __index_box_country = {
    ["1_1"] = 1,
    ["1_2"] = 2,
    ["1_3"] = 3,
    ["1_4"] = 4,
    ["2_1"] = 5,
    ["2_2"] = 6,
    ["2_3"] = 7,
    ["2_4"] = 8,
    ["3_1"] = 9,
    ["3_2"] = 10,
    ["3_3"] = 11,
    ["3_4"] = 12,

}

-- index mainkey map
local __main_key_map = {
    [1] = "1_1",
    [2] = "1_2",
    [3] = "1_3",
    [4] = "1_4",
    [5] = "2_1",
    [6] = "2_2",
    [7] = "2_3",
    [8] = "2_4",
    [9] = "3_1",
    [10] = "3_2",
    [11] = "3_3",
    [12] = "3_4",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in draw_point")
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
function draw_point.length()
    return #draw_point._data
end

-- 
function draw_point.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function draw_point.isVersionValid(v)
    if draw_point.version then
        if v then
            return draw_point.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function draw_point.indexOf(index)
    if index == nil or not draw_point._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/draw_point.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/draw_point.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/draw_point.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "draw_point" )
                _isDataExist = draw_point.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "draw_point" )
                _isBaseExist = draw_point.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "draw_point" )
                _isExist = draw_point.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "draw_point" )
        local main_key = __main_key_map[index]
		local index_key = "__index_box_country"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "draw_point" )
        local main_key = __main_key_map[index]
		local index_key = "__index_box_country"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = draw_point._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "draw_point" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function draw_point.get(box,country)
    
    local k = box .. '_' .. country
    return draw_point.indexOf(__index_box_country[k])
        
end

--
function draw_point.set(box,country, key, value)
    local record = draw_point.get(box,country)
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
function draw_point.index()
    return __index_box_country
end

return draw_point