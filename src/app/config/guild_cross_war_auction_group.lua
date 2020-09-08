--guild_cross_war_auction_group

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  group = 2,    --掉落组-int 
  type = 3,    --掉落类型-int 
  auction_full_tab = 4,    --所属全服拍卖页签-int 
  value = 5,    --类型值-int 
  size = 6,    --堆叠-int 
  start_price = 7,    --起拍价-int 
  fare = 8,    --加价-int 
  net = 9,    --一口价-int 
  price_id = 10,    --货币类型，0元宝，1玉璧-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  group = "int",    --掉落组-2 
  type = "int",    --掉落类型-3 
  auction_full_tab = "int",    --所属全服拍卖页签-4 
  value = "int",    --类型值-5 
  size = "int",    --堆叠-6 
  start_price = "int",    --起拍价-7 
  fare = "int",    --加价-8 
  net = "int",    --一口价-9 
  price_id = "int",    --货币类型，0元宝，1玉璧-10 

}


-- data
local guild_cross_war_auction_group = {
    version =  1,
    _data = {
        [1] = {1,1,11,5,1406,1,27000,4050,67500,0,},
        [2] = {2,1,11,5,1407,1,27000,4050,67500,0,},
        [3] = {3,1,11,5,1408,1,27000,4050,67500,0,},
        [4] = {101,1,11,5,1405,1,27000,4050,67500,0,},
        [5] = {4,2,6,10,555,1,2700,405,6750,0,},
        [6] = {5,2,6,10,556,1,2700,405,6750,0,},
        [7] = {6,3,6,10,721,1,3200,480,8000,0,},
        [8] = {7,3,6,10,722,1,3200,480,8000,0,},
        [9] = {8,4,6,4,706,1,3000,450,7500,0,},
        [10] = {9,5,14,6,101,1,8000,1200,20000,0,},
        [11] = {10,5,14,6,102,1,8000,1200,20000,0,},
        [12] = {11,5,14,6,103,1,8000,1200,20000,0,},
        [13] = {12,5,14,6,104,1,8000,1200,20000,0,},
        [14] = {13,6,7,6,140001,1,3000,450,7500,1,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 11,
    [101] = 4,
    [11] = 12,
    [12] = 13,
    [13] = 14,
    [2] = 2,
    [3] = 3,
    [4] = 5,
    [5] = 6,
    [6] = 7,
    [7] = 8,
    [8] = 9,
    [9] = 10,

}

-- index mainkey map
local __main_key_map = {
    [1] = 1,
    [11] = 10,
    [4] = 101,
    [12] = 11,
    [13] = 12,
    [14] = 13,
    [2] = 2,
    [3] = 3,
    [5] = 4,
    [6] = 5,
    [7] = 6,
    [8] = 7,
    [9] = 8,
    [10] = 9,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in guild_cross_war_auction_group")
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
function guild_cross_war_auction_group.length()
    return #guild_cross_war_auction_group._data
end

-- 
function guild_cross_war_auction_group.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_cross_war_auction_group.isVersionValid(v)
    if guild_cross_war_auction_group.version then
        if v then
            return guild_cross_war_auction_group.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function guild_cross_war_auction_group.indexOf(index)
    if index == nil or not guild_cross_war_auction_group._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/guild_cross_war_auction_group.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/guild_cross_war_auction_group.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/guild_cross_war_auction_group.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_auction_group" )
                _isDataExist = guild_cross_war_auction_group.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_auction_group" )
                _isBaseExist = guild_cross_war_auction_group.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_auction_group" )
                _isExist = guild_cross_war_auction_group.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "guild_cross_war_auction_group" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_cross_war_auction_group" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = guild_cross_war_auction_group._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "guild_cross_war_auction_group" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function guild_cross_war_auction_group.get(id)
    
    return guild_cross_war_auction_group.indexOf(__index_id[id])
        
end

--
function guild_cross_war_auction_group.set(id, key, value)
    local record = guild_cross_war_auction_group.get(id)
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
function guild_cross_war_auction_group.index()
    return __index_id
end

return guild_cross_war_auction_group