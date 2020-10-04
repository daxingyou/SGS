--
-- Author: Liangxu
-- Date: 2017-05-10 14:43:21
-- 宝物培养界面
local ViewBase = require("app.ui.ViewBase")
local TreasureTrainView = class("TreasureTrainView", ViewBase)
local TreasureConst = require("app.const.TreasureConst")
local TreasureTrainStrengthenLayer = require("app.scene.view.treasureTrain.TreasureTrainStrengthenLayer")
local TreasureTrainRefineLayer = require("app.scene.view.treasureTrain.TreasureTrainRefineLayer")
local TreasureTrainLimitLayer = require("app.scene.view.treasureTrain.TreasureTrainLimitLayer")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local RedPointHelper = require("app.data.RedPointHelper")
local TreasureTrainHelper = require("app.scene.view.treasureTrain.TreasureTrainHelper")

function TreasureTrainView:ctor(treasureId, trainType, rangeType, isJumpWhenBack)
	G_UserData:getTreasure():setCurTreasureId(treasureId)
	self._selectTabIndex = trainType or TreasureConst.TREASURE_TRAIN_STRENGTHEN
	self._rangeType = rangeType or TreasureConst.TREASURE_RANGE_TYPE_1
	self._isJumpWhenBack = isJumpWhenBack --当点返回时，是否要跳过上一个场景
	self._allTreasureIds = {}

	local resource = {
		file = Path.getCSB("TreasureTrainView", "treasure"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonLeft = {
				events = {{event = "touch", method = "_onButtonLeftClicked"}}
			},
			_buttonRight = {
				events = {{event = "touch", method = "_onButtonRightClicked"}}
			},
		},
	}
	TreasureTrainView.super.ctor(self, resource)
end

function TreasureTrainView:onCreate()
	if not Lang.checkLang(Lang.CN)  then
		self:_dealPosByI18n()
	end
	self._subLayers = {} --存储子layer
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)
	self._topbarBase:setImageTitle("txt_sys_com_baowu")
	if self._isJumpWhenBack then
		self._topbarBase:setCallBackOnBack(handler(self, self._setCallback))
	end
	
	self:_initTab()
end

function TreasureTrainView:onEnter()
	self._signalTreasureRefine = G_SignalManager:add(SignalConst.EVENT_TREASURE_REFINE_SUCCESS, handler(self, self._onRefineSuccess))

	self:_updateTreasureIds()
	self:_calCurSelectedPos()
	self:updateArrowBtn()

	self:updateTabIcons()
	self:_updateView()

	--抛出新手事件出新手事件
    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
end

function TreasureTrainView:onExit()
	self._signalTreasureRefine:remove()
	self._signalTreasureRefine = nil
end

function TreasureTrainView:_updateTreasureIds()
	local treasureId = G_UserData:getTreasure():getCurTreasureId()
	if self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_1 then
		self._allTreasureIds = G_UserData:getTreasure():getRangeDataBySort()
	elseif self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_2 then
		local unit = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
		local pos = unit:getPos()
		if pos then
			self._allTreasureIds = G_UserData:getBattleResource():getTreasureIdsWithPos(pos)
		end
	end
	self._treasureCount = #self._allTreasureIds
end

function TreasureTrainView:_calCurSelectedPos()
	local treasureId = G_UserData:getTreasure():getCurTreasureId()
	self._selectedPos = 1
	for i, id in ipairs(self._allTreasureIds) do
		if id == treasureId then
			self._selectedPos = i
		end
	end
end

function TreasureTrainView:_initTab()
	for i = 1, 3 do
		local txt = Lang.get("treasure_train_tab_icon_"..i)
		local isOpen = LogicCheckHelper.funcIsOpened(FunctionConst["FUNC_TREASURE_TRAIN_TYPE"..i])
		self["_nodeTabIcon"..i]:updateUI(txt, isOpen, i)
		self["_nodeTabIcon"..i]:setCallback(handler(self, self._onClickTabIcon))
	end
end

function TreasureTrainView:_onClickTabIcon(index)
	if index == self._selectTabIndex then
		return
	end

	self._selectTabIndex = index
	self:updateTabIcons()
	self:_updateView()
end

function TreasureTrainView:updateTabIcons()
	self:_doLayoutTabIcons()
	self:_updateTabIconSelectedState()
	self:_updateRedPoint()
end

function TreasureTrainView:_updateTabIconSelectedState()
	for i = 1, 3 do
		self["_nodeTabIcon"..i]:setSelected(i == self._selectTabIndex)
	end
end

function TreasureTrainView:_updateView()
	local layer = self._subLayers[self._selectTabIndex]
	if layer == nil then
		if self._selectTabIndex == TreasureConst.TREASURE_TRAIN_STRENGTHEN then
			layer = TreasureTrainStrengthenLayer.new(self)
		elseif self._selectTabIndex == TreasureConst.TREASURE_TRAIN_REFINE then
			layer = TreasureTrainRefineLayer.new(self)
		elseif self._selectTabIndex == TreasureConst.TREASURE_TRAIN_LIMIT then
			layer = TreasureTrainLimitLayer.new(self)
		end

		if layer then
			self._panelContent:addChild(layer)
			self._subLayers[self._selectTabIndex] = layer
		end
	end
	for k, subLayer in pairs(self._subLayers) do
		subLayer:setVisible(false)
	end
	layer:setVisible(true)
	layer:updateInfo()
end

function TreasureTrainView:_setCallback()
	G_UserData:getTeamCache():setShowTreasureTrainFlag(true)
	G_SceneManager:popSceneByTimes(2) --pop2次，返回阵容界面
end

function TreasureTrainView:checkRedPoint(index)
	local treasureId = G_UserData:getTreasure():getCurTreasureId()
	local unitData = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
	local reach = RedPointHelper.isModuleReach(FunctionConst["FUNC_TREASURE_TRAIN_TYPE"..index], unitData)
	self["_nodeTabIcon"..index]:showRedPoint(reach)
end

function TreasureTrainView:_updateRedPoint()
	for i = 1, 3 do
		self:checkRedPoint(i)
	end
end

function TreasureTrainView:updateArrowBtn()
	self._buttonLeft:setVisible(self._selectedPos > 1)
	self._buttonRight:setVisible(self._selectedPos < self._treasureCount)
end

function TreasureTrainView:setArrowBtnVisible(visible)
	self._buttonLeft:setVisible(visible)
	self._buttonRight:setVisible(visible)
end

function TreasureTrainView:_onButtonLeftClicked()
	if self._selectedPos <= 1 then
		return
	end

	self._selectedPos = self._selectedPos - 1
	local curTreasureId = self._allTreasureIds[self._selectedPos]
	G_UserData:getTreasure():setCurTreasureId(curTreasureId)
	self:updateArrowBtn()
	self:_updateView()
	self:updateTabIcons()
end

function TreasureTrainView:_onButtonRightClicked()
	if self._selectedPos >= self._treasureCount then
		return
	end

	self._selectedPos = self._selectedPos + 1
	local curTreasureId = self._allTreasureIds[self._selectedPos]
	G_UserData:getTreasure():setCurTreasureId(curTreasureId)
	self:updateArrowBtn()
	self:_updateView()
	self:updateTabIcons()
end

function TreasureTrainView:getAllTreasureIds()
	return self._allTreasureIds
end

function TreasureTrainView:getTreasureCount()
	return self._treasureCount
end

function TreasureTrainView:setSelectedPos(pos)
	self._selectedPos = pos
end

function TreasureTrainView:getSelectedPos()
	return self._selectedPos
end

function TreasureTrainView:setArrowBtnEnable(enable)
	self._buttonLeft:setEnabled(enable)
	self._buttonRight:setEnabled(enable)
end

function TreasureTrainView:_onRefineSuccess()
	--全范围的情况，精炼如果消耗同名卡，要重新更新列表
	if self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_1 then 
		self:_updateTreasureIds()
		self:_calCurSelectedPos()
		self:updateArrowBtn()
		local layer = self._subLayers[self._selectTabIndex]
		if layer then
			layer:updatePageView()
		end
	end
end

function TreasureTrainView:getRangeType()
	return self._rangeType
end

function TreasureTrainView:_doLayoutTabIcons()
	local dynamicTabs = {} --需要动态排版的
	local showCount = 2
	for i = 1, 3 do
		local txt = Lang.get("treasure_train_tab_icon_"..i)
		local isOpen = LogicCheckHelper.funcIsShow(FunctionConst["FUNC_TREASURE_TRAIN_TYPE"..i])
		local curTreasureId = G_UserData:getTreasure():getCurTreasureId()
		local curUnitData = G_UserData:getTreasure():getTreasureDataWithId(curTreasureId)
		if i == 3 then
			local canLimit = curUnitData:isCanLimitBreak()
			isOpen = isOpen and canLimit
			self._nodeTabIcon3:setVisible(isOpen)
			self._imageRope3:setVisible(isOpen)

			if Lang.checkChannel(Lang.CHANNEL_SEA) then
				self._imageRope3:setVisible(false)
			end


			if isOpen then
				showCount = showCount + 1
				local funcLevelInfo = require("app.config.function_level").get(FunctionConst.FUNC_TREASURE_TRAIN_TYPE3)
		    	assert(funcLevelInfo, "Invalid function_level can not find funcId "..FunctionConst.FUNC_TREASURE_TRAIN_TYPE3)
				table.insert(dynamicTabs, {tab = self._nodeTabIcon3, openLevel = funcLevelInfo.level})
			end
		end

		self["_nodeTabIcon"..i]:updateUI(txt, isOpen, i)
	end

	if showCount == 2 then
		self._imageRopeTail:setPositionY(292)
	elseif showCount == 3 then
		self._imageRopeTail:setPositionY(140)
	end
end


-- i18n pos lable
function TreasureTrainView:_dealPosByI18n()
	if Lang.checkHorizontal() then
		local UIHelper  = require("yoka.utils.UIHelper")
		local panelLeft = UIHelper.seekNodeByName(self,"PanelLeft")
		local size = panelLeft:getContentSize()
		panelLeft:setContentSize(cc.size(146,size.height))

		self._imageRope1:setVisible(false)
		self._imageRope2:setVisible(false)
		self._imageRope3:setVisible(false)

		self._imageRopeTail:setVisible(false)

		self._nodeTabIcon1:setPositionY(500)
		self._nodeTabIcon2:setPositionY(self._nodeTabIcon1:getPositionY()-100)
		self._nodeTabIcon3:setPositionY(self._nodeTabIcon2:getPositionY()-100)
	
		self._nodeTabIcon1:setPositionX(self._nodeTabIcon1:getPositionX()+20)
		self._nodeTabIcon2:setPositionX(self._nodeTabIcon2:getPositionX()+20)
		self._nodeTabIcon3:setPositionX(self._nodeTabIcon3:getPositionX()+20)
	

		
	end
end



return TreasureTrainView