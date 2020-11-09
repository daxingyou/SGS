--
-- Author: Liangxu
-- Date: 2018-8-29
-- 战马详情
local ViewBase = require("app.ui.ViewBase")
local HorseDetailView = class("HorseDetailView", ViewBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local RedPointHelper = require("app.data.RedPointHelper")
local HorseConst = require("app.const.HorseConst")
local CSHelper = require("yoka.utils.CSHelper")
local HorseDetailBaseView = require("app.scene.view.horseDetail.HorseDetailBaseView")
local HorseDataHelper = require("app.utils.data.HorseDataHelper")
local HorseDetailEquipNode = require("app.scene.view.horseDetail.HorseDetailEquipNode")
local TeamViewHelper = require("app.scene.view.team.TeamViewHelper")
local TeamHeroBustIcon = require("app.scene.view.team.TeamHeroBustIcon")

--播放战马穿戴飘字
local UIConst = require("app.const.UIConst")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local AttributeConst = require("app.const.AttributeConst")


--需要记录的属性列表
--{属性Id， 对应控件名}
local RECORD_ATTR_LIST = {
	{AttributeConst.ATK, nil},
	{AttributeConst.HP, nil},
	{AttributeConst.PD, nil},
	{AttributeConst.MD, nil},
	{AttributeConst.NO_CRIT, nil}, -- CRIT
	{AttributeConst.HIT, nil},
}
  

function HorseDetailView:ctor(horseId, rangeType, tabSelectId) 
	G_UserData:getHorse():setCurHorseId(horseId)

	self._topbarBase 		= nil --顶部条
	self._buttonLeft 		= nil --左箭头按钮
	self._buttonRight 		= nil --右箭头按钮
	self._buttonReplace 	= nil --更换按钮
	self._buttonUnload		= nil --卸下按钮
	self._nodeDetailView 	= nil 
    
    self._canRefreshAttr    = true

	self._tabSelectId = tabSelectId	-- tabSelectId如果传值 代表从战马列表进入， 则显示“进阶”页签, 不能显示默认页签
	self._rangeType = rangeType or HorseConst.HORSE_RANGE_TYPE_1
    self._allHorseIds = {}
    
    self._recordAttr = G_UserData:getAttr():createRecordData(horseId)

	local resource = {
		file = Path.getCSB("HorseDetailView2", "horse"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonLeft = {
				events = {{event = "touch", method = "_onButtonLeftClicked"}}
			},
			_buttonRight = {
				events = {{event = "touch", method = "_onButtonRightClicked"}}
			},
			_buttonReplace = {
				events = {{event = "touch", method = "_onButtonReplaceClicked"}}
			},
			_buttonUnload = {
				events = {{event = "touch", method = "_onButtonUnloadClicked"}}
			},
		}
    }
    
    self:setName("HorseDetailView")
	HorseDetailView.super.ctor(self, resource)
end

function HorseDetailView:onCreate()
	self._pageAvatars = {}

	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)
	self._topbarBase:setImageTitle("txt_sys_com_horse")

	self._buttonReplace:setFontSize(20)
	self._buttonUnload:setFontSize(20)
	self._buttonUnload:setFontName(Path.getFontW8())
	self._buttonReplace:setFontName(Path.getFontW8())
	self._buttonUnload:setString(Lang.get("horse_detail_btn_unload"))
	self._buttonReplace:setString(Lang.get("horse_detail_btn_replace"))
end

function HorseDetailView:onEnter()
	self._signalHorseRemoveSuccess = G_SignalManager:add(SignalConst.EVENT_HORSE_CLEAR_SUCCESS, handler(self, self._horseRemoveSuccess))
	self._signalHorseAddSuccess = G_SignalManager:add(SignalConst.EVENT_HORSE_ADD_SUCCESS, handler(self, self._horseAddSuccess))
	self._signalRedPointUpdate = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._onEventRedPointUpdate))
	
	 
	local curHorseId = G_UserData:getHorse():getCurHorseId()
	--特殊处理:	背包入口中选中装备若已被武将装备，则打开上面装备信息界面；若没有被任何武将装备，则去掉滑动切换按钮
	if self._rangeType == HorseConst.HORSE_RANGE_TYPE_1 then
		local unit = G_UserData:getHorse():getUnitDataWithId(curHorseId)
		local pos = unit:getPos()
		if pos then
			self._rangeType = HorseConst.HORSE_RANGE_TYPE_2
		end
	end 

	if self._rangeType == HorseConst.HORSE_RANGE_TYPE_1 then
		self._allHorseIds = G_UserData:getHorse():getRangeDataBySort()
	elseif self._rangeType == HorseConst.HORSE_RANGE_TYPE_2 then
		local unit = G_UserData:getHorse():getUnitDataWithId(curHorseId)
		local pos = unit:getPos()
		if pos then
			self.curPos = pos --当前阵位
			self._allHorseIds = G_UserData:getBattleResource():getHorseIdsWithPos(pos)
		end
	end

	self._selectedPos = 0
	for i, id in ipairs(self._allHorseIds) do
		if id == curHorseId then
			self._selectedPos = i
		end
	end
	self._maxCount = #self._allHorseIds
	self:_updatePageItem()
	self:_initLeftIcons()
	self:_updateInfo()
	self:_initEffectData() -- 飘字
end

function HorseDetailView:onExit()
	self._signalHorseAddSuccess:remove()
	self._signalHorseAddSuccess = nil
	self._signalRedPointUpdate:remove()
	self._signalRedPointUpdate = nil
	self._signalHorseRemoveSuccess:remove()
	self._signalHorseRemoveSuccess = nil
end

function HorseDetailView:_createPageItem(width, height, i)
	local widget = ccui.Widget:create()
	widget:setContentSize(width, height)

	local horseId = self._allHorseIds[i]
	local unitData = G_UserData:getHorse():getUnitDataWithId(horseId)
	local baseId = unitData:getBase_id()
	local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonHorseAvatar", "common"))
	avatar:updateUI(baseId)
	avatar:showShadow(false)
	avatar:showEffect(true)
	local size = widget:getContentSize()
	avatar:setPosition(cc.p(size.width*0.57, 200))
	widget:addChild(avatar)

	return widget
end

function HorseDetailView:_updatePageItem()
 	local viewSize = self._pageView:getContentSize()
	local item = self:_createPageItem(viewSize.width, viewSize.height, self._selectedPos)

	self._avatar:removeAllChildren()
	self._avatar:addChild(item)
end

-- 头像列表
function HorseDetailView:_initLeftIcons()
	if self._rangeType == HorseConst.HORSE_RANGE_TYPE_1 then  
		return
	end
 
	local itemList = self._listViewLineup:getChildren()  --bug: 装备精炼界面，精炼石不够去商店返回，左侧英雄列表会额外初始化一次
	if #itemList > 0 then
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
			local _allInstrumentIds = G_UserData:getBattleResource():getHorseIdsWithPos( unitData:getPos() )
			if #_allInstrumentIds > 0 then
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
function HorseDetailView:_onLeftIconClicked(pos)
	local iconData = TeamViewHelper.getHeroIconData()
	local info = iconData[pos] 

	local heroId = info.id
	local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
	self.curPos = unitData:getPos() --当前阵位
	self._allHorseIds = {}
	self._allHorseIds = G_UserData:getBattleResource():getHorseIdsWithPos(self.curPos)   

	local horseId = self._allHorseIds[self._selectedPos] 
	G_UserData:getHorse():setCurHorseId(horseId)

	self:_updateInfo()
	--记录更换武将的基础属性
	self:_updateEffectData()
end 

-- 左侧Icon红点刷新
function HorseDetailView:refreshLeftIconRedPoint(pos)
	if self._rangeType == HorseConst.HORSE_RANGE_TYPE_1 then  
		return  
	end

	local getShowRedPoint = function ()  
 
		local horseId = G_UserData:getBattleResource():getResourceId(pos, 4, 1)
		if horseId then
			-- 养成红点
		    local unitData = G_UserData:getHorse():getUnitDataWithId(horseId) 
			local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_HORSE_TRAIN, "slotRP", unitData)
			if reach then
				return true
			end 

			-- 更换红点 
			local pos = unitData:getPos()
			local slot = unitData:getSlot()
			if pos then
				local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
				local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
				local heroBaseId = heroUnitData:getBase_id()
				local param = {pos = pos, slot = slot, heroBaseId = heroBaseId,notCheckEquip = true}
				local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_HORSE, "slotRP", param)
				if reach then
					return true
				end 
			end
		end
 
		return  false
	end

	self._leftIcons[pos]:showRedPoint( getShowRedPoint() ) 
end

--点击装备回调 
function HorseDetailView:_onBtnHorseClick(slot)  

	--self._selectedPos = slot   
	local horseId = G_UserData:getBattleResource():getResourceId(self.curPos, 4, self._selectedPos)  
	G_UserData:getHorse():setCurHorseId(horseId)
	self:_updateInfo() 
end

function HorseDetailView:_updateInfo2()
	self:_updatePageItem()
	self:_updateHeroIconsSelectedState()
	
	self._nodeEquip:removeAllChildren()
    self._horseEquipItem = HorseDetailEquipNode.new()
	self._nodeEquip:addChild(self._horseEquipItem)
 
	local root = ccui.Helper:seekNodeByName(self._horseEquipItem, "Node_Root")
	for index = 1, root:getChildrenCount() do
		root:getChildren()[index]:setScale(0.8)
	end
	
	HorseDetailBaseView = require("app.scene.view.horseDetail.HorseDetailBaseView2")
	if self._nodeDetailView:getChildrenCount() > 0 then
		self._selectTabIndex = self._nodeDetailView:getChildren()[1]:getTabSelect()
	end
	if self._tabSelectId then
		self._selectTabIndex = 2
		self._tabSelectId = nil -- 仅使用一次就重置
	end
	self._nodeDetailView:removeAllChildren()
	self._horseDetail = HorseDetailBaseView.new(self._horseData, self._rangeType, self._recordAttr, self._horseEquipItem, self)
	self._nodeDetailView:addChild(self._horseDetail)

	-- 隐藏头像列表
	if self._rangeType == HorseConst.HORSE_RANGE_TYPE_1 then 
		--self._horse:setVisible(false) 
		self._listViewLineup:setVisible(false)
	end
end

function HorseDetailView:_updateInfo()
	local horseId = G_UserData:getHorse():getCurHorseId()
	self._horseData = G_UserData:getHorse():getUnitDataWithId(horseId)
	self._buttonUnload:setVisible(self._horseData:isInBattle())
	self._buttonReplace:setVisible(self._horseData:isInBattle())
	self:_checkRedPoint()

    if self._canRefreshAttr then
        local attrInfo = HorseDataHelper.getHorseAttrInfo(self._horseData)    
        self._recordAttr:updateData(attrInfo)
    end
	local avatar = self._avatar:getChildren()[1]:getChildren()[1]  -- self._pageAvatars[self._selectedPos]
	if avatar then
		avatar:playAnimationOnce("win")
		HorseDataHelper.playVoiceWithId(self._horseData:getBase_id())
	end

	if Lang.checkUI("ui4") then   
		self:_updateInfo2()
		return
	end

    self._nodeEquip:removeAllChildren()
    self._horseEquipItem = HorseDetailEquipNode.new()
    self._nodeEquip:addChild(self._horseEquipItem)
	self._nodeDetailView:removeAllChildren()
	self._horseDetail = HorseDetailBaseView.new(self._horseData, self._rangeType, self._recordAttr, self._horseEquipItem, self)
    self._nodeDetailView:addChild(self._horseDetail)

	
	local avatar = self._pageAvatars[self._selectedPos]
	if avatar then
		avatar:playAnimationOnce("win")
		HorseDataHelper.playVoiceWithId(self._horseData:getBase_id())
	end
end

function HorseDetailView:_onButtonLeftClicked()
	if self._selectedPos <= 1 then
		return
	end
	self._selectedPos = self._selectedPos - 1
	local curHorseId = self._allHorseIds[self._selectedPos]
	G_UserData:getHorse():setCurHorseId(curHorseId)
	self:_updateArrowBtn()
	self._pageView:setCurrentPageIndex(self._selectedPos - 1)
	self:_updateInfo()
	self:_updatePageItem()
end

function HorseDetailView:_updateHeroIconsSelectedState()
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

function HorseDetailView:_onButtonRightClicked()
	if self._selectedPos >= self._maxCount then
		return
	end
	self._selectedPos = self._selectedPos + 1
	local curHorseId = self._allHorseIds[self._selectedPos]
	G_UserData:getHorse():setCurHorseId(curHorseId)
	self:_updateArrowBtn()
	self._pageView:setCurrentPageIndex(self._selectedPos - 1)
	self:_updateInfo()
	self:_updatePageItem()
end

function HorseDetailView:_updateArrowBtn()
	self._buttonLeft:setVisible(self._selectedPos > 1)
	self._buttonRight:setVisible(self._selectedPos < self._maxCount)
end

function HorseDetailView:_onButtonReplaceClicked()
	local curPos = self.curPos 
	local heroId = G_UserData:getTeam():getHeroIdWithPos(curPos)
	local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
	local heroBaseId = heroUnitData:getAvatarToHeroBaseId()
	local result, noWear, wear = G_UserData:getHorse():getReplaceHorseListWithSlot(curPos, heroBaseId)
	if #result == 0 then
		G_Prompt:showTip(Lang.get("horse_empty_tip"))
	else
		local PopupChooseHorseHelper = require("app.ui.PopupChooseHorseHelper")
		local popup = require("app.ui.PopupChooseHorse").new()
		local callBack = handler(self, self._onChooseHorse)
		popup:setTitle(Lang.get("horse_replace_title"))
		popup:updateUI(PopupChooseHorseHelper.FROM_TYPE2, callBack, result, self._btnReplaceShowRP)
		popup:openWithAction()
	end

	-- G_SceneManager:popScene()
	-- local scene = G_SceneManager:getTopScene()
	-- if scene:getName() == "team" then
	-- 	local view = scene:getSceneView()
	-- 	view:setNeedPopupHorseReplace(self._btnReplaceShowRP)
	-- end
end

function HorseDetailView:_onChooseHorse(horseId)
	local curPos = self.curPos 
	G_UserData:getHorse():c2sWarHorseFit(curPos, horseId)
end

function HorseDetailView:_horseAddSuccess(eventName, id, pos, oldId)
	local scene = G_SceneManager:getTopScene()
	if scene:getName() == "team" then   
		return
	end

	self._allHorseIds = {} 
	self._allHorseIds = G_UserData:getBattleResource():getHorseIdsWithPos(pos)    
 
	--self._selectedPos = slot   
	local horseId = G_UserData:getBattleResource():getResourceId(pos, 4, self._selectedPos) 
	if  G_UserData:getHorse():getCurHorseId() == horseId then
		return
	end
	G_UserData:getHorse():setCurHorseId(horseId)
	
	self:_updateInfo() 
	self:_playHorseAddSummary(id, pos, oldId)
end

function HorseDetailView:_onButtonUnloadClicked()
	local pos = self._horseData:getPos()
	G_UserData:getHorse():c2sWarHorseUnFit(pos)
end

function HorseDetailView:_horseRemoveSuccess(eventName, slot)
	
	G_SceneManager:popScene()
	local scene = G_SceneManager:getTopScene()
	if scene:getName() == "team" then
		local view = scene:getSceneView()
		view:setNeedHorseRemovePrompt(true) 
	end
end

function HorseDetailView:_onEventRedPointUpdate(eventName, funcId)
	self:_checkRedPoint()
end

function HorseDetailView:getAvatar()
	return self._avatar:getChildren()[1]:getChildren()[1] 
end

function HorseDetailView:isShowButton(bSHow)
	self._imgBtn:setVisible(bSHow)
	-- self._buttonUnload:setVisible(bSHow)
	-- self._buttonReplace:setVisible(bSHow)
end

function HorseDetailView:_checkRedPoint()
	local pos = self._horseData:getPos()
	local slot = self._horseData:getSlot()
	if pos then
		local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
		local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
		local heroBaseId = heroUnitData:getBase_id()
		local param = {pos = pos, slot = slot, heroBaseId = heroBaseId,notCheckEquip = true}
		local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_HORSE, "slotRP", param)
		self._buttonReplace:showRedPoint(reach)
		self._btnReplaceShowRP = reach
	end
end 

function HorseDetailView:popupHorseEquipReplace(equipPos)
    logWarn("HorseDetailView:popupHorseEquipReplace "..tostring(equipPos))
    local curHorseId = G_UserData:getHorse():getCurHorseId()
    local totalList,noWearList = G_UserData:getHorseEquipment():getReplaceEquipmentListWithSlot(equipPos,curHorseId)

    -- if #noWearList == 0 then
    --     G_Prompt:showTipOnTop(Lang.get("horse_equip_empty_tip"))
    -- end
    local PopupChooseHorseEquipHelper = require("app.ui.PopupChooseHorseEquipHelper")
    local popup = require("app.ui.PopupChooseHorseEquip").new(self)
    local callBack = function(equipInfo)
        logWarn("点击更好战马装备")
        dump(equipInfo)
        local horseId = curHorseId
        G_UserData:getHorseEquipment():c2sEquipWarHorseEquipment(horseId,equipPos,equipInfo:getId())
    end
    popup:setTitle(Lang.get("horse_equip_wear_title"))                
    popup:updateUI(PopupChooseHorseEquipHelper.FROM_TYPE2, callBack, totalList, nil, noWearList, equipPos)
    popup:openWithAction()
end

function HorseDetailView:updateHorseEquipDifPrompt()
    self._canRefreshAttr = false
    local actions = {}
    actions[1] = cc.DelayTime:create(0.2)
    actions[2] = cc.CallFunc:create(function()
        self._canRefreshAttr = true
        local attrInfo = HorseDataHelper.getHorseAttrInfo(self._horseData)    
        self._recordAttr:updateData(attrInfo)
        self._horseDetail:updateHorseEquipDifPrompt()
    end)

    self:runAction(cc.Sequence:create(actions))
end

function HorseDetailView:getSelectTabIndex()
	return self._selectTabIndex
end

function HorseDetailView:getCurPos()
	return self.curPos
end


------------------------------------------------------------ --播放战马穿戴飘字
 
function HorseDetailView:_initEffectData()
	--播放神兵穿戴飘字
	if self._rangeType == HorseConst.HORSE_RANGE_TYPE_2 then
		self._allYokeData = {} --羁绊信息
		self._lastHorseLevel = {} --记录战马升星等级,{[1] = {id, rLevel}, ...}

		--self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst["FUNC_TEAM_SLOT" .. self.curPos ])
		self._recordAttr2 = G_UserData:getAttr():createRecordData(FunctionConst.FUNC_HORSE) 	 
		self:_updateEffectData()
	end
end

function HorseDetailView:_updateEffectData()
	local curPos = self.curPos	--G_UserData:getTeam():getCurPos()
	local curHeroId = G_UserData:getTeam():getHeroIdWithPos(curPos)
	G_UserData:getHero():setCurHeroId(curHeroId)
	self._curHeroData = G_UserData:getHero():getUnitDataWithId(curHeroId)
 
	--self:_checkInstrumentIsShow()
	self._allYokeData = UserDataHelper.getHeroYokeInfo(self._curHeroData)
	self:_recordBaseAttr()
	G_UserData:getAttr():recordPower()  --recordPowerWithKey(FunctionConst.FUNC_TEAM)
	--self:_recordMasterLevel()
end

--记录基础属性
function HorseDetailView:_recordBaseAttr()	
	local param = {
		heroUnitData = self._curHeroData
	}
	local attrInfo = UserDataHelper.getTotalAttr(param) 	  
	
--	local attrInfo = HorseDataHelper.getHorseAttrInfo(self._horseData)      -- bug:战马飘字属性对不上
	self._recordAttr2:updateData(attrInfo)
end

function HorseDetailView:_playHorseAddSummary(id, pos, oldId)
	self:_updateEffectData()
	local summary = {}

	local param1 = {
		content = oldId > 0 and Lang.get("summary_horse_change_success") or Lang.get("summary_horse_add_success"),
		--anchorPoint = cc.p(0.5, 0.5),
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
	}
	table.insert(summary, param1)

	self:_addBaseAttrPromptSummary(summary)

	G_Prompt:showSummary(summary)
	--总战力
	G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_TEAM, UIConst.SUMMARY_OFFSET_X_TRAIN, -5)
end

function HorseDetailView:_addBaseAttrPromptSummary(summary)
	local attrIds = self._recordAttr2:getAllAttrIdsBySort() -- 不是所有属性要比对
	--for i, attrId in ipairs(attrIds) do

	
	for i, one in ipairs(RECORD_ATTR_LIST) do 
		local attrId = one[1]
		local diffValue = self._recordAttr2:getDiffValue(attrId)
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

return HorseDetailView


 

 

