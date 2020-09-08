--
-- Author: hedili
-- Date: 2018-01-30 17:57:20
-- 神兽升星
local ViewBase = require("app.ui.ViewBase")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PetTrainStarLayer = class("PetTrainStarLayer", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local AttributeConst = require("app.const.AttributeConst")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local CSHelper = require("yoka.utils.CSHelper")
local AudioConst = require("app.const.AudioConst")
local PetTrainHelper = require("app.scene.view.petTrain.PetTrainHelper")

--根据材料数量，定义材料的位置
-- i18n pos lable
local MATERIAL_POS = {
	[1] = {{166, 56}},
	[2] = {{92, 68}, {235, 68}},
	[3] = {{60, 56}, {163, 56}, {269, 56}}-- 需有修改
}

function PetTrainStarLayer:ctor(parentView)
	self._parentView = parentView
	local resource = {
		file = Path.getCSB("PetTrainStarLayer2", "pet"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonStar = {
				events = {{event = "touch", method = "_onButtonBreakClicked"}}
			},
			_buttonTalentDes = {
				events = {{event = "touch", method = "_onButtonTalentDesClicked"}},
			}
		}
	}
	self:enableNodeEvents() 
	self:setName("PetTrainStarLayer")
	PetTrainStarLayer.super.ctor(self, resource)
end

function PetTrainStarLayer:onCreate()
	self:_doLayout()
	-- i18n pos lable
	self:_dealPosI18n()
	self:_initData()
	self:_initView()
end

function PetTrainStarLayer:onEnter()
	self._signalPetStarUp =
		G_SignalManager:add(SignalConst.EVENT_PET_STAR_UP_SUCCESS, handler(self, self._petStarUpSuccess))

	self:_updateInfo()
end

function PetTrainStarLayer:onExit()
	self._signalPetStarUp:remove()
	self._signalPetStarUp = nil
end

function PetTrainStarLayer:_doLayout()
    local contentSize = self._parentView._listView:getContentSize() --self._panelBg:getContentSize() 
	self:setContentSize(contentSize)                                --  设置node节点尺寸   
end

function PetTrainStarLayer:initInfo()
	self:_updateInfo()
	self:_updateInfo()
	--local selectedPos = self._parentView:getSelectedPos()
	--self._pageView:setCurrentPageIndex(selectedPos - 1)
end

function PetTrainStarLayer:_initData()
	self._isReachLimit = false -- 是否达到上限
	self._conditionLevel = false
	self._isPageViewMoving = false --pageview是否在拖动过程中
end

function PetTrainStarLayer:_initView()
	self._materialIcons = {}
	self._buttonStar:setFontSize(20)
	self._buttonStar:setFontName(Path.getFontW8())
	self._buttonStar:setString(Lang.get("pet_break_btn_break"))
	self._fileNodeDetailTitle:setFontSize(22)
	self._fileNodeDetailTitle2:setFontSize(22)
	self._fileNodeDetailTitle:setTitle(Lang.get("pet_break_detail_title"))
	self._fileNodeDetailTitle2:setTitle(Lang.get("pet_break_cost_title"))
	self._parentView:getTalentDes():getParent():setVisible(true)
	self._fileNodePetNew = self._parentView:getPetAvatar()
	self._textLevelTitle:setString(self._textLevelTitle:getString() .. ":")  
end
 
 
function PetTrainStarLayer:_updateInfo()
	self._petId = G_UserData:getPet():getCurPetId()
	self._petUnitData = G_UserData:getPet():getUnitDataWithId(self._petId)
	self._starLevel = self._petUnitData:getStar()
	self._isReachLimit = UserDataHelper.isReachStarLimit(self._petUnitData)

	self:setButtonEnable(true)
	self:_updateShow()
	self:_updateAttr()
	self:_updateCost()
end

function PetTrainStarLayer:_updateShow()
	local petBaseId = self._petUnitData:getBase_id()
	local starLevel = self._petUnitData:getStar()

	local strDes = ""

	--self._fileNodeHeroName:setConvertType(TypeConvertHelper.TYPE_PET)
	-- self._fileNodeHeroName2:setConvertType(TypeConvertHelper.TYPE_PET)
	-- self._fileNodeHeroName2:setFontSize(18)
	-- self._fileNodeHeroName2:setName(petBaseId)
	--self._fileNodeStar:setCount(starLevel)
	self._nodeTitle:setName(5)

	-- 天赋描述
	if UserDataHelper.isReachStarLimit(self._petUnitData) then
		self._imageTalentBg:setVisible(false)  
		self._parentView:getTalentDes():setVisible(false)  
		return
	end

	local starLevel = self._petUnitData:getStar() + 1
	local petStarConfig = UserDataHelper.getPetStarConfig(self._petUnitData:getBase_id(), starLevel)
	local talentName = petStarConfig.talent_name
	local talentDes = petStarConfig.talent_description
	local breakDes = Lang.get("pet_break_txt_break_des", {rank = starLevel})
	local talentInfo =
		Lang.get(
		"pet_break_txt_talent_des",
		{
			name = talentName,
			des = talentDes,
			breakDes = breakDes
		}
	)

	if talentName == "" then
		self._imageTalentBg:setVisible(false)  
		self._parentView:getTalentDes():setVisible(false)
	else   
		talentInfo = string.gsub(talentInfo, talentName..":", "")  
		talentInfo = string.gsub(talentInfo, "\"fontSize\":22", "\"fontSize\":18")   -- 修改字号
		local richText = ccui.RichText:createWithContent(talentInfo)
		richText:setAnchorPoint(cc.p(0.5, 1))
		richText:ignoreContentAdaptWithSize(false)
		richText:setContentSize(cc.size(360,0))
		richText:formatText()
		local height = richText:getVirtualRendererSize().height + 43
		self._parentView._imageTalentBg:setContentSize(cc.size(370, height))  
		
		self._parentView._nodeBreakDesc:removeAllChildren()
		self._parentView._nodeBreakDesc:addChild(richText)

		-- 天赋描述
		self._parentView._textTalentTitle:setString("[" .. talentName .. "]") 
		-- 叹号按钮描述
		local Names = Lang.get("hero_gold_txt_talent_title2", {talentName = talentName})
		local labelName = ccui.RichText:createWithContent(Names)
		labelName:setAnchorPoint(cc.p(0, 0.5))
		labelName:setPositionX(0)
		self._nodeTalentName:removeAllChildren()
		self._nodeTalentName:addChild(labelName)   
	end 
end

function PetTrainStarLayer:_updateAttr()
	self._textOldStar:setString(Lang.get("pet_break_txt_break_title", {level = self._starLevel}))

	local strRankLevel = nil
	if self._isReachLimit == true then
		local strStarLevel = Lang.get("pet_break_txt_reach_limit")
		self._textNewStar:setString(strStarLevel)
		self._textNewAdd:setString(strStarLevel)

		local curBreakAttr = UserDataHelper.getPetBreakShowAttr(self._petUnitData)
		local oldPercent =
			Lang.get(
			"pet_break_txt_add",
			{
				percent = math.floor(curBreakAttr[AttributeConst.PET_ALL_ATTR] / 10)
			}
		)
		self._textOldAdd:setString(oldPercent)
		return
	end

	local strRankLevel = Lang.get("pet_break_txt_break_title", {level = self._starLevel + 1})

	self._textNewStar:setString(strRankLevel)

	local curBreakAttr = UserDataHelper.getPetBreakShowAttr(self._petUnitData)
	local nextBreakAttr = UserDataHelper.getPetBreakShowAttr(self._petUnitData, 1) or {}

	local oldPercent =
		Lang.get(
		"pet_break_txt_add",
		{
			percent = math.floor(curBreakAttr[AttributeConst.PET_ALL_ATTR] / 10)
		}
	)
	local newPercent =
		Lang.get(
		"pet_break_txt_add",
		{
			percent = math.floor(nextBreakAttr[AttributeConst.PET_ALL_ATTR] / 10)
		}
	)

	self._textOldAdd:setString(oldPercent)
	self._textNewAdd:setString(newPercent)
end

function PetTrainStarLayer:_updateCost()
	self._costCardNum = 0
	self._fileNodeDetailTitle2:setVisible(not self._isReachLimit)
	self._nodeResource:setVisible(not self._isReachLimit)
	self._panelCost:removeAllChildren()
	self._nodeNeedLevelPos:removeAllChildren()

	self._buttonStar:setEnabled(not self._isReachLimit)
	if self._isReachLimit then --达到顶级了
		-- i18n change lable
		if not Lang.checkLang(Lang.CN) then
			self._buttonStar:setVisible(false)
			--添加背景图
			local sp = cc.Sprite:create(Path.getTextTeam("img_zr_anwen"))
			local size = self._panelCost:getContentSize()
			sp:setPosition(cc.p(size.width/2, size.height/2))
			self._panelCost:addChild(sp)

			local size = self._panelCost:getContentSize()
			local UIHelper  = require("yoka.utils.UIHelper")
			local label = UIHelper.createLabel(
				{
					style = "team_max_level_ja", 
					text =  Lang.getImgText("txt_train_breakthroughtop") ,
					position = cc.p(size.width/2, size.height/2) ,
					anchorPoint = cc.p(0.5,0.5),
				}
			)
			label:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER  )
			self._panelCost:addChild(label)
		else
			local sp = cc.Sprite:create(Path.getTextTeam("img_beast_upstar"))
			local size = self._panelCost:getContentSize()
			sp:setPosition(cc.p(size.width/2, size.height/2))
			self._panelCost:addChild(sp)
		end
		return
	end

	--材料
	self._materialIcons = {}
	self._materialInfo = {}
	self._resourceInfo = {}
	local allMaterialInfo = UserDataHelper.getPetBreakMaterials(self._petUnitData)
	for i, info in ipairs(allMaterialInfo) do
		if info.type ~= TypeConvertHelper.TYPE_RESOURCE then --排除银币
			table.insert(self._materialInfo, info)
		else
			table.insert(self._resourceInfo, info)
		end
	end
	local _createMaterialIcon = 
		function (info)
			local node = CSHelper.loadResourceNode(Path.getCSB("CommonCostNode", "common"))
			node:setCloseMode()
			node:updateView(info, self._petUnitData:getId())
			return node
		end
	local len = #self._materialInfo
	for i, info in ipairs(self._materialInfo) do
		local item = _createMaterialIcon(info)
		local pos = cc.p(MATERIAL_POS[len][i][1], MATERIAL_POS[len][i][2])
		item:setPosition(pos)
		self._panelCost:addChild(item)
		table.insert(self._materialIcons, item)
		if info.type == TypeConvertHelper.TYPE_PET then
			self._costCardNum = self._costCardNum + item:getNeedCount()
		end
	end

	self:_adjustCostPosAndSize()

	--银币
	local resource = self._resourceInfo[1]
	if resource then
		self._nodeResource:updateUI(resource.type, resource.value, resource.size)
		self._nodeResource:setTextColor(Colors.BRIGHT_BG_TWO)
		self._nodeResource:setVisible(true)
	else
		self._nodeResource:setVisible(false)
	end

	--需要等级
	local myLevel = self._petUnitData:getLevel()
	local needLevel = UserDataHelper.getPetBreakLimitLevel(self._petUnitData)
	local colorNeed =
		myLevel < needLevel and Colors.colorToNumber(Colors.BRIGHT_BG_RED) or Colors.colorToNumber(Colors.BRIGHT_BG_GREEN)
	local needLevelInfo =
		Lang.get(
		"pet_break_txt_need_level",
		{
			value1 = myLevel,
			color = colorNeed,
			value2 = needLevel
		}
	)
	needLevelInfo = string.gsub(needLevelInfo, "\"fontSize\":20", "\"fontSize\":16")   -- 修改字号
	needLevelInfo = string.gsub(needLevelInfo, "\"color\":\"0xb46414\",\"fontSize\":20", "\"color\":\"0xb46414\",\"fontSize\":18")
	local richTextNeedLevel = ccui.RichText:createWithContent(needLevelInfo)
	richTextNeedLevel:setAnchorPoint(cc.p(0, 0))
	self._nodeNeedLevelPos:addChild(richTextNeedLevel)
	self._conditionLevel = myLevel >= needLevel
end

function PetTrainStarLayer:_adjustCostPosAndSize()
	--银币
	self._nodeResource:getChildByName("Text"):setFontSize(18)
	self._nodeResource:getChildByName("Text"):setPositionX(18 + 15)
	self._nodeResource:getChildByName("Image"):setPositionY(18)
	self._nodeResource:getChildByName("Image"):setScale(0.8)
	-- local width = self._nodeResource:getChildByName("Text"):getContentSize().width + 12 + self._nodeResource:getChildByName("Image"):getContentSize().width*0.8 			
	-- width = width*0.5
	-- self._nodeResource:setPositionX(width*-1) 
	
   --材料
   local len = self._panelCost:getChildrenCount()
   for i=1,len do
	   local child = self._panelCost:getChildren()[i]
	   
	   child:getChildByName("TextName"):setAnchorPoint(cc.p(0.5, 0))
	   child:getChildByName("TextName"):setPosition(cc.p(0, 40))
	   --child:setCloseMode(true)

	   local size = child:getChildByName("FileNodeIcon"):getChildByName("ImageTemplate"):getContentSize()
	   child:getChildByName("NodeNumPos"):getChildren()[1]:setAnchorPoint(cc.p(0.5, 0.5))
	   child:getChildByName("NodeNumPos"):setPosition(cc.p(0, -size.height*0.44))  
	   child:getChildByName("NodeNumPos"):setScale(18/22)
	   child:getChildByName("TextName"):setFontSize(18)
   end
end

function PetTrainStarLayer:setButtonEnable(enable)
	self._buttonStar:setEnabled(enable)
	-- self._pageView:setEnabled(enable)
	-- if self._parentView and self._parentView.setArrowBtnEnable then
	-- 	self._parentView:setArrowBtnEnable(enable)
	-- end
end

function PetTrainStarLayer:_onButtonBreakClicked()
	if self._isReachLimit then
		G_Prompt:showTip(Lang.get("pet_break_reach_limit_tip"))
		return
	end
	if not self._conditionLevel then
		G_Prompt:showTip(Lang.get("pet_break_condition_no_level"))
		return
	end
	for i, icon in ipairs(self._materialIcons) do
		local isReachCondition = icon:isReachCondition()
		if not isReachCondition then
			local info = self._materialInfo[i]
			local param = TypeConvertHelper.convert(info.type, info.value)
			G_Prompt:showTip(Lang.get("pet_break_condition_no_cost", {name = param.name}))
			return
		end
	end
	for i, info in ipairs(self._resourceInfo) do
		local enough = require("app.utils.LogicCheckHelper").enoughValue(info.type, info.value, info.size)
		if not enough then
			return false
		end
	end

	self:_doPetBreak()
end

function PetTrainStarLayer:_doPetBreak()
	local id = self._petUnitData:getId()
	local config = self._petUnitData:getConfig()
	local petBaseId = self._petUnitData:getBase_id()
	local initial_star = self._petUnitData:getInitial_star()

	if config.color == 6 and initial_star == 0 then
		-- 非原始红神兽升星消耗
		petBaseId = config.potential_before
	end

	local petIds = {}
	local sameCards = G_UserData:getPet():getSameCardCountWithBaseId(petBaseId, id)
	local count = 0
	for k, card in pairs(sameCards) do
		if count >= self._costCardNum then
			break
		end
		table.insert(petIds, card:getId())
		count = count + 1
	end
	if config.color == 6 and initial_star == 0 then
		-- 非原始红神兽升星
		G_UserData:getPet():c2sPetStarUp(id, nil, petIds)
	else
		G_UserData:getPet():c2sPetStarUp(id, petIds, nil)
	end
	self:setButtonEnable(false)
end

function PetTrainStarLayer:_petStarUpSuccess()
	self:_playEffect()
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint()
		self._parentView:refreshBtnAndUI()
	end
end

function PetTrainStarLayer:showPetAvatar()
	--self._fileNodeHeroOld:setOpacity(255)
	self._fileNodePetNew:setOpacity(255)
end

function PetTrainStarLayer:_playEffect()
	local function eventFunctionBo(event)
		if event == "finish" and self and self._petId then
			local popupBreakResult = require("app.scene.view.petTrain.PopupPetBreakResult2").new(self, self._petId)
			popupBreakResult:open()
			
			self:setButtonEnable(true)
			self:_updateInfo()
		end
	end
	local gfxEffect = G_EffectGfxMgr:createPlayGfx(self._parentView._nodeBreakEffect, "effect_wujiang_up", eventFunctionBo)
	do return end  -- 策划需求：去掉下面特效

	local function effectFunction(effect)
		if effect == "effect_wujiangtupo_ningju" then
			local subEffect = EffectGfxNode.new("effect_wujiangtupo_ningju")
			subEffect:play()
			return subEffect
		end

		if effect == "effect_wujiangtupo_feichu" then
			local subEffect = EffectGfxNode.new("effect_wujiangtupo_feichu")
			subEffect:play()
			return subEffect
		end

		if effect == "effect_wujiangtupo_xingxing" then
			local subEffect = EffectGfxNode.new("effect_wujiangtupo_xingxing")
			subEffect:play()
			return subEffect
		end

		if effect == "effect_wujiangtupo_daguang" then
			local subEffect = EffectGfxNode.new("effect_wujiangtupo_daguang")
			subEffect:play()
			return subEffect
		end

		if effect == "effect_wujiangtupo_xiaoxing" then
			local subEffect = EffectGfxNode.new("effect_wujiangtupo_xiaoxing")
			subEffect:play()
			return subEffect
		end

		if effect == "effect_wujiangtupo_guangqiu" then
			local subEffect = EffectGfxNode.new("effect_wujiangtupo_guangqiu")
			subEffect:play()
			return subEffect
		end

		if effect == "effect_wujiangtupo_shuxian" then
			local subEffect = EffectGfxNode.new("effect_wujiangtupo_shuxian")
			subEffect:play()
			return subEffect
		end

		if effect == "effect_wujiangtupo_xiaosan" then
			local subEffect = EffectGfxNode.new("effect_wujiangtupo_xiaosan")
			subEffect:play()
			return subEffect
		end

		return cc.Node:create()
	end

	local function eventFunction(event)
		if event == "1p" then
			local action = cc.FadeOut:create(0.3)
			--self._fileNodeHeroOld:runAction(action)
			G_AudioManager:playSoundWithId(AudioConst.SOUND_HERO_BREAK) --播音效
		elseif event == "2p" then
			local action = cc.FadeOut:create(0.3)
			self._fileNodePetNew:runAction(action)
		elseif event == "finish" then
			local function eventFunctionBo(event)
				if event == "finish" and self and self._petId then
					local popupBreakResult = require("app.scene.view.petTrain.PopupPetBreakResult2").new(self, self._petId)
					popupBreakResult:open()
					
					self:setButtonEnable(true)
					self:_updateInfo()
				end
			end
			local gfxEffect = G_EffectGfxMgr:createPlayGfx(self._parentView._nodeBreakEffect, "effect_wujiang_up", eventFunctionBo)
		end
	end

	local effect =
		G_EffectGfxMgr:createPlayMovingGfx(G_SceneManager:getRunningScene(), "moving_shenshoushengxing1", effectFunction, eventFunction, false)

	effect:setPosition(G_ResolutionManager:getDesignCCPoint())
end

--全范围的情况，突破如果消耗同名卡，要重新更新列表
--此处特殊处理，重新建一遍pageView
function PetTrainStarLayer:updatePageView()
	--self:_initPageView()
	--self:_updatePageItem()
	self:_updateShow()
end

function PetTrainStarLayer:_onButtonTalentDesClicked()
	self._parentView:getTalentDes():setVisible( not self._parentView:getTalentDes():isVisible() )
end

-- i18n pos lable
function PetTrainStarLayer:_dealPosI18n()
	if Lang.checkLang(Lang.JA) then
		return 
	end   

	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local panel156 = UIHelper.seekNodeByName(self,"Panel_156")
		local textLevel0 = UIHelper.seekNodeByName(panel156,"TextLevel_0")
		local textLevel = UIHelper.seekNodeByName(panel156,"TextLevel")
		
		local x = math.max(textLevel0:getContentSize().width,textLevel:getContentSize().width)
		
		
        self._textOldAdd:setPositionX( textLevel0:getPositionX() + x + 10)
		self._textNewAdd:setPositionX( self._textOldAdd:getPositionX() + 85)

		self._textOldStar:setPositionX(textLevel:getPositionX() + x +  10)

		local image449 = UIHelper.seekNodeByName(panel156,"Image_449")
		image449:setPositionX(self._textOldStar:getPositionX()+62)

		self._textNewStar:setPositionX(image449:getPositionX() + 42)
        
		
	
		self._fileNodeDetailTitle:setPositionX(self._fileNodeDetailTitle:getPositionX()+10)
	--	self._nodeBreakDesc:setPositionY(self._nodeBreakDesc:getPositionY()+18)

	end
end






return PetTrainStarLayer