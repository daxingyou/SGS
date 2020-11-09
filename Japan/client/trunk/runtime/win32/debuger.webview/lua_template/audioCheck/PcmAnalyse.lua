
-- PCM数据解析，传入文件路径，解析数据

local SchedulerHelper 	= require("app.utils.SchedulerHelper")

local fileUtils 	= cc.FileUtils:getInstance()

local writePath 	= fileUtils:getWritablePath()


local audioFiles    = cc.FileUtils:getInstance():listFiles("audio/ja/voice/")

local handler 		= nil
local interval 		= 0.2
local fileIndex     = 0
local fileList 		= {}
for i, file in ipairs(audioFiles) do
	local content 	= string.split(file,"/")
    local num 		= #content
    if content[num - 1] ~= "." and content[num - 1] ~= ".." then

		local fileName 	= content[num]
		fileName = string.split(fileName,".")[1]

        table.insert(fileList,fileName)
    end
end

local function preload()
	fileIndex 		= fileIndex + 1
	local fileName 	= fileList[fileIndex]
	if not fileName then
		logWarn("[ -------------- all mp3 preload finish --------------- ]")
		SchedulerHelper.cancelSchedule(handler)
		handler 	= nil
		return
	end

	logWarn("[ ------------- fileName = "..fileName.." fileIndex "..fileIndex.." ]")
	local mp3 			= Path.getSkillVoice(fileName)
    ccexp.AudioEngine:preloadAndAnalyse(mp3)
end

handler 	= SchedulerHelper.newSchedule(function()
	preload()
end, interval)

