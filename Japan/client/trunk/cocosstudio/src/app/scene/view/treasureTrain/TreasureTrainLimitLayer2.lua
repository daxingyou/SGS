--
-- Author: Liangxu
-- Date: 2018-12-27
-- 宝物界限突破
local ViewBase = require("app.ui.ViewBase")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local TreasureTrainLimitLayer = class("TreasureTrainLimitLayer", ListViewCellBase)
local TreasureConst = require("app.const.TreasureConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local TreasureLimitCostNode = require("app.scene.view.treasureTrain.TreasureLimitCostNode")
local TreasureDataHelper = require("app.utils.data.TreasureDataHelper")
local TextHelper = require("app.utils.TextHelper")
local TreasureLimitCostPanel = require("app.scene.view.treasureTrain.TreasureLimitCostPanel")
local UIHelper = require("yoka.utils.UIHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local UIConst = require("app.const.UIConst")
local DataConst = require("app.const.DataConst")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local PopupTreasureLimitDetail = require("app.scene.view.treasureTrain.PopupTreasureLimitDetail")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local TreasureTrainHelper = require("app.scene.view.treasureTrain.TreasureTrainHelper")

local ZORDER_COMMON = 0
local ZORDER_MID = 1
local ZORDER_MOVE = 2

function TreasureTrainLimitLayer:ctor(parentView)
	self._parentView = parentView

	local resource = {
		file = Path.getCSB("TreasureTrainLimitLayer2", "treasure"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonBreak = {
				events = {{event = "touch", method = "_onButtonBreak"}},
			},
			-- _buttonDetail = {
			-- 	events = {{event = "touch", method = "_onButtonDetail"}}
			-- }
		},
	}
	self:enableNodeEvents()   
	TreasureTrainLimitLayer.super.ctor(self, resource)
end

function TreasureTrainLimitLayer:onCreate()
	self:_doLayout()
	-- i18n change to lable
	if not Lang.checkLang(Lang.CN) then
		self:_swapImageByI18n()
	end
	--i18n
	self:_dealByI18n()
	self:_initData()
	self:_initView()
end

function TreasureTrainLimitLayer:onEnter()
	self._signalTreasureLimitLvPutRes = G_SignalManager:add(SignalConst.EVENT_TREASURE_LIMIT_LV_PUT_RES, handler(self, self._onTreasureLimitLvPutRes))
	self._signalTreasureLimitSuccess = G_SignalManager:add(SignalConst.EVENT_TREASURE_LIMIT_SUCCESS, handler(self, self._onTreasureLimitSuccess))

	self:_updateData()
	self:_updateView()
end

function TreasureTrainLimitLayer:onExit()
	self._signalTreasureLimitLvPutRes:remove()
	self._signalTreasureLimitLvPutRes = nil
	self._signalTreasureLimitSuccess:remove()
	self._signalTreasureLimitSuccess = nil
end

function TreasureTrainLimitLayer:_doLayout()
    local contentSize = self._parentView._listView:getContentSize() --self._panelBg:getContentSize() 
	self:setContentSize(contentSize)                                --  设置node节点尺寸   
end

function TreasureTrainLimitLayer:updateInfo()
	--self._parentView:setArrowBtnVisible(false)
	self:_updateData()
	self:_updateView()
	self:_playFire(true)
end

function TreasureTrainLimitLayer:_initData()
	self._costMaterials = {} --记录消耗的材料
	self._materialMaxSize = { --每种材料最大值
		[TreasureConst.TREASURE_LIMIT_COST_KEY_1] = 0,
		[TreasureConst.TREASURE_LIMIT_COST_KEY_2] = 0,
		[TreasureConst.TREASURE_LIMIT_COST_KEY_3] = 0,
		[TreasureConst.TREASURE_LIMIT_COST_KEY_4] = 0,
	}
	self._silverCost = 0

	self._materialFakeCount = nil --材料假个数
	self._materialFakeCostCount = nil --材料假的消耗个数
	self._materialFakeCurSize = 0

	self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst.FUNC_TREASURE_TRAIN_TYPE4)
end

function TreasureTrainLimitLayer:_initView()
	self._popupPanel = nil

	--self._imgBg = ccui.Helper:seekNodeByName(self, "Image_181")
	self._textNameTop = ccui.Helper:seekNodeByName(self, "_textNameTop")

	self._parentView._buttonShow:updateUI(FunctionConst.FUNC_TREASURE_TRAIN_TYPE4)
	self._buttonBreak:setString(Lang.get("treasure_limit_break_btn"))
	self._buttonBreak:setFontSize(20)
	self._buttonBreak:setFontName(Path.getFontW8())
	self._nodeTreasure:setLocalZOrder(ZORDER_MID)
	self._nodeTreasure:showShadow(false)
	for key = TreasureConst.TREASURE_LIMIT_COST_KEY_1, TreasureConst.TREASURE_LIMIT_COST_KEY_4 do
		self["_cost"..key] = TreasureLimitCostNode.new(self["_costNode"..key], key, handler(self, self._onClickCostAdd))
	end
	self._nodeSilver:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_GOLD)
	--	self._nodeSilver:setTextColorToDTypeColor()
	self._nodeSilver:getChildByName("Text"):setFontSize(18)
	self._nodeSilver:getChildByName("Text"):setPositionX(18 + 15)
	self._nodeSilver:getChildByName("Image"):setPositionY(18)
	self._nodeSilver:getChildByName("Image"):setScale(0.8)
	G_EffectGfxMgr:createPlayMovingGfx(self._parentView._nodeBgMoving, "moving_tujie_huohua", nil, nil, false)
	self:_adjustScaleAndPos()
	-- 调整层级_nodeTreasureDetailView
	local scene = G_SceneManager:getTopScene()   
    scene:getSceneView():changeDetailViewZorder(true)  
end

function TreasureTrainLimitLayer:_adjustScaleAndPos()
	-- 父界面展示
	self._parentView._nodeLimit:setVisible(true)  	 
	self._parentView._nodeDetail:setVisible(true)
	self._parentView._nodeDetail:getChildByName("_buttonShow"):setVisible(true)
	self._parentView._nodeDetail:getChildByName("_buttonPreview"):setVisible(true)
 
    -- 调整+号 文字位置
	for key = TreasureConst.TREASURE_LIMIT_COST_KEY_1, TreasureConst.TREASURE_LIMIT_COST_KEY_4 do
		ccui.Helper:seekNodeByName(self["_costNode"..key], "ButtonAdd"):setScale(0.7) -- +号缩放
		
		self["_cost"..key]._imageName:setAnchorPoint(cc.p(0.5, 0.5))
		self["_cost"..key]._imageName:setPosition(cc.p(0, -53))
		self["_cost"..key]._textPercent:setAnchorPoint(cc.p(0.5, 0.5))
		self["_cost"..key]._textPercent:setPosition(cc.p(0, -76))

		self["_cost"..key]._textPercent:setFontSize(18)
		self["_cost"..key]._textPercent:setColor(Colors.BRIGHT_BG_ONE)
		self["_cost"..key]._textPercent:disableEffect(cc.LabelEffect.OUTLINE)
		if not Lang.checkLang(Lang.CN) then
			self["_cost"..key]._imageName:setFontSize(18)
			self["_cost"..key]._imageName:setColor(Colors.NORMAL_BG_ONE) 
			self["_cost"..key]._imageName:disableEffect(cc.LabelEffect.OUTLINE)
		end
        ccui.Helper:seekNodeByName(self["_costNode"..key], "NodeFull"):getParent():setScale(0.9) 	-- 这个node缩放90%
    end
end

function TreasureTrainLimitLayer:_updateData()
	local treasureId = G_UserData:getTreasure():getCurTreasureId()
	self._treasureUnitData = G_UserData:getTreasure():getTreasureDataWithId(treasureId)

	local limitLevel = self._treasureUnitData:getLimit_cost()
	local info = TreasureDataHelper.getLimitCostConfig(limitLevel)
	for i = TreasureConst.TREASURE_LIMIT_COST_KEY_1, TreasureConst.TREASURE_LIMIT_COST_KEY_4 do
		if i == TreasureConst.TREASURE_LIMIT_COST_KEY_1 then
			self._materialMaxSize[i] = info.exp
		else
			self._materialMaxSize[i] = info["size_"..i]
		end
	end
	self._silverCost = info.break_size

	local curAttrData = TreasureDataHelper.getTreasureAttrInfo(self._treasureUnitData)
	self._recordAttr:updateData(curAttrData)
	G_UserData:getAttr():recordPower()
end

function TreasureTrainLimitLayer:_updateView()
	self:_updateBaseInfo()
	self:_updateAllCost()
	self:_updateBtnAndSilverState()
end

function TreasureTrainLimitLayer:_updateBaseInfo()
	local limitUpId = self._treasureUnitData:getConfig().limit_up_id
	local name = self._treasureUnitData:getConfig().name
	local color = self._treasureUnitData:getConfig().color
	local showNext = limitUpId > 0 and not self._treasureUnitData:isLimitShowTop()
	if showNext then
		name = TreasureDataHelper.getTreasureConfig(limitUpId).name
		color = TreasureDataHelper.getTreasureConfig(limitUpId).color
	end
	local baseId = self._treasureUnitData:getBase_id()
	local limitLevel = self._treasureUnitData:getLimit_cost()
	local nameStr = Lang.get("treasure_limit_name", {name = name})

	local changeBg = limitLevel==TreasureConst.TREASURE_LIMIT_UP_MAX_LEVEL
		or (limitLevel==TreasureConst.TREASURE_LIMIT_RED_LEVEL and not self._treasureUnitData:isLimitShowTop())

	local bgres, imgres
	if changeBg then
		bgres = Path.getLimitImgBg("img_bg_limit02")
		imgres = Path.getTextLimit("txt_limit_06h")
	else
		bgres = Path.getLimitImgBg("img_limit_bg01")
		imgres = Path.getTextLimit("txt_limit_06c")
	end
	if bgres then
		--self._imgBg:loadTexture(bgres)
		local scene = G_SceneManager:getTopScene()    
		scene:getSceneView():changeBackground(bgres)	
	end
	if  Lang.checkLang(Lang.CN) then
		if imgres then
			self._imageTitle:loadTexture(imgres)
		end
	end
	local showTop = limitLevel==TreasureConst.TREASURE_LIMIT_UP_MAX_LEVEL
		or (limitLevel==TreasureConst.TREASURE_LIMIT_RED_LEVEL and self._treasureUnitData:isLimitShowTop())
	self._textNameTop:setVisible(showTop)
	
	local txtColor =  Colors.getColor(color)
	local txtColorOutline = Colors.getColorOutline(color)
	
	self._textName:setColor(txtColor)
	self._textNameTop:setString(nameStr)
	self._textNameTop:setColor(txtColor)
	if color==7 then
		self._textName:enableOutline(txtColorOutline,2)
		self._textNameTop:enableOutline(txtColorOutline,2)
	else
		self._textName:disableEffect(cc.LabelEffect.OUTLINE)
		self._textNameTop:disableEffect(cc.LabelEffect.OUTLINE)
	end
	if  Lang.checkLang(Lang.CN) then
		self._textName:setString(nameStr)
		self._textLevel1:setString(self._treasureUnitData:getAddStrLevelByNextLimit())
		self._textLevel2:setString(self._treasureUnitData:getAddRefineLevelByNextLimit())
	elseif  imgres then
		local textstyle = ""
		if changeBg then
			textstyle = "txt_limit_06h"
		else
			textstyle = "txt_limit_06c"
		end

		if Lang.checkLang(Lang.JA)then
			local label1 = ccui.RichText:createByI18n()
			label1:setAnchorPoint(cc.p(0.5,0.5))
			local strContent = Lang.get(textstyle.."_1",{name = ""})
			label1:setRichTextWithJson(strContent)
			label1:setPosition(0, 26)
			local label2 = ccui.RichText:createByI18n()
			label2:setAnchorPoint(cc.p(0.5,0.5))
			strContent = Lang.get(textstyle.."_2",{level = TreasureConst.getAddStrLevelByLimit()})
			label2:setRichTextWithJson(strContent )
			label2:setPosition(0, -20)
			
			local label3 = ccui.RichText:createByI18n()
			label3:setAnchorPoint(cc.p(0.5,0.5))
			strContent = Lang.get(textstyle.."_3",{level = TreasureConst.getAddRefineLevelByLimit()})
			label3:setRichTextWithJson( strContent)
			label3:setPosition(0, -47)
	
			self._imageTitle:removeAllChildren()
			self._imageTitle:addChild(label1)
			self._imageTitle:addChild(label2)
			self._imageTitle:addChild(label3)

			local text = UIHelper.createLabel({ text = nameStr, fontSize = 18, color = txtColor, outlineColor = txtColorOutline, outlineSize=2})
			text:setAnchorPoint(cc.p(0.5, 0.5))
			text:setPosition(0, 3)
			self._imageTitle:addChild(text)
		else  
			local label1 = ccui.RichText:createByI18n()
			label1:setAnchorPoint(cc.p(0.5,0.5))
			local strContent = Lang.getImgText(textstyle.."_1",{name = nameStr})
			strContent = string.gsub(strContent, "\"fontSize\":22", "\"fontSize\":18")  
			label1:setRichTextWithJson(strContent)
			label1:setPositionY(70)
			local label2 = ccui.RichText:createByI18n()
			label2:setAnchorPoint(cc.p(0.5,0.5))
			strContent = Lang.getImgText(textstyle.."_2",{level = TreasureConst.getAddStrLevelByLimit()})
			strContent = string.gsub(strContent, "\"fontSize\":22", "\"fontSize\":18")  
			label2:setRichTextWithJson(strContent )
			label2:setPositionY(14)
			
			local label3 = ccui.RichText:createByI18n()
			label3:setAnchorPoint(cc.p(0.5,0.5))
			strContent = Lang.getImgText(textstyle.."_3",{level = TreasureConst.getAddRefineLevelByLimit()})
			strContent = string.gsub(strContent, "\"fontSize\":22", "\"fontSize\":18")  
			label3:setRichTextWithJson( strContent)
			label3:setPositionY(-11)
	
			self._imageTitle:removeAllChildren()
			self._imageTitle:addChild(label1)
			self._imageTitle:addChild(label2)
			self._imageTitle:addChild(label3)
			self._textName:setPositionY(43)
		end  
	end	

	-- self._nodeTreasure:updateUI(baseId)
	if showNext then
		self._nodeTreasure:updateUI(limitUpId)
	else
		self._nodeTreasure:updateUI(baseId)
	end

	if self._treasureUnitData:isLimitShowTop() then
		self._imageTitle:setVisible(false)
	else
		self._imageTitle:setVisible(true)
	end
	
	--名字
	self._nodeTitle:setName(2)
end

function TreasureTrainLimitLayer:_updateAllCost()
	for key = TreasureConst.TREASURE_LIMIT_COST_KEY_1, TreasureConst.TREASURE_LIMIT_COST_KEY_4 do
		self:_updateSingeCost(key)
	end
	self:_updateSilverCost()
end

function TreasureTrainLimitLayer:_updateSingeCost(costKey)
	local limitLevel = self._treasureUnitData:getLimit_cost()
	local curCount = self._treasureUnitData:getLimitCostCountWithKey(costKey)
	self["_cost"..costKey]:updateUI(limitLevel, curCount, self._treasureUnitData:isLimitShowTop())
	local isShowAll = TreasureDataHelper.isPromptTreasureLimit(self._treasureUnitData)
	local isShow = isShowAll and TreasureDataHelper.isPromptTreasureLimitWithCostKey(self._treasureUnitData, costKey)
	self["_cost"..costKey]:showRedPoint(isShow)
	self["_costNode"..costKey]:setLocalZOrder(ZORDER_COMMON)
end

function TreasureTrainLimitLayer:_updateSilverCost()
	local strSilver = TextHelper.getAmountText1(self._silverCost)
	self._nodeSilver:setCount(strSilver, nil, true)
end

function TreasureTrainLimitLayer:_updateBtnAndSilverState()
	if self._treasureUnitData:getLimit_cost() >= TreasureConst.TREASURE_LIMIT_UP_MAX_LEVEL then --满级不显示
		self._buttonBreak:setVisible(false)
		self._nodeSilver:setVisible(false) 
		self._planeMaxLimit:setVisible(true)
		return
	end

	local isAllFull = true
	for key = TreasureConst.TREASURE_LIMIT_COST_KEY_1, TreasureConst.TREASURE_LIMIT_COST_KEY_4 do
		local isFull = self:_checkIsMaterialFull(key)
		isAllFull = isAllFull and isFull
	end
	self._buttonBreak:setEnabled(isAllFull)   -- 材料不满时 按钮置灰 
	self._buttonBreak:showRedPoint(isAllFull) -- 红点
	-- self._buttonBreak:setVisible(isAllFull)  
	-- self._nodeSilver:setVisible(isAllFull)
	self._buttonBreak:setVisible(true)
	self._nodeSilver:setVisible(true)
	-- 调位置
	local width = self._nodeSilver:getChildByName("Text"):getContentSize().width + 12 + self._nodeSilver:getChildByName("Image"):getContentSize().width*0.8 			
	width = width*0.5
	self._nodeSilver:setPositionX(width*-1) 
end

function TreasureTrainLimitLayer:_playFire(isPlay)
	self._parentView._nodeFire:removeAllChildren()
	local effectName = isPlay and "effect_tujietiaozi_1" or "effect_tujietiaozi_2"
	local limitLevel = self._treasureUnitData:getLimit_cost()

	if limitLevel >= TreasureConst.TREASURE_LIMIT_RED_LEVEL and self._treasureUnitData:isLimitShowTop() then
		local effect = EffectGfxNode.new(effectName)
		self._parentView._nodeFire:addChild(effect)
		effect:play()
	end
end

function TreasureTrainLimitLayer:_onClickCostAdd(costKey)
	if TreasureTrainHelper.isOpen(FunctionConst.FUNC_TREASURE_TRAIN_TYPE4) == false then
		return
	end

	local isReach, needLevel = self:_checkRankLevel()
	if isReach == false then
		local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_TREASURE, self._treasureUnitData:getBase_id())
		local name = param.name
		local level = needLevel
		G_Prompt:showTip(Lang.get("treasure_limit_level_condition", {name = name, level = level}))
		return
	end
	-- 判断等级是否到了
	local limitLevel = self._treasureUnitData:getLimit_cost()
	local lv = TreasureDataHelper.getLimitOpenLv(limitLevel)
	local gameUserLevel = G_UserData:getBase():getLevel()
	if gameUserLevel<lv then
		G_Prompt:showTip(Lang.get("treasure_limit_level"))
		return
	end

	local limitLevel = self._treasureUnitData:getLimit_cost()
	self:_openPopupPanel(costKey, limitLevel)
end

function TreasureTrainLimitLayer:_openPopupPanel(costKey, limitLevel)
	if self._popupPanel ~= nil then
		return
	end

	self._popupPanel = TreasureLimitCostPanel.new(costKey, 
											handler(self, self._onClickCostPanelItem), 
											handler(self, self._onClickCostPanelStep), 
											handler(self, self._onClickCostPanelStart), 
											handler(self, self._onClickCostPanelStop),
											limitLevel,
											self["_costNode"..costKey])
	self._popupPanelSignal = self._popupPanel.signal:add(handler(self, self._onPopupPanelClose))
	--self._parentView._nodePopup:addChild(self._popupPanel)
	G_SceneManager:getRunningScene():addChild(self._popupPanel)
	self._popupPanel:setPosition(cc.p(0, 0))--(G_ResolutionManager:getDesignWidth()*0.5, G_ResolutionManager:getDesignHeight()*0.5 ))  
	self._popupPanel:updateUI()
end

function TreasureTrainLimitLayer:_onPopupPanelClose(event)
	if event == "close" then
        self._popupPanel = nil
        if self._popupPanelSignal then
	        self._popupPanelSignal:remove()
	        self._popupPanelSignal = nil
	    end
    end
end

function TreasureTrainLimitLayer:_onClickCostPanelItem(costKey, materials)
	if self:_checkIsMaterialFull(costKey) == true then
		return
	end

	self:_doPutRes(costKey, materials)
end

function TreasureTrainLimitLayer:_onClickCostPanelStep(costKey, itemId, itemValue, costCountEveryTime)
	if self._materialFakeCount <= 0 then
		return false
	end

	if self._materialFakeCurSize >= self._materialMaxSize[costKey] then
		G_Prompt:showTip(Lang.get("treasure_limit_material_full"))
		return false, nil, true
	end

	local realCostCount = math.min(self._materialFakeCount, costCountEveryTime)
	self._materialFakeCount = self._materialFakeCount - realCostCount
	self._materialFakeCostCount = self._materialFakeCostCount + realCostCount

	local costSizeEveryTime = realCostCount
	if costKey == TreasureConst.TREASURE_LIMIT_COST_KEY_1 then
		costSizeEveryTime = itemValue * realCostCount
	end
	self._materialFakeCurSize = self._materialFakeCurSize + costSizeEveryTime

	if self._popupPanel then
		local emitter = self:_createEmitter(costKey)
		local startNode = self._popupPanel:findNodeWithItemId(itemId)
		local endNode = self["_costNode"..costKey]
		self:_playEmitterEffect(emitter, startNode, endNode, costKey, self._materialFakeCurSize)
		startNode:setCount(self._materialFakeCount)
	end
	return true, realCostCount
end

function TreasureTrainLimitLayer:_onClickCostPanelStart(costKey, itemId, count)
	self._materialFakeCount = count
	self._materialFakeCostCount = 0
	self._materialFakeCurSize = self._treasureUnitData:getLimitCostCountWithKey(costKey)
end

function TreasureTrainLimitLayer:_onClickCostPanelStop()
	
end

function TreasureTrainLimitLayer:_onButtonDetail()
	local popup = PopupTreasureLimitDetail.new(self._treasureUnitData)
	popup:openWithAction()
end

function TreasureTrainLimitLayer:_onButtonBreak()
	local isOk, func = LogicCheckHelper.enoughMoney(self._silverCost)
	if isOk == false then
		func()
		return
	end

	self:_doLvUp()
end

function TreasureTrainLimitLayer:_checkRankLevel()
	local curLevel = self._treasureUnitData:getRefine_level()
	local limitLevel = self._treasureUnitData:getLimit_cost()
	local isReach, needLevel = TreasureDataHelper.isReachTreasureLimitRank(limitLevel, curLevel)
	return isReach, needLevel
end

function TreasureTrainLimitLayer:_checkIsMaterialFull(costKey)
	local curSize = self._treasureUnitData:getLimitCostCountWithKey(costKey)
	local maxSize = self._materialMaxSize[costKey]
	if curSize >= maxSize then
		return true
	else
		return false
	end
end

function TreasureTrainLimitLayer:_doPutRes(costKey, materials)
	local treasureId = self._treasureUnitData:getId()
	local idx = costKey
	local subItems = materials[1]
	G_UserData:getTreasure():c2sTreasureLimitCost(treasureId, idx, subItems)
	self._costMaterials = subItems
end

function TreasureTrainLimitLayer:_doLvUp()
	local treasureId = self._treasureUnitData:getId()
	G_UserData:getTreasure():c2sTreasureLimitCost(treasureId)
	self._buttonBreak:setEnabled(false)
end

function TreasureTrainLimitLayer:_onTreasureLimitLvPutRes(eventName, costKey)
	self:_updateData()
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint()
	end

	if self._popupPanel == nil then
		self:_updateSingeCost(costKey)
		self:_updateBtnAndSilverState()
		return
	end
	
	if self._materialFakeCostCount and self._materialFakeCostCount > 0 then --如果假球已经飞过了，就不再播球了，直接播剩下的特效和飘字
		self._materialFakeCostCount = nil
		self:_updateSingeCost(costKey)
	else
		local curCount = self._treasureUnitData:getLimitCostCountWithKey(costKey)
		local itemId = self._costMaterials.id
		local emitter = self:_createEmitter(costKey)
		local startNode = self._popupPanel:findNodeWithItemId(itemId)
		local endNode = self["_costNode"..costKey]
		self:_playEmitterEffect(emitter, startNode, endNode, costKey, curCount)
	end
	
	self:_updateBtnAndSilverState()
	if self:_checkIsMaterialFull(costKey) == true then
		self._popupPanel:close()
	end
end

function TreasureTrainLimitLayer:_onTreasureLimitSuccess()
	self:_updateData()
	local AudioConst = require("app.const.AudioConst")
	G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_TUPO)
	self:_playLvUpEffect()
	-- if self._parentView and self._parentView.checkRedPoint then 刷新在refreshAvatarAndUI
	-- 	self._parentView:checkRedPoint()
	-- end
end

--特效部分-----------------------------------------------------------

function TreasureTrainLimitLayer:_createEmitter(costKey)
	local names = {
		[TreasureConst.TREASURE_LIMIT_COST_KEY_1] = "tujiegreen",
		[TreasureConst.TREASURE_LIMIT_COST_KEY_2] = "tujieblue",
		[TreasureConst.TREASURE_LIMIT_COST_KEY_3] = "tujiepurple",
		[TreasureConst.TREASURE_LIMIT_COST_KEY_4] = "tujieorange",
	}
	local emitter = cc.ParticleSystemQuad:create("particle/"..names[costKey]..".plist")
	emitter:resetSystem()
    return emitter
end

--飞球特效
function TreasureTrainLimitLayer:_playEmitterEffect(emitter, startNode, endNode, costKey, curCount)
	local function getRandomPos(startPos, endPos)
		local pos11 = cc.p(startPos.x+(endPos.x-startPos.x)*1/2, startPos.y+(endPos.y-startPos.y)*3/4)
    	local pos12 = cc.p(startPos.x+(endPos.x-startPos.x)*1/4, startPos.y+(endPos.y-startPos.y)*1/2)
    	local pos21 = cc.p(startPos.x+(endPos.x-startPos.x)*3/4, startPos.y+(endPos.y-startPos.y)*1/2)
    	local pos22 = cc.p(startPos.x+(endPos.x-startPos.x)*1/2, startPos.y+(endPos.y-startPos.y)*1/4)
    	local tbPos = {
    		[1] = {pos11, pos12},
    		[2] = {pos21, pos22},
    	}

		local index = math.random(1, 2)
		return tbPos[index][1], tbPos[index][2]
	end

    local startPos = UIHelper.convertSpaceFromNodeToNode(startNode, self._parentView._panelDesign) -- self) 
    emitter:setPosition(startPos)
	G_SceneManager:getRunningScene():addChild(emitter)  --self:addChild(emitter)
    local endPos = UIHelper.convertSpaceFromNodeToNode(endNode, self._parentView._panelDesign) -- self) 
    local pointPos1, pointPos2 = getRandomPos(startPos, endPos)
    local bezier = {
	    pointPos1,
	    pointPos2,
	    endPos,
	}
	local action1 = cc.BezierTo:create(0.7, bezier)
	local action2 = cc.EaseSineIn:create(action1)
	emitter:runAction(cc.Sequence:create(
            action2,
            cc.CallFunc:create(function()
            	local limitLevel = self._treasureUnitData:getLimit_cost()
            	self["_cost"..costKey]:playRippleMoveEffect(limitLevel, curCount)
            end),
            cc.RemoveSelf:create()
        )
	)
end

function TreasureTrainLimitLayer:_playLvUpEffect()
	local function effectFunction(effect)
        return cc.Node:create()
    end

    local function eventFunction(event)
    	if event == "faguang" then
    		
        elseif event == "finish" then
        	self._buttonBreak:setEnabled(true)
            self:_updateView()			-- bug:银两资源 都没扣  UI未刷新
			self:_playFire(true)
			local delay = cc.DelayTime:create(0.5) --延迟x秒播飘字
		    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
				self:_playPrompt() 
				self._parentView:refreshAvatarAndUI() -- 开始显示界限按钮 刷新神兽形象
		    end))
		    self:runAction(sequence)
        end
    end

	G_EffectGfxMgr:createPlayMovingGfx(self._parentView._nodeHetiMoving, "moving_tujieheti", effectFunction, eventFunction , true)

	for key = TreasureConst.TREASURE_LIMIT_COST_KEY_1, TreasureConst.TREASURE_LIMIT_COST_KEY_4 do
		self["_costNode"..key]:setLocalZOrder(ZORDER_MOVE)
		self["_cost"..key]:playSMoving()
	end
end

function TreasureTrainLimitLayer:_playPrompt()
    local summary = {}
	local content = Lang.get("summary_treasure_limit_break_success")
	local param = {
		content = content,
	} 
	table.insert(summary, param)
	
	--属性飘字
	self:_addBaseAttrPromptSummary(summary)

    G_Prompt:showSummary(summary)

	--总战力
	G_Prompt:playTotalPowerSummary()
end

--加入基础属性飘字内容
function TreasureTrainLimitLayer:_addBaseAttrPromptSummary(summary)
	local attr = self._recordAttr:getAttr()
	local desInfo = TextHelper.getAttrInfoBySort(attr)
	for i, info in ipairs(desInfo) do
		local attrId = info.id
		local diffValue = self._recordAttr:getDiffValue(attrId)
		if diffValue ~= 0 then
			local param = {
				content = AttrDataHelper.getPromptContent(attrId, diffValue),
				anchorPoint = cc.p(0, 0.5),
				startPosition = {x = UIConst.SUMMARY_OFFSET_X_ATTR},
			}
			table.insert(summary, param)
		end
	end

	return summary
end

-- i18n change to lable
function TreasureTrainLimitLayer:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local node = cc.Node:create()
		local source = self._imageTitle

		local x,y = source:getPosition()
		node:setPosition( x,y + 15)
		node:setAnchorPoint( source:getAnchorPoint() )
		node:setLocalZOrder( source:getLocalZOrder() )
		

		source:setVisible(false)
		local sourceParent = source:getParent()
		sourceParent:addChild(node)
	
		self._imageTitle = node
		self._imageTitle:setLocalZOrder(self._nodeTreasure:getParent():getLocalZOrder() - 1) 
		self._imgAvatarBg:setLocalZOrder(self._imageTitle:getLocalZOrder() - 1)
		
		-- 界限详情
		local image1 = UIHelper.seekNodeByName(self._parentView._buttonPreview,"Image_2")
		local label = UIHelper.swapWithLabel(image1,{ 
			style = "limit_1_ja", 
			text = Lang.getImgText("txt_limit_detail") ,
		})
		label:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER  )
		label:setAnchorPoint(cc.p(0.5, 1))
		label:setPosition(cc.p(29, 17))	

		-- 满级     
		self._planeMaxLimit:setVisible(false)
		self._image_des = UIHelper.swapWithLabel(self._image_des,{ 
			style = "team_max_level_ja", 
			text = Lang.getImgText("txt_train_breakthroughtop"),
			offsetY = 0
		})
		self._image_des:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER  )
	end
end

--i18n
function TreasureTrainLimitLayer:_dealByI18n()
	if Lang.checkUI("ui4") then
        return
	end
	
    if Lang.checkHorizontal() then
        self._buttonDetail:setAnchorPoint(1,0.5)
        self._buttonDetail:setCapInsets(cc.rect(50,10,20,1))
        self._buttonDetail:loadTextureNormal(Path.getLimitImg("img_limit_07_h"))
        self._buttonDetail:setPositionX(self._buttonDetail:getPositionX()+20)
        local img = ccui.Helper:seekNodeByName(self._buttonDetail, "Image_91")
		local UIHelper  = require("yoka.utils.UIHelper")
	    img = UIHelper.swapWithLabel(img,{
			 style = "icon_txt_3",
             text = Lang.getImgText("txt_limit_detail"),
        })
        img:setFontSize(20)
        local size = cc.size(img:getContentSize().width+40,36)
        self._buttonDetail:setContentSize(size)
        img:setPosition(size.width/2+10,size.height/2)
    end
end
		
return TreasureTrainLimitLayer