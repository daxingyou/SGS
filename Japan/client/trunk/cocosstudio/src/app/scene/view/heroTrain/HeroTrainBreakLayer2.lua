--
-- Author: Liangxu
-- Date: 2017-03-17 17:57:20
-- 武将突破
local ListViewCellBase = require("app.ui.ListViewCellBase")
local HeroTrainBreakLayer = class("HeroTrainBreakLayer", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local AttributeConst = require("app.const.AttributeConst")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local CSHelper = require("yoka.utils.CSHelper")
local AudioConst = require("app.const.AudioConst")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local UIHelper = require("yoka.utils.UIHelper")

--根据材料数量，定义材料的位置
local MATERIAL_POS = {
	[1] = {{160, 56}},
	[2] = {{92, 68}, {235, 68}},
}

function HeroTrainBreakLayer:ctor(parentView)
	self._parentView = parentView
	local resource = {
		file = Path.getCSB("HeroTrainBreakLayer2", "hero"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonBreak = {
				events = {{event = "touch", method = "_onButtonBreakClicked"}},
			},
			_buttonTalentDes = {
				events = {{event = "touch", method = "_onButtonTalentDesClicked"}},
			}
		},
	}
	self:setName("HeroTrainBreakLayer")
	self:enableNodeEvents()          		--  OnEnter网络回调才能调用
	HeroTrainBreakLayer.super.ctor(self, resource)
end

function HeroTrainBreakLayer:onCreate()
	--self:_dealPosI18n()
	self:_doLayout()
	self:_initData()
	self:_initView()
end

function HeroTrainBreakLayer:onEnter()
	--抛出新手事件
	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
	self._signalHeroRankUp = G_SignalManager:add(SignalConst.EVENT_HERO_RANKUP, handler(self, self._heroRankUpSuccess))

	self:_updatePageItem()
	self:_updateInfo()
end

function HeroTrainBreakLayer:onExit()
	self._signalHeroRankUp:remove()
	self._signalHeroRankUp = nil
end

function HeroTrainBreakLayer:initInfo()
	self:_updatePageItem()
	self:_updateInfo()
end

function HeroTrainBreakLayer:_initData()
	self._isReachLimit = false -- 是否达到上限
	self._conditionLevel = false
end

function HeroTrainBreakLayer:_initView()
	self._materialIcons = {}
	self._buttonBreak:setString(Lang.get("hero_break_btn_break"))
	self._fileNodeDetailTitle:setFontSize(22)
	self._fileNodeCostTitle:setFontSize(22)
	self._fileNodeDetailTitle:setTitle(Lang.get("hero_break_detail_title"))
	self._fileNodeCostTitle:setTitle(Lang.get("hero_break_cost_title"))
	-- self._fileNodeHeroName2:setFontSize(22)

	--self:_initPageView()
end

function HeroTrainBreakLayer:_doLayout()
    local contentSize = self._parentView._listView:getContentSize() --self._panelBg:getContentSize() 
	self:setContentSize(contentSize)                                --  设置node节点尺寸   
end

function HeroTrainBreakLayer:_updateInfo()
	self._heroId = G_UserData:getHero():getCurHeroId()
	self._heroUnitData = G_UserData:getHero():getUnitDataWithId(self._heroId)
	local rankMax = self._heroUnitData:getConfig().rank_max
	self._rankLevel = self._heroUnitData:getRank_lv()
	self._isReachLimit = self._rankLevel >= rankMax --是否抵达上限

	self:setButtonEnable(true)
	self:_updateShow()
	self:_updateAttr()
	self:_updateCost()
end

function HeroTrainBreakLayer:_updateShow()
	-- local index = self._parentView:getSelectedPos()
	--	self._fileNodeHeroOld = self._pageItems[index].avatar1
	--	self._fileNodeHeroNew = self._pageItems[index].avatar2
	self._heroTitle:updateUI(self._heroUnitData)
	self._parentView._parentView:updateFightPower()

	local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)
	local rankLevel = self._isReachLimit and self._rankLevel or self._rankLevel+1
	local limitLevel = avatarLimitLevel or self._heroUnitData:getLimit_level()
	local limitRedLevel = arLimitLevel or self._heroUnitData:getLimit_rtg()
	-- self._fileNodeNameOld:setName(self._heroUnitData:getBase_id(), self._rankLevel, self._heroUnitData:getLimit_level(),
	-- 	nil, self._heroUnitData:getLimit_rtg())
	-- self._fileNodeNameNew:setName(self._heroUnitData:getBase_id(), rankLevel, self._heroUnitData:getLimit_level(),
	-- 	nil, self._heroUnitData:getLimit_rtg())
	-- self._fileNodeHeroName2:setName(self._heroUnitData:getBase_id(), self._rankLevel, self._heroUnitData:getLimit_level(),
	-- 	nil, self._heroUnitData:getLimit_rtg())
	--self._fileNodeHeroNew:updateUI(heroBaseId, nil, nil, limitLevel, nil, nil, limitRedLevel)

	--self._fileNodeNameOld:setVisible(not self._isReachLimit)
	--self._fileNodeHeroOld:setVisible(not self._isReachLimit)
	--	self._imageBreakArrow:setVisible(not self._isReachLimit)
	--	self._iconArrow:setVisible(not self._isReachLimit)
	self._imageTalentBg:setVisible(not self._isReachLimit)

	self._parentView._nodeTalentDesPos:removeAllChildren()
	local label = nil
	local height = 102
	if self._isReachLimit then
		label = cc.Label:createWithTTF(Lang.get("hero_break_txt_all_unlock"), Path.getCommonFont(), 20)
		label:setMaxLineWidth(334)
		label:setAnchorPoint(cc.p(0.5, 1))
	else 
		--self._fileNodeHeroNew:setPosition(self:_getPositionWithIndex(2))
	    --self._fileNodeHeroOld:updateUI(heroBaseId, nil, nil, limitLevel, nil, nil, limitRedLevel)
		local limitLevel = self._heroUnitData:getLimit_level()
		local limitRedLevel = self._heroUnitData:getLimit_rtg()
		if self._heroUnitData:isLeader() then
			limitLevel = self._heroUnitData:getLeaderLimitLevel()
			limitRedLevel = self._heroUnitData:getLeaderLimitRedLevel()
		end
		local heroRankConfig = UserDataHelper.getHeroRankConfig(heroBaseId, rankLevel, limitLevel, limitRedLevel)
		if heroRankConfig then
			local talentName = heroRankConfig.talent_name
			local talentDes = heroRankConfig.talent_description
			local breakDes = Lang.get("hero_break_txt_break_des", {rank = rankLevel})   
			local talentInfo = Lang.get("hero_break_txt_talent_des_ja", {
				des = talentDes,
				breakDes = breakDes,
			})
	 
			label = ccui.RichText:createWithContent(talentInfo)
			label:setAnchorPoint(cc.p(0.5, 1))
			label:ignoreContentAdaptWithSize(false)
			if Lang.checkLatinLanguage()  then
				label:setVerticalSpace(-4)
				label:setContentSize(cc.size(350,0))
			else
				label:setContentSize(cc.size(350,0))
			end
			label:formatText()


			local Names = Lang.get("hero_gold_txt_talent_title2", {talentName = talentName})
			local labelName = ccui.RichText:createWithContent(Names)
			labelName:setAnchorPoint(cc.p(1, 0.5))
			labelName:setPositionX(0)
			self._nodeTalentName:removeAllChildren()
			self._nodeTalentName:addChild(labelName)  
			self._imageTalentBg:setVisible(true)

			self._parentView._textBreakTalentTitle:setString("[" .. talentName .. "]") 
			print("---richText:getVirtualRendererSize().height:", label:getContentSize().height, label:getVirtualRendererSize().height)  --2个输出来一样高  没formatText输出高度=0
			height = label:getVirtualRendererSize().height + 43
		else
			self._imageTalentBg:setVisible(false)
			self._parentView._nodeTalent:setVisible(false)
		end
	end
	if label then
		self._parentView._nodeTalentDesPos:addChild(label)
		self._parentView._imgBreakTalentBg:setContentSize(cc.size(370, height))
		--self._parentView._nodeTalent:setVisible(true)  默认不显示 点击按钮显示
	end
end

function HeroTrainBreakLayer:_updateAttr()
	self._textOldLevel:setString(Lang.get("hero_break_txt_break_title", {level = self._rankLevel}))
	local strRankLevel = self._isReachLimit == true and Lang.get("hero_break_txt_reach_limit") or Lang.get("hero_break_txt_break_title", {level = self._rankLevel + 1})
	self._textTitle:setString(Lang.get("hero_transform_result_title_2"))     
	self._textNewLevel:setString(strRankLevel)   
 

	local curBreakAttr = UserDataHelper.getBreakAttr(self._heroUnitData)
	local nextBreakAttr = UserDataHelper.getBreakAttr(self._heroUnitData, 1) or {}
	self._fileNodeAttr1:updateInfo(AttributeConst.ATK, curBreakAttr[AttributeConst.ATK], nextBreakAttr[AttributeConst.ATK], 4)
	self._fileNodeAttr2:updateInfo(AttributeConst.HP, curBreakAttr[AttributeConst.HP], nextBreakAttr[AttributeConst.HP], 4)
	self._fileNodeAttr3:updateInfo(AttributeConst.PD, curBreakAttr[AttributeConst.PD], nextBreakAttr[AttributeConst.PD], 4)
	self._fileNodeAttr4:updateInfo(AttributeConst.MD, curBreakAttr[AttributeConst.MD], nextBreakAttr[AttributeConst.MD], 4)
	self:_adjustFontSizeAndDis()
end

function HeroTrainBreakLayer:_adjustFontSizeAndDis( )
	for i=1,4 do
		self["_fileNodeAttr" .. i]:getChildByName("TextName"):setFontSize(18)
		self["_fileNodeAttr" .. i]:getChildByName("TextCurValue"):setFontSize(16)
		self["_fileNodeAttr" .. i]:getChildByName("TextNextValue"):setFontSize(16)
		self["_fileNodeAttr" .. i]:getChildByName("TextAddValue"):setFontSize(16)

		self["_fileNodeAttr" .. i]:getChildByName("TextNextValue"):setPositionX(118-14)
		self["_fileNodeAttr" .. i]:getChildByName("TextName"):setPositionX(0 + 18)
		self["_fileNodeAttr" .. i]:getChildByName("TextCurValue"):setPositionX(13 + 6)

		self["_fileNodeAttr" .. i]:getChildByName("ImageUpArrow"):setPositionX(201 - 7)

		-- 血量特殊处理
		if i == 2 then
			self["_fileNodeAttr" .. i]:getChildByName("TextName"):setString("P:")
			self["_fileNodeAttr" .. i]:getChildByName("Text_HP"):setString("H")    
		end

		-- 添加空格
		local str = self["_fileNodeAttr" .. i]:getChildByName("TextName"):getString()
		str = string.gsub(str, " ", "") 
		str = string.gsub(str, ":", ": ") 
		self["_fileNodeAttr" .. i]:getChildByName("TextName"):setString(str)

		-- 满突时
		if self._isReachLimit then
			self["_fileNodeAttr" .. i]:getChildByName("TextNextValue"):setVisible(false)
			self["_fileNodeAttr" .. i]:getChildByName("ImageUpArrow"):setVisible(false)
			self["_fileNodeAttr" .. i]:getChildByName("TextAddValue"):setString(Lang.get("hero_break_txt_reach_limit"))  
			self["_fileNodeAttr" .. i]:getChildByName("TextAddValue"):setPositionX(216 - 30 - 8)
			self["_fileNodeAttr" .. i]:getChildByName("TextAddValue"):setFontSize(14)
			-- 箭头
			self._textNewLevel:setAnchorPoint(cc.p(0, 0))
			self._textNewLevel:setPositionX(236-12 - 8)
			self._textNewLevel:setFontSize(14)
			self._imageArrow:setPositionX(178+1)
			local widget = self._imageArrow:clone()
			self["_fileNodeAttr" .. i]:addChild(widget)
			widget:setAnchorPoint(cc.p(0.5, 0.5))
			widget:setPosition(cc.p(141, 11))
		end
	end
end

function HeroTrainBreakLayer:_updateCost()
	self._costCardNum = 0
	self._fileNodeCostTitle:setVisible(not self._isReachLimit)
	self._panelCost:removeAllChildren()
	self._nodeNeedLevelPos:removeAllChildren()
	self._nodeResource:setVisible(false)
	self._buttonBreak:setEnabled(not self._isReachLimit)
	if self._isReachLimit then --达到顶级了
		self._buttonBreak:setVisible(false)
		self._parentView._nodeTalent:setVisible(false)
		--添加背景图
		local sp = cc.Sprite:create(Path.getTextTeam("img_zr_anwen"))
		local size = self._panelCost:getContentSize()
		sp:setPosition(cc.p(size.width/2, size.height/2))
		self._panelCost:addChild(sp)

		-- i18n change lable
		if not Lang.checkLang(Lang.CN) then
			local size = self._panelCost:getContentSize()
			local UIHelper  = require("yoka.utils.UIHelper")
			local label = UIHelper.createLabel(
				{
					style = "team_max_level_ja", 
					text =  Lang.getImgText("txt_train_breakthroughtop") ,
					position = cc.p(size.width/2, size.height/2) ,
					anchorPoint = cc.p(0.5,0.5),
				}
			)
			label:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER  )
			self._panelCost:addChild(label)
		else
			local sp = cc.Sprite:create(Path.getTextTeam("img_zr_ls"))
			local size = self._panelCost:getContentSize()
			sp:setPosition(cc.p(size.width/2, size.height/2))
			self._panelCost:addChild(sp)
		end
		return
	end

	--材料
	self._materialIcons = {}
	self._materialInfo = {}
	self._resourceInfo = {}
	local allMaterialInfo = UserDataHelper.getHeroBreakMaterials(self._heroUnitData)
	for i, info in ipairs(allMaterialInfo) do
		if info.type ~= TypeConvertHelper.TYPE_RESOURCE then --排除银币
			table.insert(self._materialInfo, info)
		else
			table.insert(self._resourceInfo, info)
		end
	end
	local len = #self._materialInfo
	for i, info in ipairs(self._materialInfo) do
		local node = CSHelper.loadResourceNode(Path.getCSB("CommonCostNode", "common"))
		node:updateView(info)
		local pos = cc.p(MATERIAL_POS[len][i][1], MATERIAL_POS[len][i][2])   
		node:setPosition(pos)
		self._panelCost:addChild(node)
		table.insert(self._materialIcons, node)
		if info.type == TypeConvertHelper.TYPE_HERO then
			self._costCardNum = self._costCardNum + node:getNeedCount()
		end
	end

	--银币
	local resource = self._resourceInfo[1]
	if resource then
		self._nodeResource:updateUI(resource.type, resource.value, resource.size)
		self._nodeResource:setTextColor(Colors.BRIGHT_BG_TWO)
		self._nodeResource:setVisible(true)
	else
		self._nodeResource:setVisible(false)
	end

	--需要等级
	local myLevel = self._heroUnitData:getLevel()
	local needLevel = UserDataHelper.getHeroBreakLimitLevel(self._heroUnitData)
	local colorNeed = myLevel < needLevel and Colors.colorToNumber(Colors.BRIGHT_BG_RED) or Colors.colorToNumber(Colors.BRIGHT_BG_GREEN)
	local needLevelInfo = Lang.get("hero_break_txt_need_level", {
										value1 = myLevel,
										color = colorNeed,
										value2 = needLevel,
									})
	needLevelInfo = string.gsub(needLevelInfo, "\"fontSize\":20", "\"fontSize\":18")   -- 修改字号

	local richTextNeedLevel = ccui.RichText:createWithContent(needLevelInfo)
	richTextNeedLevel:setAnchorPoint(cc.p(0, 0))
	self._nodeNeedLevelPos:addChild(richTextNeedLevel)
	self._conditionLevel = myLevel >= needLevel
 	self:_adjustCostPosAndSize()
end

-- i18n ja change font position
function HeroTrainBreakLayer:_adjustCostPosAndSize()
	--银币
	self._nodeResource:getChildByName("Text"):setFontSize(19)
	self._nodeResource:getChildByName("Text"):setPositionX(18 + 15)
	self._nodeResource:getChildByName("Image"):setPositionY(18 + 3)
	self._nodeResource:getChildByName("Image"):setScale(0.8)
	local width = self._nodeResource:getChildByName("Text"):getContentSize().width + 12 + self._nodeResource:getChildByName("Image"):getContentSize().width*0.8 	
	self._nodeResource:setPositionX(self._buttonBreak:getPositionX() - width - 20)
	 
	--材料
	local len = self._panelCost:getChildrenCount()
	for i=1,len do
		local child = self._panelCost:getChildren()[i]
        
		child:getChildByName("TextName"):setAnchorPoint(cc.p(0.5, 0))
		child:getChildByName("TextName"):setPosition(cc.p(0, 40))
		--child:setCloseMode(true)

		local size = child:getChildByName("FileNodeIcon"):getChildByName("ImageTemplate"):getContentSize()
		child:getChildByName("NodeNumPos"):getChildren()[1]:setAnchorPoint(cc.p(0.5, 0.5))
		child:getChildByName("NodeNumPos"):setPosition(cc.p(0, -size.height*0.44))  
		child:getChildByName("NodeNumPos"):setScale(18/22)
		child:getChildByName("TextName"):setFontSize(18)
	end
end


function HeroTrainBreakLayer:setButtonEnable(enable)
	self._buttonBreak:setEnabled(enable)
	-- self._pageView:setEnabled(enable)
	-- if self._parentView and self._parentView.setArrowBtnEnable then
	-- 	self._parentView:setArrowBtnEnable(enable)
	-- end
end

function HeroTrainBreakLayer:_onButtonBreakClicked()
	if self._isReachLimit then
		G_Prompt:showTip(Lang.get("hero_break_reach_limit_tip"))
		return
	end
	if not self._conditionLevel then
		G_Prompt:showTip(Lang.get("hero_break_condition_no_level"))
		return
	end
	for i, icon in ipairs(self._materialIcons) do
		local isReachCondition = icon:isReachCondition()
		if not isReachCondition then
			local info = self._materialInfo[i]
			local param = TypeConvertHelper.convert(info.type, info.value)
			G_Prompt:showTip(Lang.get("hero_break_condition_no_cost", {name = param.name}))
			return
		end
	end
	for i, info in ipairs(self._resourceInfo) do
		local enough = require("app.utils.LogicCheckHelper").enoughValue(info.type, info.value, info.size)
		if not enough then
			return false
		end
	end
	
	self:_doHeroBreak()
end

function HeroTrainBreakLayer:_onButtonTalentDesClicked()
	self._parentView._nodeTalent:setVisible( not self._parentView._nodeTalent:isVisible() )
end

function HeroTrainBreakLayer:_doHeroBreak()
	local id = self._heroUnitData:getId()
	local heroIds = {}
	local sameCards = G_UserData:getHero():getSameCardCountWithBaseId(self._heroUnitData:getBase_id())
	local count = 0
	for k, card in pairs(sameCards) do
		if count >= self._costCardNum then
			break
		end
		table.insert(heroIds, card:getId())
		count = count + 1
	end
	G_UserData:getHero():c2sHeroRankUp(id, heroIds)
	self:setButtonEnable(false)
end

function HeroTrainBreakLayer:_heroRankUpSuccess()
	self:_playEffect()
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint() 
	end
end

function HeroTrainBreakLayer:showHeroAvatar()
	self._fileNodeHeroOld:setOpacity(255)
	self._fileNodeHeroNew:setOpacity(255)
end

function HeroTrainBreakLayer:_playEffect()
	local function eventFunction(event)
		if event == "bao" then
			if self and self.setButtonEnable and self._updateInfo then
				local popupBreakResult = require("app.scene.view.heroTrain.PopupBreakResult2").new(self, self._heroId)
				popupBreakResult:open()
				
				self:setButtonEnable(true) 
				self:_updateInfo()
			end
        end
    end
	local gfxEffect = G_EffectGfxMgr:createPlayGfx(self._parentView._nodeBreakEffect, "effect_wujiang_up", eventFunction) 
	G_AudioManager:playSound(Path.getUIVoice("herotpSucess")) --WithId(AudioConst.SOUND_HERO_BREAK) --播音效   
	do return end 
 
	local function effectFunction(effect)
        if effect == "effect_wujiangtupo_ningju" then
            local subEffect = EffectGfxNode.new("effect_wujiangtupo_ningju")
            subEffect:play()
            return subEffect
        end

        if effect == "effect_wujiangtupo_feichu" then
        	local subEffect = EffectGfxNode.new("effect_wujiangtupo_feichu")
            subEffect:play()
            return subEffect
        end

    	if effect == "effect_wujiangtupo_xingxing" then
    		local subEffect = EffectGfxNode.new("effect_wujiangtupo_xingxing")
            subEffect:play()
            return subEffect
    	end

    	if effect == "effect_wujiangtupo_daguang" then
    		local subEffect = EffectGfxNode.new("effect_wujiangtupo_daguang")
            subEffect:play()
            return subEffect
    	end

    	if effect == "effect_wujiangtupo_xiaoxing" then
    		local subEffect = EffectGfxNode.new("effect_wujiangtupo_xiaoxing")
            subEffect:play()
            return subEffect
    	end

    	if effect == "effect_wujiangtupo_guangqiu" then
    		local subEffect = EffectGfxNode.new("effect_wujiangtupo_guangqiu")
            subEffect:play()
            return subEffect
    	end

    	if effect == "effect_wujiangtupo_shuxian" then
    		local subEffect = EffectGfxNode.new("effect_wujiangtupo_shuxian")
            subEffect:play()
            return subEffect
    	end

    	if effect == "effect_wujiangtupo_xiaosan" then
    		local subEffect = EffectGfxNode.new("effect_wujiangtupo_xiaosan")
            subEffect:play()
            return subEffect
    	end
    		
        return cc.Node:create()
    end

    local function eventFunction(event)
    	if event == "1p" then
    		local action = cc.FadeOut:create(0.3)
    		self._fileNodeHeroOld:runAction(action)
    		G_AudioManager:playSoundWithId(AudioConst.SOUND_HERO_BREAK) --播音效
        elseif event == "2p" then
        	local action = cc.FadeOut:create(0.3)
    		self._fileNodeHeroNew:runAction(action)
    	elseif event == "finish" then
    		local popupBreakResult = require("app.scene.view.heroTrain.PopupBreakResult").new(self, self._heroId)
			popupBreakResult:open()
			
			self:setButtonEnable(true)
			self:_updateInfo()
			self:showHeroAvatar()
        end
    end

	if CONFIG_LIMIT_BOOST then
		self:setButtonEnable(true)
		self:_updateInfo()
		self:showHeroAvatar()
	else
		local effect = G_EffectGfxMgr:createPlayMovingGfx(self, "moving_wujiangtupo", effectFunction, eventFunction , false)
		effect:setPosition(cc.p(G_ResolutionManager:getDesignWidth()*0.5, G_ResolutionManager:getDesignHeight()*0.5))
	end
end

--全范围的情况，突破如果消耗同名卡，要重新更新列表
--此处特殊处理，重新建一遍pageView
function HeroTrainBreakLayer:updatePageView()
	self:_initPageView()
	self:_updatePageItem()
	self:_updateShow()
end

---------------------- 无用函数

function HeroTrainBreakLayer:_dealPosI18n()
	if not Lang.checkLang(Lang.CN) then
		local text = ccui.Helper:seekNodeByName(self._nodeResource, "Text")
		text:setFontSize(text:getFontSize()-2)

		self._fileNodeNameOld:setPositionX(self._fileNodeNameOld:getPositionX()-48)
		self._iconArrow:setPositionX(self._iconArrow:getPositionX()-21)

		self._textOldLevel:setPositionX(self._textOldLevel:getPositionX()+4)
	end
	
end

function HeroTrainBreakLayer:_createPageItem()
	local widget = ccui.Widget:create()
	widget:setSwallowTouches(false)
	widget:setContentSize(self._pageViewSize.width, self._pageViewSize.height)

	return widget
end

function HeroTrainBreakLayer:_getPositionWithIndex(index)
	local imageStage = self["_imageStage"..index]
	local targetPosX = imageStage:getPositionX()
	local targetPosY = imageStage:getPositionY() + (imageStage:getContentSize().height / 4)
	local pos = UIHelper.convertSpaceFromNodeToNode(self._nodeShow, self._pageView, cc.p(targetPosX, targetPosY))
	return pos
end

function HeroTrainBreakLayer:_initPageView()
	self._pageItems = {}
	self._pageView:setItemsMargin(60) --加大间隙，防止有武器太大，越界穿帮
	self._pageView:setSwallowTouches(false)
	self._pageView:setScrollDuration(0.3)
	self._pageView:addEventListener(handler(self,self._onPageViewEvent))
    self._pageViewSize = self._pageView:getContentSize()

	self._pageView:removeAllPages()
	local heroCount = self._parentView:getHeroCount()
    for i = 1, heroCount do
    	local widget = self:_createPageItem()
        self._pageView:addPage(widget)
        self._pageItems[i] = {widget = widget}
    end
    local selectedPos = self._parentView:getSelectedPos()
    self._pageView:setCurrentPageIndex(selectedPos - 1)
end

function HeroTrainBreakLayer:_onPageViewEvent(sender,event)
	if event == ccui.PageViewEventType.turning and sender == self._pageView then
		local targetPos = self._pageView:getCurrentPageIndex() + 1
		local selectedPos = self._parentView:getSelectedPos()
		if targetPos ~= selectedPos then
			self._parentView:setSelectedPos(targetPos)
			local allHeroIds = self._parentView:getAllHeroIds()
			local curHeroId = allHeroIds[targetPos]
			G_UserData:getHero():setCurHeroId(curHeroId)
			self._parentView:updateArrowBtn()
			self:_updatePageItem()
			self:_updateInfo()
			self._parentView:updateTabIcons()
		end
	end
end

function HeroTrainBreakLayer:_updatePageItem()
	do return end
	local allHeroIds = self._parentView:getAllHeroIds()
	local index = self._parentView:getSelectedPos()
	for i = index-1, index+1 do
		if i >= 1 and i <= #allHeroIds then
			if self._pageItems[i] == nil then
				local widget = self:_createPageItem()
		        self._pageView:addPage(widget)
		        self._pageItems[i] = {widget = widget}
			end
			if self._pageItems[i].avatar1 == nil and self._pageItems[i].avatar2 == nil then
				local avatar1 = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
				local avatar2 = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
				avatar1:setScale(1.0)
				avatar2:setScale(1.2)
				avatar1:setPosition(self:_getPositionWithIndex(1))
				avatar2:setPosition(self:_getPositionWithIndex(2))
				self._pageItems[i].widget:addChild(avatar1)
				self._pageItems[i].widget:addChild(avatar2)
				self._pageItems[i].avatar1 = avatar1
				self._pageItems[i].avatar2 = avatar2
			end
			local heroId = allHeroIds[i]
			local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
			local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(unitData)
			local limitLevel = avatarLimitLevel or unitData:getLimit_level()
			local limitRedLevel = arLimitLevel or unitData:getLimit_rtg()
			self._pageItems[i].avatar1:updateUI(heroBaseId, nil, nil, limitLevel, nil, nil, limitRedLevel)
			self._pageItems[i].avatar2:updateUI(heroBaseId, nil, nil, limitLevel, nil, nil, limitRedLevel)
		end
	end
end 

return HeroTrainBreakLayer


