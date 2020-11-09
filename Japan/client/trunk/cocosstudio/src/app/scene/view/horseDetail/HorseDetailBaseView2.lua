--
-- Author: Liangxu
-- Date: 2018-8-29
--
local ViewBase = require("app.ui.ViewBase")
local HorseDetailBaseView = class("HorseDetailBaseView", ViewBase)
local HorseDetailAttrNode = require("app.scene.view.horseDetail.HorseDetailAttrNode2")
local HorseDetailSkillNode = require("app.scene.view.horseDetail.HorseDetailSkillNode2")
local HorseDetailRideNode = require("app.scene.view.horseDetail.HorseDetailRideNode2")
local HorseDetailBriefNode = require("app.scene.view.horseDetail.HorseDetailBriefNode2")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local HorseDataHelper = require("app.utils.data.HorseDataHelper")
local HorseConst = require("app.const.HorseConst")
local RedPointHelper = require("app.data.RedPointHelper")

HorseDetailBaseView.BUTTON_INFO = 1          	--信息
HorseDetailBaseView.BUTTON_UPSTAR = 2           --升阶    

function HorseDetailBaseView:ctor(horseData, rangeType, recordAttr, horseEquipItem, parentView)
	self._textName 			= nil
	self._textFrom			= nil
	self._textDetailName 	= nil
    self._listView 			= nil 
    self._nodeEquip         = nil
    self._lastAttr          = {}
    self._difAttr           = {}

	self._horseData 		= horseData
    self._rangeType         = rangeType

    -- 记录战马属性
    self._recordAttr        = recordAttr
    self._horseEquipItem 	= horseEquipItem --战马装备
	self._parentView = parentView

	local resource = {
		file = Path.getCSB("HorseDetailBaseView2", "horse"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonInfo = {
				events = {{event = "touch", method = "_onButtonInfoClicked"}}
			},
			_buttonUpStar = { 
				events = {{event = "touch", method = "_onButtonUpStarClicked"}} 
			}
		}
	}
	HorseDetailBaseView.super.ctor(self, resource)
end

function HorseDetailBaseView:onCreate()
	self._tabSelect = self._parentView:getSelectTabIndex() --nil  
	--i18n
	self:_dealByI18n()
	
end

function HorseDetailBaseView:onEnter()
    self._singleHorseEquipAddSuccess = G_SignalManager:add(SignalConst.EVENT_HORSE_EQUIP_ADD_SUCCESS,handler(self,self._horseEquipAddSuccess))

    self:_updateInfo()
end

function HorseDetailBaseView:onExit()
    self._singleHorseEquipAddSuccess:remove()
    self._singleHorseEquipAddSuccess = nil
end

function HorseDetailBaseView:_updateInfo()
	local horseData = self._horseData
	local horseBaseId = horseData:getBase_id()
	local star = horseData:getStar()
	local horseParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HORSE, horseBaseId)

	local heroUnitData = HorseDataHelper.getHeroDataWithHorseId(horseData:getId())

	if heroUnitData == nil then
		self._textFrom:setVisible(false)
		-- self._imageTalentBg:setVisible(false)
	else
		local baseId = heroUnitData:getBase_id()
		local limitLevel = heroUnitData:getLimit_level()
		local limitRedLevel = heroUnitData:getLimit_rtg()
		self._textFrom:setVisible(true)
		-- self._imageTalentBg:setVisible(true)
		local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, baseId, nil, nil, limitLevel, limitRedLevel)
		self._textFrom:setString(Lang.get("horse_detail_from", {name = heroParam.name}))
	end

	--名字
	local horseName = HorseDataHelper.getHorseName(horseBaseId, star)
	self._textName:setString(horseName)
	self._textName:setColor(horseParam.icon_color)
	-- self._textName:enableOutline(horseParam.icon_color_outline, 2)
	-- self._textDetailName:setString(horseName)
	-- self._textDetailName:setColor(horseParam.icon_color)
	-- -- self._textDetailName:enableOutline(horseParam.icon_color_outline, 2)

    self._nodeStar:setCount(horseData:getStar(), HorseConst.HORSE_STAR_MAX)

	--详情列表
	--self:_updateListView()
	self:_updateBtnList()

	-- 天赋描述
	self._starDesPlane:addClickEventListenerEx(handler(self, self._onButtonStarTalentDesPlaneClicked)) 
end

function HorseDetailBaseView:_updateListView()
	if self._tabSelect == HorseDetailBaseView.BUTTON_INFO then
		return
	end  

	-- 修复bug:数据未更新  导致升星成功后  技能描述文字颜色未变化
	local curHorseId = G_UserData:getHorse():getCurHorseId() 
	self._horseData = G_UserData:getHorse():getUnitDataWithId(curHorseId) 

    --详情List开始
	self._listView:removeAllChildren()
	-- 标题
	--self:_createTitle()
    --属性
    self:_buildAttrModule()
    --技能
    self:_buildSkillModule()
    --骑乘
    self:_buildRideModule()
    --简介
	self:_buildBriefModule()
end

function HorseDetailBaseView:_createTitle()
	local CSHelper = require("yoka.utils.CSHelper")
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitle", "common"))
	title:setFontSize(18)
	ccui.Helper:seekNodeByName(title, "TextTitle"):setFontName(Path.getCommonFont()) 
    ccui.Helper:seekNodeByName(title, "ImageBase"):loadTexture( Path.getTextTeam("img_com_board_zrd4") )
	ccui.Helper:seekNodeByName(title, "ImageBase"):setContentSize(cc.size(self._listView:getContentSize().width, 40))
	--名字
	local horseData = self._horseData
	local horseBaseId = horseData:getBase_id()
	local star = horseData:getStar()
	local horseParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HORSE, horseBaseId)
	local horseName = HorseDataHelper.getHorseName(horseBaseId, star) 
	title:setTitle(horseName) 
	title:setTitleColor(horseParam.icon_color)  

	local widget = ccui.Widget:create()
	local titleSize = cc.size(self._listView:getContentSize().width, 50)  
	widget:setContentSize(titleSize)
	title:setPosition(titleSize.width / 2, 30)
	widget:addChild(title)
	self._listView:pushBackCustomItem(widget)
end

function HorseDetailBaseView:_buildAttrModule()
	self._attrItem = HorseDetailAttrNode.new(self._horseData, self._rangeType, self._recordAttr)
	self._listView:pushBackCustomItem(self._attrItem)
end

function HorseDetailBaseView:_buildSkillModule()
	local item = HorseDetailSkillNode.new(self._horseData)
	self._listView:pushBackCustomItem(item)
end

function HorseDetailBaseView:_buildRideModule()
	local item = HorseDetailRideNode.new(self._horseData)
	self._listView:pushBackCustomItem(item)
end

function HorseDetailBaseView:_buildBriefModule()
	local item = HorseDetailBriefNode.new(self._horseData)
	self._listView:pushBackCustomItem(item)
end

-- 新增刷新战马装备的逻辑
function HorseDetailBaseView:_horseEquipAddSuccess(event,equipPos)
	if self._tabSelect == HorseDetailBaseView.BUTTON_INFO then 		  --信息
		self._horseEquipItem:updateHorseEquip(equipPos)

		local attrInfo = HorseDataHelper.getHorseAttrInfo(self._horseData)    
		self._recordAttr:updateData(attrInfo)

		-- 播放属性变化
		self._attrItem:playBaseAttrPromptSummary(self._recordAttr)

	elseif self._tabSelect == HorseDetailBaseView.BUTTON_UPSTAR  then  --升阶   
		local horseUpStar = ccui.Helper:seekNodeByName(G_SceneManager.getRunningScene(), "HorseTrainUpStarLayer")

		self._horseEquipItem:updateHorseEquip(equipPos)
		horseUpStar:_updateData()
	
		if not horseUpStar._unitData:isInBattle() then
			-- 没有上阵的战马不播放战力差值动画
			horseUpStar:_updateAttr()
			return
		end
		--属性飘字
		local summary = {}
		horseUpStar:_executeSummaryPrompt(summary)
	end
end

function HorseDetailBaseView:updateHorseEquipDifPrompt()
	logWarn("HorseDetailBaseView:updateHorseEquipDifPrompt")
	
	if self._tabSelect == HorseDetailBaseView.BUTTON_INFO then 		  --信息
		local refresh = false
		if not self._horseData:isInBattle() then
			refresh = true
		end
	
		self._attrItem:playBaseAttrPromptSummary(self._recordAttr,refresh)
	elseif self._tabSelect == HorseDetailBaseView.BUTTON_UPSTAR  then  --升阶  
		-- local horseUpStar = ccui.Helper:seekNodeByName(G_SceneManager.getRunningScene(), "HorseTrainUpStarLayer")
		-- horseUpStar:updateHorseEquipDifPrompt()
	end	
end


-------------------------------------------------------------------------------
function HorseDetailBaseView:_updateBtnList()
	-- create name
	self._buttonInfo:setString(Lang.get("hero_team_tab_title"))
	self._buttonUpStar:setString(Lang.get("horse_btn_advance"))
  
	self:_showInit()

	self:checkRedPoint()
end

function HorseDetailBaseView:_showInit()
	local tabIndex = self._tabSelect
	local isExist1 = (self._tabSelect == HorseDetailBaseView.BUTTON_UPSTAR and self._buttonUpStar:isVisible() == false)
	local isExist2 = (self._tabSelect == HorseDetailBaseView.BUTTON_REFINE and self._buttonUpStar:isVisible() == false)

	if isExist1 or isExist2 then
		tabIndex = HorseDetailBaseView.BUTTON_INFO
	end 

	self._tabSelect = nil
	if tabIndex == nil then
		tabIndex = HorseDetailBaseView.BUTTON_INFO
	end
	local btnFunc = {  [HorseDetailBaseView.BUTTON_INFO] = self._onButtonInfoClicked,
						[HorseDetailBaseView.BUTTON_UPSTAR] = self._onButtonUpStarClicked
					} 
	btnFunc[tabIndex](self)
end

function HorseDetailBaseView:checkRedPoint()
	local curHorseId = G_UserData:getHorse():getCurHorseId() 
	self._horseData = G_UserData:getHorse():getUnitDataWithId(curHorseId) 
	local reach = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_HORSE_TRAIN, "slotRP", self._horseData)
	self._buttonUpStar:showRedPoint(reach)

	-- 刷新当前装备红点
	self._parentView:refreshLeftIconRedPoint(self._parentView:getCurPos()) 
end

-- 调整按钮高亮
function HorseDetailBaseView:_adjustBtnListHigh()
	if self._tabSelect == nil then
		self._buttonInfo:enableHighLightStyle(true)      
	else 	
		self._buttonInfo:enableHighLightStyle( (self._tabSelect == HorseDetailBaseView.BUTTON_INFO and {true} or {false})[1] ) 
		self._buttonUpStar:enableHighLightStyle( (self._tabSelect == HorseDetailBaseView.BUTTON_UPSTAR and {true} or {false})[1] ) 
	end  --完整三目运算符(a and {b} or {c})[1]  /  a and b or c
 
	if self._tabSelect ~= HorseDetailBaseView.BUTTON_INFO  then
		self._listView:jumpToTop()
		self._listView:setDirection(ccui.ScrollViewDir.none)
		self._listView:setTouchEnabled(false)  
	else 
		self._listView:setDirection(ccui.ScrollViewDir.vertical)
		self._listView:setTouchEnabled(true)  
	end

	self._parentView:isShowButton(false)      -- 更换 卸下按钮
	self._nodeTalentDesPos:removeAllChildren() -- 天赋描述
end

-- 回调
function HorseDetailBaseView:_onButtonInfoClicked()
	self:_updateListView()
	
	self._tabSelect = HorseDetailBaseView.BUTTON_INFO 
	self:_adjustBtnListHigh()
	self._listView:doLayout()
	self._parentView:isShowButton(true)
end

function HorseDetailBaseView:_onButtonUpStarClicked()
	if self._tabSelect == HorseDetailBaseView.BUTTON_UPSTAR then   
		return
	end

	self._tabSelect = HorseDetailBaseView.BUTTON_UPSTAR    
	self:_adjustBtnListHigh() 
	self._listView:removeAllChildren()
	local HorseTrainUpStarLayer2 = require("app.scene.view.horseTrain.HorseTrainUpStarLayer2")
	local Item = HorseTrainUpStarLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()
	Item:initInfo() 
end

function HorseDetailBaseView:getTabSelect()
	return self._tabSelect
end

function HorseDetailBaseView:getHorseAvatar()
	if self._parentView then
		return self._parentView:getAvatar()
	end

	return nil
end

function HorseDetailBaseView:getRangeType()
	return self._rangeType
end

function HorseDetailBaseView:getEquipAvatar()
	if self._parentView then
		return self._parentView:getAvatar()
	end

	return nil
end

function HorseDetailBaseView:_onButtonStarTalentDesPlaneClicked()
	self._nodeTalentDes:setVisible( false )
end

function HorseDetailBaseView:getTalentDes(bShow)
	return self._nodeTalentDes 
end
--i18n
function HorseDetailBaseView:_dealByI18n()
	ccui.Helper:seekNodeByName(self._buttonUpStar, "Text"):setFontSize(22)
end

return HorseDetailBaseView


 