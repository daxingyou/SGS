local PopupBase = require("app.ui.PopupBase")
local PopupInfo = class("PopupInfo", PopupBase)

function PopupInfo:ctor()
    local resource = {
		file = Path.getCSB("DrawCardScoreIntroLayer", "drawCard"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_panelBase = {
				events = {{event = "touch", method = "_onCloseClick"}}
			},
		}
	}
	PopupInfo.super.ctor(self, resource, true, true)
end

function PopupInfo:onCreate()
	-- i18n pos lable
	self:_dealPosByI18n()
	self:setPosition(0,0)
end

function PopupInfo:onEnter()
    self:setPosition(cc.p(0, 0))
end

function PopupInfo:onExit()
end

function PopupInfo:_onCloseClick()
    self:closeWithAction()
end

-- i18n pos lable
function PopupInfo:_dealPosByI18n()
	if Lang.checkLang(Lang.VN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local imageBG = UIHelper.seekNodeByName(self._panelDesign,"ImageBG")
		local size = imageBG:getContentSize()
		imageBG:setContentSize(
			cc.size(440,size.height)
		)
	end
end
return PopupInfo