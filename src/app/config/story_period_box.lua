--story_period_box

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  title = 2,    --阶段标题-string 
  chapter = 3,    --领取条件-int 
  type = 4,    --奖励类型-int 
  value = 5,    --奖励类型值-int 
  size = 6,    --奖励数量-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  title = "string",    --阶段标题-2 
  chapter = "int",    --领取条件-3 
  type = "int",    --奖励类型-4 
  value = "int",    --奖励类型值-5 
  size = "int",    --奖励数量-6 

}


-- data
local story_period_box = {
    version =  1,
    _data = {
        [1] = {1,"通关第3回领取",3,5,1,500,},
        [2] = {2,"通关第6回领取",6,5,1,800,},
        [3] = {3,"通关第8回领取",8,6,112,1,},
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
        assert(key_map[k], "cannot find " .. k .. " in story_period_box")
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
function story_period_box.length()
    return #story_period_box._data
end

-- 
function story_period_box.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function story_period_box.isVersionValid(v)
    if story_period_box.version then
        if v then
            return story_period_box.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function story_period_box.indexOf(index)
    if index == nil or not story_period_box._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/story_period_box.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/story_period_box.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/story_period_box.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "story_period_box" )
                _isDataExist = story_period_box.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "story_period_box" )
                _isBaseExist = story_period_box.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "story_period_box" )
                _isExist = story_period_box.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "story_period_box" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "story_period_box" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = story_period_box._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "story_period_box" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function story_period_box.get(id)
    
    return story_period_box.indexOf(__index_id[id])
        
end

--
function story_period_box.set(id, key, value)
    local record = story_period_box.get(id)
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
function story_period_box.index()
    return __index_id
end

return story_period_box