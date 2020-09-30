--
-- Author: Liangxu
-- Date: 2017-08-02 19:21:57
-- 强化大师升级弹框
local PopupBase = require("app.ui.PopupBase")
local PopupMasterLevelup = class("PopupMasterLevelup", PopupBase)
local MasterConst = require("app.const.MasterConst")
local AudioConst = require("app.const.AudioConst")
local TextHelper = require("app.utils.TextHelper")


local TYPE_RES = {
	[MasterConst.MASTER_TYPE_1] = "img_btn_qianghuadashi01",
	[MasterConst.MASTER_TYPE_2] = "img_btn_qianghuadashi01",
	[MasterConst.MASTER_TYPE_3] = "img_btn_qianghuadashi01",
	[MasterConst.MASTER_TYPE_4] = "img_btn_qianghuadashi01",
}

function PopupMasterLevelup:ctor(parentView, masterInfo1, masterInfo2, masterType)
	self._parentView = parentView
	self._masterInfo1 = masterInfo1
	self._masterInfo2 = masterInfo2
	self._masterType = masterType
	local filePath = Path.getCSB("PopupMasterLevelup", "equipment")
    if Lang.checkUI("ui4") then
        filePath = Path.getCSB("PopupMasterLevelup1", "equipment")
    end
	local resource = {
		file = filePath,
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClickTouch"}},
			}
		}
	}
	PopupMasterLevelup.super.ctor(self, resource)
end

-- i18n change text 
function PopupMasterLevelup:onLangHandle()
	local UIHelper = require("yoka.utils.UIHelper")
	local TypeConst = require("app.i18n.utils.TypeConst")
	local resource = self:getResourceNode()
	local titleImg = ccui.Helper:seekNodeByName(resource, "Image_42")
	titleImg = UIHelper.swap(titleImg,{text=Lang.getImgText("txt_system_qianghuadashi"), style="system_1",styleType=TypeConst.TEXT,h_align=cc.TEXT_ALIGNMENT_LEFT})
end	
function PopupMasterLevelup:onCreate()
	-- i18n change text
	if not Lang.checkLang(Lang.CN) then 
		if not Lang.checkUI("ui4") then 
			self:onLangHandle() 
		end
	end
end

function PopupMasterLevelup:onEnter()
	G_AudioManager:playSoundWithId(AudioConst.SOUND_MASTER) --播音效
	if not Lang.checkUI("ui4") then 
		self:_updateView()
	else
		self:_initEffectByI18n()
		self:_createPlayEffectByI18n()
	end
end

function PopupMasterLevelup:onExit()
	
end

function PopupMasterLevelup:_onClickTouch()
	if self._parentView and self._parentView.onExitPopupMasterLevelup then
		self._parentView:onExitPopupMasterLevelup()
	end
	self:close()
end

function PopupMasterLevelup:_updateView()
	if self == nil or self._parentView == nil or self._masterInfo1 == nil or self._masterInfo2 == nil then
		return
	end
	
	local totalLevel = self._masterInfo1.masterInfo.needLevel
	self._textTotalLevel:setString(Lang.get("equipment_master_total_level", {level = totalLevel}))

	--Icon显示
	local iconRes = Path.getCommonIcon("main", TYPE_RES[self._masterType])
	self._imageIcon1:loadTexture(iconRes)
	self._imageIcon2:loadTexture(iconRes)

	--等级显示
	local name = Lang.get("equipment_master_tab_title_"..self._masterType)
	local level1 = self._masterInfo1.masterInfo.curMasterLevel
	local content1 = Lang.get("equipment_master_level", {
		name = name,
		level = level1,
	})
	local richText1 = ccui.RichText:createWithContent(content1)
	richText1:setAnchorPoint(cc.p(0.5, 1))

	local level2 = self._masterInfo2.masterInfo.curMasterLevel
	local content2 = Lang.get("equipment_master_level", {
		name = name,
		level = level2,
	})
	local richText2 = ccui.RichText:createWithContent(content2)
	richText2:setAnchorPoint(cc.p(0.5, 1))
	self._nodeLevelPos1:addChild(richText1)
	self._nodeLevelPos2:addChild(richText2)

	--属性显示
	for i = 1, 4 do
		self["_nodeAttrDiff"..i]:setVisible(false)
	end

	local attrInfo1 = self._masterInfo1.masterInfo.curAttr
	local attrInfo2 = self._masterInfo2.masterInfo.curAttr
	local index = 1
	for k, value in pairs(attrInfo1) do
		local value2 = attrInfo2[k]
		self["_nodeAttrDiff"..index]:updateInfo(k, value, value2, 3)
		self["_nodeAttrDiff"..index]:setVisible(true)
		index = index + 1
	end
end

--特殊处理
function PopupMasterLevelup:_createPlayEffectByI18n()
	local  numItems = 0
	for k,v in pairs(self._masterInfo1.masterInfo.curAttr) do
		numItems = numItems + 1
	end
	local function effectFunction(effect)
		if effect == "qianghuadengji" then
			local totalLevel = self._masterInfo1.masterInfo.needLevel
			local UIHelper  = require("yoka.utils.UIHelper")
			local txt = Lang.get("equipment_master_total_level", {level = totalLevel})
			local subLabel = UIHelper.createLabel({text=txt, size = 22, outlineSize = 2, color = cc.c3b(0xff, 0xd8, 0x00), outlineColor =  cc.c3b(0x77, 0x29, 0x09)})
			return subLabel
		end			
		if effect == "touxian_1" then
				--Icon显示
			local pNode = cc.Node:create()
			local iconRes = Path.getCommonIcon("main", TYPE_RES[self._masterType])
			local retNode = cc.Sprite:create(iconRes)
					--等级显示
			local name = Lang.get("equipment_master_tab_title_"..self._masterType)
			local level1 = self._masterInfo1.masterInfo.curMasterLevel
			local content1 = Lang.get("equipment_master_level", {
				name = name,
				level = level1,
			})
			local richText1 = ccui.RichText:createWithContent(content1)
			richText1:setAnchorPoint(cc.p(0.5, 1))
			pNode:addChild(richText1)
			richText1:setPositionY(-45)
			pNode:addChild(retNode)
			return pNode

		end
		if effect == "touxian_2" then
			local pNode = cc.Node:create()
			--Icon显示
			local iconRes = Path.getCommonIcon("main", TYPE_RES[self._masterType])
			local retNode = cc.Sprite:create(iconRes)
					--等级显示
			local name = Lang.get("equipment_master_tab_title_"..self._masterType)
			local level2 = self._masterInfo2.masterInfo.curMasterLevel
			local content2 = Lang.get("equipment_master_level", {
				name = name,
				level = level2,
			})
			local richText2 = ccui.RichText:createWithContent(content2)
			richText2:setAnchorPoint(cc.p(0.5, 1))
			pNode:addChild(richText2)
			richText2:setPositionY(-40)
			pNode:addChild(retNode)
			return pNode			
		end

        return cc.Node:create()
    end

	local function eventFunction(event)
		local stc, edc = string.find(event, "play_shuzhi")
    	if stc then
			local index = tonumber( string.sub(event, edc+1, -1) )

			if index and index > 0 and index <= numItems  then
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
			self._nodeContinue:setVisible(true)			
        end
    end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, "moving_qianghuadashi", effectFunction, eventFunction , false)
	effect:setPosition(cc.p(0, 0))
    return effect

end

--添加特效节点
function PopupMasterLevelup:_initEffectByI18n()	
	if Lang.checkUI("ui4") then	
		self._nodeContinue:setVisible(false)
		local pos = {
			-50,-85,-120,-155,-190
		}

		for i = 1, 4 do
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

		-- 处理异常
		if self == nil or self._parentView == nil or self._masterInfo1 == nil or self._masterInfo2 == nil then
			return
		end
		if self._masterInfo1.masterInfo == nil or self._masterInfo1.masterInfo.curAttr == nil or self._masterInfo2.masterInfo == nil or self._masterInfo2.masterInfo.curAttr == nil then
			return
		end

		local attrInfo1 = self._masterInfo1.masterInfo.curAttr
		local attrInfo2 = self._masterInfo2.masterInfo.curAttr
		local index = 1
		for k, value in pairs(attrInfo1) do
			local value2 = attrInfo2[k]
			--更新属性
			self:_updateAttrByI18n(index,k,value,value2)
			index = index + 1
		end
	end
end
--更新属性
function PopupMasterLevelup:_updateAttrByI18n(index, name, value, nextValue)
	local nodeAttr = self["_fileNodeAttr"..index]:getChildByName("infoNode")
	if not nodeAttr then
		return
	end 
	if name == nil or value == nil then
		return
	end

	local textName = ccui.Helper:seekNodeByName(nodeAttr, "TextName")
	local textCurValue = ccui.Helper:seekNodeByName(nodeAttr, "TextCurValue") 
	local textNextValue = ccui.Helper:seekNodeByName(nodeAttr, "TextNextValue")  
	local jiantou = ccui.Helper:seekNodeByName(nodeAttr, "jiantou")  

	local name1, value1 = TextHelper.getAttrBasicText(name, value)
	
	textName:setString(name1)
	textCurValue:setString(value1)

	if nextValue == nil then --达到上限
		textNextValue:setString(Lang.get("equipment_strengthen_max_level"))
		return
	end
	
	local _, value2 = TextHelper.getAttrBasicText(name, nextValue)
	textNextValue:setString(value2)

	--调整属性
	ccui.Helper:seekNodeByName(nodeAttr, "ImageUpArrow"):setVisible(false) 
	ccui.Helper:seekNodeByName(nodeAttr, "TextAddValue"):setVisible(false) 
	textName:setAnchorPoint(cc.p(0, 0))
	textName:setPosition(cc.p(-210, -11))
	textCurValue:setAnchorPoint(cc.p(0, 0))
	textCurValue:setPosition(cc.p(-35, -11))
	textNextValue:setAnchorPoint(cc.p(0, 0))
	textNextValue:setPosition(cc.p(136, -11))
	jiantou:setPositionY(-11)
	jiantou:setPositionX(61)
end	

return PopupMasterLevelup