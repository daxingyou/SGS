-- Author: Liangxu
-- Date: 2018-8-7
-- 神兵界限消耗Node

local InstrumentLimitCostNode = class("InstrumentLimitCostNode")
local InstrumentDataHelper = require("app.utils.data.InstrumentDataHelper")
local UIActionHelper = require("app.utils.UIActionHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local InstrumentConst = require("app.const.InstrumentConst")

local POSY_START = -46 --0%水纹位置
local POSY_END = 30 --100%水纹位置

local RES_NAME = {
	[InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_1] = {
		imageButtom = "img_limit_03",
		imageFront = "img_limit_03c",
		ripple = "purple",
		imageName = "txt_limit_03",
		effectBg = "effect_tujiepurple",
		moving = "moving_tujieballpurple",
		effectReceive = "effect_tujiedianjipurple",
		effectFull = "effect_tujie_mannengliangpurple",
		smoving = "smoving_shenbingtujie_left"
	},
	[InstrumentConst.INSTRUMENT_LIMIT_COST_KEY_2] = {
		imageButtom = "img_limit_04",
		imageFront = "img_limit_04c",
		ripple = "orange",
		imageName = "txt_limit_04",
		effectBg = "effect_tujieorange",
		moving = "moving_tujieballorange",
		effectReceive = "effect_tujiedianjiorange",
		effectFull = "effect_tujie_mannengliangorange",
		smoving = "smoving_shenbingtujie_right"
	}
}

function InstrumentLimitCostNode:ctor(target, costKey, callback)
	self._target = target
	self._costKey = costKey
	self._callback = callback
	self._isShowCount = false -- 是否显示数量，默认显示百分比
	self._isFull = false --是否满了
	self:_init()
	self:_check()
end

function InstrumentLimitCostNode:_init()
	self._nodeNormal = ccui.Helper:seekNodeByName(self._target, "NodeNormal")
	self._nodeFull = ccui.Helper:seekNodeByName(self._target, "NodeFull")

	self._imageButtom = ccui.Helper:seekNodeByName(self._target, "ImageButtom")
	self._imageFront = ccui.Helper:seekNodeByName(self._target, "ImageFront")
	self._nodeRipple = ccui.Helper:seekNodeByName(self._target, "NodeRipple")
	self._imageName = ccui.Helper:seekNodeByName(self._target, "ImageName")
	self._textPercent = ccui.Helper:seekNodeByName(self._target, "TextPercent")
	self._nodeCount = ccui.Helper:seekNodeByName(self._target, "NodeCount")
	self._buttonAdd = ccui.Helper:seekNodeByName(self._target, "ButtonAdd")
	self._buttonAdd:addClickEventListenerEx(handler(self, self._onClickAdd))
	UIActionHelper.playBlinkEffect2(self._buttonAdd)
	self._nodeEffectBg = ccui.Helper:seekNodeByName(self._target, "NodeEffectBg")
	self._nodeEffect = ccui.Helper:seekNodeByName(self._target, "NodeEffect")
	self._redPoint = ccui.Helper:seekNodeByName(self._target, "RedPoint")

	self._imageButtom:loadTexture(Path.getLimitImg(RES_NAME[self._costKey].imageButtom))
	self._imageFront:loadTexture(Path.getLimitImg(RES_NAME[self._costKey].imageFront))

	local spineRipple = require("yoka.node.SpineNode").new()
	self._nodeRipple:addChild(spineRipple)
	spineRipple:setAsset(Path.getEffectSpine("tujieshui"))
	spineRipple:setAnimation(RES_NAME[self._costKey].ripple, true)

	-- i18n change lable
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageName = UIHelper.swapWithLabel(self._imageName,{ 
			 style = "limit_1", 
			 text = Lang.getImgText(RES_NAME[self._costKey].imageName),
		})
	else
		self._imageName:loadTexture(Path.getTextLimit(RES_NAME[self._costKey].imageName))
	end
	local effectBg = EffectGfxNode.new(RES_NAME[self._costKey].effectBg)
	self._nodeEffectBg:addChild(effectBg)
	effectBg:play()

	G_EffectGfxMgr:createPlayMovingGfx(self._nodeFull, RES_NAME[self._costKey].moving, nil, nil, false)

	local posX, posY = self._target:getPosition()
	self._initPos = cc.p(posX, posY)
	self:_adjustPosI18n()
end

function InstrumentLimitCostNode:_check()
	self._isShowCount = true
end

function InstrumentLimitCostNode:updateUI(templateId, limitLevel, curCount)
	if limitLevel >= InstrumentConst.INSTRUMENT_LIMIT_MAX_LEVEL then
		self._isFull = false
		self._target:setVisible(false)
		return
	end

	self._target:setVisible(true)
	local percent, totalCount = self:_calPercent(templateId, limitLevel, curCount)
	self._isFull = percent >= 100
	local ripplePos = self:_getRipplePos(percent)
	self._nodeRipple:setPosition(ripplePos.x, ripplePos.y)
	if self._isShowCount then --显示数量
		self._textPercent:setString("")
		self._nodeCount:removeAllChildren()
		local content = Lang.get("instrument_limit_cost_count", {curCount = curCount, totalCount = totalCount})
		local richText = ccui.RichText:createWithContent(content)
		richText:setAnchorPoint(cc.p(0, 0.5))
		self._nodeCount:addChild(richText)
	else
		self._textPercent:setString(percent .. "%")
	end
	self:_updateState()
	self._target:setPosition(self._initPos)
	self:_adjustPosI18n()
end

function InstrumentLimitCostNode:_onClickAdd()
	if self._callback then
		self._callback(self._costKey)
	end
end

function InstrumentLimitCostNode:_getRipplePos(percent)
	local height = (POSY_END - POSY_START) * percent / 100
	local targetPosY = POSY_START + height
	return {x = 0, y = targetPosY}
end

function InstrumentLimitCostNode:_calPercent(templateId, limitLevel, curCount)
	local info = InstrumentDataHelper.getInstrumentRankConfig(templateId, limitLevel)
	local size = info["size_" .. self._costKey] or 0
	local percent = math.floor(curCount / size * 100)
	return math.min(percent, 100), size
end

function InstrumentLimitCostNode:playRippleMoveEffect(templateId, limitLevel, curCount)
	self._nodeRipple:stopAllActions()
	local percent, totalCount = self:_calPercent(templateId, limitLevel, curCount)
	self._isFull = percent >= 100
	local targetPos = self:_getRipplePos(percent)
	local action = cc.MoveTo:create(0.4, cc.p(targetPos.x, targetPos.y))
	self._nodeRipple:runAction(action)
	if self._isShowCount then --显示数量
		self._textPercent:setString("")
		self._nodeCount:removeAllChildren()
		local content = Lang.get("instrument_limit_cost_count", {curCount = curCount, totalCount = totalCount})
		local richText = ccui.RichText:createWithContent(content)
		richText:setAnchorPoint(cc.p(0, 0.5))
		self._nodeCount:addChild(richText)
	else
		self._textPercent:setString(percent .. "%")
	end
	self:_playEffect(self._isFull)
	self:_adjustPosI18n()
end

function InstrumentLimitCostNode:_playEffect(isFull)
	if isFull then
		local AudioConst = require("app.const.AudioConst")
		G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_YINMAN)
		self:_playFullEffect()
	else
		self:_playCommonEffect()
	end
end

--播放一般粒子到达特效
function InstrumentLimitCostNode:_playCommonEffect()
	local function eventFunc(event)
		if event == "finish" then
			self:_updateState()
		end
	end
	local effectReceive = EffectGfxNode.new(RES_NAME[self._costKey].effectReceive, eventFunc)
	effectReceive:setAutoRelease(true)
	self._nodeEffect:addChild(effectReceive)
	effectReceive:play()
end

--播放满时的特效
function InstrumentLimitCostNode:_playFullEffect()
	local function eventFunc(event)
		if event == "fuck" then
			self:_updateState()
		end
	end
	local effectFull = EffectGfxNode.new(RES_NAME[self._costKey].effectFull, eventFunc)
	effectFull:setAutoRelease(true)
	self._nodeEffect:addChild(effectFull)
	effectFull:play()
end

function InstrumentLimitCostNode:playSMoving()
	G_EffectGfxMgr:applySingleGfx(
		self._target,
		RES_NAME[self._costKey].smoving,
		function()
			self._target:setVisible(false)
		end
	)
end

function InstrumentLimitCostNode:_updateState()
	self._nodeFull:setVisible(self._isFull)
	self._nodeNormal:setVisible(not self._isFull)
end

function InstrumentLimitCostNode:isFull()
	return self._isFull
end

function InstrumentLimitCostNode:showRedPoint(show)
	self._redPoint:setVisible(show)
end

function InstrumentLimitCostNode:_adjustPosI18n()
	if not Lang.checkLang(Lang.CN) then
		if self._isShowCount  then
			local countLabel = self._nodeCount:getChildren()[1]
			countLabel:formatText()
			local size1 = self._imageName:getContentSize()
			local size2 = countLabel:getContentSize()
			self._imageName:setPositionX(-size2.width* 0.5)
			self._nodeCount:setPositionX(size1.width* 0.5-size2.width* 0.5+3)
		else
			local size1 = self._imageName:getContentSize()
			local size2 = self._textPercent:getContentSize()
			self._imageName:setPositionX(-size2.width* 0.5)
			self._textPercent:setPositionX(size1.width* 0.5+5)
		end

	end
	
end
return InstrumentLimitCostNode