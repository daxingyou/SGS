--story_stage_guide

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  type = 2,    --类型-int 
  value = 3,    --参数-int 
  x = 4,    --x偏移-int 
  y = 5,    --Y偏移-int 
  text = 6,    --文本-string 
  level_min = 7,    --等级下区间-int 
  level_max = 8,    --等级上区间-int 
  time_min = 9,    --存在时间下限-int 
  time_max = 10,    --存在时间上限-int 
  cd_min = 11,    --再次出现时间下限-int 
  cd_max = 12,    --再次出现时间上限-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  type = "int",    --类型-2 
  value = "int",    --参数-3 
  x = "int",    --x偏移-4 
  y = "int",    --Y偏移-5 
  text = "string",    --文本-6 
  level_min = "int",    --等级下区间-7 
  level_max = "int",    --等级上区间-8 
  time_min = "int",    --存在时间下限-9 
  time_max = "int",    --存在时间上限-10 
  cd_min = "int",    --再次出现时间下限-11 
  cd_max = "int",    --再次出现时间上限-12 

}


-- data
local story_stage_guide = {
    version =  1,
    _data = {
        [1] = {1001,1,0,85,75,"主公快去征战吧！",5,20,4,5,3,4,},
        [2] = {2001,2,2,0,120,"",5,10,3,4,3,4,},
        [3] = {2002,2,3,0,120,"",5,10,3,4,3,4,},
        [4] = {3001,3,100201,0,-150,"",5,10,3,4,3,4,},
        [5] = {3002,3,100202,0,-150,"",5,10,3,4,3,4,},
        [6] = {3003,3,100203,0,-150,"",5,10,3,4,3,4,},
        [7] = {3004,3,100204,0,-150,"",5,10,3,4,3,4,},
        [8] = {3005,3,100205,0,-150,"",5,10,3,4,3,4,},
        [9] = {3006,3,100206,0,-150,"",5,10,3,4,3,4,},
    }
}

-- index
local __index_id = {
    [1001] = 1,
    [2001] = 2,
    [2002] = 3,
    [3001] = 4,
    [3002] = 5,
    [3003] = 6,
    [3004] = 7,
    [3005] = 8,
    [3006] = 9,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1001,
    [2] = 2001,
    [3] = 2002,
    [4] = 3001,
    [5] = 3002,
    [6] = 3003,
    [7] = 3004,
    [8] = 3005,
    [9] = 3006,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in story_stage_guide")
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
function story_stage_guide.length()
    return #story_stage_guide._data
end

-- 
function story_stage_guide.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function story_stage_guide.isVersionValid(v)
    if story_stage_guide.version then
        if v then
            return story_stage_guide.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function story_stage_guide.indexOf(index)
    if index == nil or not story_stage_guide._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/story_stage_guide.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/story_stage_guide.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/story_stage_guide.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "story_stage_guide" )
                _isDataExist = story_stage_guide.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "story_stage_guide" )
                _isBaseExist = story_stage_guide.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "story_stage_guide" )
                _isExist = story_stage_guide.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "story_stage_guide" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "story_stage_guide" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = story_stage_guide._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "story_stage_guide" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function story_stage_guide.get(id)
    
    return story_stage_guide.indexOf(__index_id[id])
        
end

--
function story_stage_guide.set(id, key, value)
    local record = story_stage_guide.get(id)
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
function story_stage_guide.index()
    return __index_id
end

return story_stage_guide