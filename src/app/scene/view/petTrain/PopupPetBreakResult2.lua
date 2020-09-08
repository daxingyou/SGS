--
-- Author: hedili
-- Date: 2018-01-30 15:17:50
-- 神兽升星结果
local PopupBase = require("app.ui.PopupBase")
local PopupPetBreakResult = class("PopupPetBreakResult", PopupBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local AttributeConst = require("app.const.AttributeConst")
local CSHelper = require("yoka.utils.CSHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")

function PopupPetBreakResult:ctor(parentView, petId)
    self._parentView = parentView
	self._petId = petId

	local resource = {
		file = Path.getCSB("PopupPetBreakResult2", "pet"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClickTouch"}},
			}
		}
	}
	PopupPetBreakResult.super.ctor(self, resource,nil,nil,true)
end

function PopupPetBreakResult:onCreate()
	-- for i = 1, 1 do
	-- 	self["_fileNodeAttr"..i]:setNameColor(Colors.LIST_TEXT)
	-- 	self["_fileNodeAttr"..i]:setCurValueColor(Colors.DARK_BG_ONE)
	-- 	self["_fileNodeAttr"..i]:setNextValueColor(Colors.DARK_BG_ONE)
	-- 	self["_fileNodeAttr"..i]:showDiffValue(false)
	-- end
end

function PopupPetBreakResult:onEnter()
	self._canContinue = false
	self:_updateInfo()
	self:_initEffect()
	self:_playEffect()
	--self:_createRoleEffect()
end

function PopupPetBreakResult:onShowFinish( ... )
	-- body

end

function PopupPetBreakResult:onExit()
	
    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_END)
    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP,"PopupPetBreakResult:_createRoleEffect")
end

function PopupPetBreakResult:_onClickTouch()
	if self._canContinue then
        if self._parentView and self._parentView.showPetAvatar then
            self._parentView:showPetAvatar()
        end
		self:close()
	end
end

function PopupPetBreakResult:_updateInfo()
	self._petUnitData = G_UserData:getPet():getUnitDataWithId(self._petId)
	if self._petUnitData == nil then
		local curPetId = G_UserData:getPet():getCurPetId()
		self._petUnitData = G_UserData:getPet():getUnitDataWithId(curPetId)
	end
	local petBaseId = self._petUnitData:getBase_id()

	local starLevel = self._petUnitData:getStar()
	self._starLevel = starLevel
	local petStarConfig = UserDataHelper.getPetStarConfig(petBaseId, starLevel)
	self._talentName = petStarConfig.talent_name
	self._talentDes = petStarConfig.talent_description
	-- 天赋
	local str = " [".. self._talentName  .. "] " .. self._talentDes
	self._talentName = Lang.get("txt_hero_resault_talent") .. str


	-- self._textOldLevel:setString(Lang.get("pet_break_result_level", {level = starLevel - 1}))
	-- local strStarLevel = Lang.get("pet_break_result_level", {level = starLevel})
	-- self._textNewLevel:setString(strStarLevel)

	local curBreakAttr = UserDataHelper.getPetBreakShowAttr(self._petUnitData, -1)
	local nextBreakAttr = UserDataHelper.getPetBreakShowAttr(self._petUnitData)

	--self._fileNodeAttr1:updateValue(AttributeConst.PET_ALL_ATTR, 
	-- curBreakAttr[AttributeConst.PET_ALL_ATTR], 
	-- nextBreakAttr[AttributeConst.PET_ALL_ATTR], 3)

	local add = nextBreakAttr[AttributeConst.PET_ALL_ATTR] - curBreakAttr[AttributeConst.PET_ALL_ATTR]
	add = add / 10
--	self._textDiffValue1:setString("+"..add.."%")
	
	self._commonStar:setCount(starLevel, self._petUnitData:getStarMax())
	self._commonStar:playStar(self._petUnitData:getStar(),0.5)
end



function PopupPetBreakResult:_initEffect() 
	self._nodeContinue:setVisible(false)
	ccui.Helper:seekNodeByName(self._nodeContinue, "Text_continue_desc"):setColor(Colors.getSummaryStarColor()) 
	--ccui.Helper:seekNodeByName(self._nodeContinue, "Continue_Image"):setVisible(false)
	-- self._nodeTxt1:setVisible(false)
	-- self._nodeTxt3:setVisible(false)
	-- for i = 1, 1 do
	-- 	self["_fileNodeAttr"..i]:setVisible(false)
	-- end

	local effectTitle = "effect_upchenggong_ui"
	local effectDengLong = "effect_tupochenggong_denglong"
	G_EffectGfxMgr:createPlayGfx(self._nodeEffectTitle, effectTitle)
	G_EffectGfxMgr:createPlayGfx(self._nodeEffectDengLong, effectDengLong)
end

function PopupPetBreakResult:_playEffect()
	local function effectFunction(effect)
		if effect == "smoving_wujiangbreak_txt_big" then 	-- smoving用法
			local node = cc.Node:create()
			local desNode = CSHelper.loadResourceNode(Path.getCSB("CommonTalentTitle", "common"))
			--desNode:setTitle(self._talentName)
			local textTalent = ccui.Helper:seekNodeByName(desNode, "Text_talent")
			textTalent:ignoreContentAdaptWithSize(true)
			textTalent:setTextAreaSize(cc.size(450, 0)) 
			--textTalent:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
			textTalent:setString(self._talentName)
			local aaa =  textTalent:getContentSize().height
			if textTalent:getContentSize().height > textTalent:getFontSize()*3 then
				textTalent:setFontSize(15)
			else  
				textTalent:setFontSize(20)	  
			end

			G_EffectGfxMgr:applySingleGfx(desNode, "smoving_wujiangbreak_txt_big", nil, nil, nil)
			node:addChild(desNode)
			return node
		end

		if string.find(effect, "moving_wujiangbreak_txt") then  -- moving用法
			local num = tonumber(string.match(effect, "%d+"))
			local function effectFunction1(effect_2)
				if effect_2 == "target" then  				 
					if num <= 2 then
						local desNode = CSHelper.loadResourceNode(Path.getCSB("CommonAttrDiff", "common"))
						self:_createFileNodeAttr(num, desNode)
						return desNode 
					else   
						return cc.Node:create()   
					end	
				end
				if effect_2 == "smoving_wujiangbreak_txt_green" then  -- 创建绿色字
					local node = cc.Node:create()
					if num ~= 2 then
						return node   -- 第一个无绿色字 特殊处理,
					else  
						local desNode = self:_createGreenText(num)
						G_EffectGfxMgr:applySingleGfx(desNode, "smoving_wujiangbreak_txt_green", nil, nil, nil)
						node:addChild(desNode)
					end
					return node
				end
			end

			if num > 2 then
				return cc.Node:create()
			else   
				local node = cc.Node:create()
				G_EffectGfxMgr:createPlayMovingGfx(node, effect, effectFunction1, nil , false)
				return node
			end	
		end


        return cc.Node:create()
    end

    local function eventFunction(event)
    	local stc, edc = string.find(event, "play_txt2_")
    	if stc then
 
    	elseif event == "play_txt1" then
 
        elseif event == "play_txt5" then
        	--self:_createRoleEffect()
        elseif event == "play_txt3" then
 
        elseif event == "finish" then
        	self._canContinue = true
        	self._nodeContinue:setVisible(true)
			G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_TOUCH_AUTH_BEGIN,"PopupPetBreakResult")
        end
    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_up_chenggong", effectFunction, eventFunction , false)
    effect:setPosition(cc.p(0, 0))
    
end

function PopupPetBreakResult:_createRoleEffect()
	local TypeConvertHelper = require("app.utils.TypeConvertHelper")
	local petSpine = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
	local petBaseId = self._petUnitData:getBase_id()
	petSpine:setConvertType(TypeConvertHelper.TYPE_PET)
	petSpine:updateUI(petBaseId)
	petSpine:setScale(1)
	petSpine:showShadow(false)
	self._avatar:addChild(petSpine)
end

function PopupPetBreakResult:_createFileNodeAttr(num, nodeAttr)
	nodeAttr:setNameColor(Colors.getSummaryStarColor())
	nodeAttr:setCurValueColor(Colors.DARK_BG_ONE)
	nodeAttr:setNextValueColor(Colors.DARK_BG_ONE)
	nodeAttr:showDiffValue(false) 
	nodeAttr:showArrow(false)  -- 绿色箭头


	if num == 1 then
		local textName = ccui.Helper:seekNodeByName(nodeAttr, "TextName")
		local textCurValue = ccui.Helper:seekNodeByName(nodeAttr, "TextCurValue") 
		local textNextValue = ccui.Helper:seekNodeByName(nodeAttr, "TextNextValue")  
		local str = Lang.get("common_title_pet_level")
		str = string.gsub(str, ":", "")
		textName:setString(str)  
		textCurValue:setString(Lang.get("pet_break_result_level", {level = self._starLevel - 1}))
		textNextValue:setString(Lang.get("pet_break_result_level", {level = self._starLevel}))
	else

		local curBreakAttr = UserDataHelper.getPetBreakShowAttr(self._petUnitData, -1)
		local nextBreakAttr = UserDataHelper.getPetBreakShowAttr(self._petUnitData)
	
		nodeAttr:updateValue(AttributeConst.PET_ALL_ATTR, 
								curBreakAttr[AttributeConst.PET_ALL_ATTR], 
								nextBreakAttr[AttributeConst.PET_ALL_ATTR], 3)
		-- 去除“：”
		local textName = ccui.Helper:seekNodeByName(nodeAttr, "TextName"):getString() 
		textName = string.gsub(textName, ":", "")
		ccui.Helper:seekNodeByName(nodeAttr, "TextName"):setString(textName)	
		nodeAttr:setNextValueColor(Colors.DARK_BG_ONE)						
	end


	-- 调整属性
	ccui.Helper:seekNodeByName(nodeAttr, "ImageUpArrow"):setVisible(false) 
	ccui.Helper:seekNodeByName(nodeAttr, "TextAddValue"):setVisible(false)  
	ccui.Helper:seekNodeByName(nodeAttr, "TextName"):setAnchorPoint(cc.p(0, 0))
	ccui.Helper:seekNodeByName(nodeAttr, "TextName"):setPosition(cc.p(-191, -11))
	ccui.Helper:seekNodeByName(nodeAttr, "TextCurValue"):setAnchorPoint(cc.p(1, 0))
	ccui.Helper:seekNodeByName(nodeAttr, "TextCurValue"):setPosition(cc.p(15, -11))
	ccui.Helper:seekNodeByName(nodeAttr, "TextNextValue"):setAnchorPoint(cc.p(1, 0))
	ccui.Helper:seekNodeByName(nodeAttr, "TextNextValue"):setPosition(cc.p(152, -11))
end

function PopupPetBreakResult:_createGreenText(num)
	if num ~= 2 then
		return 
	end

	local textNum = ccui.Text:create("", Path.getCommonFont(), 22)
	textNum:setColor(Colors.CUSTOM_ACT_DES_HILIGHT) 

	local curBreakAttr = UserDataHelper.getPetBreakShowAttr(self._petUnitData, -1)
	local nextBreakAttr = UserDataHelper.getPetBreakShowAttr(self._petUnitData)
	local add = nextBreakAttr[AttributeConst.PET_ALL_ATTR] - curBreakAttr[AttributeConst.PET_ALL_ATTR]
	add = add / 10
 	textNum:setString("+"..add.."%")

	return textNum
end

return PopupPetBreakResult

