-- i18n ja 
-- Author: hedl
-- Date: 2017-04-20 16:46:24
-- 装备详情
local ViewBase = require("app.ui.ViewBase")
local EquipDetailBaseView = class("EquipDetailBaseView", ViewBase)
local UIHelper = require("yoka.utils.UIHelper")
local EquipConst = require("app.const.EquipConst")
local UserDataHelper = require("app.utils.UserDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local EquipTrainHelper = require("app.scene.view.equipTrain.EquipTrainHelper")
local TeamViewHelper = require("app.scene.view.team.TeamViewHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local FunctionCheck = require("app.utils.logic.FunctionCheck")
local RedPointHelper = require("app.data.RedPointHelper")

local EquipDetailStrengthenNode = require("app.scene.view.equipmentDetail.EquipDetailStrengthenNode2")
local EquipDetailSuitNode = require("app.scene.view.equipmentDetail.EquipDetailSuitNode2")
local EquipDetailRefineNode = require("app.scene.view.equipmentDetail.EquipDetailRefineNode2")
local EquipDetailBriefNode = require("app.scene.view.equipmentDetail.EquipDetailBriefNode2")
local EquipDetailJadeNode = require("app.scene.view.equipmentJade.EquipDetailJadeNode2")


EquipDetailBaseView.BUTTON_INFO = 1          	--信息
EquipDetailBaseView.BUTTON_STRENG = 2           --强化  
EquipDetailBaseView.BUTTON_REFINE = 3           --精炼 
EquipDetailBaseView.BUTTON_JADE = 4     		--镶嵌
EquipDetailBaseView.BUTTON_LIMIT = 5            --界限


function EquipDetailBaseView:ctor(equipData, rangeType, parentView)
	self._textName = nil --装备名称
	self._textPotential = nil --装备品级
	self._listView = nil --装备详情列表框

	self._equipData = equipData
	self._rangeType = rangeType or EquipConst.EQUIP_RANGE_TYPE_1
	self._parentView = parentView

	local resource = {
		file = Path.getCSB("EquipDetailBaseView2", "equipment"),
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
		self:setName("EquipDetailBaseView")
	end
	EquipDetailBaseView.super.ctor(self, resource)
end

function EquipDetailBaseView:onCreate()
	self._tabSelect = self._parentView:getSelectTabIndex() --nil  
	-- i18n pos lable
	self:_dealPosI18n()
	self:updateInfor()
end

function EquipDetailBaseView:onEnter()
end

function EquipDetailBaseView:onExit()
end

function EquipDetailBaseView:onRefreshInfo()
	local curEquipId = G_UserData:getEquipment():getCurEquipId()
	self._equipData = G_UserData:getEquipment():getEquipmentDataWithId(curEquipId)

	local equipData = self._equipData
	local equipBaseId = equipData:getBase_id()
	local equipParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_EQUIPMENT, equipBaseId)

	--名字
	local equipName = equipParam.name
	local rLevel = equipData:getR_level()
	if rLevel > 0 then
		equipName = equipName .. "+" .. rLevel
	end
	self._textName:setString(equipName)
	self._textName:setColor(equipParam.icon_color)


	local heroUnitData = UserDataHelper.getHeroDataWithEquipId(equipData:getId())
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

	--品级
	self._textPotential:setString(Lang.get("equipment_detail_txt_potential", {value = equipParam.potential}))
	self._textPotential:setColor(equipParam.icon_color)
	self._textPotential:enableOutline(equipParam.icon_color_outline, 2)
end

function EquipDetailBaseView:updateInfor()

	self:onRefreshInfo()

	--详情列表
	-- self._listView:removeAllItems()
	-- self:_updateListView()
	self:_updateBtnList()
end

--强化属性
function EquipDetailBaseView:_buildAttrModule()
	local equipData = self._equipData
	local equipDetailStrengthenNode = EquipDetailStrengthenNode.new(equipData, self._rangeType)
	self._listView:pushBackCustomItem(equipDetailStrengthenNode)
end

--套装信息
function EquipDetailBaseView:_buildSuitModule()
	local equipData = self._equipData

	local suitId = equipData:getConfig().suit_id
	if suitId > 0 and equipData:isInBattle() then --有套装信息
		local equipDetailSuitNode = EquipDetailSuitNode.new(equipData, true)
		self._listView:pushBackCustomItem(equipDetailSuitNode)
	end
end

--精炼属性
function EquipDetailBaseView:_buildRefineModule()
	local equipData = self._equipData
	local equipDetailRefineNode = EquipDetailRefineNode.new(equipData, self._rangeType)
	self._listView:pushBackCustomItem(equipDetailRefineNode)
end

--描述
function EquipDetailBaseView:_buildBriefModule()
	local equipData = self._equipData
	local equipDetailBriefNode = EquipDetailBriefNode.new(equipData)
	self._listView:pushBackCustomItem(equipDetailBriefNode)
end

function EquipDetailBaseView:_buildJadeModule()
	local FunctionCheck = require("app.utils.logic.FunctionCheck")
	if FunctionCheck.funcIsShow(FunctionConst.FUNC_EQUIP_TRAIN_TYPE3) then
		local EquipTrainHelper = require("app.scene.view.equipTrain.EquipTrainHelper")
		if EquipTrainHelper.canLimitUp(self._equipData:getBase_id()) then
			local equipData = self._equipData
			local equipDetailJadeNode = EquipDetailJadeNode.new(equipData, self._rangeType)
			self._listView:pushBackCustomItem(equipDetailJadeNode)
		end
	end
end

function EquipDetailBaseView:_updateListView()
	if self._tabSelect == EquipDetailBaseView.BUTTON_INFO then
		return
	end

	--详情List开始
	self._listView:removeAllChildren()
	--属性
	self:_buildAttrModule()
	--套装信息
	self:_buildSuitModule()
	--精炼属性
	self:_buildRefineModule()
	--玉石
	self:_buildJadeModule()
	--简介
	self:_buildBriefModule()

--	self._listView:doLayout()
end
 
-- 一键强化
function EquipDetailBaseView:oneKeyUpdateListView()
	self._listView:removeAllChildren()
	
	--属性
	self:_buildAttrModule()
	--套装信息
	self:_buildSuitModule()
	--精炼属性
	self:_buildRefineModule()
	--玉石
	self:_buildJadeModule()
	--简介
	self:_buildBriefModule()

	self._listView:doLayout()
end

-------------------------------------------------------------------------------
function EquipDetailBaseView:refreshAvatarAndUI()  -- bug: 1界限突破和UI未刷新
	local curEquipId = G_UserData:getEquipment():getCurEquipId()
	self._equipData = G_UserData:getEquipment():getEquipmentDataWithId(curEquipId)

--	self._parentView:_updateData()  -- 界限突破后会修改petId
	self._parentView:_updatePageView()

 	self:onRefreshInfo()
	self:checkRedPoint()
end

function EquipDetailBaseView:_updateBtnList()
	-- create name
	self._buttonInfo:setString(Lang.get("hero_team_tab_title"))
	self._tabList = {self._buttonStreng, self._buttonRefine, self._buttonJade, self._buttonLimit}
	
	--调整位置
	self:_doLayout() 

	self:checkRedPoint()
end

-- 调整按钮位置
function EquipDetailBaseView:_doLayout()
	local showCount = 1 --信息默认显示
	local _posList = {522, 447, 373, 299, 225}  --分别对应对应序号的位置

	-- 位置 + 控制显示
	self._buttonInfo:setPositionY(_posList[showCount])
    local tabData = EquipTrainHelper.getShowEquipTrainTab()
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

function EquipDetailBaseView:_showInit()
	local tabIndex = self._tabSelect
	local isExist1 = (self._tabSelect == EquipDetailBaseView.BUTTON_STRENG and self._buttonStreng:isVisible() == false)
	local isExist2 = (self._tabSelect == EquipDetailBaseView.BUTTON_REFINE and self._buttonRefine:isVisible() == false)
	local isExist3 = (self._tabSelect == EquipDetailBaseView.BUTTON_LIMIT and self._buttonLimit:isVisible() == false)
	local isExist4 = (self._tabSelect == EquipDetailBaseView.BUTTON_JADE and self._buttonJade:isVisible() == false) 

	if isExist1 or isExist2 or isExist3 or isExist4  then
		tabIndex = EquipDetailBaseView.BUTTON_INFO
	end 

	self._tabSelect = nil
	if tabIndex == nil then
		tabIndex = EquipDetailBaseView.BUTTON_INFO
	end
	local btnFunc = {  [EquipDetailBaseView.BUTTON_INFO] = self._onButtonInfoClicked,
						[EquipDetailBaseView.BUTTON_STRENG] = self._onButtonStrengClicked,
						[EquipDetailBaseView.BUTTON_REFINE] = self._onButtonRefineClicked,
						[EquipDetailBaseView.BUTTON_JADE] = self._onButtonJadeClicked,
						[EquipDetailBaseView.BUTTON_LIMIT] = self._onButtonLimitClicked,
					} 
	btnFunc[tabIndex](self)
end

-- 调整按钮高亮
function EquipDetailBaseView:_adjustBtnListHigh()
	if self._tabSelect == nil then
		self._buttonInfo:enableHighLightStyle(true)      
	else 	
		self._buttonInfo:enableHighLightStyle( (self._tabSelect == EquipDetailBaseView.BUTTON_INFO and {true} or {false})[1] ) 
		self._buttonStreng:enableHighLightStyle( (self._tabSelect == EquipDetailBaseView.BUTTON_STRENG and {true} or {false})[1] ) 
		self._buttonRefine:enableHighLightStyle( (self._tabSelect == EquipDetailBaseView.BUTTON_REFINE and {true} or {false})[1] ) 
		self._buttonJade:enableHighLightStyle( (self._tabSelect == EquipDetailBaseView.BUTTON_JADE and {true} or {false})[1] ) 
		self._buttonLimit:enableHighLightStyle( (self._tabSelect == EquipDetailBaseView.BUTTON_LIMIT and {true} or {false})[1] ) 
	end  --完整三目运算符(a and {b} or {c})[1]  /  a and b or c
 
	if self._tabSelect ~= EquipDetailBaseView.BUTTON_INFO  then
		self._listView:jumpToTop()
		self._listView:setDirection(ccui.ScrollViewDir.none)
		self._listView:setTouchEnabled(false)  
	else 
		self._listView:setDirection(ccui.ScrollViewDir.vertical)
		self._listView:setTouchEnabled(true)  
	end

	self._nodeDetail:setVisible(false) 		-- 详情按钮 描述按钮
	self._nodeJade:setVisible(false)   		-- 镶嵌
	self._nodeLimit:setVisible(false)  		-- 界限 _nodeFire “我预问鼎天下 试问谁与争锋”特效     _nodeHetiMoving 成功后特效  _nodeBgMoving 背景后火星特效  _nodePopup 黑圈圈父节点
	self._parentView:setButtonVisible(false)-- 隐藏更换，卸下按钮
	self._parentView:changeBackground()  	-- 切换普通,界限背景图
	self._parentView:changeDetailViewZorder()-- 调整层级_nodeTreasureDetailView
	self._parentView:refreshOnKeyButton(self._tabSelect)
end

-- 红点相关
function EquipDetailBaseView:checkRedPoint()   
	local curEquipId = G_UserData:getEquipment():getCurEquipId()
	self._equipData = G_UserData:getEquipment():getEquipmentDataWithId(curEquipId)  -- 刷新数据

	self:_checkInfoRedPoint()
	self:_checkStrengRedPoint()
	self:_checkRefineRedPoint()
	self:_checkJadeRedPoint()
	self:_checkLimitRedPoint()
	
 	-- 刷新左侧当前的武将红点
	self._parentView:refreshLeftIconRedPoint(self._parentView:getCurPos()) 
	-- 刷新4个装备状态(写在上层 不用每个类都处理)
	local scene = G_SceneManager:getTopScene()   
    scene:getSceneView():_updateEquipment()  
end

-- 策划需求：如果装备可更换时， 信息页签要显示红点
function EquipDetailBaseView:_checkInfoRedPoint() 
	local unitData = self._equipData
	local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP, "slotRP", {pos = unitData:getPos(), slot = unitData:getSlot()}) -- 更换红点
	self._buttonInfo:showRedPoint(reach)
end

function EquipDetailBaseView:_checkStrengRedPoint() 
	local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP_TRAIN_TYPE1, "slotRP", self._equipData)
	self._tabList[1]:showRedPoint(reach)
end

function EquipDetailBaseView:_checkRefineRedPoint()
	local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_EQUIP_TRAIN_TYPE2, "slotRP", self._equipData)
	self._tabList[2]:showRedPoint(reach)

end

function EquipDetailBaseView:_checkJadeRedPoint()
	local isOpen = LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_EQUIP_TRAIN_TYPE3)
	local isRed = EquipTrainHelper.needJadeRedPoint(G_UserData:getEquipment():getCurEquipId()) and isOpen
	self._tabList[3]:showRedPoint(isRed)
end

function EquipDetailBaseView:_checkLimitRedPoint( ) 
	local isOpen = LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_EQUIP_TRAIN_TYPE4)
	local isRed = EquipTrainHelper.isNeedRedPoint() and isOpen
	self._tabList[4]:showRedPoint(isRed)
end

-- 回调
function EquipDetailBaseView:_onButtonInfoClicked()
	self:_updateListView()
	
	self._tabSelect = EquipDetailBaseView.BUTTON_INFO 
	self:_adjustBtnListHigh()
	self._listView:doLayout()
	self._parentView:setButtonVisible(true)
end

function EquipDetailBaseView:_onButtonStrengClicked()
	if self._tabSelect == EquipDetailBaseView.BUTTON_STRENG then   
		return
	end

	self._tabSelect = EquipDetailBaseView.BUTTON_STRENG    
	self:_adjustBtnListHigh() 
	self._listView:removeAllChildren()
	local EquipTrainStrengthenLayer2 = require("app.scene.view.equipTrain.EquipTrainStrengthenLayer2")
	local Item = EquipTrainStrengthenLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()
	Item:updateInfo() 
end

function EquipDetailBaseView:_onButtonRefineClicked()
	if self._tabSelect == EquipDetailBaseView.BUTTON_REFINE then   
		return
	end
  
	self._tabSelect = EquipDetailBaseView.BUTTON_REFINE  
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local EquipTrainRefineLayer2 = require("app.scene.view.equipTrain.EquipTrainRefineLayer2")
	local Item = EquipTrainRefineLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:updateInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏突破天赋描述，在刷新
end

function EquipDetailBaseView:_onButtonJadeClicked()
	if self._tabSelect == EquipDetailBaseView.BUTTON_JADE then   
		return
	end

	self._tabSelect = EquipDetailBaseView.BUTTON_JADE    
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local EquipTrainJadeLayer2 = require("app.scene.view.equipTrain.EquipTrainJadeLayer2") 
	local Item = EquipTrainJadeLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:updateInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏天赋描述，在刷新
end

function EquipDetailBaseView:_onButtonLimitClicked()
	if self._tabSelect == EquipDetailBaseView.BUTTON_LIMIT then   
		return
	end

	self._tabSelect = EquipDetailBaseView.BUTTON_LIMIT    
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local EquipTrainLimitLayer2 = require("app.scene.view.equipTrain.EquipTrainLimitLayer2") 
	local Item = EquipTrainLimitLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:updateInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏左侧道具
end

function EquipDetailBaseView:getTabSelect()
	return self._tabSelect
end

function EquipDetailBaseView:getEquipAvatar()
	if self._parentView then
		return self._parentView:getAvatar()
	end

	return nil
end

-- 详情
function EquipDetailBaseView:_onButtonPreviewClicked()

	if self._tabSelect == EquipDetailBaseView.BUTTON_LIMIT then
		local equipTrainLimitLayer = ccui.Helper:seekNodeByName(G_SceneManager:getRunningScene(), "EquipTrainLimitLayer")
		if equipTrainLimitLayer.onButtonDetail then
			equipTrainLimitLayer:onButtonDetail()
		end
	end
end

-- i18n pos lable
function EquipDetailBaseView:_dealPosI18n()
	if Lang.checkLang(Lang.JA) then
		return 
	end

	if not Lang.checkLang(Lang.CN) then
		self._textDetailName:setFontSize(
			self._textDetailName:getFontSize()-2
		)
	end
end

 


return EquipDetailBaseView