-- 越南扩展功能
-- import(".VnEx")

-- 韩国扩展功能
-- import(".KrEx")

-- 适配黑边替换纹理
import(".BlackFrame")


local status, ret = pcall(function ()
    local lang_farst = string.sub(string.lower(Lang.lang),1,1)
    local lang_last = string.sub(string.lower(Lang.lang),2,-1)
    local ex_name = string.upper(lang_farst) .. lang_last .."Ex"
    -- print("exName = " .. ex_name)
    local ex_path = string.format("app.i18n.extends.lang.%s",ex_name)
    if Lang.isFileExist( "app/i18n/extends/lang/"..ex_name ..".lua" ) then
        -- print("exPath = " .. ex_path)
        require(ex_path)
    end
end)

if not status then print(ret) end

--处理模拟器channel
local platform = G_NativeAgent:getNativeType()
if platform == "windows" then
    local lang = Lang.lang
    if lang == Lang.ZH or lang == Lang.TH or lang == Lang.EN then
        Lang.channel = Lang.CHANNEL_SEA
        Lang.mathLang = "zh|en|th"
    else
        Lang.channel = Lang.lang
    end
    Lang._writeStorage()
end