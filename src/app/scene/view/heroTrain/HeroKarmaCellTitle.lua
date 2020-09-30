--
-- Author: Liangxu
-- Date: 2017-03-23 17:14:30
-- 武将缘分Cell中的标头
local HeroKarmaCellTitle = class("HeroKarmaCellTitle")

function HeroKarmaCellTitle:ctor(target, callback)
	self._target = target
	self._callback = callback

	self._textDes = nil
	self._buttonActive = nil

	self:_init()
end

function HeroKarmaCellTitle:_init()
	self._textDes = ccui.Helper:seekNodeByName(self._target, "TextDes")
	self._buttonActive = ccui.Helper:seekNodeByName(self._target, "ButtonActive")
	cc.bind(self._buttonActive, "CommonButtonLevel2Highlight")
	self._buttonActive:setString(Lang.get("hero_karma_btn_active"))
	self._buttonActive:addClickEventListenerEx(handler(self, self._onClickButton))
	self._imageActivated = ccui.Helper:seekNodeByName(self._target, "ImageActivated")

	-- i18n change lable
	self:_createLabelByI18n()
	if not Lang.checkLang(Lang.CN) then
		self:_dealPosI18n()
	end
end

function HeroKarmaCellTitle:setDes(des, isActivated, isCanActivate, attrId)
	self._textDes:setString(des)

	if isActivated then
		self._imageActivated:setVisible(true)
		self._buttonActive:setVisible(false)
	else
		self._imageActivated:setVisible(false)
		self._buttonActive:setVisible(true)
		self._buttonActive:setEnabled(isCanActivate)
	end
end

function HeroKarmaCellTitle:_onClickButton()
	if self._callback then
		self._callback()
	end
end


-- i18n ja change lable
function HeroKarmaCellTitle:_createLabelByI18n()
	if not Lang.checkLang(Lang.CN) and not Lang.checkLang(Lang.JA) then  
		local UIHelper  = require("yoka.utils.UIHelper")
		local size = self._imageActivated:getContentSize()
		local label = UIHelper.createLabel({
			style = "fetter_1",
			text = Lang.getImgText("img_fatter_yijihuo") ,
			position = cc.p(size.width * 0.5,20),
		})
		
		self._imageActivated:addChild(label)
	end

	if Lang.checkLang(Lang.JA) then  
		self._imageActivated:setPositionY(34)
		self._imageActivated:loadTexture(Path.getFetterRes("img_fatter_yijihuo"))
	end
end


-- i18n pos lable
function HeroKarmaCellTitle:_dealPosI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._buttonActive:setPositionY(self._buttonActive:getPositionY())	
	end
end

return HeroKarmaCellTitle