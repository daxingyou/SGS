
-- Author: zhanglinsen
-- Date:2018-06-29 13:50:27
-- Describle：

-- local PopupBase = require("app.ui.PopupBase")
-- local PopupTransformResult = class("PopupTransformResult", PopupBase)

local PopupBase = require("app.ui.PopupBase")
local PopupTransformResult = class("PopupTransformResult", PopupBase)
local CSHelper = require("yoka.utils.CSHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

-- function PopupTransformResult:ctor()

-- 	--csb bind var name
-- 	self._nodeContinue = nil  --CommonContinueNode
-- 	self._nodeDesDiff1 = nil  --CommonDesDiff
-- 	self._nodeDesDiff2 = nil  --CommonDesDiff
-- 	self._nodeDesDiff3 = nil  --CommonDesDiff
-- 	self._nodeEffect = nil  --SingleNode
-- 	self._nodeTxt1 = nil  --SingleNode
-- 	self._panelTouch = nil  --Panel
-- 	self._textSrcTreasure = nil  --Text
-- 	self._textTarTreasure = nil  --Text

-- 	local resource = {
-- 		file = Path.getCSB("PopupTransformResult", "transform/treasure"),

-- 	}
-- 	PopupTransformResult.super.ctor(self, resource)
-- end

-- -- Describle：
-- function PopupTransformResult:onCreate()

-- end

-- -- Describle：
-- function PopupTransformResult:onEnter()

-- end

-- -- Describle：
-- function PopupTransformResult:onExit()

-- end

PopupTransformResult.ATTAR_SUM = 3

function PopupTransformResult:ctor(parentView, data)
    self._parentView = parentView
	self._data = data
	--csb bind var name
	self._nodeContinue = nil  --CommonContinueNode
	self._nodeDesDiff1 = nil  --CommonDesDiff
	self._nodeDesDiff2 = nil  --CommonDesDiff
	self._nodeDesDiff3 = nil  --CommonDesDiff
	self._nodeEffect = nil  --SingleNode
	self._nodeTxt1 = nil  --SingleNode
	self._panelTouch = nil  --Panel
	self._textSrcTreasure = nil  --Text
	self._textTarTreasure = nil  --Text

	local resource = {
		file = Path.getCSB("PopupTransformResult", "transform/treasure"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClickTouch"}},
			}
		}
	}
	PopupTransformResult.super.ctor(self, resource)
end

function PopupTransformResult:onCreate()
	
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
    local srcItemBaseId = self._data.srcItemBaseId
    local tarItemBaseId = self._data.tarItemBaseId
    local srcParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_TREASURE, srcItemBaseId)
    local tarParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_TREASURE, tarItemBaseId)

	self._textSrcTreasure:setString(srcParam.name)
    self._textTarTreasure:setString(tarParam.name)
    self._textSrcTreasure:setColor(srcParam.icon_color)
    self._textTarTreasure:setColor(tarParam.icon_color)

    for i = 1, PopupTransformResult.ATTAR_SUM do
        self["_nodeDesDiff"..i]:updateUI(Lang.get("treasure_transform_result_title_"..i), self._data.value[i], self._data.value[i])
    end
end

function PopupTransformResult:_initEffect()
	self._nodeContinue:setVisible(false)
	self._nodeTxt1:setVisible(false)
	for i = 1, PopupTransformResult.ATTAR_SUM do
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
			if tonumber(index) <= PopupTransformResult.ATTAR_SUM then
				self["_nodeDesDiff"..index]:setVisible(true)
				G_EffectGfxMgr:applySingleGfx(self["_nodeDesDiff"..index], "smoving_wujiangbreak_txt_2", nil, nil, nil)
			end
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
			local spineNode = cc.Node:create()
    		local itemSpine = CSHelper.loadResourceNode(Path.getCSB("CommonTreasureAvatar", "common"))
			itemSpine:updateUI(self._data.tarItemBaseId)
			itemSpine:showShadow(false)
			itemSpine:setPositionY(80)
			spineNode:addChild(itemSpine)
			return spineNode
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



function PopupTransformResult:_createRoleEffectByI18n()
	local function effectFunction(effect)
		if effect == "levelup_role" then
			local spineNode = cc.Node:create()
    		local itemSpine = CSHelper.loadResourceNode(Path.getCSB("CommonTreasureAvatar", "common"))
			itemSpine:updateUI(self._data.tarItemBaseId)
			itemSpine:showShadow(false)
			itemSpine:setPositionY(80)
			spineNode:addChild(itemSpine)
			return spineNode
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
			if index and index > 0 and (tonumber(index) <= PopupTransformResult.ATTAR_SUM ) then
				self["_fileNodeAttr"..index]:setVisible(true)
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
	local srcItemBaseId = self._data.srcItemBaseId
    local tarItemBaseId = self._data.tarItemBaseId
    local srcParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_TREASURE, srcItemBaseId)
    local tarParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_TREASURE, tarItemBaseId)

	self._textSrcTreasure:setString(srcParam.name)
    self._textTarTreasure:setString(tarParam.name)
    self._textSrcTreasure:setColor(cc.c3b(0xff, 0xb8, 0x0c))
	self._textTarTreasure:setColor(cc.c3b(0xff, 0xb8, 0x0c))
	
	local pos = {
		-115,-150,-185,-220,-255,-290
	}
	for i = 1, 3 do
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
	for i = 1, PopupTransformResult.ATTAR_SUM do
		self:_updateAttrByI18n(i,Lang.get("treasure_transform_result_title_"..i), self._data.value[i], self._data.value[i])
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