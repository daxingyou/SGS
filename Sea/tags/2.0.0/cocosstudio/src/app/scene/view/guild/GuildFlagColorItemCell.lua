
-- Author: 
-- Date:2018-04-19 16:37:43
-- Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local GuildFlagColorItemCell = class("GuildFlagColorItemCell", ListViewCellBase)

function GuildFlagColorItemCell:ctor()
	self._imageColor = nil
	self._imageSelect = nil
	self._resourceNode = nil

	local resource = {
		file = Path.getCSB("GuildFlagColorItemCell", "guild"),
	
		binding = {
			_resourceNode = {
				events = {{event = "touch", method = "_onButton"}}
			},
		}
	}
	GuildFlagColorItemCell.super.ctor(self, resource)
end

function GuildFlagColorItemCell:onCreate()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end

function GuildFlagColorItemCell:updateUI(index)
	self._imageSelect:setVisible(false)
	self._imageColor:loadTexture(Path.getGuildFlagColorImage(index))
end

function GuildFlagColorItemCell:setSelect(select)
	self._imageSelect:setVisible(select)
end

function GuildFlagColorItemCell:_onButton(sender)
	logWarn("GuildFlagColorItemCell xdsds  44")
    local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
	if offsetX < 20 and offsetY < 20  then
       self:dispatchCustomCallback()
	end
end

return GuildFlagColorItemCell