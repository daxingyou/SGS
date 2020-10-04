--
-- Author: Liangxu
-- Date: 2017-03-30 11:14:10
-- 查看阵容武将模块

local ViewBase = require("app.ui.ViewBase")
local UserDetailHeroNode = class("UserDetailHeroNode", ViewBase)
local TeamEquipIcon = require("app.scene.view.team.TeamEquipIcon")
local TeamTreasureIcon = require("app.scene.view.team.TeamTreasureIcon")
local TeamInstrumentIcon = require("app.scene.view.team.TeamInstrumentIcon")
local UserDataHelper = require("app.utils.UserDataHelper")
local AttributeConst = require("app.const.AttributeConst")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local AttrDataHelper = require("app.utils.data.AttrDataHelper")
local SilkbagIcon = require("app.scene.view.silkbag.SilkbagIcon")
local SilkbagConst = require("app.const.SilkbagConst")
local TeamHorseIcon = require("app.scene.view.team.TeamHorseIcon")

function UserDetailHeroNode:ctor(parentView, detailData)
	self._parentView = parentView
	self._detailData = detailData

	local resource = {
		file = Path.getCSB("UserDetailHeroNode", "common"),
		binding = {
			_buttonSilkbag = {
				events = {{event = "touch", method = "_onButtonSilkbagClicked"}}
			},
			_buttonEquip = {
				events = {{event = "touch", method = "_onButtonEquipClicked"}}
			}
		}
	}

	UserDetailHeroNode.super.ctor(self, resource)
end

function UserDetailHeroNode:onCreate()
	self:_dealPosByI18n()
	self:_initData()
	self:_initView()

	self:_swapImageByI18n()
end

function UserDetailHeroNode:_initData()
	self._switchIndex = 1
end

function UserDetailHeroNode:_initView()
	self._nodeDetailTitleBasic:setTitle(Lang.get("team_detail_title_basic"))
	self._nodeDetailTitleKarma:setTitle(Lang.get("team_detail_title_karma"))
	self._nodeDetailTitleYoke:setTitle(Lang.get("team_detail_title_yoke"))
	self._nodeLevel:setFontSize(17)
	self._nodePotential:setFontSize(17)
	for i = 1, 4 do
		self["_fileNodeAttr" .. i]:setFontSize(17)
	end

	--装备
	self._equipments = {}
	for i = 1, 4 do --4个装备
		local equip = TeamEquipIcon.new(self["_fileNodeEquip" .. i])
		table.insert(self._equipments, equip)
	end

	--宝物
	self._treasures = {}
	for i = 1, 2 do --2个宝物
		local treasure = TeamTreasureIcon.new(self["_fileNodeTreasure" .. i])
		table.insert(self._treasures, treasure)
	end

	--神兵
	self._instrument = TeamInstrumentIcon.new(self._fileNodeInstrument)

	--战马
	self._horse = TeamHorseIcon.new(self._fileNodeHorse)

	--锦囊
	for i = 1, SilkbagConst.SLOT_MAX do
		self["_silkbagIcon" .. i] = SilkbagIcon.new(i)
		self["_silkbagIcon" .. i]:setScale(0.8)
		self._panelSilkbag:addChild(self["_silkbagIcon" .. i])
	end
	local count2Pos = {
		[1] = {cc.p(247, 425)},
		[2] = {cc.p(105, 405), cc.p(390, 405)},
		[3] = {cc.p(247, 425), cc.p(115, 198), cc.p(380, 198)},
		[4] = {cc.p(140, 381), cc.p(356, 381), cc.p(140, 168), cc.p(355, 168)},
		[5] = {cc.p(247, 425), cc.p(102, 322), cc.p(391, 322), cc.p(158, 152), cc.p(337, 152)},
		[6] = {cc.p(247, 425), cc.p(116, 350), cc.p(379, 350), cc.p(115, 198), cc.p(379, 198), cc.p(247, 123)},
		[7] = {cc.p(247, 425), cc.p(128, 370), cc.p(365, 370), cc.p(99, 241), cc.p(396, 241), cc.p(180, 139), cc.p(313, 139)},
		[8] = {
			cc.p(247, 425),
			cc.p(140, 382),
			cc.p(356, 382),
			cc.p(94, 275),
			cc.p(399, 275),
			cc.p(139, 168),
			cc.p(354, 168),
			cc.p(247, 123)
		},
		[9] = {
			cc.p(247, 425),
			cc.p(148, 392),
			cc.p(345, 392),
			cc.p(97, 302),
			cc.p(398, 302),
			cc.p(115, 200),
			cc.p(380, 200),
			cc.p(196, 132),
			cc.p(300, 132)
		},
		[10] = {
			cc.p(201, 420),
			cc.p(294, 420),
			cc.p(125, 365),
			cc.p(370, 365),
			cc.p(95, 276),
			cc.p(398, 276),
			cc.p(125, 186),
			cc.p(370, 186),
			cc.p(200, 131),
			cc.p(293, 131)
		}
	}

	local count = 0
	for i = 1, SilkbagConst.SLOT_MAX do
		local isOpen = self._detailData:funcIsOpened(FunctionConst["FUNC_SILKBAG_SLOT" .. i])
		if isOpen then
			count = i
		else
			break
		end
	end

	self._showSilkbagIcons = {}
	for i = 1, SilkbagConst.SLOT_MAX do
		if i <= count then
			self["_silkbagIcon" .. i]:setVisible(true)
			self["_silkbagIcon" .. i]:setPosition(count2Pos[count][i])
			table.insert(self._showSilkbagIcons, self["_silkbagIcon" .. i])
		else
			self["_silkbagIcon" .. i]:setVisible(false)
		end
	end
end

function UserDetailHeroNode:onEnter()
end

function UserDetailHeroNode:onExit()
end

function UserDetailHeroNode:updateInfo(pos)
	self:_updateData(pos)
	self:_updateView()
	self:_switchEquipOrSilkbag()
end

function UserDetailHeroNode:_updateData(pos)
	self._pos = pos
	self._curHeroData = self._detailData:getHeroDataWithPos(pos)
	if self._curHeroData then
		self._allYokeData = UserDataHelper.getHeroYokeInfo(self._curHeroData)
	end
end

function UserDetailHeroNode:_updateView()
	self:_updateBaseInfo()
	self:_updateAttr()
	self:_updateSkill()
	self:_updateKarma()
	self:_updateYoke()
	self:_updateEquipment()
	self:_updateTreasure()
	self:_updateInstrument()
	self:_updateHorse()
	self:_updateSilkbag()
	self:_updatePower()
	self:_updateSilkbagBtn()
end

function UserDetailHeroNode:_updateBaseInfo()
	local level = self._curHeroData:getLevel()
	local heroConfig = self._curHeroData:getConfig()
	local rank = self._curHeroData:getRank_lv()
	local maxLevel = self._detailData:getLevel()

	if self._curHeroData:isPureGoldHero() then
		self._nodeLevel:updateUI(Lang.get("goldenhero_train_des"), rank, rank)
		self._nodeLevel:setMaxValue("")
	else
		self._nodeLevel:updateUI(Lang.get("team_detail_des_level"), level, maxLevel)
		self._nodeLevel:setMaxValue("/" .. maxLevel)
	end

	self._nodePotential:updateUI(Lang.get("team_detail_des_potential"), heroConfig.potential)
	self._fileNodeCountry:updateUI(self._curHeroData:getBase_id())
	if self._pos == 1 then
		self._fileNodeHeroName:setNameInUserDetail(self._detailData:getName(), self._detailData:getOfficeLevel(), rank)
	else
		self._fileNodeHeroName:setName(self._curHeroData:getBase_id(), rank, self._curHeroData:getLimit_level())
	end
	self:_updateAwake()
	self:_adjustPosByI18n()
end

--基础属性
function UserDetailHeroNode:_updateAttr()
	local attrInfo = UserDataHelper.getOtherUserTotalAttr(self._curHeroData, self._detailData)
	self._fileNodeAttr1:updateView(AttributeConst.ATK, attrInfo[AttributeConst.ATK])
	self._fileNodeAttr2:updateView(AttributeConst.PD, attrInfo[AttributeConst.PD])
	self._fileNodeAttr3:updateView(AttributeConst.HP, attrInfo[AttributeConst.HP])
	self._fileNodeAttr4:updateView(AttributeConst.MD, attrInfo[AttributeConst.MD])
end

--更新技能描述
function UserDetailHeroNode:_updateSkill()
	local skillIds = {}
	local avatarBaseId = self._detailData:getAvatarBaseId()
	if avatarBaseId > 0 and self._curHeroData:isLeader() then
		local heroBaseId = AvatarDataHelper.getAvatarConfig(avatarBaseId).hero_id
		local limitLevel = self._curHeroData:getLimit_level()
		skillIds = require("app.utils.data.HeroDataHelper").getSkillIdsWithBaseIdAndRank(heroBaseId, 0, limitLevel)
	else
		skillIds = require("app.utils.data.HeroDataHelper").getSkillIdsWithHeroData(self._curHeroData)
	end

	for i = 1, 3 do
		local skillId = skillIds[i]
		self["_fileNodeSkill" .. i]:updateUI(skillId, true)
	end
end

--缘分信息
function UserDetailHeroNode:_updateKarma()
	local imageMark = {
		[AttributeConst.ATK_PER] = {"img_com_team_sign02", "img_com_team_sign02b"}, --攻击加成
		[AttributeConst.DEF_PER] = {"img_com_team_sign04", "img_com_team_sign04b"}, --防御加成
		[AttributeConst.HP_PER] = {"img_com_team_sign03", "img_com_team_sign03b"} --生命加成
	}

	local allKaramData = UserDataHelper.getHeroKarmaData(self._curHeroData:getConfig())
	for i = 1, 6 do --6条缘分
		local data = allKaramData[i]
		local text = self["_textYuanFenDes" .. i]
		local mark = self["_imageYuanFenMark" .. i]
		local bg = self["_imageYuanFenBg" .. i]
		if data then
			text:setVisible(true)
			local isActivated = self._detailData:isKarmaActivated(data.id)
			local markInfo = imageMark[data.attrId]
			assert(markInfo, string.format("hero_friend config talent_attr is wrong = %d", data.attrId))
			local markRes = isActivated and markInfo[1] or markInfo[2]
			local color = isActivated and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_TWO
			text:setString(data.karmaName)
			text:setColor(color)
			mark:setVisible(true)
			mark:loadTexture(Path.getTeamUI(markRes))
			-- bg:setVisible(isActivated)
			bg:setVisible(false)
		else
			text:setVisible(false)
			mark:setVisible(false)
			bg:setVisible(false)
		end
	end
end

--羁绊信息
function UserDetailHeroNode:_updateYoke()
	for i = 1, 6 do --6条羁绊
		self:_updateOneYoke(i)
	end
end

--更新一条羁绊
function UserDetailHeroNode:_updateOneYoke(index)
	local allYokeData = self._allYokeData
	local text = self["_textJiBanDes" .. index]
	local mark = self["_imageJiBanMark" .. index]
	if allYokeData and allYokeData.yokeInfo and allYokeData.yokeInfo[index] then
		local info = allYokeData.yokeInfo[index]
		text:setVisible(true)
		local color = info.isActivated and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_TWO
		text:setString(info.name)
		text:setColor(color)
		if not Lang.checkLang(Lang.CN) then
			mark:setVisible(false)
			mark:getParent():setVisible(false)
		else
			mark:setVisible(info.isActivated)
		end
	else
		text:setVisible(false)
		mark:setVisible(false)
	end
end

--装备信息
function UserDetailHeroNode:_updateEquipment()
	local curPos = self._pos
	local heroData = self._detailData:getHeroDataWithPos(curPos)
	local heroBaseId = nil
	if heroData then
		heroBaseId = heroData:getAvatarToHeroBaseIdByAvatarId(self._detailData:getAvatarBaseId())
	end
	for i = 1, 4 do
		local equipIcon = self._equipments[i]
		local equipData = self._detailData:getEquipData(curPos, i)
		local isShow = self._detailData:isShowEquipJade()
		equipIcon:onlyShow(i, equipData, isShow, heroBaseId)
		-- equipIcon:showEffect()
	end
end

--宝物信息
function UserDetailHeroNode:_updateTreasure()
	local curPos = self._pos
	for i = 1, 2 do
		local treasureIcon = self._treasures[i]
		local treasureData = self._detailData:getTreasureData(curPos, i)
		treasureIcon:onlyShow(i, treasureData)
	end
end

--神兵信息
function UserDetailHeroNode:_updateInstrument()
	local curPos = self._pos
	local data = self._detailData:getInstrumentData(curPos, 1)
	self._instrument:onlyShow(data)
	self._instrument:showTextBg(false)
end

--战马信息
function UserDetailHeroNode:_updateHorse()
	local isOpen = self._detailData:funcIsOpened(FunctionConst.FUNC_HORSE)
	if not isOpen then
		self._fileNodeHorse:setVisible(false)
		return
	end
	self._fileNodeHorse:setVisible(true)
	local curPos = self._pos
	local data = self._detailData:getHorseData(curPos, 1)
	local horseEquipData = self._detailData:getHorseEquipData()
	self._horse:onlyShow(data, horseEquipData)
end

--锦囊
function UserDetailHeroNode:_updateSilkbag()
	local curPos = self._pos
	for i = 1, SilkbagConst.SLOT_MAX do
		self["_silkbagIcon" .. i]:onlyShow(curPos, self._detailData)
	end
end

--战斗力
function UserDetailHeroNode:_updatePower()
	local attrInfo = UserDataHelper.getOtherHeroPowerAttr(self._curHeroData, self._detailData)
	local power = AttrDataHelper.getPower(attrInfo)
	self._fileNodePower:updateUI(power)
	local width = self._fileNodePower:getWidth()
	local panelWidth = self._imageBtnBg:getContentSize().width
	local posX = (panelWidth - width) / 2
	self._fileNodePower:setPositionX(posX)
end

--觉醒显示
function UserDetailHeroNode:_updateAwake()
	local HeroTrainHelper = require("app.scene.view.heroTrain.HeroTrainHelper")
	local isOpen = HeroTrainHelper.checkIsReachAwakeInitLevel(self._curHeroData)
	local isCanAwake = self._curHeroData:isCanAwake()

	if isOpen and isCanAwake then
		self._imageAwakeBg:setVisible(true)
		local awakeLevel = self._curHeroData:getAwaken_level()
		local star = UserDataHelper.convertAwakeLevel(awakeLevel)
		self._nodeHeroStar:setStarOrMoon(star)
	else
		self._imageAwakeBg:setVisible(false)
	end
end

function UserDetailHeroNode:_onButtonSilkbagClicked()
	self._switchIndex = 2
	self:_switchEquipOrSilkbag()
end

function UserDetailHeroNode:_onButtonEquipClicked()
	self._switchIndex = 1
	self:_switchEquipOrSilkbag()
end

function UserDetailHeroNode:_switchEquipOrSilkbag()
	if self._switchIndex == 1 then --装备
		self._panelDetail:setVisible(true)
		self._panelSilkbag:setVisible(false)
	elseif self._switchIndex == 2 then --锦囊
		self._panelDetail:setVisible(false)
		self._panelSilkbag:setVisible(true)
	end
end

function UserDetailHeroNode:_updateSilkbagBtn()
	local isOpen = self._detailData:funcIsOpened(FunctionConst.FUNC_SILKBAG)
	self._buttonSilkbag:setVisible(isOpen)
end

function UserDetailHeroNode:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
	
		local image1 = UIHelper.seekNodeByName(self._buttonSilkbag,"Image_4")
		local label = UIHelper.swapWithLabel(image1,{ 
			 style = "team_3", 
			 text = Lang.getImgText("img_btn_silkbagtxt") ,
			 fontSize = 22,
		})

		label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
        label:getVirtualRenderer():setLineSpacing(-7 )
        
		
        local image2 =  UIHelper.seekNodeByName(self._buttonEquip,"Image_358")
	    local label2 =  UIHelper.swapWithLabel(image2,{
			 style = "icon_txt_3",
			 text = Lang.getImgText("txt_main_enter_equip") ,
			 offsetY = -30,
		})
		label2:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
        label2:getVirtualRenderer():setLineSpacing(-7 )
		
		

		local image3 =  UIHelper.seekNodeByName(self._buttonJade,"Image_358")
	    local label3 =  UIHelper.swapWithLabel(image3,{
			 style = "icon_txt_3",
			 text = Lang.getImgText("txt_main_enter6_jade") ,
			 offsetY = -30,
		})
		label3:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER )
		label3:getVirtualRenderer():setLineSpacing(-7 )
		
	end
end


-- i18n pos lable
function UserDetailHeroNode:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		for i = 1, 6 do
			self["_textYuanFenDes"..i]:setFontSize(self["_textYuanFenDes"..i]:getFontSize()-2)
			self["_textJiBanDes"..i]:setFontSize(self["_textJiBanDes"..i]:getFontSize()-2)

			self["_textYuanFenDes"..i]:setPositionX(self["_textYuanFenDes"..i]:getPositionX()-6)
			self["_textJiBanDes"..i]:setPositionX(self["_textJiBanDes"..i]:getPositionX()-6)

		end


		for i = 1, 4 do
			self["_fileNodeAttr"..i]:setFontSize(18)
		end

		self._nodeLevel:setFontSize(18)
		
		local nodeKama = UIHelper.seekNodeByName(self,"PanelAttr","nodeKama")
		for i = 1, 6 do
			local panel = UIHelper.seekNodeByName(nodeKama,"Panel_"..i)
			panel:setPositionX(panel:getPositionX()-10)
		end

		
		local nodeYoke = UIHelper.seekNodeByName(self,"nodeYoke")
		for i = 1, 6 do
			
			local panel = UIHelper.seekNodeByName(nodeYoke,"Panel_6_"..i)
			panel:setPositionX(panel:getPositionX()-30)

			self["_imageJiBanMark"..i]:setScale(0.8)
			self["_imageJiBanMark"..i]:setVisible(false)
			self["_imageJiBanMark"..i]:getParent():setVisible(false)
		end
	end

	if Lang.checkLang(Lang.TH) then
		self._nodeLevel:setPositionX(self._nodeLevel:getPositionX()-12)
		self._fileNodeAttr1:setPositionX(self._fileNodeAttr1:getPositionX()-12)
		self._fileNodeAttr2:setPositionX(self._fileNodeAttr2:getPositionX()-12)
	end

	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		self._nodeLevel:setPositionY(self._nodeLevel:getPositionY()+6)
		self._nodePotential:setPositionY(self._nodePotential:getPositionY()+6)
		for i = 1, 4 do
			self["_fileNodeAttr"..i]:setPositionY(self["_fileNodeAttr"..i]:getPositionY()+6)
		end
		for i = 1, 3 do
			self["_fileNodeSkill"..i]:setPositionY(self["_fileNodeSkill"..i]:getPositionY()+16)
		end
		local UIHelper  = require("yoka.utils.UIHelper")
		local nodeKama = UIHelper.seekNodeByName(self,"PanelAttr","nodeKama")
		nodeKama:setPositionY(nodeKama:getPositionY()+20)
		local nodeYoke = UIHelper.seekNodeByName(self,"nodeYoke")
		nodeYoke:setPositionY(nodeYoke:getPositionY()+32)
		for i = 1, 6 do
			local panel = ccui.Helper:seekNodeByName(nodeKama, "Panel_"..i)
			panel:setPositionY(panel:getPositionY()+7)
		end
		local img185 = ccui.Helper:seekNodeByName(nodeKama, "Image_185")
		img185:setPositionY(img185:getPositionY()+7)
		for i = 1, 6 do
			local panel = ccui.Helper:seekNodeByName(nodeYoke, "Panel_6_"..i)
			panel:setPositionY(85-math.floor((i-1)/2)*38)
			self["_textJiBanDes"..i]:setAnchorPoint(0,1)
			self["_textJiBanDes"..i]:getVirtualRenderer():setMaxLineWidth(155)
		end
	end

end



function UserDetailHeroNode:_adjustPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local textName = UIHelper.seekNodeByName(self._fileNodeHeroName,"TextName")
		self._fileNodeCountry:setPositionX(	self._fileNodeHeroName:getPositionX()-textName:getContentSize().width *0.5-18 )
	end
end	




return UserDetailHeroNode