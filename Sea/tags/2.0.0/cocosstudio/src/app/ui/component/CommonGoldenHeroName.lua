-- Author: panhao
-- Date:2018-11-23 17:11:36
-- Describle：

local CommonGoldenHeroName = class("CommonGoldenHeroName")

local EXPORTED_METHODS = {
	"setName",
    "setColor",
    "setCountryFlag",
}

function CommonGoldenHeroName:ctor()
	self._target = nil
end

function CommonGoldenHeroName:_init()
    self._heroCountry = ccui.Helper:seekNodeByName(self._target, "Image_3")
	self._heroName = ccui.Helper:seekNodeByName(self._target, "Text_1")
	--i18n
	self:_swapImageHorizontal()
end

function CommonGoldenHeroName:bind(target)
	self._target = target
	self:_init()
	cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonGoldenHeroName:unbind(target)
	cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonGoldenHeroName:setName(heroName)
	if Lang.checkHorizontal() then
		self._heroName:setString(heroName)
		self:_dealHorizontal()
	elseif not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		UIHelper.dealVTextWidget(self._heroName,heroName)
	else
		self._heroName:setString(heroName)
	end
end

function CommonGoldenHeroName:setColor(color)
	self._heroName:setColor(color)
end

function CommonGoldenHeroName:setCountryFlag(path)
    --local smallCamps = {4, 1, 3, 2}
    self._heroCountry:loadTexture(path)--Path.getTextSignet("img_com_camp0"..smallCamps[camp]))
end

-- i18n
function CommonGoldenHeroName:_swapImageHorizontal()
	if Lang.checkHorizontal() then
		local bg = ccui.Helper:seekNodeByName(self._target, "Image_1")
		bg:setScale9Enabled(true)
		bg:setCapInsets(cc.rect(10,10,1,1))
		bg:loadTexture(Path.getCommonImage("img_mingzidi_h"))
		bg:setPosition(0,0)
		bg:setAnchorPoint(0.5,0.5)
		self._heroName:setFontSize(18)
		self._heroName:setColor(cc.c3b(0xfe, 0xe1, 0x02))
		self._heroName:setAnchorPoint(0.5,0.5)
		self._heroName:setPosition(0,0)
		self._heroName:ignoreContentAdaptWithSize(true)
	end
end
-- i18n
function CommonGoldenHeroName:_dealHorizontal()
	if Lang.checkHorizontal() then
		local bg = ccui.Helper:seekNodeByName(self._target, "Image_1")
		local width = self._heroName:getContentSize().width + 40
		bg:setContentSize(cc.size(width,30))
		self._heroCountry:setPosition(-width/2-13,0)
	end
end

return CommonGoldenHeroName