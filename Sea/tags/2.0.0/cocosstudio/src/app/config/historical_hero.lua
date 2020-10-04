--historical_hero

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  type = 2,    --类型-int 
  color = 3,    --品质-int 
  name = 4,    --名称-string 
  res_id = 5,    --资源id-int 
  fragment_id = 6,    --对应碎片id-int 
  arm = 7,    --对应武器id-int 
  is_open = 8,    --图鉴是否开启-int 
  description = 9,    --描述-string 
  is_step = 10,    --是否可突破-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  type = "int",    --类型-2 
  color = "int",    --品质-3 
  name = "string",    --名称-4 
  res_id = "int",    --资源id-5 
  fragment_id = "int",    --对应碎片id-6 
  arm = "int",    --对应武器id-7 
  is_open = "int",    --图鉴是否开启-8 
  description = "string",    --描述-9 
  is_step = "int",    --是否可突破-10 

}


-- data
local historical_hero = {
    _data = {
        [1] = {101,1,4,"高渐离",200101,0,101,1,"高渐离",0,},
        [2] = {102,2,4,"荆轲",200102,0,102,1,"荆轲",0,},
        [3] = {103,3,4,"韩信",200103,0,103,1,"韩信",0,},
        [4] = {104,4,4,"张良",200104,0,104,1,"张良",0,},
        [5] = {201,1,5,"秦始皇",200201,130001,201,0,"秦始皇",1,},
        [6] = {202,2,5,"汉武帝",200202,130002,202,0,"汉武帝",1,},
        [7] = {203,3,5,"项羽",107,130003,203,0,"项羽",1,},
        [8] = {204,4,5,"虞姬",108,130004,204,0,"虞姬",1,},
    }
}

-- index
local __index_id = {
    [101] = 1,
    [102] = 2,
    [103] = 3,
    [104] = 4,
    [201] = 5,
    [202] = 6,
    [203] = 7,
    [204] = 8,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in historical_hero")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function historical_hero.length()
    return #historical_hero._data
end

-- 
function historical_hero.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function historical_hero.indexOf(index)
    if index == nil or not historical_hero._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/historical_hero.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "historical_hero" )
        return setmetatable({_raw = historical_hero._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = historical_hero._data[index]}, mt)
end

--
function historical_hero.get(id)
    
    return historical_hero.indexOf(__index_id[id])
        
end

--
function historical_hero.set(id, key, value)
    local record = historical_hero.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function historical_hero.index()
    return __index_id
end

return historical_hero