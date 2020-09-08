--exp_over

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  level = 2,    --等级-int 
  exp = 3,    --溢出经验上限-int 
  drop_id = 4,    --随机奖励-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  level = "int",    --等级-2 
  exp = "int",    --溢出经验上限-3 
  drop_id = "int",    --随机奖励-4 

}


-- data
local exp_over = {
    version =  1,
    _data = {
        [1] = {1,120,1500000,80001,},
    }
}

-- index
local __index_id = {
    [1] = 1,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in exp_over")
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
function exp_over.length()
    return #exp_over._data
end

-- 
function exp_over.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function exp_over.isVersionValid(v)
    if exp_over.version then
        if v then
            return exp_over.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function exp_over.indexOf(index)
    if index == nil or not exp_over._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/exp_over.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/exp_over.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/exp_over.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "exp_over" )
                _isDataExist = exp_over.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "exp_over" )
                _isBaseExist = exp_over.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "exp_over" )
                _isExist = exp_over.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "exp_over" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "exp_over" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = exp_over._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "exp_over" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function exp_over.get(id)
    
    return exp_over.indexOf(__index_id[id])
        
end

--
function exp_over.set(id, key, value)
    local record = exp_over.get(id)
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
function exp_over.index()
    return __index_id
end

return exp_over