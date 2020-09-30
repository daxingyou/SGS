local CGHelper = {}
local VideoConst = require("app.const.VideoConst")

function CGHelper.checkCG(isLoginUI)
    if not isLoginUI then
        if watchVideo then
            return false
        end
        local v = G_UserData:getUserSetting():getSettingValue("VideoVer")
        if v and v == VideoConst.videoVer then
            return false
        end
    end
    if not ccexp.VideoPlayer then
        return false
    end
    if not cc.FileUtils:getInstance():isFileExist("start.mp4") then
        return false
    end
    --[[
    --版本必须大于1.9.9（2.0以上）
    -- local currentAppVersion = G_NativeAgent:getAppVersion()
    -- local Version = require("yoka.utils.Version")
    -- local r = Version.compare("1.99.99", currentAppVersion)
    -- if r ~= Version.CURRENT then
    --     return false
    -- end

    return true
    ]]

    -- return true
    return false
end

return CGHelper
