--
-- Author: Liangxu
-- Date: 2017-05-09 10:06:57
--
local ViewBase = require("app.ui.ViewBase")
local TreasureDetailBaseView = class("TreasureDetailBaseView", ViewBase)
local UIHelper  = require("yoka.utils.UIHelper")
local RedPointHelper = require("app.data.RedPointHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local TreasureConst = require("app.const.TreasureConst")
local TreasureTrainHelper = require("app.scene.view.treasureTrain.TreasureTrainHelper")

local TreasureDetailStrengthenNode = require("app.scene.view.treasureDetail.TreasureDetailStrengthenNode2")
local TreasureDetailRefineNode = require("app.scene.view.treasureDetail.TreasureDetailRefineNode2")
local TreasureDetailYokeNode = require("app.scene.view.treasureDetail.TreasureDetailYokeNode2")
local TreasureDetailBriefNode = require("app.scene.view.treasureDetail.TreasureDetailBriefNode2")
local TreasureDetailJadeNode = require("app.scene.view.equipmentJade.TreasureDetailJadeNode2")
local TreasureDetailYokeModule = require("app.scene.view.treasureDetail.TreasureDetailYokeModule2")


TreasureDetailBaseView.BUTTON_INFO = 1             --信息
TreasureDetailBaseView.BUTTON_STRENG = 2           --强化  
TreasureDetailBaseView.BUTTON_REFINE = 3           --精炼 
TreasureDetailBaseView.BUTTON_JADE = 4     		   --镶嵌
TreasureDetailBaseView.BUTTON_LIMIT = 5            --界限

function TreasureDetailBaseView:ctor(treasureData, rangeType, parentView)
	self._textName 			= nil --宝物名称
	self._textFrom			= nil --装备于
	self._textPotential 	= nil --宝物品级
	self._listView 			= nil --宝物详情列表框

	self._treasureData 		= treasureData
	self._rangeType = rangeType
	self._parentView = parentView

	local resource = {
		file = Path.getCSB("TreasureDetailBaseView2", "treasure"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonInfo = {
				events = {{event = "touch", method = "_onButtonInfoClicked"}}
			},
			_buttonStreng = {
				events = {{event = "touch", method = "_onButtonStrengClicked"}}
			},
			_buttonRefine = {
				events = {{event = "touch", method = "_onButtonRefineClicked"}}
			},
			_buttonJade = {
				events = {{event = "touch", method = "_onButtonJadeClicked"}}
			},
			_buttonLimit = {
				events = {{event = "touch", method = "_onButtonLimitClicked"}}
			},
			_buttonPreview = {
				events = {{event = "touch", method = "_onButtonPreviewClicked"}}  -- 详情
			}
		}
	}
	if Lang.checkUI("ui4") then
		self:setName("TreasureDetailBaseView")
	end
	TreasureDetailBaseView.super.ctor(self, resource)
end

function TreasureDetailBaseView:onCreate()
	self._tabSelect = self._parentView:getSelectTabIndex() --nil  
end

function TreasureDetailBaseView:onEnter()
	self:_updateInfo()
end

function TreasureDetailBaseView:onExit()

end

function TreasureDetailBaseView:_updateInfo()
	self:onRefreshInfo()

	--详情列表
	--self:_updateListView()
	self:_updateBtnList()
end

function TreasureDetailBaseView:onRefreshInfo()
	local curTreasureId = G_UserData:getTreasure():getCurTreasureId()
	self._treasureData = G_UserData:getTreasure():getTreasureDataWithId(curTreasureId)
	local treasureData = self._treasureData
	local treasureBaseId = treasureData:getBase_id()
	local treasureParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_TREASURE, treasureBaseId)

	local heroUnitData = UserDataHelper.getHeroDataWithTreasureId(treasureData:getId())

	if heroUnitData == nil then
		self._textFrom:setVisible(false)
	else
		local baseId = heroUnitData:getBase_id()
		local limitLevel = heroUnitData:getLimit_level()
		local limitRedLevel = heroUnitData:getLimit_rtg()
		self._textFrom:setVisible(true)
		local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, baseId, nil, nil, limitLevel, limitRedLevel)
		self._textFrom:setString(Lang.get("treasure_detail_from", {name = heroParam.name}))
	end

	--名字
	local treasureName = treasureParam.name
	local rLevel = treasureData:getRefine_level()
	if rLevel > 0 then
		treasureName = treasureName.."+"..rLevel
	end
	self._textName:setString(treasureName)
	self._textName:setColor(treasureParam.icon_color)

	--品级
	self._textPotential:setString(Lang.get("treasure_detail_txt_potential", {value = treasureParam.potential}))
	self._textPotential:setColor(treasureParam.icon_color)
	self._textPotential:enableOutline(treasureParam.icon_color_outline, 2)
end

function TreasureDetailBaseView:_buildAttrModule()
	--强化属性
	local treasureData = self._treasureData

	local treasureDetailStrengthenNode = TreasureDetailStrengthenNode.new(treasureData, self._rangeType)
	self._listView:pushBackCustomItem(treasureDetailStrengthenNode)
end

function TreasureDetailBaseView:_buildRefineModule()
	--精炼属性
	local treasureData = self._treasureData

	local treasureDetailRefineNode = TreasureDetailRefineNode.new(treasureData, self._rangeType)
	self._listView:pushBackCustomItem(treasureDetailRefineNode)
end

function TreasureDetailBaseView:_buildYokeModule()
	--羁绊
	local treasureData = self._treasureData
	local yokeInfo = UserDataHelper.getTreasureYokeInfo(treasureData:getBase_id())
	if #yokeInfo > 0 then
		local treasureId = treasureData:getId()
		local treasureDetailYokeModule = TreasureDetailYokeModule.new(yokeInfo, treasureId)
		self._listView:pushBackCustomItem(treasureDetailYokeModule)
	end
end

function TreasureDetailBaseView:_buildBriefModule()
	--描述
	local treasureData = self._treasureData

	local treasureDetailBriefNode = TreasureDetailBriefNode.new(treasureData)
	self._listView:pushBackCustomItem(treasureDetailBriefNode)
end

function TreasureDetailBaseView:_buildJadeModule()
	local FunctionCheck = require("app.utils.logic.FunctionCheck")
	if FunctionCheck.funcIsShow(FunctionConst.FUNC_TREASURE_TRAIN_TYPE3) then
		if self._treasureData:getJadeSlotNums() > 0 then
			local equipData = self._treasureData
			local treasureDetailJadeNode = TreasureDetailJadeNode.new(equipData, self._rangeType)
			self._listView:pushBackCustomItem(treasureDetailJadeNode)
		end
	end
end


function TreasureDetailBaseView:_updateListView()
	if self._tabSelect == TreasureDetailBaseView.BUTTON_INFO then
		return
	end

	--详情List开始
	self._listView:removeAllChildren()
	
	if self._treasureData:isCanTrain() then
		--强化属性
		self:_buildAttrModule()

		--精炼属性
		self:_buildRefineModule()
	end
	--玉石
	self:_buildJadeModule()
	--羁绊
	self:_buildYokeModule()
	--简介
	self:_buildBriefModule()

	--self._listView:doLayout()
end


-------------------------------------------------------------------------------
function TreasureDetailBaseView:refreshAvatarAndUI()  -- bug: 1界限突破和UI未刷新
	local curTreasureId = G_UserData:getTreasure():getCurTreasureId()
	self._treasureData = G_UserData:getTreasure():getTreasureDataWithId(curTreasureId)

--	self._parentView:_updateData()  -- 界限突破后会修改petId
	self._parentView:_updatePageView()

 	self:onRefreshInfo()
	self:checkRedPoint()
end

function TreasureDetailBaseView:_updateBtnList()
	-- create name
	self._buttonInfo:setString(Lang.get("hero_team_tab_title"))
	self._tabList = {self._buttonStreng, self._buttonRefine, self._buttonJade, self._buttonLimit}
	
	--调整位置
	self:_doLayout() 

	self:checkRedPoint()
end

-- 调整按钮位置
function TreasureDetailBaseView:_doLayout()
	local showCount = 1 --信息默认显示
	local _posList = {522, 447, 373, 299, 225}  --分别对应对应序号的位置 

	-- 位置 + 控制显示
	self._buttonInfo:setPositionY(_posList[showCount])
	local tabData = TreasureTrainHelper.getShowTreasureTrainTab()
    if #tabData <= 0 then
        return
    end
	for index = 1, #self._tabList do
		self._tabList[index]:setVisible(false)
	end
 
	for index = 1, #tabData do
		self._tabList[index]:setString(Lang.get("equipment_train_tab_icon_"..index))
		self._tabList[index]:setVisible(true)
		showCount = showCount + 1
		self._tabList[index]:setPositionY(_posList[showCount])
	end
	
	self:_showInit()
end

function TreasureDetailBaseView:_showInit()
	local tabIndex = self._tabSelect
	local isExist1 = (self._tabSelect == TreasureDetailBaseView.BUTTON_STRENG and self._buttonStreng:isVisible() == false)
	local isExist2 = (self._tabSelect == TreasureDetailBaseView.BUTTON_REFINE and self._buttonRefine:isVisible() == false)
	local isExist3 = (self._tabSelect == TreasureDetailBaseView.BUTTON_LIMIT and self._buttonLimit:isVisible() == false)
	local isExist4 = (self._tabSelect == TreasureDetailBaseView.BUTTON_JADE and self._buttonJade:isVisible() == false) 

	if isExist1 or isExist2 or isExist3 or isExist4  then
		tabIndex = TreasureDetailBaseView.BUTTON_INFO
	end 

	self._tabSelect = nil
	if tabIndex == nil then
		tabIndex = TreasureDetailBaseView.BUTTON_INFO
	end
	local btnFunc = {  [TreasureDetailBaseView.BUTTON_INFO] = self._onButtonInfoClicked,
						[TreasureDetailBaseView.BUTTON_STRENG] = self._onButtonStrengClicked,
						[TreasureDetailBaseView.BUTTON_REFINE] = self._onButtonRefineClicked,
						[TreasureDetailBaseView.BUTTON_JADE] = self._onButtonJadeClicked,
						[TreasureDetailBaseView.BUTTON_LIMIT] = self._onButtonLimitClicked,
					} 
	btnFunc[tabIndex](self)
end

-- 调整按钮高亮
function TreasureDetailBaseView:_adjustBtnListHigh()
	if self._tabSelect == nil then
		self._buttonInfo:enableHighLightStyle(true)      
	else 	
		self._buttonInfo:enableHighLightStyle( (self._tabSelect == TreasureDetailBaseView.BUTTON_INFO and {true} or {false})[1] ) 
		self._buttonStreng:enableHighLightStyle( (self._tabSelect == TreasureDetailBaseView.BUTTON_STRENG and {true} or {false})[1] ) 
		self._buttonRefine:enableHighLightStyle( (self._tabSelect == TreasureDetailBaseView.BUTTON_REFINE and {true} or {false})[1] ) 
		self._buttonJade:enableHighLightStyle( (self._tabSelect == TreasureDetailBaseView.BUTTON_JADE and {true} or {false})[1] ) 
		self._buttonLimit:enableHighLightStyle( (self._tabSelect == TreasureDetailBaseView.BUTTON_LIMIT and {true} or {false})[1] ) 
	end  --完整三目运算符(a and {b} or {c})[1]  /  a and b or c
 
	if self._tabSelect ~= TreasureDetailBaseView.BUTTON_INFO  then
		self._listView:jumpToTop()
		self._listView:setDirection(ccui.ScrollViewDir.none)
		self._listView:setTouchEnabled(false)  
	else 
		self._listView:setDirection(ccui.ScrollViewDir.vertical)
		self._listView:setTouchEnabled(true)  
	end

	self._nodeJade:setVisible(false)          -- 镶嵌
	self._nodeDetail:setVisible(false) 		  -- 详情按钮 描述按钮
	self._nodeLimit:setVisible(false)         -- 界限
	self._parentView:setButtonVisible(false)  -- 隐藏更换和卸下按钮
	self._parentView:changeBackground()  	  -- 切换普通,镶嵌,界限背景图
	self:changeJadeZorder()		  			  -- 调整镶嵌界面的zorder 因为有块石头在列表上方
	self._parentView:changeDetailViewZorder() -- 调整层级_nodeTreasureDetailView
end

-- 红点相关
function TreasureDetailBaseView:checkRedPoint(nIndex)
	local treasureId = G_UserData:getTreasure():getCurTreasureId()
	local unitData = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
 
	self:_checkInfoRedPoint(unitData)
	if nIndex ~= nil then
		if self._tabList[nIndex] then
			local reach = RedPointHelper.isModuleSubReach(FunctionConst["FUNC_TREASURE_TRAIN_TYPE"..nIndex], "slotRP", unitData)
			self._tabList[nIndex]:showRedPoint(reach)
		end 
		return 
	end
	
	for index = 1, TreasureConst.TREASURE_TRAIN_LIMIT do
		if self._tabList[index] then
			local reach = RedPointHelper.isModuleSubReach(FunctionConst["FUNC_TREASURE_TRAIN_TYPE"..index], "slotRP", unitData)
			self._tabList[index]:showRedPoint(reach)
		end 
	end
	
 	-- 刷新左侧头像装备红点
	self._parentView:refreshLeftIconRedPoint(self._parentView:getCurPos()) 
 	-- 刷新4个装备状态(写在上层 不用每个类都处理)
	local scene = G_SceneManager:getTopScene()   
	scene:getSceneView():_updateTreasure()  
end

-- 策划需求：如果装备可更换时， 信息页签要显示红点
function TreasureDetailBaseView:_checkInfoRedPoint(unitData) 
	local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_TREASURE, "slotRP", {pos = unitData:getPos(), slot = unitData:getSlot()})
	self._buttonInfo:showRedPoint(reach)
end
 
-- 回调
function TreasureDetailBaseView:_onButtonInfoClicked()
	self:_updateListView()
	
	self._tabSelect = TreasureDetailBaseView.BUTTON_INFO 
	self:_adjustBtnListHigh()
	self._listView:doLayout()
	self._parentView:setButtonVisible(true)
end

function TreasureDetailBaseView:_onButtonStrengClicked()
	if self._tabSelect == TreasureDetailBaseView.BUTTON_STRENG then   
		return
	end

	self._tabSelect = TreasureDetailBaseView.BUTTON_STRENG    
	self:_adjustBtnListHigh() 
	self._listView:removeAllChildren()
	local TreasureTrainStrengthenLayer2 = require("app.scene.view.treasureTrain.TreasureTrainStrengthenLayer2")
	local Item = TreasureTrainStrengthenLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()
	Item:updateInfo() 
end

function TreasureDetailBaseView:_onButtonRefineClicked()
	if self._tabSelect == TreasureDetailBaseView.BUTTON_REFINE then   
		return
	end
  
	self._tabSelect = TreasureDetailBaseView.BUTTON_REFINE  
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local TreasureTrainRefineLayer2 = require("app.scene.view.treasureTrain.TreasureTrainRefineLayer2") 
	local Item = TreasureTrainRefineLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:updateInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏突破天赋描述，在刷新
end

function TreasureDetailBaseView:_onButtonJadeClicked()
	if self._tabSelect == TreasureDetailBaseView.BUTTON_JADE then   
		return
	end

	self._tabSelect = TreasureDetailBaseView.BUTTON_JADE    
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local TreasureTrainJadeLayer2 = require("app.scene.view.treasureTrain.TreasureTrainJadeLayer2")
	local Item = TreasureTrainJadeLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:updateInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏天赋描述，在刷新
end

function TreasureDetailBaseView:_onButtonLimitClicked()
	if self._tabSelect == TreasureDetailBaseView.BUTTON_LIMIT then   
		return
	end

	self._tabSelect = TreasureDetailBaseView.BUTTON_LIMIT    
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local TreasureTrainLimitLayer2 = require("app.scene.view.treasureTrain.TreasureTrainLimitLayer2")
	local Item = TreasureTrainLimitLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:updateInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏左侧道具
end

function TreasureDetailBaseView:getTabSelect()
	return self._tabSelect
end

function TreasureDetailBaseView:getEquipAvatar()
	if self._parentView then
		return self._parentView:getAvatar()
	end

	return nil
end

-- 详情
function TreasureDetailBaseView:_onButtonPreviewClicked()
	if self._tabSelect == TreasureDetailBaseView.BUTTON_LIMIT then
		local PopupTreasureLimitDetail = require("app.scene.view.treasureTrain.PopupTreasureLimitDetail")
		local treasureId = G_UserData:getTreasure():getCurTreasureId()
		local unitData = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
		local popup = PopupTreasureLimitDetail.new(unitData)
		popup:openWithAction()
	end
end

function TreasureDetailBaseView:getRangeType()
	return self._rangeType
end

-- 处理bug：调整镶嵌界面的zorder， 因为有块石头在列表上方 （没有直接写死  是不知道会不会影响到特效）
function TreasureDetailBaseView:changeJadeZorder(bChange)
	if bChange == nil then
		self._Panel_2:setLocalZOrder(1)
		self._Panel_5:setLocalZOrder(2)
		self._panelEffect:setLocalZOrder(4)
	else  
		self._panelEffect:setLocalZOrder(2)
		self._Panel_5:setLocalZOrder(3)
	end
end


return TreasureDetailBaseView