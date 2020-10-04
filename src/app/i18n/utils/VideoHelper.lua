local VideoHelper = {}
--[[
createVedio 创建视频
参数:
path                    视频路径
keepAspectRatioEnabled  是否保持宽高比，默认true
fullScreenEnabled       是否全屏模式，默认false
anchorPoint             锚点，默认cc.p(0.5, 0.5)
size                    尺寸，默认cc.size(1136, 640)
playingCallback         正在播放回调
pausedCallback          暂停播放回调
stoppedCallback         停止播放回调
completedCallback       播放完成回调
返回:
videoPlayer 对象，play播放视频，stop停止播放
]]
function VideoHelper.createVedio(params)
    if not ccexp.VideoPlayer then
        logWarn(string.format("-------Current platform %s doesn't support ccexp.VideoPlayer-------",G_NativeAgent:getNativeType()))
        return nil
    end
    local keepAspectRatioEnabled = true
    if params.keepAspectRatioEnabled ~= nil then
        keepAspectRatioEnabled = params.keepAspectRatioEnabled
    end
    local fullScreenEnabled = false
    if params.fullScreenEnabled ~= nil then
        fullScreenEnabled = params.fullScreenEnabled
    end
    local anchorPoint = params.anchorPoint or cc.p(0.5, 0.5)
    local size = params.size or cc.size(1136, 640)

    local videoPlayer = ccexp.VideoPlayer:create()
    videoPlayer:setAnchorPoint(anchorPoint)
    videoPlayer:setContentSize(size)
    videoPlayer:setKeepAspectRatioEnabled(keepAspectRatioEnabled)
    videoPlayer:setFullScreenEnabled(fullScreenEnabled)
    if params.path then
        videoPlayer:setFileName(params.path)
    end
    videoPlayer:addEventListener(function(sender,eventType)
        if eventType == ccexp.VideoPlayerEvent.PLAYING then
            --正在播放
            if params.playingCallback then
                params.playingCallback()
            end
        elseif eventType == ccexp.VideoPlayerEvent.PAUSED then
            --暂停播放
            if params.pausedCallback then
                params.pausedCallback()
            end
        elseif eventType == ccexp.VideoPlayerEvent.STOPPED then
            --停止播放
            if params.stoppedCallback then
                params.stoppedCallback()
            end
        elseif eventType == ccexp.VideoPlayerEvent.COMPLETED then
            --播放完成
            if params.completedCallback then
                params.completedCallback()
            end
        end
    end)

    return videoPlayer
end

function VideoHelper.showLogoVideos(parentNode,paths,completedCallback)
    local index = 1
    local params = {}
    local video = VideoHelper.createVedio(params)
    if video then
        local function playVideo()
            if index > #paths then
                video:removeFromParent()
                completedCallback()
                return
            end
            local path = paths[index]
            index = index + 1
            if cc.FileUtils:getInstance():isFileExist(path) then
                video:setFileName(path)
                video:play()
            else
                playVideo()
            end
        end
        parentNode:addChild(video)
        video:setPosition(display.center)
        video:addEventListener(function(sender,eventType)
            if eventType == ccexp.VideoPlayerEvent.COMPLETED then
                playVideo()
            end
        end)
        playVideo()
    else
        completedCallback()
    end
end


return VideoHelper
