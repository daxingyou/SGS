
local CommonVerticalText = class("CommonVerticalText")

local EXPORTED_METHODS = {
    "setString",
	"setTextPosition",
	"getImageWidth"
}

function CommonVerticalText:ctor()
	self._target = nil
end

function CommonVerticalText:_init()
	self._image = ccui.Helper:seekNodeByName(self._target, "Image")
	self._text = ccui.Helper:seekNodeByName(self._target, "Text")

	if Lang.checkHorizontal() then
		self._image:setScale9Enabled(true)
		self._image:setCapInsets(cc.rect(80,10,6,1))
		self._image:loadTexture(Path.getCommonImage("img_wujiangtexingdi01_h"))
		self._text:setAnchorPoint(0.5,0.5)
		self._text:setPositionY(0)
		self._text:ignoreContentAdaptWithSize(true)
	elseif Lang.checkSquareLanguage() then
		
    elseif not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		local size = self._text:getContentSize()
		self._text:setContentSize(cc.size(100,size.height))
		self._text:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	end
end

function CommonVerticalText:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonVerticalText:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonVerticalText:setString(txt)
    self._text:setString(txt)
    self._target:setVisible(txt ~= "")

	if Lang.checkHorizontal() then
		self._image:setContentSize(cc.size(self._text:getContentSize().width+60,30))
	elseif not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		UIHelper.dealVTextWidget(self._text, txt)
	end

end

function CommonVerticalText:setTextPosition(pos)
    self._text:setPosition(pos)
end

--i18n
function CommonVerticalText:getImageWidth()
    return self._image:getContentSize().width
end

return CommonVerticalText