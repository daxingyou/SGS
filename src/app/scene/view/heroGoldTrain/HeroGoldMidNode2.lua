local HeroGoldMidNode = class("HeroGoldMidNode")
local LimitCostConst = require("app.const.LimitCostConst")

function HeroGoldMidNode:ctor(target, callback)
    self._target = target
    self._effectNode1 = ccui.Helper:seekNodeByName(self._target, "EffectNode1")
    self._effectNode2 = ccui.Helper:seekNodeByName(self._target, "EffectNode2")
    self._imageHead = ccui.Helper:seekNodeByName(self._target, "ImageHead")
    self._imageName = ccui.Helper:seekNodeByName(self._target, "ImageName")
    self._textPercent = ccui.Helper:seekNodeByName(self._target, "TextPercent")
    self._imageTips = ccui.Helper:seekNodeByName(self._target, "ImageTips")
    self._panelTouch = ccui.Helper:seekNodeByName(self._target, "TouchPanel")
    self._panelTouch:addClickEventListenerEx(handler(self, self._panelTouchClicked))
    self._callback = callback
    self._imageHead:ignoreContentAdaptWithSize(true)
    self._imageName:ignoreContentAdaptWithSize(true) 
    self:_playMoving(self._effectNode1, "moving_jinjiangyangcheng_touxiang")

    self._imgBlack = ccui.Helper:seekNodeByName(self._target, "Image_black")
    self._imgAdd = ccui.Helper:seekNodeByName(self._target, "add")
    self._nodeCircle = ccui.Helper:seekNodeByName(self._target, "nodeCircle")

    -- i18n change lable
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageName = UIHelper.swapWithLabel(self._imageName,{ 
				style = "text_limit_1", 
				text = Lang.getImgText("txt_goldhero_cultivate_shu01"),
        })
        
        self._imageTips = UIHelper.swapWithLabel(self._imageTips,{ 
            style = "text_limit_2", 
            text = Lang.getImgText("txt_goldhero_cultivate_04"),
        })
    end

end
function HeroGoldMidNode:_panelTouchClicked()
    if self._callback then
        self._callback(nil, self.bSkip)
    end
end

function HeroGoldMidNode:updateNode(unitData)
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local UserDataHelper = require("app.utils.UserDataHelper")
    local HeroGoldHelper = require("app.scene.view.heroGoldTrain.HeroGoldHelper")
    local oweCount =
        UserDataHelper.getSameCardCount(TypeConvertHelper.TYPE_HERO, unitData:getBase_id(), unitData:getId())
    local costInfo = HeroGoldHelper.heroGoldTrainCostInfo(unitData)
    local txt = oweCount .. "/" .. costInfo["cost_hero"]
    local iconRes = HeroGoldHelper.getHeroIconRes(unitData:getBase_id())
    self._imageHead:loadTexture(Path.getGoldHero(iconRes))
    if HeroGoldHelper.heroGoldCanRankUp(unitData) then
        self:_switchUI(true)
        self:_playMoving(self._effectNode2, "moving_jinjiangyangcheng_touxiangkedianji")
    else
        self:_switchUI(false)
        self._textPercent:setString(txt)
        local nameRes = HeroGoldHelper.getHeroNameRes(unitData:getBase_id())
       
		if Lang.checkLang(Lang.CN) then
             self._imageName:loadTexture(Path.getTextLimit(nameRes))
        else
            self._imageName:setString( Lang.getImgText(nameRes))
        end

        -- i18n change lable
        if not Lang.checkLang(Lang.CN) then
            local UIHelper  = require("yoka.utils.UIHelper")
            local image2 = UIHelper.seekNodeByName(self._target,"Image_2")
            UIHelper.alignCenter(image2,{self._imageName,self._textPercent})
        end
    end
    self:_refreshFaceUI(unitData, oweCount, costInfo["cost_hero"])  -- i18n ja 
end

function HeroGoldMidNode:_playMoving(node, movingName)
    node:removeAllChildren()
    G_EffectGfxMgr:createPlayMovingGfx(
        node,
        movingName,
        function(key)
            if key == "touxiang" then
                return self:_getHeadIamge()
            end
        end,
        nil
    )
end

function HeroGoldMidNode:_switchUI(switch)
    self._imageTips:setVisible(switch)
    self._effectNode2:setVisible(switch)
    self._imageName:setVisible(not switch)
    self._textPercent:setVisible(not switch)
end

-- i18n ja change UI  需求：1条件满了后，这里就不要再提示：点击涅槃了另外点击也不再出发涅槃  2数量不足的时候拥有数量红色显示。够了的话绿色显示。
function HeroGoldMidNode:_refreshFaceUI(unitData, oweCount, numTotal)
    local HeroGoldHelper = require("app.scene.view.heroGoldTrain.HeroGoldHelper")
    if HeroGoldHelper.heroGoldCanRankUp(unitData) then
        self._imageTips:setVisible(false)
        self._panelTouch:setTouchEnabled(false)
        ccui.Helper:seekNodeByName(self._target, "Image_2"):setVisible(false)
    end
 
    if self._textPercent:getParent():getChildByName("HeroGoldNum") then
        self._textPercent:getParent():removeChildByName("HeroGoldNum")
    end
    if self._textPercent:isVisible() then
        ccui.Helper:seekNodeByName(self._target, "Image_2"):setVisible(true)
        local richText = ""
        if oweCount < numTotal then
            richText = Lang.get("Hero_Gold_Num_2", {num = oweCount, value = numTotal})
        else  
            richText = Lang.get("Hero_Gold_Num_1", {num = oweCount, value = numTotal})
        end

        local widget = ccui.RichText:createWithContent(richText)
        widget:setAnchorPoint(cc.p(0,0.5))
        widget:setPosition(self._textPercent:getPositionX(), self._textPercent:getPositionY() - 1.5)  
        self._textPercent:getParent():addChild(widget)
        widget:setName("HeroGoldNum")
        
        self._textPercent:setVisible(false)
    end

    -- 数量不足时 显示跳转
    self.bSkip = oweCount < numTotal
    self._nodeCircle:setVisible(oweCount < numTotal)
    if oweCount < numTotal then      
        self._panelTouch:setTouchEnabled(true)
        local nodeCiclre = self.setCircleClip(self._imgBlack, 55)
        --self._imgBlack:setLocalZOrder(0)
        nodeCiclre:setLocalZOrder(0)
        self._imgAdd:setLocalZOrder(1)

        local UIActionHelper = require("app.utils.UIActionHelper")
        UIActionHelper.playBlinkEffect(self._imgAdd)
    end
end

function HeroGoldMidNode:_getHeadIamge()
    local image = ccui.ImageView:create()
    return image
end

 
-- 为节点添加圆形裁减
function HeroGoldMidNode.setCircleClip(node, radius)
    local pos = cc.p(node:getPosition())
    local parent = node:getParent()

    local drawNodeCircle = cc.DrawNode:create()
    local angle = 180
    local freg = 100
    local scaleX = 1.0
    local scaleY = 1.0
    local color = cc.c4f(1, 1, 1, 1)
    drawNodeCircle:drawSolidCircle(pos, radius, angle, freg, scaleX, scaleY, color)

    local stencil = cc.Node:create()
    stencil:addChild(drawNodeCircle)
    local clippingNode = cc.ClippingNode:create()
    clippingNode:setStencil(stencil)
    parent:addChild(clippingNode)
    clippingNode:setPosition(pos)
    node:retain()  -- 必须retrain  or节点的referentCount=0
    node:removeFromParent(false)
    clippingNode:addChild(node)
    node:release()    -- 在release
    clippingNode:setInverted(false)
    clippingNode:setAlphaThreshold(1)
    clippingNode:setName("clippingNode")

    return clippingNode
end
 


return HeroGoldMidNode

 