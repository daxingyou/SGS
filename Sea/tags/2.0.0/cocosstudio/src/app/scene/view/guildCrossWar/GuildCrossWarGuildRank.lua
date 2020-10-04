-- @Author  panhoa
-- @Date  3.20.2019
-- @Role 
local ViewBase = require("app.ui.ViewBase")
local GuildCrossWarGuildRank = class("GuildCrossWarGuildRank", ViewBase)
local TabScrollView = require("app.utils.TabScrollView")
local GuildCrossWarHelper = import(".GuildCrossWarHelper")
local GuildCrossWarGuildRankCell = import(".GuildCrossWarGuildRankCell")
local TextHelper = require("app.utils.TextHelper")
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")


function GuildCrossWarGuildRank:ctor()
    -- body
    self._listView    = nil
    self._tabListView = nil
    self._imageOwn    = nil
    self._imageOwnback= nil
    self._rankData    = {}

    local resource = {
        file = Path.getCSB("GuildCrossWarGuildRank", "guildCrossWar"),
    }
    GuildCrossWarGuildRank.super.ctor(self, resource)
end

function GuildCrossWarGuildRank:onCreate()
    local size = self._resourcePanel:getContentSize()
    self:setContentSize(size.width, size.height)
    self:_initListView()
end

function GuildCrossWarGuildRank:onEnter()
    self._msgGuildCrossLadder         = G_NetworkManager:add(MessageIDConst.ID_S2C_BrawlGuildsLadder, handler(self, self._s2cBrawlGuildsLadder))               -- 军团排行
    self:_updateListView()
end

function GuildCrossWarGuildRank:onExit()
    self._msgGuildCrossLadder:remove()
    self._msgGuildCrossLadder = nil
end

function GuildCrossWarGuildRank:_initListView()
    self._imageOwn:setVisible(false)
	local scrollViewParam = {
	    template = GuildCrossWarGuildRankCell,
	    updateFunc = handler(self, self._onCellUpdate),
	    selectFunc = handler(self, self._onCellSelected),
        touchFunc = handler(self, self._onCellTouch),
    }
	self._tabListView = TabScrollView.new(self._listView, scrollViewParam, 1)
end

function GuildCrossWarGuildRank:_updateListView()
	local maxGroup = table.nums(self._rankData)
	if maxGroup <= 0 then
		return
	end
    
    self:_updateOwnRank()
    self._tabListView:updateListView(1, maxGroup)
end

function GuildCrossWarGuildRank:_onCellUpdate(cell, index)
    -- body
	if table.nums(self._rankData) <= 0 then
		return
    end
    
    local cellIndex = (index + 1)
    local cellData = self._rankData[cellIndex]
    if type(cellData) ~= "table" then
        return
    end

    cellData.index = cellIndex
    cell:updateUI(cellData)
end

function GuildCrossWarGuildRank:_onCellSelected(cell, index)
    -- body
end

function GuildCrossWarGuildRank:_onCellTouch(index, data)
    -- body
end

function GuildCrossWarGuildRank:_updateOwnRank()
    -- body
    local ownData = {}
    for k,v in pairs(self._rankData) do
        if rawequal(v.guild_id, G_UserData:getGuild():getMyGuildId()) then
            ownData = v
            ownData.index = k
            break
        end
    end

    if table.nums(ownData) > 0 then
        self._imageOwn:setVisible(true)
        if ownData.index <= 3 then
            self._imageOwnback:loadTexture(Path.getArenaUI(GuildCrossWarConst.GUILD_LADDER_RANKNUM[ownData.index]))
        else
            self._imageOwnback:loadTexture(Path.getArenaUI(GuildCrossWarConst.GUILD_LADDER_RANKNUM[4]))
        end

        self._textOwnRank:setString(tonumber(ownData.index))
        self._textOwnGuildName:setString(ownData.guild_name)
        self._textOwnGuildName:setColor(GuildCrossWarHelper.getGuildNameColor(ownData.index))
        self._textOwnHurt:setString(TextHelper.getAmountText(ownData.score))
    end
end

function GuildCrossWarGuildRank:_s2cBrawlGuildsLadder(id, message)
    -- body
    if rawget(message, "guild_ladders") == nil then
        return
    end

    self._rankData = {}
    self._rankData = message.guild_ladders
    table.sort(self._rankData, function(item1, item2)
        if item1.score == item2.score then
            return item1.guild_id < item2.guild_id
        else
            return item1.score > item2.score
        end
    end)
    self:_updateListView()
end



return GuildCrossWarGuildRank