local AudioPatchHelper = {}

local Version = require("yoka.utils.Version")
local UserDataHelper = require("app.utils.UserDataHelper")

function AudioPatchHelper.checkShowDownload()
    local chapterId = UserDataHelper.getParameter(55000)
    local openChapterId = G_UserData:getChapter():getLastOpenChapterId()
    print("lkm-------chapterId=",chapterId)
    print("lkm-------openChapterId=",openChapterId)
    if openChapterId >= chapterId then
        if AudioPatchHelper.checkVersion() and AudioPatchHelper.checkFrequency() then
            local popup = AudioPatchHelper.getPopupAudioPatch()
            if popup == nil then
                AudioPatchHelper.showPopupAudioPatch()
                AudioPatchHelper._writePatchTime()
                return true
            end
        end
    end
    return false
end

-- 对比GM后台配置的版本号和本地版本号
function AudioPatchHelper.checkVersion()
    local latestVersion = Version.toNumber(G_ConfigManager:getAudioVersion())
    local  currentVersion = AudioPatchHelper.getVersion()
    print("lkm-------latestVersion=",latestVersion)
    print("lkm-------currentVersion=",currentVersion)
    if latestVersion > currentVersion then
        --检查到有新版本
        return true
    else
        return false
    end
end

function AudioPatchHelper.getVersion()
    local writeDir = cc.FileUtils:getInstance():getWritablePath()
    local sha = writeDir.."updatehd.sha"
    if cc.FileUtils:getInstance():isFileExist(sha) then
        return 0
    end
    local  currentVersion = checkint(cc.FileUtils:getInstance():getStringFromFile(writeDir.."packagehd/code"))
    return currentVersion
end

-- x天提示1次
function AudioPatchHelper.checkFrequency()
    local data = G_StorageManager:load("audiopatchtime") or {}
    local patchTime = checkint(data.patchTime or 0)
	local currTime = G_ServerTime:getTime()
	local patchZeroTime = G_ServerTime:secondsFromZero(patchTime)
	local currZeroTime = G_ServerTime:secondsFromZero(currTime)

    local day = math.floor( (currZeroTime - patchZeroTime) / (3600*24) )
    local voice_prompt_frequency = UserDataHelper.getParameter(55001)
    print("lkm day=",day)
    print("lkm voice_prompt_frequency=",voice_prompt_frequency)
    if day >= voice_prompt_frequency then
        return true
    end
    return false
end

function AudioPatchHelper._writePatchTime()
    local data = G_StorageManager:load("audiopatchtime") or {}
    data["patchTime"] = G_ServerTime:getTime()
    G_StorageManager:save("audiopatchtime", data)
end

function AudioPatchHelper.showPopupAudioPatch()
    local platform = G_NativeAgent:getNativeType()
    if platform == "windows" or platform == "mac" then
        return
    end

    local popup = AudioPatchHelper.getPopupAudioPatch()
    if popup then
        popup:maximize()
    else
        local PopupAudioPatch = require("app.scene.view.audiopatch.PopupAudioPatch")
        local popup = PopupAudioPatch.new()
        popup:openWithAction()
    end
end

function AudioPatchHelper.getPopupAudioPatch()
    local popup = G_TopLevelNode:getRootNode():getChildByName("PopupAudioPatch")
    return popup
end

function AudioPatchHelper.removePopupAudioPatch()
    local popup = AudioPatchHelper.getPopupAudioPatch()
    if popup then
        popup:close()
    end
end

function AudioPatchHelper.checkPopupAudioPatch()
    local popup = AudioPatchHelper.getPopupAudioPatch()
    if popup and popup:isVisible() then
        if popup:isDownloading() then
            popup:minimize()
        else
            popup:closeWithAction()
        end
        return true
    end
    return false
end

function AudioPatchHelper.getVersionString()
    local versionNum = AudioPatchHelper.getVersion()
    local versionStr = tostring(versionNum)
    local loopi = math.floor( (#versionStr-1) / 2 )
    local strVersion = ""
    local startValue = versionNum
    if loopi > 2 then
        loopi = 2
    end
    for i=loopi, 0, -1 do
        local tempValue = math.pow(100, i)
        local value = math.floor( startValue / tempValue )
        if i == loopi then
            strVersion = strVersion..value
        else
            strVersion = strVersion.."."..value
        end
        startValue = startValue - tempValue*value
    end
    if loopi == 0 then
        strVersion = "0.0."..strVersion
    elseif loopi == 1 then
        strVersion = "0."..strVersion
    end
    return strVersion
end

return AudioPatchHelper