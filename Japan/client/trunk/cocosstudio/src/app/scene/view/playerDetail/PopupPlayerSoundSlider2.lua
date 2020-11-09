local PopupPlayerSoundSlider = class("PopupPlayerSoundSlider")

local typeList = {
    mus_volume = Lang.get("player_detail_music_volume"),
    sou_volume = Lang.get("player_detail_sound_volume"),
    vc_volume = Lang.get("player_detail_vc_volume"),
}

function PopupPlayerSoundSlider:ctor(target,soundType)
    self._target = target
    self._soundType = soundType

    self._slider = nil
    self._levelLow = nil
    self._levelHigh = nil
    self._callBack = nil

    self:_init()
end

function PopupPlayerSoundSlider:_init()
    self._slider = ccui.Helper:seekNodeByName(self._target, "Slider")
    self._slider:addEventListener(handler(self, self._onSlider))


    self._levelLow = ccui.Helper:seekNodeByName(self._target, "LevelLow")
    self._levelHigh = ccui.Helper:seekNodeByName(self._target, "LevelHigh")
    self._soundImg = ccui.Helper:seekNodeByName(self._target, "SoundImg")
    self._textName = ccui.Helper:seekNodeByName(self._target, "TextName")
    self._textName:setString(typeList[self._soundType])
end

function PopupPlayerSoundSlider:setCallBack(_callBack)
    if _callBack then 
        self._callBack = _callBack
    end
end

function PopupPlayerSoundSlider:updateUI( _value )
    self._soundImg:setVisible(_value == 0)
    self._levelLow:setVisible(_value ~= 0)
    self._slider:setPercent(_value)
end


function PopupPlayerSoundSlider:_onSlider(sender,event)
    local value = self._slider:getPercent()
    if event == ccui.SliderEventType.percentChanged then
        self:updateUI(value)
        if self._callBack then
            self._callBack(value,"on")
        end

    elseif event == ccui.SliderEventType.slideBallUp then
        if self._callBack then
            self._callBack(value,"up")
        end
    end
end


return PopupPlayerSoundSlider