--answer_award

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --回答-int 
  right_type1 = 2,    --答对奖励类型1-int 
  right_resource1 = 3,    --答对奖励资源1-int 
  right_size1 = 4,    --答对奖励数量1-int 
  right_type2 = 5,    --答对奖励类型2-int 
  right_resource2 = 6,    --答对奖励资源2-int 
  right_size2 = 7,    --答对奖励数量2-int 

}

-- key type
local __key_type = {
  id = "int",    --回答-1 
  right_type1 = "int",    --答对奖励类型1-2 
  right_resource1 = "int",    --答对奖励资源1-3 
  right_size1 = "int",    --答对奖励数量1-4 
  right_type2 = "int",    --答对奖励类型2-5 
  right_resource2 = "int",    --答对奖励资源2-6 
  right_size2 = "int",    --答对奖励数量2-7 

}


-- data
local answer_award = {
    version =  1,
    _data = {
        [1] = {1,5,13,200,5,18,20,},
        [2] = {2,5,13,100,5,18,10,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in answer_award")
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
function answer_award.length()
    return #answer_award._data
end

-- 
function answer_award.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function answer_award.isVersionValid(v)
    if answer_award.version then
        if v then
            return answer_award.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function answer_award.indexOf(index)
    if index == nil or not answer_award._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/answer_award.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/answer_award.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/answer_award.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "answer_award" )
                _isDataExist = answer_award.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "answer_award" )
                _isBaseExist = answer_award.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "answer_award" )
                _isExist = answer_award.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "answer_award" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "answer_award" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = answer_award._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "answer_award" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function answer_award.get(id)
    
    return answer_award.indexOf(__index_id[id])
        
end

--
function answer_award.set(id, key, value)
    local record = answer_award.get(id)
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
function answer_award.index()
    return __index_id
end

return answer_award