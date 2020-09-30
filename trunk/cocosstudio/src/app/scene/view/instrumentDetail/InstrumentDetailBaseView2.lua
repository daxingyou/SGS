--
-- Author: Liangxu
-- Date: 2017-9-16 10:22:34
--
local ViewBase = require("app.ui.ViewBase")
local InstrumentDetailBaseView = class("InstrumentDetailBaseView", ViewBase)
local InstrumentDetailAttrNode = require("app.scene.view.instrumentDetail.InstrumentDetailAttrNode2")
local InstrumentDetailBriefNode = require("app.scene.view.instrumentDetail.InstrumentDetailBriefNode2")
local InstrumentDetailYokeNode = require("app.scene.view.instrumentDetail.InstrumentDetailYokeNode2")
local InstrumentDetailFeatureNode = require("app.scene.view.instrumentDetail.InstrumentDetailFeatureNode2")
local InstrumentDetailTalentNode = require("app.scene.view.instrumentDetail.InstrumentDetailTalentNode2")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local UIHelper = require("yoka.utils.UIHelper")
local RedPointHelper = require("app.data.RedPointHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
 
 
InstrumentDetailBaseView.BUTTON_INFO = 1             --信息
InstrumentDetailBaseView.BUTTON_ADVANCE = 2          --进阶     
InstrumentDetailBaseView.BUTTON_LIMIT = 3            --界限

function InstrumentDetailBaseView:ctor(instrumentData, rangeType, parentView)
	self._textName 			= nil --神兵名称
	self._textFrom			= nil --装备于
	--self._textDetailName 	= nil --神兵详情头部的名称
	self._listView 			= nil --神兵详情列表框

	self._instrumentData 		= instrumentData
	self._rangeType = rangeType
	self._parentView = parentView

	local resource = {
		file = Path.getCSB("InstrumentDetailBaseView2", "instrument"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonInfo = {
				events = {{event = "touch", method = "_onButtonInfoClicked"}}
			},
			_buttonAdvance = {
				events = {{event = "touch", method = "_onButtonAdvanceClicked"}}
			},
			_buttonLimit = {
				events = {{event = "touch", method = "_onButtonLimitClicked"}}
			},
			_buttonPreview = {
				events = {{event = "touch", method = "_onButtonPreviewClicked"}}  -- 界限 涅磐详情
			}
		}
	}
	InstrumentDetailBaseView.super.ctor(self, resource)
end

function InstrumentDetailBaseView:onCreate()
	self._tabSelect = self._parentView:getSelectTabIndex() --nil  

 	-- 调整字号
	ccui.Helper:seekNodeByName(self._buttonAdvance, "Text"):setFontSize(19) 
end

function InstrumentDetailBaseView:onEnter()
	self:_updateInfo()
end

function InstrumentDetailBaseView:onExit()

end

function InstrumentDetailBaseView:onRefreshInfo()
	local curInstrumentId = G_UserData:getInstrument():getCurInstrumentId()
	self._instrumentData = G_UserData:getInstrument():getInstrumentDataWithId(curInstrumentId)

	local instrumentData = self._instrumentData
	local instrumentBaseId = instrumentData:getBase_id()
	local limitLevel = instrumentData:getLimit_level()
	local instrumentParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_INSTRUMENT, instrumentBaseId, nil, nil, limitLevel)

	local heroBaseId = UserDataHelper.getHeroBaseIdWithInstrumentId(instrumentData:getId())
	if heroBaseId == nil then
		self._textFrom:setVisible(false)
	else
		self._textFrom:setVisible(true)
		local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)
		self._textFrom:setString(Lang.get("instrument_detail_from", {name = heroParam.name}))
	end

	--名字
	local instrumentName = instrumentParam.name
	local level = instrumentData:getLevel()
	if level > 0 then
		instrumentName = instrumentName.."+"..level
	end
	self._textName:setString(instrumentName)
	self._textName:setColor(instrumentParam.icon_color)
	self._textName:setFontSize(20)
end

function InstrumentDetailBaseView:_updateInfo()
 
	self:onRefreshInfo()

	--详情列表
	--self:_updateListView()
	self:_updateBtnList()

	-- 天赋描述
	self._advanceDesPlane:addClickEventListenerEx(handler(self, self._onButtonAdvanceTalentDesPlaneClicked)) 
end

function InstrumentDetailBaseView:_updateListView()
	if self._tabSelect == InstrumentDetailBaseView.BUTTON_INFO then
		return
	end

	--详情List开始
	self._listView:removeAllChildren()

	--属性
	self:_buildAttrModule()
	--羁绊
	self:_buildYokeModule()
	--特性
	self:_buildFeatureModule()
	--天赋
	self:_buildTalentModule()
	--简介
	self:_buildBriefModule()
end

function InstrumentDetailBaseView:_buildAttrModule()
	local item = InstrumentDetailAttrNode.new(self._instrumentData, self._rangeType)
	self._listView:pushBackCustomItem(item)
end

function InstrumentDetailBaseView:_buildYokeModule()
	local item = InstrumentDetailYokeNode.new(self._instrumentData)
	self._listView:pushBackCustomItem(item)
end

function InstrumentDetailBaseView:_buildFeatureModule()
	local item = InstrumentDetailFeatureNode.new(self._instrumentData)
	self._listView:pushBackCustomItem(item)
end

function InstrumentDetailBaseView:_buildTalentModule()
	local item = InstrumentDetailTalentNode.new(self._instrumentData)
	self._listView:pushBackCustomItem(item)
end

function InstrumentDetailBaseView:_buildBriefModule()
	local item = InstrumentDetailBriefNode.new(self._instrumentData)
	self._listView:pushBackCustomItem(item)
end


-------------------------------------------------------------------------------
function InstrumentDetailBaseView:refreshAvatarAndUI()  -- bug: 1界限突破和UI未刷新
	local curInstrumentId = G_UserData:getInstrument():getCurInstrumentId()
	self._instrumentData = G_UserData:getInstrument():getInstrumentDataWithId(curInstrumentId)
--	self._parentView:_updateData()  -- 界限突破后会修改petId
	self._parentView:_updatePageView()

 	self:onRefreshInfo()
	self:checkRedPoint()
end

function InstrumentDetailBaseView:_updateBtnList()
	self._tabList = {self._buttonAdvance, self._buttonLimit}

	-- create name
	self._buttonInfo:setString(Lang.get("hero_team_tab_title"))
	for i = 1, 2 do
		local txt = Lang.get("instrument_train_tab_icon_"..i)
		self._tabList[i]:setString(txt)
	end
 
	
	--调整位置
	self:_doLayout() 

	self:checkRedPoint()
end

-- 调整按钮位置
function InstrumentDetailBaseView:_doLayout()
	local showCount = 1 --信息默认显示
	local _posList = {522, 447, 373, 299, 225}  --分别对应对应序号的位置

	-- 位置 + 控制显示
	self._buttonInfo:setPositionY(_posList[showCount])
	showCount = showCount + 1
	self._buttonAdvance:setPositionY(_posList[showCount])
	
	local isOpen = LogicCheckHelper.funcIsShow(FunctionConst["FUNC_INSTRUMENT_TRAIN_TYPE"..2]) -- 界限：金色武将的神兵无界限(已是最高)
	local curInstrumentId = G_UserData:getInstrument():getCurInstrumentId()
	local curUnitData = G_UserData:getInstrument():getInstrumentDataWithId(curInstrumentId)
	local canLimit = curUnitData:isCanLimitBreak()
	local isShow = curUnitData:getLimitFuncShow()
	isOpen = isShow and canLimit
	self._tabList[2]:setVisible(isOpen)
	if isOpen then
		showCount = showCount + 1
		self._tabList[2]:setPositionY(_posList[showCount])
	end

	self:_showInit()
end

function InstrumentDetailBaseView:_showInit() 
	local tabIndex = self._tabSelect
	local isExist1 = (self._tabSelect == InstrumentDetailBaseView.BUTTON_ADVANCE and self._buttonAdvance:isVisible() == false)
	local isExist2 = (self._tabSelect == InstrumentDetailBaseView.BUTTON_LIMIT and self._buttonLimit:isVisible() == false)

	if isExist1 or isExist2  then
		tabIndex = InstrumentDetailBaseView.BUTTON_INFO
	end 

	self._tabSelect = nil
	if tabIndex == nil then
		tabIndex = InstrumentDetailBaseView.BUTTON_INFO
	end
	local btnFunc = {  [InstrumentDetailBaseView.BUTTON_INFO] = self._onButtonInfoClicked,
						[InstrumentDetailBaseView.BUTTON_ADVANCE] = self._onButtonAdvanceClicked,
						[InstrumentDetailBaseView.BUTTON_LIMIT] = self._onButtonLimitClicked,
					} 
	btnFunc[tabIndex](self)
end

-- 调整按钮高亮
function InstrumentDetailBaseView:_adjustBtnListHigh()
	if self._tabSelect == nil then
		self._buttonInfo:enableHighLightStyle(true)      
	else 	
		self._buttonInfo:enableHighLightStyle( (self._tabSelect == InstrumentDetailBaseView.BUTTON_INFO and {true} or {false})[1] ) 
		self._buttonAdvance:enableHighLightStyle( (self._tabSelect == InstrumentDetailBaseView.BUTTON_ADVANCE and {true} or {false})[1] ) 
		self._buttonLimit:enableHighLightStyle( (self._tabSelect == InstrumentDetailBaseView.BUTTON_LIMIT and {true} or {false})[1] ) 
	end  --完整三目运算符(a and {b} or {c})[1]  /  a and b or c
 
	if self._tabSelect ~= InstrumentDetailBaseView.BUTTON_INFO  then
		self._listView:jumpToTop()
		self._listView:setDirection(ccui.ScrollViewDir.none)
		self._listView:setTouchEnabled(false)  
	else 
		self._listView:setDirection(ccui.ScrollViewDir.vertical)
		self._listView:setTouchEnabled(true)  
	end

	self._nodeDetail:setVisible(false) 		  -- 详情按钮 描述按钮
	self._nodeLimit:setVisible(false)         -- 界限
	self._nodeAdvance:setVisible(false)       -- 升级
	self._parentView:setButtonVisible(false)  -- 隐藏更换和卸下按钮
	self._parentView:changeBackground()  	  -- 切换普通,界限背景图
	self:changeInstrumentZorder()		  	  -- 调整界限突破后的zorder 因为有那nodeFire在最上方了
end
 

function InstrumentDetailBaseView:checkRedPoint(nIndex)
	local instrumentId = G_UserData:getInstrument():getCurInstrumentId()
	local unitData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)

	--策划大大需求： 不用国服和越南红点逻辑
	local reach1 = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE1, "slotRP", unitData)
	self._tabList[1]:showRedPoint(reach1)
	local reach2 = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_INSTRUMENT_TRAIN_TYPE2, "slotRP", unitData)
	self._tabList[2]:showRedPoint(reach2)

	-- -- 老的国服红点规则
	-- if nIndex ~= nil then
	-- 	if self._tabList[nIndex] then
	-- 		local reach = RedPointHelper.isModuleReach(FunctionConst["FUNC_INSTRUMENT_TRAIN_TYPE"..nIndex], unitData)
	-- 		self._tabList[nIndex]:showRedPoint(reach)
	-- 	end 
	-- 	return 
	-- end

	-- local InstrumentConst = require("app.const.InstrumentConst")
	-- for index = 1, InstrumentConst.INSTRUMENT_TRAIN_LIMIT do 
	-- 	if self._tabList[index] then
	-- 		local reach = RedPointHelper.isModuleReach(FunctionConst["FUNC_INSTRUMENT_TRAIN_TYPE"..index], unitData)
	-- 		self._tabList[index]:showRedPoint(reach)
	-- 	end 
	-- end

	-- 刷新当前装备红点
	self._parentView:refreshLeftIconRedPoint(self._parentView:getCurPos()) 
end

-- 回调
function InstrumentDetailBaseView:_onButtonInfoClicked()
	self:_updateListView()
	
	self._tabSelect = InstrumentDetailBaseView.BUTTON_INFO 
	self:_adjustBtnListHigh()
	self._listView:doLayout()
	self._parentView:setButtonVisible(true)  
end

function InstrumentDetailBaseView:_onButtonAdvanceClicked()
	if self._tabSelect == InstrumentDetailBaseView.BUTTON_ADVANCE then   
		return
	end

	self._tabSelect = InstrumentDetailBaseView.BUTTON_ADVANCE    
	self:_adjustBtnListHigh() 
	self._listView:removeAllChildren()
	local InstrumentTrainAdvanceLayer2 = require("app.scene.view.instrumentTrain.InstrumentTrainAdvanceLayer2")
	local Item = InstrumentTrainAdvanceLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()
	Item:updateInfo() 
end

function InstrumentDetailBaseView:_onButtonLimitClicked()
	if self._tabSelect == InstrumentDetailBaseView.BUTTON_LIMIT then   
		return
	end

	self._tabSelect = InstrumentDetailBaseView.BUTTON_LIMIT    
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local InstrumentTrainLimitLayer2 = require("app.scene.view.instrumentTrain.InstrumentTrainLimitLayer2") 
	local Item = InstrumentTrainLimitLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:updateInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏左侧道具
end

function InstrumentDetailBaseView:getTabSelect()
	return self._tabSelect
end

-- 界限 涅磐详情
function InstrumentDetailBaseView:_onButtonPreviewClicked()
	if self._tabSelect == InstrumentDetailBaseView.BUTTON_LIMIT then
		local PopupInstrumentLimitDetail = require("app.scene.view.instrumentTrain.PopupInstrumentLimitDetail")
		local instrumentId = G_UserData:getInstrument():getCurInstrumentId()
		local instrumentUnitData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
		local popup = PopupInstrumentLimitDetail.new(instrumentUnitData)
		popup:openWithAction()
	end
end

function InstrumentDetailBaseView:getAllInstrumentIds()
	return self._parentView:getAllInstruments()
end

function InstrumentDetailBaseView:getRangeType()
	return self._rangeType
end

function InstrumentDetailBaseView:getInstrumentAvatar()
	if self._parentView then
		return self._parentView:getAvatar()
	end

	return nil
end

function InstrumentDetailBaseView:_onButtonAdvanceTalentDesPlaneClicked()
	self._nodeTalentDes:setVisible( false )
end

function InstrumentDetailBaseView:getTalentDes(bShow)
	return self._nodeTalentDes 
end

function InstrumentDetailBaseView:getParentNode(bShow)
	if self._parentView then
		return self._parentView 
	end

	return nil
end

-- 处理bug：调整ListView与Effect的层级 
function InstrumentDetailBaseView:changeInstrumentZorder(bChange)
	if bChange == nil then
		self._Panel_2:setLocalZOrder(1)
		self._Panel_5:setLocalZOrder(2)
		self._panelEffect:setLocalZOrder(4)
	else  
		self._panelEffect:setLocalZOrder(2)
		self._Panel_5:setLocalZOrder(3)
	end
end

return InstrumentDetailBaseView