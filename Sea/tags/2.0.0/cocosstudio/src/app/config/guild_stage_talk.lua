--guild_stage_talk

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  combat_min = 2,    --战力千分比下限-int 
  combat_max = 3,    --战力千分比上限-int 
  talk1 = 4,    --说话1-string 
  talk2 = 5,    --说话2-string 
  talk3 = 6,    --说话3-string 
  talk4 = 7,    --说话4-string 
  talk5 = 8,    --说话5-string 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  combat_min = "int",    --战力千分比下限-2 
  combat_max = "int",    --战力千分比上限-3 
  talk1 = "string",    --说话1-4 
  talk2 = "string",    --说话2-5 
  talk3 = "string",    --说话3-6 
  talk4 = "string",    --说话4-7 
  talk5 = "string",    --说话5-8 

}


-- data
local guild_stage_talk = {
    _data = {
        [1] = {1,1201,1000000,"不是……不要误会，我不是针对你","我是说在做各位……都是垃圾","我一拳下去，你可能会死哦！","弱者为何要战斗？！","我一根手指都能灭了你！",},
        [2] = {2,801,1200,"顺流而下，袭敌不备！","你是令人敬佩的对手！","旗鼓相当的对手，本将军喜欢！","今日便是你们军团的末日！","不要走！今日我要与你大战300回合！",},
        [3] = {3,0,800,"我从未见过有如此厚颜无耻之人！","将军饶命，小的上有老下有小！","不找个旗鼓相当的对手吗？","打我对你没啥好处！","我建议你找我上面的家伙！",},
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
        assert(__key_map[k], "cannot find " .. k .. " in guild_stage_talk")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function guild_stage_talk.length()
    return #guild_stage_talk._data
end

-- 
function guild_stage_talk.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function guild_stage_talk.indexOf(index)
    if index == nil or not guild_stage_talk._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/guild_stage_talk.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "guild_stage_talk" )
        return setmetatable({_raw = guild_stage_talk._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = guild_stage_talk._data[index]}, mt)
end

--
function guild_stage_talk.get(id)
    
    return guild_stage_talk.indexOf(__index_id[id])
        
end

--
function guild_stage_talk.set(id, key, value)
    local record = guild_stage_talk.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function guild_stage_talk.index()
    return __index_id
end

return guild_stage_talk