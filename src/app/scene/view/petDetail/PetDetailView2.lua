--
-- Author: hedili
-- Date: 2017-02-28 15:09:42
-- 神兽详情
local ViewBase = require("app.ui.ViewBase")
local PetDetailView = class("PetDetailView", ViewBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local PetDetailBaseView = require("app.scene.view.petDetail.PetDetailBaseView")
local PetConst = require("app.const.PetConst")
local CSHelper = require("yoka.utils.CSHelper")
local RedPointHelper = require("app.data.RedPointHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local AttributeConst = require("app.const.AttributeConst")
local UIHelper = require("yoka.utils.UIHelper")
local UIConst = require("app.const.UIConst")
local PetDataHelper = require("app.utils.data.PetDataHelper")

local RECORD_ATTR_LIST = {	
	{AttributeConst.ATK_FINAL, "_nodeAttr1"},
	{AttributeConst.HP_FINAL, "_nodeAttr2"},
	{AttributeConst.PD_FINAL, "_nodeAttr3"},
	{AttributeConst.MD_FINAL, "_nodeAttr4"},
}

function PetDetailView:ctor(petId, rangeType)
	dump(petId)
	G_UserData:getPet():setCurPetId(petId)


	self._rangeType = rangeType
	self._allPetIds = {}

	local resource = {
		file = Path.getCSB("PetDetailView2", "pet"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonLeft = {
				events = {{event = "touch", method = "_onButtonLeftClicked"}}
			},
			_buttonRight = {
				events = {{event = "touch", method = "_onButtonRightClicked"}}
			},
			_buttonChange = {
				events = {{event = "touch", method = "_onButtonChangeClicked"}}
			},
			_buttonUnload = {
				events = {{event = "touch", method = "_onButtonUnloadClicked"}}
			}

		}
	}
	PetDetailView.super.ctor(self, resource)
end

function PetDetailView:onCreate()
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)
	self._topbarBase:setImageTitle("txt_sys_com_shenshou")

	self._pageView:setScrollDuration(0.3)
	self._pageView:addEventListener(handler(self,self._onPageViewEvent))
    self._pageView:addTouchEventListener(handler(self,self._onPageTouch))
    self._pageViewSize = self._pageView:getContentSize()

	self:_initData()

	-- i18n change lable
	self:_swapImageByI18n()

	self._buttonChange:setFontSize(20)
	self._buttonUnload:setFontSize(20)
	self._buttonUnload:setFontName(Path.getFontW8())
	self._buttonChange:setFontName(Path.getFontW8())
	self._buttonChange:setString(Lang.getImgText("img_btn_replacetxt01"))
	self._buttonUnload:setString(Lang.getImgText("img_btn_replacetxt02"))
	self._nodePetDetailView:setLocalZOrder(self._panelDesign:getLocalZOrder() + 1)   -- 处理：pageview遮挡下方详情按钮
end

function PetDetailView:_initData( ... )
	-- body
	self._changeOldPetId = 0
	
	self._lastPetLevel = {} --记录神兽等级:{id, level}
	self._lastPetRank = {} --记录神兽突破等级:{id, level}

	self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst["FUNC_PET_TEAM_SLOT"])
	self._isPageViewMoving = false --pageview是否在拖动过程中
end

function PetDetailView:_updateData( ... )
	-- body


	self._nodeButton:setVisible(false)
	if self._rangeType == PetConst.PET_RANGE_TYPE_1 then

		self._allPetIds = G_UserData:getPet():getRangeDataBySort() --getListDataBySort()  
	elseif self._rangeType == PetConst.PET_RANGE_TYPE_2 then
		self._allPetIds = G_UserData:getTeam():getPetIdsInBattle()
	elseif self._rangeType == PetConst.PET_RANGE_TYPE_3 then
		self._allPetIds = G_UserData:getTeam():getPetIdsInHelp()
		--self._nodeButton:setVisible(true)
	end

	self._selectedPos = 1
	local petId = G_UserData:getPet():getCurPetId()
	for i, id in ipairs(self._allPetIds) do
		if id == petId then
			self._selectedPos = i
		end
	end
	self._petCount = #self._allPetIds

	G_UserData:getPet():setCurPetId(petId)
	self:_recordBaseAttr()
	G_UserData:getAttr():recordPower()
end
function PetDetailView:onEnter()

	self._signalChangePetFormation = G_SignalManager:add(SignalConst.EVENT_PET_ON_TEAM_SUCCESS, handler(self, self._onEventUserPetChange))

	
	self:_updateData()
	self:_initPageView()
	self:_updateArrowBtn()
	self:_updateInfo()

		
	--抛出新手事件
	G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
end

function PetDetailView:onExit()
	self._signalChangePetFormation:remove()
	self._signalChangePetFormation = nil
end

function PetDetailView:_setCurPos()

end

--只创建widget，减少开始的加载量
function PetDetailView:_createPageItem()
	local widget = ccui.Widget:create()
	widget:setContentSize(self._pageViewSize.width, self._pageViewSize.height)
	return widget
end

function PetDetailView:updatePageItem()
	local index = self._selectedPos
	for i = index-1, index+1 do
		local widget = self._pageItems[i]
		if widget then --如果当前位置左右没有加Avatar，加上
			local count = widget:getChildrenCount()
			local petId = self._allPetIds[i]
			if count == 0 and petId > 0 then
				local unitData = G_UserData:getPet():getUnitDataWithId(petId)
				local avatar = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
				avatar:setConvertType(TypeConvertHelper.TYPE_PET)

				avatar:updateUI(unitData:getBase_id())
				avatar:setScale(1.0)
				avatar:setShadowScale(2.7) --神兽影子放大
				avatar:setPosition(cc.p(self._pageViewSize.width *0.57, 190))
				avatar:playAnimationLoopIdle(handler(self, self._onAvatarCallBack), i)
				widget:addChild(avatar)
			end

			if index == self._selectedPos then  -- bug: 强制清空  因为界限突破成功后 形象会发生变化
				local unitData = G_UserData:getPet():getUnitDataWithId(petId)
				widget:getChildren()[1]:updateUI(unitData:getBase_id())
			end
			
		end
	end
	self:_updatePageItemVisible()
end

function PetDetailView:_onAvatarCallBack(loopCount, spineHero, heroId, posIndex)
	if self._selectedPos == posIndex and loopCount == 2 and spineHero:getAnimationName() ~= "idle2" then
		PetDataHelper.playVoiceWithId(heroId)
	end
end

function PetDetailView:_initPageView()
	self._pageItems = {}
	self._pageView:removeAllPages()
    for i = 1, self._petCount do
    	local item = self:_createPageItem()
        self._pageView:addPage(item)
        table.insert(self._pageItems, item)
    end
    self:updatePageItem()
    self._pageView:setCurrentPageIndex(self._selectedPos - 1)
end 

function PetDetailView:_updateInfo()
	-- i18n ja update UI
	local curPetId = G_UserData:getPet():getCurPetId()
	if Lang.checkUI("ui4") then   
		PetDetailBaseView = require("app.scene.view.petDetail.PetDetailBaseView2")
		if self._nodePetDetailView:getChildrenCount() > 0 then
			self._selectTabIndex = self._nodePetDetailView:getChildren()[1]:getTabSelect()
		end

		self._nodePetDetailView:removeAllChildren()
		local petDetail = PetDetailBaseView.new(curPetId, nil, self._rangeType, self)
		self._nodePetDetailView:addChild(petDetail)
	else    
		self._nodePetDetailView:removeAllChildren()
		local petDetail = PetDetailBaseView.new(curPetId, nil, self._rangeType)
		self._nodePetDetailView:addChild(petDetail)
	end


	local petUnitData = G_UserData:getPet():getUnitDataWithId(curPetId)
	local reach = RedPointHelper.isModuleReach(FunctionConst.FUNC_PET_CHANGE, petUnitData)
	self._buttonChange:showRedPoint(reach)
	

	local strDesc = UserDataHelper.getPetStateStr(petUnitData)
	dump(strDesc)
	if strDesc then
		self._textIsBless:setString(strDesc)
		self._textIsBless:setVisible(true)
	else
		self._textIsBless:setVisible(false)
	end
end


function PetDetailView:_updateArrowBtn()
	self._buttonLeft:setVisible(self._selectedPos > 1)
	self._buttonRight:setVisible(self._selectedPos < self._petCount)
end

function PetDetailView:_onButtonLeftClicked()
	if self._selectedPos <= 1 then
		return
	end

	self._selectedPos = self._selectedPos - 1
	self:_setCurPos()
	local curPetId = self._allPetIds[self._selectedPos]
	G_UserData:getPet():setCurPetId(curPetId)
	self:_updateArrowBtn()
	self._pageView:setCurrentPageIndex(self._selectedPos - 1)
	self:_updateInfo()
	self:updatePageItem()
end

function PetDetailView:_onButtonRightClicked()
	if self._selectedPos >= self._petCount then
		return
	end

	self._selectedPos = self._selectedPos + 1
	self:_setCurPos()
	local curPetId = self._allPetIds[self._selectedPos]
	G_UserData:getPet():setCurPetId(curPetId)
	self:_updateArrowBtn()
	self._pageView:setCurrentPageIndex(self._selectedPos - 1)
	self:_updateInfo()
	self:updatePageItem()
end

function PetDetailView:_onPageTouch(sender, state)
	if state == ccui.TouchEventType.began then
		self._isPageViewMoving = true
		self:_updatePageItemVisible()
	elseif state == ccui.TouchEventType.ended or state == ccui.TouchEventType.canceled then
		self._isPageViewMoving = false
	end
end

function PetDetailView:_updatePageItemVisible()
	local curIndex = self._selectedPos
	for i, item in ipairs(self._pageItems) do
		if i == curIndex then
			item:setVisible(true)
		else
			item:setVisible(self._isPageViewMoving)
		end
	end
end

function PetDetailView:_onPageViewEvent(sender,event)
	if event == ccui.PageViewEventType.turning and sender == self._pageView then
		local targetPos = self._pageView:getCurrentPageIndex() + 1
		if targetPos ~= self._selectedPos then
			self._selectedPos = targetPos
			self:_setCurPos()
			local curPetId = self._allPetIds[self._selectedPos]
			G_UserData:getPet():setCurPetId(curPetId)
			self:_updateArrowBtn()
			self:_updateInfo()
			self:updatePageItem()
		end
	end
end


--选择更换神兽后的回调
function PetDetailView:_changePetCallBack(petId)
	local oldPet = G_UserData:getPet():getCurPetId()
	local oldPetUnit = G_UserData:getPet():getUnitDataWithId(oldPet)
	dump( oldPetUnit:getPos() )
	if oldPet and oldPetUnit then
		G_UserData:getPet():c2sPetOnTeam(petId, 2, oldPetUnit:getPos() - 1)
	end
end


function PetDetailView:_onButtonUnloadClicked()
	local pos = self._selectedPos
	local petId = self._allPetIds[self._selectedPos]
	local petUnit = G_UserData:getPet():getUnitDataWithId(petId)
	if petUnit then
		G_UserData:getPet():c2sPetOnTeam(0,2, petUnit:getPos() - 1)
	end
	G_SceneManager:popScene()
end

function PetDetailView:_onButtonChangeClicked()
	local petId = self._allPetIds[self._selectedPos]
	local PopupChoosePet = require("app.ui.PopupChoosePet")
	local PopupChoosePetHelper = require("app.ui.PopupChoosePetHelper")
	local isEmpty = PopupChoosePetHelper.checkIsEmpty(PopupChoosePetHelper.FROM_TYPE3, {petId})
	if isEmpty then
		G_Prompt:showTip(Lang.get("pet_popup_list_empty_tip"..PopupChoosePetHelper.FROM_TYPE3))
	else
		local PopupChoosePet = PopupChoosePet.new()
		local callBack = handler(self, self._changePetCallBack)
		PopupChoosePet:setTitle(Lang.get("pet_help_replace_title"))
		PopupChoosePet:updateUI(PopupChoosePetHelper.FROM_TYPE3, callBack, petId)
		PopupChoosePet:openWithAction()
	end
end

-- 更新UI
function PetDetailView:_onEventUserPetChange(_, petId)
	if petId == 0 then
		return
	end

	G_UserData:getPet():setCurPetId(petId)
	self:_updateData()
	self:_initPageView()
	self:_updateArrowBtn()
	self:_updateInfo()



	self._changeOldPetId = petId
	self:_playChangePetSummary()
end



--记录基础属性
function PetDetailView:_recordBaseAttr()
	local curPetId = G_UserData:getPet():getCurPetId()
	local curUnit = G_UserData:getPet():getUnitDataWithId(curPetId)
	local param = {
		unitData = curUnit,
	}
	local attrInfo = UserDataHelper.getPetTotalAttr(param)

	dump(attrInfo)
	self._recordAttr:updateData(attrInfo)
end


--播放更换神兽成功后的飘字
function PetDetailView:_playChangePetSummary()
	local summary = {}

	--神兽上阵\更换成功
	local successStr = ""
	if self._changeOldPetId and self._changeOldPetId > 0 then
		successStr = Lang.get("summary_pet_change")
	elseif self._changeOldPetId == 0 then
		self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst["FUNC_PET_HELP_SLOT"..self._selectedPos])
		self:_recordBaseAttr()
		successStr = Lang.get("summary_pet_level_team")
	else
		self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst["FUNC_PET_HELP_SLOT"..self._selectedPos])
		self:_recordBaseAttr()
		successStr = Lang.get("summary_pet_inbattle")
	end
	local param2 = {
		content = successStr,
		startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN},
		finishCallback = function()
			if self._onChangePetSummaryFinish then
				self:_onChangePetSummaryFinish()
			end
		end,
	} 
	table.insert(summary, param2)

	
	self:_addBaseAttrPromptSummary(summary)

	dump(summary)
	G_Prompt:showSummary(summary)

	--总战力
	G_Prompt:playTotalPowerSummary(UIConst.SUMMARY_OFFSET_X_TRAIN, -5) --(nil, -5)
end

--加入基础属性飘字内容
function PetDetailView:_addBaseAttrPromptSummary(summary)
	for i, one in ipairs(RECORD_ATTR_LIST) do
		local attrId = one[1]
		local dstNodeName = one[2]
		local diffValue = self._recordAttr:getDiffValue(attrId)

		if diffValue ~= 0 then
			local dstNode = self._nodePetDetailView:getSubNodeByName(dstNodeName)
			local param = {
				content = AttrDataHelper.getPromptContent(attrId, diffValue),
				anchorPoint = cc.p(0, 0.5),
				startPosition = {x = UIConst.SUMMARY_OFFSET_X_TRAIN+UIConst.SUMMARY_OFFSET_X_ATTR},
				dstPosition = dstNode and UIHelper.convertSpaceFromNodeToNode(dstNode, self) or nil,
				finishCallback = function()
					if self._nodePetDetailView then
						local dstNode = ccui.Helper:seekNodeByName(self._nodePetDetailView, dstNodeName) --self._nodePetDetailView:getSubNodeByName(dstNodeName)
						if attrId and dstNode and self._recordAttr then
							local curValue = self._recordAttr:getCurValue(attrId)
							dstNode:getSubNodeByName("TextValue"):updateTxtValue(curValue)
						end
					end
				end,
			}
			table.insert(summary, param)
		end
	end
	return summary
end


--更换神兽飘字结束后的回调
function PetDetailView:_onChangePetSummaryFinish()
	--更换神兽飘字结束后的回调
	self:runAction(cc.Sequence:create(
			cc.DelayTime:create(0.3),
			cc.CallFunc:create(function()
				G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, self.__cname)
			end)
		)
	)
end

-- i18n change lable
function PetDetailView:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")

		-- local image1 = UIHelper.seekNodeByName(self._buttonChange,"Image_4")
		-- UIHelper.swapWithLabel(image1,{ 
		-- 	 style = "team_3", 
		-- 	 text = Lang.getImgText("img_btn_replacetxt01") ,
		-- })
		
		-- local image2 = UIHelper.seekNodeByName(self._buttonUnload,"Image_4")
		-- UIHelper.swapWithLabel(image2,{ 
		-- 	 style = "team_3", 
		-- 	 text = Lang.getImgText("img_btn_replacetxt02") ,
		-- })
		

	end
end

 
function PetDetailView:getAvatar()
		return self._pageItems[self._selectedPos]:getChildren()[1] 
end

 
function PetDetailView:getDetailViewNode()
	return self._nodePetDetailView 
end

 
function PetDetailView:isShowButton(bSHow) 
	self._nodeButton:setVisible(bSHow)
end

 
function PetDetailView:getSelectTabIndex(bShow)  
	return self._selectTabIndex
end 

 
function PetDetailView:changeBackground(resPath) 
	local imgBg = UIHelper.seekNodeByName(self, "Image_44")

	if resPath == nil then  
		resPath = Path.getStageBG("img_transform_bg")
		resPath = string.gsub(resPath, "png", "jpg")
		imgBg:loadTexture(resPath)  
		imgBg:setPositionX(imgBg:getParent():getContentSize().width*0.5)
	else
		imgBg:loadTexture(resPath) -- 要先load在设置 顺序
		imgBg:setScale9Enabled(true)
		imgBg:setCapInsets(cc.rect(1200, 270,1,1))
		imgBg:setContentSize(cc.size(1600, imgBg:getContentSize().height))  
		imgBg:setAnchorPoint(0.5,0.5)
		imgBg:setPositionX(imgBg:getParent():getContentSize().width*0.44)
	end	
end

function PetDetailView:getPageView()
	return self._pageView
end

return PetDetailView