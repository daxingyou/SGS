local CommonGuildTalk = class("CommonGuildTalk")


local EXPORTED_METHODS = {
    "setText",
}

function CommonGuildTalk:ctor()
	self._target = nil
	self._imageTalkBG = nil
	self._textTalk = nil
    self._maxWidth = 0
end

function CommonGuildTalk:_init()
	self._imageTalkBG = ccui.Helper:seekNodeByName(self._target, "Image_talk_bg")
	self._textTalk = ccui.Helper:seekNodeByName(self._target, "Text_talk")
    self:_dealPosI18n()
end

function CommonGuildTalk:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonGuildTalk:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonGuildTalk:setText(text)
    local render = self._textTalk:getVirtualRenderer()
    render:setMaxLineWidth(140)
    self._textTalk:setString(text)
end


function CommonGuildTalk:_dealPosI18n()
	if not Lang.checkLang(Lang.CN) then
        local size = self._imageTalkBG:getContentSize()
        self._imageTalkBG:setContentSize(cc.size(size.width,size.height+30))
        self._textTalk:setPositionY(self._textTalk:getPositionY()+15)
	end
	
end


return CommonGuildTalk