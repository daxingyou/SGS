--
-- Author: Liangxu
-- Date: 2017-03-08 19:47:14
-- 武将升级
local ViewBase = require("app.ui.ViewBase")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local HeroTrainUpgradeLayer = class("HeroTrainUpgradeLayer",  ListViewCellBase)  --ViewBase)  备注：节点类型must是widget。 self要设置contentSize 
local HeroConst = require("app.const.HeroConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local AttributeConst = require("app.const.AttributeConst")
local CSHelper = require("yoka.utils.CSHelper")
local TextHelper = require("app.utils.TextHelper")
local DataConst = require("app.const.DataConst")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local AudioConst = require("app.const.AudioConst")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local UIHelper  = require("yoka.utils.UIHelper")
local UIConst = require("app.const.UIConst")

--需要记录的属性列表（飘字用）
--{属性Id， 对应控件名}
local RECORD_ATTR_LIST = {	
	{AttributeConst.ATK, "_fileNodeAttr1"},
	{AttributeConst.HP, "_fileNodeAttr2"},
	{AttributeConst.PD, "_fileNodeAttr3"},
	{AttributeConst.MD, "_fileNodeAttr4"},
	{AttributeConst.CRIT, nil},
	{AttributeConst.NO_CRIT, nil},
	{AttributeConst.HIT, nil},
	{AttributeConst.NO_HIT, nil},
	{AttributeConst.HURT, nil},
	{AttributeConst.HURT_RED, nil},
}

--材料id对应材料控件索引
local ITEM_ID_2_MATERICAL_INDEX = {
	[DataConst["ITEM_HERO_LEVELUP_MATERIAL_1"]] = 1,
	[DataConst["ITEM_HERO_LEVELUP_MATERIAL_2"]] = 2,
	[DataConst["ITEM_HERO_LEVELUP_MATERIAL_3"]] = 3,
	[DataConst["ITEM_HERO_LEVELUP_MATERIAL_4"]] = 4,
}

function HeroTrainUpgradeLayer:ctor(parentView)
	self._parentView = parentView   -- 不能删  处理特效位置可能用到

	local resource = {
		file = Path.getCSB("HeroTrainUpgradeLayer2", "hero"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonUpgradeOne = {
				events = {{event = "touch", method = "_onButtonUpgradeOneClicked"}},
			},
			_buttonUpgradeFive = {
				events = {{event = "touch", method = "_onButtonUpgradeFiveClicked"}},
			},
		},
	}
	self:setName("HeroTrainUpgradeLayer")
	self:enableNodeEvents()          		 
	HeroTrainUpgradeLayer.super.ctor(self, resource)
end

function HeroTrainUpgradeLayer:onCreate()
	self:_doLayout()
	self:_initData()
	self:_initView()
	-- i18n change lable
	self:_swapImageByI18n()
end

function HeroTrainUpgradeLayer:onEnter()
	--抛出新手事件
	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
	self._signalHeroLevelUp = G_SignalManager:add(SignalConst.EVENT_HERO_LEVELUP, handler(self, self._onHeroLevelUpSuccess))
end

function HeroTrainUpgradeLayer:onExit()
	self._signalHeroLevelUp:remove()
	self._signalHeroLevelUp = nil
	self:_clearTextSummary()
	self._parentView._nodeUpgradeEffect:removeAllChildren()
end

function HeroTrainUpgradeLayer:_doLayout()

	
	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)                   --  设置node节点尺寸
end

function HeroTrainUpgradeLayer:initInfo()
	self:_updateData()
	self:_updateView()
	--self:_reachMaxLevel()  策划需求：改成和国服一样  不显示主公。。。。。
end

function HeroTrainUpgradeLayer:_initData()
	self._limitLevel = 0 --等级限制
	self._limitExp = 0 --限制经验
	self._lastTotalPower = 0 --记录总战力
	self._lastAttrData = {} --记录属性
	self._diffAttrData = {} --记录属性差
	self._lastExp = 0 --记录武将升级经验
	self._lastLevel = 0 --记录武将升级的等级
	self._curAttrData = {} --当前属性数据
	self._nextAttrData = {} --下一级属性数据
	self._materialFakeCount = nil --材料假个数
	self._materialFakeCostCount = nil --材料假的消耗个数
	self._fakeCurExp = 0 --假的当前经验
	self._fakeLevel = 0 --假的等级
	self._fakeCurAttrData = {} --假的当前属性
	self._fakeNextAttrData = {} --假的下一等级数据
	self._costMaterials = {} --记录消耗的材料
	self._isLeader = false --是否主角
	self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst.FUNC_HERO_TRAIN_TYPE1)
end

function HeroTrainUpgradeLayer:_initView()
	self._fileNodeDetailTitle:setFontSize(22)  -- 
	self._fileNodeDetailTitle2:setFontSize(22)  --
	self._fileNodeDetailTitle:setTitle(Lang.get("hero_upgrade_detail_title"))
	self._fileNodeDetailTitle2:setTitle(Lang.get("hero_upgrade_detail_title2"))
	self._buttonUpgradeOne:setString(Lang.get("hero_upgrade_btn_upgrade_1"))
	self._buttonUpgradeFive:setString(Lang.get("hero_upgrade_btn_upgrade_5"))

    for i = 1, 4 do
		local itemId = DataConst["ITEM_HERO_LEVELUP_MATERIAL_"..i]
		self["_fileNodeMaterial"..i]:updateUI(itemId, handler(self, self._onClickMaterialIcon), handler(self, self._onStepClickMaterialIcon))
		self["_fileNodeMaterial"..i]:setStartCallback(handler(self, self._onStartCallback))
		self["_fileNodeMaterial"..i]:setStopCallback(handler(self, self._onStopCallback))

		--换行
		local exp = self["_fileNodeMaterial"..i]:getChildByName("TextValue"):getString()
		local len = string.gsub(exp, "EXP", "EXP\n") 
		self["_fileNodeMaterial"..i]:getChildByName("TextValue"):setString(len)
		self["_fileNodeMaterial"..i]:getChildByName("TextValue"):setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER  )
		self["_fileNodeMaterial"..i]:getChildByName("TextValue"):setFontSize(16)
		self["_fileNodeMaterial"..i]:getChildByName("TextValue"):getVirtualRenderer():setLineSpacing(-5)
		-- local size = self["_fileNodeMaterial"..i]:getChildByName("TextValue"):getContentSize()
		-- self["_fileNodeMaterial"..i]:getChildByName("TextValue"):setTextAreaSize(cc.size(size.width, 40))
		--self["_fileNodeMaterial"..i]:getChildByName("TextValue"):setLineHeight(20)
		self["_fileNodeMaterial"..i]:getChildByName("TextValue"):setPositionY(-53 - 7)
	end
end

function HeroTrainUpgradeLayer:_updateData()
	self._limitLevel = G_UserData:getBase():getLevel() 
	local curHeroId = G_UserData:getHero():getCurHeroId()
	self._heroUnitData = G_UserData:getHero():getUnitDataWithId(curHeroId)
	local heroConfig = self._heroUnitData:getConfig()
	self._isLeader = heroConfig.type == 1
	local templet = heroConfig.lvup_cost
	self._limitExp = UserDataHelper.getHeroNeedExpWithLevel(templet, self._limitLevel) 

	self:_updateAttrData()
	self:_recordAddedLevel()
	self:_recordAddedExp()
	--G_UserData:getAttr():recordPower()
	G_UserData:getAttr():recordPowerWithKey(FunctionConst.FUNC_HERO_TRAIN_TYPE1)
end

function HeroTrainUpgradeLayer:_updateAttrData()
	local config = self._heroUnitData:getConfig()
	local curLevel = self._heroUnitData:getLevel()
	self._curAttrData = UserDataHelper.getBasicAttrWithLevel(config, curLevel)
	self._nextAttrData = UserDataHelper.getBasicAttrWithLevel(config, curLevel + 1)
	self._recordAttr:updateData(self._curAttrData)
end

function HeroTrainUpgradeLayer:_updateView()
	self:_updateBaseInfo()
	self:_updateLoadingBar()
	self:_updateLevel()
	self:_updateAttr()
	self:_updateCost()
end

function HeroTrainUpgradeLayer:_updateBaseInfo()
	local heroBaseId = self._heroUnitData:getBase_id()
	local rankLevel = self._heroUnitData:getRank_lv()
	local limitLevel = self._heroUnitData:getLimit_level()
	local limitRedLevel = self._heroUnitData:getLimit_rtg()
	self._heroTitle:updateUI(self._heroUnitData)
	-- self._fileNodeCountry:updateUI(heroBaseId)
	-- self._fileNodeHeroName:setName(heroBaseId, rankLevel, limitLevel, nil, limitRedLevel)
	--self._fileNodeHeroName2:setName(heroBaseId, rankLevel, limitLevel, nil, limitRedLevel)
	self:setButtonEnable(true)
end

--进度条
function HeroTrainUpgradeLayer:_updateLoadingBar(withAni)
	local level = self._heroUnitData:getLevel()
	--self._textLevel:setString(Lang.get("hero_upgrade_txt_level", {level = level}))
	self._textLevel:setString("LV." .. level)
	
	local heroConfig = self._heroUnitData:getConfig()
	local templet = heroConfig.lvup_cost
	local needCurExp = UserDataHelper.getHeroLevelUpExp(level, templet)
	local nowExp = self._heroUnitData:getExp() - UserDataHelper.getHeroNeedExpWithLevel(templet, level)
	if self._isLeader then
		nowExp = G_UserData:getBase():getExp()
		needCurExp = UserDataHelper.getUserLevelUpExp()
	end
	local percent = nowExp / needCurExp * 100
	self._loadingBarExp:setPercent(percent)

	if withAni then --播滚动动画
		local lastValue = tonumber(self._textExpPercent1:getString())
		if nowExp ~= lastValue then
			self._textExpPercent2:doScaleAnimation()
		end
		self._textExpPercent1:updateTxtValue(nowExp)
	else
		self._textExpPercent1:setString(nowExp)
	end
	self._textExpPercent2:setString("/"..needCurExp)
end

--等级
function HeroTrainUpgradeLayer:_updateLevel()
	local level = self._heroUnitData:getLevel()
	self._textOldLevel1:setString(level)
	self._textOldLevel2:setString("/"..self._limitLevel)
	ccui.Helper:seekNodeByName(self._heroTitle, "Textlevel"):setString("LV." .. level) 
	local posX = self._textOldLevel1:getPositionX()
	local posY = self._textOldLevel1:getPositionY()
	local size1 = self._textOldLevel1:getContentSize()
	self._textOldLevel2:setPosition(cc.p(posX + size1.width, posY))
	
	self._textNewLevel:setString((level+1).."/"..self._limitLevel)
	ccui.Helper:seekNodeByName(self._panelBg, "TextLevel"):setString(Lang.get("hero_transform_result_title_1"))
	self:_updateArrowByI18n()
end

--属性
function HeroTrainUpgradeLayer:_updateAttr()
	self._fileNodeAttr1:updateInfo(AttributeConst.ATK, self._curAttrData[AttributeConst.ATK], self._nextAttrData[AttributeConst.ATK], 2)
	self._fileNodeAttr2:updateInfo(AttributeConst.HP, self._curAttrData[AttributeConst.HP], self._nextAttrData[AttributeConst.HP], 2)
	self._fileNodeAttr3:updateInfo(AttributeConst.PD, self._curAttrData[AttributeConst.PD], self._nextAttrData[AttributeConst.PD], 2)
	self._fileNodeAttr4:updateInfo(AttributeConst.MD, self._curAttrData[AttributeConst.MD], self._nextAttrData[AttributeConst.MD], 4)
	self:_adjustFontSizeAndDis()
end

--花费
function HeroTrainUpgradeLayer:_updateCost()
	if self._isLeader then
		self._panelLeader:setVisible(true)
		self._panelMaterial:setVisible(false)
		self._panelButton:setVisible(false)
		self._textLevel:setVisible(false)
		self._loadingBarExp:getParent():setVisible(false)
	else
		self._panelLeader:setVisible(false)
		self._panelMaterial:setVisible(true)
		self._panelButton:setVisible(true)
		for i = 1, 4 do
			self["_fileNodeMaterial"..i]:updateCount()
		end
	end
end

function HeroTrainUpgradeLayer:_onStartCallback(itemId, count)
	self._materialFakeCount = count
	self._materialFakeCostCount = 0
	self._fakeCurExp = self._heroUnitData:getExp()
	self._fakeLevel = self._heroUnitData:getLevel()
	self._fakeCurAttrData = self._curAttrData
	self._fakeNextAttrData = self._nextAttrData
end

function HeroTrainUpgradeLayer:_onStopCallback()
	--self._labelCount:setVisible(false)
end

function HeroTrainUpgradeLayer:_onStepClickMaterialIcon(itemId, itemValue)
	if self._materialFakeCount <= 0 then
		return false
	end
	if self._fakeCurExp >= self._limitExp then
		return false
	end

	self._materialFakeCount = self._materialFakeCount - 1
	self._materialFakeCostCount = self._materialFakeCostCount + 1
	self._fakeCurExp = self._fakeCurExp + itemValue
	self:_fakeUpdateView(itemId)
	self:_fakePlayEffect(itemId)

	return true
end

--假的刷新界面，根据客户端自己算的数据
function HeroTrainUpgradeLayer:_fakeUpdateView(itemId)
	local heroConfig = self._heroUnitData:getConfig()
	local templet = heroConfig.lvup_cost

	self._fakeLevel = UserDataHelper.getCanReachLevelWithExp(self._fakeCurExp, templet)
	--self._textLevel:setString(Lang.get("hero_upgrade_txt_level", {level = self._fakeLevel}))
	self._textLevel:setString("LV." .. self._fakeLevel)
	--xN
	-- self._labelCount:setString("+"..self._materialFakeCostCount)
	-- self._labelCount:setVisible(self._materialFakeCostCount > 1)


	--进度条
	local needCurExp = UserDataHelper.getHeroLevelUpExp(self._fakeLevel, templet)
	local nowExp = self._fakeCurExp - UserDataHelper.getHeroNeedExpWithLevel(templet, self._fakeLevel)
	local percent = nowExp / needCurExp * 100

	self._loadingBarExp:setPercent(percent)
	self._textExpPercent1:updateTxtValue(nowExp)
	self._textExpPercent2:setString("/"..needCurExp)
	self._textExpPercent2:doScaleAnimation()

	--等级
	self._textOldLevel1:setString(self._fakeLevel)
	self._textOldLevel2:setString("/"..self._limitLevel)
	ccui.Helper:seekNodeByName(self._heroTitle, "Textlevel"):setString("LV." .. self._fakeLevel)
	local posX = self._textOldLevel1:getPositionX()
	local posY = self._textOldLevel1:getPositionY()
	local size1 = self._textOldLevel1:getContentSize()
	self._textOldLevel2:setPosition(cc.p(posX + size1.width, posY))
	self._textNewLevel:setString((self._fakeLevel+1).."/"..self._limitLevel)
	self._textNewLevel:setPositionY(posY - 3) 

	--属性
	self._fakeCurAttrData = UserDataHelper.getBasicAttrWithLevel(heroConfig, self._fakeLevel)
	self._fakeNextAttrData = UserDataHelper.getBasicAttrWithLevel(heroConfig, self._fakeLevel + 1)
	self._fileNodeAttr1:updateInfo(AttributeConst.ATK, self._fakeCurAttrData[AttributeConst.ATK], self._fakeNextAttrData[AttributeConst.ATK], 4)
	self._fileNodeAttr2:updateInfo(AttributeConst.HP, self._fakeCurAttrData[AttributeConst.HP], self._fakeNextAttrData[AttributeConst.HP], 4)
	self._fileNodeAttr3:updateInfo(AttributeConst.PD, self._fakeCurAttrData[AttributeConst.PD], self._fakeNextAttrData[AttributeConst.PD], 4)
	self._fileNodeAttr4:updateInfo(AttributeConst.MD, self._fakeCurAttrData[AttributeConst.MD], self._fakeNextAttrData[AttributeConst.MD], 4)
	self:_adjustFontSizeAndDis()
	--消耗
	local index = ITEM_ID_2_MATERICAL_INDEX[itemId] 
	self["_fileNodeMaterial"..index]:setCount(self._materialFakeCount)
	self:_updateArrowByI18n()
end

function HeroTrainUpgradeLayer:_adjustFontSizeAndDis()
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
end

function HeroTrainUpgradeLayer:_fakePlayEffect(itemId)
	self:_playSingleBallEffect(itemId, true)
end

function HeroTrainUpgradeLayer:_onClickMaterialIcon(materials)
	if self:_checkLimitLevel() == false then
		return
	end
	if self:_checkMaterials(materials) == false then
		return
	end
	self:_doUpgrade(materials)
end

--检查等级限制
function HeroTrainUpgradeLayer:_checkLimitLevel()
	local level = self._heroUnitData:getLevel()
	if level >= self._limitLevel then
		G_Prompt:showTip(Lang.get("hero_upgrade_level_limit_tip"))
		return false
	end
	return true
end

--获取一键升级需要的材料
function HeroTrainUpgradeLayer:_getUpgradeMaterials(level)
	local templet = self._heroUnitData:getConfig().lvup_cost
	local curLevel = self._heroUnitData:getLevel()
	local targetLevel = math.min(curLevel+level, self._limitLevel)
	local curExp = clone(self._heroUnitData:getExp())
	local targetExp = UserDataHelper.getHeroNeedExpWithLevel(templet, targetLevel)

	local materials = {}
	local reach = false --是否达到限制
	for i = 1, 4 do
		local itemId = self["_fileNodeMaterial"..i]:getItemId()
		local expValue = self["_fileNodeMaterial"..i]:getItemValue()
		local count = self["_fileNodeMaterial"..i]:getCount()
		local item = {id = itemId, num = 0}
		for j = 1, count do
			curExp = curExp + expValue
			item.num = item.num + 1
			if curExp >= targetExp then
				reach = true
				break
			end
		end
		if item.num > 0 then
			table.insert(materials, item)
		end
		if reach then
			break
		end
	end

	return materials
end

-- 满级
function HeroTrainUpgradeLayer:_reachMaxLevel()
	local level = self._heroUnitData:getLevel()  	 
	
	if level >= self._limitLevel and not self._isLeader then
		self._panelMaxLevel:setVisible(true)
		self._panelMaterial:setVisible(false)
		self._panelButton:setVisible(false)
		self._panelLeader:setVisible(false)
		self._textLevel:setVisible(false)
		self._loadingBarExp:getParent():setVisible(false)
	end
end

function HeroTrainUpgradeLayer:_onButtonUpgradeOneClicked()
	if self:_checkLimitLevel() == false then
		return
	end

	local materials = self:_getUpgradeMaterials(1)
	if self:_checkMaterials(materials) == false then
		return
	end
	self:_doUpgrade(materials)
	self:setButtonEnable(false)
end

function HeroTrainUpgradeLayer:_onButtonUpgradeFiveClicked()
	if self:_checkLimitLevel() == false then
		return
	end

	local materials = self:_getUpgradeMaterials(5)
	if self:_checkMaterials(materials) == false then
		return
	end
	self:_doUpgrade(materials)
	self:setButtonEnable(false)
end

function HeroTrainUpgradeLayer:_checkMaterials(materials)
	if #materials == 0 then
		local popup = require("app.ui.PopupItemGuider").new()
		popup:updateUI(TypeConvertHelper.TYPE_ITEM, DataConst.ITEM_HERO_LEVELUP_MATERIAL_3)
		popup:openWithAction()
		return false
	else
		return true
	end
end

function HeroTrainUpgradeLayer:_doUpgrade(materials)

	local heroId = self._heroUnitData:getId()
	G_UserData:getHero():c2sHeroLevelUp(heroId, materials)
	self._costMaterials = materials
end

function HeroTrainUpgradeLayer:setButtonEnable(enable)
	self._buttonUpgradeOne:setEnabled(enable)
	self._buttonUpgradeFive:setEnabled(enable)

	--self._pageView:setEnabled(enable)
	-- if self._parentView and self._parentView.setArrowBtnEnable then
	-- 	self._parentView:setArrowBtnEnable(enable)
	-- end
end

function HeroTrainUpgradeLayer:_onHeroLevelUpSuccess()

	self:_updateData()
	self:_updateCost()
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint()
	end


	if self._materialFakeCount == 0 then --如果假球已经飞过了，就不再播球了，直接播剩下的特效和飘字
		self._materialFakeCount = nil
        self:_playExplodeEffect()
		self:_playPrompt()
		self:setButtonEnable(true)
		return
	end

	for i, material in ipairs(self._costMaterials) do
		local itemId = material.id
		if i == #self._costMaterials then --最后一个球，结束时播爆炸特效并飘字
			self:_playSingleBallEffect(itemId, true, true)
		else
			self:_playSingleBallEffect(itemId)
		end
	end
end

--====================================特效部分==========================================
--isPlayFinishEffect,是否播结束特效
--isPlayPrompt,是否结束播飘字
function HeroTrainUpgradeLayer:_playSingleBallEffect(itemId, isPlayFinishEffect, isPlayPrompt)
 
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, itemId)
	local color = param.cfg.color
	local sp = display.newSprite(Path.getBackgroundEffect("img_photosphere"..color))
	local emitter = cc.ParticleSystemQuad:create("particle/particle_touch.plist")
	if emitter then
		emitter:setPosition(cc.p(sp:getContentSize().width / 2, sp:getContentSize().height / 2))
        sp:addChild(emitter)
        emitter:resetSystem()
    end

    local index = ITEM_ID_2_MATERICAL_INDEX[itemId]
    local startPos = UIHelper.convertSpaceFromNodeToNode(self["_fileNodeMaterial"..index], self._parentView)--self)
    sp:setPosition(startPos)
	--self:addChild(sp)
	self._parentView:addChild(sp)
  --  local curSelectedPos = self._parentView:getSelectedPos()
	local curAvatar = self._parentView.avatar   -- self._pageItems[curSelectedPos].avatar 
    local endPos = UIHelper.convertSpaceFromNodeToNode(curAvatar, self._parentView, cc.p(0, 1024*0.4)) --飞到中心点
    local pointPos1 = cc.p(startPos.x, startPos.y + 200)
    local pointPos2 = cc.p((startPos.x + endPos.x) / 2, startPos.y + 100)
    local bezier = {
	    pointPos1,
	    pointPos2,
	    endPos,
	}
	local action1 = cc.BezierTo:create(0.7, bezier)
	local action2 = cc.EaseSineIn:create(action1)
	sp:runAction(cc.Sequence:create(
            action2,
            cc.CallFunc:create(function()
            	if isPlayFinishEffect and self._playExplodeEffect then
            		self:_playExplodeEffect()
            	end
            	if isPlayPrompt and self._playPrompt then
            		self:_playPrompt()
            		self:setButtonEnable(true)	
            	end
            end),
            cc.RemoveSelf:create()
        )
	)
	G_AudioManager:playSoundWithId(AudioConst.SOUND_HERO_LV)
end

function HeroTrainUpgradeLayer:_playExplodeEffect()
 
	local effect1 = EffectGfxNode.new("effect_wujiang_tupojiemian")
	--local effect2 = EffectGfxNode.new("effect_wujianglevelup_light")
	effect1:setAutoRelease(true)
--	effect2:setAutoRelease(true)
	self._parentView._nodeUpgradeEffect:addChild(effect1)    
--	self._parentView._nodeUpgradeEffect:addChild(effect2)
    effect1:play()
  --  effect2:play()
end

--=========================飘字部分========================================

--记录增加的等级
function HeroTrainUpgradeLayer:_recordAddedLevel()
	local level = self._heroUnitData:getLevel()
	self._diffLevel = level - self._lastLevel
	self._lastLevel = level
end

--记录增加的经验
function HeroTrainUpgradeLayer:_recordAddedExp()
	local level = self._heroUnitData:getLevel()
	local heroConfig = self._heroUnitData:getConfig()
	local templet = heroConfig.lvup_cost
	local nowExp = self._heroUnitData:getExp() - UserDataHelper.getHeroNeedExpWithLevel(templet, level)
	if self._isLeader then
		nowExp = G_UserData:getBase():getExp()
	end

	self._diffExp = nowExp - self._lastExp
	self._lastExp = nowExp
end

--转换节点坐标
function HeroTrainUpgradeLayer.convertSpaceFromNodeToNode1(srcNode, tarNode, pos)
	local pos =  pos or cc.p(0,0)
	
	local x, y = srcNode:getChildByName("TextCurValue"):getPosition()
    local worldPos = srcNode:convertToWorldSpace(cc.p(x, y))
    return tarNode:convertToNodeSpace(worldPos)
end

function HeroTrainUpgradeLayer:_playPrompt()
    local summary = {}
    if self._diffLevel == 0 then
    	local content = Lang.get("summary_hero_exp_add", {value = self._diffExp})
    	local param = {
    		content = content,
    		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
    		dstPosition = UIHelper.convertSpaceFromNodeToNode(self._textExpPercent1, G_SceneManager:getRunningScene()),  -- 飞向进度条
    		finishCallback = function()
    			self:_updateLoadingBar(true)
    		end
    	} 
		table.insert(summary, param)
    else
    	local content1 = Lang.get("summary_hero_levelup")
    	local param1 = {
    		content = content1,
    		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
    		dstPosition = UIHelper.convertSpaceFromNodeToNode(self._textOldLevel1, G_SceneManager:getRunningScene()),   -- 飞向新等级
    		finishCallback = function()
    			if self._textOldLevel1 and self._updateLevel then
    				self:_updateLoadingBar(true)
    				self._textOldLevel1:updateTxtValue(self._heroUnitData:getLevel())
    				self:_updateLevel()
    				self:_onSummaryFinish()
    			end
    		end
    	} 
		table.insert(summary, param1)

		--提示可以突破
		local rankMax = UserDataHelper.getHeroBreakMaxLevel(self._heroUnitData)             -- 飞向突破按钮
		if self._heroUnitData:getRank_lv() < rankMax then
			local heroBaseId = self._heroUnitData:getBase_id()
			local limitLevel = self._heroUnitData:getLimit_level()
			local limitRedLevel = self._heroUnitData:getLimit_rtg()
			local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId, nil, nil, limitLevel, limitRedLevel)
			local desNode = self._parentView._buttonUpgrade  --self:getParent():getParent():getSubNodeByName("_nodeTabIcon2")
			local content2 = Lang.get("summary_hero_can_break", {
					name = heroParam.name,
					color = Colors.colorToNumber(heroParam.icon_color),
					outlineColor = Colors.colorToNumber(heroParam.icon_color_outline),
					value = rankMax,
				})
	    	local param2 = {
	    		content = content2,
	    		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
	    		dstPosition = UIHelper.convertSpaceFromNodeToNode(desNode, G_SceneManager:getRunningScene()),
	    	} 
			table.insert(summary, param2)
		end
		

		--属性飘字
		self:_addBaseAttrPromptSummary(summary)
    end

	G_Prompt:showSummary(summary)

	--总战力
	G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_HERO_TRAIN_TYPE1, UIConst.SUMMARY_OFFSET_X_TRAIN, -29)  
	self._parentView._parentView:updateFightPower()
end

--加入基础属性飘字内容
function HeroTrainUpgradeLayer:_addBaseAttrPromptSummary(summary)
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
				dstPosition = self.convertSpaceFromNodeToNode1(self["_fileNodeAttr"..i], G_SceneManager:getRunningScene()), -- 位置不对
 
				finishCallback = function()
					if self and self._curAttrData then
						local _, curValue = TextHelper.getAttrBasicText(attrId, self._curAttrData[attrId])
						self["_fileNodeAttr"..i]:getSubNodeByName("TextCurValue"):updateTxtValue(curValue)
						self["_fileNodeAttr"..i]:updateInfo(attrId, self._curAttrData[attrId], self._nextAttrData[attrId], 4)
						self:_adjustFontSizeAndDis()
					end  
				end,
			}
			table.insert(summary, param)
		end
	end

	return summary
end

--武将升级飘字结束后的回调
function HeroTrainUpgradeLayer:_onSummaryFinish()
	--升级特效结束后，通知新手步骤
	self:runAction(cc.Sequence:create(
			cc.DelayTime:create(0.3),
			cc.CallFunc:create(function()
				G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
			end)
		)
	)
end
 
function HeroTrainUpgradeLayer:_clearTextSummary()
	local runningScene = G_SceneManager:getRunningScene()
	runningScene:clearTextSummary()
end

-- i18n change lable
function HeroTrainUpgradeLayer:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then

		-- 满级
		self._panelMaxLevel:setVisible(false)
		self._image_des = UIHelper.swapWithLabel(self._image_des,{ 
			style = "team_max_level_ja", 
			text = Lang.getImgText("txt_train_breakthroughtop"),
			offsetY = 0
	   })
	   self._image_des:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER  )
	end
end
 

function HeroTrainUpgradeLayer:_updateArrowByI18n()
	if Lang.checkUI("ui4") then
		local arrow = ccui.Helper:seekNodeByName(self, "Image_449")
		local posX1 = self._textOldLevel2:getPositionX()+self._textOldLevel2:getContentSize().width
		local posX2 = self._textNewLevel:getPositionX()
		local posX = (posX2 - posX1)/2
		arrow:setPositionX(posX1+posX)
	end
end

return HeroTrainUpgradeLayer

