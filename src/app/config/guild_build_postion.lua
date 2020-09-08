--guild_build_postion

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --建筑id-int 
  show_level = 2,    --开放显示需要军团等级-int 
  open = 3,    --是否开放-int 
  name = 4,    --建筑名称-string 
  pic = 5,    --资源名称-string 
  postion_x = 6,    --建筑X坐标-int 
  postion_y = 7,    --建筑Y坐标-int 
  name_pic = 8,    --标题Y坐标-string 
  name_postion_x = 9,    --标题X坐标-int 
  name_postion_y = 10,    --标题Y坐标-int 

}

-- key type
local __key_type = {
  id = "int",    --建筑id-1 
  show_level = "int",    --开放显示需要军团等级-2 
  open = "int",    --是否开放-3 
  name = "string",    --建筑名称-4 
  pic = "string",    --资源名称-5 
  postion_x = "int",    --建筑X坐标-6 
  postion_y = "int",    --建筑Y坐标-7 
  name_pic = "string",    --标题Y坐标-8 
  name_postion_x = "int",    --标题X坐标-9 
  name_postion_y = "int",    --标题Y坐标-10 

}


-- data
local guild_build_postion = {
    version =  1,
    _data = {
        [1] = {1,1,1,"军团大殿","guild_build_01",1205,591,"txt_guild_dadian01",1380,820,},
        [2] = {2,1,1,"军团援助","guild_build_02",478,396,"txt_guild_yuanzhu03",740,556,},
        [3] = {3,1,1,"军团商店","guild_build_03",826,542,"txt_guild_shangdian05",1050,730,},
        [4] = {4,4,0,"亭子","guild_build_04",1005,805,"",1088,857,},
        [5] = {5,1,1,"军团BOSS","guild_build_05",857,400,"txt_guild_boss04",1080,560,},
        [6] = {6,1,1,"军团捐献","guild_build_06",1174,374,"txt_guild_jisi07",1400,534,},
        [7] = {7,3,0,"军需所","guild_build_07",872,213,"",1144,361,},
        [8] = {8,1,1,"军团试炼","guild_build_08",401,529,"txt_guild_fuben02",548,702,},
        [9] = {9,1,0,"东城门","guild_build_09",1226,221,"",1486,481,},
        [10] = {10,1,0,"军团战","guild_build_10",1540,225,"txt_guild_juanxian06",1800,485,},
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
        assert(key_map[k], "cannot find " .. k .. " in guild_build_postion")
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
function guild_build_postion.length()
    return #guild_build_postion._data
end

-- 
function guild_build_postion.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_build_postion.isVersionValid(v)
    if guild_build_postion.version then
        if v then
            return guild_build_postion.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_build_postion.indexOf(index)
    if index == nil or not guild_build_postion._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_build_postion.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_build_postion.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_build_postion.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_build_postion" )
                _isDataExist = guild_build_postion.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_build_postion" )
                _isBaseExist = guild_build_postion.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_build_postion" )
                _isExist = guild_build_postion.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_build_postion" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_build_postion" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_build_postion._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_build_postion" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_build_postion.get(id)
    
    return guild_build_postion.indexOf(__index_id[id])
        
end

--
function guild_build_postion.set(id, key, value)
    local record = guild_build_postion.get(id)
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
function guild_build_postion.index()
    return __index_id
end

return guild_build_postion