--common_award

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  function_id = 2,    --function_id-int 
  mail_id = 3,    --发送奖励邮件id-int 
  type1 = 4,    --奖励类型-int 
  value1 = 5,    --奖励类型值-int 
  size1 = 6,    --奖励数量-int 
  type2 = 7,    --奖励类型-int 
  value2 = 8,    --奖励类型值-int 
  size2 = 9,    --奖励数量-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  function_id = "int",    --function_id-2 
  mail_id = "int",    --发送奖励邮件id-3 
  type1 = "int",    --奖励类型-4 
  value1 = "int",    --奖励类型值-5 
  size1 = "int",    --奖励数量-6 
  type2 = "int",    --奖励类型-7 
  value2 = "int",    --奖励类型值-8 
  size2 = "int",    --奖励数量-9 

}


-- data
local common_award = {
    version =  1,
    _data = {
        [1] = {1,1001,8501,5,1,100,5,2,5000,},
        [2] = {2,1002,8501,5,1,200,5,2,6000,},
        [3] = {3,1003,8501,5,1,300,5,2,7000,},
        [4] = {4,1004,8501,5,1,400,5,2,8000,},
        [5] = {5,1005,8501,5,1,500,5,2,9000,},
        [6] = {6,1006,8501,5,1,600,5,2,10000,},
        [7] = {7,1007,8501,5,1,700,5,2,11000,},
        [8] = {8,2001,0,5,1,200,0,0,0,},
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
        assert(key_map[k], "cannot find " .. k .. " in common_award")
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
function common_award.length()
    return #common_award._data
end

-- 
function common_award.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function common_award.isVersionValid(v)
    if common_award.version then
        if v then
            return common_award.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function common_award.indexOf(index)
    if index == nil or not common_award._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/common_award.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/common_award.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/common_award.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "common_award" )
                _isDataExist = common_award.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "common_award" )
                _isBaseExist = common_award.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "common_award" )
                _isExist = common_award.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "common_award" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "common_award" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = common_award._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "common_award" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function common_award.get(id)
    
    return common_award.indexOf(__index_id[id])
        
end

--
function common_award.set(id, key, value)
    local record = common_award.get(id)
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
function common_award.index()
    return __index_id
end

return common_award