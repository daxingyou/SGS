--
-- Author: hedili
-- Date: 2018-01-30 17:57:20
-- 神兽界限突破
local ViewBase = require("app.ui.ViewBase")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PetTrainLimitLayer = class("PetTrainLimitLayer", ListViewCellBase)
local PetTrainHelper = require("app.scene.view.petTrain.PetTrainHelper")
local PetLimitCostNode = require("app.scene.view.petTrain.PetLimitCostNode")
local PetLimitCostPanel = require("app.scene.view.petTrain.PetLimitCostPanel2")
local LimitCostConst = require("app.const.LimitCostConst")
local PetConst = require("app.const.PetConst")
local CSHelper = require("yoka.utils.CSHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local TextHelper = require("app.utils.TextHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")

function PetTrainLimitLayer:ctor(parentView)
	self._parentView = parentView
	local resource = {
		file = Path.getCSB("PetTrainLimitLayer2", "pet"),
		size = G_ResolutionManager:getDesignSize(),
		binding = { 
			_buttonBreak = {
				events = {{event = "touch", method = "_onButtonBreak"}}
			}
		}
	}
	self:enableNodeEvents()   
	self:setName("PetTrainLimitLayer")
	PetTrainLimitLayer.super.ctor(self, resource, 2006)
end

function PetTrainLimitLayer:onCreate()
	self:_doLayout()
	-- i18n change lable
	if not Lang.checkLang(Lang.CN) then
		self:_swapImageByI18n()
	end
	--i18n
	self:_dealByI18n()
	self._materialFakeCount = nil --材料假个数
	self._materialFakeCostCount = nil --材料假的消耗个数
	self._materialFakeCurSize = 0
	self._petNameOrgX = 0 		-- 名字初始位置

	self:_initUI()
	self:_initAvatar()
	self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst.FUNC_PET_TRAIN_TYPE3)
end

function PetTrainLimitLayer:onEnter()
	self._signalPetLimitUpMaterial =
		G_SignalManager:add(SignalConst.EVENT_PET_LIMITUP_MATERIAL_SUCCESS, handler(self, self._onEventPetLimitUpPutRes))

	self._signalPetLimitUpSuccess =
		G_SignalManager:add(SignalConst.EVENT_PET_LIMITUP_SUCCESS, handler(self, self._petLimitUpSuccess))		
end

function PetTrainLimitLayer:onExit()
	self._signalPetLimitUpMaterial:remove()
	self._signalPetLimitUpMaterial = nil

	self._signalPetLimitUpSuccess:remove()
	self._signalPetLimitUpSuccess = nil
end

function PetTrainLimitLayer:_doLayout()

	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)                   --  设置node节点尺寸
end

function PetTrainLimitLayer:_initAvatar()
	-- self._petAvatar = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
	self._petAvatar:setConvertType(TypeConvertHelper.TYPE_PET)
	self._petAvatar:setScale(1.0)
	self._petAvatar:setShadowScale(2.7) --神兽影子放大

	-- 北闽神鲲/神鲲特殊处理
	self._petAvatar:setPositionY(30)
	local unitData = G_UserData:getPet():getUnitDataWithId(G_UserData:getPet():getCurPetId())
	if unitData:getBase_id() == 109 or unitData:getBase_id() == 9 then   
		self._petAvatar:setPositionY(30*3)
	end   
	print(G_UserData:getPet():getCurPetId(), unitData:getBase_id()) 
end

function PetTrainLimitLayer:initInfo()
	self:_updateData()
	self:_updateView()
	self:_updateCost()
	self:_playFire(true)
end

function PetTrainLimitLayer:_updateView()
	self:_updatePet()
	self:_updateInfoUI()
	self:_updateNodeSliver()
end

function PetTrainLimitLayer:_updatePet()
	local config = self._petUnitData:getConfig()
	local petBaseId = config.potential_after > 0 and config.potential_after or config.id
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_PET, petBaseId)

	self._nodeTitle:setName(5)
	self._petName:setString(param.name)
	self._petName:setColor(param.icon_color)
	self._petName:enableOutline(param.icon_color_outline)
	self._petAvatar:updateUI(petBaseId)
	self._petAvatar:playAnimationLoopIdle()
	--self._fileNodeStar:setCount(self._petUnitData:getStar())

	-- 更新名字描述
	if config.potential_after>0 then 		-- 未界限突破
		self._imageTitle:setVisible(true)
		--self._petName:setPositionX(self._petNameOrgX)
	else
		self._imageTitle:setVisible(false)
		local sz = self._petName:getContentSize()
		--self._petName:setPositionX(-sz.width*0.5)
	end
	--self._imageTitle:setPositionX(self:getContentSize().width*0.5) 
	--self._petName:setPositionX(self:getContentSize().width*0.5)
	self._petName:setFontSize(18)
end

function PetTrainLimitLayer:_updateInfoUI()
	local isCan = PetTrainHelper.canLimit(self._petUnitData, true)
	--self._buttonBreak:setVisible(isCan)
	self._buttonBreak:setEnabled(isCan)  -- 策划需求：不隐藏按钮  
	--self._nodeSilver:setVisible(isCan)
end

function PetTrainLimitLayer:_petLimitUpSuccess()
	-- self._parentView:refreshBtnAndUI() 
end

-- 界限突破道具消耗返回
function PetTrainLimitLayer:_onEventPetLimitUpPutRes(id, costKey)
	self:_updateData()
	if costKey ~= LimitCostConst.BREAK_LIMIT_UP then -- 非突破操作
		self:_putResEffect(costKey)
		self:_updateNodeSliver()
	else
		local AudioConst = require("app.const.AudioConst")
		G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_TUPO)
		self:_playLvUpEffect()
	end
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint()
	end
	-- self:_updateCost()
end

function PetTrainLimitLayer:_playLvUpEffect()
	local function effectFunction(effect)
		return cc.Node:create()
	end
	local function eventFunction(event)
		if event == "faguang" then
		elseif event == "finish" then
			self:_updateView()
			self:_playFire(true)
			local delay = cc.DelayTime:create(0.5) --延迟x秒播飘字
			local sequence =
				cc.Sequence:create(
				delay,
				cc.CallFunc:create(
					function()
						if self and self._parentView then
							self:_playPrompt()
							self._parentView:refreshBtnAndUI() -- 开始显示界限按钮 刷新神兽形象
						end
					end
				)
			)
			self:runAction(sequence)
		end
	end
	G_EffectGfxMgr:createPlayMovingGfx(self._parentView._nodeHetiMoving, "moving_tujieheti", effectFunction, eventFunction, true)
	for key = LimitCostConst.LIMIT_COST_KEY_1, LimitCostConst.LIMIT_COST_KEY_4 do
		self["_cost" .. key]:playSMoving()
	end
end

-- 更新银币和突破按钮状态信息
function PetTrainLimitLayer:_updateNodeSliver()
	if self._petUnitData:getConfig().potential_after == 0 then
		self._nodeSilver:setVisible(false)
		self._buttonBreak:setVisible(false)
		return
	end
	self._buttonBreak:setVisible(true)
	self._nodeSilver:setVisible(true)
	local isCan = PetTrainHelper.canLimit(self._petUnitData, true)
	self._buttonBreak:setEnabled(isCan)

 
	local silver = PetTrainHelper.getCurLimitCostInfo()["coin_size"]
	local strSilver = TextHelper.getAmountText3(silver)
	self._nodeSilver:setCount(strSilver, nil, true)
	if isCan then
		-- self._buttonBreak:setVisible(isCan)
		-- self._nodeSilver:setVisible(isCan)

		-- local silver = PetTrainHelper.getCurLimitCostInfo()["coin_size"] -- bug: 只有能界限时货币数量才正确
		-- local strSilver = TextHelper.getAmountText3(silver)
		-- self._nodeSilver:setCount(strSilver, nil, true)
		
		--self._nodeSilver:setVisible(silver > 0)
		local isEnough = false
		local UserDataHelper = require("app.utils.UserDataHelper")
		local haveCoin = UserDataHelper.getNumByTypeAndValue(TypeConvertHelper.TYPE_RESOURCE, 2) -- 银币数量
		isEnough = haveCoin >= silver
		-- if isEnough then
		-- 	self._nodeSilver:setTextColorToDTypeColor()
		-- else
		-- 	self._nodeSilver:setCountColorRed(true)
		-- end
		self._buttonBreak:showRedPoint(isCan and isEnough)
	end
	-- 调位置
	local width = self._nodeSilver:getChildByName("Text"):getContentSize().width + 12 + self._nodeSilver:getChildByName("Image"):getContentSize().width*0.8 			
	width = width*0.5
	self._nodeSilver:setPositionX(width*-1) 
end

function PetTrainLimitLayer:_playFire(isPlay)
	self._parentView._nodeFire:removeAllChildren()
	local effectName = isPlay and "effect_tujietiaozi_1" or "effect_tujietiaozi_2"
	local quality = self._petUnitData:getQuality()
	if quality == PetConst.QUALITY_RED then
		local effect = EffectGfxNode.new(effectName)
		self._parentView._nodeFire:addChild(effect)
		effect:play()
		self._planeMaxLimit:setVisible(true)
	end
end

-- 释放特效
function PetTrainLimitLayer:_putResEffect(costKey)
	if self._popupPanel == nil then
		self:_updateCost()
		return
	end

	if self._materialFakeCostCount and self._materialFakeCostCount > 0 then --如果假球已经飞过了，就不再播球了，直接播剩下的特效和飘字
		self._materialFakeCostCount = nil
		self:_updateCost()
	else
		local curCount = self._petUnitData:getMaterials()[costKey] or 0
		for i, material in ipairs(self._costMaterials) do
			local itemId = material.id
			local emitter = self:_createEmitter(costKey)
			local startNode = self._popupPanel:findNodeWithItemId(itemId)
			local endNode = self["_costNode" .. costKey]
			self["_cost" .. costKey]:lock()
			self:_playEmitterEffect(emitter, startNode, endNode, costKey, curCount)
		end
	end
	self._popupPanel:updateUI()
	if self:_checkIsMaterialFull(costKey) == true then
		self._popupPanel:close()
	end
end

function PetTrainLimitLayer:_updateData()
	local petId = G_UserData:getPet():getCurPetId()
	self._petUnitData = G_UserData:getPet():getUnitDataWithId(petId)

	local UserDataHelper = require("app.utils.UserDataHelper")
	local param = {unitData = self._petUnitData}
	local attrInfo = UserDataHelper.getPetTotalAttr(param)
	self._recordAttr:updateData(attrInfo)
	G_UserData:getAttr():recordPower()
end

-- 初始化UI
function PetTrainLimitLayer:_initUI()
	-- self._imageBg:setVisible(false)  ????
	self._petNameOrgX = self._petName:getPositionX()
	self:_initCostIcon()
	local TypeConvertHelper = require("app.utils.TypeConvertHelper")
	local DataConst = require("app.const.DataConst")
	self._parentView._buttonShow:updateLangName("pet_limit_up_help_txt")

	self._buttonBreak:setFontSize(20)
	self._buttonBreak:setFontName(Path.getFontW8())
	self._buttonBreak:setString(Lang.get("pet_limit_break_btn"))
	self._nodeSilver:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_GOLD)
	--self._nodeSilver:setTextColorToDTypeColor()
	self._nodeSilver:getChildByName("Text"):setFontSize(18)
	self._nodeSilver:getChildByName("Text"):setPositionX(18 + 15)
	self._nodeSilver:getChildByName("Image"):setPositionY(18)
	self._nodeSilver:getChildByName("Image"):setScale(0.8)
	--G_EffectGfxMgr:createPlayMovingGfx(self._parentView._nodeBgMoving, "moving_tujie_huohua", nil, nil, false) 火星特效去除
	G_EffectGfxMgr:createPlayMovingGfx(self._parentView._nodeBgMoving, "moving_shengshoushenghong_middle", nil, nil, false)
	self:_adjustScaleAndPos()	
	-- 修改背景图
	local scene = G_SceneManager:getTopScene()
	scene:getSceneView():changeBackground(Path.getLimitImgBg("img_limit_bg01"))
end

function PetTrainLimitLayer:_adjustScaleAndPos()
	-- 父界面展示
	self._parentView._nodeLimit:setVisible(true)  	 
	self._parentView._nodeDetail:setVisible(true)
	self._parentView._nodeDetail:getChildByName("_buttonShow"):setVisible(true)
	self._parentView._nodeDetail:getChildByName("_buttonPreview"):setVisible(true)

	-- 调整+号 文字位置
	for key = LimitCostConst.LIMIT_COST_KEY_1, LimitCostConst.LIMIT_COST_KEY_4 do
		ccui.Helper:seekNodeByName(self["_costNode"..key], "ButtonAdd"):setScale(0.7) -- +号缩放
		local _imageName = ccui.Helper:seekNodeByName(self["_costNode"..key], "ImageName")
		local _textPercent = ccui.Helper:seekNodeByName(self["_costNode"..key], "TextPercent")
		
		_imageName:setAnchorPoint(cc.p(0.5, 0.5))  
		_imageName:setPosition(cc.p(0, -53))
		_textPercent:setAnchorPoint(cc.p(0.5, 0.5))
		_textPercent:setPosition(cc.p(0, -76))

		_textPercent:setFontSize(18)
		_textPercent:setColor(Colors.BRIGHT_BG_ONE)
		_textPercent:disableEffect(cc.LabelEffect.OUTLINE)
		if not Lang.checkLang(Lang.CN) then
			_imageName:setFontSize(18)
			_imageName:setColor(Colors.NORMAL_BG_ONE) 
			_imageName:disableEffect(cc.LabelEffect.OUTLINE)
		end
		ccui.Helper:seekNodeByName(self["_costNode"..key], "NodeFull"):getParent():setScale(0.9) 	-- 这个node缩放90%
	end
end

-- 打开材料面板
function PetTrainLimitLayer:_openPopupPanel(costKey, limitLevel)
	if self._popupPanel ~= nil then
		return
	end

	self._popupPanel =
		PetLimitCostPanel.new(
		costKey,
		handler(self, self._onClickCostPanelItem),
		handler(self, self._onClickCostPanelStep),
		handler(self, self._onClickCostPanelStart),
		handler(self, self._onClickCostPanelStop),
		limitLevel,
		self["_costNode" .. costKey]
	)
	self._popupPanelSignal = self._popupPanel.signal:add(handler(self, self._onPopupPanelClose))
	--self._parentView._nodePopup:addChild(self._popupPanel)
	G_SceneManager:getRunningScene():addChild(self._popupPanel)
	self._popupPanel:setPosition(cc.p(G_ResolutionManager:getDesignWidth()*0.5, G_ResolutionManager:getDesignHeight()*0.5 )) 
	self._popupPanel:updateUI()
end

-- 检查能否界限突破
function PetTrainLimitLayer:_checkCanLimit()
	local curRank = self._petUnitData:getRank_lv()
	local star = self._petUnitData:getStar()
	local isReach, needRank = PetTrainHelper.isReachLimitRank(limitLevel, curRank)
	return isReach, needRank
end

-- 检查材料是否已满
function PetTrainLimitLayer:_checkIsMaterialFull(costKey)
	local curCount = self._petUnitData:getMaterials()[costKey]
	local costInfo = PetTrainHelper.getCurLimitCostInfo()
	return curCount >= costInfo["size_" .. costKey]
end

-- 处理界限突破逻辑
function PetTrainLimitLayer:_doPutRes(costKey, materials)
	if not PetTrainHelper.petStarCanLimit(self._petUnitData) then
		G_Prompt:showTip(Lang.get("pet_limit_up_star_not"))
		return
	end
	local subItem = materials[1]
	G_UserData:getPet():c2sPetPostRankUpMaterial(self._petUnitData:getId(), subItem, costKey)
	self._costMaterials = materials
end

function PetTrainLimitLayer:_createEmitter(costKey)
	local names = {
		[LimitCostConst.LIMIT_COST_KEY_1] = "tujiegreen",
		[LimitCostConst.LIMIT_COST_KEY_2] = "tujieblue",
		[LimitCostConst.LIMIT_COST_KEY_3] = "tujiepurple",
		[LimitCostConst.LIMIT_COST_KEY_4] = "tujieorange"
	}
	local emitter = cc.ParticleSystemQuad:create("particle/" .. names[costKey] .. ".plist")
	emitter:resetSystem()
	return emitter
end

--飞球特效
function PetTrainLimitLayer:_playEmitterEffect(emitter, startNode, endNode, costKey, curCount)
	local function getRandomPos(startPos, endPos)
		local pos11 = cc.p(startPos.x + (endPos.x - startPos.x) * 1 / 2, startPos.y + (endPos.y - startPos.y) * 3 / 4)
		local pos12 = cc.p(startPos.x + (endPos.x - startPos.x) * 1 / 4, startPos.y + (endPos.y - startPos.y) * 1 / 2)
		local pos21 = cc.p(startPos.x + (endPos.x - startPos.x) * 3 / 4, startPos.y + (endPos.y - startPos.y) * 1 / 2)
		local pos22 = cc.p(startPos.x + (endPos.x - startPos.x) * 1 / 2, startPos.y + (endPos.y - startPos.y) * 1 / 4)
		local tbPos = {
			[1] = {pos11, pos12},
			[2] = {pos21, pos22}
		}

		local index = math.random(1, 2)
		return tbPos[index][1], tbPos[index][2]
	end
	local UIHelper = require("yoka.utils.UIHelper")
	local startPos = UIHelper.convertSpaceFromNodeToNode(startNode, self._parentView._panelDesign) -- self) 
	emitter:setPosition(startPos)
	G_SceneManager:getRunningScene():addChild(emitter)  --self:addChild(emitter)
	local endPos = UIHelper.convertSpaceFromNodeToNode(endNode, self._parentView._panelDesign) -- self) 
	local pointPos1, pointPos2 = getRandomPos(startPos, endPos)
	local bezier = {
		pointPos1,
		pointPos2,
		endPos
	}
	local action1 = cc.BezierTo:create(0.7, bezier)
	local action2 = cc.EaseSineIn:create(action1)

	emitter:runAction(
		cc.Sequence:create(
			action2,
			cc.CallFunc:create(
				function()
					self["_cost" .. costKey]:playRippleMoveEffect(1, curCount)
				end
			),
			cc.RemoveSelf:create()
		)
	)
end

-- 点击消耗材料
function PetTrainLimitLayer:_onClickCostPanelItem(costKey, materials)
	if self:_checkIsMaterialFull(costKey) == true then
		return
	end
	self:_doPutRes(costKey, materials)
end

-- 持续按住消耗材料按钮每步调用
function PetTrainLimitLayer:_onClickCostPanelStep(costKey, itemId, itemValue, costCountEveryTime)
	if self._materialFakeCount <= 0 then
		return false
	end

	local costInfo = PetTrainHelper.getCurLimitCostInfo()
	if self._materialFakeCurSize >= costInfo["size_" .. costKey] then
		G_Prompt:showTip(Lang.get("limit_material_full"))
		return false, nil, true
	end

	local realCostCount = math.min(self._materialFakeCount, costCountEveryTime)
	self._materialFakeCount = self._materialFakeCount - realCostCount
	self._materialFakeCostCount = self._materialFakeCostCount + realCostCount

	local costSizeEveryTime = realCostCount
	if costKey == LimitCostConst.LIMIT_COST_KEY_1 then
	    costSizeEveryTime = itemValue * realCostCount
	end
	self._materialFakeCurSize = self._materialFakeCurSize + costSizeEveryTime

	if self._popupPanel then
		local emitter = self:_createEmitter(costKey)
		local startNode = self._popupPanel:findNodeWithItemId(itemId)
		local endNode = self["_costNode" .. costKey]
		self:_playEmitterEffect(emitter, startNode, endNode, costKey, self._materialFakeCurSize)
		startNode:setCount(self._materialFakeCount)
	end
	return true, realCostCount
end

-- 开始按住消耗材料
function PetTrainLimitLayer:_onClickCostPanelStart(costKey, itemId, count)
	self._materialFakeCount = count
	self._materialFakeCostCount = 0
	local materials = self._petUnitData:getMaterials() -- 材料当前进度
	self._materialFakeCurSize = materials[costKey] or 0
end

function PetTrainLimitLayer:_onClickCostPanelStop()
end

-- 材料面板关闭
function PetTrainLimitLayer:_onPopupPanelClose(event)
	if event == "close" then
		self._popupPanel = nil
		if self._popupPanelSignal then
			self._popupPanelSignal:remove()
			self._popupPanelSignal = nil
		end
	end
end

-- 点击详情按钮
function PetTrainLimitLayer:_onButtonDetail()
	local PopupPetLimitDetail = require("app.scene.view.petTrain.PopupPetLimitDetail").new(self._petUnitData)
	PopupPetLimitDetail:openWithAction()
end

-- 界限突破
function PetTrainLimitLayer:_onButtonBreak()
	local petId = self._petUnitData:getId()
	G_UserData:getPet():c2sPetRankUp(petId)
end

-- 初始化四类小球
function PetTrainLimitLayer:_initCostIcon()
	for key = LimitCostConst.LIMIT_COST_KEY_1, LimitCostConst.LIMIT_COST_KEY_4 do
		self["_cost" .. key] = PetLimitCostNode.new(self["_costNode" .. key], key, handler(self, self._onClickCostAdd))
	end
end

-- 点击添加材料按钮（）
function PetTrainLimitLayer:_onClickCostAdd(costKey)
	self:_openPopupPanel(costKey, 1)
end

-- 更新小球数据
function PetTrainLimitLayer:_updateCost()
	local materials = self._petUnitData:getMaterials()
	for key = LimitCostConst.LIMIT_COST_KEY_1, LimitCostConst.LIMIT_COST_KEY_4 do
		local curCount = materials[key] or 0
		self["_cost" .. key]:updateUI(1, curCount)
		--self["_cost" .. key]:enableTextOutline(true)
		self["_costNode" .. key]:setVisible(self._petUnitData:getConfig().potential_after > 0)
		local isShow = PetTrainHelper.isPromptPetLimitWithCostKey(self._petUnitData, key)
		self["_cost"..key]:showRedPoint(isShow)
	end

end

function PetTrainLimitLayer:_playPrompt()
    local summary = {}
	local content = Lang.get("summary_pet_limit_break_success")
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
function PetTrainLimitLayer:_addBaseAttrPromptSummary(summary)
	local attr = self._recordAttr:getAttr()
	local desInfo = TextHelper.getAttrInfoBySort(attr)
	local UIConst = require("app.const.UIConst")
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
function PetTrainLimitLayer:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageTitle = UIHelper.swapWithLabel(self._imageTitle,
			{
				style = "instrument_limit_1", 
				text = Lang.getImgText("txt_limit_06f") ,
			}
		)

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
function PetTrainLimitLayer:_dealByI18n()
	if Lang.checkLang(Lang.JA) then
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

 

return PetTrainLimitLayer
