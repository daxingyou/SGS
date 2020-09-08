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
		file = Path.getCSB("PopupAwakeResult2", "hero"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClickTouch"}},
			}
		}
	}
	PopupAwakeResult.super.ctor(self, resource,nil,nil,true)
end

function PopupAwakeResult:onCreate()
	-- for i = 2, 5 do
	-- 	self["_fileNodeAttr"..i]:setNameColor(Colors.LIST_TEXT)
	-- 	self["_fileNodeAttr"..i]:setCurValueColor(Colors.DARK_BG_ONE)
	-- 	self["_fileNodeAttr"..i]:setNextValueColor(Colors.DARK_BG_ONE)
	-- 	self["_fileNodeAttr"..i]:showDiffValue(false)
	-- end
    self:_dealPosI18n()
end

function PopupAwakeResult:onEnter()
	self._canContinue = false
	self:_updateInfo()
	self:_initEffect()
	self:_playEffect()
	self:_playCurHeroVoice()
	--self:_createRoleEffect()
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

		if self._talentDes ~= "" then   -- bug：出现为空 可能会导致闪退,(==""时升级不升星，这是什么规则啊。。。。。)
			local desTitle = Lang.get("horse_detail_title_talent") .. string.match(self._talentDes, "%d+")
			local talentName = " [" .. desTitle .. "] "  
			self._talentDes = Lang.get("txt_hero_resault_talent") .. talentName .. heroAwakenConfig.detail_description
		end
    else
		self._talentDes = Lang.get("hero_break_txt_all_unlock")
		-- self._textTalent:setString(self._talentDes)
		-- self._nodeTxt2:setVisible(false) -- 隐藏天赋描述
	end
 
	self._awakeLevel = awakeLevel
    local star1, level1 = UserDataHelper.convertAwakeLevel(awakeLevel-1)
    local star2, level2 = UserDataHelper.convertAwakeLevel(awakeLevel)
	-- self._textOldLevel:setString(Lang.get("hero_awake_star_level", {star = star1, level = level1}))
	-- self._textNewLevel:setString(Lang.get("hero_awake_star_level", {star = star2, level = level2}))
	-- local str = Lang.get("common_title_awaken_level")
	-- str = string.gsub(str, ":", "")
	-- self._textLevelName:setString(str)  
	self._commonStar:setStarOrMoonForPlay(star1)   
	self._commonStar:playStar(star2, 0.5)--playStarOrMoon(star2)
 

	local curAttr = UserDataHelper.getAwakeAttr(self._heroUnitData, -1)
	local nextAttr = UserDataHelper.getAwakeAttr(self._heroUnitData)
    local curDesInfo = TextHelper.getAttrInfoBySort(curAttr)
	local nextDesInfo = TextHelper.getAttrInfoBySort(nextAttr)
	
    -- for i = 2, 5 do
    --     local curInfo = curDesInfo[i-1]
    --     local nextInfo = nextDesInfo[i-1] or {}
    --     if curInfo then
    --         self["_fileNodeAttr"..i]:updateInfo(curInfo.id, curInfo.value, nextInfo.value, 4)
    --         self["_textDiffValue"..i-1]:setString(nextInfo.value - curInfo.value)
    --         self["_fileNodeAttr"..i]:setVisible(true)
	-- 		self["_textDiffValue"..i-1]:setVisible(true)
	-- 		self["_fileNodeAttr"..i]:setNextValueColor(Colors.DARK_BG_ONE)
	-- 		-- 去除“：”
	-- 		local textName = ccui.Helper:seekNodeByName(self["_fileNodeAttr"..i], "TextName"):getString() 
	-- 		textName = string.gsub(textName, ":", "")
	-- 		ccui.Helper:seekNodeByName(self["_fileNodeAttr"..i], "TextName"):setString(textName)
    --     else
    --         self["_fileNodeAttr"..i]:setVisible(false)
    --         self["_textDiffValue"..i-1]:setVisible(false)
    --     end
    -- end
end

function PopupAwakeResult:_playCurHeroVoice()
    local baseId = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)
    G_HeroVoiceManager:playVoiceWithHeroId(baseId, true)
end

function PopupAwakeResult:_initEffect()
	self._nodeContinue:setVisible(false) 
	ccui.Helper:seekNodeByName(self._nodeContinue, "Text_continue_desc"):setColor(Colors.getSummaryStarColor()) 
	--ccui.Helper:seekNodeByName(self._nodeContinue, "Continue_Image"):setVisible(false)
	--self._nodeTxt3:setVisible(false)
	-- for i = 2, 5 do
	-- 	self["_fileNodeAttr"..i]:setVisible(false)
	-- end

	
	
	local effectTitle = "effect_upchenggong_ui"
	local effectDengLong = "effect_tupochenggong_denglong"
	G_EffectGfxMgr:createPlayGfx(self._nodeEffectTitle, effectTitle)
	G_EffectGfxMgr:createPlayGfx(self._nodeEffectDengLong, effectDengLong)
end

function PopupAwakeResult:_playEffect()
	local function effectFunction(effect)
		if effect == "smoving_wujiangbreak_txt_big" then 	-- smoving用法
			local node = cc.Node:create()
			local desNode = CSHelper.loadResourceNode(Path.getCSB("CommonTalentTitle", "common"))
			desNode:setTitle(self._talentDes)
			
			if self._talentDes == "" then -- bug：出现为空 可能会导致闪退,(==""时升级不升星，这是什么规则啊。。。。。)
				desNode:setOpacity(0)
			end
			G_EffectGfxMgr:applySingleGfx(desNode, "smoving_wujiangbreak_txt_big", nil, nil, nil)
			node:addChild(desNode)
			return node
		end

		if string.find(effect, "moving_wujiangbreak_txt") then  -- moving用法
			local num = tonumber(string.match(effect, "%d+"))
			local function effectFunction1(effect_2)
				if effect_2 == "target" then  				 
					if num == 1 or self:_isExist(num) ~= nil then
						local desNode = CSHelper.loadResourceNode(Path.getCSB("CommonAttrDiff", "common"))
						self:_createFileNodeAttr(num, desNode)
						return desNode 
					else   
						return cc.Node:create()   
					end	
				end
				if effect_2 == "smoving_wujiangbreak_txt_green" then  -- 创建绿色字
					local node = cc.Node:create()
					if num == 1 then
						return node   -- 第一个无绿色字 特殊处理,
					else  
						if self:_isExist(num) == nil then  
							return node 
						else  
							local desNode = self:_createGreenText(num)
							G_EffectGfxMgr:applySingleGfx(desNode, "smoving_wujiangbreak_txt_green", nil, nil, nil)
							node:addChild(desNode)
						end	
					end
					return node
				end
			end

			if num == 1 or self:_isExist(num) ~= nil then
				local node = cc.Node:create()
				G_EffectGfxMgr:createPlayMovingGfx(node, effect, effectFunction1, nil , false)
				return node
			else  
				return cc.Node:create()
			end	
		end


        return cc.Node:create()
    end

    local function eventFunction(event)
    	local stc, edc = string.find(event, "play_txt2_")
    	if stc then
    		-- local index = string.sub(event, edc+1, -1)
			-- self["_fileNodeAttr"..index]:setVisible(true)
			-- if self["_fileNodeAttr"..index].showArrow then
			-- 	self["_fileNodeAttr"..index]:showArrow(false)
			-- end
    		-- G_EffectGfxMgr:applySingleGfx(self["_fileNodeAttr"..index], "smoving_wujiangbreak_txt_2", nil, nil, nil)
    	elseif event == "play_txt1" then
 
        elseif event == "star" then
 
        elseif event == "play_txt3" then
 
        elseif event == "finish" then
        	self._canContinue = true
			self._nodeContinue:setVisible(true)  --已经在特效中 无需 	
        end
    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_up_chenggong", effectFunction, eventFunction , false)
    effect:setPosition(cc.p(0, 0))
    
end

function PopupAwakeResult:_createRoleEffect()
	local CSHelper = require("yoka.utils.CSHelper")
	local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
	local unitData = G_UserData:getHero():getUnitDataWithId(self._heroId)
	local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(unitData)
	local limitLevel = avatarLimitLevel or unitData:getLimit_level()
	local limitRedLevel = arLimitLevel or unitData:getLimit_rtg()

	local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
	avatar:updateUI(heroBaseId, limitLevel, limitRedLevel)
	local size = self:getContentSize()
	avatar:setPosition(cc.p(size.width / 2, 0))  
	self._avatar:addChild(avatar)
end

function PopupAwakeResult:_createFileNodeAttr(num, nodeAttr)
	nodeAttr:setNameColor(Colors.getSummaryStarColor())
	nodeAttr:setCurValueColor(Colors.DARK_BG_ONE)
	nodeAttr:setNextValueColor(Colors.DARK_BG_ONE)
	nodeAttr:showDiffValue(false) 
	nodeAttr:showArrow(false)  -- 绿色箭头
	
	if num == 1 then
		local textName = ccui.Helper:seekNodeByName(nodeAttr, "TextName")
		local textCurValue = ccui.Helper:seekNodeByName(nodeAttr, "TextCurValue") 
		local textNextValue = ccui.Helper:seekNodeByName(nodeAttr, "TextNextValue")  

		local star1, level1 = UserDataHelper.convertAwakeLevel(self._awakeLevel-1)
		local star2, level2 = UserDataHelper.convertAwakeLevel(self._awakeLevel)
		textCurValue:setString(Lang.get("hero_awake_star_level", {star = star1, level = level1}))
		textNextValue:setString(Lang.get("hero_awake_star_level", {star = star2, level = level2}))
		local str = Lang.get("common_title_awaken_level")
		str = string.gsub(str, ":", "")
		textName:setString(str)  
	else
		local curAttr = UserDataHelper.getAwakeAttr(self._heroUnitData, -1)
		local nextAttr = UserDataHelper.getAwakeAttr(self._heroUnitData)
		local curDesInfo = TextHelper.getAttrInfoBySort(curAttr)
		local nextDesInfo = TextHelper.getAttrInfoBySort(nextAttr)
	
		local curInfo = curDesInfo[num-1]
		local nextInfo = nextDesInfo[num-1] or {}		
        if curInfo then
            nodeAttr:updateInfo(curInfo.id, curInfo.value, nextInfo.value, 4)
            nodeAttr:setVisible(true)
			nodeAttr:setNextValueColor(Colors.DARK_BG_ONE)
			-- 去除“：”
			local textName = ccui.Helper:seekNodeByName(nodeAttr, "TextName"):getString() 
			textName = string.gsub(textName, ":", "")
			ccui.Helper:seekNodeByName(nodeAttr, "TextName"):setString(textName)
        -- else
        --     self["_fileNodeAttr"..i]:setVisible(false)
        --     self["_textDiffValue"..i-1]:setVisible(false)
        end
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

function PopupAwakeResult:_createGreenText(num)
	if num == 1 then
		return 
	end

	local textNum = ccui.Text:create("", Path.getCommonFont(), 22)
	textNum:setColor(Colors.CUSTOM_ACT_DES_HILIGHT) 

	-- num == 1 没有绿色数字
	local curAttr = UserDataHelper.getAwakeAttr(self._heroUnitData, -1)
	local nextAttr = UserDataHelper.getAwakeAttr(self._heroUnitData)
    local curDesInfo = TextHelper.getAttrInfoBySort(curAttr)
	local nextDesInfo = TextHelper.getAttrInfoBySort(nextAttr)

	local curInfo = curDesInfo[num-1]
	local nextInfo = nextDesInfo[num-1] or {}
	if curInfo then
		textNum:setString(nextInfo.value - curInfo.value)
		textNum:setVisible(true)

		--添加+号
		local str = "+" .. textNum:getString() 
		textNum:setString(str) 
	-- else
	-- 	textNum:setVisible(false)
	end

	return textNum
end

function PopupAwakeResult:_isExist(num)
	local curAttr = UserDataHelper.getAwakeAttr(self._heroUnitData, -1)
	local nextAttr = UserDataHelper.getAwakeAttr(self._heroUnitData)
    local curDesInfo = TextHelper.getAttrInfoBySort(curAttr)
	local nextDesInfo = TextHelper.getAttrInfoBySort(nextAttr)

	local curInfo = curDesInfo[num-1]
	local nextInfo = nextDesInfo[num-1] or {}
	return curInfo 
end

-- i18n pos lable
function PopupAwakeResult:_dealPosI18n()
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


return PopupAwakeResult