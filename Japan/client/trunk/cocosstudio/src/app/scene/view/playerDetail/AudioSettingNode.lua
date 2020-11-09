local ViewBase = require("app.ui.ViewBase")
local AudioSettingNode = class("AudioSettingNode", ViewBase)
local PopupPlayerSoundSlider = require("app.scene.view.playerDetail.PopupPlayerSoundSlider2")
local AudioPatchHelper = require("app.scene.view.audiopatch.AudioPatchHelper")

function AudioSettingNode:ctor()
	local resource = {
		file = Path.getCSB("AudioSettingNode", "playerDetail"),
		binding = {
			_btnPatch = {
				events = {{event = "touch", method = "_onClickPatch"}}
			},
		}
	}
	self:setName("AudioSettingNode")
	AudioSettingNode.super.ctor(self, resource)
end

function AudioSettingNode:onCreate()
	self._btnPatch:setString(Lang.get("player_detail_audio_patch"))
	local desc = self._btnPatch:getDesc()
	desc:getVirtualRenderer():setWidth(80)
	desc:setFontName(Path.getFontW8())
	desc:setFontSize(18)
	desc:setPositionX(20)

	if not AudioPatchHelper.checkVersion() then
		self._btnPatch:setVisible(false)
	end

	self:_initSound()
end

function AudioSettingNode:_initSound()
	local function updateSound(_control, _name)
		local soundControl = PopupPlayerSoundSlider.new(_control,_name)
		local volume = G_UserData:getUserSetting():getSettingValue(_name) or 1
		soundControl:updateUI(volume * 100)
		G_UserData:getUserSetting():updateMusic()

		soundControl:setCallBack(
			function(_value, _event)
				if _event == "on" then
					if _name == "mus_volume" then
						if _value > 0 then
							G_AudioManager:setMusicEnabled(true)
						end
						G_AudioManager:setMusicVolume(_value / 100)
					elseif _name == "sou_volume" then
						if _value > 0 then
							G_AudioManager:setSoundEnabled(true)
						end
						G_AudioManager:setSoundVolume(_value / 100)
					elseif _name == "vc_volume" then
						if _value > 0 then
							G_AudioManager:setVcEnabled(true)
						end
						G_AudioManager:setVcVolume(_value / 100)
					end
				elseif _event == "up" then
					local index = _value > 0 and 1 or 0
					if _name == "mus_volume" then
						G_UserData:getUserSetting():setSettingValue("musicEnabled", index)
					elseif _name == "sou_volume" then
						G_UserData:getUserSetting():setSettingValue("soundEnabled", index)
					elseif _name == "vc_volume" then
						G_UserData:getUserSetting():setSettingValue("vcEnabled", index)
					end
					G_UserData:getUserSetting():setSettingValue(_name, _value / 100)
					G_UserData:getUserSetting():updateMusic()
				end
			end
		)
	end

	updateSound(self._settingNode1, "mus_volume")
	updateSound(self._settingNode2, "sou_volume")
	updateSound(self._settingNode3, "vc_volume")
end

function AudioSettingNode:_onClickPatch()
	AudioPatchHelper.showPopupAudioPatch()
end

function AudioSettingNode:onEnter()
	self._signalShowAudioPatch =
		G_SignalManager:add(SignalConst.EVENT_SHOW_AUDIO_PATCH, handler(self, self._onEventShowAudioPatch))
end

function AudioSettingNode:onExit()
    self._signalShowAudioPatch:remove()
    self._signalShowAudioPatch = nil
end

function AudioSettingNode:_onEventShowAudioPatch(_, param)
	if param == false then
		self._btnPatch:setVisible(false)
	end
end

return AudioSettingNode
