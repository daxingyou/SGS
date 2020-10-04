--
-- Author: Liangxu
-- Date: 2018-8-3 11:28:42
-- 武将界限突破

local ViewBase = require("app.ui.ViewBase")
local HeroTrainLimitLayer = class("HeroTrainLimitLayer", ViewBase)
local HeroLimitCostNode = require("app.scene.view.heroTrain.HeroLimitCostNode")
local HeroConst = require("app.const.HeroConst")
local HeroLimitCostPanel = require("app.scene.view.heroTrain.HeroLimitCostPanel")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UIHelper = require("yoka.utils.UIHelper")
local PopupLimitDetail = require("app.scene.view.heroTrain.PopupLimitDetail")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local TextHelper = require("app.utils.TextHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local UIConst = require("app.const.UIConst")
local DataConst = require("app.const.DataConst")
local EffectGfxNode = require("app.effect.EffectGfxNode")

local ZORDER_COMMON = 0
local ZORDER_MID = 1
local ZORDER_MOVE = 2

function HeroTrainLimitLayer:ctor(parentView)
	self._parentView = parentView
	local resource = {
		file = Path.getCSB("HeroTrainLimitLayer", "hero"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonBreak = {
				events = {{event = "touch", method = "_onButtonBreak"}}
			},
			_buttonDetail = {
				events = {{event = "touch", method = "_onButtonDetail"}}
			}
		},
	}
	
	HeroTrainLimitLayer.super.ctor(self, resource)
end

function HeroTrainLimitLayer:onCreate()
	-- i18n change lable
	self:_swapImageByI18n()
	--i18n
	self:_dealByI18n()

	self:_initData()
	self:_initView()
end

function HeroTrainLimitLayer:onEnter()
	self._signalHeroLimitLvPutRes = G_SignalManager:add(SignalConst.EVENT_HERO_LIMIT_LV_PUT_RES, handler(self, self._onHeroLimitLvPutRes))
	self._signalHeroLimitLvUpSuccess = G_SignalManager:add(SignalConst.EVENT_HERO_LIMIT_LV_UP_SUCCESS, handler(self, self._onHeroLimitLvUpSuccess))
end

function HeroTrainLimitLayer:onExit()
	self._signalHeroLimitLvPutRes:remove()
	self._signalHeroLimitLvPutRes = nil
	self._signalHeroLimitLvUpSuccess:remove()
	self._signalHeroLimitLvUpSuccess = nil
end

function HeroTrainLimitLayer:initInfo()
	self._parentView:setArrowBtnVisible(false)
	self:_updateData()
	self:_updateView()
	self:_playFire(true)
end

function HeroTrainLimitLayer:_initData()
	self._costMaterials = {} --记录消耗的材料
	self._materialMaxSize = { --每种材料最大值
		[HeroConst.HERO_LIMIT_COST_KEY_1] = 0,
		[HeroConst.HERO_LIMIT_COST_KEY_2] = 0,
		[HeroConst.HERO_LIMIT_COST_KEY_3] = 0,
		[HeroConst.HERO_LIMIT_COST_KEY_4] = 0,
	}
	self._silverCost = 0

	self._materialFakeCount = nil --材料假个数
	self._materialFakeCostCount = nil --材料假的消耗个数
	self._materialFakeCurSize = 0

	self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst.FUNC_HERO_TRAIN_TYPE4)
end

function HeroTrainLimitLayer:_initView()
	self._popupPanel = nil
	self._buttonHelp:updateUI(FunctionConst.FUNC_HERO_TRAIN_TYPE4)
	self._buttonBreak:setString(Lang.get("hero_limit_break_btn"))
	self._nodeHero:setScale(1.4)
	self._nodeHero:setLocalZOrder(ZORDER_MID)
	for key = HeroConst.HERO_LIMIT_COST_KEY_1, HeroConst.HERO_LIMIT_COST_KEY_4 do
		self["_cost"..key] = HeroLimitCostNode.new(self["_costNode"..key], key, handler(self, self._onClickCostAdd))
	end
	self._nodeSilver:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_GOLD)
	self._nodeSilver:setTextColorToDTypeColor()
	G_EffectGfxMgr:createPlayMovingGfx(self._nodeBgMoving, "moving_tujie_huohua", nil, nil, false)
end

function HeroTrainLimitLayer:_updateData()
	self._heroId = G_UserData:getHero():getCurHeroId()
	self._heroUnitData = G_UserData:getHero():getUnitDataWithId(self._heroId)

	local limitLevel = self._heroUnitData:getLimit_level()
	local info = HeroDataHelper.getHeroLimitCostConfig(limitLevel)
	for i = HeroConst.HERO_LIMIT_COST_KEY_1, HeroConst.HERO_LIMIT_COST_KEY_4 do
		self._materialMaxSize[i] = info["size_"..i]
	end
	self._silverCost = info.break_size

	local curAttrData = HeroDataHelper.getLimitAttr(self._heroUnitData)
	self._recordAttr:updateData(curAttrData)
	G_UserData:getAttr():recordPower()
end

function HeroTrainLimitLayer:_updateView()
	self:_updateBaseInfo()
	self:_updateAllCost()
	self:_updateBtnAndSilverState()
end

function HeroTrainLimitLayer:_updateBaseInfo()
	local name = self._heroUnitData:getConfig().name
	local baseId = self._heroUnitData:getBase_id()
	local limitLevel = self._heroUnitData:getLimit_level()
	local nameStr = Lang.get("hero_limit_name", {name = name})

	self._textName:setString(nameStr)
	self._nodeGogok:setCount(limitLevel)
	self._nodeHero:updateUI(baseId, nil, nil, 3) --一直放红将形象
	if limitLevel >= 3 then
		self._imageTitle:setVisible(false)
		self._textName:setPositionX(-25)

		if not Lang.checkLang(Lang.CN) then
			local size2 = self._textName:getContentSize()
			local UIHelper  = require("yoka.utils.UIHelper")
			local image1 = UIHelper.seekNodeByName(self,"NodeMid","Image1")
			local size = image1:getContentSize()
			image1:setContentSize(cc.size(size2.width+200,size.height))
		end


	else
		self._imageTitle:setVisible(true)
		self._textName:setPositionX(107)

		self:_adjustPosI18n()
	end
end

function HeroTrainLimitLayer:_updateAllCost()
	for key = HeroConst.HERO_LIMIT_COST_KEY_1, HeroConst.HERO_LIMIT_COST_KEY_4 do
		self:_updateSingeCost(key)
	end
	self:_updateSilverCost()
end

function HeroTrainLimitLayer:_updateSingeCost(costKey)
	local limitLevel = self._heroUnitData:getLimit_level()
	local curCount = self._heroUnitData:getLimitCostCountWithKey(costKey)
	self["_cost"..costKey]:updateUI(limitLevel, curCount)
	local isShow = HeroDataHelper.isPromptHeroLimitWithCostKey(self._heroUnitData, costKey)
	self["_cost"..costKey]:showRedPoint(isShow)
	self["_costNode"..costKey]:setLocalZOrder(ZORDER_COMMON)
end

function HeroTrainLimitLayer:_updateSilverCost()
	local strSilver = TextHelper.getAmountText1(self._silverCost)
	self._nodeSilver:setCount(strSilver, nil, true)
end

function HeroTrainLimitLayer:_updateBtnAndSilverState()
	if self._heroUnitData:getLimit_level() >= 3 then --满级不显示
		self._buttonBreak:setVisible(false)
		self._nodeSilver:setVisible(false)
		return
	end

	local isAllFull = true
	for key = HeroConst.HERO_LIMIT_COST_KEY_1, HeroConst.HERO_LIMIT_COST_KEY_4 do
		local isFull = self:_checkIsMaterialFull(key)
		isAllFull = isAllFull and isFull
	end
	self._buttonBreak:setVisible(isAllFull)
	self._nodeSilver:setVisible(isAllFull)
end

function HeroTrainLimitLayer:_playFire(isPlay)
	self._nodeFire:removeAllChildren()
	local effectName = isPlay and "effect_tujietiaozi_1" or "effect_tujietiaozi_2"
	local limitLevel = self._heroUnitData:getLimit_level()
	if limitLevel == HeroConst.HERO_LIMIT_MAX_LEVEL then
		local effect = EffectGfxNode.new(effectName)
		self._nodeFire:addChild(effect)
		effect:play()
	end
end

function HeroTrainLimitLayer:_onClickCostAdd(costKey)
	local isReach, needRank = self:_checkRankLevel()
	if isReach == false then
		local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, self._heroUnitData:getBase_id())
		local name = param.name
		local rank = needRank
		local level = self._heroUnitData:getLimit_level() + 1
		G_Prompt:showTip(Lang.get("hero_limit_level_condition", {name = name, rank = rank, level = level}))
		return
	end

	local limitLevel = self._heroUnitData:getLimit_level()
	self:_openPopupPanel(costKey, limitLevel)
end

function HeroTrainLimitLayer:_openPopupPanel(costKey, limitLevel)
	if self._popupPanel ~= nil then
		return
	end

	self._popupPanel = HeroLimitCostPanel.new(costKey, 
											handler(self, self._onClickCostPanelItem), 
											handler(self, self._onClickCostPanelStep), 
											handler(self, self._onClickCostPanelStart), 
											handler(self, self._onClickCostPanelStop),
											limitLevel,
											self["_costNode"..costKey])
	self._popupPanelSignal = self._popupPanel.signal:add(handler(self, self._onPopupPanelClose))
	self._nodePopup:addChild(self._popupPanel)
	self._popupPanel:updateUI()
end

function HeroTrainLimitLayer:_onPopupPanelClose(event)
	if event == "close" then
        self._popupPanel = nil
        if self._popupPanelSignal then
	        self._popupPanelSignal:remove()
	        self._popupPanelSignal = nil
	    end
    end
end

function HeroTrainLimitLayer:_onClickCostPanelItem(costKey, materials)
	if self:_checkIsMaterialFull(costKey) == true then
		return
	end

	-- 防止过多消耗
	if costKey==HeroConst.HERO_LIMIT_COST_KEY_1 or costKey==HeroConst.HERO_LIMIT_COST_KEY_2 then
		-- 按照需要的经验消耗道具，防止多余的消耗
		local id = materials[1].id
		local num = materials[1].num
		local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, id)
		local itemValue = math.max(1, param.cfg.item_value)
		local count = 0
		local cur = 0

		local curCount = self._heroUnitData:getLimitCostCountWithKey(costKey, self._limitDataType)
		local info = HeroDataHelper.getHeroLimitCostConfig(self._heroUnitData:getLimit_level())
		local configKey = HeroDataHelper.getLimitCostConfigKey(costKey)
		local size = info[configKey.size] or 0
		local reminder = size - curCount

		for j=1,num do
			cur = cur + itemValue
			count = count+1
			if cur>=reminder then
				break
			end
		end
		materials[1].num = count
	end

	self:_doPutRes(costKey, materials)
end

function HeroTrainLimitLayer:_onClickCostPanelStep(costKey, itemId, itemValue, costCountEveryTime)
	if self._materialFakeCount <= 0 then
		return false
	end

	if self._materialFakeCurSize >= self._materialMaxSize[costKey] then
		G_Prompt:showTip(Lang.get("hero_limit_material_full"))
		return false, nil, true
	end

	local realCostCount = math.min(self._materialFakeCount, costCountEveryTime)
	self._materialFakeCount = self._materialFakeCount - realCostCount
	self._materialFakeCostCount = self._materialFakeCostCount + realCostCount

	local costSizeEveryTime = costCountEveryTime
	if costKey == HeroConst.HERO_LIMIT_COST_KEY_1 then
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

function HeroTrainLimitLayer:_onClickCostPanelStart(costKey, itemId, count)
	self._materialFakeCount = count
	self._materialFakeCostCount = 0
	self._materialFakeCurSize = self._heroUnitData:getLimitCostCountWithKey(costKey)
end

function HeroTrainLimitLayer:_onClickCostPanelStop()
	
end

function HeroTrainLimitLayer:_onButtonDetail()
	local popup = PopupLimitDetail.new(self._heroUnitData)
	popup:openWithAction()
end

function HeroTrainLimitLayer:_onButtonBreak()
	local isOk, func = LogicCheckHelper.enoughMoney(self._silverCost)
	if isOk == false then
		func()
		return
	end

	self:_doLvUp()
end

function HeroTrainLimitLayer:_checkRankLevel()
	local curRank = self._heroUnitData:getRank_lv()
	local limitLevel = self._heroUnitData:getLimit_level()
	local isReach, needRank = HeroDataHelper.isReachLimitRank(limitLevel, curRank)
	return isReach, needRank
end

function HeroTrainLimitLayer:_checkIsMaterialFull(costKey)
	local curSize = self._heroUnitData:getLimitCostCountWithKey(costKey)
	local maxSize = self._materialMaxSize[costKey]
	if curSize >= maxSize then
		return true
	else
		return false
	end
end

function HeroTrainLimitLayer:_doPutRes(costKey, materials)
	local heroId = self._heroUnitData:getId()
	local pos = costKey
	local subItems = materials
	G_UserData:getHero():c2sHeroLimitLvPutRes(heroId, pos, subItems)
	self._costMaterials = materials
end

function HeroTrainLimitLayer:_doLvUp()
	local heroId = self._heroUnitData:getId()
	G_UserData:getHero():c2sHeroLimitLvUp(heroId)
end

function HeroTrainLimitLayer:_onHeroLimitLvPutRes(eventName, costKey)
	self:_updateData()
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint(4)
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
		local curCount = self._heroUnitData:getLimitCostCountWithKey(costKey)
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

function HeroTrainLimitLayer:_onHeroLimitLvUpSuccess()
	self:_updateData()
	local AudioConst = require("app.const.AudioConst")
	G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_TUPO)
	self:_playLvUpEffect()
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint(4)
	end
end

--特效部分-----------------------------------------------------------

function HeroTrainLimitLayer:_createEmitter(costKey)
	local names = {
		[HeroConst.HERO_LIMIT_COST_KEY_1] = "tujiegreen",
		[HeroConst.HERO_LIMIT_COST_KEY_2] = "tujieblue",
		[HeroConst.HERO_LIMIT_COST_KEY_3] = "tujiepurple",
		[HeroConst.HERO_LIMIT_COST_KEY_4] = "tujieorange",
	}
	local emitter = cc.ParticleSystemQuad:create("particle/"..names[costKey]..".plist")
	emitter:resetSystem()
    return emitter
end

--飞球特效
function HeroTrainLimitLayer:_playEmitterEffect(emitter, startNode, endNode, costKey, curCount)
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
            	local limitLevel = self._heroUnitData:getLimit_level()
            	self["_cost"..costKey]:playRippleMoveEffect(limitLevel, curCount)
            end),
            cc.RemoveSelf:create()
        )
	)
end

function HeroTrainLimitLayer:_playLvUpEffect()
	local function effectFunction(effect)
        return cc.Node:create()
    end

    local function eventFunction(event)
    	if event == "faguang" then
    		
        elseif event == "finish" then
            self:_updateView()
            self:_playHeroAnimation()
            self:_playFire(true)
			local delay = cc.DelayTime:create(0.5) --延迟x秒播飘字
		    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		    	self:_playPrompt()
		    end))
		    self:runAction(sequence)
        end
    end

	G_EffectGfxMgr:createPlayMovingGfx(self._nodeHetiMoving, "moving_tujieheti", effectFunction, eventFunction , true)

	for key = HeroConst.HERO_LIMIT_COST_KEY_1, HeroConst.HERO_LIMIT_COST_KEY_4 do
		self["_costNode"..key]:setLocalZOrder(ZORDER_MOVE)
		self["_cost"..key]:playSMoving()
	end
end

--播放武将动作
function HeroTrainLimitLayer:_playHeroAnimation()
	local heroBaseId = self._heroUnitData:getBase_id()
	local limitLevel = 3
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId, nil, nil, limitLevel)
	local actionName = param.res_cfg.show_action
	if actionName ~= "" then
		self._nodeHero:playAnimationOnce(actionName)
	end
	G_HeroVoiceManager:playVoiceWithHeroId(heroBaseId, true)
end

function HeroTrainLimitLayer:_playPrompt()
    local summary = {}
	local content = Lang.get("summary_hero_limit_break_success")
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
function HeroTrainLimitLayer:_addBaseAttrPromptSummary(summary)
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
function HeroTrainLimitLayer:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageTitle = UIHelper.swapWithLabel(self._imageTitle,{ 
			 style = "limit_2", 
			 text = Lang.getImgText("txt_limit_06") ,
		})
	end
end

function HeroTrainLimitLayer:_adjustPosI18n()
	if not Lang.checkLang(Lang.CN) then
		local size1 = self._imageTitle:getContentSize()
		local size2 = self._textName:getContentSize()
		self._imageTitle:setPositionX(-size2.width* 0.5)
		self._textName:setPositionX(size1.width* 0.5-size2.width*0.5 + 6)
		
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self,"NodeMid","Image1")
		local size = image1:getContentSize()
		image1:setContentSize(cc.size(size1.width+size2.width+200,size.height))
	end
	
end

--i18n
function HeroTrainLimitLayer:_dealByI18n()
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

return HeroTrainLimitLayer
