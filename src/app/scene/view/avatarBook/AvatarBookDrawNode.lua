--
-- Author: Liangxu
-- Date: 2018-1-10 10:50:21
-- 变身卡图鉴Node
local AvatarBookDrawNode = class("AvatarBookDrawNode")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local AvatarConst = require("app.const.AvatarConst")

local COLOR_KARMA = {
	{cc.c3b(0xff, 0xde, 0x6d), cc.c4b(0xd4, 0x4d, 0x08, 0xff)}, --未激活
	{cc.c3b(0xf3, 0xff, 0x2b), cc.c4b(0x64, 0xbd, 0x0d, 0xff)}, --已激活
}

function AvatarBookDrawNode:ctor(target, callback)
	self._target = target
	self._callback = callback
	self._bookId = 0
	self._avatarId1 = 0
	self._avatarId2 = 0
	self:_init()
end

function AvatarBookDrawNode:_init()
	for i = 1, 4 do
		self["_fileNodeAttr"..i] = ccui.Helper:seekNodeByName(self._target, "FileNodeAttr"..i)
		cc.bind(self["_fileNodeAttr"..i], "CommonAttrNode")
	end
	self._buttonActive = ccui.Helper:seekNodeByName(self._target, "ButtonActive")
	self._imageActivated = ccui.Helper:seekNodeByName(self._target, "ImageActivated")
	self._imageTitle = ccui.Helper:seekNodeByName(self._target, "ImageTitle")
	self._textTitle = ccui.Helper:seekNodeByName(self._target, "TextTitle")
	self._fileNodeIcon1 = ccui.Helper:seekNodeByName(self._target, "FileNodeIcon1")
	self._textName1 = ccui.Helper:seekNodeByName(self._target, "TextName1")
	self._fileNodeIcon2 = ccui.Helper:seekNodeByName(self._target, "FileNodeIcon2")
	self._textName2 = ccui.Helper:seekNodeByName(self._target, "TextName2")
	-- i18n change lable
	self:_createLabelByI18n()
	cc.bind(self._buttonActive, "CommonButtonLevel1Highlight")
	self._buttonActive:addClickEventListenerEx(handler(self, self._onButtonClicked))
	self._buttonActive:setString(Lang.get("avatar_btn_active"))

	cc.bind(self._fileNodeIcon1, "CommonAvatarIcon")
	cc.bind(self._fileNodeIcon2, "CommonAvatarIcon")
	self._fileNodeIcon1:setTouchEnabled(true)
	self._fileNodeIcon2:setTouchEnabled(true)
	self._fileNodeIcon1:setCallBack(handler(self, self._onClickIcon1))
	self._fileNodeIcon2:setCallBack(handler(self, self._onClickIcon2))
end

function AvatarBookDrawNode:updateUI(bookId)
	self._bookId = bookId
	self:_updateBaseInfo(bookId)
	for i = 1, 2 do
		self:_updateIcon(i)
	end
	self:_updateAttr(bookId)
end

function AvatarBookDrawNode:_updateBaseInfo(bookId)
	local showConfig = AvatarDataHelper.getAvatarShowConfig(bookId)
	local name = showConfig.name
	self._avatarId1 = showConfig.avatar_id1
	self._avatarId2 = showConfig.avatar_id2
	self._textTitle:setString(name)

	if Lang.checkHorizontal() then
		
	elseif not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		UIHelper.dealVTextWidget(self._textTitle,name)
	end

 	-- i18n ja change
	if Lang.checkUI("ui4") then
		local UTF8 = require("app.utils.UTF8")
		local len = UTF8.utf8len(name)
		local strContent = ""
		for i=1, len do  
			local strEle = UTF8.utf8sub(name, i, i)
			if i ~= len then
				strEle = strEle .. "\n"
			end
			strContent = strContent .. strEle
		end
		-- self._textTitle:ignoreContentAdaptWithSize(true)
		-- self._textTitle:setTextAreaSize(cc.size(self._textTitle:getFontSize(), 0)) 
		self._textTitle:setString(strContent)
	end
end

function AvatarBookDrawNode:_updateIcon(index)
	local avatarId = self["_avatarId"..index]
	local isHave = G_UserData:getAvatar():isHaveWithBaseId(avatarId)
	local avatarConfig = AvatarDataHelper.getAvatarConfig(avatarId)
	self["_fileNodeIcon"..index]:updateUI(avatarId)
	self["_fileNodeIcon"..index]:setIconMask(not isHave)
	local name = avatarConfig.list_name
	if Lang.checkLang(Lang.JA) then	 -- i18n ja change 
		name = string.gsub(name, "%[", "\n[")
	end
	self["_textName"..index]:setString(name)
	self["_textName"..index]:setColor(Colors.getColor(avatarConfig.color))
end

function AvatarBookDrawNode:_updateAttr(bookId)
	local isHave = AvatarDataHelper.isHaveAvatarShow(bookId)
	local isActive = G_UserData:getAvatarPhoto():isActiveWithId(bookId)
	self._buttonActive:setEnabled(isHave)
	self._buttonActive:setVisible(not isActive)
	self._imageActivated:setVisible(isActive)
	local reach = AvatarDataHelper.isCanActiveBookWithId(bookId)
	self._buttonActive:showRedPoint(reach)

	local color = isActive and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_TWO
	local attrInfo = AvatarDataHelper.getShowAttr(bookId)
	for i = 1, 4 do
		local info = attrInfo[i]
		if info then
			local attrId = info.attrId
			local attrValue = info.attrValue
			if not Lang.checkLang(Lang.CN) then
				self["_fileNodeAttr"..i]:updateView(attrId, attrValue, -5)
			else
				self["_fileNodeAttr"..i]:updateView(attrId, attrValue, -10)
			end
			self["_fileNodeAttr"..i]:setNameColor(color)
			self["_fileNodeAttr"..i]:setValueColor(color)
			self["_fileNodeAttr"..i]:setVisible(true)
		else
			self["_fileNodeAttr"..i]:setVisible(false)
		end
	end

	local resName = isActive and Path.getFetterRes("img_namebg_light") or Path.getFetterRes("img_namebg_nml")
	if Lang.checkHorizontal() then
		resName = isActive and Path.getFetterRes("img_namebg_light_h") or Path.getFetterRes("img_namebg_nml_h")
		-- self._imageTitle:ignoreContentAdaptWithSize(true)
		self._imageTitle:setScale9Enabled(false)
		self._imageTitle:setContentSize(cc.size(118,118))
		self._imageTitle:setPosition(-3,248)
		self._textTitle:setRotation(-45)
		self._textTitle:setPosition(41,74)
		self._textTitle:setFontSize(20)
		if Lang.checkLang(Lang.ZH) then
			self._textTitle:setFontSize(22)
		end
		self._textTitle:ignoreContentAdaptWithSize(true)
	end
	self._imageTitle:loadTexture(resName)
	local titleColor = isActive and COLOR_KARMA[2][1] or COLOR_KARMA[1][1]
	local titleOutline = isActive and COLOR_KARMA[2][2] or COLOR_KARMA[1][2]
	self._textTitle:setColor(titleColor)
	self._textTitle:enableOutline(titleOutline, 2)
end

function AvatarBookDrawNode:_onClickIcon1(sender, state)
	local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
		G_UserData:getAvatar():setCurAvatarId(self._avatarId1)
		G_SceneManager:popScene()
	end
end

function AvatarBookDrawNode:_onClickIcon2(sender, state)
	local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
		G_UserData:getAvatar():setCurAvatarId(self._avatarId2)
		G_SceneManager:popScene()
	end
end

function AvatarBookDrawNode:_onButtonClicked()
	if self._callback then
		self:_callback()
	end
end

-- i18n change lable
function AvatarBookDrawNode:_createLabelByI18n()
	if not Lang.checkLang(Lang.CN) then
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

	elseif not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		local size = self._textTitle:getContentSize()
		self._textTitle:setContentSize(cc.size(130,size.height))
		self._textTitle:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		self._textTitle:setFontSize(self._textTitle:getFontSize()-4)
	end

	if not Lang.checkLang(Lang.CN) then
	
		local size = self._textName1:getContentSize()
		self._textName1:setFontSize(18)
		self._textName2:setFontSize(18)

		if Lang.checkLang(Lang.ZH) then
		else
			self._textName1:getVirtualRenderer():setLineSpacing(-1) -- i18n ja change
			self._textName2:getVirtualRenderer():setLineSpacing(-1) 
		end

		--self._textName1:setContentSize(cc.size(size.width+20,size.height))
		--self._textName2:setContentSize(cc.size(size.width+20,size.height))
		for i = 1, 4 do
			self["_fileNodeAttr"..i]:setFontSize(18)
			if i % 2 ~= 0 then
				self["_fileNodeAttr"..i]:setPositionX(self["_fileNodeAttr"..i]:getPositionX()+3)
			else
				self["_fileNodeAttr"..i]:setPositionX(self["_fileNodeAttr"..i]:getPositionX()-3)
			end
		end
	end

	-- i18n ja change pos fontSize
	if Lang.checkUI("ui4") then   
		self._textTitle:setFontSize(self._textTitle:getFontSize() - 5)    -- 20好
		self._textTitle:getVirtualRenderer():setLineSpacing(-4)
		self["_fileNodeAttr4"]:setPosition(cc.p(64, 184))
		ccui.Helper:seekNodeByName(self._target, "Image_7"):setPositionX(167)
		self._textName1:setFontSize(self._textName1:getFontSize() - 2) 	   -- 16
		self._textName2:setFontSize(self._textName2:getFontSize() - 2)
	end 
end





return AvatarBookDrawNode