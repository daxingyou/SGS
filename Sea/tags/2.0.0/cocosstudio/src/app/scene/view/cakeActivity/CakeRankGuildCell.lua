--
-- Author: Liangxu
-- Date: 2019-4-30
-- 蛋糕活动军团排行榜Cell

local ListViewCellBase = require("app.ui.ListViewCellBase")
local CakeRankGuildCell = class("CakeRankGuildCell", ListViewCellBase)
local CakeActivityDataHelper = require("app.utils.data.CakeActivityDataHelper")

function CakeRankGuildCell:ctor()
	local resource = {
		file = Path.getCSB("CakeRankGuildCell", "cakeActivity"),
		binding = {
			
		}
	}
	CakeRankGuildCell.super.ctor(self, resource)
end

function CakeRankGuildCell:onCreate()
	local size = self._panelBg:getContentSize()
	self:setContentSize(size.width, size.height)
	self._imageArrow:ignoreContentAdaptWithSize(true)
end

function CakeRankGuildCell:update(data)
	self._textRank:setString(data:getRank())
	local serverName = CakeActivityDataHelper.formatServerName(data:getServer_name(), 5)
	self._textInfo:setString(serverName.." "..data:getGuild_name())
	self._textScore:setString(Lang.get("cake_activity_cake_level", {level = data:getCake_level()}))
	self._imageArrow:loadTexture(Path.getUICommon(data:getChangeResName()))
end


return CakeRankGuildCell
