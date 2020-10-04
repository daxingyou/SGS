--
-- Author: Liangxu
-- Date: 2017-03-01 11:32:41
-- 武将详情 缘分模块
local ListViewCellBase = require("app.ui.ListViewCellBase")
local HeroDetailKarmaModule = class("HeroDetailKarmaModule", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local UIHelper = require("yoka.utils.UIHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local CSHelper = require("yoka.utils.CSHelper")

function HeroDetailKarmaModule:ctor(heroUnitData, rangeType)
	self._heroUnitData = heroUnitData
	self._rangeType = rangeType
	local resource = {
		file = Path.getCSB("HeroDetailDynamicModule", "hero"),
		binding = {

		}
	}
	self:setName("HeroDetailKarmaModule")
	HeroDetailKarmaModule.super.ctor(self, resource)
end

function HeroDetailKarmaModule:onCreate()
	self:_updateView()
end

function HeroDetailKarmaModule:updateData(heroUnitData)
	self._heroUnitData = heroUnitData
	self:_updateView()
end

function HeroDetailKarmaModule:_updateView()
	self._listView:removeAllChildren()

	local title = self:_createTitle()
	self._listView:pushBackCustomItem(title)

	self._allKarmaData = UserDataHelper.getHeroKarmaData(self._heroUnitData:getConfig())
	
	for i, data in ipairs(self._allKarmaData) do
		local des = self:_createDes(data)
		self._listView:pushBackCustomItem(des)
	end

	local offset = 0
	--区分武将二级弹窗
	if self._heroUnitData:isUserHero() then
		local btnWidget = self:_createButton()
		self._listView:pushBackCustomItem(btnWidget)
	else
		offset = 10	
	end


	self._listView:doLayout()
	local contentSize = self._listView:getInnerContainerSize()
	contentSize.height = contentSize.height+offset
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)
end

function HeroDetailKarmaModule:_createTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg", "common"))
	title:setFontSize(24)
	title:setTitle(Lang.get("hero_detail_title_karma"))
	local widget = ccui.Widget:create()
	local titleSize = cc.size(402, 36)
	local widgetSize = cc.size(402, 36 + 10)
	widget:setContentSize(widgetSize)
	title:setPosition(titleSize.width / 2, titleSize.height / 2 + 10)
	widget:addChild(title)

	return widget
end

function HeroDetailKarmaModule:_createButton()
	local widget = ccui.Widget:create()
	widget:setContentSize(cc.size(402, 70))
	local btn = CSHelper.loadResourceNode(Path.getCSB("CommonButtonLevel2Highlight", "common"))
	btn:setString(Lang.get("hero_detail_btn_active"))
	btn:setPosition(320, 35)
	btn:addClickEventListenerEx(handler(self, self._onButtonActiveClicked))
	widget:addChild(btn)

	return widget
end

function HeroDetailKarmaModule:_createDes(data)
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
		return self:_createDesI18n(data)
	end
	local widget = ccui.Widget:create()

	local isActive = self._heroUnitData:isUserHero() and G_UserData:getKarma():isActivated(data.id)
	local desColor = isActive and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_TWO

	local name = Lang.get("hero_detail_karma_name", {name = data.karmaName})
	local tbDesInfo = {}
	for i, heroId in ipairs(data.heroIds) do
		local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroId)
		local heroName = heroParam.name
		local isHaveHero = self._heroUnitData:isUserHero() and G_UserData:getKarma():isHaveHero(heroId)
		local heroColor = isHaveHero and "c103" or "c102"
		local parma = {heroName, heroColor}
		table.insert(tbDesInfo, parma)
	end
	
	local labelName = cc.Label:createWithTTF(name, Path.getCommonFont(), 20)
	labelName:setAnchorPoint(cc.p(0, 1))
	labelName:setLineHeight(26)
	-- i18n pos lable
	if not Lang.checkLang(Lang.CN) then
		labelName:setWidth(120)
	else
		labelName:setWidth(140)
	end
	labelName:setColor(desColor)

	local params = {defaultColor = desColor, defaultSize = 20}
	local heroNames = ""
	for i, info in ipairs(tbDesInfo) do
		local name = info[1]
		if i ~= #tbDesInfo then
			-- i18n change punc
			if not Lang.checkLang(Lang.CN) then
				name = name..", "
			else
				name = name.."、"
			end
		end
		heroNames = heroNames.."$"..info[2].."_"..name.."$"
	end
	local formatStr = Lang.get("hero_detail_karma_des", {attr = data.attrName, value = data.attrValue, names = heroNames})
	local richTextDes = ccui.RichText:createRichTextByFormatString(formatStr, params)
	richTextDes:setAnchorPoint(cc.p(0, 1))
	richTextDes:ignoreContentAdaptWithSize(false)
	richTextDes:setContentSize(cc.size(250,0))
	richTextDes:formatText()

	local height = richTextDes:getContentSize().height
	
	if not Lang.checkLang(Lang.CN) then
		height = math.max(height,labelName:getContentSize().height)
		labelName:setPosition(cc.p(14, height + 10))
		richTextDes:setPosition(cc.p(144, height + 10))
	else	
		labelName:setPosition(cc.p(24, height + 10))
		richTextDes:setPosition(cc.p(134, height + 10))
	end

	widget:addChild(labelName)
	widget:addChild(richTextDes)
 	
	local size = cc.size(402, height + 10)
	widget:setContentSize(size)

	return widget
end

function HeroDetailKarmaModule:_onButtonActiveClicked()
	local popupHeroKarma = require("app.scene.view.heroTrain.PopupHeroKarma").new(self, self._heroUnitData, self._rangeType)
	popupHeroKarma:openWithAction()
end

--i18n
function HeroDetailKarmaModule:_createDesI18n(data)
	local widget = ccui.Widget:create()

	local isActive = self._heroUnitData:isUserHero() and G_UserData:getKarma():isActivated(data.id)
	local desColor = isActive and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_TWO

	local name = Lang.get("hero_detail_karma_name", {name = data.karmaName})
	local tbDesInfo = {}
	for i, heroId in ipairs(data.heroIds) do
		local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroId)
		local heroName = heroParam.name
		local isHaveHero = self._heroUnitData:isUserHero() and G_UserData:getKarma():isHaveHero(heroId)
		local heroColor = isHaveHero and "c103" or "c102"
		local parma = {heroName, heroColor}
		table.insert(tbDesInfo, parma)
	end


	local params = {defaultColor = desColor, defaultSize = 20}
	local heroNames = ""
	for i, info in ipairs(tbDesInfo) do
		local name = info[1]
		if i ~= #tbDesInfo then
			name = name..", "
		end
		heroNames = heroNames.."$"..info[2].."_"..name.."$"
	end
	local formatStr = Lang.get("hero_detail_karma_des", {attr = data.attrName, value = data.attrValue, names = heroNames})
	formatStr = name..formatStr
	local richTextDes = ccui.RichText:createRichTextByFormatString(formatStr, params)
	richTextDes:setAnchorPoint(cc.p(0, 1))
	richTextDes:ignoreContentAdaptWithSize(false)
	richTextDes:setContentSize(cc.size(375,0))
	if Lang.checkLang(Lang.TH) then
		richTextDes:setVerticalSpace(10)
	end
	richTextDes:formatText()

	local height = richTextDes:getContentSize().height
	richTextDes:setPosition(cc.p(14, height + 10))

	widget:addChild(richTextDes)
 	
	local size = cc.size(402, height + 10)
	widget:setContentSize(size)

	return widget
end

return HeroDetailKarmaModule