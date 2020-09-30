
-- Author: liangxu
-- Date:2017-10-18 16:26:18
-- Describle：

local ViewBase = require("app.ui.ViewBase")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local HeroTrainAwakeLayer = class("HeroTrainAwakeLayer", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TeamGemstoneIcon = require("app.scene.view.team.TeamGemstoneIcon")
local TextHelper = require("app.utils.TextHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local GemstoneConst = require("app.const.GemstoneConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local HeroTrainHelper = require("app.scene.view.heroTrain.HeroTrainHelper")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local UIHelper  = require("yoka.utils.UIHelper")
local AudioConst = require("app.const.AudioConst")
local UIConst = require("app.const.UIConst")
local PopupAwakePreview = require("app.scene.view.heroTrain.PopupAwakePreview")

--根据材料数量，定义材料的位置
local MATERIAL_POS = {
	[1] = {{160, 56}}, 
	[2] = {{85, 56}, {238, 56}},
}

function HeroTrainAwakeLayer:ctor(parentView)
	self._fileNodeStar = nil  --CommonStar
	self._textLevel = nil  --Text
	self._fileNodeGemstone4 = nil  --
	self._textCost = nil  --Text
	self._fileNodeGemstone1 = nil  --
	self._pageView = nil  --PageView
	self._fileNodeCost = nil  --CommonResourceInfo
	self._fileNodeDetailTitle = nil  --CommonDetailTitle
	self._fileNodeCountry = nil  --CommonHeroCountry
	self._fileNodeHeroName2 = nil  --CommonHeroName
	self._fileNodeGemstone3 = nil  --
	self._fileNodeGemstone2 = nil  --
	self._textOldLevel = nil  --Text
	self._textDesc = nil  --Text
	self._fileNodeDetailTitle2 = nil  --CommonDetailTitle
	self._fileNodeHeroName = nil  --CommonHeroName
	self._textNewLevel = nil  --Text
	self._buttonAwake = nil  --CommonButtonHighLight
	self._panelCost = nil  --Panel
	self._fileNodeAttr2 = nil  --CommonAttrDiff
	self._fileNodeAttr3 = nil  --CommonAttrDiff
	self._fileNodeAttr1 = nil  --CommonAttrDiff
	self._fileNodeAttr4 = nil  --CommonAttrDiff

	self._parentView = parentView

	local resource = {
		file = Path.getCSB("HeroTrainAwakeLayer2", "hero"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonAwake = {
				events = {{event = "touch", method = "_onButtonAwake"}}
			},
			_buttonTalentDes = {
				events = {{event = "touch", method = "_onButtonTalentDesClicked"}},
			}
			-- _buttonPreview = {
			-- 	events = {{event = "touch", method = "_onButtonPreview"}}
			-- },
			-- _buttonOneKey = {
			-- 	events = {{event = "touch", method = "_onButtonOneKey"}}
			-- },
		},
	}
	self:enableNodeEvents()          		--  OnEnter网络回调才能调用
	HeroTrainAwakeLayer.super.ctor(self, resource)
end

function HeroTrainAwakeLayer:onCreate()
	self:_dealPosByI18n()
	self:_doLayout()
	self:_initData()
	self:_initView()

	-- i18n change lable
	self:_swapImageByI18n()
end

function HeroTrainAwakeLayer:onEnter()
	self._signalHeroAwake = G_SignalManager:add(SignalConst.EVENT_HERO_AWAKE_SUCCESS, handler(self, self._heroAwakeSuccess))
	self._signalHeroEquipAwake = G_SignalManager:add(SignalConst.EVENT_HERO_EQUIP_AWAKE_SUCCESS, handler(self, self._heroEquipAwakeSuccess))
	self._signalMerageItemMsg = G_SignalManager:add(SignalConst.EVENT_EQUIPMENT_COMPOSE_OK, handler(self, self._onSyntheticFragments))
	self._signalFastExecute = G_SignalManager:add(SignalConst.EVENT_FAST_EXECUTE_STAGE, handler(self, self._onEventFastExecuteStage))

end

function HeroTrainAwakeLayer:onExit()
	self._signalHeroAwake:remove()
	self._signalHeroAwake = nil
	self._signalHeroEquipAwake:remove()
	self._signalHeroEquipAwake = nil
	self._signalMerageItemMsg:remove()
	self._signalMerageItemMsg = nil
	self._signalFastExecute:remove()
	self._signalFastExecute = nil

end

function HeroTrainAwakeLayer:initInfo()
	--self._parentView:setArrowBtnVisible(true)
	--self:_updatePageItem()
	self:_updateData()
	self:_updateView()
-- 	local selectedPos = self._parentView:getSelectedPos()
--  self._pageView:setCurrentPageIndex(selectedPos - 1)

	local isOpen = LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_HERO_AWAKE_ONEKEY)
	self._parentView._buttonOneKey:setVisible(isOpen)  
	self._parentView._buttonOneKey:setEnabled(true) 
	self._parentView._nodeLimitAwakeGold:setVisible(true)
	self._parentView._nodeLimitAwakeGold:getChildByName("_buttonShow"):setVisible(false)	
	self._parentView._nodeAwake:setVisible(true)
end

  

function HeroTrainAwakeLayer:_initData()
	self._isLimit = false --是否到顶级
	self._curAttrInfo = {}
	self._nextAttrInfo = {}
	self._sameCardNum = 0 --同名卡数量
	self._materialInfo = {}
	self._costInfo = {}
	self._isAllEquip = false --是否都装备了
	self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst.FUNC_HERO_TRAIN_TYPE3)
	self._lastAwakeLevel = 0 --记录觉醒等级
end

function HeroTrainAwakeLayer:_initView()
	self._fileNodeDetailTitle:setFontSize(22)
	self._fileNodeDetailTitle2:setFontSize(22)
	self._fileNodeDetailTitle:setTitle(Lang.get("hero_awake_detail_title"))
	self._fileNodeDetailTitle2:setTitle(Lang.get("hero_awake_material_title"))
	self._buttonAwake:setString(Lang.get("hero_awake_btn"))
	self._parentView._buttonOneKey:setString(Lang.get("hero_awake_onekey_btn"))
	self._parentView._buttonOneKey:addClickEventListenerEx(handler(self, self._onButtonOneKey))
	

	self._gemstoneIcons = {}
	for i = 1, 4 do
		local icon = TeamGemstoneIcon.new(self._parentView["_fileNodeGemstone"..i], i, handler(self, self._onGemstoneCallback))
		self._gemstoneIcons[i] = icon
		-- bug: 重置位置
	    local size = ccui.Helper:seekNodeByName(self._parentView["_fileNodeGemstone"..i], "ImageBg"):getContentSize()
		ccui.Helper:seekNodeByName(self._parentView["_fileNodeGemstone"..i], "FileNodeCommon"):setPosition(size.width*0.5, size.height*0.5)
	end

	self._materialIcons = {}

	--self:_initPageView()
	self:_adjustFontSizeAndDis()
end

function HeroTrainAwakeLayer:_doLayout()
    local contentSize = self._parentView._listView:getContentSize() --self._panelBg:getContentSize() 
	self:setContentSize(contentSize)                                --  设置node节点尺寸   
end

function HeroTrainAwakeLayer:_updateData()
	self._heroId = G_UserData:getHero():getCurHeroId()
	self._heroUnitData = G_UserData:getHero():getUnitDataWithId(self._heroId)
	local awakeLevel = self._heroUnitData:getAwaken_level()
	local nextAwakeLevel = awakeLevel + 1
	local maxLevel = self._heroUnitData:getConfig().awaken_max
	self._isLimit = nextAwakeLevel > maxLevel
	self._curAttrInfo = UserDataHelper.getAwakeAttr(self._heroUnitData)
	self._nextAttrInfo = {}
	if self._isLimit == false then
		self._nextAttrInfo = UserDataHelper.getAwakeAttr(self._heroUnitData, 1)
	end
	self._recordAttr:updateData(self._curAttrInfo)
	G_UserData:getAttr():recordPower()
end

function HeroTrainAwakeLayer:_recordAwakeLevel()
	local awakeLevel = self._heroUnitData:getAwaken_level()
	self._lastAwakeLevel = awakeLevel
end

--扫荡信息
function HeroTrainAwakeLayer:_onEventFastExecuteStage(eventName, results)
	self:_updateGemstone()
end

function HeroTrainAwakeLayer:_updateView()
	self:setButtonEnable(true)
	self:_updateShow()
	self:_updateGemstone()
	self:_updateLevel()
	self:_updateAttr()
	self:_updateMaterical()
end

--刷新武将展示
function HeroTrainAwakeLayer:_updateShow()
	local heroBaseId = self._heroUnitData:getBase_id()
	local rankLevel = self._heroUnitData:getRank_lv()
	local awakeLevel = self._heroUnitData:getAwaken_level()
	local limitLevel = self._heroUnitData:getLimit_level()
	local limitRedLevel = self._heroUnitData:getLimit_rtg()
	local star, level = UserDataHelper.convertAwakeLevel(awakeLevel) --已达到的星级
	local awakenCost = self._heroUnitData:getConfig().awaken_cost
	local maxLevel = self._heroUnitData:getConfig().awaken_max

	local strLevel = ""
	local strDes = ""
	local strDes2 = ""
	local enoughLevel, nextNeedLevel = HeroTrainHelper.checkAwakeIsEnoughLevel(self._heroUnitData)
	if enoughLevel then
		local nextAwakeLevel, attrInfo, des, des2 = UserDataHelper.findNextAwakeLevel2(awakeLevel, awakenCost, maxLevel)
		if nextAwakeLevel then
			local nextStar, nextLevel = UserDataHelper.convertAwakeLevel(nextAwakeLevel) --下一个有天赋的星级
			strLevel = Lang.get("hero_awake_star_level_des", {star = nextStar, level = nextLevel})
			strDes = des
			strDes2 = des2
			strDes = string.gsub(strDes, "\"fontSize\":22", "\"fontSize\":18")  
		else
			strLevel = Lang.get("hero_awake_star_level_max_des", {star = star, level = level})
			strDes = Lang.get("hero_awake_talent_max_des")
		end
	else
		strDes = Lang.get("hero_awake_next_need_level", {level = nextNeedLevel})
	end
	local star2, level2 = UserDataHelper.convertAwakeLevel(awakeLevel)
	-- self._fileNodeCountry:updateUI(heroBaseId)
	-- self._fileNodeHeroName:setName(heroBaseId, rankLevel, limitLevel, nil, limitRedLevel)
	-- self._fileNodeHeroName2:setName(heroBaseId, rankLevel, limitLevel, nil, limitRedLevel)
	self._fileNodeStar:setStarOrMoon(star)
	self._parentView._parentView._CVTxt:getParent():setVisible(false)  
	ccui.Helper:seekNodeByName(self._parentView._parentView, "CVBg"):setVisible(false)  	-- 隐藏CV
	ccui.Helper:seekNodeByName(self._panelBg, "TextLevel"):setString(Lang.get("hero_transform_result_title_3"))
	--	self._fileNodeStarCopy:setStarOrMoon(star) 
	--	self._textDesc:setString(strDes)
	--self._textLevel:setString(strLevel)  
 
	if self._isLimit then  			--满觉
		self._panelLeader:setVisible(true)
		self._imageTalentBg:setVisible(false)
		self._parentView._nodeAwakeTalent:setVisible(false)
		ccui.Helper:seekNodeByName(self._panelBg, "Panel_123"):setVisible(false)
		return
	end

	if not enoughLevel then         -- 检查是否达到了觉醒要求等级
		self._imageTalentBg:setVisible(false)
		self._parentView._nodeAwakeTalent:setVisible(false)
		return
	end
 
	-- 标题
	local desTitle = Lang.get("horse_detail_title_talent") .. string.match(strDes, "%d+")
	local Names = Lang.get("hero_gold_txt_talent_title2", {talentName = desTitle})
	local labelName = ccui.RichText:createWithContent(Names)
	labelName:setAnchorPoint(cc.p(0, 0.5))
	labelName:setPositionX(0)
	labelName:formatText()
    self._nodeTalentName:removeAllChildren()
	self._nodeTalentName:addChild(labelName)   
--	self._buttonTalentDes:setPositionX(self._nodeTalentName:getPositionX() + labelName:getContentSize().width + 20)
	
	-- 点击按钮描述
	-- strTalentName = string.match(strTalentName, "%d+")   				 -- "觉醒天赋25"  %d匹配到2 %d+匹配到25
	self._parentView._textTalentTitle:setString("[" .. desTitle .. "]")   
	local buttonDes = Lang.get("Hero_awake_des", {Des = strDes2, value = strLevel})
	self._parentView._nodeAwakeTalentDes:removeAllChildren()
	local height = 102
	local label = ccui.RichText:createWithContent(buttonDes)
	label:setAnchorPoint(cc.p(0.5, 1))
	label:ignoreContentAdaptWithSize(false)
	label:setContentSize(cc.size(350,0))
	label:formatText()
	self._parentView._nodeAwakeTalentDes:addChild(label)
	height = label:getVirtualRendererSize().height + 43
	self._parentView._imageAwakeTalentBg:setContentSize(cc.size(370, height))
end


--刷新宝石
function HeroTrainAwakeLayer:_updateGemstone()
	local info = UserDataHelper.getHeroAwakeEquipState(self._heroUnitData)
	self._isAllEquip = true
	for i = 1, 4 do
		local baseId = info[i].needId
		local state = info[i].state
		local icon = self._gemstoneIcons[i]
		icon:updateIcon(state, baseId)
		self._isAllEquip = self._isAllEquip and state == GemstoneConst.EQUIP_STATE_2
		if state == GemstoneConst.EQUIP_STATE_1 or state == GemstoneConst.EQUIP_STATE_3 then
			icon:showRedPoint(true)
		else
			icon:showRedPoint(false)
		end 
 
		 if state == GemstoneConst.EQUIP_STATE_5 then --锁住  美术要求：新增背景图 
			icon:getCommonIcon():setVisible(true)
			ccui.Helper:seekNodeByName(icon:getCommonIcon(), "ImageIcon"):setVisible(false)
		end
	end

	self._buttonAwake:setEnabled(self._isAllEquip and not self._isLimit)
	local show = UserDataHelper.isCanHeroAwake(self._heroUnitData)
	self._buttonAwake:showRedPoint(show)
	self._parentView._buttonPreview:setVisible(not self._isLimit)  
end

--刷新等级
function HeroTrainAwakeLayer:_updateLevel()
	local awakeLevel = self._heroUnitData:getAwaken_level()
	local star, level = UserDataHelper.convertAwakeLevel(awakeLevel)
	self._textOldLevel:setString(Lang.get("hero_awake_star_level", {star = star, level = level}))
	local nextAwakeLevel = awakeLevel + 1
	if self._isLimit then
		self._textNewLevel:setString(Lang.get("hero_awake_star_level_max"))
	else
		local nextStar, nextLevel = UserDataHelper.convertAwakeLevel(nextAwakeLevel)
		self._textNewLevel:setString(Lang.get("hero_awake_star_level", {star = nextStar, level = nextLevel}))
	end
	self._heroTitle:updateUI(self._heroUnitData)
end

--刷新属性
function HeroTrainAwakeLayer:_updateAttr()
	local curDesInfo = TextHelper.getAttrInfoBySort(self._curAttrInfo)
	local nextDesInfo = TextHelper.getAttrInfoBySort(self._nextAttrInfo)
	for i = 1, 4 do
		local curInfo = curDesInfo[i]
		local nextInfo = nextDesInfo[i] or {}
		if curInfo then
			self["_fileNodeAttr"..i]:updateInfo(curInfo.id, curInfo.value, nextInfo.value, 4)
			self["_fileNodeAttr"..i]:setVisible(true)
		else
			self["_fileNodeAttr"..i]:setVisible(false)
		end
	end

	self:_adjustFontSizeAndDis()
end

function HeroTrainAwakeLayer:_adjustFontSizeAndDis()
	-- 属性
	for i=1,4 do
		self["_fileNodeAttr" .. i]:getChildByName("TextName"):setFontSize(18)
		self["_fileNodeAttr" .. i]:getChildByName("TextCurValue"):setFontSize(16)
		self["_fileNodeAttr" .. i]:getChildByName("TextNextValue"):setFontSize(16)
		self["_fileNodeAttr" .. i]:getChildByName("TextAddValue"):setFontSize(16)

		self["_fileNodeAttr" .. i]:getChildByName("TextNextValue"):setPositionX(118 - 14)
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
	end

	-- 标题
	self._fileNodeDetailTitle:getChildByName("TextTitle"):setPositionY(2)
	self._fileNodeDetailTitle2:getChildByName("TextTitle"):setPositionY(2)
end 

--刷新材料
function HeroTrainAwakeLayer:_updateMaterical()
	self._sameCardNum = 0
	self._fileNodeDetailTitle2:setVisible(not self._isLimit)
	self._fileNodeCost:setVisible(not self._isLimit)
	self._buttonAwake:setEnabled(self._isAllEquip and not self._isLimit)
	self._textCost:setVisible(self._isLimit)
	self._panelCost:removeAllChildren()
	if self._isLimit then
		if not Lang.checkLang(Lang.CN) then
			local size = self._panelCost:getContentSize()
			local UIHelper  = require("yoka.utils.UIHelper")
			local label = UIHelper.createLabel(
				{
					style = "team_2",
					text =  Lang.getImgText("txt_train_breakthroughtop") ,
					position = cc.p(size.width/2, size.height/2) ,
					anchorPoint = cc.p(0.5,0.5),
				}
			)
			self._panelCost:addChild(label)
		else
			local sp = cc.Sprite:create(Path.getText("txt_train_breakthroughtop"))
			local size = self._panelCost:getContentSize()
			sp:setPosition(cc.p(size.width/2, size.height/2))
			self._panelCost:addChild(sp)
		end
		self._textCost:setString(Lang.get("hero_awake_cost_limit_des"))
		return
	end

	self._materialIcons = {}
	self._materialInfo = UserDataHelper.getHeroAwakeMaterials(self._heroUnitData)
	local len = #self._materialInfo
	for i, info in ipairs(self._materialInfo) do
		local node = CSHelper.loadResourceNode(Path.getCSB("CommonCostNode", "common"))
		node:updateView(info)
		local pos = cc.p(MATERIAL_POS[len][i][1], MATERIAL_POS[len][i][2])
		node:setPosition(pos)
		self._panelCost:addChild(node)
		table.insert(self._materialIcons, node)
		if info.type == TypeConvertHelper.TYPE_HERO then
			self._sameCardNum = self._sameCardNum + node:getNeedCount()
		end
	end

	self._costInfo = UserDataHelper.getHeroAwakeCost(self._heroUnitData)
	if self._costInfo then
		self._fileNodeCost:updateUI(self._costInfo.type, self._costInfo.value, self._costInfo.size)
		self._fileNodeCost:setTextColor(Colors.BRIGHT_BG_TWO)
	end
	self:_adjustCostPosAndSize()
end

-- i18n ja change font position
function HeroTrainAwakeLayer:_adjustCostPosAndSize()
	local len = self._panelCost:getChildrenCount()
	for i=1,len do
		local child = self._panelCost:getChildren()[i]
		child:getChildByName("TextName"):setAnchorPoint(cc.p(0.5, 0))
		child:getChildByName("TextName"):setPosition(cc.p(0, 40))

		local size = child:getChildByName("FileNodeIcon"):getChildByName("ImageTemplate"):getContentSize()
		child:getChildByName("NodeNumPos"):getChildren()[1]:setAnchorPoint(cc.p(0.5, 0.5))
		child:getChildByName("NodeNumPos"):setPosition(cc.p(0, -size.height*0.44))  
		child:getChildByName("NodeNumPos"):setScale(18/22)
	end
	self._fileNodeCost:getChildByName("Text"):setFontSize(18)
	self._fileNodeCost:getChildByName("Text"):setPositionX(18 + 15)
	self._fileNodeCost:getChildByName("Image"):setPositionY(18 + 3)
	self._fileNodeCost:getChildByName("Image"):setScale(0.8)

	local width = self._fileNodeCost:getChildByName("Text"):getContentSize().width + 12 + self._fileNodeCost:getChildByName("Image"):getContentSize().width*0.8 			
	width = width*0.5
	self._fileNodeCost:setPositionX(self._buttonAwake:getParent():getPositionX() - width )   
end

function HeroTrainAwakeLayer:_onButtonAwake()
	--检查等级
	local enoughLevel, limitLevel = HeroTrainHelper.checkAwakeIsEnoughLevel(self._heroUnitData)
	if not enoughLevel then
		G_Prompt:showTip(Lang.get("hero_awake_level_not_enough"))
		return
	end

	--检查材料
	for i, icon in ipairs(self._materialIcons) do
		local isReachCondition = icon:isReachCondition()
		if not isReachCondition then
			local info = self._materialInfo[i]
			local popup = require("app.ui.PopupItemGuider").new()
			popup:updateUI(info.type, info.value)
			popup:openWithAction()
			return
		end
	end

	--检查花费
	local isOk = LogicCheckHelper.enoughMoney(self._costInfo.size)
	if not isOk then
		local popup = require("app.ui.PopupItemGuider").new()
		popup:updateUI(self._costInfo.type, self._costInfo.value)
		popup:openWithAction()
		return
	end

	--去觉醒
	local heroId = self._heroUnitData:getId()
	local costHeros = {}
	local sameCards = G_UserData:getHero():getSameCardCountWithBaseId(self._heroUnitData:getBase_id())
	local count = 0
	for k, card in pairs(sameCards) do
		if count >= self._sameCardNum then
			break
		end
		table.insert(costHeros, card:getId())
		count = count + 1
	end
	self:_recordAwakeLevel()
	G_UserData:getHero():c2sHeroAwaken(heroId, costHeros)
	self:setButtonEnable(false)
end

--宝石回调
function HeroTrainAwakeLayer:_onGemstoneCallback(slot, isSynthetic)
	local tempSlot = {slot}
	local slot, composeInfo = self:_getSlotAndCompose()

	if isSynthetic == true and #composeInfo == 0 then
		-- 如果满足条件，则是合成觉醒宝石后的回调，这里不发装备消息，会在_onSyntheticFragments里发，避免发两次
		return
	end

	G_UserData:getHero():c2sHeroEquipAwaken(self._heroUnitData:getId(), tempSlot)
end
  
function HeroTrainAwakeLayer:setButtonEnable(enable)
	self._buttonAwake:setEnabled(enable and self._isAllEquip and not self._isLimit)
	self._buttonAwake:showRedPoint(self._buttonAwake:isEnabled())  -- 策划需求：点完觉醒按钮后，红点立即消失
	--self._pageView:setEnabled(enable)
	-- if self._parentView and self._parentView.setArrowBtnEnable then
	-- 	self._parentView:setArrowBtnEnable(enable)
	-- end
	self._parentView._buttonOneKey:setEnabled(enable) 
end

function HeroTrainAwakeLayer:_heroAwakeSuccess()
	self:_updateData()
	self:_checkAndPlayEffect()
end

function HeroTrainAwakeLayer:_heroEquipAwakeSuccess(eventName, slot)  
	self:_updateData()
	self:_updateGemstone()
	for i, index in ipairs(slot) do
		local icon = self._gemstoneIcons[index]
		if icon then
			icon:playEffect()
		end
	end
	
	self:_playPromptEquipGemstone()
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint(3)
	end
end

function HeroTrainAwakeLayer:_onSyntheticFragments()
	self:_updateData()
	self:_updateGemstone()

	local slot, composeInfo = self:_getSlotAndCompose()
	if #composeInfo == 0 then --都合成完了再一键装备
		self:_doOneKey(slot)
	end
end

function HeroTrainAwakeLayer:_updateFightPower()  
	local param = {heroUnitData = self._heroUnitData}
	local attrInfo = UserDataHelper.getHeroPowerAttr(param)
	local power = AttrDataHelper.getPower(attrInfo)
	self._parentView._parentView._fightPower:updateUI(power)
end

--飘字部分-------------------------------------------
--觉醒成功飘字
function HeroTrainAwakeLayer:_playPrompt()
    local summary = {}

	local content1 = Lang.get("summary_hero_awake_success")
	local param1 = {
		content = content1,
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
	} 
	table.insert(summary, param1)
	

	--属性飘字
	self:_addBaseAttrPromptSummary(summary)

    G_Prompt:showSummary(summary)

	--总战力
	G_Prompt:playTotalPowerSummary(UIConst.SUMMARY_OFFSET_X_TRAIN, -29)
	self._parentView._parentView:updateFightPower()
end

--装备宝石成功飘字
function HeroTrainAwakeLayer:_playPromptEquipGemstone()
	local summary = {}

	local content1 = Lang.get("summary_hero_awake_equip_gemstone_success")
	local param1 = {
		content = content1,
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
	} 
	table.insert(summary, param1)
	
	--属性飘字
	self:_addBaseAttrPromptSummary(summary)

    G_Prompt:showSummary(summary)

	--总战力
	G_Prompt:playTotalPowerSummary(UIConst.SUMMARY_OFFSET_X_TRAIN, -29)
	self._parentView._parentView:updateFightPower()
end

--加入基础属性飘字内容
function HeroTrainAwakeLayer:_addBaseAttrPromptSummary(summary)
	if self == nil or self._recordAttr == nil then
		return  {}
	end

	local attr = self._recordAttr:getAttr()
	local desInfo = TextHelper.getAttrInfoBySort(attr)
	for i, info in ipairs(desInfo) do
		local attrId = info.id
		local diffValue = self._recordAttr:getDiffValue(attrId)
		if diffValue ~= 0 then
			local param = {
				content = AttrDataHelper.getPromptContent(attrId, diffValue),
				anchorPoint = cc.p(0, 0.5),
				startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN+UIConst.SUMMARY_OFFSET_X_ATTR},
				dstPosition = UIHelper.convertSpaceFromNodeToNode(self["_fileNodeAttr"..i], G_SceneManager:getRunningScene()),
				finishCallback = function()
					if self and self._curAttrInfo and self._nextAttrInfo then
						local _, curValue = TextHelper.getAttrBasicText(attrId, self._curAttrInfo[attrId])
						self["_fileNodeAttr"..i]:getSubNodeByName("TextCurValue"):updateTxtValue(curValue)
						self["_fileNodeAttr"..i]:updateInfo(attrId, self._curAttrInfo[attrId], self._nextAttrInfo[attrId], 4)
						self:_adjustFontSizeAndDis()
					end
				end,
			}
			table.insert(summary, param)
		end
	end

	return summary
end

function HeroTrainAwakeLayer:_checkAndPlayEffect()
	local lastLevel = self._lastAwakeLevel
	local curLevel = self._heroUnitData:getAwaken_level()
	local lastStar = UserDataHelper.convertAwakeLevel(lastLevel)
	local curStar = UserDataHelper.convertAwakeLevel(curLevel)
	local isUpStar = curStar > lastStar --是否引起了升星
	self:_playEffect(isUpStar)   
end

function HeroTrainAwakeLayer:_onCommonFinishEffect()
	if self and self._updateShow and self.setButtonEnable then
		self:_updateShow()
		self:_updateGemstone()
		self:_updateLevel()
		self:_updateMaterical()
		self:_playPrompt()
		if self._parentView and self._parentView.checkRedPoint then
			self._parentView:checkRedPoint(3)
			self._parentView:checkRedPoint(4)
		end
		self:setButtonEnable(true)
	end
end

function HeroTrainAwakeLayer:_clearTextSummary()
	local runningScene = G_SceneManager:getRunningScene()
	runningScene:clearTextSummary()
end

function HeroTrainAwakeLayer:_onUpStarFinishEffect()
	if self == nil or self._parentView == nil then
		return
	end

--[[	self:_clearTextSummary()

	local popup = require("app.scene.view.heroTrain.PopupAwakeResult2").new(self, self._heroId)
	popup:openWithAction()

	self:_updateShow()
	self:_updateGemstone()
	self:_updateLevel()
	self:_updateMaterical()
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint()
	end
	self:setButtonEnable(true)]]


	local function eventFunction(event)
		if event == "finish" then
			if self and self._updateShow and self._clearTextSummary and self.setButtonEnable then
				self:_clearTextSummary()

				local popup = require("app.scene.view.heroTrain.PopupAwakeResult2").new(self, self._heroId)
				popup:openWithAction()
				
				self:_updateShow()
				self:_updateGemstone()
				self:_updateLevel()
				self:_updateMaterical()
				if self._parentView and self._parentView.checkRedPoint then
					self._parentView:checkRedPoint()
				end
				self:setButtonEnable(true)
			end
        end
    end
	local gfxEffect = G_EffectGfxMgr:createPlayGfx(self._parentView._nodeAwakeResult, "effect_wujiang_up", eventFunction)
end

function HeroTrainAwakeLayer:_playEffect(isUpStar)
	local onFinishCallback = nil

	if isUpStar then
		onFinishCallback = handler(self, self._onUpStarFinishEffect)
	else
		self._parentView._buttonOneKey:setEnabled(false)  --禁止点击
		onFinishCallback = handler(self, self._onCommonFinishEffect)  
	end

	self:_playCommonEffect(isUpStar, onFinishCallback)
end

function HeroTrainAwakeLayer:_playCommonEffect(isUpStar, callback)

	local function effectFunction(effect)
        return cc.Node:create()
    end

    local function eventFunction(event)
    	if event == "play" then
    		for i = 1, 4 do
    			local icon = self._gemstoneIcons[i]
				local node = icon:getCommonIcon()
				G_EffectGfxMgr:applySingleGfx(node, "smoving_juexing_item_"..i, function()
					node:setVisible(false)
				end, nil, nil)
    		end
        elseif event == "finish" then
			if callback then
				callback()
				
				if self and self._gemstoneIcons then
					-- 恢复icon位置
					for i = 1, 4 do
						local icon = self._gemstoneIcons[i]
						local node = icon:getCommonIcon()
						node:setPosition(47, 39)
					end
				end
        	end
        end
    end  

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._parentView._nodeAwakeEffect, "moving_juexing", effectFunction, eventFunction , false)
	effect:setPosition(cc.p(0-50, 0))

	-- 策划需求：引起升星时， 去掉装备成功的特效 
	self._parentView._nodeAwakeEffect:setOpacity(255)
	if isUpStar then
		self._parentView._nodeAwakeEffect:setOpacity(0)
	end
end

function HeroTrainAwakeLayer:_onButtonPreview()
	local popup = PopupAwakePreview.new(self._heroUnitData)
	popup:openWithAction()
end

function HeroTrainAwakeLayer:_getSlotAndCompose()
	local slot = {}
	local composeInfo = {} --可合成的信息
	local info = UserDataHelper.getHeroAwakeEquipState(self._heroUnitData)
	
	for i = 1, 4 do
		local state = info[i].state
		if state == GemstoneConst.EQUIP_STATE_3 then
			table.insert(composeInfo, {slot = i, id = info[i].needId})
		elseif state == GemstoneConst.EQUIP_STATE_1 then
			table.insert(slot, i)
		end
	end
	return slot, composeInfo
end

function HeroTrainAwakeLayer:_onButtonOneKey()
	local slot, composeInfo = self:_getSlotAndCompose()
	if #composeInfo > 0 then --有能合成的先合成
		for i, info in ipairs(composeInfo) do
			local baseId = info.id
			local config = require("app.config.gemstone").get(baseId)
			assert(config, string.format("gemstone config can not find id = %d", baseId))
			local fragmentId = config.fragment_id
			G_UserData:getFragments():c2sSyntheticFragments(fragmentId, 1)
		end
	else
		self:_doOneKey(slot)
	end
end

function HeroTrainAwakeLayer:_doOneKey(slot)
	if #slot == 0 then
		G_Prompt:showTip(Lang.get("hero_awake_gemstone_empty"))
		return
	end
	G_UserData:getHero():c2sHeroEquipAwaken(self._heroUnitData:getId(), slot)
end

function HeroTrainAwakeLayer:_onButtonTalentDesClicked()
	self._parentView._nodeAwakeTalent:setVisible( not self._parentView._nodeAwakeTalent:isVisible() )
end

-- i18n change lable
function HeroTrainAwakeLayer:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self._parentView._buttonPreview,"Image_2")
		local label = UIHelper.swapWithLabel(image1,{ 
			 style = "limit_1_ja", 
			 text = Lang.getImgText("img_btn_starspreview") ,
		})
		label:getVirtualRenderer():setMaxLineWidth(100)
		label:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER  )
		label:setAnchorPoint(cc.p(0.5, 1))
		label:setPosition(cc.p(29, 17))
		label:getVirtualRenderer():setLineSpacing(-9)

		
		-- 满觉
		self._panelLeader:setVisible(false)
		self._image_des = UIHelper.swapWithLabel(self._image_des,{ 
			style = "team_max_level_ja",  
			text = Lang.getImgText("txt_train_breakthroughtop"),
			offsetY = 0
	   })
	   self._image_des:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER  )
	end
end


-- i18n change lable
function HeroTrainAwakeLayer:_dealPosByI18n()
	do return end
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		for i = 1,4,1 do
			self["_fileNodeAttr"..i]:setNextValueGap(20)
		end
		self._textNewLevel:setPositionX(self._textNewLevel:getPositionX()+20)
		local image449 = UIHelper.seekNodeByName(self,"Image_449")
		image449:setPositionX(image449:getPositionX()+20)
	end
end

 
return HeroTrainAwakeLayer


 