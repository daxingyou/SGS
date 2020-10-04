--
-- Author: Liangxu
-- Date: 2017-03-21 15:17:50
-- 突破结果
local PopupBase = require("app.ui.PopupBase")
local PopupBreakResult = class("PopupBreakResult", PopupBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local AttributeConst = require("app.const.AttributeConst")
local CSHelper = require("yoka.utils.CSHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")

function PopupBreakResult:ctor(parentView, heroId)
    self._parentView = parentView
	self._heroId = heroId

	local resource = {
		file = Path.getCSB("PopupBreakResult", "hero"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClickTouch"}},
			}
		}
	}
	PopupBreakResult.super.ctor(self, resource)
end

function PopupBreakResult:onCreate()
	for i = 1, 4 do
		self["_fileNodeAttr"..i]:setNameColor(Colors.LIST_TEXT)
		self["_fileNodeAttr"..i]:setCurValueColor(Colors.DARK_BG_ONE)
		self["_fileNodeAttr"..i]:setNextValueColor(Colors.DARK_BG_ONE)
		self["_fileNodeAttr"..i]:showDiffValue(false)
	end
end

function PopupBreakResult:onEnter()
	self._canContinue = false
	self:_updateInfo()
	self:_initEffect()
	self:_playEffect()
    self:_playCurHeroVoice()
end

function PopupBreakResult:onShowFinish( ... )
	-- body

end

function PopupBreakResult:onExit()
	
    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_END)
    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP,"PopupBreakResult:_createRoleEffect")
end

function PopupBreakResult:_onClickTouch()
	if self._canContinue then
		self:close()
	end
end

function PopupBreakResult:_updateInfo()
	self._heroUnitData = G_UserData:getHero():getUnitDataWithId(self._heroId)
	local heroBaseId, isEquipAvatar, avatarLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)

	local rankLevel = self._heroUnitData:getRank_lv()
    local limitLevel = avatarLimitLevel or self._heroUnitData:getLimit_level()
	local heroRankConfig = UserDataHelper.getHeroRankConfig(heroBaseId, rankLevel, limitLevel)
    if heroRankConfig then
		-- i18n change punc
		if not Lang.checkLang(Lang.CN) then
			self._talentName = heroRankConfig.talent_name..":"
		else
			self._talentName = heroRankConfig.talent_name.."："
		end
        self._talentDes = heroRankConfig.talent_description
    else
        self._talentName = Lang.get("hero_break_txt_all_unlock")
        self._talentDes = ""
    end

	self._textOldLevel:setString(Lang.get("hero_break_result_level", {level = rankLevel - 1}))
	local strRankLevel = Lang.get("hero_break_result_level", {level = rankLevel})
	self._textNewLevel:setString(strRankLevel)

	local curBreakAttr = UserDataHelper.getBreakAttr(self._heroUnitData, -1)
	local nextBreakAttr = UserDataHelper.getBreakAttr(self._heroUnitData)

	self._fileNodeAttr1:updateInfo(AttributeConst.ATK, curBreakAttr[AttributeConst.ATK], nextBreakAttr[AttributeConst.ATK], 3)
	self._fileNodeAttr2:updateInfo(AttributeConst.HP, curBreakAttr[AttributeConst.HP], nextBreakAttr[AttributeConst.HP], 3)
	self._fileNodeAttr3:updateInfo(AttributeConst.PD, curBreakAttr[AttributeConst.PD], nextBreakAttr[AttributeConst.PD], 3)
	self._fileNodeAttr4:updateInfo(AttributeConst.MD, curBreakAttr[AttributeConst.MD], nextBreakAttr[AttributeConst.MD], 3)
    for i = 1, 4 do
        self["_fileNodeAttr"..i]:setNextValueColor(Colors.DARK_BG_ONE)
    end

	self._textDiffValue1:setString(nextBreakAttr[AttributeConst.ATK] - curBreakAttr[AttributeConst.ATK])
	self._textDiffValue2:setString(nextBreakAttr[AttributeConst.HP] - curBreakAttr[AttributeConst.HP])
	self._textDiffValue3:setString(nextBreakAttr[AttributeConst.PD] - curBreakAttr[AttributeConst.PD])
	self._textDiffValue4:setString(nextBreakAttr[AttributeConst.MD] - curBreakAttr[AttributeConst.MD])
	
	-- i18n pos lable
	self:_dealByI18n()
end

function PopupBreakResult:_playCurHeroVoice()
    local baseId = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)
    G_HeroVoiceManager:playVoiceWithHeroId(baseId, true)
end

function PopupBreakResult:_initEffect()
	self._nodeContinue:setVisible(false)
	self._nodeTxt1:setVisible(false)
	self._nodeTxt3:setVisible(false)
	for i = 1, 4 do
		self["_fileNodeAttr"..i]:setVisible(false)
	end
end

function PopupBreakResult:_playEffect()
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
            textTalentName:setString(self._talentName)
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
				local richTxt = Lang.getTxt(template,{name =self._talentName ,des = self._talentDes})
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

    	if effect == "moving_wujiangbreak_role" then
    		local node = self:_createRoleEffect()
    		return node
    	end

    	if effect == "effect_wujiangbreak_heidi" then
    		local subEffect = EffectGfxNode.new("effect_wujiangbreak_heidi")
            subEffect:play()
            return subEffect
    	end
    		
		-- i18n change effect
		if  not Lang.checkLang(Lang.CN) and effect == "routine_word_wujiangbreak_jiesuotianfu" then
			local TypeConst = require("app.i18n.utils.TypeConst")
			local UIHelper = require("yoka.utils.UIHelper")
    		local subLabel = UIHelper.createLabel({text=Lang.getEffectText("effect_jiesuotexing"),style="effect_text_36",styleType=TypeConst.EFFECT})
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
        elseif event == "play_jiantou" then
        	
        elseif event == "play_txt3" then
        	self._nodeTxt3:setVisible(true)
        	G_EffectGfxMgr:applySingleGfx(self._nodeTxt3, "smoving_wujiangbreak_txt_3", nil, nil, nil)
        elseif event == "finish" then
        	self._canContinue = true
        	self._nodeContinue:setVisible(true)
			G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_BEGIN,"PopupBreakResult")
        end
    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_wujiangbreak", effectFunction, eventFunction , false)
    effect:setPosition(cc.p(0, 0))
    
end

function PopupBreakResult:_createRoleEffect()
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

        if effect == 'effect_wujiangbreak_tupochenggong' then
        	local subEffect = EffectGfxNode.new("effect_wujiangbreak_tupochenggong")
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
    		
		-- i18n change effect  font
		if  not Lang.checkLang(Lang.CN) and effect == "moving_wujiangshengxingchenggong" then
			local function _effectFunction(_effect)
				if _effect == "routine_word_shengxing_zi" then
					local UIHelper = require("yoka.utils.UIHelper")
					local subLabel = UIHelper.createBMFLabel({
						text=Lang.getEffectText("effect_fnt_tupochenggong"),fontName = Path.getImgFont("effect")
						--,fontSize = 36
					})
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
	local effect = G_EffectGfxMgr:createPlayMovingGfx(node, "moving_wujiangbreak_role", effectFunction, eventFunction , false)
    -- effect:setPosition(cc.p(0, 0))
    return node
end


-- i18n pos lable
function PopupBreakResult:_dealByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._textOldLevel:setAnchorPoint(cc.p(1,0.5))
		self._textOldLevel:setPositionX(self._nodeTxt1:getPositionX()-37)
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

return PopupBreakResult