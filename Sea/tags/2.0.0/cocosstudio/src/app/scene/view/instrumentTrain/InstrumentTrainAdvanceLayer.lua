--
-- Author: Liangxu
-- Date: 2017-9-18 14:39:38
-- 神兵进阶
local ViewBase = require("app.ui.ViewBase")
local InstrumentTrainAdvanceLayer = class("InstrumentTrainAdvanceLayer", ViewBase)
local InstrumentTrainHelper = require("app.scene.view.instrumentTrain.InstrumentTrainHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local TextHelper = require("app.utils.TextHelper")
local ParameterIDConst = require("app.const.ParameterIDConst")
local CSHelper = require("yoka.utils.CSHelper")
local AttributeConst = require("app.const.AttributeConst")
local DataConst = require("app.const.DataConst")
local InstrumentConst = require("app.const.InstrumentConst")
local AudioConst = require("app.const.AudioConst")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local UIHelper  = require("yoka.utils.UIHelper")
local UIConst = require("app.const.UIConst")
local InstrumentDataHelper = require("app.utils.data.InstrumentDataHelper")

--根据材料数量，定义材料的位置
local MATERIAL_POS = {
	[1] = {{166, 80}},
	[2] = {{57, 80}, {247, 80}},
}
function InstrumentTrainAdvanceLayer:ctor(parentView)
	self._textName = nil --名称
	self._textOldLevel = nil --当前等级
	self._textNewLevel = nil --下一等级
	self._fileNodeAttr1 = nil --属性1
	self._fileNodeAttr2 = nil --属性2
	self._fileNodeAttr3 = nil --属性3
	self._fileNodeAttr4 = nil --属性4
	self._buttonAdvance = nil --进阶按钮
	self._fileNodeSliver = nil --花费

	self._parentView = parentView

	local resource = {
		file = Path.getCSB("InstrumentTrainAdvanceLayer", "instrument"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonAdvance = {
				events = {{event = "touch", method = "_onButtonAdvanceClicked"}},
			},
		},
	}
	InstrumentTrainAdvanceLayer.super.ctor(self, resource)
end

function InstrumentTrainAdvanceLayer:onCreate()
	-- i18n pos lable
	self:_dealPosByI18n()
	self:_initData()
	self:_initView()

	-- i18n change lable
	self:_swapImageByI18n()
end

function InstrumentTrainAdvanceLayer:onEnter()
	self._signalInstrumentLevelup = G_SignalManager:add(SignalConst.EVENT_INSTRUMENT_LEVELUP_SUCCESS, handler(self, self._onLevelupSuccess))

	self:_updateData()
	self:_updateView()
end

function InstrumentTrainAdvanceLayer:onExit()
	self._signalInstrumentLevelup:remove()
	self._signalInstrumentLevelup = nil
end

function InstrumentTrainAdvanceLayer:updateInfo()
	self._parentView:setArrowBtnVisible(true)
	self:_updateData()
	self:_updateView()
end

function InstrumentTrainAdvanceLayer:_initData()
	self._isGlobalLimit = false --是否达到开放等级上限
	self._isReachLimit = false --是否到了该界限突破的时刻

	self._unitData = nil --数据
	self._maxLevel = 0 --可达到的最大等级
	self._enoughMoney = true 	--是否够银币
	self._curAttrData = {} --当前属性
	self._nextAttrData = {} --下级属性
	self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE1)
end

function InstrumentTrainAdvanceLayer:_initView()
	self._smovingZB = nil
	self._fileNodeName:setFontSize(20)
	self._fileNodeName2:setFontSize(22)
	self._buttonAdvance:setString(Lang.get("instrument_advance_btn"))
	self._fileNodeDetailTitle:setFontSize(24)
	self._fileNodeDetailTitle:setTitle(Lang.get("instrument_advance_detail_title"))
	self._fileNodeCostTitle:setFontSize(24)
	self._fileNodeCostTitle:setTitle(Lang.get("instrument_advance_cost_title"))
	self._panelLimit:setVisible(false)
	self:_initPageView()
end

function InstrumentTrainAdvanceLayer:_updateData()
	local curInstrumentId = G_UserData:getInstrument():getCurInstrumentId()
	self._unitData = G_UserData:getInstrument():getInstrumentDataWithId(curInstrumentId)
	local baseId = self._unitData:getBase_id()
	self._isGlobalLimit = false
	self._maxLevel = self._unitData:getAdvanceMaxLevel()
	self:_checkIsReachLimit()
	self:_updateAttrData()
end

function InstrumentTrainAdvanceLayer:_checkIsReachLimit()
	if self._unitData:isCanLimitBreak() then
		local level = self._unitData:getLevel()
		local templateId = self._unitData:getLimitTemplateId()
		local limitLevel = self._unitData:getLimit_level()
		local info = InstrumentDataHelper.getInstrumentRankConfig(templateId, limitLevel)
		self._isReachLimit = level == info.level
	end
end

function InstrumentTrainAdvanceLayer:_updateAttrData()
	self._curAttrData = UserDataHelper.getInstrumentAttrInfo(self._unitData)
	if self._isReachLimit then
		self._nextAttrData = {}
	else
		self._nextAttrData = UserDataHelper.getInstrumentAttrInfo(self._unitData, 1)
		if self._nextAttrData == nil then
			self._nextAttrData = {}
			self._isGlobalLimit = true
		end
	end
	
	self._recordAttr:updateData(self._curAttrData)
	G_UserData:getAttr():recordPower()
end

function InstrumentTrainAdvanceLayer:_createPageItem(i)
	local allInstrumentIds = self._parentView:getAllInstrumentIds()
	local instrumentId = allInstrumentIds[i]
	local unitData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
	local baseId = unitData:getBase_id()
	local limitLevel = unitData:getLimit_level()
	local widget = ccui.Widget:create()
	widget:setSwallowTouches(false)
	widget:setContentSize(self._pageViewSize.width, self._pageViewSize.height)
	local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonInstrumentAvatar", "common"))
	avatar:showShadow(false)
	avatar:updateUI(baseId,limitLevel)
	local size = widget:getContentSize()
	avatar:setPosition(cc.p(size.width / 2, size.height / 2))
	widget:addChild(avatar)

	return widget, avatar
end

function InstrumentTrainAdvanceLayer:_initPageView()
	self._pageItems = {}
	self._pageView:setSwallowTouches(false)
	self._pageView:setScrollDuration(0.3)
	self._pageView:addEventListener(handler(self,self._onPageViewEvent))
	self._pageViewSize = self._pageView:getContentSize()

	self:updatePageView()
end

function InstrumentTrainAdvanceLayer:updatePageView()
	self._smovingZB = nil
	self._pageView:removeAllPages()
	for i, item in ipairs(self._pageItems) do
		item.widget = nil
		item.avatar = nil
	end
	self._pageItems = {}
	local instrumentCount = self._parentView:getInstrumentCount()
    for i = 1, instrumentCount do
    	local widget, avatar = self:_createPageItem(i)
        self._pageView:addPage(widget)
        self._pageItems[i] = {widget = widget, avatar = avatar}
    end
    local selectedPos = self._parentView:getSelectedPos()
    self._pageView:setCurrentPageIndex(selectedPos - 1)
end

function InstrumentTrainAdvanceLayer:_onPageViewEvent(sender,event)
	if event == ccui.PageViewEventType.turning and sender == self._pageView then
		local targetPos = self._pageView:getCurrentPageIndex() + 1
		local selectedPos = self._parentView:getSelectedPos()
		if targetPos ~= selectedPos then
			self._parentView:setSelectedPos(targetPos)
			local allInstrumentIds = self._parentView:getAllInstrumentIds()
			local curInstrumentId = allInstrumentIds[targetPos]
			G_UserData:getInstrument():setCurInstrumentId(curInstrumentId)
			self._parentView:updateArrowBtn()
			self:_updateData()
			self:_updateView()
		end
	end
end

function InstrumentTrainAdvanceLayer:_updateView()
	self:_updateBaseInfo()
	self:_updateLevel()
	self:_updateAttr()
	self:_updateMaterial()
	self:_updateCost()
	self:updatePageView()
end

function InstrumentTrainAdvanceLayer:_updateBaseInfo()
	local baseId = self._unitData:getBase_id()
	local level = self._unitData:getLevel()
	local limitLevel = self._unitData:getLimit_level()

	self._fileNodeName:setName(baseId, level, limitLevel)
	self._fileNodeName2:setName(baseId, level, limitLevel)
	self._fileNodeName2:showTextBg(false)
	local heroBaseId = UserDataHelper.getHeroBaseIdWithInstrumentId(self._unitData:getId())
	if heroBaseId == nil then
		self._textFrom:setVisible(false)
	else
		self._textFrom:setVisible(true)
		local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)
		self._textFrom:setString(Lang.get("instrument_detail_from", {name = heroParam.name}))
	end

	--天赋描述
	self._nodeTalentDesPos:removeAllChildren()
	local instrumentBaseId = UserDataHelper.getInstrumentBaseIdByCheckAvatar(self._unitData)
	local configInfo = require("app.config.instrument").get(instrumentBaseId)
	local templet = self._unitData:getAdvacneTemplateId()
	local unlock = configInfo.unlock
	local unlock1 = configInfo.unlock_1
	local unlock2 = configInfo.unlock_2
	local talentInfo = nil
	if level < unlock then
		local nextLevel, talentName, talentDes = UserDataHelper.findNextInstrumentTalent(level, templet, unlock)
		if nextLevel then
			local advanceDes = Lang.get("instrument_advance_txt_break_des", {rank = nextLevel})
			talentInfo = Lang.get("instrument_advance_txt_talent_des", {
				name = talentName,
				des = talentDes,
				advanceDes = advanceDes,
			})
		else
			local advanceDes = Lang.get("instrument_advance_txt_break_des", {rank = unlock})
			talentInfo = Lang.get("instrument_advance_txt_feature_des", {
				des = configInfo.description,
				advanceDes = advanceDes,
			})
		end
	elseif unlock1 > 0 and level < unlock1 then
		local nextLevel, talentName, talentDes = UserDataHelper.findNextInstrumentTalent(level, templet, unlock1)
		if nextLevel then
			local advanceDes = Lang.get("instrument_advance_txt_break_des", {rank = nextLevel})
			talentInfo = Lang.get("instrument_advance_txt_talent_des", {
				name = talentName,
				des = talentDes,
				advanceDes = advanceDes,
			})
		else
			local advanceDes = Lang.get("instrument_advance_txt_break_des", {rank = unlock1})
			talentInfo = Lang.get("instrument_advance_txt_feature_des", {
				des = configInfo.description_1,
				advanceDes = advanceDes,
			})
		end
	elseif unlock2 > 0 and level < unlock2 then
		local isShow = false
		if self._unitData:isCanLimitBreak() then
			if self._unitData:getLimit_level() > 0 then
				isShow = true
			end
		else
			isShow = true
		end
		if isShow then
			local nextLevel, talentName, talentDes = UserDataHelper.findNextInstrumentTalent(level, templet, unlock2)
			if nextLevel then
				local advanceDes = Lang.get("instrument_advance_txt_break_des", {rank = nextLevel})
				talentInfo = Lang.get("instrument_advance_txt_talent_des", {
					name = talentName,
					des = talentDes,
					advanceDes = advanceDes,
				})
			else
				local advanceDes = Lang.get("instrument_advance_txt_break_des", {rank = unlock2})
				talentInfo = Lang.get("instrument_advance_txt_feature_des", {
					des = configInfo.description_2,
					advanceDes = advanceDes,
				})
			end
		end
	end
	if talentInfo then
		local richText = ccui.RichText:createWithContent(talentInfo)
		richText:setAnchorPoint(cc.p(0.5, 0))
		richText:ignoreContentAdaptWithSize(false)
		richText:setContentSize(cc.size(500,0))
		if Lang.checkLang(Lang.TH) then
			richText:setVerticalSpace(8)
		end
		richText:formatText()
		self._nodeTalentDesPos:addChild(richText)
	end
end

--等级
function InstrumentTrainAdvanceLayer:_updateLevel()
	local level = self._unitData:getLevel()
	local maxLevel = self._maxLevel

	self._textOldLevel1:setString(level)
	self._textOldLevel2:setString("/"..maxLevel)
	local posX = self._textOldLevel1:getPositionX()
	local posY = self._textOldLevel1:getPositionY()
	local size1 = self._textOldLevel1:getContentSize()
	self._textOldLevel2:setPosition(cc.p(posX + size1.width, posY))

	local newDes = Lang.get("equipment_refine_level2", {level = level + 1, maxLevel = maxLevel})
	if self._isGlobalLimit or self._isReachLimit then
		newDes = Lang.get("equipment_refine_max_level")
	end
	self._textNewLevel:setString(newDes)
end

--属性
function InstrumentTrainAdvanceLayer:_updateAttr()
	local desInfo = TextHelper.getAttrInfoBySort(self._curAttrData)
	for i = 1, 4 do
		local info = desInfo[i]
		if info then
			local key = info.id
			local curValue = self._curAttrData[key]
			local nextValue = self._nextAttrData[key]
			self["_fileNodeAttr"..i]:updateInfo(key, curValue, nextValue, 4)
			self["_fileNodeAttr"..i]:setVisible(true)
		else
			self["_fileNodeAttr"..i]:setVisible(false)
		end
	end
end

--材料
function InstrumentTrainAdvanceLayer:_updateMaterial()
	if self._isReachLimit or self._isGlobalLimit then
		self._fileNodeCostTitle:setVisible(false)
		self._panelTip:setVisible(false)
	else
		self._fileNodeCostTitle:setVisible(true)
		self._panelTip:setVisible(true)
	end

	self._materialIcons = {}
	self._panelMaterial:removeAllChildren()
	self._buttonAdvance:setString(Lang.get("instrument_advance_btn"))
	if self._isReachLimit then
		
		-- i18n change lable
		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local size = self._panelMaterial:getContentSize()
		
			local label = nil
			if LogicCheckHelper.funcIsShow(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE2) then
	
				label = UIHelper.createLabel(
					{
						style = "team_1",
						text =  Lang.getImgText("img_team_shenbing") ,
						position = cc.p(size.width/2, size.height/2) ,
						anchorPoint = cc.p(0.5,0.5),
					}
				)
				label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
				self._buttonAdvance:setString(Lang.get("instrument_limit_btn"))
				self._buttonAdvance:setEnabled(true)
			else


				label = UIHelper.createLabel(
					{
						style = "team_2",
						text =  Lang.getImgText("txt_train_breakthroughtop") ,
						position = cc.p(size.width/2, size.height/2) ,
						anchorPoint = cc.p(0.5,0.5),
					}
				)


				self._buttonAdvance:setEnabled(false)
			end
		
		
			
			self._panelMaterial:addChild(label)
		else
			local sp = nil
			if LogicCheckHelper.funcIsShow(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE2) then
				sp = cc.Sprite:create(Path.getTextTeam("img_team_shenbing"))
				self._buttonAdvance:setString(Lang.get("instrument_limit_btn"))
				self._buttonAdvance:setEnabled(true)
			else
				sp = cc.Sprite:create(Path.getText("txt_train_breakthroughtop"))
				self._buttonAdvance:setEnabled(false)
			end
			local size = self._panelMaterial:getContentSize()
			sp:setPosition(cc.p(size.width/2, size.height/2))
			self._panelMaterial:addChild(sp)

		end
		return
	end
	if self._isGlobalLimit then

		-- i18n change lable
		if not Lang.checkLang(Lang.CN) then
			local size = self._panelMaterial:getContentSize()
			local UIHelper  = require("yoka.utils.UIHelper")
			local label = UIHelper.createLabel(
				{
					style = "team_2",
					text =  Lang.getImgText("txt_train_breakthroughtop") ,
					position = cc.p(size.width/2, size.height/2) ,
					anchorPoint = cc.p(0.5,0.5),
				}
			)
			self._panelMaterial:addChild(label)
		else
			local sp = cc.Sprite:create(Path.getText("txt_train_breakthroughtop"))
			local size = self._panelMaterial:getContentSize()
			sp:setPosition(cc.p(size.width/2, size.height/2))
			self._panelMaterial:addChild(sp)
		end
	
		return
	end

	self._materialInfo = UserDataHelper.getInstrumentAdvanceMaterial(self._unitData)
	local len = #self._materialInfo
	for i, info in ipairs(self._materialInfo) do
		local node = CSHelper.loadResourceNode(Path.getCSB("CommonCostNode", "common"))
		node:updateView(info)
		local pos = cc.p(MATERIAL_POS[len][i][1], MATERIAL_POS[len][i][2])
		node:setPosition(pos)
		self._panelMaterial:addChild(node)
		if Lang.checkLang(Lang.TH) then
			local textName = ccui.Helper:seekNodeByName(node, "TextName")
			textName:getVirtualRenderer():setMaxLineWidth(120)
			if len == 2 and i == 1 then
				node:setPositionX(node:getPositionX()-12)
			end
		end
		table.insert(self._materialIcons, node)
	end

	--万能神兵提示
	local baseId = self._unitData:getBase_id()
	local commonId, commonCount = UserDataHelper.getCommonInstrumentIdAndCount(baseId)
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, commonId)
	local count = G_UserData:getItems():getItemNum(commonId)
	local color = count >= commonCount and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_RED
	self._imageMini:loadTexture(param.res_mini)
	self._textMiniCount:setString(count)
	self._textMiniCount:setColor(color)
end

--花费
function InstrumentTrainAdvanceLayer:_updateCost()
	if self._isGlobalLimit then
		self._fileNodeSliver:setVisible(false)
		self._buttonAdvance:setEnabled(false)
		return 
	end
	if self._isReachLimit then
		self._fileNodeSliver:setVisible(false)
		return
	end
	
	local moneyInfo = UserDataHelper.getInstrumentAdvanceMoney(self._unitData)
	self._fileNodeSliver:updateUI(moneyInfo.type, moneyInfo.value, moneyInfo.size)
	self._fileNodeSliver:setTextColor(Colors.BRIGHT_BG_TWO)
	self._fileNodeSliver:setVisible(true)
	self._enoughMoney = LogicCheckHelper.enoughMoney(moneyInfo.size)
	self._buttonAdvance:setEnabled(true)
end

function InstrumentTrainAdvanceLayer:_setButtonEnable(enable)
	self._buttonAdvance:setEnabled(enable and not self._isGlobalLimit and not self._isReachLimit)
	self._pageView:setEnabled(enable)
	if self._parentView and self._parentView.setArrowBtnEnable then
		self._parentView:setArrowBtnEnable(enable)
	end
end

function InstrumentTrainAdvanceLayer:_checkCommonInstrument(name, count)
	local commonId, commonCount = UserDataHelper.getCommonInstrumentIdAndCount(self._unitData:getBase_id())
	local myCount = G_UserData:getItems():getItemNum(commonId)
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, commonId)
	local needCount = count*commonCount
	if myCount < needCount then --拥有的万能神兵不足
		G_Prompt:showTip(Lang.get("instrument_advance_condition_no_enough", {name = name}))
		return false
	end

	local function callback()
		self:_doAdvance()
	end
	local popup = require("app.ui.PopupAlert").new(Lang.get("common_cost_tip_title"), "", callback)
	local des1 = Lang.get("instrument_advance_check_common_1", {name = name, count = needCount, costName = param.name})
	local des2 = Lang.get("instrument_advance_check_common_2")
	local des3 = Lang.get("instrument_advance_check_common_3", {name = param.name, count = myCount})
	local content = {}
	table.insert(content, des1)
	table.insert(content, des2)
	table.insert(content, des3)
	popup:addRichTextList(content)
	self._popupCommonInstrument = popup

	return true
end

function InstrumentTrainAdvanceLayer:_checkMaterial()
	local isUseCommonInstrument = false --是否要使用万能神兵
	for i, icon in ipairs(self._materialIcons) do
		if not icon:isReachCondition() then
			local info = self._materialInfo[i]
			local param = TypeConvertHelper.convert(info.type, info.value)
			if info.type == TypeConvertHelper.TYPE_INSTRUMENT then
				local myCount = icon:getMyCount()
				local needCount = icon:getNeedCount()
				local diffCount = needCount - myCount
				local enough = self:_checkCommonInstrument(param.name, diffCount)
				if not enough then
					return false
				end
			else
				G_Prompt:showTip(Lang.get("instrument_advance_condition_no_enough", {name = param.name}))
				return false
			end
		end
	end

	return true
end

function InstrumentTrainAdvanceLayer:_checkOtherCondition()
	if not self._enoughMoney then
		G_Prompt:showTip(Lang.get("instrument_advance_condition_no_money"))
		return false		
	end
	if self._unitData:getLevel() >= self._maxLevel then
		G_Prompt:showTip(Lang.get("instrument_advance_level_limit_tip"))
		return false
	end
	
	return true
end

function InstrumentTrainAdvanceLayer:_doAdvance()
	local instrumentId = self._unitData:getId()
	G_UserData:getInstrument():c2sInstrumentUpLevel(instrumentId)
	self:_setButtonEnable(false)
end

function InstrumentTrainAdvanceLayer:_onButtonAdvanceClicked()
	if self._isReachLimit then --到了界限突破的时机点，跳转到界限突破
		local isOpen, des = LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE2)
		if not isOpen then
			G_Prompt:showTip(des)
			return
		end

		self._parentView:onClickTabIcon(InstrumentConst.INSTRUMENT_TRAIN_LIMIT)
		return
	end

	self._popupCommonInstrument = nil
	
	local isCan, limitLevel = self._unitData:isCanAdvanced()
	if isCan == false then
		G_Prompt:showTip(Lang.get("instrument_advance_level_tip", {level = limitLevel}))
		return
	end
	local reach = self:_checkMaterial()
	if reach == false then
		return
	end
	if self:_checkOtherCondition() == false then
		return
	end
	if self._popupCommonInstrument then
		self._popupCommonInstrument:openWithAction()
		return
	end

	self:_doAdvance()
end

function InstrumentTrainAdvanceLayer:_onLevelupSuccess()
	self:_playEffect()

	self:_updateData()
	self:_updateBaseInfo()
	self:_updateMaterial()
	self:_updateCost()
end

--播放特效
function InstrumentTrainAdvanceLayer:_playEffect()
	local count2Index = {
		[1] = {1},
		[2] = {2, 3},
	}
	local function effectFunction(effect)
        return cc.Node:create()
    end

    local function eventFunction(event)
    	if event == "play" then
    		for i, info in ipairs(self._materialInfo) do
    			local param = TypeConvertHelper.convert(info.type, info.value)
				local color = param.cfg.color
				local sp = display.newSprite(Path.getBackgroundEffect("img_photosphere"..color))
				local emitter = cc.ParticleSystemQuad:create("particle/particle_touch.plist")
				if emitter then
					emitter:setPosition(cc.p(sp:getContentSize().width / 2, sp:getContentSize().height / 2))
			        sp:addChild(emitter)
			        emitter:resetSystem()
			    end
			    
			    local worldPos = self._materialIcons[i]:convertToWorldSpace(cc.p(0, 0))
				local pos = self:convertToNodeSpace(worldPos)
			    sp:setPosition(pos)
			    self:addChild(sp)
			    local index = count2Index[#self._materialInfo][i]
			    local function finishCallback()
			    	sp:runAction(cc.RemoveSelf:create())
			    end
			    G_EffectGfxMgr:applySingleGfx(sp, "smoving_shenbingjinjie_lizi"..index, finishCallback, nil, nil)
    		end

    		if self._smovingZB and self._parentView:getRangeType() ~= InstrumentConst.INSTRUMENT_RANGE_TYPE_1 then
    			self._smovingZB:reset()
    		end
    		local selectedPos = self._parentView:getSelectedPos()
    		local avatar = self._pageItems[selectedPos].avatar
    		self._smovingZB = G_EffectGfxMgr:applySingleGfx(avatar, "smoving_shenbingjinjie_zhuangbei", nil, nil, nil)
    	elseif event == "next" then
    		self:_setButtonEnable(true)
    	elseif event == "finish" then
    		self:_playPrompt()
        end
    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self, "moving_shenbingjinjie", effectFunction, eventFunction , false)
	local offsetX = require("app.const.UIConst").EFFECT_OFFSET_X
    effect:setPosition(cc.p(G_ResolutionManager:getDesignWidth()*0.5+offsetX, G_ResolutionManager:getDesignHeight()*0.5))
    G_AudioManager:playSoundWithId(AudioConst.SOUND_INSTRUMENT_ADVANCE) --播音效
end

--飘字
function InstrumentTrainAdvanceLayer:_playPrompt()
	local summary = {}

	local param = {
		content = Lang.get("summary_instrument_advance_success"),
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
	} 
	table.insert(summary, param)

    local content1 = Lang.get("summary_instrument_advance_level", {value = 1})
	local param1 = {
		content = content1,
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
		dstPosition = self:_convertToWorldSpace(self._textOldLevel1),
		finishCallback = function()
			if self._textOldLevel1 and self._updateLevel then
				self._textOldLevel1:updateTxtValue(self._unitData:getLevel())
				self:_updateLevel()
			end
			if self._onPromptFinish then
				self:_onPromptFinish()
			end
		end
	} 
	table.insert(summary, param1)

	
	
	--属性飘字
	self:_addBaseAttrPromptSummary(summary)

    G_Prompt:showSummary(summary)

	--总战力
	G_Prompt:playTotalPowerSummary(UIConst.SUMMARY_OFFSET_X_TRAIN)
end

--加入基础属性飘字内容
function InstrumentTrainAdvanceLayer:_addBaseAttrPromptSummary(summary)
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
				dstPosition = self["_fileNodeAttr"..i] and UIHelper.convertSpaceFromNodeToNode(self["_fileNodeAttr"..i], self) or nil,
				finishCallback = function()
					if self["_fileNodeAttr"..i] then
						local _, curValue = TextHelper.getAttrBasicText(attrId, self._curAttrData[attrId])
						self["_fileNodeAttr"..i]:getSubNodeByName("TextCurValue"):updateTxtValue(curValue)
						self["_fileNodeAttr"..i]:updateInfo(attrId, self._curAttrData[attrId], self._nextAttrData[attrId], 4)
					end
				end,
			}
			table.insert(summary, param)
		end
	end

	return summary
end

--飘字结束回调
function InstrumentTrainAdvanceLayer:_onPromptFinish()
	
end

function InstrumentTrainAdvanceLayer:_convertToWorldSpace(node)
	local worldPos = node:convertToWorldSpace(cc.p(0,0))
	return self:convertToNodeSpace(worldPos)
end

-- i18n change lable
function InstrumentTrainAdvanceLayer:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local image1 = UIHelper.seekNodeByName(self._panelLimit,"Image_121")
		UIHelper.swapWithLabel(image1,{
			style = "team_2",
			text =  Lang.getImgText("txt_train_breakthroughtop") ,
		})


	end
end

-- i18n pos lable
function InstrumentTrainAdvanceLayer:_dealPosByI18n()
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
		self._panelTip:setPositionY(self._panelTip:getPositionY()+8)
	end
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local text1 = UIHelper.seekNodeByName(self._panelTip,"Text_1")
		text1:setPositionX(text1:getPositionX()-18)
		self._imageMini:setPositionX(text1:getPositionX()+text1:getContentSize().width+15)
		self._textMiniCount:setPositionX(self._imageMini:getPositionX()+30)
	end
end


return InstrumentTrainAdvanceLayer