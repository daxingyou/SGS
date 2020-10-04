--
-- Author: Liangxu
-- Date: 2018-1-8 16:16:16
-- 武将置换结果
local PopupBase = require("app.ui.PopupBase")
local PopupTransformResult = class("PopupTransformResult", PopupBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local AttributeConst = require("app.const.AttributeConst")
local CSHelper = require("yoka.utils.CSHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function PopupTransformResult:ctor(parentView, data)
    self._parentView = parentView
	self._data = data

	local resource = {
		file = Path.getCSB("PopupTransformResult", "hero"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClickTouch"}},
			}
		}
	}
	PopupTransformResult.super.ctor(self, resource)
end

function PopupTransformResult:onCreate()
	self:_dealPosI18n()
end

function PopupTransformResult:onEnter()
	self._canContinue = false
	self:_updateInfo()
	self:_initEffect()
	self:_playEffect()
end

function PopupTransformResult:onExit()
	
end

function PopupTransformResult:_onClickTouch()
	if self._canContinue then
		self:close()
	end
end

function PopupTransformResult:_updateInfo()
    local srcHeroBaseId = self._data.srcHeroBaseId
    local tarHeroBaseId = self._data.tarHeroBaseId
    local tarHeroLimitLevel = self._data.tarHeroLimitLevel
    local srcParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, srcHeroBaseId, nil, nil, tarHeroLimitLevel)
    local tarParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, tarHeroBaseId, nil, nil, tarHeroLimitLevel)

	self._textSrcHero:setString(srcParam.name)
    self._textTarHero:setString(tarParam.name)
    self._textSrcHero:setColor(srcParam.icon_color)
    self._textTarHero:setColor(tarParam.icon_color)

    for i = 1, 5 do
        self["_nodeDesDiff"..i]:updateUI(Lang.get("hero_transform_result_title_"..i), self._data.value[i], self._data.value[i])
    end
end

function PopupTransformResult:_initEffect()
	self._nodeContinue:setVisible(false)
	self._nodeTxt1:setVisible(false)
	for i = 1, 5 do
		self["_nodeDesDiff"..i]:setVisible(false)
	end
end

function PopupTransformResult:_playEffect()
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
            textTalentName:setString(self._talentName..":")
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
				local richTxt = Lang.getTxt(template,{name =self._talentName..":" ,des = self._talentDes})
				local lineSize = imageButtomLine:getContentSize()
				local richText = ccui.RichText:createWithContent(richTxt)
				richText:setAnchorPoint(cc.p(0,1))
				richText:ignoreContentAdaptWithSize(false)
				richText:setContentSize(cc.size(lineSize.width-40, 0))
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

    	if effect == "moving_zhihuan_role" then
    		local node = self:_createRoleEffect()
    		return node
    	end
    		
        return cc.Node:create()
    end

    local function eventFunction(event)
    	local stc, edc = string.find(event, "play_txt2_")
    	if stc then
    		local index = string.sub(event, edc+1, -1)
    		self["_nodeDesDiff"..index]:setVisible(true)
    		G_EffectGfxMgr:applySingleGfx(self["_nodeDesDiff"..index], "smoving_wujiangbreak_txt_2", nil, nil, nil)
    	elseif event == "play_txt1" then
    		self._nodeTxt1:setVisible(true)
    		G_EffectGfxMgr:applySingleGfx(self._nodeTxt1, "smoving_wujiangbreak_txt_1", nil, nil, nil)
        elseif event == "finish" then
        	self._canContinue = true
        	self._nodeContinue:setVisible(true)
        end
    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_zhihuanchenggong", effectFunction, eventFunction , false)
    effect:setPosition(cc.p(0, 0))
end

function PopupTransformResult:_createRoleEffect()
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
			heroSpine:updateUI(self._data.tarHeroBaseId, nil, nil, self._data.tarHeroLimitLevel)
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
    		
		if  not Lang.checkLang(Lang.CN) and effect == "moving_zhihuan_haoxiangchenggongle" then
			local function _effectFunction(_effect)
				if _effect == "routine_word_zhihuan_zi" then
					local UIHelper = require("yoka.utils.UIHelper")
					local subLabel = UIHelper.createBMFLabel({text=Lang.getEffectText("effect_fnt_zhihuanchenggong"),fontName = Path.getImgFont("effect")})
					return subLabel
				end
			end	
			local _node = cc.Node:create()
			local effect = G_EffectGfxMgr:createPlayMovingGfx(_node, "moving_zhihuan_haoxiangchenggongle", _effectFunction, nil , false)
			return _node
		end	
        return cc.Node:create()
    end

    local function eventFunction(event)
        if event == "finish" then
        
        end
    end

    local node = cc.Node:create()
	local effect = G_EffectGfxMgr:createPlayMovingGfx(node, "moving_zhihuan_role", effectFunction, eventFunction , false)
    return node
end


-- i18n pos lable
function PopupTransformResult:_dealPosI18n()
	if not Lang.checkLang(Lang.CN) then
		self._textSrcHero:setAnchorPoint(cc.p(1,0.5))
		self._textSrcHero:setPositionX(-56)
	end
end


return PopupTransformResult