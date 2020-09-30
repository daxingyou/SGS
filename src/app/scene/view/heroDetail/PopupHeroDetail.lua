-- Author: Liangxu
-- Update: Conley
-- Date: 2017-02-28 15:09:42
-- 武将详情
local PopupBase = require("app.ui.PopupBase")
local PopupHeroDetail = class("PopupHeroDetail", PopupBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")

function PopupHeroDetail:ctor(type, value, isPage, limitLevel, limitRedLevel)
	self._type = type
	self._value = value
	self._isPage = isPage
	self._limitLevel = limitLevel
	self._limitRedLevel = limitRedLevel

	local resource = {
		file = Path.getCSB("PopupHeroDetail", "hero"),
		binding = {
			_btnWayGet = {
				events = {{event = "touch", method = "_onBtnWayGetClicked"}}
			},
			_buttonClose = {
				events = {{event = "touch", method = "_onBtnClose"}}
			},
			_buttonVoice = {
				events = {{event = "touch", method = "_onButtonVoiceClicked"}}
			},
		}
	}

	-- i18n ja change
	if Lang.checkUI("ui4") then 
		resource.file = Path.getCSB("PopupHeroDetail2", "hero")
	end
	PopupHeroDetail.super.ctor(self, resource)
end

function PopupHeroDetail:onCreate()
	self._btnWayGet:setString(Lang.get("way_type_goto_get"))
	self._buttonSwitch:setCallback(handler(self, self._showDrawing))
	self._isShowDrawing = false
	self._avatarPageItems = nil
	self._storyPageItems = nil
	self._curSelectedPos = 0
end

function PopupHeroDetail:onEnter()
	self._buttonSwitch:setState(self._isShowDrawing)
	if not self._isPage then
		local dataList = {
			{cfg = {id = self._value}, limitLevel = self._limitLevel, limitRedLevel = self._limitRedLevel}
		}
		self:setPageData(dataList)
	end
end

function PopupHeroDetail:onExit()

end

function PopupHeroDetail:_updateHeroInfo(heroBaseId, limitLevel, limitRedLevel)
	self._heroBaseId = heroBaseId
	self._fileNodeCountry:updateUI(heroBaseId)
	self._fileNodeCountryFlag:updateUI(TypeConvertHelper.TYPE_HERO, heroBaseId, limitLevel, limitRedLevel)
 
 
	self._detailWindow:updateUI(nil, heroBaseId, nil, limitLevel, limitRedLevel)
	
	
	local haveHero = G_UserData:getHandBook():isHeroHave(heroBaseId, limitLevel, limitRedLevel)
	local color = haveHero and Colors.DARK_BG_THREE or Colors.BRIGHT_BG_RED
	self._hasText:setColor(color)
	self._hasText:setString(haveHero and Lang.get("common_have") or  Lang.get("common_not_have")) 

	local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)
	self._commonVerticalText:setString(heroParam.cfg.feature)
	--i18n
	self:_dealByI18n(heroParam)
	self:_updateHeroState(heroBaseId)
	self._btnWayGet:setEnabled(heroParam.cfg.type ~= 1) --主角没有获取途径

	self:_playCurHeroVoice()
end

--如果没有立绘，显示普通状态
function PopupHeroDetail:_updateHeroState(heroBaseId)
	local isHave = self:_isHaveStory(heroBaseId)
	self._buttonSwitch:setVisible(isHave)
	local show = self._isShowDrawing and isHave
	self:_updateDrawing(show)
end

function PopupHeroDetail:_onBtnWayGetClicked()
	local PopupItemGuider = require("app.ui.PopupItemGuider").new(Lang.get("way_type_get"))
	PopupItemGuider:updateUI(self._type,self._value)
	PopupItemGuider:openWithAction()
end

function PopupHeroDetail:_showDrawing(show)
	self._isShowDrawing = show

	self:_updateDrawing(show)
end

function PopupHeroDetail:_updateDrawing(show)
	self._heroStage:setVisible(not show)
	self._scrollPage:setVisible(not show)
	self._scrollPageStory:setVisible(show)
	if show then
		self._scrollPageStory:setCurPage(self._curSelectedPos)
	else
		self._scrollPage:setCurPage(self._curSelectedPos)
	end
end

function PopupHeroDetail:setDrawing(show)
	if not self:_isHaveStory(self._value) then
		return
	end
	self:_showDrawing(show)
	self._buttonSwitch:setState(self._isShowDrawing)
end

function PopupHeroDetail:_onBtnClose()
	self:close()
end

--使用了翻页功能
function PopupHeroDetail:setPageData(dataList)
	local selectPos = 0
	for i, data in ipairs(dataList) do
		if data.cfg.id == self._value and data.limitLevel == self._limitLevel then
			selectPos = i
		end
	end
	self:_setScrollPage(dataList, selectPos)
	self:_showDrawing(self._isShowDrawing)
end

function PopupHeroDetail:_setScrollPage(dataList, selectPos)
	self._dataList = dataList
	-- self._curSelectedPos = selectPos
	self._scrollPage:setCallBack(handler(self, self._updateHeroItem))
	self._scrollPage:setUserData(dataList, selectPos)
	self._scrollPageStory:setCallBack(handler(self, self._updateHeroItem))
	self._scrollPageStory:setUserData(dataList, selectPos)
	self._scrollPageStory:setTouchEnabled(false)
end

function PopupHeroDetail:_updateHeroItem(sender, widget, index, selectPos)
	local data = self._dataList[index]
	if data == nil then
		return
	end
	
	self._avatarPageItems = self._scrollPage:getPageItems()
	self._storyPageItems = self._scrollPageStory:getPageItems()

	local heroBaseId = data.cfg.id
	local limitLevel = data.limitLevel
	local limitRedLevel = data.limitRedLevel
	if self._avatarPageItems then
		local avatarItem = self._avatarPageItems[index]
		if avatarItem then
			local avatarCount = avatarItem:getChildrenCount()
			if avatarCount == 0 then
				local CSHelper = require("yoka.utils.CSHelper")
				local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
				avatar:updateUI(heroBaseId, nil, nil, limitLevel, nil, nil, limitRedLevel)
				avatar:setScale(1.4)
				avatar:setPosition(cc.p(self._scrollPage:getPageSize().width / 2, self._scrollPage:getPageSize().height / 2 - 150))
				avatarItem:addChild(avatar)
			end
		end
	end
	
	if self._storyPageItems then
		local storyItem = self._storyPageItems[index]
		if storyItem then
			local storyCount = storyItem:getChildrenCount()
			if storyCount == 0 then
				local CSHelper = require("yoka.utils.CSHelper")
				local story = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
				story:updateUI(heroBaseId, limitLevel, limitRedLevel)
				story:setScale(0.8)
				story:setPosition(cc.p(self._scrollPageStory:getPageSize().width / 2 + 150, 0)) -- i18n ja change
				storyItem:addChild(story)
			end
		end
	end
	

	if selectPos == index then
		if self._curSelectedPos ~= selectPos then
			self._value = heroBaseId
			self._curSelectedPos = selectPos
			self:_updateHeroInfo(heroBaseId, limitLevel, limitRedLevel)
		end
	end
end

--是否有立绘
function PopupHeroDetail:_isHaveStory(heroBaseId)
	local info = HeroDataHelper.getHeroConfig(heroBaseId)
	local resId = info.res_id
    local resData = HeroDataHelper.getHeroResConfig(resId)
    local isHaveSpine = resData.story_res_spine ~= 0
    local isHaveRes = resData.story_res ~= 0 and resData.story_res ~= 777 --777是阴影图
    return isHaveSpine or isHaveRes
end

function PopupHeroDetail:_onButtonVoiceClicked()
	self:_playCurHeroVoice(true)
end

function PopupHeroDetail:_playCurHeroVoice(must)
	local baseId = self._heroBaseId
	G_HeroVoiceManager:playVoiceWithHeroId(baseId, must)
end

--i18n
function PopupHeroDetail:_dealByI18n(heroParam)
	if Lang.checkHorizontal() then
		self._commonVerticalText:setPosition(65+self._commonVerticalText:getImageWidth()/2,483)
	end

	-- i18n ja change font size
	if Lang.checkUI("ui4") then
		self._fileNodeCountry:setPositionY(482)
		self._commonVerticalText:setPosition(55, 400)
		self._buttonVoice:loadTextureNormal(Path.getVoiceRes("btn_hero_voice"))
		self._buttonVoice:setContentSize(cc.size(53, 53))
		self._btnWayGet:setFontSize(26)
		self._hasText:setFontSize(20)
		self._hasText:enableOutline(Colors.CUSTOM_ACT_DES_OUTLINE,  1) 	

		-- bug:个别立绘尺寸有问题（如：孙权）
		local pageView = ccui.Helper:seekNodeByName(self._scrollPageStory, "Page_View") 
		pageView:setContentSize(cc.size(790, 600))
		pageView:setPositionX(-110)

		-- bug: 2个标题 
		local imageBg = ccui.Helper:seekNodeByName(self, "Image_bg_all") 
		self._textTitle:retain()  -- 必须retrain  or节点的referentCount=0
		self._textTitle:removeFromParent(false)
		imageBg:addChild(self._textTitle)  
		self._textTitle:setPosition(imageBg:getContentSize().width*0.5, 573) 
		self._textTitle:release()    -- 在release
		ccui.Helper:seekNodeByName(self, "Image_1"):setVisible(false) 

		-- 更换标签
		if heroParam then
			ccui.Helper:seekNodeByName(self._commonVerticalText, "Text"):setFontSize(18) 
			ccui.Helper:seekNodeByName(self._commonVerticalText, "Text"):setPositionY(63)
			ccui.Helper:seekNodeByName(self._commonVerticalText, "Text"):setFontName(Path.getCommonFont())
			ccui.Helper:seekNodeByName(self._commonVerticalText, "Image"):setAnchorPoint(cc.p(0.5, 1))
			ccui.Helper:seekNodeByName(self._commonVerticalText, "Image"):setPositionY(82)
			ccui.Helper:seekNodeByName(self._commonVerticalText, "Image"):loadTexture(Path.getUICommon("img_wujiangcv"))
			ccui.Helper:seekNodeByName(self._commonVerticalText, "Image"):setContentSize(cc.size(27, 224))


			local UTF8 = require("app.utils.UTF8")
			local heroData = require("app.config.hero").get(heroParam.cfg.id) 
			local resInfo = require("app.config.hero_res").get(heroData.res_id)
			local strContent = ""    
			local len = UTF8.utf8len(resInfo.cast_name)
			for i=1, len do  
				local strEle = UTF8.utf8sub(resInfo.cast_name, i, i)
				if i ~= len then
					strEle = strEle .. "\n"
				end
				strContent = strContent .. strEle
			end
			self._txtCV:setString("CV\n" .. strContent)

			if self._commonVerticalText:isVisible() == false then-- 蓝将 绿将
				self._nodeCV:setPosition(55, 380)
				self._txtCV:setPositionY(197-15)
			else   -- 红将...
				self._nodeCV:setPosition(84, 342)
				self._txtCV:setPositionY(210-18)
			end
		end
	end
end

return PopupHeroDetail


