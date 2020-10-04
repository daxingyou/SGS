--
-- Author: Liangxu
-- Date: 2017-02-28 15:09:42
-- 武将详情
local ViewBase = require("app.ui.ViewBase")
local HeroDetailBaseView = class("HeroDetailBaseView", ViewBase)
local HeroDetailAttrModule = require("app.scene.view.heroDetail.HeroDetailAttrModule2")
local HeroDetailJointModule = require("app.scene.view.heroDetail.HeroDetailJointModule2")
local HeroDetailSkillModule = require("app.scene.view.heroDetail.HeroDetailSkillModule2")
local HeroDetailWeaponModule = require("app.scene.view.heroDetail.HeroDetailWeaponModule2")
local HeroDetailTalentModule = require("app.scene.view.heroDetail.HeroDetailTalentModule2") 
local HeroDetailKarmaModule = require("app.scene.view.heroDetail.HeroDetailKarmaModule2")   
local HeroDetailYokeModule = require("app.scene.view.heroDetail.HeroDetailYokeModule2")
local HeroDetailAwakeModule = require("app.scene.view.heroDetail.HeroDetailAwakeModule2")
local HeroDetailBriefModule = require("app.scene.view.heroDetail.HeroDetailBriefModule2")  

local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local HeroTrainHelper = require("app.scene.view.heroTrain.HeroTrainHelper")
local HeroConst = require("app.const.HeroConst")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")

HeroDetailBaseView.BUTTON_INFO = 1          	--信息
HeroDetailBaseView.BUTTON_UPGRADE = 2           --升级
HeroDetailBaseView.BUTTON_BREAK = 3             --突破
HeroDetailBaseView.BUTTON_LIMIT = 4             --界限
HeroDetailBaseView.BUTTON_AWAKE = 5     		--觉醒
HeroDetailBaseView.BUTTON_GOLD = 6     			--涅槃

 
function HeroDetailBaseView:ctor(heroId, heroBaseId, rangeType, parentView)
	if heroId then
		self._heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
	else
		local data = {baseId = heroBaseId}
		self._heroUnitData = G_UserData:getHero():createTempHeroUnitData(data)
	end
	self._rangeType = rangeType
	self._parentView = parentView
	self.avatar = self._parentView._pageItems[self._parentView._selectedPos]:getChildren()[1]

	local resource = {
		file = Path.getCSB("HeroDetailBaseView2", "hero"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonInfo = {
				events = {{event = "touch", method = "_onButtonInfoClicked"}}
			},
			_buttonUpgrade = {
				events = {{event = "touch", method = "_onButtonUpgradeClicked"}}
			},
			_buttonBreak = {
				events = {{event = "touch", method = "_onButtonBreakClicked"}}
			},
			_buttonAwake = {
				events = {{event = "touch", method = "_onButtonAwakeClicked"}}
			},
			_buttonLimit = {
				events = {{event = "touch", method = "_onButtonLimitClicked"}}
			},
			_buttonGold = {
				events = {{event = "touch", method = "_onButtonGoldClicked"}}
			},
			_buttonPreview = {
				events = {{event = "touch", method = "_onButtonPreviewClicked"}}  -- 界限 涅磐详情
			}
		}
	}
	self:setName("HeroDetailBaseView")
	HeroDetailBaseView.super.ctor(self, resource)
end

function HeroDetailBaseView:onCreate()
	self._tabSelect = self._parentView._selectTabIndex --nil  
	self._origListSize = self._listView:getContentSize()
	self:_updateInfo()
	self:_adjustButtonPreviewPos() 
	ccui.Helper:seekNodeByName(self._buttonShow, "Button"):loadTextureNormal(Path.getUICommon("img_com_tips02")) -- 更换叹号按钮底图
	ccui.Helper:seekNodeByName(self._buttonShow, "Button"):setContentSize(cc.size(24, 32))
end

function HeroDetailBaseView:onEnter()	
	self._signalHeroKarmaActive =
		G_SignalManager:add(SignalConst.EVENT_HERO_KARMA_ACTIVE_SUCCESS, handler(self, self._heroKarmaActiveSuccess))
end

function HeroDetailBaseView:onExit()
	self._signalHeroKarmaActive:remove()
	self._signalHeroKarmaActive = nil
end

function HeroDetailBaseView:buildAttrModule()
	--基础属性
	local heroUnitData = self._heroUnitData
	self._attrModule = HeroDetailAttrModule.new(heroUnitData, self._rangeType, nil) 

	--print("****self._attrModule",  self._attrModule:isVisible(), self._attrModule:getContentSize().width, self._attrModule:getContentSize().height) 
	self._listView:pushBackCustomItem(self._attrModule)
end

function HeroDetailBaseView:buildJointModule()
	--合击
	local heroUnitData = self._heroUnitData
	local heroBaseId = heroUnitData:getBase_id()
	local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)

	if heroParam.cfg.skill_3_type ~= 0 then --有合击关系
		self._jointModule = HeroDetailJointModule.new(heroUnitData)
		self._listView:pushBackCustomItem(self._jointModule)
	end
end

function HeroDetailBaseView:buildSkillModule()
	--技能
	local heroUnitData = self._heroUnitData
	local skillIds = {}
	local showSkillIds = AvatarDataHelper.getShowSkillIdsByCheck(heroUnitData)
	for i = 1, 3 do
		local skillId = showSkillIds[i]
		if skillId > 0 then
			table.insert(skillIds, skillId)
		end
	end

	if #skillIds > 0 then
		local skillModule = HeroDetailSkillModule.new(skillIds)
		self._listView:pushBackCustomItem(skillModule)
	end
end

--神兵
function HeroDetailBaseView:buildWeaponModule()
	local baseId = self._heroUnitData:getConfig().instrument_id
	if baseId > 0 then
		self._weaponModule = HeroDetailWeaponModule.new(self._heroUnitData)
		self._listView:pushBackCustomItem(self._weaponModule)
	end
end

function HeroDetailBaseView:buildTalentModule()
	--天赋
	local heroUnitData = self._heroUnitData
	if heroUnitData:isCanBreak() then
		self._talentModule = HeroDetailTalentModule.new(heroUnitData)
		self._listView:pushBackCustomItem(self._talentModule)
	end
end

function HeroDetailBaseView:buildKarmaModule()
	local heroUnitData = self._heroUnitData

	self._karmaModule = HeroDetailKarmaModule.new(heroUnitData, self._rangeType)
	self._listView:pushBackCustomItem(self._karmaModule)
end

function HeroDetailBaseView:buildYokeModule()
	local heroUnitData = self._heroUnitData
	local heroYoke = UserDataHelper.getHeroYokeInfo(heroUnitData)
	if heroYoke then
		self._yokeModule = HeroDetailYokeModule.new(heroYoke)
		self._listView:pushBackCustomItem(self._yokeModule)
	end
end

function HeroDetailBaseView:buildDestinyModule()
	--天命
end

--觉醒
function HeroDetailBaseView:buildAwakeModule()
	local heroUnitData = self._heroUnitData
	if heroUnitData:isCanAwake() then
		self._awakeModule = HeroDetailAwakeModule.new(heroUnitData, self._rangeType)
		self._listView:pushBackCustomItem(self._awakeModule)
	end
end

function HeroDetailBaseView:buildBriefModule()
	local heroUnitData = self._heroUnitData
	self._briefModule = HeroDetailBriefModule.new(heroUnitData)
	self._listView:pushBackCustomItem(self._briefModule)
end

function HeroDetailBaseView:_updateInfo()
	self:_updateBtnList()

	-- 天赋描述
	self._breakDesPlane:addClickEventListenerEx(handler(self, self._onButtonBreakTalentDesPlaneClicked)) 
	self._awakeDesPlane:addClickEventListenerEx(handler(self, self._onButtonAwakeTalentDesPlaneClicked)) 
	self._goldDesPlane:addClickEventListenerEx(handler(self, self._onButtonGoldTalentDesPlaneClicked)) 
end

function HeroDetailBaseView:_updateListView()
	if self._tabSelect == HeroDetailBaseView.BUTTON_INFO then
		return
	end

	--详情List开始
	self._listView:removeAllChildren()
	--属性
	self:buildAttrModule()
	--合击
	self:buildJointModule()
	--技能
	self:buildSkillModule()
	--天赋
	self:buildTalentModule()
	--神兵
	self:buildWeaponModule()
	--缘分
	self:buildKarmaModule()
	--羁绊
	self:buildYokeModule()
	--天命
	-- self:buildDestinyModule()
	--觉醒天赋
	if not self._heroUnitData:isPureGoldHero() then
		self:buildAwakeModule()
	end
	--简介
	self:buildBriefModule()

	--self._listView:doLayout()
end

function HeroDetailBaseView:_heroKarmaActiveSuccess()
	if self._karmaModule then
		self._karmaModule:updateData(self._heroUnitData)
	end
end

-----------------------------------------------------------------------------------------
-- i18n ja add  
function HeroDetailBaseView:_updateBtnList()
	-- create name
	self._buttonGold:setString(Lang.get("goldenhero_train_button_text"))
	self._buttonUpgrade:setString(Lang.get("hero_detail_btn_upgrade"))
	self._buttonBreak:setString(Lang.get("hero_detail_btn_break"))
	self._buttonAwake:setString(Lang.get("hero_detail_btn_awake"))
	self._buttonLimit:setString(Lang.get("hero_detail_btn_limit"))
	self._buttonInfo:setString(Lang.get("hero_team_tab_title"))
 
	--调整位置
	self:_doLayout()

	self:checkRedPoint()
 
	-- 升级
	self._buttonUpgrade:getChildByName("Text"):setFontSize(22)
end

-- 调整按钮位置
function HeroDetailBaseView:_doLayout()
	local showCount = 1 --信息默认显示
	local _posList = {543, 469, 395, 321, 247, 469}  --分别对应对应序号的位置

	-- 位置 + 控制显示
	local HeroGoldHelper = require("app.scene.view.heroGoldTrain.HeroGoldHelper")
	local isGold = HeroGoldHelper.isPureHeroGold(self._heroUnitData)
	self._buttonGold:setVisible(isGold)
	self._buttonGold:setPositionY(_posList[6])

	local showUpgrade = self._heroUnitData:getConfig().type ~= 1 and not isGold
	local heroConfig = self._heroUnitData:getConfig()
	local isLeader = heroConfig.type == 1
	if not isGold and isLeader then -- 主将特殊处理
		showUpgrade = true
	end
	self._buttonUpgrade:setVisible(showUpgrade)
	if showUpgrade then 
		showCount = showCount + 1
		self._buttonUpgrade:setPositionY(_posList[showCount])
	end

	local showBreak = self._heroUnitData:isCanBreak() and not isGold
	self._buttonBreak:setVisible(showBreak)
	if showBreak then 
		showCount = showCount + 1
		self._buttonBreak:setPositionY(_posList[showCount])
	end

	local canLimit, limitType = self._heroUnitData:isCanLimitBreak()
	canLimit = canLimit and not isGold
	local funcLimitType = FunctionConst.FUNC_HERO_TRAIN_TYPE4
	local funcLimitType2 = funcLimitType
	if limitType==HeroConst.HERO_LIMIT_TYPE_GOLD then
		funcLimitType = FunctionConst.FUNC_HERO_TRAIN_TYPE4_RED
	end
	local limitIsOpen = LogicCheckHelper.funcIsOpened(funcLimitType)
	local showLimit = canLimit and limitIsOpen
	self._buttonLimit:setVisible(showLimit)
	if showLimit then 
		showCount = showCount + 1
		self._buttonLimit:setPositionY(_posList[showCount])
	end

	local canAwake = self._heroUnitData:isCanAwake() and not isGold
	local awakeIsOpen = LogicCheckHelper.funcIsOpened(FunctionConst.FUNC_HERO_TRAIN_TYPE3)
	local showAwake = canAwake and awakeIsOpen
	self._buttonAwake:setVisible(showAwake)
	if showAwake then 
		showCount = showCount + 1
		self._buttonAwake:setPositionY(_posList[showCount])
	end

	self:_showInit()
end

function HeroDetailBaseView:_showInit()
	local tabIndex = self._tabSelect
	local isExist1 = (self._tabSelect == HeroDetailBaseView.BUTTON_UPGRADE and self._buttonUpgrade:isVisible() == false)
	local isExist2 = (self._tabSelect == HeroDetailBaseView.BUTTON_BREAK and self._buttonBreak:isVisible() == false)
	local isExist3 = (self._tabSelect == HeroDetailBaseView.BUTTON_LIMIT and self._buttonLimit:isVisible() == false)
	local isExist4 = (self._tabSelect == HeroDetailBaseView.BUTTON_AWAKE and self._buttonAwake:isVisible() == false)
	local isExist5 = (self._tabSelect == HeroDetailBaseView.BUTTON_GOLD and self._buttonGold:isVisible() == false)

	if isExist1 or isExist2 or isExist3 or isExist4 or isExist5 then
		tabIndex = HeroDetailBaseView.BUTTON_INFO
	end 

	self._tabSelect = nil
	if tabIndex == nil then
		tabIndex = HeroDetailBaseView.BUTTON_INFO
	end
	local btnFunc = {  [HeroDetailBaseView.BUTTON_INFO] = self._onButtonInfoClicked,
						[HeroDetailBaseView.BUTTON_UPGRADE] = self._onButtonUpgradeClicked,
						[HeroDetailBaseView.BUTTON_BREAK] = self._onButtonBreakClicked,
						[HeroDetailBaseView.BUTTON_LIMIT] = self._onButtonLimitClicked,
						[HeroDetailBaseView.BUTTON_AWAKE] = self._onButtonAwakeClicked,
						[HeroDetailBaseView.BUTTON_GOLD] = self._onButtonGoldClicked
					} 
	btnFunc[tabIndex](self)
end
 
-- 调整按钮高亮
function HeroDetailBaseView:_adjustBtnListHigh()

	if self._tabSelect == nil then
		self._buttonInfo:enableHighLightStyle(true)      
	else 	
		self._buttonInfo:enableHighLightStyle( (self._tabSelect == HeroDetailBaseView.BUTTON_INFO and {true} or {false})[1] ) 
		self._buttonUpgrade:enableHighLightStyle( (self._tabSelect == HeroDetailBaseView.BUTTON_UPGRADE and {true} or {false})[1] ) 
		self._buttonBreak:enableHighLightStyle( (self._tabSelect == HeroDetailBaseView.BUTTON_BREAK and {true} or {false})[1] ) 
		self._buttonLimit:enableHighLightStyle( (self._tabSelect == HeroDetailBaseView.BUTTON_LIMIT and {true} or {false})[1] ) 
		self._buttonAwake:enableHighLightStyle( (self._tabSelect == HeroDetailBaseView.BUTTON_AWAKE and {true} or {false})[1] ) 
		self._buttonGold:enableHighLightStyle( (self._tabSelect == HeroDetailBaseView.BUTTON_GOLD and {true} or {false})[1] ) 
	end  --完整三目运算符(a and {b} or {c})[1]  /  a and b or c

	ccui.Helper:seekNodeByName(self._parentView, "CVBg"):setVisible(true)
	if self._parentView:getPageViewPos() == 1 then  -- 男女主角无CV
		local heroBaseId, isEquipAvatar, avatarLimitLevel, arLimitLevel = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)
		ccui.Helper:seekNodeByName(self._parentView, "CVBg"):setVisible(isEquipAvatar)  --穿了变身卡 有CV
	end
	
	if self._tabSelect ~= HeroDetailBaseView.BUTTON_INFO  then
		self._listView:jumpToTop()
		self._listView:setDirection(ccui.ScrollViewDir.none)
		self._listView:setTouchEnabled(false)  
	else 
		self._listView:setDirection(ccui.ScrollViewDir.vertical)
		self._listView:setTouchEnabled(true)  
	end

	self._nodeTalent:setVisible(false)         -- 突破详情描述
	self._nodeAwake:setVisible(false)          -- 觉醒
	self._nodeLimitAwakeGold:setVisible(false) -- 详情按钮 描述按钮
	self._nodeLimit:setVisible(false)          -- _nodeFire “我预问鼎天下 试问谁与争锋”特效     _nodeHetiMoving 成功后特效  _nodeBgMoving背景后火星特效  _nodePopup黑圈圈父节点
	self._nodeGold:setVisible(false)		   -- 涅槃
end 

-- 红点相关
function HeroDetailBaseView:checkRedPoint()   
	local heroId = G_UserData:getHero():getCurHeroId()
	local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
	-- local RedPointHelper = require("app.data.RedPointHelper")
	-- local reach = RedPointHelper.isModuleReach(FunctionConst["FUNC_HERO_TRAIN_TYPE" .. index], heroUnitData)
	-- local tab = {self._buttonUpgrade, self._buttonBreak, self._buttonLimit, self._buttonAwake}
	-- tab[index]:showRedPoint(reach) 
	self:_checkUpgradeRedPoint(heroUnitData)
	self:_checkBreakRedPoint(heroUnitData)
	self:_checkAwakeRedPoint(heroUnitData)
	self:_checkLimitRedPoint(heroUnitData)
	self:_checkGoldRankRedPoint(heroUnitData)
end

function HeroDetailBaseView:_checkUpgradeRedPoint(heroUnitData)
	if heroUnitData:getConfig().type ~= 1 then
		local RedPointHelper = require("app.data.RedPointHelper")
		local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HERO_TRAIN_TYPE1, heroUnitData)
		self._buttonUpgrade:showRedPoint(reach)
	end
end

function HeroDetailBaseView:_checkBreakRedPoint(heroUnitData)
	local RedPointHelper = require("app.data.RedPointHelper")
	local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HERO_TRAIN_TYPE2, heroUnitData)
	self._buttonBreak:showRedPoint(reach)
end

function HeroDetailBaseView:_checkAwakeRedPoint(heroUnitData)
	local RedPointHelper = require("app.data.RedPointHelper")
	local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HERO_TRAIN_TYPE3, heroUnitData)
	self._buttonAwake:showRedPoint(reach)
end

function HeroDetailBaseView:_checkLimitRedPoint(heroUnitData)
	local RedPointHelper = require("app.data.RedPointHelper")
	local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_HERO_TRAIN_TYPE4, heroUnitData)
	self._buttonLimit:showRedPoint(reach)
end

function HeroDetailBaseView:_checkGoldRankRedPoint(heroUnitData)
	local HeroGoldHelper = require("app.scene.view.heroGoldTrain.HeroGoldHelper")
	local reach = HeroGoldHelper.heroGoldNeedRedPoint(heroUnitData)
	self._buttonGold:showRedPoint(reach)
end

-- 回调
function HeroDetailBaseView:_onButtonInfoClicked()
	self:_updateListView()
	
	self._tabSelect = HeroDetailBaseView.BUTTON_INFO 
	self:_adjustBtnListHigh()
	self._listView:doLayout()
end

function HeroDetailBaseView:_onButtonUpgradeClicked()
	if self._tabSelect == HeroDetailBaseView.BUTTON_UPGRADE then   
		return
	end

	self._tabSelect = HeroDetailBaseView.BUTTON_UPGRADE    
	self:_adjustBtnListHigh() 
	self._listView:removeAllChildren()
	local HeroTrainUpgradeLayer = require("app.scene.view.heroTrain.HeroTrainUpgradeLayer2")
	local Item = HeroTrainUpgradeLayer.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()
	Item:initInfo() 
end

function HeroDetailBaseView:_onButtonBreakClicked()
	if self._tabSelect == HeroDetailBaseView.BUTTON_BREAK then   
		return
	end
  
	self._tabSelect = HeroDetailBaseView.BUTTON_BREAK  
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local HeroTrainBreakLayer2 = require("app.scene.view.heroTrain.HeroTrainBreakLayer2")
	local Item = HeroTrainBreakLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:initInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏突破天赋描述，在刷新
end

function HeroDetailBaseView:_onButtonAwakeClicked()
	if self._tabSelect == HeroDetailBaseView.BUTTON_AWAKE then   
		return
	end

	self._tabSelect = HeroDetailBaseView.BUTTON_AWAKE    
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local HeroTrainAwakeLayer2 = require("app.scene.view.heroTrain.HeroTrainAwakeLayer2") 
	local Item = HeroTrainAwakeLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:initInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏天赋描述，在刷新
end

function HeroDetailBaseView:_onButtonLimitClicked()
	if self._tabSelect == HeroDetailBaseView.BUTTON_LIMIT then   
		return
	end

	self._tabSelect = HeroDetailBaseView.BUTTON_LIMIT    
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local HeroTrainLimitLayer2 = require("app.scene.view.heroTrain.HeroTrainLimitLayer2") 
	local Item = HeroTrainLimitLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:initInfo()    -- 后刷新 因为_adjustBtnListHigh先隐藏左侧道具
end

function HeroDetailBaseView:_onButtonGoldClicked()
	if self._tabSelect == HeroDetailBaseView.BUTTON_GOLD then   
		return
	end

	self._tabSelect = HeroDetailBaseView.BUTTON_GOLD  
	self:_adjustBtnListHigh()
	self._listView:removeAllChildren()
	local HeroGoldTrainLayer2 = require("app.scene.view.heroGoldTrain.HeroGoldTrainLayer2") 
	local Item = HeroGoldTrainLayer2.new( self ) 
	self._listView:pushBackCustomItem(Item)
	self._listView:doLayout()

	Item:initInfo()     
end

-- 界限 涅磐详情
function HeroDetailBaseView:_onButtonPreviewClicked()
	if self._tabSelect == HeroDetailBaseView.BUTTON_LIMIT then
		local popup = require("app.scene.view.heroTrain.PopupLimitDetail").new(self._heroUnitData)
		popup:openWithAction()
	elseif self._tabSelect == HeroDetailBaseView.BUTTON_AWAKE then 
		local popup = require("app.scene.view.heroTrain.PopupAwakePreview").new(self._heroUnitData)
		popup:openWithAction()
	elseif self._tabSelect == HeroDetailBaseView.BUTTON_GOLD then 	
		local PopupPetLimitDetail = require("app.scene.view.heroGoldTrain.PopupHeroGoldTrainDetail").new(self._heroUnitData)
		PopupPetLimitDetail:openWithAction()
	end
end

-- 适配突破  觉醒  涅槃详情描述
function HeroDetailBaseView:_adjustButtonPreviewPos()  
	local newWorldPos = self._listView:getParent():convertToWorldSpace(cc.p(self._listView:getPosition()))
	newWorldPos = self._nodeTalent:getParent():convertToNodeSpace(newWorldPos)
	local pos = newWorldPos.x - self._listView:getContentSize().width*0.5 - 3
	self._nodeTalent:setPositionX(pos)
	self._nodeAwakeTalent:setPositionX(pos)
	self._nodeGoldTalent:setPositionX(pos)
end

function HeroDetailBaseView:_onButtonBreakTalentDesPlaneClicked()
	self._nodeTalent:setVisible( false )
end

function HeroDetailBaseView:_onButtonAwakeTalentDesPlaneClicked()
	self._nodeAwakeTalent:setVisible( false )
end

function HeroDetailBaseView:_onButtonGoldTalentDesPlaneClicked()
	self._nodeGoldTalent:setVisible( false )
end

function HeroDetailBaseView:getTabSelect()
	 return self._tabSelect
end
 
function HeroDetailBaseView:refreshBtnAndUI()
	local curHeroId = G_UserData:getHero():getCurHeroId()
	self._heroUnitData = G_UserData:getHero():getUnitDataWithId(curHeroId)
 
	self._parentView:_updatePageItem() -- 界限突破后会修改形象
	self:checkRedPoint()  
end

 
return HeroDetailBaseView 


 