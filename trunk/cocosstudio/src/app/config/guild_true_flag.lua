--guild_true_flag

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --颜色id-int 
  name = 2,    --名称-string 
  description = 3,    --描述-string 
  color = 4,    --品质-int 
  view_time = 5,    --可见天数-int 
  time_value = 6,    --有效天数-int 
  square_res = 7,    --方块样式-string 
  origin_res = 8,    --普通样式-string 
  long_res = 9,    --长条样式-string 
  text_color = 10,    --字体颜色-string 
  outline_color = 11,    --描边颜色-string 

}

-- key type
local __key_type = {
  id = "int",    --颜色id-1 
  name = "string",    --名称-2 
  description = "string",    --描述-3 
  color = "int",    --品质-4 
  view_time = "int",    --可见天数-5 
  time_value = "int",    --有效天数-6 
  square_res = "string",    --方块样式-7 
  origin_res = "string",    --普通样式-8 
  long_res = "string",    --长条样式-9 
  text_color = "string",    --字体颜色-10 
  outline_color = "string",    --描边颜色-11 

}


-- data
local guild_true_flag = {
    version =  1,
    _data = {
        [1] = {1,"基础颜色-酡红","",3,1,0,"img_colour01","img_flag_colour01","img_flag_colour01a","255,255,255","160,4,0",},
        [2] = {2,"基础颜色-橘黄","",3,1,0,"img_colour02","img_flag_colour02","img_flag_colour02a","255,255,255","215,66,0",},
        [3] = {3,"基础颜色-赤金","",3,1,0,"img_colour03","img_flag_colour03","img_flag_colour03a","255,255,255","233,148,0",},
        [4] = {4,"基础颜色-葱绿","",3,1,0,"img_colour04","img_flag_colour04","img_flag_colour04a","255,255,255","45,186,0",},
        [5] = {5,"基础颜色-柏绿","",3,1,0,"img_colour05","img_flag_colour05","img_flag_colour05a","255,255,255","0,141,70",},
        [6] = {6,"基础颜色-青碧","",3,1,0,"img_colour06","img_flag_colour06","img_flag_colour06a","255,255,255","0,150,122",},
        [7] = {7,"基础颜色-湖蓝","",3,1,0,"img_colour07","img_flag_colour07","img_flag_colour07a","255,255,255","21,91,187",},
        [8] = {8,"基础颜色-青莲","",3,1,0,"img_colour08","img_flag_colour08","img_flag_colour08a","255,255,255","119,0,179",},
        [9] = {9,"基础颜色-紫棠","",3,1,0,"img_colour09","img_flag_colour09","img_flag_colour09a","255,255,255","166,0,176",},
        [10] = {10,"基础颜色-黄栌","",3,1,0,"img_colour10","img_flag_colour10","img_flag_colour10a","255,255,255","180,86,51",},
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
        assert(key_map[k], "cannot find " .. k .. " in guild_true_flag")
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
function guild_true_flag.length()
    return #guild_true_flag._data
end

-- 
function guild_true_flag.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_true_flag.isVersionValid(v)
    if guild_true_flag.version then
        if v then
            return guild_true_flag.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_true_flag.indexOf(index)
    if index == nil or not guild_true_flag._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_true_flag.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_true_flag.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_true_flag.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_true_flag" )
                _isDataExist = guild_true_flag.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_true_flag" )
                _isBaseExist = guild_true_flag.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_true_flag" )
                _isExist = guild_true_flag.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_true_flag" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_true_flag" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_true_flag._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_true_flag" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_true_flag.get(id)
    
    return guild_true_flag.indexOf(__index_id[id])
        
end

--
function guild_true_flag.set(id, key, value)
    local record = guild_true_flag.get(id)
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
function guild_true_flag.index()
    return __index_id
end

return guild_true_flag