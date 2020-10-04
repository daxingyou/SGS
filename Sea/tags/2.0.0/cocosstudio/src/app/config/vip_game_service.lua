--vip_game_service

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  image = 2,    --图片名称-string 
  line_id = 3,    --line号-string 
  wechat_id = 4,    --微信号-string 
  server_id = 5,    --服务器尾数-string 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  image = "string",    --图片名称-2 
  line_id = "string",    --line号-3 
  wechat_id = "string",    --微信号-4 
  server_id = "string",    --服务器尾数-5 

}


-- data
local vip_game_service = {
    _data = {
        [1] = {1,"1","eskyfun-gigi","eskyfun-gigi","1|2|3",},
        [2] = {2,"2","eskyfun_lala","eskyfun-mika","4|5|6",},
        [3] = {3,"3","eskyfun_mimi","eskyfun-mimi","7|8",},
        [4] = {4,"5","eskyfunzxj","eskyfun-kiki","9|0",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in vip_game_service")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function vip_game_service.length()
    return #vip_game_service._data
end

-- 
function vip_game_service.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function vip_game_service.indexOf(index)
    if index == nil or not vip_game_service._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/vip_game_service.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "vip_game_service" )
        return setmetatable({_raw = vip_game_service._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = vip_game_service._data[index]}, mt)
end

--
function vip_game_service.get(id)
    
    return vip_game_service.indexOf(__index_id[id])
        
end

--
function vip_game_service.set(id, key, value)
    local record = vip_game_service.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function vip_game_service.index()
    return __index_id
end

return vip_game_service