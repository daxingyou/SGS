-- Author: dingjunlong
-- Date:2020-09-16 15:17:53
-- Describle：名将画卷

local ViewBase = require("app.ui.ViewBase")
local TeamPictureScrollView = class("TeamPictureScrollView", ViewBase)
local TeamPictureNode = require("app.scene.view.teamPictureScroll.TeamPictureNode")
local TeamPictureShareLayer = require("app.scene.view.teamPictureScroll.TeamPictureShareLayer")
local BigImagesNode = require("app.utils.BigImagesNode")
local TeamPictureConst = require("app.scene.view.teamPictureScroll.TeamPictureConst")
local AudioConst = require("app.const.AudioConst")
local UIConst = require("app.const.UIConst")
local UIHelper  = require("yoka.utils.UIHelper")
local UserDataHelper = require("app.utils.UserDataHelper")

TeamPictureScrollView.BTN_ID = {
	BTN_WEI = 1,
	BTN_SHU = 2,
	BTN_WU  = 3,
	BTN_QUN = 4
}

local btnTexturePath = {"img_wei", "img_shu", "img_wu", "img_qun"}

function TeamPictureScrollView:ctor()
	self._btnType = {}
	self._chooseBtnId = -1  	-- 当前选中的buttonId
	self._scroll = nil		-- 滚动地图
	self._innerContainer = nil	-- 滚动容器内核
	

	self._heroInfo = {{}, {}, {}, {}} 
	self._pictureNodes = {{}, {}, {}, {}}     -- 绘卷列表
	self._canActivateOrUpgradeNodes = {{}, {}, {}, {}}
	self._clickPictureNode = -1
	self._redPointShow = {false, false, false, false}
	self._attackSum = 0

    local resource = {
		size = G_ResolutionManager:getDesignSize(),
		file = Path.getCSB("TeamPictureScrollView", "teamPictureScroll"),
		binding = {
			_btnWei = {
				events = {{event = "touch", method = "_onBtnWei"}}
			},
			_btnShu = {
				events = {{event = "touch", method = "_onBtnShu"}}
			},
			_btnWu = {
				events = {{event = "touch", method = "_onBtnWu"}}
			},
			_btnQun = {
				events = {{event = "touch", method = "_onBtnQun"}}
			},
			_btnShare = {
				events = {{event = "touch", method = "_onBtnShare"}}
			},
			_btnAttr = {
				events = {{event = "touch", method = "_onBtnAttr"}}
			},
		},
	}
	TeamPictureScrollView.super.ctor(self, resource)
end

function TeamPictureScrollView:onCreate()
	self._topBar:setTitle("絵巻", 32, Colors.DARK_BG_THREE, Colors.DARK_BG_OUTLINE, true)
	self._btnTxt:setString("詳細")
	self._btnAttr:setVisible(false)
	self._teamBtn = {self._btnWei, self._btnShu, self._btnWu, self._btnQun}
	
	self._innerContainer = self._scroll:getInnerContainer()
	self._scroll:setScrollBarEnabled(false)

	self:_addMap()

	self:_dealNodeRich()
	self:_playFloatXEffect(self._imageArrow)

	self:_initRedPoint()
	self._attackSum = G_UserData:getBase():getPower()
	self._attackLabel:setString(self._attackSum)
end

function TeamPictureScrollView:onEnter()
	G_UserData:getHandBook():c2sGetResPhoto()

	self._getHandBookInfo = G_SignalManager:add(SignalConst.EVENT_GET_RES_PHOTO_SUCCESS, handler(self, self._getResPhotoInfoSucess))

	self._getHeroEmakiInfo =
	G_SignalManager:add(SignalConst.EVENT_GET_TEAM_INFO_SUCCESS, handler(self, self._updateView))

	-- 激活
	self._getActivateHeroEmaki =
	G_SignalManager:add(SignalConst.EVENT_ACTIVE_HERO_SUCCESS, handler(self, self._activateHeroSucess))
	-- 升级
	self._getLevelUpHeroEmaki =
	G_SignalManager:add(SignalConst.EVENT_LEVELUP_HERO_SUCCESS, handler(self, self._levelUpHeroSucess))

	-- 暂时屏蔽分享
	self._nodeShareRewardParent:setVisible(false)
	self._btnShare:setVisible(false)
end

function TeamPictureScrollView:_getResPhotoInfoSucess()
	print(">>>>>> Log _getResPhotoInfoSucess: ")
	G_UserData:getTeamPictureData():c2sGetHeroEmakiInfo()
end

function TeamPictureScrollView:_activateHeroSucess()
	G_AudioManager:playSoundWithId(AudioConst.SOUND_HERO_LV) --播音效
	local index, pictureNode = self:_getPictureHeroNodeByid(G_UserData:getTeamPictureData():getActivateHeroEmaki().id, TeamPictureNode.STATUS.HAS_ACTIVATE)
	pictureNode:refreshCellDataAndUI(TeamPictureNode.STATUS.HAS_ACTIVATE)
	self:_refreshRedPoint(index)

	G_UserData:getAttr():setLastPower(self._attackSum)
	self:_refreshSumAttack(pictureNode:getPictureNodeAllCombat())
	G_UserData:getAttr():setCurPower(self._attackSum)

	self:_addBaseAttrPromptSummary(pictureNode)

	G_Prompt:playTotalPowerSummary()
end

function TeamPictureScrollView:_levelUpHeroSucess()
	G_AudioManager:playSoundWithId(AudioConst.SOUND_HERO_LV) --播音效
	local index, pictureNode = self:_getPictureHeroNodeByid(G_UserData:getTeamPictureData():getLevelUpHeroEmaki().id, TeamPictureNode.STATUS.HAS_UPGRADE)
	pictureNode:refreshCellDataAndUI(TeamPictureNode.STATUS.HAS_UPGRADE)
	self:_refreshRedPoint(index)

	G_UserData:getAttr():setLastPower(self._attackSum)
	self:_refreshSumAttack(pictureNode:getPictureNodeFinalCombat())
	G_UserData:getAttr():setCurPower(self._attackSum)

	G_Prompt:playTotalPowerSummary()
end

function TeamPictureScrollView:_addBaseAttrPromptSummary(pictureNode)
	local TextHelper = require("app.utils.TextHelper")
	local AttrDataHelper = require("app.utils.data.AttrDataHelper")

	local summary = {}
	-- local indexArr = {1, 5, 6, 7}
	local indexArr = {80, 81, 82, 83}  -- 暂时写死

	for index = 1, 4 do
		local param = {
			content = AttrDataHelper.getPromptContent(indexArr[index], pictureNode:getPictureNodeActive_valueById(index)),
			anchorPoint = cc.p(0, 0.5),
			startPosition = {x = UIConst.TEAM_PICTURE_OFFSET_X_ACTIVATE},
			finishCallback = function()
			end,
		}
		table.insert(summary, param)
	end
	G_Prompt:showSummary(summary)
end

function TeamPictureScrollView:_refreshSumAttack(attack)
	self._attackSum = self._attackSum + attack
	self._attackLabel:updateTxtValue(self._attackSum, nil, 5)
	self._attackLabel:setString(self._attackSum)
end

function TeamPictureScrollView:_getPictureHeroNodeByid(id, status)
	for i = 1, #self._heroInfo do
		for j = 1, #self._heroInfo[i] do
			local info = self._heroInfo[i][j]
			if info.id == id then
				info.status = status
				if info.exitUpgrade and G_UserData:getTeamPictureData():getActivateHeroEmaki().status == TeamPictureNode.STATUS.HAS_ACTIVATE then
					info.status = TeamPictureNode.STATUS.CAN_UPGRADE
				end
				return i, self._pictureNodes[i][j]
			end
		end
	end
end

function TeamPictureScrollView:_refreshRedPoint(index)
	self._redPointShow[index] = false
	self._canActivateOrUpgradeNodes[index] = {}
	for i = 1, #self._heroInfo[index] do
		local shuInfo = self._heroInfo[index][i]
		if shuInfo.status == TeamPictureNode.STATUS.CAN_ACTIVATE or shuInfo.status == TeamPictureNode.STATUS.CAN_UPGRADE then
			self._redPointShow[index] = true
			table.insert(self._canActivateOrUpgradeNodes[index], shuInfo)
		end
	end
	self["_redPoint" .. index]:setVisible(self._redPointShow[index])
end

function TeamPictureScrollView:onExit()
	self._getHandBookInfo:remove()
	self._getHandBookInfo = nil

	self._getHeroEmakiInfo:remove()
	self._getHeroEmakiInfo = nil
	
	self._getActivateHeroEmaki:remove()
	self._getActivateHeroEmaki = nil

	self._getLevelUpHeroEmaki:remove()
	self._getLevelUpHeroEmaki = nil
end

function TeamPictureScrollView:_resetData()
	self._heroInfo = {{}, {}, {}, {}} 
	self._pictureNodes = {{}, {}, {}, {}}     -- 绘卷列表
	self._canActivateOrUpgradeNodes = {{}, {}, {}, {}}
	self._redPointShow = {false, false, false, false}
end

function TeamPictureScrollView:_updateView()
	self:_resetData()
	self:_initData()
	self:_initRedPoint()
	self:_addTeamNode()
	self._btnAttr:setVisible(true)
end

function TeamPictureScrollView:_dealNodeRich()
	self._nodeRich:removeAllChildren()
    local CommonAward = require("app.config.common_award")
    local config =  CommonAward.get(8)
    
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local content = json.decode(Lang.get("show_hero2_share_reward",{num = config.size1}))
    for k,v in ipairs(content) do
        if v.type == "custom" then
            local param = TypeConvertHelper.convert(config.type1,config.value1)
            local sprite = display.newSprite(param.res_mini)
            local spriteSize = sprite:getContentSize()
            local node = cc.Node:create()
            node:addChild(sprite)
            node:setContentSize(cc.size(spriteSize.width,18))
            sprite:setPosition(spriteSize.width*0.5,12)
            v.customNode = node
            v.opacity = 255
        end
    end
    
    local label = nil
    if Lang.checkLang(Lang.CN) then
        label = ccui.RichText:create()
    else
        label = ccui.RichText:createByI18n()         
    end
    label:setRichText(content)
    label:setVerticalSpace(5)
    label:ignoreContentAdaptWithSize(false)
    label:setContentSize(cc.size(210, 0))
    label:formatText()
    
    label:setAnchorPoint(cc.p(0.5,0.5))
    self._nodeRich:addChild(label)
end

--播放左右浮动动画
function TeamPictureScrollView:_playFloatXEffect(node)
	-- body
	if not node then return end

	local action1 = cc.MoveBy:create(0.75, cc.p(5, 0))
	local fade1 = cc.FadeTo:create(0.75, 255)
	local spawn1 = cc.Spawn:create(action1,fade1)

	local action2 = cc.MoveBy:create(0.75, cc.p(-5, 0))
	local fade2 = cc.FadeTo:create(0.75, 255*0.5)
	local spawn2 = cc.Spawn:create(action2,fade2)

	local seq = cc.Sequence:create(spawn1,spawn2)
	local rep = cc.RepeatForever:create(seq)

	node:runAction(rep)
end


function TeamPictureScrollView:_addMap()
	local innerSize = self._scroll:getInnerContainerSize()

	local imgArr = {}
    for index = 1, 3 do
        local spr = cc.Sprite:create(Path.getTeamPictureScroll("bg", ".jpg"))
        table.insert(imgArr, spr)
    end
	self._bigBg = self:_createImg(imgArr)

	-- self._bigBg = cc.Sprite:create(Path.getTeamPictureScroll("bg", ".jpg"))
    self._bigBg:setAnchorPoint(0, 0)
    self._bigBg:setPosition(0, 0)
	self._scroll:addChild(self._bigBg, -10)
	-- innerSize.width = self._bigBg:getContentSize().width

	-- self._scroll:setInnerContainerSize(innerSize)
end

function TeamPictureScrollView:_createImg(imgArr)
    local node = cc.Node:create()
    local nodeHeight = node:getContentSize().height
    for i = 1, #imgArr - 1 do
        imgArr[i]:setAnchorPoint(0, 0)
        nodeHeight = math.max(nodeHeight, imgArr[i]:getBoundingBox().height)
        node:setContentSize(cc.size(node:getContentSize().width + imgArr[i]:getBoundingBox().width, nodeHeight))
        imgArr[i + 1]:setPositionX(imgArr[i]:getPositionX() + imgArr[i]:getBoundingBox().width)
        node:addChild(imgArr[i])
    end
    imgArr[#imgArr]:setAnchorPoint(0, 0)
    nodeHeight = math.max(nodeHeight, imgArr[#imgArr]:getBoundingBox().height)
    node:setContentSize(cc.size(node:getContentSize().width + imgArr[#imgArr]:getBoundingBox().width, nodeHeight))
    node:addChild(imgArr[#imgArr])
    return node
end

function TeamPictureScrollView:_initData()

	local heroConfig = require("app.config.hero")
	local config = require("app.config.hero_emaki")

	local len = config.length()
	for i = 1, len do
		local info = config.indexOf(i)

		local heroInfo = heroConfig.get(info.id)
		info.name = heroInfo.name
		info.color = heroInfo.color
		info.country = heroInfo.country
		info.limit = heroInfo.limit
		info.limit_red = heroInfo.limit_red

		if info.color == 4 or info.color == 5 or info.color == 6 then
			if info.country == 1 then  -- 魏
				local weiInfo = self:_createTableInfo(info)
				table.insert(self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_WEI], weiInfo)
			elseif info.country == 2 then -- 蜀
				local shuInfo = self:_createTableInfo(info)
				table.insert(self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_SHU], shuInfo)
			elseif info.country == 3 then  -- 吴
				local wuInfo = self:_createTableInfo(info)
				table.insert(self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_WU], wuInfo)
			elseif info.country == 4 then  -- 群
				local qunInfo = self:_createTableInfo(info)
				table.insert(self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_QUN], qunInfo)
			end
		end
	end

	self:_sortInfo(self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_WEI])
	for index = 1, #self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_WEI] do
		local weiInfo = self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_WEI][index]

		weiInfo.heroNodePos = TeamPictureConst.heroNodePos[TeamPictureScrollView.BTN_ID.BTN_WEI][index]
		weiInfo.namePos = TeamPictureConst.namePos[TeamPictureScrollView.BTN_ID.BTN_WEI][index]
		weiInfo.heroNodeZorder = TeamPictureConst.heroNodeZorder[TeamPictureScrollView.BTN_ID.BTN_WEI][index]
		weiInfo.spineScale = TeamPictureConst.spineScale[TeamPictureScrollView.BTN_ID.BTN_WEI][index]
		weiInfo.signPos = TeamPictureConst.signPos[TeamPictureScrollView.BTN_ID.BTN_WEI][index]
	
		if (weiInfo.status == TeamPictureNode.STATUS.CAN_ACTIVATE or weiInfo.status == TeamPictureNode.STATUS.CAN_UPGRADE) then
			self._redPointShow[TeamPictureScrollView.BTN_ID.BTN_WEI] = true
			table.insert(self._canActivateOrUpgradeNodes[TeamPictureScrollView.BTN_ID.BTN_WEI], weiInfo)
		end
	end

	self:_sortInfo(self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_SHU])
	for index = 1, #self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_SHU] do
		local shuInfo = self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_SHU][index]

		shuInfo.heroNodePos = TeamPictureConst.heroNodePos[TeamPictureScrollView.BTN_ID.BTN_SHU][index]
		shuInfo.namePos = TeamPictureConst.namePos[TeamPictureScrollView.BTN_ID.BTN_SHU][index]
		shuInfo.heroNodeZorder = TeamPictureConst.heroNodeZorder[TeamPictureScrollView.BTN_ID.BTN_SHU][index]
		shuInfo.spineScale = TeamPictureConst.spineScale[TeamPictureScrollView.BTN_ID.BTN_SHU][index]
		shuInfo.signPos = TeamPictureConst.signPos[TeamPictureScrollView.BTN_ID.BTN_SHU][index]

		if (shuInfo.status == TeamPictureNode.STATUS.CAN_ACTIVATE or shuInfo.status == TeamPictureNode.STATUS.CAN_UPGRADE) then
			self._redPointShow[TeamPictureScrollView.BTN_ID.BTN_SHU] = true
			table.insert(self._canActivateOrUpgradeNodes[TeamPictureScrollView.BTN_ID.BTN_SHU], shuInfo)
		end
	end

	self:_sortInfo(self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_WU])
	for index = 1, #self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_WU] do
		local wuInfo = self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_WU][index]

		wuInfo.heroNodePos = TeamPictureConst.heroNodePos[TeamPictureScrollView.BTN_ID.BTN_WU][index]
		wuInfo.namePos = TeamPictureConst.namePos[TeamPictureScrollView.BTN_ID.BTN_WU][index]
		wuInfo.heroNodeZorder = TeamPictureConst.heroNodeZorder[TeamPictureScrollView.BTN_ID.BTN_WU][index]
		wuInfo.spineScale = TeamPictureConst.spineScale[TeamPictureScrollView.BTN_ID.BTN_WU][index]
		wuInfo.signPos = TeamPictureConst.signPos[TeamPictureScrollView.BTN_ID.BTN_WU][index]

		if (wuInfo.status == TeamPictureNode.STATUS.CAN_ACTIVATE or wuInfo.status == TeamPictureNode.STATUS.CAN_UPGRADE) then
			self._redPointShow[TeamPictureScrollView.BTN_ID.BTN_WU] = true
			table.insert(self._canActivateOrUpgradeNodes[TeamPictureScrollView.BTN_ID.BTN_WU], wuInfo)
		end
	end

	self:_sortInfo(self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_QUN])
	for index = 1, #self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_QUN] do
		local qunInfo = self._heroInfo[TeamPictureScrollView.BTN_ID.BTN_QUN][index]

		qunInfo.heroNodePos = TeamPictureConst.heroNodePos[TeamPictureScrollView.BTN_ID.BTN_QUN][index]
		qunInfo.namePos = TeamPictureConst.namePos[TeamPictureScrollView.BTN_ID.BTN_QUN][index]
		qunInfo.heroNodeZorder = TeamPictureConst.heroNodeZorder[TeamPictureScrollView.BTN_ID.BTN_QUN][index]
		qunInfo.spineScale = TeamPictureConst.spineScale[TeamPictureScrollView.BTN_ID.BTN_QUN][index]
		qunInfo.signPos = TeamPictureConst.signPos[TeamPictureScrollView.BTN_ID.BTN_QUN][index]

		if (qunInfo.status == TeamPictureNode.STATUS.CAN_ACTIVATE or qunInfo.status == TeamPictureNode.STATUS.CAN_UPGRADE) then
			self._redPointShow[TeamPictureScrollView.BTN_ID.BTN_QUN] = true
			table.insert(self._canActivateOrUpgradeNodes[TeamPictureScrollView.BTN_ID.BTN_QUN], qunInfo)
		end
	end
end

function TeamPictureScrollView:_judgeIdInArrInfo(id, info, idField)
	for index, value in ipairs(info) do
		if id == value[idField] then
			return true
		end
	end
	return false
end

function TeamPictureScrollView:_judgeStatus(id, info, idField)
	for index, value in ipairs(info) do
		if id == value[idField] then
			return value.status
		end
	end
end

function TeamPictureScrollView:_judgeUpGrade(id, info)
	for index, value in ipairs(info) do
		if value.status == 1 then  -- 已激活，可升级状态
			-- body
		elseif value.status == 2 then -- 已经升级过了
			-- body
		end
	end
end


function TeamPictureScrollView:_createTableInfo(info)
	local tableInfo = {}

	tableInfo.id = info.id
	tableInfo.limit_level = info.limit
	tableInfo.limit_rtg = info.limit_red
	tableInfo.color = info.color
	tableInfo.country = info.country
	tableInfo.name = info.name
	tableInfo.limit = info.limit
	tableInfo.active_value1 = info.active_value1
	tableInfo.active_value2 = info.active_value2
	tableInfo.active_value3 = info.active_value3
	tableInfo.active_value4 = info.active_value4
	tableInfo.lv_up_value1 = info.lv_up_value1
	tableInfo.lv_up_value2 = info.lv_up_value2
	tableInfo.lv_up_value3 = info.lv_up_value3
	tableInfo.lv_up_value4 = info.lv_up_value4
	tableInfo.all_combat = info.all_combat
	tableInfo.final_combat = info.final_combat

	tableInfo.isHaveHero = G_UserData:getHandBook():isHeroHave(tableInfo.id)  -- 是否拥有这个英雄
	tableInfo.status = -1

	tableInfo.exitUpgrade = false  -- 是否真的存在升级条件
	local isBoundaryBreak = tableInfo.limit_level == 1 or tableInfo.limit_rtg == 1
	if isBoundaryBreak then
		local toRed = G_UserData:getHandBook():isHeroHave(tableInfo.id, require("app.const.HeroConst").HERO_LIMIT_RED_MAX_LEVEL)  -- 是否可以升级
		local toGolden = G_UserData:getHandBook():isHeroHave(tableInfo.id, nil, require("app.const.HeroConst").HERO_LIMIT_GOLD_MAX_LEVEL)  -- 是否可以升级
		tableInfo.exitUpgrade = toRed or toGolden
	end
	tableInfo.exitUpgrade = false -- 暂时屏蔽升级
	if tableInfo.isHaveHero then
		if not self:_judgeIdInArrInfo(tableInfo.id, G_UserData:getTeamPictureData():getHeroEmakiInfo(), "id") then 
			-- 不在HeroEmakiInfo里面肯定没激活过，可激活状态
			tableInfo.status = 0
		else
			-- 1：已经激活了， 2： 已经升级了
			tableInfo.status = self:_judgeStatus(tableInfo.id, G_UserData:getTeamPictureData():getHeroEmakiInfo(), "id")
		end

		if tableInfo.exitUpgrade then -- 存在升级但还没激活，则不能升级
			if tableInfo.status == 1 then
				tableInfo.status = 3  -- 可以升级
			end
		end
	else
		tableInfo.status = -1
	end

	return tableInfo
end

function TeamPictureScrollView:_sortInfo(info)
	table.sort(info, function(a, b)
		if a.color ~= b.color then
			return a.color > b.color
		else
			return a.id < b.id
		end
	end)
end

function TeamPictureScrollView:_initRedPoint()
	for index = 1, 4 do
		self["_redPoint" .. index]:setVisible(self._redPointShow[index])
	end
end

function TeamPictureScrollView:_addTeamNode()

	self:_onBtnWei()
	-- self:_onBtnShu()
	-- self:_onBtnWu()
	-- self:_onBtnQun()
end

function TeamPictureScrollView:_resetPictureNode()
	for i = 1, #self._pictureNodes do
		for j = 1, #self._pictureNodes[i] do
			if self._pictureNodes[i][j] then
				self._pictureNodes[i][j]:setVisible(false)
			end
		end
	end
end

function TeamPictureScrollView:_refreshPictureNode(chooseId, isVisible)
	if chooseId == -1 then
		return
	end
	local pictureArr = self._pictureNodes[chooseId]
	local len = #pictureArr
	if len == 0 then
		self._scroll:jumpToLeft()
		self:_createPictureMap(self._chooseBtnId)
		return
	end
	if isVisible then
		self._scroll:jumpToLeft()
	end
	for index = 1, len do
		pictureArr[index]:setVisible(isVisible)
	end

	-- if self._rt and not tolua.isnull(self._rt) then
	-- 	self._rt:release()
	-- end
end

function TeamPictureScrollView:_createPictureMap(countryId)
	local countryInfo = self._heroInfo[countryId]
	for index, value in pairs(countryInfo) do
		local heroInfo = countryInfo[index]
		local pictureNode = TeamPictureNode.new(self, heroInfo, countryId, function(type)
			self._clickPictureNode = index
			print(">>>>>> Log id", heroInfo.id, type)
			if type == TeamPictureNode.STATUS.CAN_ACTIVATE then  -- 激活
				G_UserData:getTeamPictureData():c2sActivateHeroEmaki(heroInfo.id, heroInfo.limit_level, heroInfo.limit_rtg)
			elseif type == TeamPictureNode.STATUS.CAN_UPGRADE then  -- 升级
				G_UserData:getTeamPictureData():c2sLevelUpHeroEmaki(heroInfo.id, heroInfo.limit_level, heroInfo.limit_rtg)
			end
		end)
		pictureNode:setAnchorPoint(0.5, 0.5)
		
		if heroInfo.heroNodeZorder then
			pictureNode:setLocalZOrder(heroInfo.heroNodeZorder)
		end
		
		pictureNode:setPosition(heroInfo.heroNodePos)

		table.insert(self._pictureNodes[countryId], pictureNode)
		self._scroll:addChild(pictureNode)
	end
end

function TeamPictureScrollView:_loadBtnTexture(chooseId, id)
	if chooseId == -1 then
		return
	end
	self._teamBtn[chooseId]:loadTextureNormal(Path.getTeamPictureScroll(btnTexturePath[chooseId] .. id))
end

function TeamPictureScrollView:_onBtnWei()
	if self._chooseBtnId == TeamPictureScrollView.BTN_ID.BTN_WEI then
		self:_scrollJump()
		return
	end

	self:_loadBtnTexture(self._chooseBtnId, 2)
	self:_refreshPictureNode(self._chooseBtnId, false)
	self:_resetPictureNode()
	self._chooseBtnId = TeamPictureScrollView.BTN_ID.BTN_WEI
	self:_setScrollInnerContainerSize(250)
	self:_loadBtnTexture(self._chooseBtnId, 1)
	self:_refreshPictureNode(self._chooseBtnId, true)

	self:_scrollJump(true)
end

function TeamPictureScrollView:_onBtnShu()
	if self._chooseBtnId == TeamPictureScrollView.BTN_ID.BTN_SHU then
		self:_scrollJump()
		return
	end
	self:_loadBtnTexture(self._chooseBtnId, 2)
	self:_refreshPictureNode(self._chooseBtnId, false)
	self:_resetPictureNode()
	self._chooseBtnId = TeamPictureScrollView.BTN_ID.BTN_SHU
	self:_setScrollInnerContainerSize(240)
	self:_loadBtnTexture(self._chooseBtnId, 1)
	self:_refreshPictureNode(self._chooseBtnId, true)

	self:_scrollJump(true)
end

function TeamPictureScrollView:_onBtnWu()
	if self._chooseBtnId == TeamPictureScrollView.BTN_ID.BTN_WU then
		self:_scrollJump()
		return
	end
	self:_loadBtnTexture(self._chooseBtnId, 2)
	self:_refreshPictureNode(self._chooseBtnId, false)
	self:_resetPictureNode()
	self._chooseBtnId = TeamPictureScrollView.BTN_ID.BTN_WU
	self:_setScrollInnerContainerSize(220)
	self:_loadBtnTexture(self._chooseBtnId, 1)
	self:_refreshPictureNode(self._chooseBtnId, true)

	self:_scrollJump(true)
end

function TeamPictureScrollView:_onBtnQun()
	if self._chooseBtnId == TeamPictureScrollView.BTN_ID.BTN_QUN then
		self:_scrollJump()
		return
	end
	self:_loadBtnTexture(self._chooseBtnId, 2)
	self:_refreshPictureNode(self._chooseBtnId, false)
	self:_resetPictureNode()
	self._chooseBtnId = TeamPictureScrollView.BTN_ID.BTN_QUN
	self:_setScrollInnerContainerSize(210)
	self:_loadBtnTexture(self._chooseBtnId, 1)
	self:_refreshPictureNode(self._chooseBtnId, true)

	self:_scrollJump(true)
end

function TeamPictureScrollView:_scrollJump(isScroll)
	if #self._canActivateOrUpgradeNodes[self._chooseBtnId] == 0 then
		if isScroll then
			self._scroll:jumpToLeft()
		end
	else
		self:_setScrollInnerContainerPosX(self._canActivateOrUpgradeNodes[self._chooseBtnId][1].heroNodePos.x)
	end
end

function TeamPictureScrollView:_setScrollInnerContainerPosX(posX)

	if posX <= CC_DESIGN_RESOLUTION.width / 2 then
		self._scroll:jumpToLeft()
	else
		if posX - CC_DESIGN_RESOLUTION.width / 2 >= self._scroll:getInnerContainerSize().width -  CC_DESIGN_RESOLUTION.width then
			self._scroll:jumpToRight()
		else
			self._innerContainer:setPositionX(-(posX - CC_DESIGN_RESOLUTION.width / 2))
		end
	end
end

function TeamPictureScrollView:_setScrollInnerContainerSize(deltaWidth)
	local size = #TeamPictureConst.heroNodePos[self._chooseBtnId]
	
	self._scroll:setInnerContainerSize(cc.size(TeamPictureConst.heroNodePos[self._chooseBtnId][size].x + deltaWidth, self._innerContainer.height))
end

function TeamPictureScrollView:_onBtnAttr()
	local allHeroInfo = {}
	for i = 1, 4 do
		local heroInfo = self._heroInfo[i]
		for j = 1, #heroInfo do
			local info = heroInfo[j]
			if info.status == TeamPictureNode.STATUS.HAS_ACTIVATE or info.status == TeamPictureNode.STATUS.HAS_UPGRADE then
				table.insert(allHeroInfo, info)
			end
		end
	end

	local attackSum = 0
	local wufanSum = 0
	local mofanSum = 0
	local hpSum = 0
	for index = 1, #allHeroInfo do
		if allHeroInfo[index].status == TeamPictureNode.STATUS.HAS_ACTIVATE then
			attackSum = attackSum + allHeroInfo[index].active_value1
			wufanSum = wufanSum + allHeroInfo[index].active_value2
			mofanSum = mofanSum + allHeroInfo[index].active_value3
			hpSum = hpSum + allHeroInfo[index].active_value4
		end
		if allHeroInfo[index].status == TeamPictureNode.STATUS.HAS_UPGRADE then
			attackSum = attackSum + allHeroInfo[index].lv_up_value1
			wufanSum = wufanSum + allHeroInfo[index].lv_up_value2
			mofanSum = mofanSum + allHeroInfo[index].lv_up_value3
			hpSum = hpSum + allHeroInfo[index].lv_up_value4
		end
	end

	local sumInfo = {attackSum, wufanSum, mofanSum, hpSum} 
	local UIPopupHelper = require("app.utils.UIPopupHelper")
	UIPopupHelper.popupActivate(5, sumInfo)
end

function TeamPictureScrollView:_onBtnShare()
	self:_showShare(false)

	local drawSpr = self:_drawTeamPicture(cc.rect(0, 0, self._scroll:getInnerContainerSize().width, self._scroll:getInnerContainerSize().height))

	local shareLayer = TeamPictureShareLayer.new(self)
	shareLayer:addChild(drawSpr, 100)
	self:addChild(shareLayer)
end

function TeamPictureScrollView:_showShare(isShow)
    self._nodeShareRewardParent:setVisible(isShow)
    self._btnShare:setVisible(isShow)
end

function TeamPictureScrollView:_drawTeamPicture(rect)
	self._camera = cc.Camera:createOrthographic(1136, 640, 0, 1)
    self._camera:setCameraFlag(cc.CameraFlag.DEFAULT)
    self._scroll:addChild(self._camera)
	self._scroll:setCameraMask(1)
	
	local label = cc.Label:createWithSystemFont("游卡桌游", "Arial", 50)
    label:setAnchorPoint(1, 0.5)
    label:setColor(cc.c3b(255, 0, 0))
    label:setPosition(2000, 40)
    self._scroll:addChild(label)

	-- self._rt = cc.RenderTexture:create(rect.width, rect.height, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888, 0x88F0)
	-- self._rt = cc.RenderTexture:create(rect.width, rect.height, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888, gl.DEPTH24_STENCIL8_OES)
	-- self._rt = cc.RenderTexture:create(rect.width, rect.height, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888, gl.DEPTH24_STENCIL8_OES)
	self._rt = cc.RenderTexture:create(rect.width, rect.height)
    self._rt:beginWithClear(0, 0, 0, 0)
    self._scroll:visit()
    self._rt:endToLua()
	self._rt:retain()
	
	local texture = self._rt:getSprite():getTexture()
    self._spr = cc.Sprite:createWithTexture(texture)
    -- self._spr:setAnchorPoint(0.5, 0.5)
    self._spr:setAnchorPoint(0, 0.5)
    self._spr:setFlippedY(true)
    self._spr:setScale(0.3)
    -- self._spr:setScale(0.24)
    -- self._spr:setPosition(1136 / 2, 640 / 2)
    self._spr:setPosition(0, 640 / 2)

	local label1 = cc.Label:createWithSystemFont("", "Arial", 50)
	label1:setString(G_UserData:getBase():getName())
    label1:setColor(cc.c3b(255, 0, 0))
    label1:setPosition(400, 40)
    self._spr:addChild(label1)

    self:_performWithDelay(function()
        self._camera:removeFromParent(true)
        label:removeFromParent(true)
	end, 0.1)
	
	return self._spr
end


function TeamPictureScrollView:_performWithDelay(callback, delay)
    local delay = cc.DelayTime:create(delay)
    local sequence = cc.Sequence:create(delay, cc.CallFunc:create(callback))
    self:runAction(sequence)
    return sequence
end

return TeamPictureScrollView
