--
-- Author: Liangxu
-- Date: 2017-02-28 15:09:42
-- 武将详情
local ViewBase = require("app.ui.ViewBase")
local HeroDetailView = class("HeroDetailView", ViewBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local HeroDetailBaseView = require("app.scene.view.heroDetail.HeroDetailBaseView")
local HeroConst = require("app.const.HeroConst")
local CSHelper = require("yoka.utils.CSHelper")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")

function HeroDetailView:ctor(heroId, rangeType)
	G_UserData:getHero():setCurHeroId(heroId)
	self._rangeType = rangeType
	self._allHeroIds = {}

	local resource = {
		file = Path.getCSB("HeroDetailView", "hero"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonLeft = {
				events = {{event = "touch", method = "_onButtonLeftClicked"}}
			},
			_buttonRight = {
				events = {{event = "touch", method = "_onButtonRightClicked"}}
			},
			_buttonVoice = {
				events = {{event = "touch", method = "_onButtonVoiceClicked"}}
			}
		}
	}

	-- i18n ja change CSB
	if Lang.checkUI("ui4") then
		resource.file = Path.getCSB("HeroDetailView2", "hero")
		resource.binding["_buttonSpine"] = { events = {{event = "touch", method = "_onButtonCheckSpineClicked"}}  } 
		resource.binding["_buttonVoice"] = nil
	end

	HeroDetailView.super.ctor(self, resource)
end

function HeroDetailView:onCreate()
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)
	self._topbarBase:setImageTitle("txt_sys_com_wujiang")

	self._pageView:setScrollDuration(0.3)
	self._pageView:addEventListener(handler(self, self._onPageViewEvent))
	self._pageView:addTouchEventListener(handler(self, self._onPageTouch))
	self._pageViewSize = self._pageView:getContentSize()
end

function HeroDetailView:onEnter()
	self:_updateHeroIds()
	self:_initPageView()
	self:_updateArrowBtn()
	self:_updateInfo()
	self:_setCurPos()

	--抛出新手事件
	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
end

function HeroDetailView:_updateHeroIds()
	if self._rangeType == HeroConst.HERO_RANGE_TYPE_1 then
		self._allHeroIds = G_UserData:getHero():getRangeDataBySort()
	elseif self._rangeType == HeroConst.HERO_RANGE_TYPE_2 then
		self._allHeroIds = G_UserData:getTeam():getHeroIdsInBattle()
	end

	self._selectedPos = 1

	local heroId = G_UserData:getHero():getCurHeroId()
	for i, id in ipairs(self._allHeroIds) do
		if id == heroId then
			self._selectedPos = i
		end
	end
	self._heroCount = #self._allHeroIds
end

function HeroDetailView:onExit()
end

function HeroDetailView:_setCurPos()
	if self._rangeType == HeroConst.HERO_RANGE_TYPE_2 then
		G_UserData:getTeam():setCurPos(self._selectedPos)
	end
end

--只创建widget，减少开始的加载量
function HeroDetailView:_createPageItem()
	local widget = ccui.Widget:create()
	widget:setContentSize(self._pageViewSize.width, self._pageViewSize.height)

	return widget
end

function HeroDetailView:_updatePageItem()
	local index = self._selectedPos
	for i = index - 1, index + 1 do
		local widget = self._pageItems[i]
		if widget then --如果当前位置左右没有加Avatar，加上
			local count = widget:getChildrenCount()
			if count == 0 then
				local heroId = self._allHeroIds[i]
				local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
				local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(unitData)
				local limitLevel = avatarLimitLevel or unitData:getLimit_level()
				local limitRedLevel = arLimitLevel or unitData:getLimit_rtg()

				-- i18n ja add spine
				if not Lang.checkUI("ui4") then
					local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
					avatar:updateUI(heroBaseId, nil, nil, limitLevel, nil, nil, limitRedLevel)
					avatar:setScale(1.4)
					avatar:setPosition(cc.p(self._pageViewSize.width*0.57, 190))
					widget:addChild(avatar)
				else 
					local story = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
					story:updateChatUI(heroBaseId, limitLevel, limitRedLevel)
					story:setScale(1)
					story:setPosition(cc.p(self._pageViewSize.width / 2 , 0)) -- 调位置  会被截掉  是因为缩放导致大小变化
					--ccui.Helper:seekNodeByName(story, "NodeAvatar"):setPositionY(ccui.Helper:seekNodeByName(story, "Panel_1"):getContentSize().height*0.2)
					widget:addChild(story)  
				end	
			end

			-- i18n ja change
			if Lang.checkUI("ui4") and index == self._selectedPos then  --  bug: 因为界限突破成功后 形象会发生变化  so刷新下
				local heroId = self._allHeroIds[i]
				local unitData = G_UserData:getHero():getUnitDataWithId(heroId)

				local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(unitData)
				local limitLevel = avatarLimitLevel or unitData:getLimit_level()
				local limitRedLevel = arLimitLevel or unitData:getLimit_rtg()
				widget:getChildren()[1]:updateChatUI(heroBaseId, limitLevel, limitRedLevel)
			end
		end
	end
end  

function HeroDetailView:_initPageView()
	self._pageItems = {}
	self._pageView:removeAllPages()
	for i = 1, self._heroCount do
		local item = self:_createPageItem()
		self._pageView:addPage(item)
		table.insert(self._pageItems, item)
	end
	self:_updatePageItem()
	self._pageView:setCurrentPageIndex(self._selectedPos - 1)
end

-- i18n ja add ui
function HeroDetailView:_updateUIInfo()	
	if not Lang.checkUI("ui4") then
		return 
	end

	self:updateFightPower()
	local heroId = self._allHeroIds[self._selectedPos]
	local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
	local heroId  = AvatarDataHelper.getShowHeroBaseIdByCheck(unitData)
	if heroId and heroId > 0 then
		local Hero = require("app.config.hero")
		local HeroRes = require("app.config.hero_res")
		local heroData = Hero.get(heroId)
		local heroResData = HeroRes.get(heroData.res_id)
		self._CVTxt:setString("CV  " .. heroResData.cast_name)  	
		self._CVTxtPoint:setPositionX(self._CVTxt:getPositionX() - self._CVTxt:getContentSize().width*0.5 + (18 + 11))  
		self._CVTxt:getParent():setVisible(true)

		if self._selectedPos == 1 then -- 主角 unitData:getConfig().type  张星彩...
			local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(unitData)
			
			self._CVTxt:getParent():setVisible(false)
			if isEquipAvatar then
				local  heroBaseId = AvatarDataHelper.getAvatarConfig(G_UserData:getBase():getAvatar_base_id()).hero_id
				heroData = require("app.config.hero").get(heroBaseId)
				heroResData = require("app.config.hero_res").get(heroData.res_id)
				self._CVTxt:setString("CV  " .. heroResData.cast_name)  
				self._CVTxt:getParent():setVisible(true)
			end
		end 
		
	end

	local _textSpine = ccui.Helper:seekNodeByName(self._buttonSpine, "TextSpine")
	_textSpine:setString(Lang.get("hero_team_txt_des"))       

	-- 调整战力位置
	local posX =  self._CVTxt:getParent():getPositionX()
	posX = posX - self._fightPower:getWidth()*0.5 + 20
	self._fightPower:setPositionX(posX)
	ccui.Helper:seekNodeByName(self._panelDesign, "powerBg"):setAnchorPoint(cc.p(0, 0.5))
	ccui.Helper:seekNodeByName(self._panelDesign, "powerBg"):setPositionX(posX)
end

-- i18n ja update power
function HeroDetailView:updateFightPower()  
	local curHeroId = G_UserData:getHero():getCurHeroId()
	local unitData = G_UserData:getHero():getUnitDataWithId(curHeroId)
	local param = {heroUnitData = unitData}
	local attrInfo = UserDataHelper.getHeroPowerAttr(param)  
	local power = AttrDataHelper.getPower(attrInfo)
	self._fightPower:updateUI(power)
end

-- i18n ja add func
function HeroDetailView:_updateInfo2()
	HeroDetailBaseView = require("app.scene.view.heroDetail.HeroDetailBaseView2")
	if self._nodeHeroDetailView:getChildrenCount() > 0 then
		self._selectTabIndex = self._nodeHeroDetailView:getChildren()[1]:getTabSelect()
	end

	self._nodeHeroDetailView:removeAllChildren()
	local curHeroId = G_UserData:getHero():getCurHeroId()
	local heroDetail = HeroDetailBaseView.new(curHeroId, nil, self._rangeType, self)
	self._nodeHeroDetailView:addChild(heroDetail)
	self:_playSkillAnimationOnce()  

	self:_updateUIInfo() 
end

-- i18n ja add func
function HeroDetailView:getDetailViewNode()
	return self._nodeHeroDetailView
end

function HeroDetailView:_updateInfo()
	if Lang.checkUI("ui4") then   -- i18n ja update UI
		self:_updateInfo2()
		return
	end

	self._nodeHeroDetailView:removeAllChildren()
	local curHeroId = G_UserData:getHero():getCurHeroId()
	local heroDetail = HeroDetailBaseView.new(curHeroId, nil, self._rangeType, self)
	self._nodeHeroDetailView:addChild(heroDetail)
	self:_playCurHeroVoice()
end

function HeroDetailView:_playCurHeroVoice(must)
	local curHeroId = G_UserData:getHero():getCurHeroId()
	local curHeroData = G_UserData:getHero():getUnitDataWithId(curHeroId)
	local baseId = curHeroData:getBase_id()
	if Lang.checkUI("ui4") then
		local widget = self._pageItems[self._selectedPos]
		local avatar = widget:getChildren()[1]
		local heroBaseId = AvatarDataHelper.getShowHeroBaseIdByCheck(curHeroData)
		G_HeroVoiceManager:playVoiceWithHeroId(heroBaseId, must, avatar)
	else
		G_HeroVoiceManager:playVoiceWithHeroId(baseId, must)
	end
end

function HeroDetailView:_updateArrowBtn()
	self._buttonLeft:setVisible(self._selectedPos > 1)
	self._buttonRight:setVisible(self._selectedPos < self._heroCount)
end

function HeroDetailView:_onButtonLeftClicked()
	if self._selectedPos <= 1 then
		return
	end

	self._selectedPos = self._selectedPos - 1
	self:_setCurPos()
	local curHeroId = self._allHeroIds[self._selectedPos]
	G_UserData:getHero():setCurHeroId(curHeroId)
	self:_updateArrowBtn()
	self._pageView:setCurrentPageIndex(self._selectedPos - 1)
	self:_updateInfo()
	self:_updatePageItem()
end

function HeroDetailView:_onButtonRightClicked()
	if self._selectedPos >= self._heroCount then
		return
	end

	self._selectedPos = self._selectedPos + 1
	self:_setCurPos()
	local curHeroId = self._allHeroIds[self._selectedPos]
	G_UserData:getHero():setCurHeroId(curHeroId)
	self:_updateArrowBtn()
	self._pageView:setCurrentPageIndex(self._selectedPos - 1)
	self:_updateInfo()
	self:_updatePageItem()
end

function HeroDetailView:_onPageTouch(sender, state)
	if state == ccui.TouchEventType.began then
		self:_playCurHeroVoice(true) -- i18n ja 先随机播放一个voice音效 等后期有动作后再随机
		self:_playSkillAnimationOnce(true) -- i18n ja paly ani
		return true
	elseif state == ccui.TouchEventType.moved then
	elseif state == ccui.TouchEventType.ended or state == ccui.TouchEventType.canceled then
	end
end

function HeroDetailView:_onPageViewEvent(sender, event)
	if event == ccui.PageViewEventType.turning and sender == self._pageView then
		local targetPos = self._pageView:getCurrentPageIndex() + 1
		if targetPos ~= self._selectedPos then
			self._selectedPos = targetPos
			self:_setCurPos()
			local curHeroId = self._allHeroIds[self._selectedPos]
			G_UserData:getHero():setCurHeroId(curHeroId)
			self:_updateArrowBtn()
			self:_updateInfo()
			self:_updatePageItem()
		end
	end
end

function HeroDetailView:_onButtonVoiceClicked()
	self:_playCurHeroVoice(true)
end

-- i18n ja check spine 查看立绘
function HeroDetailView:_onButtonCheckSpineClicked()
	local HeroDetailCheckDrawing = require("app.scene.view.heroDetail.HeroDetailCheckDrawing")

	local checkSpine = HeroDetailCheckDrawing.new()
	self:addChild(checkSpine)
end
	 
-- i18n ja play ani    备注：目前因为立绘没有对应动作 暂时用不上 
function HeroDetailView:_playSkillAnimationOnce(bClickAvatar)
		do return end  
	if not Lang.checkUI("ui4") then
		return 
	end
	local curHeroId = G_UserData:getHero():getCurHeroId()
	local curHeroData = G_UserData:getHero():getUnitDataWithId(curHeroId)
	local heroBaseId = curHeroData:getBase_id()
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)
	local _actionName = param.res_cfg.show_action_b      
	local HeroDataHelper = require("app.utils.data.HeroDataHelper")
	_actionName = HeroDataHelper.getHeroAction(_actionName, bClickAvatar)  
	
	local widget = self._pageItems[self._selectedPos]
	local avatar = widget:getChildren()[1]
	print("avatar:playAnimationOnce", avatar.playAnimationOnce)
	avatar:playAnimationOnce(_actionName or "idle")          -- 播放点击动画

	G_HeroVoiceManager:playSpineVoiceWithHeroId(heroBaseId, true, _actionName)   
end

-- i18n ja 
function HeroDetailView:getPageView()
	return self._pageView
end

-- i18n ja 
function HeroDetailView:getPageViewPos()
	return self._selectedPos
end


return HeroDetailView
