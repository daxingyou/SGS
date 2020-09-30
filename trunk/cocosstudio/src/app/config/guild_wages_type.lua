--guild_wages_type

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  type = 1,    --类型-int 
  name = 2,    --任务名称-string 
  index = 3,    --排列-int 
  is_open = 4,    --是否显示已开放-int 
  max_active = 5,    --最大活跃度-int 
  color1 = 6,    --毫无生气需要积分-int 
  color2 = 7,    --不活跃需要积分-int 
  color3 = 8,    --普通需要积分-int 
  color4 = 9,    --活跃需要积分-int 
  color5 = 10,    --非常活跃需要积分-int 
  function_id = 11,    --功能跳转-int 

}

-- key type
local __key_type = {
  type = "int",    --类型-1 
  name = "string",    --任务名称-2 
  index = "int",    --排列-3 
  is_open = "int",    --是否显示已开放-4 
  max_active = "int",    --最大活跃度-5 
  color1 = "int",    --毫无生气需要积分-6 
  color2 = "int",    --不活跃需要积分-7 
  color3 = "int",    --普通需要积分-8 
  color4 = "int",    --活跃需要积分-9 
  color5 = "int",    --非常活跃需要积分-10 
  function_id = "int",    --功能跳转-11 

}


-- data
local guild_wages_type = {
    version =  1,
    _data = {
        [1] = {1,"三国战记",1,1,40,0,8,16,24,32,67,},
        [2] = {2,"军团捐献",2,1,40,0,8,16,24,32,62,},
        [3] = {3,"军团BOSS",4,1,80,0,16,32,48,64,803,},
        [4] = {4,"答题活动",6,1,40,0,8,16,24,32,87,},
        [5] = {5,"军团试炼",5,1,40,0,8,16,24,32,64,},
        [6] = {6,"军团援助",3,1,40,0,8,16,24,32,63,},
    }
}

-- index
local __index_type = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_wages_type")
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
function guild_wages_type.length()
    return #guild_wages_type._data
end

-- 
function guild_wages_type.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_wages_type.isVersionValid(v)
    if guild_wages_type.version then
        if v then
            return guild_wages_type.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_wages_type.indexOf(index)
    if index == nil or not guild_wages_type._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_wages_type.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_wages_type.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_wages_type.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_wages_type" )
                _isDataExist = guild_wages_type.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_wages_type" )
                _isBaseExist = guild_wages_type.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_wages_type" )
                _isExist = guild_wages_type.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_wages_type" )
        local main_key = __main_key_map[index]
		local index_key = "__index_type"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_wages_type" )
        local main_key = __main_key_map[index]
		local index_key = "__index_type"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_wages_type._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_wages_type" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_wages_type.get(type)
    
    return guild_wages_type.indexOf(__index_type[type])
        
end

--
function guild_wages_type.set(type, key, value)
    local record = guild_wages_type.get(type)
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
function guild_wages_type.index()
    return __index_type
end

return guild_wages_type