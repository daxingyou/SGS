--story_period_box

local _lang = "cn"
local _isExist = false

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

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in story_period_box")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
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
function story_period_box.indexOf(index)
    if index == nil or not story_period_box._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/story_period_box.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "story_period_box" )
        return setmetatable({_raw = story_period_box._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = story_period_box._data[index]}, mt)
end

--
function story_period_box.get(id)
    
    return story_period_box.indexOf(__index_id[id])
        
end

--
function story_period_box.set(id, key, value)
    local record = story_period_box.get(id)
    if record then
        local keyIndex = __key_map[key]
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