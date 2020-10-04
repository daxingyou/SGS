local AudioManager = class("AudioManager")
local SystemSound = require("app.config.system_sound")
local AudioConst = require("app.const.AudioConst")
local AudioHelper = require("app.utils.AudioHelper")
local PrioritySignal = require("yoka.event.PrioritySignal")
--
function AudioManager:ctor()
	self._musicEnabled = true
	self._soundEnabled = true

	self._musicPath = ""
	self._musicId = cc.AUDIO_INVAILD_ID
	self._musicVolume = 1
	self._soundVolume = 1
	self._soundList = {}--音效列表

	ccui.Widget.setClickSoundCallback(function (soundID)
		self:playSoundWithId(soundID or AudioConst.SOUND_BUTTON)
	end)
end

--
function AudioManager:setSoundEnabled(enable)
	if enable ~= self._soundEnabled then
		self._soundEnabled = enable

		dump(self._soundList)
		self._soundList = {}
		--if not self._soundEnabled then
			--self:stopAllSound()
		--end
	end
end

--
function AudioManager:setMusicEnabled(enable)
	if enable ~= self._musicEnabled then
		self._musicEnabled = enable

		if not self._musicEnabled then
			self:stopMusic(true)
		else
			if self._musicPath ~= "" then
				self:playMusic(self._musicPath)
			else
				self:playMusicWithId(AudioConst.MUSIC_CITY)
			end
		end
	end
end

--
function AudioManager:playMusicWithId(id)
	local audioInfo = SystemSound.get(id)
	assert(audioInfo, "Could not find the autio info with id: "..tostring(id))
	local convertStr = self:getConvertPath(audioInfo.file_name)
	self:playMusic(convertStr)
end

--
function AudioManager:playMusic(path)
	if self._musicEnabled then
		--音乐id有效，并且路径一致，则代表播放同一个背景音乐，则返回
		if self._musicId ~= cc.AUDIO_INVAILD_ID and self._musicPath == path then
			return
		end
		
		self:stopMusic(true)
		local convertStr = self:getConvertPath(path)

		self._musicId = AudioHelper.playMusic(convertStr, true, self._musicVolume)
		self._musicPath = convertStr
	end
end

--
function AudioManager:stopMusic(release)
	if self._musicId ~= cc.AUDIO_INVAILD_ID then
		AudioHelper.stopMusic(self._musicId, release, self._musicPath)
		self._musicId = cc.AUDIO_INVAILD_ID
	end
end

--
function AudioManager:getMusicVolume()
    return self._musicVolume
end

--
function AudioManager:setMusicVolume(volume)
	self._musicVolume = volume
    if self._musicId ~= cc.AUDIO_INVAILD_ID then
    	AudioHelper.setMusicVolume(self._musicId, volume)
	end
end

--
function AudioManager:getSoundVolume()
    return self._soundVolume
end

--
function AudioManager:setSoundVolume(volume,needSetPlayingSound)
	self._soundVolume = volume
	if needSetPlayingSound then--需要设置正在播放的音效
		local time = G_ServerTime:getTime()
		for k,v in pairs(self._soundList) do
			if v.isRun and (time-v.startPlayTime) < 20 then
				AudioHelper.setSoundVolume(k, volume)
			else
				self._soundList[k] = nil
			end
		end

	end
end

--
function AudioManager:playSoundWithId(id, p)
	local pitch = p or 1
	local audioInfo = SystemSound.get(id)
	assert(audioInfo, "Could not find the autio info with id: "..tostring(id))
	local convertStr = self:getConvertPath(audioInfo.file_name)
	local soundId = self:playSound(convertStr, pitch)
	return soundId
end

--
function AudioManager:playSound(path, pitch)
	--
	if self._soundEnabled then
		local convertStr = self:getConvertPath(path)
    	local soundId = AudioHelper.playSound(convertStr, false, self._soundVolume, pitch or 1)

		self._soundList[soundId] = {isRun = true,startPlayTime = G_ServerTime:getTime()}

		self:_clearExpiredSoundData()

		return soundId
    end

    return nil
end


function AudioManager:_clearExpiredSoundData()
	local time = G_ServerTime:getTime()
	for k,v in pairs(self._soundList) do
		if v.isRun and (time-v.startPlayTime) >= 20 then
			self._soundList[k] = nil
		end
	end
end

--
function AudioManager:stopSound(handler)
	AudioHelper.stopSound(handler)
end

--
function AudioManager:stopAll()
	AudioHelper.stopAll()
end

--
function AudioManager:clear()
	AudioHelper.clear()
end

function AudioManager:setCallback(soundID, callback)
	AudioHelper.setCallback(soundID, callback)
end

function AudioManager:isSoundEnable()
	return self._soundEnabled
end


function AudioManager:preLoadSoundWithId(id)
	local audioInfo = SystemSound.get(id)
	assert(audioInfo, "Could not find the autio info with id: "..tostring(id))
	local convertStr = self:getConvertPath(audioInfo.file_name)
	self:preLoadSound(convertStr)
end

function AudioManager:unLoadSoundWithId(id)
	local audioInfo = SystemSound.get(id)
	assert(audioInfo, "Could not find the autio info with id: "..tostring(id))
	local convertStr = self:getConvertPath(audioInfo.file_name)
	AudioHelper.uncacheSound(convertStr)	
end

function AudioManager:preLoadSound(path)
	local convertStr = self:getConvertPath(path)
	AudioHelper.cacheSound(convertStr)
end

function AudioManager:unLoadSound(path)
	local convertStr = self:getConvertPath(path)
	AudioHelper.uncacheSound(convertStr)
end


function AudioManager:decodeJsonFile(jsonFileName)
    
    local jsonString=cc.FileUtils:getInstance():getStringFromFile(jsonFileName)
    assert(jsonString, "Could not read the json file with path: "..tostring(jsonFileName))

    local jsonConfig = json.decode(jsonString)
    assert(jsonConfig, "Invalid json string: "..tostring(jsonString).." with name: "..tostring(jsonFileName))
    
    return jsonConfig
end


local JSON_CONVERT_FILE = "audio.json"
function AudioManager:getConvertPath(key)
	local fileUtils = cc.FileUtils:getInstance()
	if fileUtils:isFileExist(JSON_CONVERT_FILE) then
		local jsonConfig = self:decodeJsonFile(JSON_CONVERT_FILE)
		--local convertStr = cc.CSLoader:getLocalizationString(audioInfo.file_name)
		local realPath = jsonConfig[key]
		if realPath then
			return realPath
		end
	end

	-- i18n change audio
	if not Lang.checkLang(Lang.CN) then
		return Path.getAudioFullPath(key)
    else
		return key
    end
end
-- function AudioManager:getDuration(soundId)
-- 	return AudioHelper.getDuration(soundId)
-- end

return AudioManager
