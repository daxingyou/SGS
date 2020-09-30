--daily_dungeon_type

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  name = 2,    --副本名称-string 
  build = 3,    --建筑样式-string 
  x_position = 4,    --建筑名称X坐标-int 
  y_position = 5,    --建筑名称Y坐标-int 
  pic = 6,    --图片名称-string 
  win_type = 7,    --胜利条件-int 
  daily_times = 8,    --每日攻打次数上限-int 
  dungeon_round = 9,    --最高战斗回合数（每场）-int 
  week_open_queue = 10,    --每周开放时间序列-string 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  name = "string",    --副本名称-2 
  build = "string",    --建筑样式-3 
  x_position = "int",    --建筑名称X坐标-4 
  y_position = "int",    --建筑名称Y坐标-5 
  pic = "string",    --图片名称-6 
  win_type = "int",    --胜利条件-7 
  daily_times = "int",    --每日攻打次数上限-8 
  dungeon_round = "int",    --最高战斗回合数（每场）-9 
  week_open_queue = "string",    --每周开放时间序列-10 

}


-- data
local daily_dungeon_type = {
    version =  1,
    _data = {
        [1] = {1,"武将经验","1",100,-15,"txt_wujiangjingyan05",1,2,10,"1010101",},
        [2] = {2,"银两","2",60,9,"txt_yingliang07",1,2,10,"1111111",},
        [3] = {3,"突破丹","3",-65,13,"txt_rupodan06",1,2,10,"1101010",},
        [4] = {4,"装备精炼石","4",15,0,"txt_zhuangbeijinglianshi02",1,2,10,"1101010",},
        [5] = {5,"宝物经验","5",110,33,"txt_jingyanbaowu04",1,2,10,"1010101",},
        [6] = {6,"宝物精炼石","6",-60,0,"txt_baowuijinglianshi03",1,2,10,"1101010",},
        [7] = {7,"神兵进阶石","7",-50,-10,"txt_shenbingjinjieshi01",1,2,10,"1010101",},
        [8] = {8,"神兽经验","8",95,5,"txt_shenshoujingyan08",1,2,10,"1010101",},
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
        assert(key_map[k], "cannot find " .. k .. " in daily_dungeon_type")
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
function daily_dungeon_type.length()
    return #daily_dungeon_type._data
end

-- 
function daily_dungeon_type.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function daily_dungeon_type.isVersionValid(v)
    if daily_dungeon_type.version then
        if v then
            return daily_dungeon_type.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function daily_dungeon_type.indexOf(index)
    if index == nil or not daily_dungeon_type._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/daily_dungeon_type.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/daily_dungeon_type.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/daily_dungeon_type.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "daily_dungeon_type" )
                _isDataExist = daily_dungeon_type.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "daily_dungeon_type" )
                _isBaseExist = daily_dungeon_type.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "daily_dungeon_type" )
                _isExist = daily_dungeon_type.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "daily_dungeon_type" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "daily_dungeon_type" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = daily_dungeon_type._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "daily_dungeon_type" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function daily_dungeon_type.get(id)
    
    return daily_dungeon_type.indexOf(__index_id[id])
        
end

--
function daily_dungeon_type.set(id, key, value)
    local record = daily_dungeon_type.get(id)
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
function daily_dungeon_type.index()
    return __index_id
end

return daily_dungeon_type