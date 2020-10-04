--
-- Author: Liangxu
-- Date: 2017-04-17 15:49:06
-- 装备强化
local ViewBase = require("app.ui.ViewBase")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local EquipTrainStrengthenLayer = class("EquipTrainStrengthenLayer", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local EquipTrainHelper = require("app.scene.view.equipTrain.EquipTrainHelper")
local TextHelper = require("app.utils.TextHelper")
local EquipMasterHelper = require("app.scene.view.equipTrain.EquipMasterHelper")
local MasterConst = require("app.const.MasterConst")
local ParameterIDConst = require("app.const.ParameterIDConst")
local CSHelper = require("yoka.utils.CSHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local AudioConst = require("app.const.AudioConst")
local UIHelper  = require("yoka.utils.UIHelper")
local UIConst = require("app.const.UIConst")

function EquipTrainStrengthenLayer:ctor(parentView)
	self._parentView = parentView

 
	self._textOldLevel1 = nil --当前等级
	self._textOldLevel2 = nil --当前等级
	self._textNewLevel = nil --下一等级
	self._fileNodeAttr = nil --属性变化
	self._buttonStrengFive = nil --强化5次按钮
	self._buttonStreng = nil --强化按钮
	self._fileNodeSliver = nil --花销

	local resource = {
		file = Path.getCSB("EquipTrainStrengthenLayer2", "equipment"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonStrengFive = {
				events = {{event = "touch", method = "_onButtonStrengFiveClicked"}},
			},
			_buttonStreng = {
				events = {{event = "touch", method = "_onButtonStrengClicked"}},
			},
		},
	}
	self:setName("EquipTrainStrengthenLayer")
	self:enableNodeEvents()       
	EquipTrainStrengthenLayer.super.ctor(self, resource)
end

function EquipTrainStrengthenLayer:onCreate()
	self:_doLayout()
	-- i18n pos lable
	self:_dealPosI18n()
	self:_initData()
	self:_initView()
end

function EquipTrainStrengthenLayer:onEnter()
	self._signalEquipUpgradeSuccess = G_SignalManager:add(SignalConst.EVENT_EQUIP_UPGRADE_SUCCESS, handler(self, self._equipUpgradeSuccess))
	self:_updateData()
	self:_updateView()
	if Lang.checkUI("ui4") then
		G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
	end
end

function EquipTrainStrengthenLayer:onExit()
	self._signalEquipUpgradeSuccess:remove()
	self._signalEquipUpgradeSuccess = nil
end

function EquipTrainStrengthenLayer:_doLayout()

	
	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)                   --  设置node节点尺寸
end

function EquipTrainStrengthenLayer:_initData()
	self._isLimit = false --是否达到上限
	self._isGlobalLimit = false --是否达到开放等级上限
	self._newMasterLevel = 0 --新强化大师等级
	self._successData = nil --强化成功返回的数据
	self._ratio = require("app.config.parameter").get(ParameterIDConst.MAX_EQUIPMENT_LEVEL).content / 1000
	self._beforeMasterInfo = nil --保存强化之前的强化大师信息
	self._equipData = nil --当前装备数据
	self._curAttrInfo = {}
	self._nextAttrInfo = nil
	self._diffLevel = 0 --等级差
	self._pageItems = {}
end

function EquipTrainStrengthenLayer:_initView()
	self._fileNodeDetailTitle:setFontSize(22)
	self._fileNodeDetailTitle:setTitle(Lang.get("equipment_strengthen_detail_title")) 
	self._buttonStrengFive:setFontSize(20)   
	self._buttonStreng:setFontSize(20)
	self._buttonStrengFive:setFontName(Path.getFontW8())
	self._buttonStreng:setFontName(Path.getFontW8())
	self._buttonStrengFive:setString(Lang.get("equipment_strengthen_btn_five"))
	self._buttonStreng:setString(Lang.get("equipment_strengthen_btn"))
	-- self._parentView._buttonLeft:setEnabled(true)
	-- self._parentView._buttonRight:setEnabled(true)
end

function EquipTrainStrengthenLayer:updateInfo()
	self:_updateData()
	self:_updateView()
	self:_updateItemAvatar()
end

function EquipTrainStrengthenLayer:_updateItemAvatar()
	--local selectedPos = self._parentView:getSelectedPos()
	--self._pageItems[selectedPos].avatar:updateUI(self._equipData:getBase_id()) 
	local avatar = self:_getAvatar()
	avatar:updateUI(self._equipData:getBase_id()) 
end

function EquipTrainStrengthenLayer:_updateData()
	local curEquipId = G_UserData:getEquipment():getCurEquipId()
	if curEquipId == nil then
		self._equipData = nil
		return
	end
	self._equipData = G_UserData:getEquipment():getEquipmentDataWithId(curEquipId)
	local curLevel = self._equipData:getLevel()
	local maxLevel = math.ceil(G_UserData:getBase():getLevel() * self._ratio)
	self._isLimit = curLevel >= maxLevel --是否已达上限

	self:_updateAttrData()
end

function EquipTrainStrengthenLayer:_updateAttrData()
	self._curAttrInfo = UserDataHelper.getEquipStrengthenAttr(self._equipData)
	self._nextAttrInfo = UserDataHelper.getEquipStrengthenAttr(self._equipData, 1)
	if self._nextAttrInfo == nil then --到顶级了
		self._nextAttrInfo = {}
		self._isGlobalLimit = true
	end

	G_UserData:getAttr():recordPower()  
	-- if self._successData and self._successData.times == 1 then
	-- 	G_UserData:getAttr():recordPowerWithKey(FunctionConst.FUNC_EQUIP_TRAIN_TYPE1) 
	-- elseif self._successData and self._successData.times == 5 then 
	-- 	G_UserData:getAttr():recordPowerWithKey(FunctionConst.FUNC_EQUIP_STRENGTHEN_FIVE)  
	-- end
end
 
function EquipTrainStrengthenLayer:_updateView()
	if self._equipData == nil then
		return
	end
	
	self:_updateBaseInfo()
	self:_updateLevel()
	self:_updateAttr()
	self:_updateCost()
end

--基本信息
function EquipTrainStrengthenLayer:_updateBaseInfo()
	local equipBaseId = self._equipData:getBase_id()
	local equipParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_EQUIPMENT, equipBaseId)

	--名字
	local equipName = equipParam.name
	local rLevel = self._equipData:getR_level()
	if rLevel > 0 then
		equipName = equipName.."+"..rLevel
	end
	-- self._textName:setString(equipName)
	-- self._textName:setColor(equipParam.icon_color)
	-- self._textName:enableOutline(equipParam.icon_color_outline, 2)
	-- self._textName2:setString(equipName)
	-- self._textName2:setColor(equipParam.icon_color)
	-- UIHelper.updateTextOutline(self._textName2, equipParam)
	self._nodeTitle:setName(1)

	--装备于
	local heroUnitData = UserDataHelper.getHeroDataWithEquipId(self._equipData:getId())

	-- if heroUnitData == nil then
	-- 	self._textFrom:setVisible(false)
	-- else
	-- 	local baseId = heroUnitData:getBase_id()
	-- 	local limitLevel = heroUnitData:getLimit_level()
	-- 	local limitRedLevel = heroUnitData:getLimit_rtg()
	-- 	self._textFrom:setVisible(true)
	-- 	local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, baseId, nil, nil, limitLevel, limitRedLevel)
	-- 	self._textFrom:setString(Lang.get("treasure_detail_from", {name = heroParam.name}))
	-- end

	--品级
	-- self._textPotential:setString(Lang.get("equipment_detail_txt_potential", {value = equipParam.potential}))
	-- self._textPotential:setColor(equipParam.icon_color)
	-- self._textPotential:enableOutline(equipParam.icon_color_outline, 2)
end

--等级
function EquipTrainStrengthenLayer:_updateLevel()
	local curLevel = self._equipData:getLevel()
	local maxLevel = math.ceil(G_UserData:getBase():getLevel() * self._ratio)

	self._textOldLevel1:setString(curLevel)
	self._textOldLevel2:setString("/"..maxLevel)
	local posX = self._textOldLevel1:getPositionX()
	local posY = self._textOldLevel1:getPositionY()
	local size1 = self._textOldLevel1:getContentSize()
	self._textOldLevel2:setPosition(cc.p(posX + size1.width, posY))

	local newDes = Lang.get("equipment_strengthen_level", {level = curLevel + 1, maxLevel = maxLevel})
	if self._isGlobalLimit then
		newDes = Lang.get("equipment_strengthen_max_level")
	end
	self._textNewLevel:setString(newDes)
end

--属性
function EquipTrainStrengthenLayer:_updateAttr()
	for k, value in pairs(self._curAttrInfo) do
		local nextValue = self._nextAttrInfo[k]
		self._fileNodeAttr:updateInfo(k, value, nextValue, 4)
	end
	self:_adjustFontSizeAndDis()
end

function EquipTrainStrengthenLayer:_adjustFontSizeAndDis()
	-- 属性位置调整
	local offset1 = self["_fileNodeAttr"]:getChildByName("TextName"):getPositionX() + self["_fileNodeAttr"]:getChildByName("TextName"):getContentSize().width
	self["_fileNodeAttr"]:getChildByName("TextCurValue"):setPositionX(offset1 + 8)
	offset1 = self["_fileNodeAttr"]:getChildByName("TextCurValue"):getPositionX() + self["_fileNodeAttr"]:getChildByName("TextCurValue"):getContentSize().width
	self["_fileNodeAttr"]:getChildByName("TextNextValue"):setPositionX(offset1 + 30)
	self["_fileNodeAttr"]:getChildByName("ImageUpArrow"):setPositionX(214)
	self["_fileNodeAttr"]:getChildByName("TextAddValue"):setPositionX(236)
	
	-- 银币
	self._fileNodeSliver:getChildByName("Text"):setFontSize(18)
	self._fileNodeSliver:getChildByName("Text"):setPositionX(18 + 15)
	self._fileNodeSliver:getChildByName("Image"):setPositionY(18 + 3)
	self._fileNodeSliver:getChildByName("Image"):setScale(0.8)

	local width = self._fileNodeSliver:getChildByName("Text"):getContentSize().width + 12 + self._fileNodeSliver:getChildByName("Image"):getContentSize().width*0.8 			
	width = width*0.5
	self._fileNodeSliver:setPositionX(self._textCostTitle:getPositionX() + 2)   
end

--花费
function EquipTrainStrengthenLayer:_updateCost()
	if self._isLimit then
		self._textCostTitle:setVisible(false)
		self._fileNodeSliver:setVisible(false)
	else
		self._textCostTitle:setVisible(true)
		self._fileNodeSliver:setVisible(true)
		self._costValue = UserDataHelper.getLevelupCostValue(self._equipData)
		self._fileNodeSliver:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_GOLD, self._costValue)
		self._fileNodeSliver:setTextColor(Colors.BRIGHT_BG_TWO)
	end
end

function EquipTrainStrengthenLayer:_onButtonStrengFiveClicked()
	if self:_checkStrengthenCondition() == false then
		return
	end
	
	if EquipTrainHelper.isOpen(FunctionConst.FUNC_EQUIP_STRENGTHEN_FIVE) == false then
		return
	end

	self:_saveBeforeMasterInfo()

	local curEquipId = G_UserData:getEquipment():getCurEquipId()
	G_UserData:getEquipment():c2sUpgradeEquipment(curEquipId, 5)

	self:_setButtonEnable(false)
end

function EquipTrainStrengthenLayer:_onButtonStrengClicked()
	if self:_checkStrengthenCondition() == false then
		return
	end

	self:_saveBeforeMasterInfo()

	local curEquipId = G_UserData:getEquipment():getCurEquipId()
	G_UserData:getEquipment():c2sUpgradeEquipment(curEquipId, 1)

	self:_setButtonEnable(false)
end

function EquipTrainStrengthenLayer:_setButtonEnable(enable)
	self._buttonStreng:setEnabled(enable)
	self._buttonStrengFive:setEnabled(enable)
	--self._parentView:setArrowBtnEnable(enable)
end

function EquipTrainStrengthenLayer:_checkStrengthenCondition()
	if self._isLimit then
		G_Prompt:showTip(Lang.get("equipment_strengthen_limit_tip"))
		return false
	end

	local isOk, func = LogicCheckHelper.enoughMoney(self._costValue)
	if not isOk then
		func()
		return false
	end

	return true
end

function EquipTrainStrengthenLayer:_equipUpgradeSuccess(eventName, data)
	self._successData = data

	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint()
	end

	self:_recordDiffLevel()
	self:_updateData()
	self:_playEffect()
end

function EquipTrainStrengthenLayer:_getAvatar()
	if self._parentView then
		return self._parentView:getEquipAvatar()
	end

	return nil 
end

function EquipTrainStrengthenLayer:_playEffect()
	local function effectFunction(effect)
        if effect == "effect_equipqianghua_shuxian" then
            local subEffect = EffectGfxNode.new("effect_equipqianghua_shuxian")
            subEffect:play()
            return subEffect
        end
    		
        return cc.Node:create()
    end

    local function eventFunction(event)
    	if event == "play" then
			--播装备颤抖
			local node = self:_getAvatar()
			if node then
				G_EffectGfxMgr:applySingleGfx(node, "smoving_zhuangbei", nil, nil, nil)
			end
		elseif event == "next" then
			self._newMasterLevel = self:_checkIsReachNewMasterLevel()
    		if not self._newMasterLevel then
				self:_playStrSuccessPrompt()
			end
			self:_setButtonEnable(true)
		elseif event == "finish" then
			
        end
	end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self._parentView, "moving_equipqianghua", effectFunction, eventFunction , false)
	local offsetX = require("app.const.UIConst").EFFECT_OFFSET_X
	local pos = self._parentView:convertToNodeSpace(cc.p(G_ResolutionManager:getDesignWidth()*0.5+offsetX, G_ResolutionManager:getDesignHeight()*0.5))

    effect:setPosition(cc.p(pos.x, pos.y))
    G_AudioManager:playSoundWithId(AudioConst.SOUND_EQUIP_STRENGTHEN) --播音效
end

--保存强化前的强化大师信息
function EquipTrainStrengthenLayer:_saveBeforeMasterInfo()
	local pos = self._equipData:getPos()
	self._beforeMasterInfo = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_1)
end

--检查是否达到了新的强化大师等级
function EquipTrainStrengthenLayer:_checkIsReachNewMasterLevel()
	local pos = self._equipData:getPos()
	local curMasterInfo = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_1)


	if self._beforeMasterInfo then
		local beforeLevel = self._beforeMasterInfo.masterInfo.curMasterLevel
		local curLevel = curMasterInfo.masterInfo.curMasterLevel
		if curLevel > beforeLevel then
			local popup = require("app.scene.view.equipment.PopupMasterLevelup").new(self, self._beforeMasterInfo, curMasterInfo, MasterConst.MASTER_TYPE_1)
			popup:openWithAction()
			return curLevel
		end
	end
	
	return false
end

--
function EquipTrainStrengthenLayer:onExitPopupMasterLevelup()
	self:_playStrSuccessPrompt()
end

--播放强化成功后的飘字
function EquipTrainStrengthenLayer:_playStrSuccessPrompt()
	self:_updateCost()
	local data = self._successData
	local times = data.times
	local critTimes = data.critTimes
	local breakReason = data.breakReason
	local level = data.level
	local crits = data.crits
	local saveMoney = data.saveMoney

	local critInfo = {}
	for i, multiple in ipairs(crits) do
		if multiple > 1 then
			if critInfo[multiple] == nil then
				critInfo[multiple] = 0
			end
			critInfo[multiple] = critInfo[multiple] + 1
		end
	end

	local summary = {}

	local param1= {
		content = Lang.get("summary_equip_str_success_tip6"),
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
	}
	table.insert(summary, param1)

	if self._newMasterLevel and self._newMasterLevel > 0 then
		local param = {
			content = Lang.get("summary_equip_str_master_reach", {level = self._newMasterLevel}),
			startPosition = {UIConst.SUMMARY_OFFSET_X_TRAIN},
		}
		table.insert(summary, param)
	end

	local param3 = {
		content = Lang.get("summary_equip_str_success_tip3", {value = self._diffLevel}),
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
		dstPosition = UIHelper.convertSpaceFromNodeToNode(self._textOldLevel1, G_SceneManager:getRunningScene()), -- 飞向文字
		finishCallback = function()
			if self._textOldLevel1 and self._updateLevel then
				self._textOldLevel1:updateTxtValue(self._equipData:getLevel())
				self:_updateLevel()
			end
		end,
	}
	table.insert(summary, param3)

	--暴击 	 
	if critTimes > 0 then
		for multiple, count in pairs(critInfo) do
			local param = {
				content = Lang.get("summary_equip_str_success_tip2", {multiple = multiple, count = count}),
				startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
			}
			table.insert(summary, param)
		end
	end
	--节省
	if saveMoney > 0 then
		local param = {
			content = Lang.get("summary_equip_str_success_tip5", {value = saveMoney}),
			startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
		}
		table.insert(summary, param)
	end

	local curLevel = self._equipData:getLevel()
	local attrDiff = UserDataHelper.getEquipStrengthenAttrDiff(self._equipData, curLevel - self._diffLevel, curLevel)
	local attrName = ""
	local attrValue = 0
	for k, value in pairs(attrDiff) do
		attrName, attrValue = TextHelper.getAttrBasicText(k, value)
		break
	end
	local param4 = {
		content = Lang.get("summary_equip_str_success_tip4", {attrName = attrName, attrValue = attrValue}),
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
		dstPosition = UIHelper.convertSpaceFromNodeToNode(self._fileNodeAttr, G_SceneManager:getRunningScene()),  -- 飞向文字
		finishCallback = function()
			if self._equipData then
				for k, value in pairs(self._curAttrInfo) do
					if self._fileNodeAttr then
						local text = self._fileNodeAttr:getSubNodeByName("TextCurValue")
						text:updateTxtValue(value)
						self:_updateAttr()
					end
				end
				self:_onSummaryFinish()
			end
		end,
	}
	table.insert(summary, param4)

	G_Prompt:showSummary(summary)

	--总战力
	G_Prompt:playTotalPowerSummary(UIConst.SUMMARY_OFFSET_X_TRAIN)
end

--记录等级差
function EquipTrainStrengthenLayer:_recordDiffLevel()
	local curLevel = self._equipData:getLevel()
	self._diffLevel = self._successData.level - curLevel
end

--飘字结束后的回调
function EquipTrainStrengthenLayer:_onSummaryFinish()
	self:runAction(cc.Sequence:create(
			cc.DelayTime:create(0.3),
			cc.CallFunc:create(function()
				G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
			end)
		)
	)
end


-- i18n pos lable
function EquipTrainStrengthenLayer:_dealPosI18n()
	if Lang.checkLang(Lang.JA) then
		return
	end

	if not Lang.checkLang(Lang.CN) then
		self._textName2:setFontSize(
			self._textName2:getFontSize()-2
		)
	end
end 


return EquipTrainStrengthenLayer