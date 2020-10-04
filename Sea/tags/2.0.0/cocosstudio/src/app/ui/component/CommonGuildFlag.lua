
local UTF8 = require("app.utils.UTF8")
local CommonGuildFlag = class("CommonGuildFlag")

local EXPORTED_METHODS = {
    "updateUI",
}

function CommonGuildFlag:ctor()
	self._target = nil
    self._textGuildNames = {}
end

function CommonGuildFlag:_init()
	self._imageFlag = ccui.Helper:seekNodeByName(self._target, "ImageFlag")
    self._textGuildName = ccui.Helper:seekNodeByName(self._target, "TextGuildName")
    self._imageFlag:ignoreContentAdaptWithSize(true)
    if not self._textGuildName then
        for i = 1,2,1 do
            self._textGuildNames[i] =  ccui.Helper:seekNodeByName(self._target, "TextGuildName"..i)
        end
    end
    --i18n
    self:_dealByI18n()
end

function CommonGuildFlag:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonGuildFlag:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonGuildFlag:updateUI(index,name)
    if self._textGuildName then
        --i18n
        if Lang.checkChannel(Lang.CHANNEL_SEA) then
            self._textGuildName:setString(name)
        elseif not Lang.checkLang(Lang.CN) and not Lang.checkLang(Lang.TW) then
            self._textGuildName:setString(UTF8.utf8sub(name, 1, 6))  
        else
            self._textGuildName:setString(UTF8.utf8sub(name, 1, 2))     
        end
        self._textGuildName:setColor(Colors.getGuildFlagColor(index))
        self._textGuildName:enableOutline(Colors.getGuildFlagColorOutline(index))
    else
        --i18n
        if Lang.checkChannel(Lang.CHANNEL_SEA) then
            self._textGuildNames[1]:setString(name)
        elseif Lang.checkLang(Lang.CN) or Lang.checkLang(Lang.TW) then
            for i = 1,2,1 do
                self._textGuildNames[i]:setString(UTF8.utf8sub(name, i, i))
                self._textGuildNames[i]:setColor(Colors.getGuildFlagColor(index))
                self._textGuildNames[i]:enableOutline(Colors.getGuildFlagColorOutline(index))
            end
        else
            for i = 1,2,1 do
                self._textGuildNames[i]:setVisible(false)   
                self._textGuildNames[i]:setFontSize(20) 
            end
            self._textGuildNames[1]:setVisible(true)  
            self._textGuildNames[1]:setPositionY(3)
            self._textGuildNames[1]:setString(UTF8.utf8sub(name, 1, 6))  
        end

    end

  
   self._imageFlag:loadTexture(self:getImagePath(index))
end

function CommonGuildFlag:getImagePath(index)
    return Path.getGuildFlagImage(index)
end

--i18n
function CommonGuildFlag:_dealByI18n()
    if Lang.checkChannel(Lang.CHANNEL_SEA) then
        if self._textGuildName then
            self._textGuildName:setTextAreaSize(cc.size(100,41))
            self._textGuildName:getVirtualRenderer():setLineSpacing(10)
		    self._textGuildName:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
        else
            self._textGuildNames[1]:setTextAreaSize(cc.size(60,24))
            self._textGuildNames[1]:getVirtualRenderer():setLineSpacing(10)
            self._textGuildNames[1]:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
            self._textGuildNames[1]:setFontSize(20)
            self._textGuildNames[1]:setPositionY(3)
            self._textGuildNames[2]:setVisible(false)
        end
    end
end

return CommonGuildFlag