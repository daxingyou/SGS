--
-- Author: Liangxu
-- Date: 2018-3-6 18:46:56
-- 觉醒结果
local PopupBase = require("app.ui.PopupBase")
local PopupAwakeResult = class("PopupAwakeResult", PopupBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local AttributeConst = require("app.const.AttributeConst")
local CSHelper = require("yoka.utils.CSHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local TextHelper = require("app.utils.TextHelper")

function PopupAwakeResult:ctor(parentView, heroId)
    self._parentView = parentView
	self._heroId = heroId

	local resource = {
		file = Path.getCSB("PopupAwakeResult", "hero"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClickTouch"}},
			}
		}
	}
	PopupAwakeResult.super.ctor(self, resource)
end

function PopupAwakeResult:onCreate()
	for i = 1, 4 do
		self["_fileNodeAttr"..i]:setNameColor(Colors.LIST_TEXT)
		self["_fileNodeAttr"..i]:setCurValueColor(Colors.DARK_BG_ONE)
		self["_fileNodeAttr"..i]:setNextValueColor(Colors.DARK_BG_ONE)
		self["_fileNodeAttr"..i]:showDiffValue(false)
	end
    self:_dealPosI18n()
end

function PopupAwakeResult:onEnter()
	self._canContinue = false
	self:_updateInfo()
	self:_initEffect()
	self:_playEffect()
    self:_playCurHeroVoice()
end

function PopupAwakeResult:onExit()
	
end

function PopupAwakeResult:_onClickTouch()
	if self._canContinue then
		self:close()
	end
end

function PopupAwakeResult:_updateInfo()
	self._heroUnitData = G_UserData:getHero():getUnitDataWithId(self._heroId)
    local heroBaseId = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)
    local awakeCost = UserDataHelper.getHeroConfig(heroBaseId).awaken_cost
	local awakeLevel = self._heroUnitData:getAwaken_level()
	local heroAwakenConfig = UserDataHelper.getHeroAwakenConfig(awakeLevel, awakeCost)
    if heroAwakenConfig then
        self._talentDes = heroAwakenConfig.talent_description
    else
        self._talentDes = Lang.get("hero_break_txt_all_unlock")
    end

    local star1, level1 = UserDataHelper.convertAwakeLevel(awakeLevel-1)
    local star2, level2 = UserDataHelper.convertAwakeLevel(awakeLevel)
	self._textOldLevel:setString(Lang.get("hero_awake_star_level", {star = star1, level = level1}))
	self._textNewLevel:setString(Lang.get("hero_awake_star_level", {star = star2, level = level2}))
    self._commonStar:setStarOrMoonForPlay(star1)

	local curAttr = UserDataHelper.getAwakeAttr(self._heroUnitData, -1)
	local nextAttr = UserDataHelper.getAwakeAttr(self._heroUnitData)
    local curDesInfo = TextHelper.getAttrInfoBySort(curAttr)
    local nextDesInfo = TextHelper.getAttrInfoBySort(nextAttr)
    for i = 1, 4 do
        local curInfo = curDesInfo[i]
        local nextInfo = nextDesInfo[i] or {}
        if curInfo then
            self["_fileNodeAttr"..i]:updateInfo(curInfo.id, curInfo.value, nextInfo.value, 4)
            self["_textDiffValue"..i]:setString(nextInfo.value - curInfo.value)
            self["_fileNodeAttr"..i]:setVisible(true)
            self["_textDiffValue"..i]:setVisible(true)
        else
            self["_fileNodeAttr"..i]:setVisible(false)
            self["_textDiffValue"..i]:setVisible(false)
        end
        self["_fileNodeAttr"..i]:setNextValueColor(Colors.DARK_BG_ONE)
    end
end

function PopupAwakeResult:_playCurHeroVoice()
    local baseId = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)
    G_HeroVoiceManager:playVoiceWithHeroId(baseId, true)
end

function PopupAwakeResult:_initEffect()
	self._nodeContinue:setVisible(false)
	self._nodeTxt1:setVisible(false)
	self._nodeTxt3:setVisible(false)
	for i = 1, 4 do
		self["_fileNodeAttr"..i]:setVisible(false)
	end
end

function PopupAwakeResult:_playEffect()
	local function effectFunction(effect)
        if effect == "effect_wujiangbreak_jiesuotianfu" then
            local subEffect = EffectGfxNode.new("effect_wujiangbreak_jiesuotianfu")
            subEffect:play()
            return subEffect
        end

        if effect == "moving_wujiangbreak_jiesuo" then
            local desNode = CSHelper.loadResourceNode(Path.getCSB("BreakResultTalentDesNode", "hero"))
            local textTalentName = ccui.Helper:seekNodeByName(desNode, "TextTalentName")
            local textTalentDes = ccui.Helper:seekNodeByName(desNode, "TextTalentDes")
            local imageButtomLine = ccui.Helper:seekNodeByName(desNode, "ImageButtomLine")
            textTalentName:setString("")
            local nameSize = textTalentName:getContentSize()
            local namePosX = textTalentName:getPositionX()

            local render = textTalentDes:getVirtualRenderer()
            render:setMaxLineWidth(290 - nameSize.width)
            textTalentDes:setString(self._talentDes)
            textTalentDes:setPositionX(namePosX + nameSize.width + 5)
            local desSize = textTalentDes:getContentSize()
            local posLineY = textTalentDes:getPositionY() - desSize.height - 5
            posLineY = math.min(posLineY, 0)
            imageButtomLine:setPositionY(posLineY)

            if Lang.checkLang(Lang.EN) or  Lang.checkLang(Lang.TH)  then

				local template = "[{\"type\":\"text\",\"msg\":\"#name#\",\"color\":\"0xCC3B0A\",\"fontSize\":22}, \
									{\"type\":\"text\",\"msg\":\" #des#\",\"color\":\"0xFCEFD4\",\"fontSize\":22}]"
				local richTxt = Lang.getTxt(template,{name ="" ,des = self._talentDes})
				local lineSize = imageButtomLine:getContentSize()
				local richText = ccui.RichText:createWithContent(richTxt)
				richText:setAnchorPoint(cc.p(0,1))
				richText:ignoreContentAdaptWithSize(false)
				richText:setContentSize(cc.size(lineSize.width-40, 0))
				if Lang.checkLang(Lang.TH) then
					richText:setVerticalSpace(8)
				end
				richText:formatText()
				local x,y = textTalentName:getPosition()
				richText:setPosition(x,y)
				imageButtomLine:getParent():addChild(richText)

	
				local posLineY = textTalentDes:getPositionY() - richText:getVirtualRendererSize().height - 5
				posLineY = math.min(posLineY, 0)
				imageButtomLine:setPositionY(posLineY)

				textTalentName:setVisible(false)
				textTalentDes:setVisible(false)
			end

            return desNode
        end

    	if effect == "moving_wujiangbreak_txt_1" then
    		
    	end

    	if effect == "effect_wujiangbreak_jiantou" then
    		local subEffect = EffectGfxNode.new("effect_wujiangbreak_jiantou")
            subEffect:play()
            return subEffect
    	end

    	if effect == "moving_jueseshengxing_role" then
    		local node = self:_createRoleEffect()
    		return node
    	end

    	if effect == "effect_wujiangbreak_heidi" then
    		local subEffect = EffectGfxNode.new("effect_wujiangbreak_heidi")
            subEffect:play()
            return subEffect
    	end
    		
        if  not Lang.checkLang(Lang.CN) and effect == "routine_word_wujiangbreak_juexing_tianfu" then
            local TypeConst = require("app.i18n.utils.TypeConst")
            local UIHelper = require("yoka.utils.UIHelper")
            local subLabel = UIHelper.createLabel({text=Lang.getEffectText("effect_awake_talent"),style="effect_text_40",styleType=TypeConst.EFFECT})
            return subLabel
		end


        return cc.Node:create()
    end

    local function eventFunction(event)
    	local stc, edc = string.find(event, "play_txt2_")
    	if stc then
    		local index = string.sub(event, edc+1, -1)
    		self["_fileNodeAttr"..index]:setVisible(true)
    		self["_fileNodeAttr"..index]:showArrow(false)
    		G_EffectGfxMgr:applySingleGfx(self["_fileNodeAttr"..index], "smoving_wujiangbreak_txt_2", nil, nil, nil)
    	elseif event == "play_txt1" then
    		self._nodeTxt1:setVisible(true)
    		G_EffectGfxMgr:applySingleGfx(self._nodeTxt1, "smoving_wujiangbreak_txt_1", nil, nil, nil)
        elseif event == "star" then
            local awakeLevel = self._heroUnitData:getAwaken_level()
            local star = UserDataHelper.convertAwakeLevel(awakeLevel)
        	self._commonStar:playStarOrMoon(star)
        elseif event == "play_txt3" then
        	self._nodeTxt3:setVisible(true)
        	G_EffectGfxMgr:applySingleGfx(self._nodeTxt3, "smoving_wujiangbreak_txt_3", nil, nil, nil)
        elseif event == "finish" then
        	self._canContinue = true
        	self._nodeContinue:setVisible(true)
        end
    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_jueseshengxing", effectFunction, eventFunction , false)
    effect:setPosition(cc.p(0, 0))
    
end

function PopupAwakeResult:_createRoleEffect()
	local function effectFunction(effect)
        if effect == "effect_wujiangbreak_xingxing" then
            local subEffect = EffectGfxNode.new("effect_wujiangbreak_xingxing")
            subEffect:play()
            return subEffect
        end

        if effect == "effect_wujiangbreak_guangxiao" then
        	local subEffect = EffectGfxNode.new("effect_wujiangbreak_guangxiao")
            subEffect:play()
            return subEffect
        end

        if effect == "effect_shenshoubreak_tupochenggong" then
        	local subEffect = EffectGfxNode.new("effect_shenshoubreak_tupochenggong")
            subEffect:play()
            return subEffect
        end

    	if effect == "effect_wujiangbreak_luoxia" then
    		local subEffect = EffectGfxNode.new("effect_wujiangbreak_luoxia")
            subEffect:play()
            return subEffect
    	end

    	if effect == "levelup_role" then
    		local heroSpine = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
            local heroBaseId, isEquipAvatar, avatarLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)
            local limitLevel = avatarLimitLevel or self._heroUnitData:getLimit_level()
			heroSpine:updateUI(heroBaseId, nil, nil, limitLevel)
			heroSpine:showShadow(false)
			return heroSpine
    	end

    	if effect == "effect_wujiangbreak_fazhen" then
    		local subEffect = EffectGfxNode.new("effect_wujiangbreak_fazhen")
            subEffect:play()
            return subEffect
    	end

    	if effect == "effect_wujiangbreak_txt_di" then
    		local subEffect = EffectGfxNode.new("effect_wujiangbreak_txt_di")
            subEffect:play()
            return subEffect
    	end
    		
		if  not Lang.checkLang(Lang.CN) and effect == "moving_wujiangshengxingchenggong" then
			local function _effectFunction(_effect)
				if _effect == "routine_word_shengxing_zi" then
					local UIHelper = require("yoka.utils.UIHelper")
					local subLabel = UIHelper.createBMFLabel({text=Lang.getEffectText("effect_fnt_shengxingchenggong"),fontName = Path.getImgFont("effect")})
					return subLabel
				end
			end	
			local _node = cc.Node:create()
			local effect = G_EffectGfxMgr:createPlayMovingGfx(_node, "moving_wujiangshengxingchenggong", _effectFunction, nil , false)
			return _node
		end
    		
        return cc.Node:create()
    end

    local function eventFunction(event)
        if event == "finish" then
        
        end
    end

    local node = cc.Node:create()
	local effect = G_EffectGfxMgr:createPlayMovingGfx(node, "moving_jueseshengxing_role", effectFunction, eventFunction , false)
    -- effect:setPosition(cc.p(0, 0))
    return node
end

-- i18n pos lable
function PopupAwakeResult:_dealPosI18n()
	if not Lang.checkLang(Lang.CN) then
		self._textOldLevel:setAnchorPoint(cc.p(1,0.5))
		self._textOldLevel:setPositionX(-self._textNewLevel:getPositionX()-4)
	end
	if Lang.checkLang(Lang.TH) then
		self._textOldLevel:setFontSize(self._textOldLevel:getFontSize()+2)
		self._textNewLevel:setFontSize(self._textNewLevel:getFontSize()+2)
		for i = 1, 4 do
			local textName = ccui.Helper:seekNodeByName(self["_fileNodeAttr"..i], "TextName")
			textName:setFontSize(textName:getFontSize()+2)
		end
	end
end


return PopupAwakeResult