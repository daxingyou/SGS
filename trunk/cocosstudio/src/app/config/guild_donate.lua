--guild_donate

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  name = 2,    --捐献名称-string 
  cost_type = 3,    --捐献需要资源类型-int 
  cost_value = 4,    --捐献需要资源子类-int 
  cost_size = 5,    --捐献需要资源数量-int 
  crit = 6,    --暴击概率-int 
  exp = 7,    --获得军团声望-int 
  crit_exp = 8,    --暴击军团声望-int 
  contribution = 9,    --获得个人贡献-int 
  crit_contribution = 10,    --暴击个人贡献-int 
  point = 11,    --每次捐献积分-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  name = "string",    --捐献名称-2 
  cost_type = "int",    --捐献需要资源类型-3 
  cost_value = "int",    --捐献需要资源子类-4 
  cost_size = "int",    --捐献需要资源数量-5 
  crit = "int",    --暴击概率-6 
  exp = "int",    --获得军团声望-7 
  crit_exp = "int",    --暴击军团声望-8 
  contribution = "int",    --获得个人贡献-9 
  crit_contribution = "int",    --暴击个人贡献-10 
  point = "int",    --每次捐献积分-11 

}


-- data
local guild_donate = {
    version =  1,
    _data = {
        [1] = {1,"礼宗庙",5,2,50000,200,50,75,500,750,1,},
        [2] = {2,"祭地袛",5,1,100,200,100,150,1000,1500,1,},
        [3] = {3,"祭天神",5,1,200,200,300,450,3000,4500,1,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_donate")
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
function guild_donate.length()
    return #guild_donate._data
end

-- 
function guild_donate.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_donate.isVersionValid(v)
    if guild_donate.version then
        if v then
            return guild_donate.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_donate.indexOf(index)
    if index == nil or not guild_donate._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_donate.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_donate.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_donate.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_donate" )
                _isDataExist = guild_donate.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_donate" )
                _isBaseExist = guild_donate.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_donate" )
                _isExist = guild_donate.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_donate" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_donate" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_donate._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_donate" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_donate.get(id)
    
    return guild_donate.indexOf(__index_id[id])
        
end

--
function guild_donate.set(id, key, value)
    local record = guild_donate.get(id)
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
function guild_donate.index()
    return __index_id
end

return guild_donate