--auction

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  name = 2,    --子叶签-string 
  auction_type = 3,    --拍卖所属类型-int 
  auction_open_time = 4,    --拍卖开启时间-int 
  auction_continued_time = 5,    --拍卖持续时间-int 
  touch_time = 6,    --顶价触发时间-int 
  extend_time = 7,    --顶价延长时间-int 
  end_time = 8,    --结束时间-int 
  cfg_name = 9,    --对应产出配表-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  name = "string",    --子叶签-2 
  auction_type = "int",    --拍卖所属类型-3 
  auction_open_time = "int",    --拍卖开启时间-4 
  auction_continued_time = "int",    --拍卖持续时间-5 
  touch_time = "int",    --顶价触发时间-6 
  extend_time = "int",    --顶价延长时间-7 
  end_time = "int",    --结束时间-8 
  cfg_name = "string",    --对应产出配表-9 

}


-- data
local auction = {
    _data = {
        [1] = {101,"军团BOSS",1,300,600,30,30,0,"boss_auction_content",},
        [2] = {102,"军团答题",1,300,600,30,30,0,"answer_auction_content",},
        [3] = {103,"军团试炼",1,300,600,30,30,0,"guild_stage_auction_content",},
        [4] = {104,"三国战记",1,300,600,30,30,0,"guild_boss_auction_content",},
        [5] = {105,"军团战",1,300,600,30,30,0,"guild_war_auction_content",},
        [6] = {201,"全服",2,300,0,30,30,79200,"",},
        [7] = {301,"阵营竞技",3,300,600,30,30,0,"pvppro_auction_content",},
        [8] = {401,"城池行商",4,300,600,30,30,0,"guild_war_city_auction_content",},
        [9] = {501,"神秘行商",5,300,0,30,30,70200,"update_auction_content",},
        [10] = {601,"跨服个人",6,300,600,30,30,0,"pvpsingle_auction_content",},
        [11] = {701,"跨服军团战",1,300,600,30,30,0,"guild_cross_war_auction_content",},
    }
}

-- index
local __index_id = {
    [101] = 1,
    [102] = 2,
    [103] = 3,
    [104] = 4,
    [105] = 5,
    [201] = 6,
    [301] = 7,
    [401] = 8,
    [501] = 9,
    [601] = 10,
    [701] = 11,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in auction")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function auction.length()
    return #auction._data
end

-- 
function auction.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function auction.indexOf(index)
    if index == nil or not auction._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/auction.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "auction" )
        return setmetatable({_raw = auction._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = auction._data[index]}, mt)
end

--
function auction.get(id)
    
    return auction.indexOf(__index_id[id])
        
end

--
function auction.set(id, key, value)
    local record = auction.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function auction.index()
    return __index_id
end

return auction