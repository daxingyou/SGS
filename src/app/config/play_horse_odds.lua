--play_horse_odds

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --序号-int 
  odds_min = 2,    --最低赔率-int 
  odds_max = 3,    --最高赔率-int 
  player = 4,    --玩家-int 
  hero = 5,    --武将-int 
  hero_library = 6,    --武将库-string 
  win_weight = 7,    --胜利权重-int 

}

-- key type
local __key_type = {
  id = "int",    --序号-1 
  odds_min = "int",    --最低赔率-2 
  odds_max = "int",    --最高赔率-3 
  player = "int",    --玩家-4 
  hero = "int",    --武将-5 
  hero_library = "string",    --武将库-6 
  win_weight = "int",    --胜利权重-7 

}


-- data
local play_horse_odds = {
    version =  1,
    _data = {
        [1] = {1,10,22,90,10,"112|215|317|415|130|302|428",650,},
        [2] = {2,5,10,90,10,"304|310|214|213|115|101|405|319|108|230|418",1420,},
        [3] = {3,5,10,90,10,"318|313|206|205|119|118|410|417|217|216|412",1420,},
        [4] = {4,2,5,90,10,"419|308|207|110|416|404|123",3254,},
        [5] = {5,2,5,90,10,"113|201|301|403",3254,},
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
        assert(key_map[k], "cannot find " .. k .. " in play_horse_odds")
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
function play_horse_odds.length()
    return #play_horse_odds._data
end

-- 
function play_horse_odds.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function play_horse_odds.isVersionValid(v)
    if play_horse_odds.version then
        if v then
            return play_horse_odds.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function play_horse_odds.indexOf(index)
    if index == nil or not play_horse_odds._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/play_horse_odds.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/play_horse_odds.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/play_horse_odds.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "play_horse_odds" )
                _isDataExist = play_horse_odds.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "play_horse_odds" )
                _isBaseExist = play_horse_odds.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "play_horse_odds" )
                _isExist = play_horse_odds.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "play_horse_odds" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "play_horse_odds" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = play_horse_odds._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "play_horse_odds" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function play_horse_odds.get(id)
    
    return play_horse_odds.indexOf(__index_id[id])
        
end

--
function play_horse_odds.set(id, key, value)
    local record = play_horse_odds.get(id)
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
function play_horse_odds.index()
    return __index_id
end

return play_horse_odds