--research_staff

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  title = 2,    --标题-string 
  name = 3,    --人员名称-string 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  title = "string",    --标题-2 
  name = "string",    --人员名称-3 

}


-- data
local research_staff = {
    _data = {
        [1] = {1,"出品","游卡桌游",},
        [2] = {2,"出品人","潘恩林",},
        [3] = {3,"总顾问","杜彬",},
        [4] = {4,"制作人","茅伟",},
        [5] = {5,"研发","曹东|李赛威|刘士豪|王淼|孙霂清|程金娟|林杰|樊淼|梁旭|黄世江|唐龙|许冷昆|李岩|冯强|刘寅超|郑雨卉|何砥砺|贠腾|吴宏杰|黄叙康|徐崟文|刘俊鹏|胡军径|高晓燕|闵芮|池邦岩|聂明|姚伟超|廖明英|黄绮清|刘杨",},
        [6] = {6,"运营","卞铭俊|唐宇|季佳慧|李霜|郑艺|洪烈",},
        [7] = {7,"市场发行","严胜|严越男|谢雯静|宋淑静|段雪蕊|姜卫星",},
        [8] = {8,"项目支持","潘旭晨|贺嘉",},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in research_staff")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function research_staff.length()
    return #research_staff._data
end

-- 
function research_staff.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function research_staff.indexOf(index)
    if index == nil or not research_staff._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/research_staff.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "research_staff" )
        return setmetatable({_raw = research_staff._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = research_staff._data[index]}, mt)
end

--
function research_staff.get(id)
    
    return research_staff.indexOf(__index_id[id])
        
end

--
function research_staff.set(id, key, value)
    local record = research_staff.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function research_staff.index()
    return __index_id
end

return research_staff