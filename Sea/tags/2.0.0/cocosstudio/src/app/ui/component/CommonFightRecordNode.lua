
local CommonFightRecordNode = class("CommonFightRecordNode")
local TextHelper = require("app.utils.TextHelper")


local EXPORTED_METHODS = {
    "updateView",
    "updateToEmptyRecordView",
}

function CommonFightRecordNode:ctor()
	self._target = nil
end

function CommonFightRecordNode:_init()
	self._imageWin = ccui.Helper:seekNodeByName(self._target, "ImageWin")
	self._textName = ccui.Helper:seekNodeByName(self._target, "TextName")
    self._textNoChallenge = ccui.Helper:seekNodeByName(self._target, "TextNoChallenge")

    if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        self._imageWin:ignoreContentAdaptWithSize(true)
        self._imageWin:setScale(0.7)

        self._textName:setPositionX(self._textName:getPositionX()-6)
        self._textName:setPositionY(self._textName:getPositionY()-4)
        self._textName:setFontSize(self._textName:getFontSize()-4)
	end


end

function CommonFightRecordNode:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonFightRecordNode:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

--i18n 新增参数 alignLeft
function CommonFightRecordNode:updateView(isWin,name,nameColor,alignLeft)
    self._imageWin:setVisible(true)
    self._textName:setVisible(true)
    self._textNoChallenge:setVisible(false)

    self._imageWin:loadTexture(isWin and Path.getTextSignet("txt_battle01_win") or 
        Path.getTextSignet("txt_battle01_lose"))
    self._textName:setString(name)
    self._textName:setColor(nameColor)

    if not Lang.checkLang(Lang.CN) and not alignLeft then
        local UIHelper  = require("yoka.utils.UIHelper")
        UIHelper.alignCenter(self._target,{self._imageWin,self._textName})
    end
end

function CommonFightRecordNode:updateToEmptyRecordView()
    self._imageWin:setVisible(false)
    self._textName:setVisible(false)
    self._textNoChallenge:setVisible(true)
    if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        UIHelper.alignCenter(self._target,{self._textNoChallenge})
    end
end

return CommonFightRecordNode