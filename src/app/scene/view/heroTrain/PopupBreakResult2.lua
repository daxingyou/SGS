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
		file = Path.getCSB("PopupBreakResult2", "hero"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClickTouch"}},
			}
		}
	}
	PopupBreakResult.super.ctor(self, resource,nil,nil,true)
end

function PopupBreakResult:onCreate()
	-- for i = 2, 5 do
	-- 	self["_fileNodeAttr"..i]:setNameColor(Colors.LIST_TEXT)
	-- 	self["_fileNodeAttr"..i]:setCurValueColor(Colors.DARK_BG_ONE)
	-- 	self["_fileNodeAttr"..i]:setNextValueColor(Colors.DARK_BG_ONE)
	-- 	self["_fileNodeAttr"..i]:showDiffValue(false)
	-- end
end

function PopupBreakResult:onEnter()
	self._canContinue = false
	self:_updateInfo()
	self:_initEffect()
	self:_playEffect()
	--self:_createRoleEffect()
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
	if self._heroId == nil then
		self._heroId = G_UserData:getHero():getCurHeroId()
	end
	self._heroUnitData = G_UserData:getHero():getUnitDataWithId(self._heroId)
	local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)

	local rankLevel = self._heroUnitData:getRank_lv()
	self._rankLevel = rankLevel
	local limitLevel = avatarLimitLevel or self._heroUnitData:getLimit_level()
	local limitRedLevel = arLimitLevel or self._heroUnitData:getLimit_rtg()
	local heroRankConfig = UserDataHelper.getHeroRankConfig(heroBaseId, rankLevel, limitLevel, limitRedLevel)
    if heroRankConfig then
		-- i18n change punc
		if not Lang.checkLang(Lang.CN) then
			self._talentName = heroRankConfig.talent_name
		else
			self._talentName = heroRankConfig.talent_name
		end
		self._talentDes = heroRankConfig.talent_description
		
	   local str = " [".. self._talentName  .. "] " .. self._talentDes
	--	self._textTalent:setString(Lang.get("txt_hero_resault_talent") .. str)
		self._talentName = Lang.get("txt_hero_resault_talent") .. str
    else
        self._talentName = Lang.get("hero_break_txt_all_unlock")
		self._talentDes = ""
	--	self._textTalent:setString(self._talentName)
	end
	
 
	-- self._textOldLevel:setString(Lang.get("hero_break_result_level", {level = rankLevel - 1}))
	-- local strRankLevel = Lang.get("hero_break_result_level", {level = rankLevel})
	-- self._textOldLevel:setString("+" .. rankLevel - 1)
	-- self._textNewLevel:setString("+" .. rankLevel)
	-- self._textLevelName:setString(Lang.get("txt_hero_break_level"))  

	local curBreakAttr = UserDataHelper.getBreakAttr(self._heroUnitData, -1)
	local nextBreakAttr = UserDataHelper.getBreakAttr(self._heroUnitData)

	-- self._fileNodeAttr2:updateInfo(AttributeConst.ATK, curBreakAttr[AttributeConst.ATK], nextBreakAttr[AttributeConst.ATK], 3)
	-- self._fileNodeAttr3:updateInfo(AttributeConst.HP, curBreakAttr[AttributeConst.HP], nextBreakAttr[AttributeConst.HP], 3)
	-- self._fileNodeAttr4:updateInfo(AttributeConst.PD, curBreakAttr[AttributeConst.PD], nextBreakAttr[AttributeConst.PD], 3)
	-- self._fileNodeAttr5:updateInfo(AttributeConst.MD, curBreakAttr[AttributeConst.MD], nextBreakAttr[AttributeConst.MD], 3)
    -- for i = 2, 5 do
	-- 	self["_fileNodeAttr"..i]:setNextValueColor(Colors.DARK_BG_ONE)
	-- 	local textName = ccui.Helper:seekNodeByName(self["_fileNodeAttr"..i], "TextName"):getString() -- 去除“：”
	-- 	textName = string.gsub(textName, ":", "")
	-- 	ccui.Helper:seekNodeByName(self["_fileNodeAttr"..i], "TextName"):setString(textName)
    -- end

	-- self._textDiffValue1:setString(nextBreakAttr[AttributeConst.ATK] - curBreakAttr[AttributeConst.ATK])
	-- self._textDiffValue2:setString(nextBreakAttr[AttributeConst.HP] - curBreakAttr[AttributeConst.HP])
	-- self._textDiffValue3:setString(nextBreakAttr[AttributeConst.PD] - curBreakAttr[AttributeConst.PD])
	-- self._textDiffValue4:setString(nextBreakAttr[AttributeConst.MD] - curBreakAttr[AttributeConst.MD])
	
	-- i18n pos lable
	self:_dealByI18n()
end



function PopupBreakResult:_playCurHeroVoice()
    local baseId = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)
    G_HeroVoiceManager:playVoiceWithHeroId(baseId, true,self._storyAvatar)
end

function PopupBreakResult:_initEffect()  
	self._nodeContinue:setVisible(false)
	ccui.Helper:seekNodeByName(self._nodeContinue, "Text_continue_desc"):setColor(Colors.getSummaryStarColor()) 
	--ccui.Helper:seekNodeByName(self._nodeContinue, "Continue_Image"):setVisible(false)
	--self._nodeTxt2:setVisible(true)  -- 解锁天赋一开始就显示
	--self._nodeTxt3:setVisible(false)
	-- for i = 1, 5 do
	-- 	self["_fileNodeAttr"..i]:setVisible(false)
	-- end


	local effectTitle = "effect_tupochenggong_ui"
	local effectDengLong = "effect_tupochenggong_denglong"
	G_EffectGfxMgr:createPlayGfx(self._nodeEffectTitle, effectTitle)
	G_EffectGfxMgr:createPlayGfx(self._nodeEffectDengLong, effectDengLong)
end
 
function PopupBreakResult:_playEffect()
	local function effectFunction(effect)
		if effect == "smoving_wujiangbreak_txt_big" then 	-- smoving用法
			local node = cc.Node:create()
			local desNode = CSHelper.loadResourceNode(Path.getCSB("CommonTalentTitle", "common"))
			--desNode:setTitle(self._talentName)  bug: 最多显示三行 超过三行拉宽

			local textTalent = ccui.Helper:seekNodeByName(desNode, "Text_talent") 
			textTalent:ignoreContentAdaptWithSize(true)
			textTalent:setTextAreaSize(cc.size(450, 0)) 
			textTalent:setString(self._talentName)
			local aaa =  textTalent:getContentSize().height
			if textTalent:getContentSize().height > textTalent:getFontSize()*3 then  
				textTalent:setFontSize(18)
			else  
				textTalent:setFontSize(20)	  
			end
 
			if textTalent:getContentSize().height < textTalent:getFontSize()*2 then   -- 如果1行居中显示  多行行左对齐  
				textTalent:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
			else  	
				textTalent:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT )
			end
 
			G_EffectGfxMgr:applySingleGfx(desNode, "smoving_wujiangbreak_txt_big", nil, nil, nil)
			node:addChild(desNode)
			return node
		end

		if string.find(effect, "moving_wujiangbreak_txt") then  -- moving用法
			local num = tonumber(string.match(effect, "%d+"))
			local function effectFunction1(effect_2)
				if effect_2 == "target" then  				-- 创建3属性
					local desNode = CSHelper.loadResourceNode(Path.getCSB("CommonAttrDiff", "common"))
					self:_createFileNodeAttr(num, desNode)
					return desNode 
				end
				if effect_2 == "smoving_wujiangbreak_txt_green" then  -- 创建绿色字
					local node = cc.Node:create()
					if num ~= 1 then  -- 第一个无绿色字 特殊处理
						local desNode = self:_createGreenText(num)
						G_EffectGfxMgr:applySingleGfx(desNode, "smoving_wujiangbreak_txt_green", nil, nil, nil)
						node:addChild(desNode)
					end
					return node
				end
			end

			local node = cc.Node:create()
			G_EffectGfxMgr:createPlayMovingGfx(node, effect, effectFunction1, nil , false)
			return node
		end

 
        return cc.Node:create()
    end

    local function eventFunction(event)
    	local stc, edc = string.find(event, "play_txt2_")
    	if stc then
    	-- 	local index = string.sub(event, edc+1, -1)
		-- 	self["_fileNodeAttr"..index]:setVisible(true)
		-- 	if self["_fileNodeAttr"..index].showArrow then
		-- 		self["_fileNodeAttr"..index]:showArrow(false)
		-- 	end
    	-- 	G_EffectGfxMgr:applySingleGfx(self["_fileNodeAttr"..index], "smoving_wujiangbreak_txt_2", nil, nil, nil)
    	elseif event == "play_txt1" then
    		-- self._nodeTxt2:setVisible(true)   
    		-- G_EffectGfxMgr:applySingleGfx(self._nodeTxt2, "smoving_wujiangbreak_txt_1", nil, nil, nil)  --等级 

			-- for index = 1, 5 do     
			-- 	G_EffectGfxMgr:createPlayGfx(self["_nodeEffect"..index], "effect_tupo_jingdutiao")
			-- end
        elseif event == "play_jiantou" then
        	
        elseif event == "play_txt3" then
        	-- self._nodeTxt3:setVisible(true)
        	-- G_EffectGfxMgr:applySingleGfx(self._nodeTxt3, "smoving_wujiangbreak_txt_3", nil, nil, nil)
        elseif event == "finish" then
        	self._canContinue = true
        	self._nodeContinue:setVisible(true)   
			G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_BEGIN,"PopupBreakResult")
        end
    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_tupobreak", effectFunction, eventFunction , false)
    effect:setPosition(cc.p(0, 0))
end

function PopupBreakResult:_createRoleEffect()
	local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
	local unitData = G_UserData:getHero():getUnitDataWithId(self._heroId)
	local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(unitData)
	local limitLevel = avatarLimitLevel or unitData:getLimit_level()
	local limitRedLevel = arLimitLevel or unitData:getLimit_rtg()

	local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
	avatar:updateChatUI(heroBaseId, limitLevel, limitRedLevel)
	local size = self:getContentSize()
	avatar:setPosition(cc.p(size.width / 2, 0))  
	self._avatar:addChild(avatar)
	self._storyAvatar = avatar
end

function PopupBreakResult:_createFileNodeAttr(num, nodeAttr)
	nodeAttr:setNameColor(Colors.getSummaryStarColor()) 
	nodeAttr:setCurValueColor(Colors.DARK_BG_ONE)
	nodeAttr:setNextValueColor(Colors.DARK_BG_ONE)
	nodeAttr:showDiffValue(false) 
	nodeAttr:showArrow(false)  -- 绿色箭头
	
	if num == 1 then
		local textName = ccui.Helper:seekNodeByName(nodeAttr, "TextName")
		local textCurValue = ccui.Helper:seekNodeByName(nodeAttr, "TextCurValue") 
		local textNextValue = ccui.Helper:seekNodeByName(nodeAttr, "TextNextValue")  
		textCurValue:setString("+" .. self._rankLevel - 1)
		textNextValue:setString("+" .. self._rankLevel)
		textName:setString(Lang.get("txt_hero_break_level"))  
	else   
		-- 初始化
		local curBreakAttr = UserDataHelper.getBreakAttr(self._heroUnitData, -1)
		local nextBreakAttr = UserDataHelper.getBreakAttr(self._heroUnitData)

		if num == 2 then
			nodeAttr:updateInfo(AttributeConst.ATK, curBreakAttr[AttributeConst.ATK], nextBreakAttr[AttributeConst.ATK], 3)
		elseif num == 3 then
			nodeAttr:updateInfo(AttributeConst.HP, curBreakAttr[AttributeConst.HP], nextBreakAttr[AttributeConst.HP], 3)
		elseif num == 4 then		
			nodeAttr:updateInfo(AttributeConst.PD, curBreakAttr[AttributeConst.PD], nextBreakAttr[AttributeConst.PD], 3)
		elseif num == 5 then
			nodeAttr:updateInfo(AttributeConst.MD, curBreakAttr[AttributeConst.MD], nextBreakAttr[AttributeConst.MD], 3)
		end

	 
		nodeAttr:setNextValueColor(Colors.DARK_BG_ONE)
		local textName = ccui.Helper:seekNodeByName(nodeAttr, "TextName"):getString() -- 去除“：”
		textName = string.gsub(textName, ":", "")
		ccui.Helper:seekNodeByName(nodeAttr, "TextName"):setString(textName)
	end
	-- 调整属性
	ccui.Helper:seekNodeByName(nodeAttr, "ImageUpArrow"):setVisible(false) 
	ccui.Helper:seekNodeByName(nodeAttr, "TextAddValue"):setVisible(false)  
	ccui.Helper:seekNodeByName(nodeAttr, "TextName"):setAnchorPoint(cc.p(0, 0))
	ccui.Helper:seekNodeByName(nodeAttr, "TextName"):setPosition(cc.p(-171, -11))
	ccui.Helper:seekNodeByName(nodeAttr, "TextCurValue"):setAnchorPoint(cc.p(1, 0))
	ccui.Helper:seekNodeByName(nodeAttr, "TextCurValue"):setPosition(cc.p(8, -11))
	ccui.Helper:seekNodeByName(nodeAttr, "TextNextValue"):setAnchorPoint(cc.p(1, 0))
	ccui.Helper:seekNodeByName(nodeAttr, "TextNextValue"):setPosition(cc.p(152, -11))
end	

function PopupBreakResult:_createGreenText(num)
	if num == 1 then
		return 
	end

	local textNum = ccui.Text:create("", Path.getCommonFont(), 22)
	textNum:setColor(Colors.CUSTOM_ACT_DES_HILIGHT) 

	-- num == 1 没有绿色数字
	local curBreakAttr = UserDataHelper.getBreakAttr(self._heroUnitData, -1)
	local nextBreakAttr = UserDataHelper.getBreakAttr(self._heroUnitData)
	if num == 2 then
		textNum:setString(nextBreakAttr[AttributeConst.ATK] - curBreakAttr[AttributeConst.ATK])
	elseif num == 3 then
		textNum:setString(nextBreakAttr[AttributeConst.HP] - curBreakAttr[AttributeConst.HP])
	elseif num == 4 then		
		textNum:setString(nextBreakAttr[AttributeConst.PD] - curBreakAttr[AttributeConst.PD])
	elseif num == 5 then
		textNum:setString(nextBreakAttr[AttributeConst.MD] - curBreakAttr[AttributeConst.MD])
	end

	--添加+号
	local str = "+" .. textNum:getString() 
	textNum:setString(str) 
	return textNum
end

-- i18n pos lable
function PopupBreakResult:_dealByI18n()
	do return end

	if Lang.checkLang(Lang.JA) then
		for i = 2, 5 do
			local textName = ccui.Helper:seekNodeByName(self["_fileNodeAttr"..i], "TextName")
			local textCurValue = ccui.Helper:seekNodeByName(self["_fileNodeAttr"..i], "TextCurValue")
			local textNextValue = ccui.Helper:seekNodeByName(self["_fileNodeAttr"..i], "TextNextValue")
			textName:setAnchorPoint(cc.p(0, 0))
			textName:setPosition(-118, 2)
			textName:setColor(Colors.getMineInfoColor(2))
				 
			textCurValue:setAnchorPoint(cc.p(1, 0))
			textCurValue:setPosition(56, 2)

			textNextValue:setAnchorPoint(cc.p(1, 0))
			textNextValue:setPosition(225, 2)
		end
	end

end

return PopupBreakResult

