--
-- Author: Liangxu
-- Date: 2017-9-16 15:49:24
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local InstrumentDetailFeatureNode = class("InstrumentDetailFeatureNode", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local CSHelper = require("yoka.utils.CSHelper")

function InstrumentDetailFeatureNode:ctor(instrumentData)
	self._instrumentData = instrumentData

	local resource = {
		file = Path.getCSB("InstrumentDetailDynamicModule2", "instrument"),
		binding = {
			
		},
	}
	InstrumentDetailFeatureNode.super.ctor(self, resource)
end

function InstrumentDetailFeatureNode:onCreate()
	local title = self:_createTitle()
	self._listView:pushBackCustomItem(title)

	if Lang.checkUI("ui4") then
		self._instrumentData:getAdvanceMaxLevel()
		self:_buildDes(1)
		self:_buildDes(2)
		if self._instrumentData:getAdvanceMaxLevel() >= 75 then
			self:_buildDes(3)
		end
		if self._instrumentData:getAdvanceMaxLevel() >= 100 then
			self:_buildDes(4)
		end
	else
		self:_buildDes(1)
		self:_buildDes(2)
		self:_buildDes(3)
		self:_buildDes(4)
	end

	
	self._listView:doLayout()
	local contentSize = self._listView:getInnerContainerSize()
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)
end

function InstrumentDetailFeatureNode:_createTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg2", "common"))
	title:setFontSize(22)
	title:setTitle(Lang.get("instrument_detail_title_feature"))
	local widget = ccui.Widget:create()
	local titleSize = cc.size(self._listView:getContentSize().width, 50)
	widget:setContentSize(titleSize)
	title:setPosition(titleSize.width / 2, 30)
	widget:addChild(title)

	return widget
end

function InstrumentDetailFeatureNode:_buildDes(type)
	local baseId = self._instrumentData:getBase_id()
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_INSTRUMENT, baseId)
	local unlockLevel = 0
	if type == 1 then
		unlockLevel = param.unlock
	elseif type == 2 then
		unlockLevel = param.cfg.unlock_1
	elseif type == 3 then
		unlockLevel = param.cfg.unlock_2
	elseif type == 4 then
		unlockLevel = param.cfg.unlock_3
	end
	if unlockLevel == 0 then
		return nil
	end

	--标题部分
	local node = CSHelper.loadResourceNode(Path.getCSB("InstrumentDetailFeatureNode", "instrument"))
	local panelBg = ccui.Helper:seekNodeByName(node, "PanelBg")
	local textName = ccui.Helper:seekNodeByName(node, "TextName")
	local textUnlock = ccui.Helper:seekNodeByName(node, "TextUnlock")

	local nameDes = Lang.get("instrument_detail_feature_level_title", {level = unlockLevel})
	textName:setString(nameDes)
	textName:setPositionX(10)
	textName:setFontSize(18)
	textName:setFontName(Path.getCommonFont())

	textUnlock:setString(Lang.get("instrument_detail_advance_unlock2", {level = unlockLevel}))
	local size = textName:getContentSize()
	local posX = textName:getPositionX() + size.width
	textUnlock:setPositionX(posX)
	textUnlock:setFontSize(18)

	local level = self._instrumentData:getLevel()
	local isUnlock = level >= unlockLevel --是否解锁特性
	textUnlock:setVisible(not isUnlock)

	local widget1 = ccui.Widget:create()
	local size = cc.size(326, panelBg:getContentSize().height)   
	widget1:setContentSize(size)
	widget1:addChild(node)
	self._listView:pushBackCustomItem(widget1)

	--描述部分
	local description = ""
	if G_UserData:getBase():isEquipAvatar() and self._instrumentData:getPos() == 1 then --有穿变身卡，且主角穿戴了此神兵
		local avatarId = G_UserData:getBase():getAvatar_base_id()
		local heroId = AvatarDataHelper.getAvatarConfig(avatarId).hero_id
		if type == 1 then
			description = AvatarDataHelper.getAvatarMappingConfig(heroId).description
		elseif type == 2 then
			description = AvatarDataHelper.getAvatarMappingConfig(heroId).description_1
		elseif type == 3 then
			description = AvatarDataHelper.getAvatarMappingConfig(heroId).description_2
		elseif type == 4 then
			description = AvatarDataHelper.getAvatarMappingConfig(heroId).description_3
		end
	else
		if type == 1 then
			description = param.description
		elseif type == 2 then
			description = param.cfg.description_1
		elseif type == 3 then
			description = param.cfg.description_2
		elseif type == 4 then
			description = param.cfg.description_3
		end
	end

	local textDes = cc.Label:createWithTTF(description, Path.getCommonFont(), 18)
	textDes:setAnchorPoint(cc.p(0, 1))
	textDes:setLineHeight(22)
	textDes:setWidth(326-20)
	local desColor = isUnlock and Colors.SYSTEM_TARGET_RED or Colors.BRIGHT_BG_TWO
	textDes:setColor(desColor)

	local widget2 = ccui.Widget:create()
	local height = textDes:getContentSize().height
	textDes:setPosition(cc.p(10, height + 15))
	widget2:addChild(textDes)
	local size = cc.size(self._listView:getContentSize().width, height + 15)
	widget2:setContentSize(size)
	self._listView:pushBackCustomItem(widget2)
end

return InstrumentDetailFeatureNode