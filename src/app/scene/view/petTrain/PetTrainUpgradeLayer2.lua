--
-- Author: hedili
-- Date: 2018-01-30 19:47:14
-- 神兽升级 
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PetTrainUpgradeLayer = class("PetTrainUpgradeLayer", ListViewCellBase)
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
local UIConst = require("app.const.UIConst")
local UTF8 = require("app.utils.UTF8")
local UIHelper  = require("yoka.utils.UIHelper")

--需要记录的属性列表（飘字用）
--{属性Id， 对应控件名}
local RECORD_ATTR_LIST = {	
	{AttributeConst.ATK_FINAL, "_fileNodeAttr1"},
	{AttributeConst.HP_FINAL, "_fileNodeAttr2"},
	{AttributeConst.PD_FINAL, "_fileNodeAttr3"},
	{AttributeConst.MD_FINAL, "_fileNodeAttr4"},
	{AttributeConst.CRIT, nil},
	{AttributeConst.NO_CRIT, nil},
	{AttributeConst.HIT, nil},
	{AttributeConst.NO_HIT, nil},
	{AttributeConst.HURT, nil},
	{AttributeConst.HURT_RED, nil},
}

--材料id对应材料控件索引
local ITEM_ID_2_MATERICAL_INDEX = {
	[DataConst["ITEM_PET_LEVELUP_MATERIAL_1"]] = 1,
	[DataConst["ITEM_PET_LEVELUP_MATERIAL_2"]] = 2,
	[DataConst["ITEM_PET_LEVELUP_MATERIAL_3"]] = 3,
	[DataConst["ITEM_PET_LEVELUP_MATERIAL_4"]] = 4,
}

function PetTrainUpgradeLayer:ctor(parentView)
	self._parentView = parentView

	local resource = {
		file = Path.getCSB("PetTrainUpgradeLayer2", "pet"),
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
	self:enableNodeEvents()  
	self:setName("PetTrainUpgradeLayer")
	PetTrainUpgradeLayer.super.ctor(self, resource)
end

function PetTrainUpgradeLayer:onCreate()
	if not Lang.checkLang(Lang.CN) then
		self:_dealPosByI18n()
	end
	self:_doLayout()
	self:_initData()
	self:_initView()
end

function PetTrainUpgradeLayer:onEnter()
	self._signalPetLevelUp = G_SignalManager:add(SignalConst.EVENT_PET_LEVEL_UP_SUCCESS, handler(self, self._onPetLevelUpSuccess))
end

function PetTrainUpgradeLayer:onExit()
	self._signalPetLevelUp:remove()
	self._signalPetLevelUp = nil
	self:_clearTextSummary()
end

function PetTrainUpgradeLayer:_doLayout()
    local contentSize = self._parentView._listView:getContentSize() --self._panelBg:getContentSize() 
	self:setContentSize(contentSize)                                --  设置node节点尺寸   
end

function PetTrainUpgradeLayer:initInfo()
	self:_updateData()
	self:_updateView() 
end

function PetTrainUpgradeLayer:_initData()
	self._limitLevel = 0 --等级限制
	self._limitExp = 0 --限制经验
	self._lastTotalPower = 0 --记录总战力
	self._diffPower = 0 --战力差值
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
	self._isPageViewMoving = false --pageview是否在拖动过程中
end

function PetTrainUpgradeLayer:_initView()
	self._fileNodeDetailTitle:setFontSize(22)
	self._fileNodeDetailTitle2:setFontSize(22)
	self._fileNodeDetailTitle:setTitle(Lang.get("pet_upgrade_detail_title"))
	self._fileNodeDetailTitle2:setTitle(Lang.get("pet_upgrade_detail_title2"))
	self._buttonUpgradeOne:setFontSize(20)
	self._buttonUpgradeFive:setFontSize(20)
	self._buttonUpgradeOne:setFontName(Path.getFontW8())
	self._buttonUpgradeFive:setFontName(Path.getFontW8())
	self._buttonUpgradeOne:setString(Lang.get("pet_upgrade_btn_upgrade_1"))
	self._buttonUpgradeFive:setString(Lang.get("pet_upgrade_btn_upgrade_5"))
	self._labelCount:setVisible(false)
  

    for i = 1, 4 do
		local itemId = DataConst["ITEM_PET_LEVELUP_MATERIAL_"..i]
		self["_fileNodeMaterial"..i]:updateUI(itemId, handler(self, self._onClickMaterialIcon), handler(self, self._onStepClickMaterialIcon))
		self["_fileNodeMaterial"..i]:setStartCallback(handler(self, self._onStartCallback))
		self["_fileNodeMaterial"..i]:setStopCallback(handler(self, self._onStopCallback))

		--换行
		local exp = self["_fileNodeMaterial"..i]:getChildByName("TextValue"):getString()
		local len = string.gsub(exp, "EXP", "EXP\n") 
		self["_fileNodeMaterial"..i]:getChildByName("TextValue"):setString(len)
		self["_fileNodeMaterial"..i]:getChildByName("TextValue"):setFontSize(16)
		self["_fileNodeMaterial"..i]:getChildByName("TextValue"):getVirtualRenderer():setLineSpacing(2)
		self["_fileNodeMaterial"..i]:getChildByName("TextValue"):setPositionY(-53 - 7)
	end
end

function PetTrainUpgradeLayer:_updateData()
	self._limitLevel = G_UserData:getBase():getLevel() 
	local curPetId = G_UserData:getPet():getCurPetId()
	self._petUnitData = G_UserData:getPet():getUnitDataWithId(curPetId)
	local petConfig = self._petUnitData:getConfig()

	local templet =  self._petUnitData:getLvUpCost()
	local realQuality = UserDataHelper.getPetUpgradeQuality(self._petUnitData)
	self._limitExp = UserDataHelper.getPetNeedExpWithLevel(G_UserData:getBase():getLevel() , realQuality)

	self:_updateAttrData()
	self:_recordAddedLevel()
	self:_recordAddedExp()
	self:_recordTotalPower()
end

function PetTrainUpgradeLayer:_updateAttrData()
	local config = self._petUnitData:getConfig()
	local curLevel = self._petUnitData:getLevel()
	self._curAttrData = UserDataHelper.getPetBasicAttrWithLevel(config, curLevel)
	self._nextAttrData = UserDataHelper.getPetBasicAttrWithLevel(config, curLevel + 1)
	self:_recordBaseAttr()
end

function PetTrainUpgradeLayer:_updateView()
	self:_updateBaseInfo()
	self:_updateLoadingBar()
	self:_updateLevel()
	self:_updateAttr()
	self:_updateCost()
end

function PetTrainUpgradeLayer:_updateBaseInfo()
	local petBaseId = self._petUnitData:getBase_id()

	--self._fileNodeHeroName:setConvertType(TypeConvertHelper.TYPE_PET)
	-- self._fileNodeHeroName2:setConvertType(TypeConvertHelper.TYPE_PET)
	-- --self._fileNodeHeroName:setName(petBaseId, 0)
	-- self._fileNodeHeroName2:setFontSize(18)
	-- self._fileNodeHeroName2:setName(petBaseId, 0)
	self._nodeTitle:setName(5)

	self:setButtonEnable(true)

    local strDesc = UserDataHelper.getPetStateStr(self._petUnitData)
	-- if strDesc then
	-- 	self._textIsBless:setString(strDesc)
	-- 	self._textIsBless:setVisible(true)
	-- else
	-- 	self._textIsBless:setVisible(false)
	-- end
	
end

--进度条
function PetTrainUpgradeLayer:_updateLoadingBar(withAni)
	local level = self._petUnitData:getLevel()
	self._textLevel:setString(Lang.get("player_level_up")) 
	self._textLevel2:setString(level)

	local petConfig = self._petUnitData:getConfig()
	-- local templet = self._petUnitData:getQuality()
	local realQuality = UserDataHelper.getPetUpgradeQuality(self._petUnitData)
	local needCurExp = UserDataHelper.getPetLevelUpExp(level, realQuality)
	local nowExp = self._petUnitData:getExp() - UserDataHelper.getPetNeedExpWithLevel(level,realQuality)

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
function PetTrainUpgradeLayer:_updateLevel()
	local level = self._petUnitData:getLevel()
	self._textOldLevel1:setString(level)
	self._textOldLevel2:setString("/"..self._limitLevel)
	local posX = self._textOldLevel1:getPositionX()
	local posY = self._textOldLevel1:getPositionY()
	local size1 = self._textOldLevel1:getContentSize()
	self._textOldLevel2:setPosition(cc.p(posX + size1.width, posY))
	
	self._textNewLevel:setString((level+1).."/"..self._limitLevel)
end

--属性
function PetTrainUpgradeLayer:_updateAttr()
	self._fileNodeAttr1:updateInfo(AttributeConst.ATK_FINAL, self._curAttrData[AttributeConst.ATK_FINAL], self._nextAttrData[AttributeConst.ATK_FINAL], 4)
	self._fileNodeAttr2:updateInfo(AttributeConst.HP_FINAL, self._curAttrData[AttributeConst.HP_FINAL], self._nextAttrData[AttributeConst.HP_FINAL], 4)
	self._fileNodeAttr3:updateInfo(AttributeConst.PD_FINAL, self._curAttrData[AttributeConst.PD_FINAL], self._nextAttrData[AttributeConst.PD_FINAL], 4)
	self._fileNodeAttr4:updateInfo(AttributeConst.MD_FINAL, self._curAttrData[AttributeConst.MD_FINAL], self._nextAttrData[AttributeConst.MD_FINAL], 4)
	self:_adjustFontSizeAndDis()
end

function PetTrainUpgradeLayer:_adjustFontSizeAndDis()
	for i=1,4 do
		self["_fileNodeAttr" .. i]:getChildByName("TextName"):setFontSize(18)
		self["_fileNodeAttr" .. i]:getChildByName("TextCurValue"):setFontSize(16)
		self["_fileNodeAttr" .. i]:getChildByName("TextNextValue"):setFontSize(16)
		self["_fileNodeAttr" .. i]:getChildByName("TextAddValue"):setFontSize(16)

		self["_fileNodeAttr" .. i]:getChildByName("TextNextValue"):setPositionX(118 - 14)
		self["_fileNodeAttr" .. i]:getChildByName("TextName"):setPositionX(0 + 18)
		self["_fileNodeAttr" .. i]:getChildByName("TextCurValue"):setPositionX(13 + 6)

		self["_fileNodeAttr" .. i]:getChildByName("ImageUpArrow"):setPositionX(201 - 7)

		-- 替换中间空格
		local strDes = self["_fileNodeAttr" .. i]:getChildByName("TextName"):getString()
		if string.find(strDes," ") then
			strDes = string.gsub(strDes, " ", "") 
			self["_fileNodeAttr" .. i]:getChildByName("TextName"):setString(strDes)
		end

		-- 血量特殊处理
		if i == 2 then
			self["_fileNodeAttr" .. i]:getChildByName("TextName"):setPositionX(14+3)
			self["_fileNodeAttr" .. i]:getChildByName("TextName"):setString("      P:")    --Hp去掉H
		end

		-- 调整2个字中间间距
		local UTF8 = require("app.utils.UTF8")
		local str = self["_fileNodeAttr" .. i]:getChildByName("TextName"):getString()
		local len = UTF8.utf8len(str)
		if len == 3 then
			str = UTF8.utf8sub(str, 1, 1) .. "    " .. UTF8.utf8sub(str, 2, 2).. ":"
			self["_fileNodeAttr" .. i]:getChildByName("TextName"):setString(str)
		end
	end
end

--花费
function PetTrainUpgradeLayer:_updateCost()	
	self._panelLeader:setVisible(false)
	self._panelMaterial:setVisible(true)
	self._panelButton:setVisible(true)
	for i = 1, 4 do
		self["_fileNodeMaterial"..i]:updateCount()

		local str = self["_fileNodeMaterial"..i]:getChildByName("TextValue"):getString()
	 	str = string.gsub(str, "\n", "") 
		local str1 = UTF8.utf8sub(str, 1, 3)
		local str2 = UTF8.utf8sub(str, 4, UTF8.utf8len(str))
		str = str1 .. "\n" .. str2
		self["_fileNodeMaterial"..i]:getChildByName("TextValue"):setString(str)
	end

end

function PetTrainUpgradeLayer:_onStartCallback(itemId, count)
	self._materialFakeCount = count
	self._materialFakeCostCount = 0
	self._fakeCurExp = self._petUnitData:getExp()
	self._fakeLevel = self._petUnitData:getLevel()
	self._fakeCurAttrData = self._curAttrData
	self._fakeNextAttrData = self._nextAttrData
end

function PetTrainUpgradeLayer:_onStopCallback()
	self._labelCount:setVisible(false)
end

function PetTrainUpgradeLayer:_onStepClickMaterialIcon(itemId, itemValue)
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
function PetTrainUpgradeLayer:_fakeUpdateView(itemId)
	local petConfig = self._petUnitData:getConfig()
	-- local templet = self._petUnitData:getLvUpCost()
	local realQuality = UserDataHelper.getPetUpgradeQuality(self._petUnitData)

	self._fakeLevel = UserDataHelper.getPetCanReachLevelWithExp(self._fakeCurExp, realQuality)
	self._textLevel:setString(Lang.get("hero_upgrade_txt_level", {level = self._fakeLevel}))

	--xN
	self._labelCount:setString("+"..self._materialFakeCostCount)
	self._labelCount:setVisible(self._materialFakeCostCount > 1)

	--进度条
	local needCurExp = UserDataHelper.getPetLevelUpExp(self._fakeLevel, realQuality)

	local nowExp = self._fakeCurExp - UserDataHelper.getPetNeedExpWithLevel(self._fakeLevel ,realQuality)
	local percent = nowExp / needCurExp * 100
	self._loadingBarExp:setPercent(percent)
	self._textExpPercent1:updateTxtValue(nowExp)
	self._textExpPercent2:setString("/"..needCurExp)
	self._textExpPercent2:doScaleAnimation()

	--等级
	self._textOldLevel1:setString(self._fakeLevel)
	self._textOldLevel2:setString("/"..self._limitLevel)
	local posX = self._textOldLevel1:getPositionX()
	local posY = self._textOldLevel1:getPositionY()
	local size1 = self._textOldLevel1:getContentSize()
	self._textOldLevel2:setPosition(cc.p(posX + size1.width, posY))
	self._textNewLevel:setString((self._fakeLevel+1).."/"..self._limitLevel)

	--属性
	self._fakeCurAttrData = UserDataHelper.getPetBasicAttrWithLevel(petConfig, self._fakeLevel)
	self._fakeNextAttrData = UserDataHelper.getPetBasicAttrWithLevel(petConfig, self._fakeLevel + 1)
	self._fileNodeAttr1:updateInfo(AttributeConst.ATK_FINAL, self._fakeCurAttrData[AttributeConst.ATK_FINAL], self._fakeNextAttrData[AttributeConst.ATK_FINAL], 4)
	self._fileNodeAttr2:updateInfo(AttributeConst.HP_FINAL, self._fakeCurAttrData[AttributeConst.HP_FINAL], self._fakeNextAttrData[AttributeConst.HP_FINAL], 4)
	self._fileNodeAttr3:updateInfo(AttributeConst.PD_FINAL, self._fakeCurAttrData[AttributeConst.PD_FINAL], self._fakeNextAttrData[AttributeConst.PD_FINAL], 4)
	self._fileNodeAttr4:updateInfo(AttributeConst.MD_FINAL, self._fakeCurAttrData[AttributeConst.MD_FINAL], self._fakeNextAttrData[AttributeConst.MD_FINAL], 4)
	self:_adjustFontSizeAndDis()

	--消耗
	local index = ITEM_ID_2_MATERICAL_INDEX[itemId]
	self["_fileNodeMaterial"..index]:setCount(self._materialFakeCount)
end

function PetTrainUpgradeLayer:_fakePlayEffect(itemId)
	self:_playSingleBallEffect(itemId, true)
end

function PetTrainUpgradeLayer:_onClickMaterialIcon(materials)
	if self:_checkLimitLevel() == false then
		return
	end
	
	self:_doUpgrade(materials)
end

--检查等级限制
function PetTrainUpgradeLayer:_checkLimitLevel()
	local level = self._petUnitData:getLevel()
	if level >= self._limitLevel then
		G_Prompt:showTip(Lang.get("pet_upgrade_level_limit_tip"))
		return false
	end
	return true
end

--获取一键升级需要的材料
function PetTrainUpgradeLayer:_getUpgradeMaterials(level)
	-- local templet = self._petUnitData:getLvUpCost()
	local realQuality = UserDataHelper.getPetUpgradeQuality(self._petUnitData)
	local curLevel = self._petUnitData:getLevel()
	local targetLevel = math.min(curLevel+level, self._limitLevel)
	local curExp = clone(self._petUnitData:getExp())
	local targetExp = UserDataHelper.getPetNeedExpWithLevel(targetLevel ,realQuality)

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

function PetTrainUpgradeLayer:_onButtonUpgradeOneClicked()
	if self:_checkLimitLevel() == false then
		return
	end

	local materials = self:_getUpgradeMaterials(1)
	self:_doUpgrade(materials)
	self:setButtonEnable(false)
end

function PetTrainUpgradeLayer:_onButtonUpgradeFiveClicked()
	if self:_checkLimitLevel() == false then
		return
	end

	local materials = self:_getUpgradeMaterials(5)
	self:_doUpgrade(materials)
	self:setButtonEnable(false)
end

function PetTrainUpgradeLayer:_doUpgrade(materials)
	if #materials == 0 then
		local popup = require("app.ui.PopupItemGuider").new()
		popup:updateUI(TypeConvertHelper.TYPE_ITEM, DataConst.ITEM_PET_LEVELUP_MATERIAL_3)
		popup:openWithAction()
		return
	end

	local petId = self._petUnitData:getId()
	G_UserData:getPet():c2sPetLevelUp(petId, materials)
	self._costMaterials = materials
end

function PetTrainUpgradeLayer:setButtonEnable(enable)
	self._buttonUpgradeOne:setEnabled(enable)
	self._buttonUpgradeFive:setEnabled(enable)
end

function PetTrainUpgradeLayer:_onPetLevelUpSuccess()
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
function PetTrainUpgradeLayer:_playSingleBallEffect(itemId, isPlayFinishEffect, isPlayPrompt)
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
	--local startPos = self:_convertToWorldSpace(self["_fileNodeMaterial"..index])
	local startPos = UIHelper.convertSpaceFromNodeToNode(self["_fileNodeMaterial" .. index], self._parentView._parentView) --self)
    sp:setPosition(startPos)
    --self:addChild(sp)
	self._parentView._parentView:addChild(sp)
	--local posIndex = self._parentView:getSelectedPos()
	local curAvatar = self:_getAvatar()   -- self._pageItems[posIndex].avatar
    local endPos = UIHelper.convertSpaceFromNodeToNode(curAvatar, self._parentView._parentView) --飞到中心点
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

function PetTrainUpgradeLayer:_playExplodeEffect()
	local effect1 = EffectGfxNode.new("effect_wujianglevelup_baozha")
	local effect2 = EffectGfxNode.new("effect_wujianglevelup_light")
	effect1:setAutoRelease(true)
	effect2:setAutoRelease(true)
	self._parentView._nodeEffect:addChild(effect1) 
	self._parentView._nodeEffect:addChild(effect2)  
    effect1:play()
    effect2:play()
end

--=========================飘字部分========================================
--记录总战力
function PetTrainUpgradeLayer:_recordTotalPower()
	local totalPower = G_UserData:getBase():getPower()
	self._diffPower = totalPower - self._lastTotalPower
	self._lastTotalPower = totalPower
end

--记录增加的等级
function PetTrainUpgradeLayer:_recordAddedLevel()
	local level = self._petUnitData:getLevel()
	self._diffLevel = level - self._lastLevel
	self._lastLevel = level
end

--记录增加的经验
function PetTrainUpgradeLayer:_recordAddedExp()
	local level = self._petUnitData:getLevel()
	local petConfig = self._petUnitData:getConfig()
	local templet = self._petUnitData:getLvUpCost()
	local realQuality = UserDataHelper.getPetUpgradeQuality(self._petUnitData)
	local nowExp = self._petUnitData:getExp() - UserDataHelper.getPetNeedExpWithLevel(level, realQuality)


	self._diffExp = nowExp - self._lastExp
	self._lastExp = nowExp
end

--记录基础属性
function PetTrainUpgradeLayer:_recordBaseAttr()
	local diffAttrData = {}
	for i, one in ipairs(RECORD_ATTR_LIST) do
		local id = one[1]
		local lastValue = self._lastAttrData[id] or 0
		local curValue = self._curAttrData[id] or 0
		local diffValue = curValue - lastValue
		diffAttrData[id] = diffValue
	end

	self._diffAttrData = diffAttrData
	self._lastAttrData = self._curAttrData
end

function PetTrainUpgradeLayer:_playPrompt()
    local summary = {}
    if self._diffLevel == 0 then
    	local content = Lang.get("summary_pet_exp_add", {value = self._diffExp})
    	local param = {
    		content = content,
    		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
			--dstPosition = self:_convertToWorldSpace(self._textExpPercent1),
			dstPosition = UIHelper.convertSpaceFromNodeToNode(self._textExpPercent1, G_SceneManager:getRunningScene()),  -- 飞向进度条
    		finishCallback = function()
    			self:_updateLoadingBar(true)
    		end
    	} 
		table.insert(summary, param)
    else
    	local content1 = Lang.get("summary_pet_levelup")
    	local param1 = {
    		content = content1,
    		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
			--dstPosition = self:_convertToWorldSpace(self._textOldLevel1),
			dstPosition = UIHelper.convertSpaceFromNodeToNode(self._textOldLevel1, G_SceneManager:getRunningScene()),   -- 飞向新等级
    		finishCallback = function()
    			if self._textOldLevel1 and self._updateLevel then
    				self:_updateLoadingBar(true)
    				self._textOldLevel1:updateTxtValue(self._petUnitData:getLevel())
    				self:_updateLevel()
    				self:_onSummaryFinish()
    			end
    		end
    	} 
		table.insert(summary, param1)

		--提示可以突破
		local canBreakMax = UserDataHelper.getPetBreakMaxLevel(self._petUnitData)
		if self._petUnitData:getStar() < canBreakMax then
			local petBaseId = self._petUnitData:getBase_id()
			local petParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_PET, petBaseId)
			local desNode = self._parentView._buttonUpgrade --self:getParent():getParent():getSubNodeByName("_nodeTabIcon2")
			local content2 = Lang.get("summary_pet_can_break", {
					name = petParam.name,
					color = Colors.colorToNumber(petParam.icon_color),
					outlineColor = Colors.colorToNumber(petParam.icon_color_outline),
					value = canBreakMax,
				})
	    	local param2 = {
	    		content = content2,
	    		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
				--dstPosition = self:_convertToWorldSpace(desNode),
				dstPosition = UIHelper.convertSpaceFromNodeToNode(desNode, G_SceneManager:getRunningScene()),
	    	} 
			table.insert(summary, param2)
		end
		

		--属性飘字
		self:_addBaseAttrPromptSummary(summary)
    end

    G_Prompt:showSummary(summary)

	--总战力
	local totalPower = G_UserData:getBase():getPower()
	local node = CSHelper.loadResourceNode(Path.getCSB("CommonPowerPrompt", "common"))
	node:updateUI(totalPower, self._diffPower)
	node:play(UIConst.SUMMARY_OFFSET_X_TRAIN, 0)
end

--加入基础属性飘字内容
function PetTrainUpgradeLayer:_addBaseAttrPromptSummary(summary)
	for i, one in ipairs(RECORD_ATTR_LIST) do
		local attrId = one[1]
		local dstNodeName = one[2]
		local diffValue = self._diffAttrData[attrId]
		if diffValue ~= 0 then
			local absValue = math.abs(diffValue)
			local attrName, attrValue = TextHelper.getAttrBasicText(attrId, absValue)
			local color = diffValue >= 0 and Colors.colorToNumber(Colors.getColor(2)) or Colors.colorToNumber(Colors.getColor(6))
			local outlineColor = diffValue >= 0 and Colors.colorToNumber(Colors.getColorOutline(2)) or Colors.colorToNumber(Colors.getColorOutline(6))
			attrValue = diffValue >= 0 and " + "..attrValue or " - "..attrValue
			local param = {
				content = Lang.get("summary_attr_change", {attr = attrName..attrValue, color = color, outlineColor = outlineColor}),
				anchorPoint = cc.p(0, 0.5),
				startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN+UIConst.SUMMARY_OFFSET_X_ATTR},
				dstPosition = dstNodeName and self:_convertToWorldSpace(self[dstNodeName]) or nil,
				finishCallback = function()
					if dstNodeName and self[dstNodeName] and attrId then
						self[dstNodeName]:getSubNodeByName("TextCurValue"):updateTxtValue(self._curAttrData[attrId])
						self[dstNodeName]:updateInfo(attrId, self._curAttrData[attrId], self._nextAttrData[attrId], 4)  
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
function PetTrainUpgradeLayer:_onSummaryFinish()
	--升级特效结束后，通知新手步骤
	self:runAction(cc.Sequence:create(
			cc.DelayTime:create(0.3),
			cc.CallFunc:create(function()
				G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
			end)
		)
	)
end

--
function PetTrainUpgradeLayer:_clearTextSummary()
	local runningScene = G_SceneManager:getRunningScene()
	runningScene:clearTextSummary()
end

function PetTrainUpgradeLayer:_convertToWorldSpace(node, pos)
	local pos = pos or cc.p(0,0)
	local worldPos = node:convertToWorldSpace(pos)
	--return self:convertToNodeSpace(worldPos)
	return G_SceneManager:getRunningScene():convertToNodeSpace(worldPos)
end

function PetTrainUpgradeLayer:_getAvatar()
	if self._parentView then
		return self._parentView:getPetAvatar()
	end

	return nil 
end

-- i18n pos lable
function PetTrainUpgradeLayer:_dealPosByI18n()
	if Lang.checkLang(Lang.JA) then
		return 
	end   

	if not Lang.checkLang(Lang.CN) then
		local image449 = UIHelper.seekNodeByName(self._panelDesign,"Panel_2","Panel_156","Image_449")
		image449:setPositionX(image449:getPositionX()+12)

		self._textNewLevel:setPositionX(self._textNewLevel:getPositionX()+10)
		for i = 1, 4 do
			self["_fileNodeAttr"..i]:setNextValueGap(10)
		end
		
	end
end


return PetTrainUpgradeLayer