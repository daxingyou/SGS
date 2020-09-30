local ViewBase = require("app.ui.ViewBase")
local TeamPictureNode = class("TeamPictureNode", ViewBase)
local ShaderHalper = require("app.utils.ShaderHelper")
local CSHelper = require("yoka.utils.CSHelper")
local UIPopupHelper = require("app.utils.UIPopupHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")

TeamPictureNode.STATUS = {
    HAVENO_HERO  = -1,  -- 没有这个武将
    
    -- 保持与服务器字段相同
    CAN_ACTIVATE = 0,  -- 可以激活
    HAS_ACTIVATE = 1,  -- 已经激活
    HAS_UPGRADE  = 2,  -- 已经升级

    CAN_UPGRADE  = 3,  -- 可以升级    
}

function TeamPictureNode:ctor(parentView, heroInfo, countryId, callback)
    self._callback = callback
    self._parentView = parentView
    self._heroInfo = heroInfo
    self._countryId = countryId

    local resource = {
		file = Path.getCSB("TeamPictureNode", "teamPictureScroll"),
		binding = {
		
		},
    }
	TeamPictureNode.super.ctor(self, resource)
end

function TeamPictureNode:onCreate()
    self._panelBase:setSwallowTouches(false)
    self._panelBase:addTouchEventListener(handler(self, self._onTouchEvent))
    self:_createPictureNode()
end

function TeamPictureNode:_onTouchEvent(sender, state)
    if state == ccui.TouchEventType.ended then
        local moveOffsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
        local moveOffsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
        print("_onFinishTouch move dis "..moveOffsetX)
        print(">>>> Log _panelBaseWidth: ", self._panelBase:getContentSize().width)
        if moveOffsetX < 50 then
            if self._heroInfo.status == TeamPictureNode.STATUS.HAVENO_HERO then  -- 没有这张卡
                UIPopupHelper.popupActivate(TeamPictureNode.STATUS.HAVENO_HERO, self._heroInfo)
            elseif self._heroInfo.status == TeamPictureNode.STATUS.CAN_ACTIVATE then
                self:_addClickEffect()
                self._callback(TeamPictureNode.STATUS.CAN_ACTIVATE)  -- 可以激活
            elseif self._heroInfo.status == TeamPictureNode.STATUS.HAS_ACTIVATE then  -- 已经激活
                UIPopupHelper.popupActivate(TeamPictureNode.STATUS.HAS_ACTIVATE, self._heroInfo)
            elseif self._heroInfo.status == TeamPictureNode.STATUS.CAN_UPGRADE then  -- 可以升级
                self:_addClickEffect()
                self._callback(TeamPictureNode.STATUS.CAN_UPGRADE)
            elseif self._heroInfo.status == TeamPictureNode.STATUS.HAS_UPGRADE then
                UIPopupHelper.popupActivate(TeamPictureNode.STATUS.HAS_UPGRADE, self._heroInfo)
            end
        end
    end
end

function TeamPictureNode:refreshCellDataAndUI(status)
    self._heroInfo.status = status
    self:_refreshPictureNode()
    G_Prompt:playTotalPowerSummary()
end


function TeamPictureNode:_refreshPictureNode()
    local heroBaseId = self._heroInfo.id
    local limitLevel = self._heroInfo.limit
    local limitRedLevel = self._heroInfo.limit_red
    local isGray = false

    if self._heroInfo.status == TeamPictureNode.STATUS.HAS_ACTIVATE then
        self._avatar:removeFromParent(true)
        self._acviteSign:removeFromParent(true)
        self._acviteEffect:removeFromParent(true)

        self._avatar = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
        self._avatar:updateUI(heroBaseId, limitLevel, limitRedLevel, isGray)
        self._avatar:setScale(self._heroInfo.spineScale)
        self._avatar:setPosition(0, 0)
        self._avatar:getChildByName("Panel_1"):setClippingEnabled(false)
        self._heroAvatar:addChild(self._avatar, self._heroInfo.heroNodeZorder)

        local UTF8 = require("app.utils.UTF8")
        local length = UTF8.utf8len(self._heroInfo.name)
        self:_setNameBgGray(isGray, length)
        

        if self._heroInfo.exitUpgrade then
            self._heroInfo.status = TeamPictureNode.STATUS.CAN_UPGRADE
        end
    elseif self._heroInfo.status == TeamPictureNode.STATUS.HAS_UPGRADE then
        self._upGradeSign:removeFromParent(true)
        self._upGradeEffect:removeFromParent(true)
    end
end

function TeamPictureNode:_createPictureNode()
    self._namebg:setLocalZOrder(200)
    self._namebg:ignoreContentAdaptWithSize(true)

    local UTF8 = require("app.utils.UTF8")
    local length = UTF8.utf8len(self._heroInfo.name)
    if length == 3 then
        self._namebg:loadTexture(Path.getTeamPictureScroll("img_name2"))
        self._heroName:setPositionY(self._heroName:getPositionY() + 25)
    end


    if self._heroInfo.namePos then
        self._namebg:setPosition(self._heroInfo.namePos)
    end
    self._heroName:setString(self._heroInfo.name)

    local heroBaseId = self._heroInfo.id
    local limitLevel = self._heroInfo.limit
    local limitRedLevel = self._heroInfo.limit_rtg

    local isGray = false  -- 武将是否置灰
    local addActivateSign = false -- 是否要加激活标签
    local addUpgradeSign = false -- 是否要加升级标签

    if self._heroInfo.status == TeamPictureNode.STATUS.HAVENO_HERO then
        isGray = true
    elseif self._heroInfo.status == TeamPictureNode.STATUS.CAN_ACTIVATE then
        isGray = true
        addActivateSign = true
    elseif self._heroInfo.status == TeamPictureNode.STATUS.CAN_UPGRADE then
        addUpgradeSign = true
    end

    -- isGray = false -- 

    self:_setNameBgGray(isGray, length)

    self._avatar = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
    self._avatar:updateUI(heroBaseId, limitLevel, limitRedLevel, isGray)
    self._avatar:setScale(self._heroInfo.spineScale)
    self._avatar:setPosition(0, 0)
    self._avatar:getChildByName("Panel_1"):setClippingEnabled(false)
    self._heroAvatar:addChild(self._avatar)

    -- addActivateSign = true
    if addActivateSign then
        -- 加激活标签
        self._acviteSign = cc.Sprite:create(Path.getTeamPictureScroll("img_dengyong"))
        self._acviteSign:setPosition(self._heroInfo.signPos)
        self._heroAvatar:addChild(self._acviteSign, 10)

        self._acviteEffect = EffectGfxNode.new("effect_huijuan_dengyong")
        self._acviteEffect:play()
        self._acviteEffect:setPosition(self._heroInfo.signPos)
        self._heroAvatar:addChild(self._acviteEffect, 10)

    end

    if addUpgradeSign then
        -- 加升级标签
        self._upGradeSign = cc.Sprite:create(Path.getTeamPictureScroll("img_lvup"))
        self._upGradeSign:setPosition(self._heroInfo.signPos)
        self._heroAvatar:addChild(self._upGradeSign, 10)

        self._upGradeEffect = EffectGfxNode.new("effect_huijuan_shengji")
        self._upGradeEffect:play()
        self._upGradeEffect:setPosition(self._heroInfo.signPos)
        self._heroAvatar:addChild(self._upGradeEffect, 10)
    end
end

function TeamPictureNode:_addClickEffect()
    local subEffect = EffectGfxNode.new("effect_huijuan_tx")
    subEffect:play()
    subEffect:setPosition(self._heroInfo.signPos)
    self._heroAvatar:addChild(subEffect, 9)
end

--是否有立绘
function TeamPictureNode:_isHaveStory(heroBaseId)
    local HeroDataHelper = require("app.utils.data.HeroDataHelper")
	local info = HeroDataHelper.getHeroConfig(heroBaseId)
	local resId = info.res_id
    local resData = HeroDataHelper.getHeroResConfig(resId)
    local isHaveSpine = resData.story_res_spine ~= 0
    local isHaveRes = resData.story_res ~= 0 and resData.story_res ~= 777 --777是阴影图
    return isHaveSpine or isHaveRes
end

function TeamPictureNode:_setNameBgGray(bGray, length)
    if bGray then
        if length == 2 then
            self._namebg:loadTexture(Path.getTeamPictureScroll("img_name4"))
        elseif length == 3 then
            self._namebg:loadTexture(Path.getTeamPictureScroll("img_name5"))
        end
        self._heroName:setColor(cc.c3b(0xe7, 0xe7, 0xe7))
    else
        if length == 2 then
            self._namebg:loadTexture(Path.getTeamPictureScroll("img_name1"))
        elseif length == 3 then
            self._namebg:loadTexture(Path.getTeamPictureScroll("img_name2"))
        end
        self._heroName:setColor(cc.c3b(0xff, 0xfc, 0xd0))
    end


    -- local state = "ShaderPositionTextureColor_noMVP"
    -- if bGray then
    --     state = "ShaderUIGrayScale"
    -- end
    -- local p_state = cc.GLProgramState:getOrCreateWithGLProgramName(state)
    -- local render = self._namebg:getVirtualRenderer():getSprite()
    -- render:setGLProgramState(p_state)
end

function TeamPictureNode:getPictureNodeAllCombat()
    return self._heroInfo.all_combat
end

function TeamPictureNode:getPictureNodeFinalCombat()
    return self._heroInfo.final_combat
end

function TeamPictureNode:getPictureNodeActive_valueById(id)
    return self._heroInfo["active_value" .. id]
end

function TeamPictureNode:getPictureNodeLv_up_valueById(id)
    return self._heroInfo["lv_up_value" .. id]
end


return TeamPictureNode