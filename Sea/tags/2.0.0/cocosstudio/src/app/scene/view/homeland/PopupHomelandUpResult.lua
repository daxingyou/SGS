--
-- Author: hedili
-- Date: 2017-08-30 15:17:50
-- 神树进阶结果
local PopupBase = require("app.ui.PopupBase")
local PopupHomelandUpResult = class("PopupHomelandUpResult", PopupBase)

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
end

function PopupHomelandUpResult:_createPlayEffect()
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
				panelCommon:setPositionY(-36)
			else
				panelCommon:setPositionY(4)
			end
			
			retNode:updateBreakUI(currData)
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
				panelCommon:setPositionY(-36)
			else
				panelCommon:setPositionY(4)
			end
			retNode:updateNextBreakUI(currData, nextData)


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

return PopupHomelandUpResult