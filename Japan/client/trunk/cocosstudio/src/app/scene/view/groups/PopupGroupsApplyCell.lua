
-- Author: zhanglinsen
-- Date:2018-09-10 10:46:32
-- Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupGroupsApplyCell = class("PopupGroupsApplyCell", ListViewCellBase)
local GroupsConst = require("app.const.GroupsConst")
local TextHelper = require("app.utils.TextHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function PopupGroupsApplyCell:ctor()
	local resource = {
		file = Path.getCSB("PopupGroupsApplyCell", "groups"),
		binding = {
			_buttonAgree = {
				events = {{event = "touch", method = "_onButtonAgree"}}
			},
			_buttonRefuse = {
				events = {{event = "touch", method = "_onButtonRefuse"}}
			},
		},
	}
	PopupGroupsApplyCell.super.ctor(self, resource)
end

function PopupGroupsApplyCell:onCreate()
	if not Lang.checkLang(Lang.CN)  then
		self:_dealPosI18n()
	end	
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end

function PopupGroupsApplyCell:updateUI(index, data)
	self._data = data

	self._icon:updateUI(data:getCovertId(), nil, data:getLimitLevel())
	-- self._icon:setLevel(data:getLevel())

	
	self._commonHeadFrame:updateUI(data:getHead_frame_id(),self._icon:getScale())
	self._commonHeadFrame:setLevel(data:getLevel())
	self._playerName:updateUI(data:getName(), data:getOffice_level())
	local guildName = data:getGuild_name()
	if guildName and guildName ~= "" then
		self._guildName:setString(guildName)
		self._guildName:setColor(Colors.BRIGHT_BG_ONE)
	else
		self._guildName:setString(Lang.get("siege_rank_no_crops"))
		self._guildName:setColor(Colors.BRIGHT_BG_RED)
	end
	self._powerNum:setString(TextHelper.getAmountText(data:getPower()))

	if data and not data:isEndApply() then
		local applyEndTime = data:getApplyEndTime()
		self._buttonRefuse:startCountDown(applyEndTime, handler(self, self._countDownEnd), handler(self, self._countDownFormatStr))
	end

	if index % 2 ~= 0 then
		self._bg:loadTexture(Path.getUICommon("img_com_board_list02a"))
	else
		self._bg:loadTexture(Path.getUICommon("img_com_board_list02b"))
	end
end

function PopupGroupsApplyCell:_countDownEnd()
	
end

function PopupGroupsApplyCell:_countDownFormatStr(endTime)
	local time = G_ServerTime:getLeftSeconds(endTime)
	local str = ""
	if time < 10 then 
		str = " " 
	end
	str = str .. time .. "s"
	return str
end

function PopupGroupsApplyCell:_onButtonAgree()
	self:dispatchCustomCallback(1, GroupsConst.OK)
end

function PopupGroupsApplyCell:_onButtonRefuse()
	self:dispatchCustomCallback(1, GroupsConst.NO)
end

-- i18n pos lable
function PopupGroupsApplyCell:_dealPosI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
    
		
		local textName = UIHelper.seekNodeByName(self._playerName, "TextPlayerName")
		textName:setAnchorPoint(cc.p(0,0.5))
		textName:setPositionY(textName:getPositionY()+12)
		textName:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER )
		textName:setTextVerticalAlignment( cc.VERTICAL_TEXT_ALIGNMENT_CENTER  )
		textName:getVirtualRenderer():setLineSpacing(0 )
		textName:getVirtualRenderer():setMaxLineWidth(100)
		
	end
end


return PopupGroupsApplyCell