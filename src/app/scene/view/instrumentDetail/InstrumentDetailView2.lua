--
-- Author: Liangxu
-- Date: 2017-9-15 17:48:07
-- 神兵详情
local ViewBase = require("app.ui.ViewBase")
local InstrumentDetailView = class("InstrumentDetailView", ViewBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local RedPointHelper = require("app.data.RedPointHelper")
local InstrumentConst = require("app.const.InstrumentConst")
local TeamHeroBustIcon = require("app.scene.view.team.TeamHeroBustIcon")
local TeamViewHelper = require("app.scene.view.team.TeamViewHelper")
local CSHelper = require("yoka.utils.CSHelper")

--播放神兵穿戴飘字
local UIConst = require("app.const.UIConst")
local HeroDataHelper = require("app.utils.data.HeroDataHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local AttributeConst = require("app.const.AttributeConst")

local InstrumentDetailBaseView = require("app.scene.view.instrumentDetail.InstrumentDetailBaseView")


--需要记录的属性列表
--{属性Id， 对应控件名}
local RECORD_ATTR_LIST = {
	{AttributeConst.ATK, nil},
	{AttributeConst.HP, nil},
	{AttributeConst.PD, nil},
	{AttributeConst.MD, nil},
}


InstrumentDetailView.INSTRUMENT_COUNT = 1
function InstrumentDetailView:ctor(instrumentId, rangeType)
	G_UserData:getInstrument():setCurInstrumentId(instrumentId)

	self._topbarBase = nil --顶部条
	self._buttonReplace = nil --更换按钮
	self._buttonUnload = nil --卸下按钮
	self._nodeInstrumentDetailView = nil --宝物详情节点

	self._rangeType = rangeType or InstrumentConst.INSTRUMENT_RANGE_TYPE_1
	self._allInstrumentIds = {}

	local resource = {
		file = Path.getCSB("InstrumentDetailView2", "instrument"),
		size = G_ResolutionManager:getDesignSize(),
		binding = { 
			_buttonReplace = {
				events = {{event = "touch", method = "_onButtonReplaceClicked"}}
			},
			_buttonUnload = {
				events = {{event = "touch", method = "_onButtonUnloadClicked"}}
			}
		}
	}
	InstrumentDetailView.super.ctor(self, resource)
end

function InstrumentDetailView:onCreate()
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)
	self._topbarBase:setImageTitle("txt_sys_com_shenbing")

	self._buttonReplace:setFontSize(20)
	self._buttonUnload:setFontSize(20)
	self._buttonUnload:setFontName(Path.getFontW8())
	self._buttonReplace:setFontName(Path.getFontW8())
	self._buttonUnload:setString(Lang.get("instrument_detail_btn_unload"))
	self._buttonReplace:setString(Lang.get("instrument_detail_btn_replace"))
end

function InstrumentDetailView:onEnter()
	self._signalRedPointUpdate =
		G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._onEventRedPointUpdate))
	self._signalInstrumentAddSuccess =
		G_SignalManager:add(SignalConst.EVENT_INSTRUMENT_ADD_SUCCESS, handler(self, self._instrumentAddSuccess))
	self._signalInstrumentRemoveSuccess =
		G_SignalManager:add(SignalConst.EVENT_INSTRUMENT_CLEAR_SUCCESS, handler(self, self._instrumentRemoveSuccess))



	local instrumentId = G_UserData:getInstrument():getCurInstrumentId()
	--特殊处理:	背包入口中选中装备若已被武将装备，则打开上面装备信息界面；若没有被任何武将装备，则去掉滑动切换按钮
	if self._rangeType == InstrumentConst.INSTRUMENT_RANGE_TYPE_1 then
		local unit = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
		local pos = unit:getPos()
		if pos then
			self._rangeType = InstrumentConst.INSTRUMENT_RANGE_TYPE_2
		end
	end 


	if self._rangeType == InstrumentConst.INSTRUMENT_RANGE_TYPE_1 then
		self._allInstrumentIds = G_UserData:getInstrument():getRangeDataBySort()
	elseif self._rangeType == InstrumentConst.INSTRUMENT_RANGE_TYPE_2 then
		local unit = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
		local pos = unit:getPos()
		if pos then
			self.curPos = pos --当前阵位
			self._allInstrumentIds = G_UserData:getBattleResource():getInstrumentInfoWithPos(pos)  -- getInstrumentIdsWithPos
		end
	end

	self._selectedPos = 0
	local curInstrumentId = G_UserData:getInstrument():getCurInstrumentId()
	for i, id in ipairs(self._allInstrumentIds) do
		if id == curInstrumentId then
			self._selectedPos = i
		end
	end
	self._maxCount = #self._allInstrumentIds
	self:_updatePageView() 
	self:_initLeftIcons()
	self:updateInfo()

	self:_initEffectData()
end

function InstrumentDetailView:onExit()
	self._signalRedPointUpdate:remove()
	self._signalRedPointUpdate = nil
	self._signalInstrumentAddSuccess:remove()
	self._signalInstrumentAddSuccess = nil
	self._signalInstrumentRemoveSuccess:remove()
	self._signalInstrumentRemoveSuccess = nil
end

function InstrumentDetailView:_createPageItem(width, height, i)
	local instrumentId = self._allInstrumentIds[i]
	local unitData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
	local baseId = unitData:getBase_id()
	local limitLevel = unitData:getLimit_level()
	local widget = ccui.Widget:create()
	widget:setContentSize(width, height)
	local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonInstrumentAvatar", "common"))
	avatar:showShadow(false)
	avatar:updateUI(baseId, limitLevel)
	local size = widget:getContentSize()
	avatar:setPosition(cc.p(size.width*0.56, size.height*0.58))
	widget:addChild(avatar)

	return widget
end

function InstrumentDetailView:_updatePageView()
	local viewSize = self._pageView:getContentSize()
	local item = self:_createPageItem(viewSize.width, viewSize.height, self._selectedPos)

	self._avatar:removeAllChildren()
	self._avatar:addChild(item)
end

-- 头像列表
function InstrumentDetailView:_initLeftIcons()
	if self._rangeType == InstrumentConst.INSTRUMENT_RANGE_TYPE_1 then  
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
			local _allInstrumentIds = G_UserData:getBattleResource():getInstrumentIdsWithPos( unitData:getPos() )
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
function InstrumentDetailView:_onLeftIconClicked(pos)
	local iconData = TeamViewHelper.getHeroIconData()
	local info = iconData[pos] 

	local heroId = info.id
	local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
	self.curPos = unitData:getPos() --当前阵位
	self._allInstrumentIds = {}
	self._allInstrumentIds = G_UserData:getBattleResource():getInstrumentInfoWithPos(self.curPos)   

	local instrumentId = self._allInstrumentIds[self._selectedPos] 
	G_UserData:getInstrument():setCurInstrumentId(instrumentId)

	self:updateInfo()
end 
 
-- 左侧Icon红点刷新
function InstrumentDetailView:refreshLeftIconRedPoint(pos)
	if self._rangeType == InstrumentConst.INSTRUMENT_RANGE_TYPE_1 then  
		return
	end

	local getShowRedPoint = function ()  

		local instrumentId = G_UserData:getBattleResource():getResourceId(pos, 3, 1)
		if instrumentId then
			-- 养成红点
			local unitData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
			local reach1 = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE1, "slotRP", unitData)
			local reach2 = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE2, "slotRP", unitData)
			if reach1 or reach2 then
				return true
			end 

			-- 更换红点
			local pos = unitData:getPos()
			local slot = unitData:getSlot()
			if pos then
				local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
				local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
				local heroBaseId = heroUnitData:getBase_id()
				local param = {pos = pos, slot = slot, heroBaseId = heroBaseId}
				local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_INSTRUMENT, "slotRP", param)
				if reach then
					return true
				end 
			end	
		end
 
		return  false
	end
 
	self._leftIcons[pos]:showRedPoint( getShowRedPoint() ) 
end

function InstrumentDetailView:_updateHeroIconsSelectedState()
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

--点击装备回调 
function InstrumentDetailView:_onBtnInstrumentClick(slot)  

	--self._selectedPos = slot   
	local treasureId = G_UserData:getBattleResource():getResourceId(self.curPos, 3, self._selectedPos) 
	G_UserData:getInstrument():setCurInstrumentId(treasureId)
	self:updateInfo()
end

function InstrumentDetailView:_updateInfo2()
	self:_updatePageView()
	self:_updateHeroIconsSelectedState()

 
	InstrumentDetailBaseView = require("app.scene.view.instrumentDetail.InstrumentDetailBaseView2")
	if self._nodeInstrumentDetailView:getChildrenCount() > 0 then
		self._selectTabIndex = self._nodeInstrumentDetailView:getChildren()[1]:getTabSelect()
	end

	self._nodeInstrumentDetailView:removeAllChildren()
	local instrumentDetail = InstrumentDetailBaseView.new(self._instrumentData, self._rangeType, self)
	self._nodeInstrumentDetailView:addChild(instrumentDetail)

	-- 隐藏头像列表
	if self._rangeType == InstrumentConst.INSTRUMENT_RANGE_TYPE_1 then 
		self._listViewLineup:setVisible(false)
	end
end

function InstrumentDetailView:updateInfo()
	local instrumentId = G_UserData:getInstrument():getCurInstrumentId()
	self._instrumentData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
	self._buttonUnload:setVisible(self._instrumentData:isInBattle())
	self._buttonReplace:setVisible(self._instrumentData:isInBattle())
	self:_checkRedPoint()

	if Lang.checkUI("ui4") then   
		self:_updateInfo2()
		return
	end

	self._nodeInstrumentDetailView:removeAllChildren()
	local instrumentDetail = InstrumentDetailBaseView.new(self._instrumentData, self._rangeType, self)
	self._nodeInstrumentDetailView:addChild(instrumentDetail)
end

function InstrumentDetailView:_onButtonReplaceClicked()
	local curPos = self.curPos
	local heroId = G_UserData:getTeam():getHeroIdWithPos(curPos)
	local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
	local heroBaseId = heroUnitData:getBase_id()
	local instrumentId = G_UserData:getInstrument():getCurInstrumentId()
	local curInstrumentData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
	local result, noWear, wear = G_UserData:getInstrument():getReplaceInstrumentListWithSlot(curPos, heroBaseId)
	if #result == 0 then
		G_Prompt:showTip(Lang.get("instrument_empty_tip"))
	else
		local PopupChooseInstrumentHelper = require("app.ui.PopupChooseInstrumentHelper")
		local popup = require("app.ui.PopupChooseInstrument").new()
		local callBack = handler(self, self._onChooseInstrument)
		popup:setTitle(Lang.get("instrument_replace_title"))
		popup:updateUI(PopupChooseInstrumentHelper.FROM_TYPE2, callBack, result, self._buttonReplace, curInstrumentData) --_btnInstrumentShowRP
		popup:openWithAction()
	end

	-- G_SceneManager:popScene()
	-- local scene = G_SceneManager:getTopScene()
	-- if scene:getName() == "team" then
	-- 	local view = scene:getSceneView()
	-- 	view:setNeedPopupInstrumentReplace(self._btnReplaceShowRP)
	-- end
end

function InstrumentDetailView:_onChooseInstrument(instrumentId)
	local curPos = self.curPos
	G_UserData:getInstrument():c2sAddFightInstrument(curPos, instrumentId)
end

function InstrumentDetailView:_instrumentAddSuccess(eventName, id, pos, oldId)

	local scene = G_SceneManager:getTopScene()
	if scene:getName() == "team" then   
		return
	end

	self._allInstrumentIds = {} 
	self._allInstrumentIds = G_UserData:getBattleResource():getInstrumentInfoWithPos(pos)    
 
	--self._selectedPos = slot   
	local instrumentId = G_UserData:getBattleResource():getResourceId(pos, 3, self._selectedPos) 
	if G_UserData:getInstrument():getCurInstrumentId() == instrumentId then
		return
	end
	G_UserData:getInstrument():setCurInstrumentId(instrumentId)
	
	self:updateInfo() 
	self:_playInstrumentAddSummary(id, pos, oldId)
end

function InstrumentDetailView:_onEventRedPointUpdate(eventName, funcId)
	self:_checkRedPoint()
end

function InstrumentDetailView:_onButtonUnloadClicked()
	local pos = self._instrumentData:getPos()
	G_UserData:getInstrument():c2sClearFightInstrument(pos)
end

function InstrumentDetailView:_instrumentRemoveSuccess(eventName, slot)

	local len = 0
	self._allInstrumentIds = {}
	self._allInstrumentIds = G_UserData:getBattleResource():getInstrumentInfoWithPos(self.curPos)    
    for k, v in pairs(self._allInstrumentIds) do
		len = len + 1
		break
	end
	if len == 0 then    -- 无可展示装备
		G_SceneManager:popScene()
		local scene = G_SceneManager:getTopScene()
		if scene:getName() == "team" then
			local view = scene:getSceneView()
			view:setNeedInstrumentRemovePrompt(true)
		end
		return
	end 

	local instrumentId = self._allInstrumentIds[self._selectedPos]  -- 就一个神兵 不会执行
	G_UserData:getInstrument():setCurInstrumentId(instrumentId)

	self:updateInfo()
end

function InstrumentDetailView:getAllInstruments()
	return self._allInstrumentIds
end

function InstrumentDetailView:getAvatar()
	return self._avatar:getChildren()[1]:getChildren()[1] 
end

-- 获取当前选中武将阵位
function InstrumentDetailView:getCurPos()
    return self.curPos  
end

function InstrumentDetailView:setButtonVisible(bShow)
	return self._ButtonBg:setVisible(bShow)
end 

function InstrumentDetailView:_checkRedPoint()
	local pos = self._instrumentData:getPos()
	local slot = self._instrumentData:getSlot()
	if pos then
		local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
		local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
		local heroBaseId = heroUnitData:getBase_id()
		local param = {pos = pos, slot = slot, heroBaseId = heroBaseId}
		local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_INSTRUMENT, "slotRP", param)
		self._buttonReplace:showRedPoint(reach)
		self._btnReplaceShowRP = reach
	end
end

function InstrumentDetailView:changeBackground(resPath)
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

function InstrumentDetailView:getSelectTabIndex(bShow)  
	return self._selectTabIndex
end 

function InstrumentDetailView:getDetailViewNode()
	return self._nodeInstrumentDetailView
end

function InstrumentDetailView:getPageView()
	return self._pageView
end




------------------------------------------------------------ --播放神兵穿戴飘字
function InstrumentDetailView:_initEffectData()
	--播放神兵穿戴飘字
	if self._rangeType == InstrumentConst.INSTRUMENT_RANGE_TYPE_2 then
		self._allYokeData = {} --羁绊信息
		self._lastInstrumentLevel = {} --记录神兵升级等级,{[1] = {id, rLevel}, ...}

		self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst["FUNC_TEAM_SLOT" .. self.curPos ])
		self:_updateEffectData()
	end
end

function InstrumentDetailView:_updateEffectData()
	local curPos = self.curPos	--G_UserData:getTeam():getCurPos()
	local curHeroId = G_UserData:getTeam():getHeroIdWithPos(curPos)
	G_UserData:getHero():setCurHeroId(curHeroId)
	self._curHeroData = G_UserData:getHero():getUnitDataWithId(curHeroId)
 
	--self:_checkInstrumentIsShow()
	self._allYokeData = UserDataHelper.getHeroYokeInfo(self._curHeroData)
	self:_recordBaseAttr()
	G_UserData:getAttr():recordPowerWithKey(FunctionConst.FUNC_TEAM)
	--self:_recordMasterLevel()
end


--记录基础属性
function InstrumentDetailView:_recordBaseAttr()	
	local param = {
		heroUnitData = self._curHeroData
	}
	local attrInfo = UserDataHelper.getTotalAttr(param)
	self._recordAttr:updateData(attrInfo)
end

--播放神兵穿戴飘字
function InstrumentDetailView:_playInstrumentAddSummary(id, pos, oldId)
	self:_updateEffectData()
	local summary = {}

	local param1 = {
		content = oldId > 0 and Lang.get("summary_instrument_change_success") or Lang.get("summary_instrument_add_success"),
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
		-- anchorPoint = cc.p(0.5, 0.5),
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

	local instrumentId = G_UserData:getBattleResource():getResourceId(pos, 3, 1)
	local instrumentData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
	local instrumentBaseId = instrumentData:getBase_id()
	local allYokeData = self._allYokeData
	if allYokeData and allYokeData.yokeInfo then
		for i = 1, 6 do  
			local info = allYokeData.yokeInfo[i]
			if info and info.isActivated and info.fateType == 4 and isInYokeCondition(info.heroIds, instrumentBaseId) then --羁绊类型是神兵羁绊
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
					-- anchorPoint = cc.p(0.5, 0.5),
					-- dstPosition = UIHelper.convertSpaceFromNodeToNode(self["_textJiBanDes" .. i], self),
					-- finishCallback = function()
					-- 	self:_updateOneYoke(i)
					-- end
				}
				table.insert(summary, param)
			else
				--self:_updateOneYoke(i)
			end
		end
	end

	self:_addBaseAttrPromptSummary(summary)

	G_Prompt:showSummary(summary)
	--总战力
	G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_TEAM, UIConst.SUMMARY_OFFSET_X_TRAIN, -5)
end

--加入基础属性飘字内容
function InstrumentDetailView:_addBaseAttrPromptSummary(summary, pos)
	-- local curPos = pos or self.curPos --G_UserData:getTeam():getCurPos()
	-- for i, one in ipairs(RECORD_ATTR_LIST) do
 
	for i = 1, #RECORD_ATTR_LIST do
		local attrId = RECORD_ATTR_LIST[i][1]
		local diffValue = self._recordAttr:getDiffValue(attrId)
		if diffValue ~= 0 then
			local param = {
				content = AttrDataHelper.getPromptContent(attrId, diffValue),
				startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
			}
			table.insert(summary, param)
		end
	end

	-- local attrIds = self._recordAttr:getAllAttrIdsBySort()
	-- for i, attrId in ipairs(attrIds) do
	-- 	local diffValue = self._recordAttr:getDiffValue(attrId)
	-- 	if diffValue ~= 0 then
	-- 		local param = {
	-- 			content = AttrDataHelper.getPromptContent(attrId, diffValue),
	-- 			-- anchorPoint = cc.p(0.5, 0.5),
	-- 			startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
	-- 			-- dstPosition = dstNodeName and UIHelper.convertSpaceFromNodeToNode(self[dstNodeName], self) or nil,
	-- 			-- finishCallback = function()
	-- 			-- 	if attrId and dstNodeName then
	-- 			-- 		local curValue = self._recordAttr:getCurValue(attrId)
	-- 			-- 		self[dstNodeName]:getSubNodeByName("TextValue"):updateTxtValue(curValue)
	-- 			-- 	end
	-- 			-- end
	-- 		}
	-- 		table.insert(summary, param)
	-- 	end
	-- end

	return summary
end





return InstrumentDetailView

