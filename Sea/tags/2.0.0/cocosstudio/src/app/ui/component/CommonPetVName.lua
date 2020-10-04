--
-- Author: hedili
-- Date: 2018-02-06 17:16:01
-- 神兽名字
local CommonPetVName = class("CommonPetVName")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")

local EXPORTED_METHODS = {
	"updateUI",
	"setFontSize",
	"getWidth"
}

function CommonPetVName:ctor()
	self._target = nil
	self._textName = nil
	self._imageColor = nil
end

function CommonPetVName:_init()
	self._imageColor = ccui.Helper:seekNodeByName(self._target, "Image_color")
	self._textName = ccui.Helper:seekNodeByName(self._target,"Text_Name")

	if Lang.checkLang(Lang.KR) or Lang.checkLang(Lang.TW) then

	elseif not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		local size = self._textName:getContentSize()
		self._textName:setContentSize(cc.size(100,size.height))
		self._textName:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	end
end

function CommonPetVName:bind(target)
	self._target = target
	self:_init()
	cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonPetVName:unbind(target)
	cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonPetVName:updateUI(petBaseId)
	local params = TypeConvertHelper.convert(TypeConvertHelper.TYPE_PET,petBaseId)

    local color = params.cfg.color
	self._textName:setString( params.name )
	if Lang.checkHorizontal() then
		self._imageColor:setScale9Enabled(true)
		self._imageColor:setCapInsets(cc.rect(40,10,10,1))
		self._textName:ignoreContentAdaptWithSize(true)
		local width = self._textName:getContentSize().width+60
		local height = 27
		self._imageColor:setContentSize(cc.size(width,height))
		self._imageColor:loadTexture(Path.getPet("img_shenshou_color"..color.."_h"))
		self._textName:setAnchorPoint(0.5,0.5)
		self._textName:setPosition(width/2,height/2)
	else
		self._imageColor:loadTexture(Path.getPet("img_shenshou_color"..color))
	end
	if not Lang.checkLang(Lang.CN) and not Lang.checkHorizontal() then
		local UIHelper  = require("yoka.utils.UIHelper")	
		UIHelper.dealVTextWidget(self._textName, params.name)
	end

	self._textName:setColor(Colors.getPetColor(color) )
end

function CommonPetVName:disableOutline()
	self._textName:disableEffect(cc.LabelEffect.OUTLINE)
end

function CommonPetVName:setFontSize(size)
	self._textName:setFontSize(size)
end



return CommonPetVName
