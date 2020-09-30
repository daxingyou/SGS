local EffectHelperEx = require("app.effect.EffectHelper")

EffectHelperEx._decodeJsonFile = EffectHelperEx.decodeJsonFile

function EffectHelperEx.decodeJsonFile(jsonFileName)
    -- print("----------------------EffectHelperEx.decodeJsonFile---------------------------")
    local langPath = "i18n/" .. Lang.lang .. "/" .. jsonFileName
    local isExist,resultPath = Path.getLangBaseEx(langPath)
    if not Lang.checkLang(Lang.CN) and isExist then
        jsonFileName = resultPath
    end
    local jsonString=cc.FileUtils:getInstance():getStringFromFile(jsonFileName)
--    local jsonString = CCFileUtils:sharedFileUtils():getEncryptFileData(jsonFileName)
    assert(jsonString, "Could not read the json file with path: "..tostring(jsonFileName))

    local jsonConfig = json.decode(jsonString)
    assert(jsonConfig, "Invalid json string: "..tostring(jsonString).." with name: "..tostring(jsonFileName))
    
    return jsonConfig
end

EffectHelperEx._pngGetter = EffectHelperEx.pngGetter

function EffectHelperEx.pngGetter(resIniter,effectJsonName)
    -- print("----------------------EffectHelperEx.pngGetter---------------------------")
    local effectJson = EffectHelperEx.jsonGetter(resIniter,effectJsonName)
    assert(effectJson, "Could not find the effectJson with name: "..tostring(effectJsonName))

   
    local effectJsonPath = "effect/" .. effectJsonName .. "/" .. effectJsonName
    local effectPngPath = "effect/" .. effectJsonName .. "/"
    local langPath = "i18n/" .. Lang.lang 
    local basePath = "i18n/" .. Path.lang_base_path 
    local isExist,resultFullPath,langName = Path.getLangBaseEx(langPath .. "/" .. effectJsonPath .. ".png")
    if not Lang.checkLang(Lang.CN) and isExist then
        effectJsonPath = "i18n/" .. langName .. "/" .. effectJsonPath
        effectPngPath = "i18n/" .. langName .. "/" .. effectPngPath
    end
    if effectJson['png'] ~= nil then
        if effectJson['png'] ~= "" then
            -- print("-----EffectHelperEx._loadResource   plist: " .. effectJsonPath .. ".plist" )
            -- print("-----EffectHelperEx._loadResource   png: " .. effectPngPath .. effectJson['png'] )
            EffectHelperEx._loadResource(effectJsonPath .. ".plist",  effectPngPath .. effectJson['png'])     
        end
    else 
        EffectLoader._loadResource(effectJsonPath .. ".plist", effectJsonPath .. ".png") 
    end

end

-- function EffectHelper.pngGetter(resIniter,effectJsonName)
--     local effectJson = EffectHelper.jsonGetter(resIniter,effectJsonName)
--     assert(effectJson, "Could not find the effectJson with name: "..tostring(effectJsonName))

   
--     local effectJsonPath = "effect/" .. effectJsonName .. "/" .. effectJsonName
--     -- local langPath = "i18n/" .. Lang.lang .. "/" .. effectJsonPath
--     -- if not Lang.checkLang(Lang.CN) and Path.isExist(langPath .. ".png") then
--     --     effectJsonPath = langPath
--     -- end
--     if effectJson['png'] ~= nil then
--         if effectJson['png'] ~= "" then
--             EffectHelper._loadResource(effectJsonPath .. ".plist",  "effect/" ..effectJsonName.."/".. effectJson['png'])     
--         end
--     else 
--         EffectLoader._loadResource(effectJsonPath .. ".plist", effectJsonPath .. ".png") 
--     end

-- end