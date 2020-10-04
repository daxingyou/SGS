--equipment_level_critical

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  templet = 1,    --装备模板-int 
  critical1_level = 2,    --暴击1倍数-int 
  critical1_chance = 3,    --暴击1概率-int 
  critical2_level = 4,    --暴击2倍数-int 
  critical2_chance = 5,    --暴击2概率-int 
  critical3_level = 6,    --暴击3倍数-int 
  critical3_chance = 7,    --暴击3概率-int 

}

-- key type
local __key_type = {
  templet = "int",    --装备模板-1 
  critical1_level = "int",    --暴击1倍数-2 
  critical1_chance = "int",    --暴击1概率-3 
  critical2_level = "int",    --暴击2倍数-4 
  critical2_chance = "int",    --暴击2概率-5 
  critical3_level = "int",    --暴击3倍数-6 
  critical3_chance = "int",    --暴击3概率-7 

}


-- data
local equipment_level_critical = {
    _data = {
        [1] = {1,1,65,2,25,3,10,},
        [2] = {2,1,65,2,25,3,10,},
        [3] = {3,1,65,2,25,3,10,},
        [4] = {4,1,65,2,25,3,10,},
    }
}

-- index
local __index_templet = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in equipment_level_critical")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function equipment_level_critical.length()
    return #equipment_level_critical._data
end

-- 
function equipment_level_critical.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function equipment_level_critical.indexOf(index)
    if index == nil or not equipment_level_critical._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/equipment_level_critical.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "equipment_level_critical" )
        return setmetatable({_raw = equipment_level_critical._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = equipment_level_critical._data[index]}, mt)
end

--
function equipment_level_critical.get(templet)
    
    return equipment_level_critical.indexOf(__index_templet[templet])
        
end

--
function equipment_level_critical.set(templet, key, value)
    local record = equipment_level_critical.get(templet)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function equipment_level_critical.index()
    return __index_templet
end

return equipment_level_critical