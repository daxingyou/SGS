--explore_hero

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  level_min = 2,    --等级下区间-int 
  level_max = 3,    --等级上区间-int 
  hero1_color = 4,    --武将1品质-int 
  hero1_chance = 5,    --武将1品质权重-int 
  hero1_type = 6,    --招募1货币类型-int 
  hero1_resource = 7,    --招募1货币资源-int 
  hero1_size = 8,    --招募1货币数量-int 
  hero2_color = 9,    --武将2品质-int 
  hero2_chance = 10,    --武将2品质权重-int 
  hero2_type = 11,    --招募2货币类型-int 
  hero2_resource = 12,    --招募2货币资源-int 
  hero2_size = 13,    --招募2货币数量-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  level_min = "int",    --等级下区间-2 
  level_max = "int",    --等级上区间-3 
  hero1_color = "int",    --武将1品质-4 
  hero1_chance = "int",    --武将1品质权重-5 
  hero1_type = "int",    --招募1货币类型-6 
  hero1_resource = "int",    --招募1货币资源-7 
  hero1_size = "int",    --招募1货币数量-8 
  hero2_color = "int",    --武将2品质-9 
  hero2_chance = "int",    --武将2品质权重-10 
  hero2_type = "int",    --招募2货币类型-11 
  hero2_resource = "int",    --招募2货币资源-12 
  hero2_size = "int",    --招募2货币数量-13 

}


-- data
local explore_hero = {
    version =  1,
    _data = {
        [1] = {1,1,43,4,1000,5,1,800,5,200,5,1,4000,},
        [2] = {2,44,120,4,1000,5,1,800,5,200,5,1,4000,},
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
        assert(key_map[k], "cannot find " .. k .. " in explore_hero")
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
function explore_hero.length()
    return #explore_hero._data
end

-- 
function explore_hero.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function explore_hero.isVersionValid(v)
    if explore_hero.version then
        if v then
            return explore_hero.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function explore_hero.indexOf(index)
    if index == nil or not explore_hero._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/explore_hero.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/explore_hero.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/explore_hero.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "explore_hero" )
                _isDataExist = explore_hero.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "explore_hero" )
                _isBaseExist = explore_hero.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "explore_hero" )
                _isExist = explore_hero.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "explore_hero" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "explore_hero" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = explore_hero._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "explore_hero" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function explore_hero.get(id)
    
    return explore_hero.indexOf(__index_id[id])
        
end

--
function explore_hero.set(id, key, value)
    local record = explore_hero.get(id)
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
function explore_hero.index()
    return __index_id
end

return explore_hero