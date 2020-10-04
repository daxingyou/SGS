--recommend_upgrade

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  function_level_id = 2,    --功能id-int 
  upgrade_limit = 3,    --上限参数-int 
  upgrade_percent = 4,    --预期参数-string 
  upgrade_level = 5,    --推荐等级-int 
  function_jump = 6,    --跳转方向-int 
  bubble_id = 7,    --提示文字id-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  function_level_id = "int",    --功能id-2 
  upgrade_limit = "int",    --上限参数-3 
  upgrade_percent = "string",    --预期参数-4 
  upgrade_level = "int",    --推荐等级-5 
  function_jump = "int",    --跳转方向-6 
  bubble_id = "int",    --提示文字id-7 

}


-- data
local recommend_upgrade = {
    _data = {
        [1] = {0,0,0,"",0,0,2000,},
        [2] = {1,102,1000,"#LEVEL#*1",1,3,2001,},
        [3] = {2,104,1000,"(#LEVEL#+5)/10",1,3,2002,},
        [4] = {3,107,1000,"#LEVEL#-50",85,3,2003,},
        [5] = {4,112,1000,"#LEVEL#*2",1,3,2004,},
        [6] = {5,114,1000,"#LEVEL#/4",1,3,2005,},
        [7] = {6,122,1000,"#LEVEL#/2",1,3,2006,},
        [8] = {7,123,1000,"#LEVEL#*120/1000",1,3,2007,},
        [9] = {8,134,1000,"#LEVEL#/2",1,3,2008,},
    }
}

-- index
local __index_id = {
    [0] = 1,
    [1] = 2,
    [2] = 3,
    [3] = 4,
    [4] = 5,
    [5] = 6,
    [6] = 7,
    [7] = 8,
    [8] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in recommend_upgrade")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function recommend_upgrade.length()
    return #recommend_upgrade._data
end

-- 
function recommend_upgrade.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function recommend_upgrade.indexOf(index)
    if index == nil or not recommend_upgrade._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/recommend_upgrade.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "recommend_upgrade" )
        return setmetatable({_raw = recommend_upgrade._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = recommend_upgrade._data[index]}, mt)
end

--
function recommend_upgrade.get(id)
    
    return recommend_upgrade.indexOf(__index_id[id])
        
end

--
function recommend_upgrade.set(id, key, value)
    local record = recommend_upgrade.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function recommend_upgrade.index()
    return __index_id
end

return recommend_upgrade