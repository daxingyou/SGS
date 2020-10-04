--
-- Author: Liangxu
-- Date: 2018-11-2
-- 神兵界限突破
local ViewBase = require("app.ui.ViewBase")
local InstrumentTrainLimitLayer = class("InstrumentTrainLimitLayer", ViewBase)
local InstrumentConst = require("app.const.InstrumentConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local InstrumentLimitCostNode = require("app.scene.view.instrumentTrain.InstrumentLimitCostNode")
local InstrumentDataHelper = require("app.utils.data.InstrumentDataHelper")
local TextHelper = require("app.utils.TextHelper")
local InstrumentLimitCostPanel = require("app.scene.view.instrumentTrain.InstrumentLimitCostPanel")
local UIHelper = require("yoka.utils.UIHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local UIConst = require("app.const.UIConst")
local DataConst = require("app.const.DataConst")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local PopupInstrumentLimitDetail = require("app.scene.view.instrumentTrain.PopupInstrumentLimitDetail")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local AudioConst = require("app.const.AudioConst")

local ZORDER_COMMON = 0
local ZORDER_MID = 1
local ZORDER_MOVE = 2

function InstrumentTrainLimitLayer:ctor(parentView)
	self._parentView = parentView

	local resource = {
		file = Path.getCSB("InstrumentTrainLimitLayer", "instrument"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonBreak = {
				events = {{event = "touch", method = "_onButtonBreak"}},
			},
			_buttonDetail = {
				events = {{event = "touch", method = "_onButtonDetail"}}
			}
		},
	}
	InstrumentTrainLimitLayer.super.ctor(self, resource)
end

function InstrumentTrainLimitLayer:onCreate()
	-- i18n change lable
	self:_swapImageByI18n()
	--i18n
	self:_dealByI18n()

	self:_initData()
	self:_initView()
end

function InstrumentTrainLimitLayer:onEnter()
	self._signalInstrumentLimitLvPutRes = G_SignalManager:add(SignalConst.EVENT_INSTRUMENT_LIMIT_LV_PUT_RES, handler(self, self._onInstrumentLimitLvPutRes))
	self._signalInstrumentLimit = G_SignalManager:add(SignalConst.EVENT_INSTRUMENT_LIMIT_SUCCESS, handler(self, self._onInstrumentLimitSuccess))

	self:_updateData()
	self:_updateView()
end

function InstrumentTrainLimitLayer:onExit()
	self._signalInstrumentLimitLvPutRes:remove()
	self._signalInstrumentLimitLvPutRes = nil
	self._signalInstrumentLimit:remove()
	self._signalInstrumentLimit = nil
end

function InstrumentTrainLimitLayer:updateInfo()
	self._parentView:setArrowBtnVisible(false)
	self:_updateData()
	self:_updateView()
	self:_playFire(true)
end

function InstrumentTrainLimitLayer:_initData()
	self._costMaterials = {} --记录消耗的材料
	self._materialMaxSize = { --每种材料最大值
		[InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_1] = 0,
		[InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_2] = 0,
	}
	self._silverCost = 0

	self._materialFakeCount = nil --材料假个数
	self._materialFakeCostCount = nil --材料假的消耗个数
	self._materialFakeCurSize = 0

	self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE2)
end

function InstrumentTrainLimitLayer:_initView()
	self._popupPanel = nil
	self._buttonHelp:updateUI(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE2)
	self._buttonBreak:setString(Lang.get("instrument_limit_break_btn"))
	self._nodeInstrument:setLocalZOrder(ZORDER_MID)
	self._nodeInstrument:showShadow(false)
	for key = InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_1, InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_2 do
		self["_cost"..key] = InstrumentLimitCostNode.new(self["_costNode"..key], key, handler(self, self._onClickCostAdd))
	end
	self._nodeSilver:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_GOLD)
	self._nodeSilver:setTextColorToDTypeColor()
	G_EffectGfxMgr:createPlayMovingGfx(self._nodeBgMoving, "moving_tujie_huohua", nil, nil, false)
end

function InstrumentTrainLimitLayer:_updateData()
	local instrumentId = G_UserData:getInstrument():getCurInstrumentId()
	self._instrumentUnitData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)

	local limitLevel = self._instrumentUnitData:getLimit_level()
	local templateId = self._instrumentUnitData:getLimitTemplateId()
	local info = InstrumentDataHelper.getInstrumentRankConfig(templateId, limitLevel)
	for i = InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_1, InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_2 do
		self._materialMaxSize[i] = info["size_"..i]
	end
	self._silverCost = info.cost_silver

	local curAttrData = InstrumentDataHelper.getInstrumentAttrInfo(self._instrumentUnitData)
	self._recordAttr:updateData(curAttrData)
	G_UserData:getAttr():recordPower()
end

function InstrumentTrainLimitLayer:_updateView()
	self:_updateBaseInfo()
	self:_updateAllCost()
	self:_updateBtnAndSilverState()
end

function InstrumentTrainLimitLayer:_updateBaseInfo()
	local name = self._instrumentUnitData:getConfig().name
	local baseId = self._instrumentUnitData:getBase_id()
	local limitLevel = self._instrumentUnitData:getLimit_level()
	local nameStr = Lang.get("instrument_limit_name", {name = name})
	local templateId = self._instrumentUnitData:getLimitTemplateId()
	local maxLevel = InstrumentDataHelper.getInstrumentRankConfig(templateId, limitLevel).level_max

	self._textName:setString(nameStr)
	self._textLevel:setString(maxLevel)
	
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		UIHelper.alignCenter(self._imageTitle,{self._label1,self._textName})
		UIHelper.alignCenter(self._imageTitle,{self._label2,self._textLevel,self._label3})
	end

	self._nodeInstrument:updateUI(baseId,limitLevel)
	if limitLevel >= InstrumentConst.INSTRUMENT_LIMIT_MAX_LEVEL then
		self._imageTitle:setVisible(false)
	else
		self._imageTitle:setVisible(true)
	end
end

function InstrumentTrainLimitLayer:_updateAllCost()
	for key = InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_1, InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_2 do
		self:_updateSingeCost(key)
	end
	self:_updateSilverCost()
end

function InstrumentTrainLimitLayer:_updateSingeCost(costKey)
	local templateId = self._instrumentUnitData:getLimitTemplateId()
	local limitLevel = self._instrumentUnitData:getLimit_level()
	local curCount = self._instrumentUnitData:getLimitCostCountWithKey(costKey)
	self["_cost"..costKey]:updateUI(templateId, limitLevel, curCount)
	local isShow = InstrumentDataHelper.isPromptInstrumentLimitWithCostKey(self._instrumentUnitData, costKey)
	self["_cost"..costKey]:showRedPoint(isShow)
	self["_costNode"..costKey]:setLocalZOrder(ZORDER_COMMON)
end

function InstrumentTrainLimitLayer:_updateSilverCost()
	local strSilver = TextHelper.getAmountText1(self._silverCost)
	self._nodeSilver:setCount(strSilver, nil, true)
end

function InstrumentTrainLimitLayer:_updateBtnAndSilverState()
	if self._instrumentUnitData:getLimit_level() >= InstrumentConst.INSTRUMENT_LIMIT_MAX_LEVEL then --满级不显示
		self._buttonBreak:setVisible(false)
		self._nodeSilver:setVisible(false)
		return
	end

	local isAllFull = true
	for key = InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_1, InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_2 do
		local isFull = self:_checkIsMaterialFull(key)
		isAllFull = isAllFull and isFull
	end
	self._buttonBreak:setVisible(isAllFull)
	self._nodeSilver:setVisible(isAllFull)
end

function InstrumentTrainLimitLayer:_playFire(isPlay)
	self._nodeFire:removeAllChildren()
	local effectName = isPlay and "effect_tujietiaozi_1" or "effect_tujietiaozi_2"
	local limitLevel = self._instrumentUnitData:getLimit_level()
	if limitLevel == InstrumentConst.INSTRUMENT_LIMIT_MAX_LEVEL then
		local effect = EffectGfxNode.new(effectName)
		self._nodeFire:addChild(effect)
		effect:play()
	end
end

function InstrumentTrainLimitLayer:_onClickCostAdd(costKey)
	local isReach, needLevel = self:_checkRankLevel()
	if isReach == false then
		local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_INSTRUMENT, self._instrumentUnitData:getBase_id())
		local name = param.name
		local level = needLevel
		G_Prompt:showTip(Lang.get("instrument_limit_level_condition", {name = name, level = level}))
		return
	end

	local limitLevel = self._instrumentUnitData:getLimit_level()
	local templateId = self._instrumentUnitData:getLimitTemplateId()
	self:_openPopupPanel(costKey, limitLevel, templateId)
end

function InstrumentTrainLimitLayer:_openPopupPanel(costKey, limitLevel, templateId)
	if self._popupPanel ~= nil then
		return
	end

	self._popupPanel = InstrumentLimitCostPanel.new(costKey, 
											handler(self, self._onClickCostPanelItem), 
											handler(self, self._onClickCostPanelStep), 
											handler(self, self._onClickCostPanelStart), 
											handler(self, self._onClickCostPanelStop),
											templateId,
											limitLevel,
											self["_costNode"..costKey])
	self._popupPanelSignal = self._popupPanel.signal:add(handler(self, self._onPopupPanelClose))
	self._nodePopup:addChild(self._popupPanel)
	self._popupPanel:updateUI()
end

function InstrumentTrainLimitLayer:_onPopupPanelClose(event)
	if event == "close" then
        self._popupPanel = nil
        if self._popupPanelSignal then
	        self._popupPanelSignal:remove()
	        self._popupPanelSignal = nil
	    end
    end
end

function InstrumentTrainLimitLayer:_onClickCostPanelItem(costKey, materials)
	if self:_checkIsMaterialFull(costKey) == true then
		return
	end

	self:_doPutRes(costKey, materials)
end

function InstrumentTrainLimitLayer:_onClickCostPanelStep(costKey, itemId, itemValue, costCountEveryTime)
	if self._materialFakeCount <= 0 then
		return false
	end

	if self._materialFakeCurSize >= self._materialMaxSize[costKey] then
		G_Prompt:showTip(Lang.get("instrument_limit_material_full"))
		return false, nil, true
	end

	local realCostCount = math.min(self._materialFakeCount, costCountEveryTime)
	self._materialFakeCount = self._materialFakeCount - realCostCount
	self._materialFakeCostCount = self._materialFakeCostCount + realCostCount

	local costSizeEveryTime = costCountEveryTime
	-- if costKey == InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_1 then
	-- 	costSizeEveryTime = itemValue * realCostCount
	-- end
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

function InstrumentTrainLimitLayer:_onClickCostPanelStart(costKey, itemId, count)
	self._materialFakeCount = count
	self._materialFakeCostCount = 0
	self._materialFakeCurSize = self._instrumentUnitData:getLimitCostCountWithKey(costKey)
end

function InstrumentTrainLimitLayer:_onClickCostPanelStop()
	
end

function InstrumentTrainLimitLayer:_onButtonDetail()
	local popup = PopupInstrumentLimitDetail.new(self._instrumentUnitData)
	popup:openWithAction()
end

function InstrumentTrainLimitLayer:_onButtonBreak()
	local isOk, func = LogicCheckHelper.enoughMoney(self._silverCost)
	if isOk == false then
		func()
		return
	end

	self:_doLvUp()
end

function InstrumentTrainLimitLayer:_checkRankLevel()
	local templateId = self._instrumentUnitData:getLimitTemplateId()
	local curLevel = self._instrumentUnitData:getLevel()
	local limitLevel = self._instrumentUnitData:getLimit_level()
	local isReach, needLevel = InstrumentDataHelper.isReachInstrumentLimitRank(templateId, limitLevel, curLevel)
	return isReach, needLevel
end

function InstrumentTrainLimitLayer:_checkIsMaterialFull(costKey)
	local curSize = self._instrumentUnitData:getLimitCostCountWithKey(costKey)
	local maxSize = self._materialMaxSize[costKey]
	if curSize >= maxSize then
		return true
	else
		return false
	end
end

function InstrumentTrainLimitLayer:_doPutRes(costKey, materials)
	local instrumentId = self._instrumentUnitData:getId()
	local pos = costKey
	local subItems = materials
	G_UserData:getInstrument():c2sInstrumentLimitLvPutRes(instrumentId, pos, subItems)
	self._costMaterials = materials
end

function InstrumentTrainLimitLayer:_doLvUp()
	local instrumentId = self._instrumentUnitData:getId()
	G_UserData:getInstrument():c2sInstrumentUpLimitLevel(instrumentId)
end

function InstrumentTrainLimitLayer:_onInstrumentLimitLvPutRes(eventName, costKey)
	self:_updateData()
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint(2)
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
		local curCount = self._instrumentUnitData:getLimitCostCountWithKey(costKey)
		for i, material in ipairs(self._costMaterials) do
			local itemId = material.id
			local emitter = self:_createEmitter(costKey)
			local startNode = self._popupPanel:findNodeWithItemId(itemId)
			local endNode = self["_costNode"..costKey]
			self:_playEmitterEffect(emitter, startNode, endNode, costKey, curCount)
		end
	end
	
	self:_updateBtnAndSilverState()
	if self:_checkIsMaterialFull(costKey) == true then
		self._popupPanel:close()
	end
end

function InstrumentTrainLimitLayer:_onInstrumentLimitSuccess()
	self:_updateData()
	G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_TUPO)
	self:_playLvUpEffect()
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint(2)
	end
end

--特效部分-----------------------------------------------------------

function InstrumentTrainLimitLayer:_createEmitter(costKey)
	local names = {
		[InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_1] = "tujiepurple",
		[InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_2] = "tujieorange",
	}
	local emitter = cc.ParticleSystemQuad:create("particle/"..names[costKey]..".plist")
	emitter:resetSystem()
    return emitter
end

--飞球特效
function InstrumentTrainLimitLayer:_playEmitterEffect(emitter, startNode, endNode, costKey, curCount)
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

    local startPos = UIHelper.convertSpaceFromNodeToNode(startNode, self)
    emitter:setPosition(startPos)
    self:addChild(emitter)
    local endPos = UIHelper.convertSpaceFromNodeToNode(endNode, self)
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
            	local templateId = self._instrumentUnitData:getLimitTemplateId()
            	local limitLevel = self._instrumentUnitData:getLimit_level()
            	self["_cost"..costKey]:playRippleMoveEffect(templateId, limitLevel, curCount)
            end),
            cc.RemoveSelf:create()
        )
	)
end

function InstrumentTrainLimitLayer:_playLvUpEffect()
	local function effectFunction(effect)
        return cc.Node:create()
    end

    local function eventFunction(event)
    	if event == "faguang" then
    		
        elseif event == "finish" then
            self:_updateView()
            self:_playFire(true)
			local delay = cc.DelayTime:create(0.5) --延迟x秒播飘字
		    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		    	self:_playPrompt()
		    end))
		    self:runAction(sequence)
        end
    end

	G_EffectGfxMgr:createPlayMovingGfx(self._nodeHetiMoving, "moving_tujieheti", effectFunction, eventFunction , true)

	for key = InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_1, InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_2 do
		self["_costNode"..key]:setLocalZOrder(ZORDER_MOVE)
		self["_cost"..key]:playSMoving()
	end
end

function InstrumentTrainLimitLayer:_playPrompt()
    local summary = {}
	local content = Lang.get("summary_instrument_limit_break_success")
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
function InstrumentTrainLimitLayer:_addBaseAttrPromptSummary(summary)
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


-- i18n change lable
function InstrumentTrainLimitLayer:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")

		local nodeMid = UIHelper.seekNodeByName(self._panelDesign,"NodeMid")


		local node = cc.Node:create()
		node:setPosition(self._imageTitle:getPosition())
		node:setContentSize(self._imageTitle:getContentSize())
		node:setAnchorPoint(cc.p(0.5,0.5))
		self._textName:retain()
		self._textName:removeFromParent()
		node:addChild(self._textName)
		self._textName:release()
		

		self._textLevel:retain()
		self._textLevel:removeFromParent()
		node:addChild(self._textLevel)
		self._textLevel:release()


		local label1 = UIHelper.createLabel({ 
			style = "limit_2", 
			text = Lang.getImgText("txt_limit_06b") ,
			position = cc.p(0,self._textName:getPositionY())
	   })
	   local label2 = UIHelper.createLabel({ 
			style = "limit_2", 
			text = Lang.getImgText("txt_limit_06b_2") ,
			position = cc.p(0,self._textLevel:getPositionY())
		})
		local label3 = UIHelper.createLabel({ 
			style = "limit_2", 
			text = Lang.getImgText("txt_limit_06b_3") ,
			position = cc.p(0,self._textLevel:getPositionY())
		})
		
		
		node:addChild(label1)
		node:addChild(label2)
		node:addChild(label3)
		self._imageTitle:getParent():addChild(node)

		self._label1 = label1
		self._label2 = label2
		self._label3 = label3
		self._imageTitle:setVisible(false)
		self._imageTitle = node
	
	end
end

--i18n
function InstrumentTrainLimitLayer:_dealByI18n()
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


return InstrumentTrainLimitLayer