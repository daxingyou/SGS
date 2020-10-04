--sgs_linkage

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --账号-int 
  type = 2,    --类型-int 
  value = 3,    --类型值-int 
  mission_description = 4,    --说明-string 
  reward_name = 5,    --奖励名称-string 
  reward_num = 6,    --奖励数量-int 
  reward_icon = 7,    --奖励图标-string 

}

-- key type
local __key_type = {
  id = "int",    --账号-1 
  type = "int",    --类型-2 
  value = "int",    --类型值-3 
  mission_description = "string",    --说明-4 
  reward_name = "string",    --奖励名称-5 
  reward_num = "int",    --奖励数量-6 
  reward_icon = "string",    --奖励图标-7 

}


-- data
local sgs_linkage = {
    _data = {
        [1] = {1,1,20,"主角升到#num#级","银币",100,"img_linkageactivity_03",},
        [2] = {2,1,35,"主角升到#num#级","进阶丹",1,"img_linkageactivity_04",},
        [3] = {3,1,50,"主角升到#num#级","雁翎甲",1,"img_linkageactivity_05",},
        [4] = {4,2,1,"完成首充","欢乐豆",100,"img_linkageactivity_06",},
        [5] = {5,2,30,"累充#num#元","招募令",1,"img_linkageactivity_07",},
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

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in sgs_linkage")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function sgs_linkage.length()
    return #sgs_linkage._data
end

-- 
function sgs_linkage.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function sgs_linkage.indexOf(index)
    if index == nil or not sgs_linkage._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/sgs_linkage.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "sgs_linkage" )
        return setmetatable({_raw = sgs_linkage._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = sgs_linkage._data[index]}, mt)
end

--
function sgs_linkage.get(id)
    
    return sgs_linkage.indexOf(__index_id[id])
        
end

--
function sgs_linkage.set(id, key, value)
    local record = sgs_linkage.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function sgs_linkage.index()
    return __index_id
end

return sgs_linkage