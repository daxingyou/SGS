-- Lang
-- 用于定义游戏中显示用的文本

local Lang = {}

local _templates = import(".LangTemplate")


--------------------------------------
Lang.langList = {
    CN = "cn",  --国服
    TW = "tw",  --繁体中文
    VN = "vn",  --越南文
    KR = "kr",  --韩文
    EN = "en",  --英文
    TH = "th",  --泰文
    ZH = "zh",  --简体中文
    ENID = "enid",  --印尼文
}
for key, value in pairs(Lang.langList) do
    Lang[key] = value
end
--------------------------------------
Lang.CHANNEL_SEA = "sea" --东南亚版本
Lang.CHANNEL_CN = "cn"  --国服
Lang.CHANNEL_TW = "tw"  --繁体中文
Lang.CHANNEL_VN = "vn"  --越南文
Lang.CHANNEL_KR = "kr"  --韩文
Lang.CHANNEL_JP = "jp"  --日本
---------------------------------------
Lang.STATUS_LOCAL   = 0   --包默认
Lang.STATUS_PHONE   = 1   --手机默认语言切换
Lang.STATUS_USER    = 2   --用户设置
Lang.STATUS_SERVER  = 3   --服务器同步
---------------------------------------

Lang.lang = Lang.ZH

Lang.channel = ""
Lang.mathLang = ""
Lang.status = Lang.STATUS_LOCAL

-- Lang.lang = CONFIG_LANG
-- Lang.lang = Lang.TW
-- Lang.lang = Lang.VN

Lang._is_i18n = false
Lang.useSwitchLang = false

--获取当前语言
function Lang.checkLang(lang)
    lang = lang or Lang.CN
    if not Lang._is_i18n then
        Lang._readStorage()
        Lang._writeStorage()
        Lang._is_i18n = true
    end
    return lang == Lang.lang
end    

--获取当前渠道
function Lang.checkChannel(channel)
    return channel == Lang.channel
end    

function Lang._readStorage()
    local i18nStorage = G_StorageManager:load("i18n") or {}
    dump(i18nStorage,"Lang read Storage")
    if i18nStorage and i18nStorage["lang"] then
        Lang["lang"] = i18nStorage["lang"]
        Lang["channel"] = i18nStorage["channel"] or Lang["lang"]
        Lang["status"] = i18nStorage["status"]
    end
end

function Lang._writeStorage(param)
    local i18n = G_StorageManager:load("i18n") or {}
    i18n["lang"] = Lang.lang
    i18n["channel"] = Lang.channel
    i18n["status"] = Lang.status
    if values ~= nil then
        for k,v in pairs(param) do
            i18n[k] = v
        end
    end
    dump("Lang._writeStorage i18n lang",i18n["lang"])
    dump("Lang._writeStorage i18n status",i18n["status"])
    dump("Lang._writeStorage i18n channel",i18n["channel"])
    G_StorageManager:save("i18n",i18n)
end

-- 获取文件的真实路径
function Lang.isFileExist(str)
    -- str = "app/i18n/".. _lang .."/config/shop.lua"
    local filePath = str               
    local aTrue = cc.FileUtils:getInstance():isFileExist( filePath )
    filePath = "bit32/" .. str .. "c"
    local bTrue = cc.FileUtils:getInstance():isFileExist( filePath )
    filePath = "bit64/" .. str .. "c"
    local cTrue = cc.FileUtils:getInstance():isFileExist( filePath )
    local isFileExist = aTrue or bTrue or cTrue
    dump({aTrue=aTrue,aPath=str,bTrue=bTrue,bPath="bit32/" .. str .. "c",cTrue=aTrue,cPath="bit64/" .. str .. "c",isFileExist=isFileExist},"Lang.isFileExist: ")
    return isFileExist
end

-- 获取文本
function Lang.get(key, values)
    local templates = Lang.getTemplates()
    local tmpl = templates[key]
    if not tmpl then
        return key  -- 直接返回key作为默认值，目的是直接显示此key来表示这个key找不到值
    end

    if values ~= nil then
        --replace vars in tmpl
        for k,v in pairs(values) do
            v = string.gsub(v, "%%", "____")  ---先把%换成其他的。
            tmpl = string.gsub(tmpl, "#" .. k .. "#", v)
            tmpl = string.gsub(tmpl, "____", "%%")
	    end
    end
    
    return tmpl
end

--直接传入文字，获得格式化文本
function Lang.getTxt(str,values)
    local tmpl = str;

    if values ~= nil then
        --replace vars in tmpl
        for k,v in pairs(values) do
            --in8 BUG
            v = string.gsub(v, "%%", "____")  ---先把%换成其他的。
            tmpl = string.gsub(tmpl, "#" .. k .. "#", v)
            tmpl = string.gsub(tmpl, "____", "%%")        
        end
    end

    return tmpl
end

function Lang.getTxtWithMark(str,values,mark)
    local tmpl = str;

    if values ~= nil then
        --replace vars in tmpl
        for k,v in pairs(values) do
            tmpl = string.gsub(tmpl, mark .. k .. mark, v)            
        end
    end

    return tmpl
end

return Lang

