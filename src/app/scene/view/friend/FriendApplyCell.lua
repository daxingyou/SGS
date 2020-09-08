
-- Author: nieming
-- Date:2017-12-26 17:07:48
-- Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local FriendApplyCell = class("FriendApplyCell", ListViewCellBase)
local FriendConst = require("app.const.FriendConst")
local TextHelper = require("app.utils.TextHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
function FriendApplyCell:ctor()

	--csb bind var name
	self._buttonAgree = nil  --CommonButton
	self._buttonRefuse = nil  --CommonButton
	self._guildName = nil  --Text
	self._icon = nil  --CommonIconTemplate
	self._level = nil  --Text
	self._playerName = nil  --CommonPlayerName
	self._powerNum = nil  --Text
	self._stateText = nil  --Text
	self._bg = nil

	local resource = {
		file = Path.getCSB("FriendApplyCell", "friend"),
		binding = {
			-- _buttonAgree = {
			-- 	events = {{event = "touch", method = "_onButtonAgree"}}
			-- },
			-- _buttonRefuse = {
			-- 	events = {{event = "touch", method = "_onButtonRefuse"}}
			-- },
			-- _btnAdd = {
			-- 	events = {{event = "touch", method = "_onButtonAdd"}}
			-- },
		},
	}
	FriendApplyCell.super.ctor(self, resource)
end

function FriendApplyCell:onCreate()
	self:_dealPosI18n()
	-- body
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	self._buttonRefuse:addClickEventListenerExDelay(handler(self,self._onButtonRefuse), 100)
	self._buttonAgree:addClickEventListenerExDelay(handler(self,self._onButtonAgree), 100)
end

function FriendApplyCell:updateUI(index, data)
	-- body
	self._data = data
	-- self._type = type

	-- if self._type == FriendConst.FRIEND_SUGGEST then
	-- 	self._btnAdd:setVisible(true)
	-- 	self._buttonAgree:setVisible(false)
	-- 	self._buttonRefuse:setVisible(false)
	-- else
	-- 	self._btnAdd:setVisible(false)
	-- 	self._buttonAgree:setVisible(true)
	-- 	self._buttonRefuse:setVisible(true)
	-- end


	if self._icon:isInit() then
		local heroIcon = self._icon:getIconTemplate()
		heroIcon:updateIcon(data:getPlayerShowInfo())
	else
		self._icon:unInitUI()
		self._icon:initUI(TypeConvertHelper.TYPE_HERO, data:getCovertId())
		local heroIcon = self._icon:getIconTemplate()
		heroIcon:updateIcon(data:getPlayerShowInfo())
	end
	self._commonHeadFrame:updateUI(data:getHead_frame_id(),self._icon:getScale())

	self._playerName:updateUI(data:getName(), data:getOffice_level())
	if not Lang.checkLang(Lang.CN)  then
		self._playerName:updateNameGap(0)
	end
	local guildName = data:getGuild_name()
	if guildName and guildName ~= "" then
		self._guildName:setString(guildName)
		self._guildName:setColor(Colors.BRIGHT_BG_ONE)
	else
		self._guildName:setString(Lang.get("siege_rank_no_crops"))
		self._guildName:setColor(Colors.BRIGHT_BG_RED)
	end
	self._level:setString(string.format("%d", data:getLevel()))

	self._powerNum:setString(TextHelper.getAmountText(data:getPower()))
	-- local onlineText, color = UserDataHelper.getOnlineText(data:getOnline())
	-- self._stateText:setString(onlineText)  --Text
	-- self._stateText:setColor(color)

	if index % 2 ~= 0 then
		self._bg:loadTexture(Path.getComplexRankUI("img_com_ranking04"))
	else
		self._bg:loadTexture(Path.getComplexRankUI("img_com_ranking05"))
	end
end
-- Describle：
function FriendApplyCell:_onButtonAgree()
	-- body
	self:dispatchCustomCallback(self._data, true)
end
-- Describle：
function FriendApplyCell:_onButtonRefuse()
	-- body
	self:dispatchCustomCallback(self._data, false)
end



function FriendApplyCell:_dealPosI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")

		self._guildName:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER )
		self._guildName:getVirtualRenderer():setLineSpacing(0 )
		self._guildName:getVirtualRenderer():setMaxLineWidth(100)
		
		
		local textName = UIHelper.seekNodeByName(self._playerName, "TextPlayerName")
		textName:setAnchorPoint(cc.p(0,0.5))
		textName:setPositionY(textName:getPositionY()+12)
		textName:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER )
		textName:setTextVerticalAlignment( cc.VERTICAL_TEXT_ALIGNMENT_CENTER  )
		textName:getVirtualRenderer():setLineSpacing(0 )
		textName:getVirtualRenderer():setMaxLineWidth(100)
		
	end
end

return FriendApplyCell
