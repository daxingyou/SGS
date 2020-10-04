local PosterGirlVoiceStateData = {}

local PosterGirlVoiceStateData = class("PosterGirlVoiceStateData")

local SETTING_NAME = "poster_girl"

function PosterGirlVoiceStateData:ctor()
    self._settingData = nil
end

function PosterGirlVoiceStateData:clear()
end

function PosterGirlVoiceStateData:loadLocalSetting()
    local settingData = G_StorageManager:loadUser(SETTING_NAME)
    if not settingData then
        settingData = {version = 0}
    end
    self._settingData = settingData
end

function PosterGirlVoiceStateData:loadRemoteSetting(remoteSettingData)
    if remoteSettingData and remoteSettingData.version >= self._settingData.version then
        self._settingData = remoteSettingData
    end
end

function PosterGirlVoiceStateData:_saveSetting()
	local message = self._settingData
	G_StorageManager:saveWithUser(SETTING_NAME, message)
end

function PosterGirlVoiceStateData:getState(key)
    return self._settingData[key]
end

function PosterGirlVoiceStateData:setState(key,state)
    self._settingData[key] = state
    if self._settingData.version ~= 0 then
        self._settingData.version = self._settingData.version + 1
        self:_saveSetting()
    end
end

function PosterGirlVoiceStateData:getSettingData()
    return self._settingData
end

return PosterGirlVoiceStateData