-- 备注：此类专为养成系统界限和涅槃用   
local CommonLimitCostNode = class("CommonLimitCostNode")
local UIActionHelper = require("app.utils.UIActionHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local HeroConst = require("app.const.HeroConst")
local LimitCostConst = require("app.const.LimitCostConst")
local AudioConst = require("app.const.AudioConst")
local UIHelper  = require("yoka.utils.UIHelper")

CommonLimitCostNode.POSY_START = -46 --0%水纹位置
CommonLimitCostNode.POSY_END = 30 --100%水纹位置

function CommonLimitCostNode:ctor(target, costKey, callback, index)
    self._target = target
    self._costKey = costKey
    self._callback = callback
    self._index = index or 1
    self._isShowCount = false       -- 是否显示数量，默认显示百分比
    self._isFull = false            --是否满了
    self:_init()
    self:_check()
end

function CommonLimitCostNode:_init()
    self._nodeNormal = ccui.Helper:seekNodeByName(self._target, "NodeNormal")
    self._nodeFull = ccui.Helper:seekNodeByName(self._target, "NodeFull")

    self._imageButtom = ccui.Helper:seekNodeByName(self._target, "ImageButtom")
    self._imageFront = ccui.Helper:seekNodeByName(self._target, "ImageFront")
    self._nodeRipple = ccui.Helper:seekNodeByName(self._target, "NodeRipple")
    self._imageName = ccui.Helper:seekNodeByName(self._target, "ImageName")
    self._textPercent = ccui.Helper:seekNodeByName(self._target, "TextPercent")
    self._nodeCount = ccui.Helper:seekNodeByName(self._target, "NodeCount")
    self._nodeCount:setVisible(false)
    self._buttonAdd = ccui.Helper:seekNodeByName(self._target, "ButtonAdd")
    self._buttonAdd:addClickEventListenerEx(handler(self, self._onClickAdd))
    UIActionHelper.playBlinkEffect2(self._buttonAdd)
    self._nodeEffectBg = ccui.Helper:seekNodeByName(self._target, "NodeEffectBg")
    self._nodeEffect = ccui.Helper:seekNodeByName(self._target, "NodeEffect")
    self._redPoint = ccui.Helper:seekNodeByName(self._target, "RedPoint")

    self._imageButtom:setLocalZOrder(-2)
    local clip = UIHelper.setCircleClip(self._nodeRipple, 37)
    clip:setLocalZOrder(-1)
    -- i18n change lable
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local label = UIHelper.swapWithLabel(self._imageName,{ 
				style = "limit_1", 
				text = Lang.getImgText(LimitCostConst.RES_NAME[self._costKey].imageName[self._index]),
		})
		self._imageName = label
	else
		self._imageName:loadTexture(Path.getTextLimit(LimitCostConst.RES_NAME[self._costKey].imageName[self._index]))
    end
    
 
    self:initImageFront()
    self:initRipple()
    self:changeImageName()
    self:initEffectBg()

    G_EffectGfxMgr:createPlayMovingGfx(self._nodeFull, self:getMoving(), nil, nil, false)

    local posX, posY = self._target:getPosition()
    self._initPos = cc.p(posX, posY)

   
      -- i18n change pos
      self:_adjustPosI18n()
end

-- 重写
function CommonLimitCostNode:getMoving()
    return LimitCostConst.RES_NAME[self._costKey].moving[self._index]
end

-- 重写
function CommonLimitCostNode:initImageFront()
    self:_initImageFront(
        LimitCostConst.RES_NAME[self._costKey].imageButtom[self._index],
        LimitCostConst.RES_NAME[self._costKey].imageFront[self._index]
    )

    if self:_isLimitUI() and self._costKey < 5 then
        local res = {"img_limit_1", "img_limit_2", "img_limit_3", "img_limit_4"} 
        self._imageFront:removeAllChildren()
        local imageBg = ccui.ImageView:create()
        local picName = Path.getTextTeam(res[self._costKey])
		imageBg:loadTexture(picName)
		imageBg:setPosition(cc.p(0, 0))
        self._nodeNormal:addChild(imageBg)
        self._nodeNormal:setLocalZOrder(3)
        self._redPoint:setLocalZOrder(4)
        self._nodeNormal:setScale(0.97)
        imageBg:setScale(1.03)
        if self._costKey == 4 then
            self._nodeNormal:setScale(0.97)
            imageBg:setScale(1.045)
        end
    end
  
end

-- 重写
function CommonLimitCostNode:initRipple()
    self:_initRipple(LimitCostConst.RES_NAME[self._costKey].ripple[self._index])
end

-- 重写
function CommonLimitCostNode:initEffectBg()
    self:_initEffectBg(LimitCostConst.RES_NAME[self._costKey].effectBg[self._index])
end

function CommonLimitCostNode:_initImageFront(buttomResId, frontResId)
    self._imageButtom:loadTexture(Path.getLimitImg(buttomResId))
    self._imageFront:loadTexture(Path.getLimitImg(frontResId))
end

function CommonLimitCostNode:_initRipple(animation)
    local spineRipple = require("yoka.node.SpineNode").new()
    self._nodeRipple:addChild(spineRipple)
    spineRipple:setAsset(Path.getEffectSpine("tujieshui"))
    spineRipple:setAnimation(animation, true)
end

function CommonLimitCostNode:_initEffectBg(resId)
    if self:_isLimitUI() then  -- 美术需求：界限时屏蔽背景特效
        return
    end
  
    local effectBg = EffectGfxNode.new(resId)
    self._nodeEffectBg:addChild(effectBg)
    effectBg:play()
end

-- node名称 需重写
function CommonLimitCostNode:changeImageName()
    -- i18n change lable
    if Lang.checkLang(Lang.CN) then
        self._imageName:loadTexture(Path.getTextLimit(LimitCostConst.RES_NAME[self._costKey].imageName[self._index]))
    else
        self._imageName:setString(
            Lang.getImgText(LimitCostConst.RES_NAME[self._costKey].imageName[self._index])
        )
    end
end

-- 可重写 检查设置显示百分比还是比值
function CommonLimitCostNode:_check()
    self._isShowCount = true
end

-- 可重写  记得调用_updateCommonUI
function CommonLimitCostNode:updateUI(limitLevel, curCount, limitRed)
    limitRed = limitRed or 0
    self:_updateCommonUI(limitLevel, curCount, limitRed)
end

function CommonLimitCostNode:_updateCommonUI(limitLevel, curCount, limitRed)
    -- if limitRed and limitRed~=0 then
    --     local txtColorOutline = cc.c4b(0x00, 0x00, 0x00, 0xff)   -- 黑色
    --     self._textPercent:enableOutline(txtColorOutline,2)
    -- else
    --     limitRed = 0
	-- 	self._textPercent:disableEffect(cc.LabelEffect.OUTLINE)
    -- end
    self._textPercent:disableEffect(cc.LabelEffect.OUTLINE)

    self._target:setVisible(true)
    local percent, totalCount = self:_calPercent(limitLevel, curCount, limitRed)
    self._isFull = percent >= 100
    local ripplePos = self:_getRipplePos(percent)
    self._nodeRipple:setPosition(ripplePos.x, ripplePos.y)
    if self._isShowCount then --显示数量
        self._textPercent:setString(curCount .."/" .. totalCount)
    else
        self._textPercent:setString(percent .. "%")
    end
    self:_updateState()
    self._target:setPosition(self._initPos)
    -- i18n change pos
    self:_adjustPosI18n()
end

function CommonLimitCostNode:_onClickAdd()
    if self._lock or self._isFull then
        return
    end
    if self._callback then
        self._callback(self._costKey)
    end
end

function CommonLimitCostNode:_getRipplePos(percent)
    local height = (self.class.POSY_END - self.class.POSY_START) * percent / 100
    local targetPosY = self.class.POSY_START + height
    return {x = 0, y = targetPosY}
end

-- 计算节点数量比值 需重写
function CommonLimitCostNode:_calPercent(limitLevel, curCount, limitRed)
    return 0, 1
end

function CommonLimitCostNode:playRippleMoveEffect(limitLevel, curCount, limitRed)
    limitRed = limitRed or 0
    self._nodeRipple:stopAllActions()
    local percent, totalCount = self:_calPercent(limitLevel, curCount, limitRed)
    self._isFull = percent >= 100
    local targetPos = self:_getRipplePos(percent)
    local action = cc.MoveTo:create(0.4, cc.p(targetPos.x, targetPos.y))
    self._nodeRipple:runAction(action)
    if self._isShowCount then --显示数量
        self._textPercent:setString(curCount .. "/" .. totalCount)
    else
        logWarn("CommonLimitCostNode:playRippleMoveEffect " .. percent)
        self._textPercent:setString(percent .. "%")
    end
    self:_playEffect(self._isFull)
    -- i18n change pos
    self:_adjustPosI18n()
end

function CommonLimitCostNode:_playEffect(isFull)
    if isFull then
        logWarn(" CommonLimitCostNode:_playEffect Full")
        G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_YINMAN)
        self:_playFullEffect()
    else
        logWarn(" CommonLimitCostNode:_playEffect not Full")
        self:_playCommonEffect()
    end
end

--播放一般粒子到达特效
function CommonLimitCostNode:_playCommonEffect()
    local function eventFunc(event)
        if event == "finish" then
            self:_updateState()
        end
    end
    local effectReceive = EffectGfxNode.new(self:getEffectReceiveName(), eventFunc)
    effectReceive:setAutoRelease(true)
    -- self._nodeEffect:addChild(effectReceive)   -- 这种写法特效会被llistview裁剪
    local runningScene = G_SceneManager:getRunningScene()
    local View = runningScene:getSceneView() 
    runningScene:addChild(effectReceive)--View._panelDesign:getParent():addChild(effectReceive)  bug：parent修改为scene 因为神兽的_nodeDetileView层级比较高 导致遮挡
    local worldPos = self._target:getParent():convertToWorldSpace(cc.p(self._target:getPositionX(), self._target:getPositionY()))
    --worldPos = View._panelDesign:getParent():convertToNodeSpace(worldPos)
    effectReceive:setPosition(worldPos)
    effectReceive:play()
end

function CommonLimitCostNode:getEffectReceiveName()
    return LimitCostConst.RES_NAME[self._costKey].effectReceive[self._index]
end

--播放满时的特效
function CommonLimitCostNode:_playFullEffect()
    local function eventFunc(event)
        if event == "fuck" then
            self:_updateState()
        end
    end
    local effectName = self:getFullEffectName()
    local effectFull = EffectGfxNode.new(effectName, eventFunc)
    effectFull:setAutoRelease(true)
    self._nodeEffect:addChild(effectFull)
    effectFull:play()
end

function CommonLimitCostNode:getFullEffectName()
    return LimitCostConst.RES_NAME[self._costKey].effectFull[self._index]
end

-- 重写 播放突界动画
function CommonLimitCostNode:playSMoving()
    self:_playSmoving(LimitCostConst.RES_NAME[self._costKey].smoving[self._index])
end

-- 成功后几个球球飞向武将/神兽
function CommonLimitCostNode:_playSmoving(smoving) 
    local avatar = nil 
    local scene = G_SceneManager:getTopScene()   

    local view = scene:getSceneView()
    local pageView = view:getPageView()
    -- 球球飞向 
    local newWorldPos = cc.p(0, 0)
    if scene:getName() == "heroDetail" then 
        newWorldPos = pageView:getParent():convertToWorldSpace(cc.p(pageView:getPositionX(), pageView:getPositionY()))
    elseif scene:getName() == "petDetail" then    
        newWorldPos = pageView:getParent():convertToWorldSpace(cc.p(pageView:getPositionX()+60, pageView:getPositionY()))
    end    
    newWorldPos = self._target:getParent():convertToNodeSpace(newWorldPos)
    local moveAction = cc.MoveTo:create(0.8, cc.p(newWorldPos.x, newWorldPos.y))
    local callAction = cc.CallFunc:create(function()
        self._target:stopAllActions()
        self._target:setVisible(false)
        self:setListViewClipping(true)
    end)   

    
    local seqAction = cc.Sequence:create(moveAction, callAction)
    self._target:stopAllActions()
    self._target:runAction(seqAction)
    self:setListViewClipping(false)
end

-- 处理觉醒成功时四个球球飞向神兽被裁剪
function CommonLimitCostNode:setListViewClipping(bEnable)   
	local runningScene = G_SceneManager:getRunningScene()
    local view = runningScene:getSceneView() 
    local list = view:getDetailViewNode():getChildren()[1]._listView
	list:setClippingEnabled(bEnable)
end

function CommonLimitCostNode:_updateState()
    self._nodeFull:setVisible(self._isFull)
    self._nodeNormal:setVisible(not self._isFull)
    self._lock = false
 
    if self._isFull and self:_isLimitUI() then   -- 美术需求：界限满时不显示特效
        self._redPoint:setVisible(false) 
        self._buttonAdd:setVisible(false) 
        self._nodeFull:setVisible(false)
        self._nodeNormal:setVisible(self._isFull)
    elseif not self._isFull and self:_isLimitUI() then
        self._buttonAdd:setVisible(true)          -- 界限突破成功后 显示加号
    end
end

function CommonLimitCostNode:isFull()
    return self._isFull
end

function CommonLimitCostNode:showRedPoint(show)
    self._redPoint:setVisible(show)
end

function CommonLimitCostNode:lock()
    self._lock = true
end

function CommonLimitCostNode:setVisible(visible)
    self._target:setVisible(visible)
end

function CommonLimitCostNode:_adjustPosI18n()
    do return end
    
	if not Lang.checkLang(Lang.CN) then
		if self._isShowCount  then
			
		else
			local size1 = self._imageName:getContentSize()
			local size2 = self._textPercent:getContentSize()
			self._imageName:setPositionX(-size2.width* 0.5)
			self._textPercent:setPositionX(size1.width* 0.5+3)
		end

	end
	
end

-- 是否是界限界面
function CommonLimitCostNode:_isLimitUI()
    do return true end    -- 写死
    local runningScene = G_SceneManager:getRunningScene()
    local view = runningScene:getSceneView() 
    if view._nodeHeroDetailView and view._nodeHeroDetailView:getChildrenCount() > 0 then   
        local tabIndex = view._nodeHeroDetailView:getChildren()[1]:getTabSelect()
        -- if view._nodeHeroDetailView:getChildren()[1]._cname == "HeroTrainLimitLayer2" then
        --     return true
        -- end
        if tabIndex == 4 then       
            return true
        end
    end

    return false
end



return CommonLimitCostNode
