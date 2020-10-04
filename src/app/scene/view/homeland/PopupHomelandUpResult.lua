--
-- Author: hedili
-- Date: 2017-08-30 15:17:50
-- 神树进阶结果
local PopupBase = require("app.ui.PopupBase")
local PopupHomelandUpResult = class("PopupHomelandUpResult", PopupBase)
local HomelandHelp = require("app.scene.view.homeland.HomelandHelp")

local EffectGfxNode = require("app.effect.EffectGfxNode")
local TextHelper = require("app.utils.TextHelper")

function PopupHomelandUpResult:ctor(power)
	self._oldPower = power
	local resource = {
		file = Path.getCSB("PopupHomelandUpResult", "homeland"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClickTouch"}},
			}
		}
	}
	self:setName("PopupHomelandUpResult")
	PopupHomelandUpResult.super.ctor(self, resource)
end

function PopupHomelandUpResult:onCreate()
	self.currLevel =  G_UserData:getHomeland():getMainTreeLevel()
	self.currData =  G_UserData:getHomeland():getMainTreeCfg(self.currLevel - 1)
	self.nextData =  G_UserData:getHomeland():getMainTreeCfg(self.currLevel)
end

function PopupHomelandUpResult:onEnter()
	--self._textAddPlayerJoint:setVisible(false)
	self:_initEffect()
	self:_createPlayEffect()
	local AudioConst = require("app.const.AudioConst")
	G_AudioManager:playSoundWithId(AudioConst.SOUND_OFFICIAL_LEVELUP)
end


function PopupHomelandUpResult:onExit()
	
end

function PopupHomelandUpResult:onClose( ... )

end


function PopupHomelandUpResult:_onClickTouch()
	if self._nodeContinue:isVisible() == true then
		self:close()
	end
end

--播放总战力飘字
function PopupHomelandUpResult:_playTotalPowerSummary()
	local totalPower = G_UserData:getBase():getPower()
	self._fileNodePower:setVisible(true)
	local diffPower = totalPower - self._oldPower
	self._fileNodePower:updateUI(totalPower, diffPower)
	self._fileNodePower:playEffect(false)
end

function PopupHomelandUpResult:isAnimEnd( ... )
	-- body
	return self._nodeContinue:isVisible()
end

function PopupHomelandUpResult:_initEffect()
	self._nodeContinue:setVisible(false)
	self._fileNodePower:setVisible(false)
	-- ui4特殊处理
	self:_initEffectByI18n()
end

--特殊处理
function PopupHomelandUpResult:_createPlayEffectByI18n()
	local function effectFunction(effect)			
		if effect == "touxian_1" then

			local PopupHomelandUpMainCell = require("app.scene.view.homeland.PopupHomelandUpMainCell")
			local retNode = PopupHomelandUpMainCell.new()
			local panelCommon = retNode:getSubNodeByName("PanelCommon")
			if not Lang.checkLang(Lang.CN) then
				panelCommon:setPositionY(-12)
			else
				panelCommon:setPositionY(4)
			end
			retNode:updateBreakUIByI18N(self.currData)
			return retNode
		end
		if effect == "touxian_2" then
			local PopupHomelandUpMainCell = require("app.scene.view.homeland.PopupHomelandUpMainCell")
			local retNode = PopupHomelandUpMainCell.new()
			local panelCommon = retNode:getSubNodeByName("PanelCommon")
			if not Lang.checkLang(Lang.CN) then
				panelCommon:setPositionY(-12)
			else
				panelCommon:setPositionY(4)
			end
			retNode:updateBreakUIByI18N(self.nextData)
			return retNode
		end

        return cc.Node:create()
    end

	local function eventFunction(event)
		local stc, edc = string.find(event, "play_shuzhi")
    	if stc then
			local index = tonumber( string.sub(event, edc+1, -1) )
			if index and index > 0 then
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
			self:_playTotalPowerSummary()
			self._nodeContinue:setVisible(true)
			local currData = self.currData
			if currData.up_text and currData.up_text ~= "" then
				self._openNewTree:removeAllChildren()
				local params1 ={
					name = "label1",
					text = Lang.get("homeland_open_new_level"),
					fontSize = 22,
					color = Colors.DARK_BG_THREE,
				}
				local params2 ={
					name = "label2",
					text = currData.up_text,
					fontSize = 22,
					color = Colors.DARK_BG_GREEN,
				}
				local UIHelper = require("yoka.utils.UIHelper")
				local widget = UIHelper.createTwoLabel(params1,params2)
				self._openNewTree:addChild(widget)
			end
        end
    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_shenshu_jinsheng", effectFunction, eventFunction , false)
	effect:setPosition(cc.p(0, 0))
    return effect

end

--添加特效节点
function PopupHomelandUpResult:_initEffectByI18n()
	if Lang.checkUI("ui4") then	
		local pos = {
			50,15,-20,-55,-90,-125
		}
		for i = 1, 6 do
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
		self:updateBreakUIByI18n(self.currData,self.nextData)
	end
end


function PopupHomelandUpResult:_createPlayEffect()
	-- UI4特殊处理
	if Lang.checkUI("ui4") then
		self:_createPlayEffectByI18n()
		return
	end
	local currLevel = G_UserData:getHomeland():getMainTreeLevel()
	local currData =  G_UserData:getHomeland():getMainTreeCfg(currLevel - 1)
	local nextData =  G_UserData:getHomeland():getMainTreeCfg(currLevel)
	local function effectFunction(effect)
		-- i18n change effect 
		if not Lang.checkLang(Lang.CN) and effect == "routine_word_jinsheng_dazi" then
			print("i18n change effect  node： routine_word_jinsheng_dazi" )
			local UIHelper = require("yoka.utils.UIHelper")
			local TypeConst = require("app.i18n.utils.TypeConst")
			local subLabel = UIHelper.createLabel({text=Lang.getEffectText("effect_tupochenggong"),style="effect_text_systen",styleType=TypeConst.EFFECT})
			return subLabel
		end				
        if effect == "effect_shenshu_jiantou" then
            local subEffect = EffectGfxNode.new("effect_shenshu_jiantou")
            subEffect:play()
            return subEffect
        end

        if effect == "effect_bg5" then
        	local subEffect = EffectGfxNode.new("effect_bg5")
            subEffect:play()
            return subEffect
        end

        if effect == 'effect_txt_bg' then
        	local subEffect = EffectGfxNode.new("effect_txt_bg")
            subEffect:play()
            return subEffect
        end

    	if effect == "effect_jinsheng_dazi" then
    		local subEffect = EffectGfxNode.new("effect_jinsheng_dazi")
            subEffect:play()
            return subEffect
    	end


    	if effect == "effect_hejilibao_xiaodi" then
    		local subEffect = EffectGfxNode.new("effect_hejilibao_xiaodi")
            subEffect:play()
            return subEffect
    	end

    	if effect == "effect_win_2" then
    		local subEffect = EffectGfxNode.new("effect_win_2")
            subEffect:play()
            return subEffect
    	end

		if effect == "effect_bg4" then
    		local subEffect = EffectGfxNode.new("effect_bg4")
            subEffect:play()
            return subEffect
    	end
    	
		if effect == "effect_bg3" then
    		local subEffect = EffectGfxNode.new("effect_bg3")
            subEffect:play()
            return subEffect
    	end

		if effect == "effect_bg2" then
    		local subEffect = EffectGfxNode.new("effect_bg2")
            subEffect:play()
            return subEffect
    	end
		if effect == "effect_bg1" then
    		local subEffect = EffectGfxNode.new("effect_bg1")
            subEffect:play()
            return subEffect
    	end
		if effect == "touxian_1" then
			local currLevel = G_UserData:getHomeland():getMainTreeLevel()
			local currData =  G_UserData:getHomeland():getMainTreeCfg(currLevel - 1)
			local nextData =  G_UserData:getHomeland():getMainTreeCfg(currLevel)

			local PopupHomelandUpMainCell = require("app.scene.view.homeland.PopupHomelandUpMainCell")
			local retNode = PopupHomelandUpMainCell.new()
			local panelCommon = retNode:getSubNodeByName("PanelCommon")
			if not Lang.checkLang(Lang.CN) then
				panelCommon:setPositionY(-12)
			else
				panelCommon:setPositionY(4)
			end
			retNode:updateBreakUI(currData)
			local imgBg = retNode:getSubNodeByName("Image_bk")
			imgBg:setPositionY(200)
			local treeTitle = retNode:getSubNodeByName("Node_treeTitle")
			treeTitle:setPositionY(227)
			return retNode
		end
		if effect == "touxian_2" then
			local currLevel = G_UserData:getHomeland():getMainTreeLevel()
			local currData =  G_UserData:getHomeland():getMainTreeCfg(currLevel - 1)
			local nextData =  G_UserData:getHomeland():getMainTreeCfg(currLevel)

			local PopupHomelandUpMainCell = require("app.scene.view.homeland.PopupHomelandUpMainCell")
			local retNode = PopupHomelandUpMainCell.new()
			local panelCommon = retNode:getSubNodeByName("PanelCommon")
			if not Lang.checkLang(Lang.CN) then
				panelCommon:setPositionY(-12)
			else
				panelCommon:setPositionY(4)
			end
			retNode:updateNextBreakUI(currData, nextData)
			local imgBg = retNode:getSubNodeByName("Image_bk")
			imgBg:setPositionY(200)
			local treeTitle = retNode:getSubNodeByName("Node_treeTitle")
			treeTitle:setPositionY(227)
			return retNode
		end

        return cc.Node:create()
    end

    local function eventFunction(event)
        if event == "finish" then
			self:_playTotalPowerSummary()
			self._nodeContinue:setVisible(true)
			if currData.up_text and currData.up_text ~= "" then
				self._openNewTree:removeAllChildren()
				local params1 ={
					name = "label1",
					text = Lang.get("homeland_open_new_level"),
					fontSize = 22,
					color = Colors.DARK_BG_THREE,
				}
				local params2 ={
					name = "label2",
					text = currData.up_text,
					fontSize = 22,
					color = Colors.DARK_BG_GREEN,
				}
				local UIHelper = require("yoka.utils.UIHelper")
				local widget = UIHelper.createTwoLabel(params1,params2)
				self._openNewTree:addChild(widget)
			end
			--self._textAddPlayerJoint:setVisible(true)
			--self._textAddPlayerJoint:setString(currData.up_text)
        end
    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_shenshu_jinsheng", effectFunction, eventFunction , false)
	effect:setPosition(cc.p(0, 0))
    return effect
end



-- 获取UI
function PopupHomelandUpResult:updateBreakUIByI18n( cfgData , nextCfgData)
	if not cfgData then
		return
	end
	if not nextCfgData then
		return
	end
	local nextValueList = self:getValueList(nextCfgData)
	local valueList = self:getValueList(cfgData)
	for index, value in ipairs(nextValueList) do
		self:_updateAttrByI18n(index, valueList[index].name, valueList[index].value, value.value )
	end
end
--获取数据
function PopupHomelandUpResult:getValueList( cfgData )
	-- body

	local retList = {}
	for i= 1, cfgData.id do
		local valueList = HomelandHelp.getMainLevelAttrList(i)
		for i, value in ipairs(valueList) do
			local data = retList[i] or {name = "", value = 0}
			data.value = data.value + value.value
			data.name = value.name
			retList[i] = data
		end
	end

	return retList
end
--更新属性
function PopupHomelandUpResult:_updateAttrByI18n(index, name, value, nextValue)
	local nodeAttr = self["_fileNodeAttr"..index]:getChildByName("infoNode")
	if not nodeAttr then
		return
	end 
	local textName = ccui.Helper:seekNodeByName(nodeAttr, "TextName")
	local textCurValue = ccui.Helper:seekNodeByName(nodeAttr, "TextCurValue") 
	local textNextValue = ccui.Helper:seekNodeByName(nodeAttr, "TextNextValue")  
	local jiantou = ccui.Helper:seekNodeByName(nodeAttr, "jiantou")  

	textCurValue:setString( value)
	textNextValue:setString( nextValue)
	textName:setString(name)  
	--调整属性
	ccui.Helper:seekNodeByName(nodeAttr, "ImageUpArrow"):setVisible(false) 
	ccui.Helper:seekNodeByName(nodeAttr, "TextAddValue"):setVisible(false) 
	textName:setAnchorPoint(cc.p(0, 0))
	textName:setPosition(cc.p(-160, -11))
	textCurValue:setAnchorPoint(cc.p(0, 0))
	textCurValue:setPosition(cc.p(-35, -11))
	textNextValue:setAnchorPoint(cc.p(0, 0))
	textNextValue:setPosition(cc.p(136, -11))
	jiantou:setPositionY(-11)
	jiantou:setPositionX(61)
end	

return PopupHomelandUpResult