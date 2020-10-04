
--
-- Author: Liangxu
-- Date: 2017-05-09 10:03:45
-- 
local ViewBase = require("app.ui.ViewBase")
local TreasureDetailView = class("TreasureDetailView", ViewBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local TreasureDetailBaseView = require("app.scene.view.treasureDetail.TreasureDetailBaseView")
local CSHelper = require("yoka.utils.CSHelper")
local RedPointHelper = require("app.data.RedPointHelper")
local TreasureConst = require("app.const.TreasureConst")
local TeamHeroBustIcon = require("app.scene.view.team.TeamHeroBustIcon")
local TeamViewHelper = require("app.scene.view.team.TeamViewHelper")
--播放宝物穿戴飘字
local UIConst = require("app.const.UIConst")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local AttributeConst = require("app.const.AttributeConst")


TreasureDetailView.TREASURE_COUNT = 2   

function TreasureDetailView:ctor(treasureId, rangeType, tabSelectId)
	G_UserData:getTreasure():setCurTreasureId(treasureId)

	self._topbarBase 		= nil --顶部条
	self._buttonReplace		= nil --更换按钮
	self._buttonUnload		= nil --卸下按钮
	self._nodeTreasureDetailView = nil --宝物详情节点
	self._tabSelectId = tabSelectId	-- tabSelectId如果传值 代表从特殊入口进入，显示对应页签

	self._rangeType = rangeType or TreasureConst.TREASURE_RANGE_TYPE_1
	self._allTreasureIds = {}

	local resource = {
		file = Path.getCSB("TreasureDetailView2", "treasure"),
		size = G_ResolutionManager:getDesignSize(),
		binding = { 
			_buttonReplace = {
				events = {{event = "touch", method = "_onButtonReplaceClicked"}}
			},
			_buttonUnload = {
				events = {{event = "touch", method = "_onButtonUnloadClicked"}}
			},
		}
	}
	TreasureDetailView.super.ctor(self, resource)
end

function TreasureDetailView:onCreate()
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)
	self._topbarBase:setImageTitle("txt_sys_com_baowu")

	self._buttonReplace:setFontSize(20)
	self._buttonUnload:setFontSize(20)
	self._buttonUnload:setFontName(Path.getFontW8())
	self._buttonReplace:setFontName(Path.getFontW8())
	self._buttonReplace:setString(Lang.get("treasure_detail_btn_replace"))
	self._buttonUnload:setString(Lang.get("treasure_detail_btn_unload"))
	
	-- local effectName1 = "effect_tupo_jingdutiao"
	-- local effectName2 = "effect_wujiangbreak_jiantou"
	-- G_EffectGfxMgr:createPlayGfx(self._testJson1, effectName1)
	-- G_EffectGfxMgr:createPlayGfx(self._testJson2, effectName2)
end

function TreasureDetailView:onEnter()
	self._signalRedPointUpdate = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._onEventRedPointUpdate))
	self._signalTreasureAddSuccess = G_SignalManager:add(SignalConst.EVENT_TREASURE_ADD_SUCCESS, handler(self, self._treasureAddSuccess))
	self._signalTreasureRemoveSuccess = G_SignalManager:add(SignalConst.EVENT_TREASURE_REMOVE_SUCCESS, handler(self, self._treasureRemoveSuccess))
	

	--特殊处理:	背包入口中选中装备若已被武将装备，则打开上面装备信息界面；若没有被任何武将装备，则去掉滑动切换按钮
	local treasureId = G_UserData:getTreasure():getCurTreasureId()
	if self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_1 then
		local unit = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
		local pos = unit:getPos()
		if pos then
			self._rangeType = TreasureConst.TREASURE_RANGE_TYPE_2
		end
	end 
	
	if self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_1 then
		self._allTreasureIds = G_UserData:getTreasure():getRangeDataBySort()
	elseif self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_2 then
		local unit = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
		local pos = unit:getPos()
		if pos then
			self.curPos = pos --当前阵位
			self._allTreasureIds = G_UserData:getBattleResource():getTreasureInfoWithPos(pos) -- getTreasureIdsWithPos
			self:getAllTreasureIds()
		end
	end

	self._selectedPos = 0
	for i, id in ipairs(self._allTreasureIds) do
		if id == treasureId then
			self._selectedPos = i
		end
	end
	self._maxCount = #self._allTreasureIds
	self:_updatePageView() 
	self:_initLeftIcons()
	self:_initTreasuretment()
	self:updateInfo()

	--抛出新手事件出新手事件
	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
	
	self:_initEffectData()
end

function TreasureDetailView:onExit()
	self._signalTreasureRemoveSuccess:remove()
	self._signalTreasureRemoveSuccess = nil
	self._signalTreasureAddSuccess:remove()
	self._signalTreasureAddSuccess = nil
	self._signalRedPointUpdate:remove()
	self._signalRedPointUpdate = nil
end

function TreasureDetailView:_createPageItem(width, height, i)
	local treasureId = self._allTreasureIds[i]
	local unitData = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
	local baseId = unitData:getBase_id()

	local widget = ccui.Widget:create()
	widget:setContentSize(width, height)
	local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonTreasureAvatar", "common"))
	avatar:showShadow(false)
	avatar:updateUI(baseId)
	local size = widget:getContentSize()
	avatar:setPosition(cc.p(size.width*0.56, size.height*0.58))
	widget:addChild(avatar)

	return widget
end

-- 创建中间装备
function TreasureDetailView:_updatePageView()
	local viewSize = self._pageView:getContentSize()
	local item = self:_createPageItem(viewSize.width, viewSize.height, self._selectedPos)

	self._avatar:removeAllChildren()
	self._avatar:addChild(item)
end

-- 头像列表
function TreasureDetailView:_initLeftIcons()
	if self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_1 then  
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
			local _allTreasureIds = G_UserData:getBattleResource():getTreasureIdsWithPos( unitData:getPos() )
			if #_allTreasureIds > 0 then
				local icon = TeamHeroBustIcon.new(i, handler(self, self._onLeftIconClicked))
				local iconBg = createIcon(icon, true)
				self._listViewLineup:pushBackCustomItem(iconBg)
				table.insert(self._heroIcons, {i, icon})  
				self._leftIcons[unitData:getPos()] = icon
	
				icon:updateIcon(data.type, data.value, data.funcId, data.limitLevel, data.limitRedLevel)
				self:refreshLeftIconRedPoint(unitData:getPos())
			end
		end
		
	end
end

--点击左侧Icon
function TreasureDetailView:_onLeftIconClicked(pos)
	local iconData = TeamViewHelper.getHeroIconData()
	local info = iconData[pos] 

	local heroId = info.id
	local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
	self.curPos = unitData:getPos() --当前阵位
	self._allTreasureIds = {}
	self._allTreasureIds = G_UserData:getBattleResource():getTreasureInfoWithPos(self.curPos)  
	self:getAllTreasureIds()
 
	
	self:_changeCurSelectEquipPos() -- 刷新选中装备
	local treasureId = self._allTreasureIds[self._selectedPos]
	G_UserData:getTreasure():setCurTreasureId(treasureId)

	self:updateInfo()
	--记录更换武将的基础属性
	self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst["FUNC_TEAM_SLOT" .. self.curPos]) 
	self:_updateEffectData()
end 

-- 左侧Icon红点刷新
function TreasureDetailView:refreshLeftIconRedPoint(pos)
	if self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_1 then  
		return
	end

	local getShowRedPoint = function ()
		for i = 1, TreasureDetailView.TREASURE_COUNT do 
			local id =  G_UserData:getBattleResource():getResourceId(pos, 2, i)
			local unitData = G_UserData:getTreasure():getTreasureDataWithId(id)
			if unitData then
		 
				for index = 1, TreasureConst.TREASURE_TRAIN_LIMIT do
					if RedPointHelper.isModuleSubReach(FunctionConst["FUNC_TREASURE_TRAIN_TYPE"..index], "slotRP", unitData) then	
						return  true
					end 
				end
			
				if RedPointHelper.isModuleSubReach(FunctionConst.FUNC_TREASURE, "slotRP", {pos = unitData:getPos(), slot = unitData:getSlot()}) then -- 更换红点   
					return  true
				end			
			end
		end
		
		return  false
	end
 
	self._leftIcons[pos]:showRedPoint( getShowRedPoint() ) 
end

function TreasureDetailView:_updateHeroIconsSelectedState()
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
function TreasureDetailView:_initTreasuretment()
	if self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_1 then    
		return
	end

	self._treasures = {}
	local TeamTreasureIcon = require("app.scene.view.team.TeamTreasureIcon")
	for i = 1, TreasureDetailView.TREASURE_COUNT do 
		local equip = TeamTreasureIcon.new(self["_fileNodeTreasure"..i])
		table.insert(self._treasures, equip)
		--self["_fileNodeEquip"..i]:getChildren()[1]:addClickEventListenerEx(handler(self, self._onBtnEquipmentClick))
		-- equip:setIsOnlyShow(true)
		-- equip:setOnlyShowCallback(handler(self, self._onBtnEquipmentClick))
		self:_initEquipIconSelect(self["_fileNodeTreasure"..i])
	end
end  

--装备信息
function TreasureDetailView:_updateTreasure()
	if self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_1 then    
		return
	end

	for i = 1, TreasureDetailView.TREASURE_COUNT do
		local treasureIcon = self._treasures[i]
		treasureIcon:updateIcon(self.curPos, i)

		self:refreshEquipRedPoint(i) --红点 treasureIcon:showRedPoint(false) 
		treasureIcon:showUpArrow(false) --箭头
		ccui.Helper:seekNodeByName(self["_fileNodeTreasure"..i], "FileNodeName"):setVisible(false) 
		ccui.Helper:seekNodeByName(self["_fileNodeTreasure"..i], "equipIconSelect"):setVisible(self._selectedPos == i) -- 刷新选中框
	end
end

-- 红点处理
function TreasureDetailView:refreshEquipRedPoint(slot) 
	local id =  G_UserData:getBattleResource():getResourceId(self.curPos, 2, slot)
	local unitData = G_UserData:getTreasure():getTreasureDataWithId(id)
	if unitData == nil then
        return 
    end
  
	local bShowRP = false
	for index = 1, TreasureConst.TREASURE_TRAIN_LIMIT do
		if RedPointHelper.isModuleSubReach(FunctionConst["FUNC_TREASURE_TRAIN_TYPE"..index], "slotRP", unitData) then	
			bShowRP = true
		end 
	end

	local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_TREASURE, "slotRP", {pos = unitData:getPos(), slot = unitData:getSlot()}) -- 更换红点   
	self._treasures[slot]:showRedPoint(bShowRP or reach)   
end

-- 初始化装备icon选中框
function TreasureDetailView:_initEquipIconSelect(equip) 
	local FileNodeName = ccui.Helper:seekNodeByName(equip, "FileNodeName")
	if FileNodeName:getParent():getChildByName("equipIconSelect") then
		FileNodeName:getParent():removeChildByName("equipIconSelect")
	end

	local image = ccui.ImageView:create()
	local path = Path.getUICommonFrame("img_zhuangbei01") 
	image:loadTexture(path)   
	image:setPosition(cc.p(0, 1))
	image:setLocalZOrder(-1)
	image:ignoreContentAdaptWithSize(false)
	image:setContentSize(cc.size(111.00, 111.00))
	FileNodeName:getParent():addChild(image)
	image:setName("equipIconSelect")
	image:setVisible(false)
end

--点击装备回调 
function TreasureDetailView:_onBtnTreasureClick(slot)  

	self._selectedPos = slot   
	local treasureId = G_UserData:getBattleResource():getResourceId(self.curPos, 2, slot) 
	G_UserData:getTreasure():setCurTreasureId(treasureId)
	self:updateInfo()
end

-- 对应卡槽中对应的装备
function TreasureDetailView:getAllTreasureIds() 
	for index = 1, TreasureDetailView.TREASURE_COUNT do   
		if not self._allTreasureIds[index] then
			self._allTreasureIds[index] = 0	--table.insert(self._allEquipIds, index, 0)
		end
	end
end 

function TreasureDetailView:_updateInfo2()
	self:_updateTreasure()
	self:_updatePageView()
	self:_updateHeroIconsSelectedState()
 

	TreasureDetailBaseView = require("app.scene.view.treasureDetail.TreasureDetailBaseView2")
	if self._nodeTreasureDetailView:getChildrenCount() > 0 then
		self._selectTabIndex = self._nodeTreasureDetailView:getChildren()[1]:getTabSelect()
	end
	if self._tabSelectId then
		self._selectTabIndex = self._tabSelectId
		self._tabSelectId = nil -- 仅使用一次就重置
	end

	self._nodeTreasureDetailView:removeAllChildren()
	local treasureDetail = TreasureDetailBaseView.new(self._treasureData, self._rangeType, self)
	if Lang.checkUI("ui4") then
		treasureDetail:setName("TreasureDetailBaseView")
	end
	self._nodeTreasureDetailView:addChild(treasureDetail)

	-- 隐藏头像列表
	if self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_1 then 
		self._treasure:setVisible(false)
		self._listViewLineup:setVisible(false)
	end
end

function TreasureDetailView:updateInfo()
	local treasureId = G_UserData:getTreasure():getCurTreasureId()
	self._treasureData = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
	self._buttonReplace:setVisible(self._treasureData:isInBattle())
	self._buttonUnload:setVisible(self._treasureData:isInBattle())
	self:_checkRedPoint()

	if Lang.checkUI("ui4") then   
		self:_updateInfo2()
		return
	end

	self._nodeTreasureDetailView:removeAllChildren()
	local treasureDetail = TreasureDetailBaseView.new(self._treasureData, self._rangeType)
	self._nodeTreasureDetailView:addChild(treasureDetail)
end

function TreasureDetailView:_onButtonReplaceClicked()
	local curPos = self.curPos 
	local curTreasureId = G_UserData:getTreasure():getCurTreasureId()
	local curTreasureUnitData = G_UserData:getTreasure():getTreasureDataWithId(curTreasureId)
	local curTreasureSlot = curTreasureUnitData:getSlot()
	local result, noWear, wear = G_UserData:getTreasure():getReplaceTreasureListWithSlot(curPos, curTreasureSlot)
	if #result == 0 then
		G_Prompt:showTip(Lang.get("treasure_empty_tip"))
	else
		local PopupChooseTreasureHelper = require("app.ui.PopupChooseTreasureHelper")
		local popup = require("app.ui.PopupChooseTreasure2").new()
		local callBack = handler(self, self._onChooseTreasure)
		popup:setTitle(Lang.get("treasure_replace_title"))
		popup:updateUI(
			PopupChooseTreasureHelper.FROM_TYPE2,
			callBack,
			result,
			self._buttonReplace, --_btnTreasureShowRP,
			curTreasureUnitData,
			noWear,
			curPos
		)
		popup:openWithAction()
	end

	-- G_SceneManager:popScene()
	-- local scene = G_SceneManager:getTopScene()
	-- if scene:getName() == "team" then
	-- 	local view = scene:getSceneView()
	-- 	view:setNeedPopupTreasureReplace(self._btnReplaceShowRP)
	-- end
end

function TreasureDetailView:_onChooseTreasure(treasureId)
	local curPos = self.curPos 
	local curTreasureId = G_UserData:getTreasure():getCurTreasureId()
	local curTreasureUnitData = G_UserData:getTreasure():getTreasureDataWithId(curTreasureId)
	local curTreasureSlot = curTreasureUnitData:getSlot()
	G_UserData:getTreasure():c2sEquipTreasure(curPos, curTreasureSlot, treasureId)
end

function TreasureDetailView:_onEventRedPointUpdate(eventName, funcId)
	if funcId ~= FunctionConst.FUNC_TREASURE then
		return 
	end
	self:_checkRedPoint()
end

function TreasureDetailView:_treasureAddSuccess(eventName, oldId, pos, slot)

	local scene = G_SceneManager:getTopScene() 
	if scene:getName() == "team" then   
		return
	end
	
	self._allTreasureIds = {}
	self._allTreasureIds = G_UserData:getBattleResource():getTreasureInfoWithPos(pos)  
	self:getAllTreasureIds()

	self._selectedPos = slot   
	local treasureId = G_UserData:getBattleResource():getResourceId(pos, 2, slot) 
	if G_UserData:getTreasure():getCurTreasureId() == treasureId then
		return
	end
	G_UserData:getTreasure():setCurTreasureId(treasureId)
	
	
	self:updateInfo() 
	self:_playTreasureAddSummary(oldId, pos, slot)
end

function TreasureDetailView:_onButtonUnloadClicked()
	local pos = self._treasureData:getPos()
	local slot = self._treasureData:getSlot()
	G_UserData:getTreasure():c2sRemoveTreasure(pos, slot)
end

function TreasureDetailView:_treasureRemoveSuccess(eventName, slot)

	local len = 0
	self._allTreasureIds = {}
	self._allTreasureIds = G_UserData:getBattleResource():getTreasureInfoWithPos(self.curPos)   
    for k, v in pairs(self._allTreasureIds) do
		len = len + 1
		break
	end
	if len == 0 then    -- 无可展示装备
		G_SceneManager:popScene()
		local scene = G_SceneManager:getTopScene()
		if scene:getName() == "team" then
			local view = scene:getSceneView()
			view:setNeedTreasureRemovePrompt(true)
		end
		return
	end

	self:getAllTreasureIds()
	self:_changeCurSelectEquipPos()

	local treasureId = self._allTreasureIds[self._selectedPos]
	G_UserData:getTreasure():setCurTreasureId(treasureId)
	
	self:updateInfo()
	self:_playRemoveTreasureSummary()
end 

function TreasureDetailView:_changeCurSelectEquipPos()
	if self._allTreasureIds[self._selectedPos] == 0 then   
		
		for index = self._selectedPos, self._selectedPos + #self._allTreasureIds - 1 do   --注：若武将对应部位没有装备，则按照从左至右的顺序优先选中并展示其对应部位装备
			local tpos = index%#self._allTreasureIds + 1
			if self._allTreasureIds[tpos] and self._allTreasureIds[tpos] ~= 0 then
				self._selectedPos = tpos
				break
			end
		end
	end 
end

function TreasureDetailView:getAvatar()
	return self._avatar:getChildren()[1]:getChildren()[1] 
end

function TreasureDetailView:setButtonVisible(bShow)
	return self._buttonBg:setVisible(bShow)
end 

function TreasureDetailView:getSelectedPos()
    return self._selectedPos
end

-- 获取当前选中武将阵位
function TreasureDetailView:getCurPos()
    return self.curPos  
end

function TreasureDetailView:_checkRedPoint()
	local pos = self._treasureData:getPos()
	local slot = self._treasureData:getSlot()
	local param = {pos = pos, slot = slot}
	local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_TREASURE, "slotRP", param)
	self._buttonReplace:showRedPoint(reach)
	self._btnReplaceShowRP = reach
end 

function TreasureDetailView:getSelectTabIndex(bShow)  
	return self._selectTabIndex
end 

function TreasureDetailView:getDetailViewNode()
	return self._nodeTreasureDetailView
end

function TreasureDetailView:getPageView()
	return self._pageView
end
 
function TreasureDetailView:changeBackground(resPath)
	if resPath == nil then  
		self._imgBg:setVisible(false) 	
	else
		self._imgBg:loadTexture(resPath) -- 要先load在设置 顺序
		self._imgBg:setScale9Enabled(true)
		self._imgBg:setCapInsets(cc.rect(1200, 270,1,1))
		self._imgBg:setContentSize(cc.size(1600, self._imgBg:getContentSize().height))  
		self._imgBg:setAnchorPoint(0.5,0.5)
		self._imgBg:setPositionX(self._imgBg:getParent():getContentSize().width*0.44)
		self._imgBg:setVisible(true) 
	end	
end 

-- bug: 界限突破时, 特效要在UI最上层 (但是玉石界面又会遮挡UI 所以动态调整)
function TreasureDetailView:changeDetailViewZorder(zOrder)
	if zOrder == nil then
		self._nodeTreasureDetailView:setLocalZOrder(1)   
		self._panelDesign:setLocalZOrder(self._nodeTreasureDetailView:getLocalZOrder() + 1)
		self._topbarBase:setLocalZOrder(self._panelDesign:getLocalZOrder() + 1)
	else
		self._panelDesign:setLocalZOrder(1)    
		self._nodeTreasureDetailView:setLocalZOrder(self._panelDesign:getLocalZOrder() + 1)
		self._topbarBase:setLocalZOrder(self._nodeTreasureDetailView:getLocalZOrder() + 1)
	end
end    






-------------------------------------------------------------播放宝物穿戴飘字
--播放宝物穿戴飘字
function TreasureDetailView:_playTreasureAddSummary(oldId, pos, slot)
	self:_updateEffectData()
	local summary = {}

	local param1 = {
		content = oldId > 0 and Lang.get("summary_treasure_change_success") or Lang.get("summary_treasure_add_success"),
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
		--anchorPoint = cc.p(0.5, 0.5),
		-- finishCallback = function()
		-- 	--穿戴宝物飘字结束事件
		-- 	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, "TeamView:_playTreasureAddSummary") -- 这是新手引导
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

	local treasureId = G_UserData:getBattleResource():getResourceId(pos, 2, slot)
	local treasureData = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
	local treasureBaseId = treasureData:getBase_id()
	local allYokeData = self._allYokeData
	if allYokeData and allYokeData.yokeInfo then
		for i = 1, 6 do
			local info = allYokeData.yokeInfo[i]
			if info and info.isActivated and info.fateType == 3 and isInYokeCondition(info.heroIds, treasureBaseId) then --羁绊类型是宝物羁绊
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
					--anchorPoint = cc.p(0.5, 0.5),
					startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
					-- dstPosition = UIHelper.convertSpaceFromNodeToNode(self["_textJiBanDes" .. i], self),
					-- finishCallback = function()
					-- --	self:_updateOneYoke(i)
					-- end
				}
				table.insert(summary, param)
			else
				--self:_updateOneYoke(i)
			end
		end
	end

	-- --宝物强化大师
	-- self:_addTreasureStrMasterPromptSummary(summary, pos)
	-- --宝物精炼大师
	-- self:_addTreasureRefinePromptSummary(summary, pos)

	self:_addBaseAttrPromptSummary(summary)

	G_Prompt:showSummary(summary)
	--总战力
	G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_TEAM, UIConst.SUMMARY_OFFSET_X_TRAIN, -5)
end

function TreasureDetailView:_initEffectData()
	--播放宝物穿戴飘字
	if self._rangeType == TreasureConst.TREASURE_RANGE_TYPE_2 then
		self._allYokeData = {} --羁绊信息
		self._lastTreasureStrMasterLevel = {} --记录宝物强化大师等级,{pos, level}
		self._diffTreasureStrMasterLevel = 0 --记录宝物强化大师等级差
		self._lastTreasureRefineMasterLevel = {} --记录宝物精炼大师等级,{pos, level}
		self._diffTreasureRefineMasterLevel = 0 --记录宝物精炼大师等级差

		self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst["FUNC_TEAM_SLOT" .. self.curPos ])
		self:_updateEffectData()
	end
end

function TreasureDetailView:_updateEffectData()
	local curPos = self.curPos	--G_UserData:getTeam():getCurPos()
	local curHeroId = G_UserData:getTeam():getHeroIdWithPos(curPos)
	G_UserData:getHero():setCurHeroId(curHeroId)
	self._curHeroData = G_UserData:getHero():getUnitDataWithId(curHeroId)
 
--	self:_checkInstrumentIsShow()
	self._allYokeData = UserDataHelper.getHeroYokeInfo(self._curHeroData)
	self:_recordBaseAttr()
	G_UserData:getAttr():recordPowerWithKey(FunctionConst.FUNC_TEAM)
	--self:_recordMasterLevel()
end

--记录基础属性
function TreasureDetailView:_recordBaseAttr()	
	local param = {
		heroUnitData = self._curHeroData
	}
	local attrInfo = UserDataHelper.getTotalAttr(param)
	self._recordAttr:updateData(attrInfo)

	-- Log
	-- local attrIds = self._recordAttr:getAllAttrIdsBySort()
	-- for i, attrId in ipairs(attrIds) do
	-- 	local diffValue = self._recordAttr:getDiffValue(attrId)
	-- 	print("------_recordBaseAttr attrId curValue  lastValue diffValue: ",  attrId, self._recordAttr:getCurValue(attrId), self._recordAttr:getLastValue(attrId), diffValue)
	-- end
end

--记录强化大师等级
function TreasureDetailView:_recordMasterLevel()
	local pos = self.curPos --G_UserData:getTeam():getCurPos()

	-- local info1 = self._lastEquipStrMasterLevel
	-- local lastLevel1 = info1[2] or 0
	-- local curMasterInfo1 = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_1)
	-- local curLevel1 = curMasterInfo1.masterInfo.curMasterLevel
	-- self._diffEquipStrMasterLevel = curLevel1 - lastLevel1
	-- self._lastEquipStrMasterLevel = {pos, curLevel1}

	-- local info2 = self._lastEquipRefineMasterLevel
	-- local lastLevel2 = info2[2] or 0
	-- local curMasterInfo2 = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_2)
	-- local curLevel2 = curMasterInfo2.masterInfo.curMasterLevel
	-- self._diffEquipRefineMasterLevel = curLevel2 - lastLevel2
	-- self._lastEquipRefineMasterLevel = {pos, curLevel2}

	local info3 = self._lastTreasureStrMasterLevel
	local lastLevel3 = info3[2] or 0
	local curMasterInfo3 = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_3)
	local curLevel3 = curMasterInfo3.masterInfo.curMasterLevel
	self._diffTreasureStrMasterLevel = curLevel3 - lastLevel3
	self._lastTreasureStrMasterLevel = {pos, curLevel3}

	local info4 = self._lastTreasureRefineMasterLevel
	local lastLevel4 = info4[2] or 0
	local curMasterInfo4 = EquipMasterHelper.getCurMasterInfo(pos, MasterConst.MASTER_TYPE_4)
	local curLevel4 = curMasterInfo4.masterInfo.curMasterLevel
	self._diffTreasureRefineMasterLevel = curLevel4 - lastLevel4
	self._lastTreasureRefineMasterLevel = {pos, curLevel4}
end

function TreasureDetailView:_addBaseAttrPromptSummary(summary)
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

--播放宝物卸下飘字
function TreasureDetailView:_playRemoveTreasureSummary() 
	self:_updateEffectData()

	local summary = {}
	self:_addBaseAttrPromptSummary(summary)
	G_Prompt:showSummary(summary)
	G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_TEAM, UIConst.SUMMARY_OFFSET_X_TEAM, -5)
end


return TreasureDetailView