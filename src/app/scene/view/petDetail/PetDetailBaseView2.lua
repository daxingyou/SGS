--
-- Author: hedili
-- Date: 2018-01-25 15:09:42
-- 神兽详情
local ViewBase = require("app.ui.ViewBase")
local PetDetailBaseView = class("PetDetailBaseView",ViewBase)
local PetDetailAttrModule = require("app.scene.view.petDetail.PetDetailAttrModule2")
local PetDetailSkillModule = require("app.scene.view.petDetail.PetDetailSkillModule2")
local PetDetailTalentModule = require("app.scene.view.petDetail.PetDetailTalentModule2")
local PetDetailBriefModule  = require("app.scene.view.petDetail.PetDetailBriefModule2")
local PetDetailStarModule = require("app.scene.view.petDetail.PetDetailStarModule")

local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")


PetDetailBaseView.BUTTON_INFO = 1             --信息
PetDetailBaseView.BUTTON_UPGRADE = 2          --升级 
PetDetailBaseView.BUTTON_UPSTAR = 3           --升星  
PetDetailBaseView.BUTTON_LIMIT = 4            --界限 

function PetDetailBaseView:ctor(petId, petBaseId, rangeType, parentView)
	dump(petId)
	dump(petBaseId)
	if petId then
		self._petUnitData = G_UserData:getPet():getUnitDataWithId(petId)
	else
		local data = {baseId = petBaseId}
		self._petUnitData = G_UserData:getPet():createTempPetUnitData(data)
	end
	self._rangeType = rangeType
	self._parentView = parentView

	local resource = {
		file = Path.getCSB("PetDetailBaseView2", "pet"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonInfo = {
				events = {{event = "touch", method = "_onButtonInfoClicked"}}
			},
			_buttonUpgrade = {
				events = {{event = "touch", method = "_onButtonStrengClicked"}}
			},
			_buttonUpStar = {
				events = {{event = "touch", method = "_onButtonRefineClicked"}}
			},
			_buttonLimit = {
				events = {{event = "touch", method = "_onButtonLimitClicked"}}
			},
			_buttonPreview = {
				events = {{event = "touch", method = "_onButtonPreviewClicked"}}  -- 详情
			}
		}
	}

	PetDetailBaseView.super.ctor(self, resource)
end

function PetDetailBaseView:onCreate()
	self._tabSelect = self._parentView:getSelectTabIndex() --nil  
	self:_updateInfo()
	
	-- 调整字号
	ccui.Helper:seekNodeByName(self._buttonUpStar, "Text"):setFontSize(20)
 
	-- 天赋描述
	self._starDesPlane:addClickEventListenerEx(handler(self, self._onButtonStarTalentDesPlaneClicked)) 
end

function PetDetailBaseView:onEnter()

end

function PetDetailBaseView:onExit()

end

function PetDetailBaseView:buildAttrModule()
	--基础属性
	local petUnitData = self._petUnitData
	self._attrModule = PetDetailAttrModule.new(petUnitData, self._rangeType)
	self._listView:pushBackCustomItem(self._attrModule)
end

function PetDetailBaseView:buildStarModule( ... )
	-- body
	local petUnitData = self._petUnitData
	self._attrModule = PetDetailStarModule.new(petUnitData, self._rangeType)
	self._listView:pushBackCustomItem(self._attrModule)
end

function PetDetailBaseView:buildSkillModule()
	--技能
	local petUnitData = self._petUnitData
	local skillIds = {}
	local PetDataHelper = require("app.utils.data.PetDataHelper")
	local rank = petUnitData:getStar()
	local showSkillIds = PetDataHelper.getPetSkillIds(petUnitData:getBase_id(),rank)
	--for i = 1, 3 do
	--	local skillId = showSkillIds[i]
	--	if skillId > 0 then
	--		table.insert(skillIds, skillId)
	--	end
	--end

	if #showSkillIds > 0 then
		local skillModule = PetDetailSkillModule.new(showSkillIds, true, petUnitData:getBase_id(),rank)
		self._listView:pushBackCustomItem(skillModule)
	end
end



function PetDetailBaseView:buildTalentModule()
	--天赋
	local petUnitData = self._petUnitData
	if petUnitData:isCanBreak() then
	self._talentModule = PetDetailTalentModule.new(petUnitData)
		self._listView:pushBackCustomItem(self._talentModule)
	end
end


function PetDetailBaseView:buildBriefModule()
	local petUnitData = self._petUnitData
	self._briefModule = PetDetailBriefModule.new(petUnitData)
	self._listView:pushBackCustomItem(self._briefModule)
end

function PetDetailBaseView:_updateInfo()
	local petUnitData = self._petUnitData
	local petBaseId = petUnitData:getBase_id()

	self._fileNodeHeroName:setConvertType(TypeConvertHelper.TYPE_PET)
	--self._fileNodeHeroName2:setConvertType(TypeConvertHelper.TYPE_PET)
	self._fileNodeHeroName:setName(petBaseId, 0)
	
	--self._fileNodeHeroName2:setName(petBaseId, 0)

	self._fileNodeStar:setCount(petUnitData:getStar())
	--国家
	--self._fileNodeCountry:updateUI(petBaseId)
	--武将定位
	--self._fileNodeFeature:setString(petUnitData:getConfig().feature)

	--self:_updateListView()
	self:_updateBtnList()
end

function PetDetailBaseView:_updateListView()
	if self._tabSelect == PetDetailBaseView.BUTTON_INFO then
		return
	end

	--详情List开始
	self._listView:removeAllChildren()
 
	--属性
	self:buildAttrModule()
	--星级
	--self:buildStarModule()
	--技能
	self:buildSkillModule()
	--天赋
	self:buildTalentModule()
	--简介
	self:buildBriefModule()

	--self._listView:doLayout()
end

     
-------------------------------------------------------------------------------

function PetDetailBaseView:refreshBtnAndUI()  -- bug: 1升星完后这个界面就应该点亮星星，但是没有点亮，要退出重新进才点亮 bug:2 升星成功后 界限按钮未出来 要退出才有
	local curPetId = G_UserData:getPet():getCurPetId()  
	self._petUnitData = G_UserData:getPet():getUnitDataWithId(curPetId)
	self._parentView:_updateData()  -- 界限突破后会修改petId
	self._parentView:updatePageItem()

--	self:_updateInfo()  会导致重新创建 进而导致self.parentView找不到
	self._fileNodeStar:setCount(self._petUnitData:getStar())  			-- 升星成功星星刷新
	self._fileNodeHeroName:setConvertType(TypeConvertHelper.TYPE_PET)
	self._fileNodeHeroName:setName(self._petUnitData:getBase_id(), 0)	-- 界限成功名字刷新

	local tabSize = require("app.scene.view.petTrain.PetTrainHelper").getCurTabSize()   -- 升星成功显示界限按钮
	self._tabList[3]:setVisible(tabSize == 3)
	self:checkRedPoint()
end

function PetDetailBaseView:_updateBtnList()
	-- create name
	self._buttonInfo:setString(Lang.get("hero_team_tab_title"))
	self._tabList = {self._buttonUpgrade, self._buttonUpStar, self._buttonLimit}  
	local PetConst = require("app.const.PetConst")
	for i = 1, PetConst.MAX_TRAIN_TAB do
		local txt = Lang.get("pet_train_tab_icon_" .. i)
		self._tabList[i]:setString(txt)
	end
	--调整位置
	self:_doLayout() 

	self:checkRedPoint()
end

-- 调整按钮位置
function PetDetailBaseView:_doLayout()
	local PetTrainHelper = require("app.scene.view.petTrain.PetTrainHelper")
	local tabSize = PetTrainHelper.getCurTabSize()
	self._tabList[3]:setVisible(tabSize == 3)
 

	self:_showInit()
end

function PetDetailBaseView:_showInit()
	local tabIndex = self._tabSelect
	local isExist1 = (self._tabSelect == PetDetailBaseView.BUTTON_UPGRADE and self._buttonUpgrade:isVisible() == false)
	local isExist2 = (self._tabSelect == PetDetailBaseView.BUTTON_UPSTAR and self._buttonUpStar:isVisible() == false)
	local isExist3 = (self._tabSelect == PetDetailBaseView.BUTTON_LIMIT and self._buttonLimit:isVisible() == false)

	if isExist1 or isExist2 or isExist3  then
		tabIndex = PetDetailBaseView.BUTTON_INFO
	end 

	self._tabSelect = nil
	if tabIndex == nil then
		tabIndex = PetDetailBaseView.BUTTON_INFO
	end
	local btnFunc = {  [PetDetailBaseView.BUTTON_INFO] = self._onButtonInfoClicked,
						[PetDetailBaseView.BUTTON_UPGRADE] = self._onButtonStrengClicked,
						[PetDetailBaseView.BUTTON_UPSTAR] = self._onButtonRefineClicked,
						[PetDetailBaseView.BUTTON_LIMIT] = self._onButtonLimitClicked,
					} 
	btnFunc[tabIndex](self)
end
 
-- 调整按钮高亮
function PetDetailBaseView:_adjustBtnListHigh()
	if self._tabSelect == nil then
		self._buttonInfo:enableHighLightStyle(true)      
	else 	
		self._buttonInfo:enableHighLightStyle( (self._tabSelect == PetDetailBaseView.BUTTON_INFO and {true} or {false})[1] ) 
		self._buttonUpgrade:enableHighLightStyle( (self._tabSelect == PetDetailBaseView.BUTTON_UPGRADE and {true} or {false})[1] ) 
		self._buttonUpStar:enableHighLightStyle( (self._tabSelect == PetDetailBaseView.BUTTON_UPSTAR and {true} or {false})[1] ) 
		self._buttonLimit:enableHighLightStyle( (self._tabSelect == PetDetailBaseView.BUTTON_LIMIT and {true} or {false})[1] ) 
	end  --完整三目运算符(a and {b} or {c})[1]  /  a and b or c
 
	if self._tabSelect ~= PetDetailBaseView.BUTTON_INFO  then
		self._listView:jumpToTop()
		self._listView:setDirection(ccui.ScrollViewDir.none)
		self._listView:setTouchEnabled(false)  
	else 
		self._listView:setDirection(ccui.ScrollViewDir.vertical)
		self._listView:setTouchEnabled(true)  
	end

	self._nodeDetail:setVisible(false) 		  -- 详情按钮 描述按钮
	self._nodeLimit:setVisible(false)         -- 界限
	self._parentView:isShowButton(false)      
	self._parentView:changeBackground()
end

function PetDetailBaseView:checkRedPoint(nIndex)
	local petId = G_UserData:getPet():getCurPetId()
	local petUnitData = G_UserData:getPet():getUnitDataWithId(petId)
	-- local reach = RedPointHelper.isModuleReach(FunctionConst["FUNC_PET_TRAIN_TYPE" .. index], petUnitData)
	-- self["_nodeTabIcon" .. index]:showRedPoint(reach)
	local RedPointHelper = require("app.data.RedPointHelper")
	if nIndex ~= nil then
		if self._tabList[nIndex] then
			local reach = RedPointHelper.isModuleSubReach(FunctionConst["FUNC_PET_TRAIN_TYPE"..nIndex], "mainRP", petUnitData)
			self._tabList[nIndex]:showRedPoint(reach)
		end 
		return 
	end
	
	local PetConst = require("app.const.PetConst") 
	for index = 1, PetConst.MAX_TRAIN_TAB do
		if self._tabList[index] then
			local reach = RedPointHelper.isModuleSubReach(FunctionConst["FUNC_PET_TRAIN_TYPE"..index], "mainRP", petUnitData)
			self._tabList[index]:showRedPoint(reach)
		end 
	end

end

-- 回调
function PetDetailBaseView:_onButtonInfoClicked()
	self:_updateListView()
	
	self._tabSelect = PetDetailBaseView.BUTTON_INFO 
	self:_adjustBtnListHigh()
	self._listView:doLayout()
	self._parentView:isShowButton(true)
end

function PetDetailBaseView:_onButtonStrengClicked()
	if self._tabSelect == PetDetailBaseView.BUTTON_UPGRADE then   
		return
	end

	self._tabSelect = PetDetailBaseView.BUTTON_UPGRADE    
	self:_adjustBtnListHigh() 
	self._listView:removeAllChildren()
	local PetTrainUpgradeLayer2 = require("app.scene.view.petTrain.PetTrainUpgradeLayer2")
	local Item = PetTrainUpgradeLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()
	Item:initInfo() 
end

function PetDetailBaseView:_onButtonRefineClicked()
	if self._tabSelect == PetDetailBaseView.BUTTON_UPSTAR then   
		return
	end
  
	self._tabSelect = PetDetailBaseView.BUTTON_UPSTAR  
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local PetTrainStarLayer2 = require("app.scene.view.petTrain.PetTrainStarLayer2") 
	local Item = PetTrainStarLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:initInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏突破天赋描述，在刷新
end
 
function PetDetailBaseView:_onButtonLimitClicked()
	if self._tabSelect == PetDetailBaseView.BUTTON_LIMIT then   
		return
	end

	self._tabSelect = PetDetailBaseView.BUTTON_LIMIT    
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local PetTrainLimitLayer2 = require("app.scene.view.petTrain.PetTrainLimitLayer2")
	local Item = PetTrainLimitLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:initInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏左侧道具
end

function PetDetailBaseView:getTabSelect()
	return self._tabSelect
end

function PetDetailBaseView:getPetAvatar()
	if self._parentView then
		return self._parentView:getAvatar()
	end

	return nil
end

function PetDetailBaseView:_onButtonStarTalentDesPlaneClicked()
	self._nodeTalentDes:setVisible( false )
end

function PetDetailBaseView:getTalentDes(bShow)
	return self._nodeTalentDes 
end

-- 详情
function PetDetailBaseView:_onButtonPreviewClicked()
	if self._tabSelect == PetDetailBaseView.BUTTON_LIMIT then 
		local petUnitData = G_UserData:getPet():getUnitDataWithId(G_UserData:getPet():getCurPetId())
		local PopupPetLimitDetail = require("app.scene.view.petTrain.PopupPetLimitDetail").new(petUnitData)
		PopupPetLimitDetail:openWithAction()
	end
end


return PetDetailBaseView