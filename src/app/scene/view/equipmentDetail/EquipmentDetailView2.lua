-- i18n ja 
-- Author: Liangxu
-- Date: 2017-04-12 16:46:24
-- 装备详情
local ViewBase = require("app.ui.ViewBase")
local EquipmentDetailView = class("EquipmentDetailView", ViewBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local EquipConst = require("app.const.EquipConst")
local EquipDetailBaseView = require("app.scene.view.equipmentDetail.EquipDetailBaseView")
local RedPointHelper = require("app.data.RedPointHelper")
local CSHelper = require("yoka.utils.CSHelper")
local TeamHeroBustIcon = require("app.scene.view.team.TeamHeroBustIcon")
local TeamViewHelper = require("app.scene.view.team.TeamViewHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local EquipTrainHelper = require("app.scene.view.equipTrain.EquipTrainHelper")

-- 一键强化
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local EquipMasterHelper = require("app.scene.view.equipTrain.EquipMasterHelper")
local MasterConst = require("app.const.MasterConst")
local UIHelper = require("yoka.utils.UIHelper")
local UIConst = require("app.const.UIConst")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local AudioConst = require("app.const.AudioConst")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")


EquipmentDetailView.EQUIP_COUNT = 4

function EquipmentDetailView:ctor(equipId, rangeType, tabSelectId)
	G_UserData:getEquipment():setCurEquipId(equipId)
	self._rangeType = rangeType or EquipConst.EQUIP_RANGE_TYPE_1
	self._allEquipIds = {}

	self._topbarBase 		= nil --顶部条
	self._buttonReplace		= nil --更换按钮
	self._buttonUnload		= nil --卸下按钮
	self._btnReplaceShowRP  = false --更换按钮是否显示红点
	self._tabSelectId = tabSelectId	-- tabSelectId如果传值 代表从特殊入口进入，显示对应页签

	local resource = {
		file = Path.getCSB("EquipmentDetailView2", "equipment"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonReplace = {
				events = {{event = "touch", method = "_onButtonReplaceClicked"}}
			},
			_buttonUnload = {
				events = {{event = "touch", method = "_onButtonUnloadClicked"}}
			},
			_buttonOneKey = {
				events = {{event = "touch", method = "_onButtonOneKeyClicked"}}
			},
		}
	}
	EquipmentDetailView.super.ctor(self, resource)
end

function EquipmentDetailView:onCreate()
	self:_swapImageByI18n()

	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)
	self._topbarBase:setImageTitle("txt_sys_com_zhuangbei")
 
	self._buttonReplace:setFontSize(20)
	self._buttonUnload:setFontSize(20)
	self._buttonUnload:setFontName(Path.getFontW8())
	self._buttonReplace:setFontName(Path.getFontW8())
	self._buttonReplace:setString(Lang.get("equipment_detail_btn_replace"))
	self._buttonUnload:setString(Lang.get("equipment_detail_btn_unload"))
end

function EquipmentDetailView:onEnter()
	self._signalRedPointUpdate = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._onEventRedPointUpdate))
	self._signalEquipClearSuccess = G_SignalManager:add(SignalConst.EVENT_EQUIP_CLEAR_SUCCESS, handler(self, self._equipClearSuccess))
	self._signalEquipAddSuccess = G_SignalManager:add(SignalConst.EVENT_EQUIP_ADD_SUCCESS, handler(self, self._equipAddSuccess)) 
	self._signalEquipSuperUpgrade = G_SignalManager:add(SignalConst.EVENT_EQUIP_SUPER_UPGRADE_SUCCESS, handler(self, self._onEventEquipSuperUpgrade))
		
	
	--特殊处理:	背包入口中选中装备若已被武将装备，则打开上面装备信息界面；若没有被任何武将装备，则去掉滑动切换按钮
	local equipId = G_UserData:getEquipment():getCurEquipId()
	if self._rangeType == EquipConst.EQUIP_RANGE_TYPE_1 then
		local unit = G_UserData:getEquipment():getEquipmentDataWithId(equipId)
		local pos = unit:getPos()
		if pos then
			self._rangeType = EquipConst.EQUIP_RANGE_TYPE_2
		end
	end 

	if self._rangeType == EquipConst.EQUIP_RANGE_TYPE_1 then
		self._allEquipIds = G_UserData:getEquipment():getListDataBySort()
	elseif self._rangeType == EquipConst.EQUIP_RANGE_TYPE_2 then
		local unit = G_UserData:getEquipment():getEquipmentDataWithId(equipId)
		local pos = unit:getPos()
		if pos then
			self.curPos = pos --当前阵位
			self._allEquipIds = G_UserData:getBattleResource():getEquipInfoWithPos(pos) -- getEquipIdsWithPos
			self:getAllEquipIds()
		end
	end
	
	self._selectedPos = 1
	
	for i, id in ipairs(self._allEquipIds) do
		if id == equipId then
			self._selectedPos = i
		end
	end
	self._equipCount = #self._allEquipIds
	self:_updatePageView()
	self:_initLeftIcons()
	self:_initEquipment()
	self:updateInfo()

	--抛出新手事件出新手事件
	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
	
	-- 一键强化
	if self._rangeType == EquipConst.EQUIP_RANGE_TYPE_2 then
		self._diffEquipStrMasterLevel = 0 --记录装备强化大师等级差
		self._lastEquipStrMasterLevel = {} --记录装备强化大师等级:{pos, level}
		-- 穿戴飘字
		self._diffEquipStrMasterLevel = 0 --记录装备强化大师等级差
		self._lastEquipStrMasterInfo = nil --记录装备强化大师信息
		self._lastEquipRefineMasterLevel = {} --记录装备精炼大师等级,{pos, level}
		self._diffEquipRefineMasterLevel = 0 --记录装备精炼大师等级差
		self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst["FUNC_TEAM_SLOT" .. self.curPos])
		self:_updateEffectData()  -- 记录初始属性
	end
end 

function EquipmentDetailView:onExit()
	self._signalEquipClearSuccess:remove()
	self._signalEquipClearSuccess = nil  
	self._signalEquipAddSuccess:remove()
	self._signalEquipAddSuccess = nil
	self._signalRedPointUpdate:remove()
	self._signalRedPointUpdate = nil
	self._signalEquipSuperUpgrade:remove()
	self._signalEquipSuperUpgrade = nil
end

function EquipmentDetailView:_createPageItem(width, height, i)
	local equipId = self._allEquipIds[i]
	local unitData = G_UserData:getEquipment():getEquipmentDataWithId(equipId)
	local equipBaseId = unitData:getBase_id()

	local widget = ccui.Widget:create()
	widget:setContentSize(width, height)
	local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonEquipAvatar", "common"))
	avatar:showShadow(false)
	avatar:updateUI(equipBaseId)
	local size = widget:getContentSize()
	avatar:setPosition(cc.p(size.width*0.56, size.height*0.58))
	widget:addChild(avatar)

	return widget
end

-- 创建中间装备
function EquipmentDetailView:_updatePageView()
	
	local viewSize = self._pageView:getContentSize()
	local item = self:_createPageItem(viewSize.width, viewSize.height, self._selectedPos)

	self._avatar:removeAllChildren()
	self._avatar:addChild(item)   
end

-- 头像列表
function EquipmentDetailView:_initLeftIcons()
	if self._rangeType == EquipConst.EQUIP_RANGE_TYPE_1 then  
		return
	end

	local function createIcon(icon, isHeroBust)
		local iconBg = ccui.Widget:create()
		local iconBgSize = cc.size(114, 108)
		if isHeroBust then
			iconBgSize = cc.size(100, 127)
		end

		-- i18n ja change size
		if Lang.checkUI("ui4") then   
			iconBgSize = cc.size(80, 88)
			local items = self._listViewLineup:getChildrenCount()
			if items == 6 then
				iconBgSize = cc.size(80, 100)
				icon:setScale(0.95)
			end
		end 
		iconBg:setContentSize(iconBgSize)
		icon:setPosition(cc.p(iconBgSize.width / 2, iconBgSize.height / 2))
		iconBg:addChild(icon)
		return iconBg
	end

	--左侧头像滑动条
	self._listViewLineup:setScrollBarEnabled(false)
	self._listViewLineup:setContentSize(cc.size(102, 450))

	self._heroIcons = {}
	self._leftIcons = {}
	local iconData = TeamViewHelper.getHeroIconData()
	for i, data in ipairs(iconData) do
		if data.id ~= 0 then
			local heroId = data.id
			local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
			local _allEquipIds = G_UserData:getBattleResource():getEquipIdsWithPos( unitData:getPos() )
			if #_allEquipIds > 0 then
				local icon = TeamHeroBustIcon.new(i, handler(self, self._onLeftIconClicked))
				local iconBg = createIcon(icon)
				self._listViewLineup:pushBackCustomItem(iconBg)
				table.insert(self._heroIcons, {i, icon})   
				self._leftIcons[unitData:getPos()] = icon --table.insert(self._leftIcons, { unitData:getPos() = icon})   
				
				icon:updateIcon(data.type, data.value, data.funcId, data.limitLevel, data.limitRedLevel)
				self:refreshLeftIconRedPoint(unitData:getPos())
			end
		end
	end
	self._listViewLineup:doLayout()
end

--点击左侧Icon
function EquipmentDetailView:_onLeftIconClicked(pos)
	local iconData = TeamViewHelper.getHeroIconData()
	local info = iconData[pos] 

	local heroId = info.id
	local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
	self.curPos = unitData:getPos() --当前阵位
	self._allEquipIds = {}
	self._allEquipIds = G_UserData:getBattleResource():getEquipInfoWithPos(self.curPos)  
	self:getAllEquipIds()
 
	
	self:_changeCurSelectEquipPos() -- 刷新选中装备
	local equipId = self._allEquipIds[self._selectedPos]
	G_UserData:getEquipment():setCurEquipId(equipId)

	self:updateInfo()
	--记录更换武将的基础属性
	self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst["FUNC_TEAM_SLOT" .. self.curPos]) 
	self:_updateEffectData()
end 

-- 左侧Icon红点刷新
function EquipmentDetailView:refreshLeftIconRedPoint(pos)
	if self._rangeType == EquipConst.EQUIP_RANGE_TYPE_1 then  
		return
	end

	local getShowRedPoint = function ()
		for i = 1, EquipmentDetailView.EQUIP_COUNT do 
			local id =  G_UserData:getBattleResource():getResourceId(pos, 1, i)
			local unitData = G_UserData:getEquipment():getEquipmentDataWithId(id)
			if unitData then
				
				local type1 = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP_TRAIN_TYPE1, "slotRP", unitData)
				local type2 = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP_TRAIN_TYPE2, "slotRP", unitData)

				local isOpen3 = LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_EQUIP_TRAIN_TYPE3)
				local isRed3 = EquipTrainHelper.needJadeRedPoint(unitData:getId()) and isOpen
				
				local isOpen4 = LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_EQUIP_TRAIN_TYPE4)
				local isRed4 = EquipTrainHelper.isNeedRedPoint() and isOpen

				local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP, "slotRP", {pos = unitData:getPos(), slot = unitData:getSlot()}) -- 更换红点
 
				if type1 or type2 or isRed3 or isRed4 or reach then
					return true 
				end 
			end
		end 

		return false  --无可操作 不显示红点
	end

	self._leftIcons[pos]:showRedPoint( getShowRedPoint() ) 
end

function EquipmentDetailView:_updateHeroIconsSelectedState()
	if self._heroIcons == nil then
		return
	end
	
	local curPos = self.curPos
	for i, data in ipairs(self._heroIcons) do
		 if data[1] == curPos then
			data[2]:setSelected(true)
		else
			data[2]:setSelected(false)
		end
	end
end

-- 4个装备
function EquipmentDetailView:_initEquipment()
	if self._rangeType == EquipConst.EQUIP_RANGE_TYPE_1 then  
		return
	end

	self._equipments = {}
	local TeamEquipIcon = require("app.scene.view.team.TeamEquipIcon")
	for i = 1, EquipmentDetailView.EQUIP_COUNT do 
		local equip = TeamEquipIcon.new(self["_fileNodeEquip"..i])
		table.insert(self._equipments, equip)
		--self["_fileNodeEquip"..i]:getChildren()[1]:addClickEventListenerEx(handler(self, self._onBtnEquipmentClick))
		-- equip:setIsOnlyShow(true)
		-- equip:setOnlyShowCallback(handler(self, self._onBtnEquipmentClick))
		self:_initEquipIconSelect(self["_fileNodeEquip"..i])
	end
end  
  
--装备信息
function EquipmentDetailView:_updateEquipment()
	if self._rangeType == EquipConst.EQUIP_RANGE_TYPE_1 then  
		return
	end

	for i = 1, EquipmentDetailView.EQUIP_COUNT do
		local equipIcon = self._equipments[i]
		equipIcon:updateIcon(self.curPos, i)

		self:refreshEquipRedPoint(i) --红点 equipIcon:showRedPoint(bRedPoint) 
		equipIcon:showUpArrow(false) --箭头
		ccui.Helper:seekNodeByName(self["_fileNodeEquip"..i], "FileNodeName"):setVisible(false) 
		local FileNodeCommon = ccui.Helper:seekNodeByName(self["_fileNodeEquip"..i], "FileNodeCommon")  -- 隐藏特效
		ccui.Helper:seekNodeByName(FileNodeCommon, "NodeEffectDown"):setVisible(false)  
		ccui.Helper:seekNodeByName(FileNodeCommon, "NodeEffectUp"):setVisible(false)   
		ccui.Helper:seekNodeByName(self["_fileNodeEquip"..i], "equipIconSelect"):setVisible(self._selectedPos == i) -- 刷新选中框
	end
end

-- 红点处理
function EquipmentDetailView:refreshEquipRedPoint(slot) 
	local id =  G_UserData:getBattleResource():getResourceId(self.curPos, 1, slot)
	local unitData = G_UserData:getEquipment():getEquipmentDataWithId(id)
	if not unitData then
        return 
    end

	local type1 = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP_TRAIN_TYPE1, "slotRP", unitData)
	local type2 = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP_TRAIN_TYPE2, "slotRP", unitData)

	local isOpen3 = LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_EQUIP_TRAIN_TYPE3)
	local isRed3 = EquipTrainHelper.needJadeRedPoint(unitData:getId()) and isOpen
	
	local isOpen4 = LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_EQUIP_TRAIN_TYPE4)
	local isRed4 = EquipTrainHelper.isNeedRedPoint() and isOpen

	local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP, "slotRP", {pos = unitData:getPos(), slot = unitData:getSlot()}) -- 更换红点
	--return (type1 or type2 or isRed3 or isRed4)  
	self._equipments[slot]:showRedPoint(type1 or type2 or isRed3 or isRed4 or reach)   
end

-- 初始化装备icon选中框
function EquipmentDetailView:_initEquipIconSelect(equip) 
	local FileNodeName = ccui.Helper:seekNodeByName(equip, "FileNodeName")
	if FileNodeName:getParent():getChildByName("equipIconSelect") then
		FileNodeName:getParent():removeChildByName("equipIconSelect")
	end

	local image = ccui.ImageView:create()
	local path = Path.getUICommonFrame("img_zhuangbei01") 
	image:loadTexture(path)   
	image:setPosition(cc.p(0.8, 1))
	image:setLocalZOrder(-1)
	image:ignoreContentAdaptWithSize(false)
	image:setContentSize(cc.size(135, 135))
	FileNodeName:getParent():addChild(image)
	image:setName("equipIconSelect")
	image:setVisible(false)
end

--点击装备回调 
function EquipmentDetailView:_onBtnEquipmentClick(slot)  

	self._selectedPos = slot   
	local equipId = G_UserData:getBattleResource():getResourceId(self.curPos, 1, slot) 
	G_UserData:getEquipment():setCurEquipId(equipId)
	self:updateInfo()
end

-- 对应卡槽中对应的装备
function EquipmentDetailView:getAllEquipIds() 
	for index = 1, EquipmentDetailView.EQUIP_COUNT do   
		if not self._allEquipIds[index] then
			self._allEquipIds[index] = 0	--table.insert(self._allEquipIds, index, 0)
		end
	end
end

function EquipmentDetailView:getSelectedPos()
    return self._selectedPos
end

-- 获取当前选中武将阵位
function EquipmentDetailView:getCurPos()
    return self.curPos  
end

function EquipmentDetailView:getAvatar()
	return self._avatar:getChildren()[1]:getChildren()[1] 
end
 
function EquipmentDetailView:_updateInfo2()
	self:_updateEquipment()
	self:_updatePageView()
	self:_updateHeroIconsSelectedState()
	
	EquipDetailBaseView = require("app.scene.view.equipmentDetail.EquipDetailBaseView2")
	if self._nodeHeroDetailView:getChildrenCount() > 0 then
		self._selectTabIndex = self._nodeHeroDetailView:getChildren()[1]:getTabSelect()
	end
	if self._tabSelectId then
		self._selectTabIndex = self._tabSelectId
		self._tabSelectId = nil -- 仅使用一次就重置
	end


	self._nodeHeroDetailView:removeAllChildren()
	local equipDetail = EquipDetailBaseView.new(self._equipData, self._rangeType, self) 
	self._nodeHeroDetailView:addChild(equipDetail)

	 
	-- 隐藏头像列表
	if self._rangeType == EquipConst.EQUIP_RANGE_TYPE_1 then
		self._equip:setVisible(false)
		self._listViewLineup:setVisible(false)
	end
end

function EquipmentDetailView:updateInfo()

	local equipId = G_UserData:getEquipment():getCurEquipId()
	self._equipData = G_UserData:getEquipment():getEquipmentDataWithId(equipId)
	self._buttonReplace:setVisible(self._equipData:isInBattle())
	self._buttonUnload:setVisible(self._equipData:isInBattle())
	self:_checkRedPoint()

	if Lang.checkUI("ui4") then   -- i18n ja update UI
		self:_updateInfo2()
		return
	end


	self._nodeHeroDetailView:removeAllChildren()
	local equipDetail = EquipDetailBaseView.new(self._equipData, self._rangeType, self) 
	self._nodeHeroDetailView:addChild(equipDetail)
end
 
function EquipmentDetailView:_onButtonReplaceClicked()
	local curPos = self.curPos 
	local curEquipId = G_UserData:getEquipment():getCurEquipId()
	local curEquipUnitData = G_UserData:getEquipment():getEquipmentDataWithId(curEquipId)
	local curEquipSlot = curEquipUnitData:getSlot()
	local result, noWear, wear = G_UserData:getEquipment():getReplaceEquipmentListWithSlot(curPos, curEquipSlot)
	if #result == 0 then
		G_Prompt:showTip(Lang.get("equipment_empty_tip"))
	else
		local PopupChooseEquipHelper = require("app.ui.PopupChooseEquipHelper")
		local popup = require("app.ui.PopupChooseEquip2").new()
		local callBack = handler(self, self._onChooseEquip)
		popup:setTitle(Lang.get("equipment_replace_title"))
		popup:updateUI(
			PopupChooseEquipHelper.FROM_TYPE2,
			callBack,
			result,
			self._buttonReplace, --_btnEquipShowRP,
			curEquipUnitData,
			noWear,
			curPos
		)
		popup:openWithAction()
	end
end

function EquipmentDetailView:_onChooseEquip(equipId)
	local curPos = self.curPos 
	local curEquipId = G_UserData:getEquipment():getCurEquipId()
	local curEquipUnitData = G_UserData:getEquipment():getEquipmentDataWithId(curEquipId)
	local curEquipSlot = curEquipUnitData:getSlot()
	G_UserData:getEquipment():c2sAddFightEquipment(curPos, curEquipSlot, equipId)
end

function EquipmentDetailView:_equipAddSuccess(eventName, oldId, pos, slot)

	local scene = G_SceneManager:getTopScene()
	if scene:getName() == "team" then   
		return
	end

	self._allEquipIds = {}
	dump(self._allEquipIds, "self._allEquipIds 1  =>")
	self._allEquipIds = G_UserData:getBattleResource():getEquipInfoWithPos(pos)  
	dump(self._allEquipIds, "self._allEquipIds 2  =>")
	self:getAllEquipIds()
	dump(self._allEquipIds, "self._allEquipIds 3  =>")

	self._selectedPos = slot   
	local equipId = G_UserData:getBattleResource():getResourceId(pos, 1, slot) 
	if G_UserData:getEquipment():getCurEquipId() == equipId then
		return
	end
	G_UserData:getEquipment():setCurEquipId(equipId)
	
	self:updateInfo() 
	self:_playEquipAddSummary(oldId, pos, slot)	-- 装备穿戴飘字
end

function EquipmentDetailView:_onEventRedPointUpdate(eventName, funcId)
	self:_checkRedPoint()
end

function EquipmentDetailView:_onButtonUnloadClicked()
	local pos = self._equipData:getPos()
	local slot = self._equipData:getSlot()
	G_UserData:getEquipment():c2sClearFightEquipment(pos, slot)
end

function EquipmentDetailView:_equipClearSuccess(eventName, slot)
	local len = 0
	self._allEquipIds = {}
	self._allEquipIds = G_UserData:getBattleResource():getEquipInfoWithPos(self.curPos)  
    for k, v in pairs(self._allEquipIds) do
		len = len + 1
		break
	end
	if len == 0 then    -- 无可展示装备
		G_SceneManager:popScene()
		local scene = G_SceneManager:getTopScene()
		if scene:getName() == "team" then
			local view = scene:getSceneView()
			view:setNeedEquipClearPrompt(true)
		end
		return
	end
	
	self:getAllEquipIds()
	self:_changeCurSelectEquipPos()

	local equipId = self._allEquipIds[self._selectedPos]
	G_UserData:getEquipment():setCurEquipId(equipId)
	
	self:updateInfo()
	self:_playRemoveEquipSummary()
end

function EquipmentDetailView:_changeCurSelectEquipPos()
	if self._allEquipIds[self._selectedPos] == 0 then   
		
		for index = self._selectedPos, self._selectedPos + #self._allEquipIds - 1 do   --注：若武将对应部位没有装备，则按照从左至右的顺序优先选中并展示其对应部位装备
			local tpos = index%#self._allEquipIds + 1
			if self._allEquipIds[tpos] and self._allEquipIds[tpos] ~= 0 then
				self._selectedPos = tpos
				break
			end
		end
	end 
end

function EquipmentDetailView:_checkRedPoint()
	local pos = self._equipData:getPos()
	local slot = self._equipData:getSlot()
	local param = {pos = pos, slot = slot}
	local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP, "slotRP", param)
	self._buttonReplace:showRedPoint(reach)
	self._btnReplaceShowRP = reach
end

function EquipmentDetailView:getDetailViewNode()
	return self._nodeHeroDetailView
end

function EquipmentDetailView:setButtonVisible(bShow) 
	return self._buttonBg:setVisible(bShow)
end 

function EquipmentDetailView:getSelectTabIndex(bShow)  
	return self._selectTabIndex
end 

function EquipmentDetailView:changeBackground(resPath)
	if resPath == nil then  
		self._imgBg:setVisible(false) 	
	else
		self._imgBg:loadTexture(resPath) -- 要先load在设置setCapInsets 在设置size 顺序 
		self._imgBg:setScale9Enabled(true)
		self._imgBg:setCapInsets(cc.rect(1200, 270,1,1))
		self._imgBg:setContentSize(cc.size(1600, self._imgBg:getContentSize().height))  
		self._imgBg:setAnchorPoint(0.5,0.5)
		self._imgBg:setPositionX(self._imgBg:getParent():getContentSize().width*0.44)
		self._imgBg:setVisible(true) 
		self._imgBg:setVisible(true) 
	end	
end 

-- bug: 界限突破时, 特效要在UI最上层 (但是玉石界面又会遮挡UI 所以动态调整)
function EquipmentDetailView:changeDetailViewZorder(zOrder)
	if zOrder == nil then
		self._nodeHeroDetailView:setLocalZOrder(1)   
		self._panelDesign:setLocalZOrder(self._nodeHeroDetailView:getLocalZOrder() + 1)
		self._topbarBase:setLocalZOrder(self._panelDesign:getLocalZOrder() + 1)
	else
		self._panelDesign:setLocalZOrder(1)    
		self._nodeHeroDetailView:setLocalZOrder(self._panelDesign:getLocalZOrder() + 1)
		self._topbarBase:setLocalZOrder(self._nodeHeroDetailView:getLocalZOrder() + 1)
	end
end    

-- 策划需求：仅有强化页签显示一键养成
function EquipmentDetailView:refreshOnKeyButton(nTabIndex)  
	self._buttonOneKey:setVisible(nTabIndex == 2)
	
	local posX = {[1] = {-101, -4, 93, 190}, [2] = {-152, -55, 42, 140}}
	if nTabIndex ~= 2 then
		nTabIndex = 1
	end
	for i = 1, EquipmentDetailView.EQUIP_COUNT do 
		self["_fileNodeEquip"..i]:setPositionX(posX[nTabIndex][i])
	end
end 

--------------------------------------------------------------一键强化    begin
---点击一键强化 
function EquipmentDetailView:_onButtonOneKeyClicked()
	local curPos = self.curPos
	local value, indexs = UserDataHelper.getOneKeyStrengCost(curPos)
	self._oneKeyEquipIndexs = indexs

	if value == -1 then
		G_Prompt:showTip(Lang.get("equipment_strengthen_fetch_equip_hint"))
		return
	end
	if value == -2 then
		G_Prompt:showTip(Lang.get("equipment_strengthen_all_reach_limit"))
		return
	end
	if value == 0 then
		G_Prompt:showTip(Lang.get("common_money_not_enough"))
		return
	end
	local content = Lang.get("equipment_strengthen_onekey_content", {value = TextHelper.getAmountText1(value)}) --
	local PopupSystemAlert = require("app.ui.PopupSystemAlert")
	local popupSystemAlert =
		PopupSystemAlert.new(Lang.get("equipment_strengthen_onekey_title"), content, handler(self, self._doOneKeyStreng))
	popupSystemAlert:setCheckBoxVisible(false)
	popupSystemAlert:openWithAction()
end

--do一键强化
function EquipmentDetailView:_doOneKeyStreng()
	local curPos = self.curPos
	G_UserData:getEquipment():c2sSuperUpgradeEquipment(curPos)
	self._buttonOneKey:setEnabled(false)
	self:_saveEquipStrMasterInfo()
end

--记录装备强化大师信息
function EquipmentDetailView:_saveEquipStrMasterInfo()
	local pos = self.curPos -- G_UserData:getTeam():getCurPos()
	self._lastEquipStrMasterInfo = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_1)
end

--装备一键强化成功
function EquipmentDetailView:_onEventEquipSuperUpgrade(eventName, crits, saveMoney)
	self:_updateEffectData()
	local curPos = self.curPos
	self:_playOneKeyEffect(crits, saveMoney, curPos)
end

--一键强化
function EquipmentDetailView:_playOneKeyEffect(crits, saveMoney, pos)
	local played = false --是否播过飘字
	local indexs = self._oneKeyEquipIndexs
	for slot, v in pairs(indexs) do
		if not played then
			self:_playOneKeyUnitEffect(slot, crits, saveMoney, pos)
			played = true
		else
			self:_playOneKeyUnitEffect(slot)
		end
	end
	G_AudioManager:playSoundWithId(AudioConst.SOUND_EQUIP_STRENGTHEN) --播音效
end

--一键强化单个特效
function EquipmentDetailView:_playOneKeyUnitEffect(index, crits, saveMoney, pos)
	local function effectFunction(effect)
		return cc.Node:create()
	end

	local function eventFunction(event)
		if event == "finish" then
			-- if self and self._refreshNodeView then  坑爹啊  事件没了 ...
			-- 	self:_refreshNodeView()
			-- end
		elseif event == "play" then
			if self == nil or self._buttonOneKey == nil then
				return
			end

			local icon = self["_fileNodeEquip" .. index]:getSubNodeByName("FileNodeCommon")
			G_EffectGfxMgr:applySingleGfx(icon, "smoving_zhuangbei", nil, nil, nil)
			if crits and saveMoney and pos then
				local curPos =  self.curPos	-- G_UserData:getTeam():getCurPos()
				if curPos >= 1 and curPos <= 6 then
					self:_updateEquipment()
					--self:_updatePower()
					self:_playEquipSuperUpgradeSummary(crits, saveMoney, pos)
				end
				self._buttonOneKey:setEnabled(true)
				self:_refreshNodeView()
			end
		end
	end

	local effect = G_EffectGfxMgr:createPlayMovingGfx(self, "moving_yijianqianghua", effectFunction, eventFunction, false)
	effect:setPosition(UIHelper.convertSpaceFromNodeToNode(self["_fileNodeEquip" .. index], self))
end

function EquipmentDetailView:_updateEffectData()
	local curPos = self.curPos
	local curHeroId = G_UserData:getTeam():getHeroIdWithPos(curPos)
	G_UserData:getHero():setCurHeroId(curHeroId)
	self._curHeroData = G_UserData:getHero():getUnitDataWithId(curHeroId)
	-- self:_checkInstrumentIsShow()
	self._allYokeData = UserDataHelper.getHeroYokeInfo(self._curHeroData)
	self:_recordBaseAttr()
 	G_UserData:getAttr():recordPowerWithKey(FunctionConst.FUNC_TEAM)
	self:_recordMasterLevel()
end

function EquipmentDetailView:_refreshNodeView()
	-- 刷新右侧按钮红点
	-- 刷新4个装备红点
	-- 刷新pageview
	-- 刷新属性
	if self._nodeHeroDetailView:getChildrenCount() > 0 then
		self._nodeHeroDetailView:getChildren()[1]:onRefreshInfo()
		self._nodeHeroDetailView:getChildren()[1]:oneKeyUpdateListView()
		self._nodeHeroDetailView:getChildren()[1]:checkRedPoint()
	end
end

--记录基础属性
function EquipmentDetailView:_recordBaseAttr()
	local curPos = self.curPos	--G_UserData:getTeam():getCurPos()
	local curHeroId = G_UserData:getTeam():getHeroIdWithPos(curPos)
	self._curHeroData = G_UserData:getHero():getUnitDataWithId(curHeroId)

	local param = {
		heroUnitData = self._curHeroData
	}
	local attrInfo = UserDataHelper.getTotalAttr(param)
	--local curPos = G_UserData:getTeam():getCurPos()
	self._recordAttr:updateData(attrInfo)
end

--记录强化大师等级
function EquipmentDetailView:_recordMasterLevel()
	local pos = self.curPos	 --G_UserData:getTeam():getCurPos()

	local info1 = self._lastEquipStrMasterLevel
	local lastLevel1 = info1[2] or 0
	local curMasterInfo1 = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_1)
	local curLevel1 = curMasterInfo1.masterInfo.curMasterLevel
	self._diffEquipStrMasterLevel = curLevel1 - lastLevel1
	self._lastEquipStrMasterLevel = {pos, curLevel1}

	local info2 = self._lastEquipRefineMasterLevel
	local lastLevel2 = info2[2] or 0
	local curMasterInfo2 = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_2)
	local curLevel2 = curMasterInfo2.masterInfo.curMasterLevel
	self._diffEquipRefineMasterLevel = curLevel2 - lastLevel2
	self._lastEquipRefineMasterLevel = {pos, curLevel2}

	-- local info3 = self._lastTreasureStrMasterLevel
	-- local lastLevel3 = info3[2] or 0
	-- local curMasterInfo3 = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_3)
	-- local curLevel3 = curMasterInfo3.masterInfo.curMasterLevel
	-- self._diffTreasureStrMasterLevel = curLevel3 - lastLevel3
	-- self._lastTreasureStrMasterLevel = {pos, curLevel3}

	-- local info4 = self._lastTreasureRefineMasterLevel
	-- local lastLevel4 = info4[2] or 0
	-- local curMasterInfo4 = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_4)
	-- local curLevel4 = curMasterInfo4.masterInfo.curMasterLevel
	-- self._diffTreasureRefineMasterLevel = curLevel4 - lastLevel4
	-- self._lastTreasureRefineMasterLevel = {pos, curLevel4}
end

--装备一键强化飘字
function EquipmentDetailView:_playEquipSuperUpgradeSummary(crits, saveMoney, pos)
	local summary = {}

	--成功
	local param1 = {
		content = Lang.get("summary_equip_str_success_tip6"),
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
		-- anchorPoint = cc.p(0.5, 0.5),
		finishCallback = function()
			if self._diffEquipStrMasterLevel > 0 then --强化大师
				local curPos = G_UserData:getTeam():getCurPos()
				local curMasterInfo = EquipMasterHelper.getCurMasterInfo(curPos, MasterConst.MASTER_TYPE_1)
				local popup =
					require("app.scene.view.equipment.PopupMasterLevelup").new(
					self,
					self._lastEquipStrMasterInfo,
					curMasterInfo,
					MasterConst.MASTER_TYPE_1
				)
				popup:openWithAction()
			end
		end
	}
	table.insert(summary, param1)

	--暴击
	local critsInfo = {}
	for i, value in ipairs(crits) do
		if value > 1 then
			if critsInfo[value] == nil then
				critsInfo[value] = 0
			end
			critsInfo[value] = critsInfo[value] + 1
		end
	end
	local key2Text = {
		[1] = "一",
		[2] = "两",
		[3] = "三",
		[4] = "四",
		[5] = "五",
		[6] = "六"
	}
	if not Lang.checkLang(Lang.CN)  then
		key2Text = {
			[1] = "1",
			[2] = "2",
			[3] = "3",
			[4] = "4",
			[5] = "5",
			[6] = "6",
		}
	end

	for k, v in pairs(critsInfo) do
		local param2 = {
			content = Lang.get("summary_equip_str_success_tip2", {multiple = key2Text[k], count = v}),
			startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
			--anchorPoint = cc.p(0.5, 0.5),
		}
		table.insert(summary, param2)
	end

	--节省
	if saveMoney > 0 then
		local param3 = {
			content = Lang.get("summary_equip_str_success_tip5", {value = saveMoney}),
			startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
			--anchorPoint = cc.p(0.5, 0.5),
		}
		table.insert(summary, param3)
	end

	self:_addBaseAttrPromptSummary(summary, pos)

	G_Prompt:showSummary(summary)
	--总战力
	G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_TEAM, UIConst.SUMMARY_OFFSET_X_TEAM, -5)
end
 
function EquipmentDetailView:_addBaseAttrPromptSummary(summary)
	local attrIds = self._recordAttr:getAllAttrIdsBySort()
	for i, attrId in ipairs(attrIds) do
		local diffValue = self._recordAttr:getDiffValue(attrId)
		if diffValue ~= 0 then
			local param = {
				content = AttrDataHelper.getPromptContent(attrId, diffValue),
				--anchorPoint = cc.p(0.5, 0.5),
				startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
			}
			table.insert(summary, param)
		end
	end
	return summary
end

-- i18n change lable
function EquipmentDetailView:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")

		local image5 = UIHelper.seekNodeByName(self._buttonOneKey,"Image_4")
		local label5 = UIHelper.swapWithLabel(image5,{ 
			style = "limit_1_ja",   			 
			text = Lang.getImgText("img_btn_yijianqianghuatxt01") ,
			fontSize = Colors.getStyle("limit_1_ja").size - 5,   
		})
		label5:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
        label5:getVirtualRenderer():setLineSpacing(-7)
	end
end
---------------------------------------------------------------end


-------------------------------------------------  装备穿戴飘字 begin
--播放装备穿戴飘字
function EquipmentDetailView:_playEquipAddSummary(oldId, pos, slot)
	self:_updateEffectData()
	local summary = {}

	local param1 = {
		content = oldId > 0 and Lang.get("summary_equip_change_success") or Lang.get("summary_equip_add_success"),
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
		--anchorPoint = cc.p(0.5, 0.5),
		-- finishCallback = function()
		-- 	--穿戴装备飘字结束事件
		-- 	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, "TeamView:_playEquipAddSummary")  新手引导
		-- end
	}
	table.insert(summary, param1)

	--羁绊
	local function isInYokeCondition(ids, id) --是否在羁绊条件内
		for i, v in ipairs(ids) do
			if v == id then
				return true
			end
		end
		return false
	end

	local equipId = G_UserData:getBattleResource():getResourceId(pos, 1, slot)
	local equipData = G_UserData:getEquipment():getEquipmentDataWithId(equipId)
	local equipBaseId = equipData:getBase_id()
	local allYokeData = self._allYokeData
	if allYokeData and allYokeData.yokeInfo then
		for i = 1, 6 do
			local info = allYokeData.yokeInfo[i]
			if info and info.isActivated and info.fateType == 2 and isInYokeCondition(info.heroIds, equipBaseId) then --羁绊类型是装备羁绊
				local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, self._curHeroData:getBase_id())
				local heroName = heroParam.name
				local param = {
					content = Lang.get(
						"summary_yoke_active",
						{
							heroName = heroName,
							colorHero = Colors.colorToNumber(heroParam.icon_color),
							outlineHero = Colors.colorToNumber(heroParam.icon_color_outline),
							yokeName = info.name
						}
					),
					startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
					--anchorPoint = cc.p(0.5, 0.5),
					-- dstPosition = UIHelper.convertSpaceFromNodeToNode(self["_textJiBanDes" .. i], self),
					-- finishCallback = function()
					-- 	self:_updateOneYoke(i)
					-- end
				}
				table.insert(summary, param)
			else
			--	self:_updateOneYoke(i)
			end
		end
	end

	--装备强化大师
	self:_addEquipStrMasterPromptSummary(summary, pos)
	--装备精炼大师
	self:_addEquipRefineMasterPromptSummary(summary, pos)
	--装备套装
	self:_addEquipSuitPromptSummary(summary, pos, slot)

	self:_addBaseAttrPromptSummary(summary)

	G_Prompt:showSummary(summary)
	--总战力
	G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_TEAM, UIConst.SUMMARY_OFFSET_X_TRAIN, -5)
end

--装备强化大师飘字
function EquipmentDetailView:_addEquipStrMasterPromptSummary(summary, pos)
	local curMasterInfo = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_1)
	local curLevel = curMasterInfo.masterInfo.curMasterLevel
	local info = self._lastEquipStrMasterLevel
	if info[1] and info[1] == pos and self._diffEquipStrMasterLevel > 0 then
		local param = {
			content = Lang.get("summary_equip_str_master_reach", {level = info[2]}),
			startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
			--anchorPoint = cc.p(0.5, 0.5),
		--	dstPosition = UIHelper.convertSpaceFromNodeToNode(self._buttonMaster, self),
			-- finishCallback = function()
			-- 	UIActionHelper.playScaleUpEffect(self._buttonMaster)
			-- end
		}
		table.insert(summary, param)
	end
end

--装备精炼大师飘字
function EquipmentDetailView:_addEquipRefineMasterPromptSummary(summary, pos)
	local curMasterInfo = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_2)
	local curLevel = curMasterInfo.masterInfo.curMasterLevel
	local info = self._lastEquipRefineMasterLevel
	if info[1] and info[1] == pos and self._diffEquipRefineMasterLevel > 0 then
		local param = {
			content = Lang.get("summary_equip_refine_master_reach", {level = info[2]}),
			startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
			--anchorPoint = cc.p(0.5, 0.5),
			-- dstPosition = UIHelper.convertSpaceFromNodeToNode(self._buttonMaster, self),
			-- finishCallback = function()
			-- 	UIActionHelper.playScaleUpEffect(self._buttonMaster)
			-- end
		}
		table.insert(summary, param)
	end
end


function EquipmentDetailView:_addEquipSuitPromptSummary(summary, pos, slot)
	local equipId = G_UserData:getBattleResource():getResourceId(pos, 1, slot)
	local equipData = G_UserData:getEquipment():getEquipmentDataWithId(equipId)
	local suitId = equipData:getConfig().suit_id
	if suitId > 0 then --有套装信息
		local componentCount = 0
		local activeCount = 0
		local componentIds = UserDataHelper.getSuitComponentIds(suitId)
		for i, id in ipairs(componentIds) do
			local isHave = UserDataHelper.isHaveEquipInPos(id, pos)
			if isHave then
				componentCount = componentCount + 1
			end
		end
		local attrInfo = UserDataHelper.getSuitAttrShowInfo(suitId)
		for i, one in ipairs(attrInfo) do
			local count = one.count
			if componentCount >= count then
				activeCount = count
			end
		end
		if activeCount > 0 then
			local name = UserDataHelper.getSuitName(suitId)
			local param = {
				content = Lang.get("summary_equip_suit_active", {name = name, count = activeCount}),
				startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
				--anchorPoint = cc.p(0.5, 0.5),
			}
			table.insert(summary, param)
		end
	end
end

--播放装备卸下飘字
function EquipmentDetailView:_playRemoveEquipSummary() 
	self:_updateEffectData()

	local summary = {}
	self:_addBaseAttrPromptSummary(summary)
	G_Prompt:showSummary(summary)
	G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_TEAM, UIConst.SUMMARY_OFFSET_X_TEAM, -5)
end

  

return EquipmentDetailView