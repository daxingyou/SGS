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
	if Lang.checkUI("ui4") then
		self:_initEffectByI18n()
		self:_playEffectByI18n()
	else
		self:_updateInfo()
		self:_initEffect()
		self:_playEffect()
	end
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
    local tarHeroRedLimitLevel = self._data.tarHeroRedLimitLevel
    local srcParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, srcHeroBaseId, nil, nil, tarHeroLimitLevel, tarHeroRedLimitLevel)
    local tarParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, tarHeroBaseId, nil, nil, tarHeroLimitLevel, tarHeroRedLimitLevel)

	self._textSrcHero:setString(srcParam.name)
    self._textTarHero:setString(tarParam.name)
    self._textSrcHero:setColor(srcParam.icon_color)
    self._textTarHero:setColor(tarParam.icon_color)

    for i = 1, 5 do
        self["_nodeDesDiff"..i]:updateUI(Lang.get("hero_transform_result_title_"..i), self._data.value[i], self._data.value[i])
    end
    if self._data.isGoldHero  then
        --是金将
        self["_nodeDesDiff1"]:updateUI(Lang.get("hero_transform_result_title_gold"), self._data.value[2], self._data.value[2])--rank
        self["_nodeDesDiff4"]:setPositionY(self["_nodeDesDiff2"]:getPositionY())
        self["_nodeDesDiff5"]:setPositionY(self["_nodeDesDiff3"]:getPositionY())
        self["_nodeDesDiff2"]:setVisible(false)
        self["_nodeDesDiff3"]:setVisible(false)
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
            if self._data.isGoldHero then
                self["_nodeDesDiff2"]:setVisible(false)
                self["_nodeDesDiff3"]:setVisible(false)
            end
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
			heroSpine:updateUI(self._data.tarHeroBaseId, nil, nil, self._data.tarHeroLimitLevel, nil, nil, self._data.tarHeroRedLimitLevel)
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

function PopupTransformResult:_createRoleEffectByI18n()
	local function effectFunction(effect)
		if effect == "levelup_role" then
			local heroSpine = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
			heroSpine:updateUI(self._data.tarHeroBaseId, nil, nil, self._data.tarHeroLimitLevel, nil, nil, self._data.tarHeroRedLimitLevel)
			heroSpine:showShadow(false)
			return heroSpine
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

function PopupTransformResult:_playEffectByI18n()
	local function effectFunction(effect)
       
        if effect == "moving_wujiangbreak_jiesuo" then
        	local desNode = CSHelper.loadResourceNode(Path.getCSB("BreakResultTalentDesNode", "item"))
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
		
            return desNode
        end

    	if effect == "moving_wujiangbreak_txt_1" then
    	end

    	if effect == "moving_zhihuan_role" then
    		local node = self:_createRoleEffectByI18n()
    		return node
    	end		
        return cc.Node:create()
    end

	local function eventFunction(event)
		local stc, edc = string.find(event, "play_shuzhi")
    	if stc then
			local index = tonumber( string.sub(event, edc+1, -1) )
            if index and index > 0 and (tonumber(index) <= 5 ) then
                
                self["_fileNodeAttr"..index]:setVisible(true)
                if self._data.isGoldHero then
                    self["_fileNodeAttr4"]:setVisible(false)
                    self["_fileNodeAttr5"]:setVisible(false)
                end
				local function effectFunction1(effect_2)
					if effect_2 == "target" then  				-- 创建3属性
						local node = cc.Node:create()
						return node
					end
					if effect_2 == "smoving_wujiangbreak_txt_green" then  -- 创建绿色字
						local node = cc.Node:create()	
						return node
					end
				end
				local effectNode = self["_fileNodeAttr"..index]:getChildByName("effectNode")
				if effectNode then
					 G_EffectGfxMgr:createPlayMovingGfx(effectNode, "moving_wujiangbreak_txt", effectFunction1, nil , false)
				end
			end
		end
    	if event == "finish" then
        	self._canContinue = true
        	self._nodeContinue:setVisible(true)
        end

        --标题字特效
        if event == "zhihuan" then
            self._nodeTxt1:setVisible(true)
    		G_EffectGfxMgr:applySingleGfx(self._nodeTxt1, "smoving_wujiangbreak_txt_1", nil, nil, nil)
        end

    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_zhihuanchenggong", effectFunction, eventFunction , false)
    effect:setPosition(cc.p(0, 0))
end


-- i18n
function PopupTransformResult:_initEffectByI18n()
	--隐藏火焰背景图
	local bgImg = ccui.Helper:seekNodeByName(self._resourceNode, "Image_2")  
	bgImg:setVisible(false)
	self._nodeContinue:setVisible(false)
    self._nodeTxt1:setVisible(false)
    local srcHeroBaseId = self._data.srcHeroBaseId
    local tarHeroBaseId = self._data.tarHeroBaseId
    local tarHeroLimitLevel = self._data.tarHeroLimitLevel
    local tarHeroRedLimitLevel = self._data.tarHeroRedLimitLevel
    local srcParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, srcHeroBaseId, nil, nil, tarHeroLimitLevel, tarHeroRedLimitLevel)
    local tarParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, tarHeroBaseId, nil, nil, tarHeroLimitLevel, tarHeroRedLimitLevel)

	self._textSrcHero:setString(srcParam.name)
    self._textTarHero:setString(tarParam.name)
    self._textSrcHero:setColor(cc.c3b(0xff, 0xb8, 0x0c))
    self._textTarHero:setColor(cc.c3b(0xff, 0xb8, 0x0c))
    local pos = {
		-115,-150,-185,-220,-255,-290
	}
	for i = 1, 5 do
		if self["_nodeDesDiff"..i] then
			self["_nodeDesDiff"..i]:removeFromParent()
		end
		self["_fileNodeAttr"..i]  = cc.Node:create()
		local posy = pos[i]
		self["_fileNodeAttr"..i]:setPositionY(posy)
		self._nodeEffect:addChild(self["_fileNodeAttr"..i])

		local effectNode =  cc.Node:create()
		effectNode:setName("effectNode")
		self["_fileNodeAttr"..i]:addChild(effectNode)

		local CSHelper = require("yoka.utils.CSHelper")
		local desNode = CSHelper.loadResourceNode(Path.getCSB("CommonLevelUpAttr1", "common"))
		cc.bind(desNode,"CommonAttrDiff")
		desNode:setName("infoNode")
		self["_fileNodeAttr"..i]:addChild(desNode)
		self["_fileNodeAttr"..i]:setVisible(false)
    end
    for i = 1, 5 do
        self:_updateAttrByI18n(i,Lang.get("hero_transform_result_title_"..i), self._data.value[i], self._data.value[i])
    end
    if self._data.isGoldHero  then
        --是金将
        self:_updateAttrByI18n(1,Lang.get("hero_transform_result_title_gold"), self._data.value[2], self._data.value[2])
        self:_updateAttrByI18n(2,Lang.get("hero_transform_result_title_"..4), self._data.value[4], self._data.value[4])
        self:_updateAttrByI18n(3,Lang.get("hero_transform_result_title_"..5), self._data.value[5], self._data.value[5])
        self["_fileNodeAttr"..4]:setVisible(false)
        self["_fileNodeAttr"..5]:setVisible(false)
    end
end

--更新属性
function PopupTransformResult:_updateAttrByI18n(index,name, value, nextValue)
	local nodeAttr = self["_fileNodeAttr"..index]:getChildByName("infoNode")
	if not nodeAttr then
		return
	end 
	nodeAttr:updateEffectAttrByI18n(name, value, nextValue)
end	
return PopupTransformResult