-- Author: liangxu
-- Date:2017-10-18 16:26:18
-- Describle：

local CommonLimitBaseView = require("app.scene.view.heroGoldTrain.CommonLimitBaseView2")
local HeroGoldTrainLayer = class("HeroGoldTrainLayer", CommonLimitBaseView)
local HeroGoldLevelNode = require("app.scene.view.heroGoldTrain.HeroGoldLevelNode")
local LimitCostConst = require("app.const.LimitCostConst")
local HeroConst = require("app.const.HeroConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local HeroGoldHelper = require("app.scene.view.heroGoldTrain.HeroGoldHelper")
local HeroGoldMidNode = require("app.scene.view.heroGoldTrain.HeroGoldMidNode2")
local UIConst = require("app.const.UIConst")

HeroGoldTrainLayer.limitPopupPanel = require("app.scene.view.heroGoldTrain.HeroGoldCostPanel")
HeroGoldTrainLayer.limitCostNode = require("app.scene.view.heroGoldTrain.HeroGoldCostNode")

local NORNAL_WIDTH = 420
local MAX_WIDTH = 600

function HeroGoldTrainLayer:ctor(parentView)
    self._parentView = parentView

    local resource = {
        file = Path.getCSB("HeroGoldTrainLayer2", "hero"),
        --size = G_ResolutionManager:getDesignSize(),
        binding = {
            _buttonTalentDes = {
				events = {{event = "touch", method = "_onButtonTalentDesClicked"}},
            },
            _buttonBreak = {
				events = {{event = "touch", method = "_onButtonBreakClicked"}},
			}
        }
    }
    self:enableNodeEvents() 
    HeroGoldTrainLayer.super.ctor(self, parentView, resource)
end

function HeroGoldTrainLayer:onCreate()
    -- i18n change lable
	self:_swapImageByI18n()
    self:_doLayout()

    self:_initUI()
    self:setLvUpCallback(handler(self, self._lvUpCallBack))
end

function HeroGoldTrainLayer:onEnter()
    self._signalEventHeroGoldPutRes =
        G_SignalManager:add(
        SignalConst.EVENT_GOLD_HERO_RESOURCE_SUCCESS,
        handler(self, self._onEventHeroGoldRankUpPutRes)
    )

    self:_updateData()
    self:_updateCost()
    self:_updateView()
    self:_updateNodeSliver()
    self:_checkCostNodeRedPoint()
    self._cost1:updateNode(self._heroUnitData)
    self._parentView._listView:setClippingEnabled(false)
end

function HeroGoldTrainLayer:onExit()
    self._signalEventHeroGoldPutRes:remove()
    self._signalEventHeroGoldPutRes = nil
    self._parentView._listView:setClippingEnabled(true)
end

function HeroGoldTrainLayer:initInfo()
	self:_adjustScaleAndPos()
end

function HeroGoldTrainLayer:_adjustScaleAndPos()
	-- 父界面展示
	self._parentView._nodeGold:setVisible(true)  	 
	self._parentView._nodeLimitAwakeGold:setVisible(true)
    self._parentView._nodeLimitAwakeGold:getChildByName("_buttonShow"):setVisible(true)
    self._parentView._nodeLimitAwakeGold:getChildByName("_buttonPreview"):setVisible(true)
end

function HeroGoldTrainLayer:_lvUpCallBack()
    self:_updateView()
    self:_updateCost()
    local strPos = {[2] = {-47,50}, [3] = {-154, -66}, [4] = {70, -67}}
    for key = LimitCostConst.LIMIT_COST_KEY_2, LimitCostConst.LIMIT_COST_KEY_4 do
        self["_cost" .. key]:clearEffect()
        self["_costNode" .. key]:setPosition(strPos[key][1], strPos[key][2])
    end
    self._cost1:updateNode(self._heroUnitData)
    G_UserData:getAttr():recordPowerWithKey(FunctionConst.FUNC_TEAM)
    -- G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_TEAM, UIConst.SUMMARY_OFFSET_X_GOLD, -5)
    G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_TEAM, UIConst.SUMMARY_OFFSET_X_TRAIN, -29)
	self._parentView._parentView:updateFightPower()
end

function HeroGoldTrainLayer:_updateData()
    local heroId = G_UserData:getHero():getCurHeroId()
    self._heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
end

function HeroGoldTrainLayer:_doLayout()
    local contentSize = self._parentView._listView:getContentSize() --self._panelBg:getContentSize() 
	self:setContentSize(contentSize)                                --  设置node节点尺寸   
end

function HeroGoldTrainLayer:_initUI()
    local DataConst = require("app.const.DataConst")

    self._goldLevelNode = HeroGoldLevelNode.new(self._levelNode)
    for costKey = LimitCostConst.LIMIT_COST_KEY_2, LimitCostConst.LIMIT_COST_KEY_4 do
        self["_cost" .. costKey] =
            self.class.limitCostNode.new(
            self["_costNode" .. costKey],
            self["_costDetail" .. costKey],
            costKey,
            handler(self, self._onClickCostAdd)
        )
    end
 
    self._cost1 = HeroGoldMidNode.new(self._costNode1, handler(self, self._onButtonBreakClicked))
    self._parentView._buttonShow:updateLangName("gold_hero_rank_up_help_txt")
    --self._heroAvatar:setScale(0.8)
    self._fileNodeDetailTitle:setFontSize(22)
	self._fileNodeDetailTitle:setTitle(Lang.get("hero_gold_txt_title")) 
    self._buttonBreak:setString(Lang.get("goldenhero_train_text"))
    self._txtNameLevel:setString(Lang.get("hero_transform_result_title_gold")) 

    --G_EffectGfxMgr:createPlayMovingGfx(self._nodeBgEffect, "moving_jinjiangyangcheng_beijing", nil, nil) 八卦外边一层闪烁特效
    --G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect1, "moving_jinjiangyangcheng_dabagua", nil, nil)  八卦特效
    --G_EffectGfxMgr:createPlayMovingGfx(self._parentView._nodeGoldBgMoving, "moving_tujie_huohua", nil, nil, false) --背后火星特效
end

function HeroGoldTrainLayer:_checkIsMaterialFull(costKey)
    local curCount = self._heroUnitData:getGoldResValue(costKey)
    return curCount >= self._materialMaxSize[costKey]
end

function HeroGoldTrainLayer:_doPutRes(costKey, materials)
    local heroId = self._heroUnitData:getId()
    self._curCostKey = costKey
    local heroIds, items = self:_getHeroIdsAndItems(costKey, materials)
    G_UserData:getHero():c2sGoldHeroResource(heroId, costKey, heroIds, items)
    self._costMaterials = materials
end

function HeroGoldTrainLayer:_getHeroIdsAndItems(costKey, materials)
    local heroIds = {}
    local items = {}
    local item = {}
    item.type = TypeConvertHelper.TYPE_ITEM
    item.value = materials[1].id
    item.size = materials[1].num
    table.insert(items, item)
    return heroIds, items
end

function HeroGoldTrainLayer:_updateView()
    self._heroTitle:updateUI(self._heroUnitData)
    self._goldLevelNode:setCount(self._heroUnitData:getRank_lv())
    local baseId = self._heroUnitData:getBase_id()
    local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, baseId)
    local goldLevel = self._heroUnitData:getRank_lv()
    local name = heroParam.name
    if goldLevel > 0 then
        if HeroGoldHelper.isPureHeroGold(self._heroUnitData) then -- 金将
            name = name .. " " .. Lang.get("goldenhero_train_text") .. goldLevel
        else
            name = name .. "+" .. goldLevel
        end
    end

    --goldLevel = HeroConst.HERO_GOLD_MAX_RANK  --测试满级
    if goldLevel == HeroConst.HERO_GOLD_MAX_RANK then
        self:_switchUI(false)
       -- self._heroAvatar:setVisible(true)
        self:_playFire(true) 
        self._textLevle2:setString(Lang.get("goldenhero_train_text") .. HeroConst.HERO_GOLD_MAX_RANK) 
        self._textLevle1:setString(Lang.get("goldenhero_train_text") .. HeroConst.HERO_GOLD_MAX_RANK) 
    else
        self:_switchUI(true)
        self:setButtonEnable(true)
       -- self._heroAvatar:setVisible(false)
        self._parentView._nodeGoldFire:setVisible(false) 
        self:_updateTalentDes()
    end
end

function HeroGoldTrainLayer:_updateTalentDes()
    local UserDataHelper = require("app.utils.UserDataHelper")
    local limitLevel = self._heroUnitData:getLimit_level()
    local limitRedLevel = self._heroUnitData:getLimit_rtg()
    local talentLevel = self._heroUnitData:getRank_lv()
    if talentLevel < HeroConst.HERO_GOLD_MAX_RANK then
        talentLevel = talentLevel + 1
    end
    local config = UserDataHelper.getHeroRankConfig(self._heroUnitData:getBase_id(), talentLevel, limitLevel, limitRedLevel)
    local talentName = config.talent_name
    local talentDes = config.talent_description
    local breakDes = Lang.get("hero_gold_txt_break_des", {rank = talentLevel})
    local talentInfo =
        Lang.get(
        "hero_break_txt_talent_des_ja", 
        {
            des = talentDes,
            breakDes = breakDes
        }
    )
    local height = 102
    local label = ccui.RichText:createWithContent(talentInfo)
    label:setAnchorPoint(cc.p(0.5, 1))
    label:ignoreContentAdaptWithSize(false)
    label:setContentSize(cc.size(350, 0))
    label:formatText()
    height = label:getVirtualRendererSize().height + 43
    -- local virtualSize = label:getVirtualRendererSize()
    -- local offsetX = virtualSize.width - NORNAL_WIDTH
    -- offsetX = offsetX > 0 and offsetX * 0.5 or 0
    --self._nodeOffset:setPositionX(-offsetX)
    
    --self._nodeDes:removeAllChildren()
    --self._nodeDes:addChild(label)
    if config and config.talent_target == 0 then
        --self._imageTalent:setVisible(true)
    else
        --self._imageTalent:setVisible(false)
    end

    -- _parentView天赋描述
    self._parentView._nodeGoldTalentDesPos:removeAllChildren()   
    self._parentView._textGoldTalentTitle:setString("[" .. talentName .. "]") 
    self._parentView._nodeGoldTalentDesPos:addChild(label)  
    self._parentView._imgGoldTalentBg:setContentSize(cc.size(370, height))  
   
    -- 天赋描述
    local talentTitle = Lang.get("hero_gold_txt_talent_title1", {titleDes = talentLevel})
    local labelTitle = ccui.RichText:createWithContent(talentTitle)
    -- labelTitle:setAnchorPoint(cc.p(0, 1))
    -- labelTitle:ignoreContentAdaptWithSize(false)
    -- labelTitle:setContentSize(cc.size(MAX_WIDTH, 0))
    -- labelTitle:formatText()
    self._nodeTalentTitle:removeAllChildren()
    self._nodeTalentTitle:addChild(labelTitle)
    local Names = Lang.get("hero_gold_txt_talent_title2", {talentName = talentName})
    local labelName = ccui.RichText:createWithContent(Names)
    self._nodeTalentName:removeAllChildren()
    self._nodeTalentName:addChild(labelName)  
    -- 涅槃等级
    self._txtNameLevel:setString(Lang.get("hero_transform_result_title_gold")) 
    self._textLevle1:setString(Lang.get("goldenhero_train_text") .. (talentLevel-1)) 
    self._textLevle2:setString(Lang.get("goldenhero_train_text").. talentLevel) 
end

function HeroGoldTrainLayer:_playFire(isPlay)
    do return end   -- 策划暂时不要特效
    self._parentView._nodeGoldFire:setVisible(true)
    self._parentView._nodeGoldFire:removeAllChildren()
    local EffectGfxNode = require("app.effect.EffectGfxNode")        
    local effectName = "effect_jinjiangyangcheng_huoyan"
    local effect = EffectGfxNode.new(effectName)
    self._parentView._nodeGoldFire:addChild(effect)
    effect:play()   
end

function HeroGoldTrainLayer:_switchUI(visible)
    self._nodeTalent:setVisible(visible)
    self._nodeRes:setVisible(visible)
    self._nodeResDetail:setVisible(visible)
    self._levelNode:setVisible(visible)
    self._maskBg:setVisible(visible)    
    --self._nodeEffect1:setVisible(visible)
    self._costNode1:setVisible(visible)
    self._buttonBreak:setVisible(visible)        
    self._panelLeader:setVisible(not visible)   -- 满级
end

function HeroGoldTrainLayer:setButtonEnable(enable)
    self._buttonBreak:setEnabled(enable)

    local isCan = HeroGoldHelper.heroGoldCanRankUp(self._heroUnitData)
    -- 禁用
    if self._buttonBreak:isVisible() and enable and not isCan then 
        self._buttonBreak:setEnabled(false)
    end
    
    -- 红点
    if enable and isCan then
        self._buttonBreak:showRedPoint(true)
    else 
        self._buttonBreak:showRedPoint(false)    
    end
end

function HeroGoldTrainLayer:_updateNodeSliver()
    if self._heroUnitData:getRank_lv() == HeroConst.HERO_GOLD_MAX_RANK then
        self._nodeSilver:setVisible(false)
        return
    end

    local isCan = HeroGoldHelper.heroGoldCanRankUp(self._heroUnitData)
    --self._nodeSilver:setVisible(isCan)
    isCan = true
    if isCan then
        local TextHelper = require("app.utils.TextHelper")
        local silver = HeroGoldHelper.heroGoldTrainCostInfo(self._heroUnitData)["break_size"]
        local strSilver = TextHelper.getAmountText3(silver)
        self._textSilver:setString(strSilver)
    end
end

function HeroGoldTrainLayer:_onButtonBreakClicked(sender, bSKip)
    -- 武将不足时 显示跳转
    if bSKip then
        local PopupItemGuider = require("app.ui.PopupItemGuider").new(Lang.get("way_type_get"))
        local curHeroId = G_UserData:getHero():getCurHeroId()
        local curHeroData = G_UserData:getHero():getUnitDataWithId(curHeroId)
        local heroBaseId = curHeroData:getBase_id()
        PopupItemGuider:updateUI(TypeConvertHelper.TYPE_HERO, heroBaseId)
        PopupItemGuider:openWithAction()
        return
    end

    local isCan = HeroGoldHelper.heroGoldCanRankUp(self._heroUnitData)
    if isCan then
        self._curCostKey = LimitCostConst.BREAK_LIMIT_UP
        G_UserData:getHero():c2sGoldHeroRankUp(self._heroUnitData:getId())
        self:setButtonEnable(false)         
    end
end

function HeroGoldTrainLayer:_onEventHeroGoldRankUpPutRes(id)
    self:_updateData()
    local costKey = self._curCostKey
    if costKey ~= LimitCostConst.BREAK_LIMIT_UP then -- 非突破操作
        self:_putResEffect(costKey)
        self:_updateNodeSliver()
        self._cost1:updateNode(self._heroUnitData)
    else
        local AudioConst = require("app.const.AudioConst")
        G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_TUPO)   
        --self:_playCostNodeSMoving()  CommonLimitBaseView2类中回调
        self:_playLvUpEffect()
        self:_updateNodeSliver()
    end
    self:_checkCostNodeRedPoint()
    self:setButtonEnable(true)
    self._parentView:checkRedPoint()
end

function HeroGoldTrainLayer:_checkCostNodeRedPoint()
    local rank_lv = self._heroUnitData:getRank_lv()
    for key = LimitCostConst.LIMIT_COST_KEY_2, LimitCostConst.LIMIT_COST_KEY_4 do
        local curCount = self._heroUnitData:getGoldResValue(key)
        self["_cost" .. key]:checkRedPoint(rank_lv, curCount)
    end
end

-- 可重写，获取没次增加的进度值
function HeroGoldTrainLayer:_getCostSizeEveryTime(costKey, itemValue, realCostCount, costCountEveryTime)
    if costKey == LimitCostConst.LIMIT_COST_KEY_2 then
        return itemValue * realCostCount
    else
        return realCostCount
    end
end

-- 必须重写，获取当前材料进度
function HeroGoldTrainLayer:_getFakeCurSize(costKey)
    local heroId = G_UserData:getHero():getCurHeroId()
    local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
    return heroUnitData:getGoldResValue(costKey)
end

-- 必须重写，获取每种材料最大值
function HeroGoldTrainLayer:_getMaterialMaxSize()
    local materialMaxSize = {}
    for key = LimitCostConst.LIMIT_COST_KEY_2, LimitCostConst.LIMIT_COST_KEY_4 do
        local heroId = G_UserData:getHero():getCurHeroId()
        local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
        local costInfo = HeroGoldHelper.heroGoldTrainCostInfo(heroUnitData)
        materialMaxSize[key] = costInfo["size_" .. key]
    end
    return materialMaxSize
end

-- 有哪些小球需要播放移动动画
function HeroGoldTrainLayer:_playCostNodeSMoving()
    do return end  -- 策划需求：太丑了 不要了， 用假的替代
    for key = LimitCostConst.LIMIT_COST_KEY_2, LimitCostConst.LIMIT_COST_KEY_4 do
        self["_cost" .. key]:playSMoving()
    end
end

function HeroGoldTrainLayer:_getLimitLevel()
    return self._heroUnitData:getRank_lv()
end

function HeroGoldTrainLayer:_updateCost()
    local rank_lv = self._heroUnitData:getRank_lv()
    for key = LimitCostConst.LIMIT_COST_KEY_2, LimitCostConst.LIMIT_COST_KEY_4 do
        local curCount = self._heroUnitData:getGoldResValue(key)
        self["_cost" .. key]:updateUI(rank_lv, curCount)
        local isFull, isCanFull = HeroGoldHelper.isHaveCanFullMaterialsByKey(key, self._heroUnitData)
        self["_cost" .. key]:showRedPoint(isCanFull and not isFull)
    end
end

function HeroGoldTrainLayer:_onButtonTalentDesClicked()
	self._parentView._nodeGoldTalent:setVisible( not self._parentView._nodeGoldTalent:isVisible() )
end

-- i18n change lable
function HeroGoldTrainLayer:_swapImageByI18n()
    local UIHelper  = require("yoka.utils.UIHelper")
    -- 涅磐详情
    local image1 = UIHelper.seekNodeByName(self._parentView._buttonPreview,"Image_2")
    local label = UIHelper.swapWithLabel(image1,{ 
        style = "limit_1_ja", 
        text = Lang.get("gold_limit_title"), 
    })
    label:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER  )
    label:setAnchorPoint(cc.p(0.5, 1))
    label:setPosition(cc.p(29, 17))

    -- 满涅磐
    self._panelLeader:setVisible(false)   
    self._topDes = UIHelper.swapWithLabel(self._topDes,{ 
        style = "team_max_level_ja", 
        text = Lang.getImgText("txt_train_breakthroughtop"),
    })
    self._topDes:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER  )
end

return HeroGoldTrainLayer

 



 