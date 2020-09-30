--graincar

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  name = 2,    --粮车名称-string 
  color = 3,    --粮车品质-int 
  icon = 4,    --粮车头像-int 
  stamina = 5,    --粮车耐久-int 
  exp = 6,    --粮车升级经验-int 
  bonus = 7,    --达到终点奖励提升系数-int 
  stop_reduce = 8,    --矿点停留时间减少百分比-int 
  moving = 9,    --2矿移动时间（秒）-int 
  attack_lose_rate = 10,    --攻击粮车消耗兵力加成千分比-int 
  recovery_stamina = 11,    --每次移动后，回复自身耐久度-int 
  goes_type = 12,    --发车奖励类型-int 
  goes_value = 13,    --发车奖励类型-string 
  goes_size = 14,    --发车奖励类型-int 
  day = 15,    --发车奖励分割天数-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  name = "string",    --粮车名称-2 
  color = "int",    --粮车品质-3 
  icon = "int",    --粮车头像-4 
  stamina = "int",    --粮车耐久-5 
  exp = "int",    --粮车升级经验-6 
  bonus = "int",    --达到终点奖励提升系数-7 
  stop_reduce = "int",    --矿点停留时间减少百分比-8 
  moving = "int",    --2矿移动时间（秒）-9 
  attack_lose_rate = "int",    --攻击粮车消耗兵力加成千分比-10 
  recovery_stamina = "int",    --每次移动后，回复自身耐久度-11 
  goes_type = "int",    --发车奖励类型-12 
  goes_value = "string",    --发车奖励类型-13 
  goes_size = "int",    --发车奖励类型-14 
  day = "int",    --发车奖励分割天数-15 

}


-- data
local graincar = {
    version =  1,
    _data = {
        [1] = {1,"粮车",2,66001,1200,30000,1000,0,18,0,0,6,"175|175",1,21,},
        [2] = {2,"木牛",3,66002,1500,60000,1000,0,14,0,0,6,"175|175",3,21,},
        [3] = {3,"流马",4,66003,1800,90000,1000,200,20,0,0,6,"175|175",6,21,},
        [4] = {4,"灵巧犀",5,66004,2100,120000,1000,200,14,1000,0,6,"175|175",8,21,},
        [5] = {5,"无极象",6,66005,2400,0,1000,200,14,1000,100,6,"175|175",10,21,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in graincar")
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
function graincar.length()
    return #graincar._data
end

-- 
function graincar.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function graincar.isVersionValid(v)
    if graincar.version then
        if v then
            return graincar.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function graincar.indexOf(index)
    if index == nil or not graincar._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/graincar.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/graincar.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/graincar.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "graincar" )
                _isDataExist = graincar.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "graincar" )
                _isBaseExist = graincar.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "graincar" )
                _isExist = graincar.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "graincar" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "graincar" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = graincar._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "graincar" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function graincar.get(id)
    
    return graincar.indexOf(__index_id[id])
        
end

--
function graincar.set(id, key, value)
    local record = graincar.get(id)
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
function graincar.index()
    return __index_id
end

return graincar