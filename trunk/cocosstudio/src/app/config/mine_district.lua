--mine_district

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  district_id = 1,    --矿区id-int 
  district_name = 2,    --矿区名称-string 
  district_type = 3,    --矿区类型-int 
  unlock_event = 4,    --解锁条件-int 
  occupy_pit = 5,    --占领条件-int 
  district_bg = 6,    --地区背景-string 
  district_name_txt = 7,    --地区名称-string 
  district_icon = 8,    --地区图标-string 
  x = 9,    --坐标x值-int 
  y = 10,    --坐标y值-int 

}

-- key type
local __key_type = {
  district_id = "int",    --矿区id-1 
  district_name = "string",    --矿区名称-2 
  district_type = "int",    --矿区类型-3 
  unlock_event = "int",    --解锁条件-4 
  occupy_pit = "int",    --占领条件-5 
  district_bg = "string",    --地区背景-6 
  district_name_txt = "string",    --地区名称-7 
  district_icon = "string",    --地区图标-8 
  x = "int",    --坐标x值-9 
  y = "int",    --坐标y值-10 

}


-- data
local mine_district = {
    version =  1,
    _data = {
        [1] = {1,"中原矿区",1,3,4,"img_mine_district01","txt_mine_qu01","img_mine_icon01",568,320,},
        [2] = {2,"河东矿区",2,2,3,"img_mine_district02","txt_mine_qu02","img_mine_icon02",568,200,},
        [3] = {3,"淮南矿区",2,2,3,"img_mine_district03","txt_mine_qu03","img_mine_icon03",757,427,},
        [4] = {4,"汉中矿区",2,2,3,"img_mine_district04","txt_mine_qu04","img_mine_icon04",379,427,},
        [5] = {5,"朔方矿区",3,1,5,"img_mine_district05","txt_mine_qu05","img_mine_icon05",868,100,},
        [6] = {6,"幽燕矿区",3,1,5,"img_mine_district06","txt_mine_qu06","img_mine_icon05",1168,100,},
        [7] = {7,"江东矿区",3,1,5,"img_mine_district07","txt_mine_qu07","img_mine_icon06",900,327,},
        [8] = {8,"南越矿区",3,1,5,"img_mine_district08","txt_mine_qu08","img_mine_icon06",900,527,},
        [9] = {9,"巴蜀矿区",3,1,5,"img_mine_district09","txt_mine_qu09","img_mine_icon07",150,327,},
        [10] = {10,"西凉矿区",3,1,5,"img_mine_district10","txt_mine_qu10","img_mine_icon07",150,527,},
    }
}

-- index
local __index_district_id = {
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
        assert(key_map[k], "cannot find " .. k .. " in mine_district")
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
function mine_district.length()
    return #mine_district._data
end

-- 
function mine_district.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function mine_district.isVersionValid(v)
    if mine_district.version then
        if v then
            return mine_district.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function mine_district.indexOf(index)
    if index == nil or not mine_district._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/mine_district.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/mine_district.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/mine_district.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "mine_district" )
                _isDataExist = mine_district.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "mine_district" )
                _isBaseExist = mine_district.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "mine_district" )
                _isExist = mine_district.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "mine_district" )
        local main_key = __main_key_map[index]
		local index_key = "__index_district_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "mine_district" )
        local main_key = __main_key_map[index]
		local index_key = "__index_district_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = mine_district._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "mine_district" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function mine_district.get(district_id)
    
    return mine_district.indexOf(__index_district_id[district_id])
        
end

--
function mine_district.set(district_id, key, value)
    local record = mine_district.get(district_id)
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
function mine_district.index()
    return __index_district_id
end

return mine_district