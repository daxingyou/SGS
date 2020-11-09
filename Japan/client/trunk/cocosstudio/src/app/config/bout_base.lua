--bout_base

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  next = 2,    --后置阵法-int 
  need_office = 3,    --需要官衔等级-int 
  name = 4,    --阵法名称-string 
  name_pic = 5,    --阵法名称美术资源，其实没用-string 
  color = 6,    --阵法品质色-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  next = "int",    --后置阵法-2 
  need_office = "int",    --需要官衔等级-3 
  name = "string",    --阵法名称-4 
  name_pic = "string",    --阵法名称美术资源，其实没用-5 
  color = "int",    --阵法品质色-6 

}


-- data
local bout_base = {
    version =  1,
    _data = {
        [1] = {1,2,0,"圆形阵","txt_bout_01",5,},
        [2] = {2,3,7,"锋矢阵","txt_bout_02",5,},
        [3] = {3,4,8,"天地人阵","txt_bout_03",6,},
        [4] = {4,5,9,"日月星阵","txt_bout_04",6,},
        [5] = {5,6,10,"北斗七星阵","txt_bout_05",7,},
        [6] = {6,0,11,"五行八卦阵","txt_bout_06",7,},
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
        assert(key_map[k], "cannot find " .. k .. " in bout_base")
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
function bout_base.length()
    return #bout_base._data
end

-- 
function bout_base.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function bout_base.isVersionValid(v)
    if bout_base.version then
        if v then
            return bout_base.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function bout_base.indexOf(index)
    if index == nil or not bout_base._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/bout_base.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/bout_base.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/bout_base.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "bout_base" )
                _isDataExist = bout_base.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "bout_base" )
                _isBaseExist = bout_base.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "bout_base" )
                _isExist = bout_base.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "bout_base" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "bout_base" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = bout_base._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "bout_base" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function bout_base.get(id)
    
    return bout_base.indexOf(__index_id[id])
        
end

--
function bout_base.set(id, key, value)
    local record = bout_base.get(id)
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
function bout_base.index()
    return __index_id
end

return bout_base