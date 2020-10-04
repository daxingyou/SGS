
local LangEx = Lang

--获取编辑器对应翻译文本 res
function LangEx.getEditorLanguageFile()
    return "i18n/" .. LangEx.lang .. "/json/editor_key.json"
end

--获取配置对应翻译文本  src
function LangEx.getConfigLanguageFullPath(config_file)
    return "app.i18n.".. LangEx.lang ..".config." .. config_file
end
-- 获取文件的真实路径
function LangEx.isFileExist(str)
    -- str = "app/i18n/".. _lang .."/config/shop.lua"
    local aTrue = cc.FileUtils:getInstance():isFileExist(str)
    local bTrue = cc.FileUtils:getInstance():isFileExist("bit32/" .. str .. "c" )
    local cTrue = cc.FileUtils:getInstance():isFileExist("bit64/" .. str .. "c" )
    return aTrue or bTrue or cTrue
end

--多语言读取系统字体
function LangEx.getColor(id)
    return Colors.getColor(id)
end

--多语言读取系统字体
function LangEx.getFont(id)
    return Path.getFont(id)
end

--多语言读取图片字体
function LangEx.getImgFont(id)
    return Path.getImgFont(id)
end

function LangEx.getTemplates()
    local templates = require("app.lang.LangTemplate")
    if not LangEx.checkLang(LangEx.CN) then
        templates = require("app.i18n.".. LangEx.lang .. ".LangTemplate")
    end
    return templates
end



-- -- 获取文本  --- 测试中使用国服数据
-- function LangEx.get(key, values)
--     local templates = LangEx.getTemplates()
--     local tmpl = templates[key]
--     if not tmpl then
--         dump(key,"key：")
--         local cn_templates = require("app.lang.LangTemplate")
--         dump(type(cn_templates[key]),"cn_templates[]")
--         dump(cn_templates[key],"cn_templates[]")
--         if cn_templates[key] and string.sub(cn_templates[key],1,1) ~= "[" then
--             -- tmpl = "i18n-" .. cn_templates[key]
--             tmpl = cn_templates[key]
--             dump(tmpl," i18n tmpl:")
--         else
--             dump(tmpl," tmpl:")
--             tmpl = cn_templates[key]
--         end
--     end

--     if not tmpl then
--         return key  -- 直接返回key作为默认值，目的是直接显示此key来表示这个key找不到值
--     end

--     if values ~= nil then
--         --replace vars in tmpl
--         for k,v in pairs(values) do
--             v = string.gsub(v, "%%", "____")  ---先把%换成其他的。
--             tmpl = string.gsub(tmpl, "#" .. k .. "#", v)
--             tmpl = string.gsub(tmpl, "____", "%%")
-- 	    end
--     end
    
--     -- 国家化数据找不到时  直接使用国服
--     if values ~= nil and tmpl == nil then
--         dump(key,"key：")
--         dump(tmpl,"tmpl：")
--         dump(values,"values：")
--         dump(require("app.lang.LangTemplate")[key],"cn_templates[key]")
--         local cn_templates = require("app.lang.LangTemplate")
--         tmpl = cn_templates[key]
--         --replace vars in tmpl
--         for k,v in pairs(values) do
--             v = string.gsub(v, "%%", "____")  ---先把%换成其他的。
--             tmpl = string.gsub(tmpl, "#" .. k .. "#", v)
--             tmpl = string.gsub(tmpl, "____", "%%")
--         end
--     end
    
--     return tmpl
-- end

function LangEx.decodeJsonFile(jsonFileName)
    
    local jsonString=cc.FileUtils:getInstance():getStringFromFile(jsonFileName)
    -- print("jsonString:"..jsonString)
    assert(jsonString, "Could not read the json file with path: "..tostring(jsonFileName))
    local jsonConfig = json.decode(jsonString)
    -- assert(jsonConfig, "Invalid json string: "..tostring(jsonString).." with name: "..tostring(jsonFileName))
    return jsonConfig
end


-- 获取服务器文本
function LangEx.getServerText(key,values)
    local tmpl = nil
    if Lang.ServerKeyData[key] then
        tmpl = Lang.ServerKeyData[key]
        -- print("tmpl:" .. tmpl)
    end
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


-- 获取图片字
function LangEx.getImgText(key,values)
    local filePath = Path.getLangImgTextJson("text_key")
    -- print("LangEx.getImgText filePath:"..filePath)
    local jsonData = LangEx.decodeJsonFile(filePath)
    if not jsonData then return key  end
    local tmpl = jsonData[key]

    if not jsonData or not tmpl then
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

-- 获取特效字
function LangEx.getEffectText(key,values)
    local filePath = Path.getLangImgTextJson("effect_key")
    -- print("LangEx.getEffectText filePath:"..filePath)
    local jsonData = LangEx.decodeJsonFile(filePath)
    -- dump(jsonData,"jsonData")
    local tmpl = jsonData[key]
    -- dump(tmpl,"tmpl")

    if not jsonData or not tmpl then
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

--检查是否是方块字语言
function LangEx.checkSquareLanguage()
    if not Lang._is_i18n then
        Lang._readStorage()
        Lang._writeStorage()
        Lang._is_i18n = true
    end
    return Lang.TW == Lang.lang or Lang.KR == Lang.lang or Lang.ZH == Lang.lang
end 

--检查是否是字母语言
function LangEx.checkLatinLanguage()
    if not Lang._is_i18n then
        Lang._readStorage()
        Lang._writeStorage()
        Lang._is_i18n = true
    end
    return  Lang.VN == Lang.lang or Lang.EN == Lang.lang or Lang.TH == Lang.lang or Lang.ENID == Lang.lang
end 


------------------------------------------------------------------------------------

-- --获取当前渠道
-- function LangEx.checkChannel(channel)
--     return channel == Lang.channel
-- end    

-- function LangEx._readStorage()
--     local i18nStorage = G_StorageManager:load("i18n") or {}
--     dump(i18nStorage,"Lang read Storage")
--     if i18nStorage and i18nStorage["lang"] then
--         Lang["lang"] = i18nStorage["lang"]
--         Lang["channel"] = i18nStorage["channel"]
--     end
-- end

-- function LangEx._writeStorage(param)
--     local i18n = G_StorageManager:load("i18n") or {}
--     i18n["lang"] = Lang.lang
--     i18n["channel"] = Lang.channel
--     if values ~= nil then
--         for k,v in pairs(param) do
--             i18n[k] = v
--         end
--     end
--     G_StorageManager:save("i18n",i18n)
-- end

--获取当前渠道
function LangEx.isSwitchLang(lang)
    lang = lang or Lang.lang
    release_print("LangEx.isSwitchLang lang: ".. lang)
    return lang ~= Lang.channel
end    

LangEx.OS_LANGUAGE_ANDROID_ENID   = "in_ID"
LangEx.OS_LANGUAGE_IOS_ENID       = "id"

function LangEx.getLocalChannelFullLanguage(os_language)
    local local_lang = nil
    local platform = G_NativeAgent:getNativeType()
    if platform == "android" then
        if os_language == Lang.OS_LANGUAGE_ANDROID_ENID then
            local_lang = Lang.ENID
        end
    elseif platform == "ios" then
        if os_language == Lang.OS_LANGUAGE_IOS_ENID then
            local_lang = Lang.ENID
        end
    end
    return local_lang
end


--根据系统语言获取当前渠道语言
function LangEx.getChannelLanguageByOS(channel,os_language)
    local channel_lang = Lang.lang
    if channel == Lang.CHANNEL_SEA then
        -- th-TH or th-CN
        if LangEx.getLocalChannelFullLanguage(os_language) then
            channel_lang = LangEx.getLocalChannelFullLanguage(os_language)
        else
            local infos = string.split(string.lower(os_language), "-")
            local lang = infos[1]
            if lang == Lang.TH then
                channel_lang = Lang.TH
            elseif lang == Lang.ZH then
                channel_lang = Lang.ZH
            elseif lang == Lang.EN then
                channel_lang = Lang.EN
            elseif lang == string.lower(LangEx.OS_LANGUAGE_IOS_ENID) or lang == string.split(string.lower(LangEx.OS_LANGUAGE_ANDROID_ENID), "_")[1] then
                channel_lang = Lang.ENID
            else
                channel_lang = Lang.EN
            end
        end
    end
    return channel_lang
end

LangEx.server_language = "unknown"

--获取当前渠道
function LangEx.switchLang(channel)
    assert(channel, "LangEx.switchLang channel is nil : ")
    --仅限首次进入游戏
    if Lang.status ~= Lang.STATUS_LOCAL then
        return
    end

    local os_lang = G_NativeAgent:getPhoneLanguageCode()
    release_print("LangEx.switchLang channel: ".. channel)
    release_print("LangEx.switchLang os_lang: ".. string.lower(os_lang))
    --渠道和语言一致的不切换
    if not LangEx.isSwitchLang() then return end

    if os_lang == "unknown" then -- Windows以配置为主
        
    else -- mac or android
        local channel_lang = Lang.getChannelLanguageByOS(channel,os_lang)
        local isChange = channel_lang ~= Lang.lang
        release_print("LangEx.switchLang channel_lang: ".. channel_lang)
        release_print("LangEx.switchLang Lang.lang: ".. Lang.lang)
        dump("Lang._is_i18n",Lang._is_i18n)
        Lang.lang = channel_lang
        Lang.status = Lang.STATUS_PHONE
        release_print("LangEx.switchLang Lang.lang: ".. Lang.lang)
        -- if not Lang._is_i18n then
        --     Lang._writeStorage()
        --     Lang._is_i18n = true
        -- end
        Lang._writeStorage()
        if isChange then
            G_GameAgent:reloadModule()
            return true
        end
    end


end    


--是否竖排转横排
function LangEx.checkHorizontal()
    if Lang.checkChannel(Lang.CHANNEL_SEA) then
        return true
    end
    return false
end



function LangEx.getLangTxtFromChannel(txt)
    local jsonUrl = json.decode(txt)
    if not jsonUrl or jsonUrl == txt then
        local temp = txt
        temp = string.gsub(temp, "\\\"", "\"")
        temp = string.gsub(temp, "\"{", "{")
        temp = string.gsub(temp, "}\"", "}")
        jsonUrl = json.decode(temp)
    end
    if jsonUrl and jsonUrl ~= txt and type(jsonUrl) == "table" then
        return jsonUrl[Lang.lang] or jsonUrl[table.keys(jsonUrl)[1]]
    end
    return txt
end

function LangEx.replaceFieldContent(content,filterFieldName)
    if content == nil or type(content) ~= "table" then
        return 
    end
    for k,v in pairs(content) do
        if type(v) == "table" then
            LangEx.replaceFieldContent(v,filterFieldName)
        end
        if type(v) == "string" and filterFieldName[k] then  
            logWarn(k .." xxxxxxx "..v)
            content[k] = Lang.getLangTxtFromChannel(v) 
        end
    end
end

--重写checkLang，ENID印尼语和EN英语相同处理，noEx==true执行原来逻辑
function LangEx.checkLang(lang,noEx)
    lang = lang or Lang.CN
    if not Lang._is_i18n then
        Lang._readStorage()
        Lang._writeStorage()
        Lang._is_i18n = true
    end
    if not noEx then
        if Lang.lang == Lang.ENID and lang == Lang.EN then
            return true
        end
    end
    return lang == Lang.lang
end
