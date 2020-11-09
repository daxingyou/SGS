
local AudioPatchIcon = class("AudioPatchIcon")
local PopupAudioPatch = require("app.scene.view.audiopatch.PopupAudioPatch")

function AudioPatchIcon:ctor(target)
    self._target = target

    self._buttonIcon = ccui.Helper:seekNodeByName(self._target, "ButtonIcon")
    self._buttonIcon:addClickEventListener(handler(self, self._onClickIcon))

    self:updateUI(false)
end

function AudioPatchIcon:updateUI(bShow)
    self._target:setVisible(bShow)

end

function AudioPatchIcon:_onClickIcon()
    local AudioPatchHelper = require("app.scene.view.audiopatch.AudioPatchHelper")
    AudioPatchHelper.showPopupAudioPatch()
end

return AudioPatchIcon