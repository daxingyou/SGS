local HeroGoldMidNode = class("HeroGoldMidNode")
local LimitCostConst = require("app.const.LimitCostConst")

local HERO_NAME_RES = {
    [250] = "txt_goldhero_cultivate_shu01", -- 水镜
    [450] = "txt_goldhero_cultivate_qun01", -- 南华
    [350] = "txt_goldhero_cultivate_wu01", -- 周姬
    [150] = "txt_goldhero_cultivate_wei01" -- 子上
}

local HERO_HEAD_RES = {
    [250] = "img_gold_cultivate_hero02", -- 水镜
    [450] = "img_gold_cultivate_hero04", -- 南华
    [350] = "img_gold_cultivate_hero03", -- 周姬
    [150] = "img_gold_cultivate_hero01" -- 子上
}

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
    self:_playMoving(self._effectNode1, "moving_jinjiangyangcheng_touxiang")

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
        self._callback()
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
    self._imageHead:loadTexture(Path.getGoldHero(HERO_HEAD_RES[unitData:getBase_id()]))
    if HeroGoldHelper.heroGoldCanRankUp(unitData) then
        self:_switchUI(true)
        self:_playMoving(self._effectNode2, "moving_jinjiangyangcheng_touxiangkedianji")
    else
        self:_switchUI(false)
        self._textPercent:setString(txt)
        if Lang.checkLang(Lang.CN) then
            self._imageName:loadTexture(Path.getTextLimit(HERO_NAME_RES[unitData:getBase_id()]))
        else
            self._imageName:setString( Lang.getImgText(HERO_NAME_RES[unitData:getBase_id()]))
        end

        -- i18n change lable
        if not Lang.checkLang(Lang.CN) then
            local UIHelper  = require("yoka.utils.UIHelper")
            local image2 = UIHelper.seekNodeByName(self._target,"Image_2")
            UIHelper.alignCenter(image2,{self._imageName,self._textPercent})
        end
      

    end
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

function HeroGoldMidNode:_getHeadIamge()
    local image = ccui.ImageView:create()
    return image
end

return HeroGoldMidNode
