--explore_map

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --格子-int 
  size = 2,    --格子数量-int 
  x = 3,    --起点x-int 
  y = 4,    --起点y-int 
  start_road = 5,    --起点-string 
  end_road = 6,    --终点-string 
  road = 7,    --道路-string 
  map = 8,    --格子-string 
  map_size = 9,    --地图-string 
  tree = 10,    --树-string 
  flower = 11,    --花-string 
  car = 12,    --车械-string 
  up_x = 13,    --左x坐标-int 
  down_x = 14,    --右x坐标-int 
  up_y = 15,    --上y坐标-int 
  down_y = 16,    --下y坐标-int 

}

-- key type
local __key_type = {
  id = "int",    --格子-1 
  size = "int",    --格子数量-2 
  x = "int",    --起点x-3 
  y = "int",    --起点y-4 
  start_road = "string",    --起点-5 
  end_road = "string",    --终点-6 
  road = "string",    --道路-7 
  map = "string",    --格子-8 
  map_size = "string",    --地图-9 
  tree = "string",    --树-10 
  flower = "string",    --花-11 
  car = "string",    --车械-12 
  up_x = "int",    --左x坐标-13 
  down_x = "int",    --右x坐标-14 
  up_y = "int",    --上y坐标-15 
  down_y = "int",    --下y坐标-16 

}


-- data
local explore_map = {
    version =  1,
    _data = {
        [1] = {1,30,300,300,"img_road2","img_road3","img_road","1|3|3|1|1|4|4|1|1|1|4|4|2|2|2|2|2|4|4|1|1|1|4|4|1|1|3|1|1","map30","","","",0,2272,1280,0,},
        [2] = {2,45,231,316,"img_road2","img_road3","img_road","1|1|1|1|3|3|3|1|1|4|4|1|1|4|4|4|2|2|2|2|2|2|4|4|4|4|1|1|1|4|4|4|1|1|1|3|3|3|1|1|1|1|1|1","map45","","","",0,2272,1280,0,},
        [3] = {3,60,172,511,"img_road5","img_road6","img_road4","1|1|1|1|1|4|4|2|2|2|4|4|2|2|2|2|2|4|4|4|1|1|1|1|1|1|4|4|4|2|4|4|1|1|1|3|3|3|1|1|3|3|3|3|3|1|1|4|1|4|4|4|4|4|4|2|2|4|4","map60","","","",0,2272,1280,0,},
        [4] = {4,75,107,932,"img_road2","img_road3","img_road","4|4|2|2|4|4|4|4|4|2|2|2|2|2|4|4|4|1|1|1|1|1|1|1|4|4|2|2|2|4|4|1|1|1|4|4|1|1|3|3|3|3|1|1|4|4|4|1|1|3|1|1|3|3|3|3|3|3|2|2|2|2|3|2|3|3|2|3|3|1|1|4|1|1","map75","","","",0,2272,1280,0,},
        [5] = {5,90,156,195,"img_road5","img_road6","img_road4","4|4|1|1|1|1|3|3|3|1|3|3|3|3|3|1|1|1|1|1|1|1|1|1|4|4|4|2|2|4|4|2|2|2|2|4|4|4|4|4|4|4|4|4|4|4|1|1|1|1|3|3|3|3|3|3|3|3|1|1|1|1|3|3|3|3|1|1|1|4|4|4|4|4|4|4|2|2|2|2|4|4|4|4|4|4|1|1|1","map90","  ","","",0,2272,1280,0,},
        [6] = {6,105,160,897,"img_road2","img_road3","img_road","4|4|4|1|1|3|1|3|1|1|4|1|1|1|4|1|4|4|2|2|2|2|4|4|2|4|2|2|4|2|2|3|2|3|3|3|2|2|4|2|4|2|4|2|2|4|4|4|4|4|1|1|1|1|1|3|3|1|1|1|1|1|1|4|4|4|4|2|4|2|4|4|1|1|1|4|1|1|4|1|1|3|3|3|3|1|3|3|3|3|3|2|2|3|3|1|1|1|1|4|1|4|4|4","map105","","","",0,2272,1280,0,},
        [7] = {7,105,225,680,"img_road2","img_road3","img_road","1|1|1|1|3|3|3|1|1|1|4|1|4|1|4|4|4|2|2|4|4|2|2|2|2|2|2|3|2|2|2|2|4|2|2|4|4|4|4|1|1|1|1|1|3|3|1|1|1|1|1|1|1|1|1|3|1|1|3|1|1|4|4|4|4|1|1|4|4|4|4|4|2|2|2|2|4|4|4|4|2|2|3|3|3|3|3|3|2|2|4|2|2|2|2|2|2|4|4|1|1|1|4|4","map105_2","","","",0,2272,1280,0,},
        [8] = {8,105,225,225,"img_road5","img_road6","img_road4","1|1|1|3|3|3|3|3|1|1|1|3|3|3|1|1|1|3|1|1|1|4|1|4|4|4|2|2|2|2|4|4|4|4|2|2|4|4|4|4|2|2|4|4|4|1|1|4|1|1|1|1|3|3|3|3|3|1|1|1|1|3|3|3|3|3|1|1|1|1|4|4|1|4|4|4|4|4|4|4|4|4|2|2|2|3|3|3|2|2|2|4|4|4|4|4|1|1|4|4|2|2|2|2","map105_3","","","",0,2272,1280,0,},
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
    [7] = 7,
    [8] = 8,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in explore_map")
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
function explore_map.length()
    return #explore_map._data
end

-- 
function explore_map.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function explore_map.isVersionValid(v)
    if explore_map.version then
        if v then
            return explore_map.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function explore_map.indexOf(index)
    if index == nil or not explore_map._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/explore_map.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/explore_map.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/explore_map.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "explore_map" )
                _isDataExist = explore_map.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "explore_map" )
                _isBaseExist = explore_map.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "explore_map" )
                _isExist = explore_map.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "explore_map" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "explore_map" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = explore_map._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "explore_map" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function explore_map.get(id)
    
    return explore_map.indexOf(__index_id[id])
        
end

--
function explore_map.set(id, key, value)
    local record = explore_map.get(id)
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
function explore_map.index()
    return __index_id
end

return explore_map