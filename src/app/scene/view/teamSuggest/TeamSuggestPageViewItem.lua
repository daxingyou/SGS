
-- Author: nieming
-- Date:2017-12-28 17:18:59
-- Describle：

local TeamSuggestPageViewItem = class("TeamSuggestPageViewItem", ccui.Widget)
local CSHelper = require("yoka.utils.CSHelper")
local Hero = require("app.config.hero")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function TeamSuggestPageViewItem:ctor()

	--csb bind var name
	self._heroAvater1 = nil  --CommonHeroAvatar
	self._heroAvater2 = nil  --CommonHeroAvatar
	self._heroAvater3 = nil  --CommonHeroAvatar
	self._heroAvater4 = nil  --CommonHeroAvatar
	self._heroAvater5 = nil  --CommonHeroAvatar
	self._heroAvater6 = nil  --CommonHeroAvatar
	self._heroName1 = nil  --Text
	self._heroName2 = nil  --Text
	self._heroName3 = nil  --Text
	self._heroName4 = nil  --Text
	self._heroName5 = nil  --Text
	self._heroName6 = nil  --Text
	self._heroPedespal1 = nil
	self._heroPedespal2 = nil
	self._heroPedespal3 = nil
	self._heroPedespal4 = nil
	self._heroPedespal5 = nil
	self._heroPedespal6 = nil
	local resource = {
		file = Path.getCSB("TeamSuggestPageViewItem", "teamSuggest"),

	}
	CSHelper.createResourceNode(self, resource)

	-- i18n
	self:_dealI18n()
end


function TeamSuggestPageViewItem:updateUI(data)
	if not data then
		return
	end
	for i=1, 6 do
		local heroID = data["hero"..i]
		if 1 == heroID then
			heroID = G_UserData:getHero():getRoleBaseId()
		end
		local heroConfig = Hero.get(heroID)
		assert(heroConfig ~= nil, string.format("can not get hero info id = %s", heroID or "nil"))
		self["_heroAvater"..i]:updateUI(heroID)
		self["_heroAvater"..i]:setTouchEnabled(true)

		if G_UserData:getHero():isInListWithBaseId(heroID) then
			self["_heroPedespal"..i]:loadTexture(Path.getEmbattle("img_embattleherbg_over"))
			self["_heroAvater"..i]:setColor(cc.c3b(255, 255, 255))
			-- self["_heroAvater"..i]:setOpacity(255)

		else
			self["_heroPedespal"..i]:loadTexture(Path.getEmbattle("img_embattleherbg_nml"))
			-- self["_heroAvater"..i]:setOpacity(170)
			self["_heroAvater"..i]:setColor(cc.c3b(150, 150, 150))

		end

		self["_heroAvater"..i]:setCallBack(function()
			local PopupHeroDetail = require("app.scene.view.heroDetail.PopupHeroDetail").new(TypeConvertHelper.TYPE_HERO ,heroID)
			PopupHeroDetail:openWithAction()
		end)
		if Lang.checkHorizontal() then
			local UIHelper  = require("yoka.utils.UIHelper")
			local image = UIHelper.seekNodeByName(self,"node"..i,"namebg")
			self["_heroName"..i]:setString(heroConfig.name)
			self["_heroName"..i]:ignoreContentAdaptWithSize(true)
			self["_heroName"..i]:setFontSize(20)
			image:setContentSize(cc.size(self["_heroName"..i]:getContentSize().width+80,28))
			local pos = cc.p(10,140)
			image:setPosition(pos)
			self["_heroName"..i]:setPosition(pos)
		elseif Lang.checkLang(Lang.JA) then
			local size = self["_heroName"..i]:getContentSize()
			local posY = self["_heroName"..i]:getPositionY()
			self["_heroName"..i]:setAnchorPoint(0.5,1)
			local fontsize = self["_heroName"..i]:getFontSize()
			self["_heroName"..i]:setFontSize(fontsize - 4)
			self["_heroName"..i]:setPositionY(posY+size.height/2)
			self["_heroName"..i]:setContentSize(cc.size(size.width,150))
			local UIHelper  = require("yoka.utils.UIHelper")
			UIHelper.dealVTextWidget(self["_heroName"..i],heroConfig.name)
		elseif not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			UIHelper.dealVTextWidget(self["_heroName"..i],heroConfig.name)
		else
			self["_heroName"..i]:setString(heroConfig.name)
		end
	
	end
end

-- i18n
function TeamSuggestPageViewItem:_dealI18n()
	if Lang.checkHorizontal() then
		local UIHelper  = require("yoka.utils.UIHelper")
		for i = 1, 6 do
			local image = UIHelper.seekNodeByName(self,"node"..i,"namebg")
			image:setScale9Enabled(true)
			image:setCapInsets(cc.rect(60,10,5,1))
			image:loadTexture(Path.getEmbattle("img_embattle02_h"))
		end
	end
end

return TeamSuggestPageViewItem
