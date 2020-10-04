-- @Author panhoa
-- @Date 8.29.2018
-- @Role 

local ListViewCellBase = require("app.ui.ListViewCellBase")
local GuildCrossWarGuildRankCell = class("GuildCrossWarGuildRankCell", ListViewCellBase)
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local GuildCrossWarHelper = import(".GuildCrossWarHelper")


function GuildCrossWarGuildRankCell:ctor()
    self._imageBack     = nil
	
    local resource = {
        file = Path.getCSB("GuildCrossWarGuildRankCell", "guildCrossWar"),
    }
    GuildCrossWarGuildRankCell.super.ctor(self, resource)
end

function GuildCrossWarGuildRankCell:onCreate()
    local size = self._resource:getContentSize()
    self:setContentSize(size.width, size.height)
end

function GuildCrossWarGuildRankCell:_updateBack(index)
    -- body
    index = (index % 2 + 1)
    self._imageBack:loadTexture(Path.getGuildWar(GuildCrossWarConst.GUILD_LADDER_CELL_BG[index]))
end

function GuildCrossWarGuildRankCell:_updateRank(index)
    -- body
    if index == nil or index <= 0 then
        return
    end
    --self._imageRank:setVisible(index <= 3)
    self._textRank:setVisible(index > 3)

    if index <= 3 then
        self._imageRank:loadTexture(Path.getArenaUI(GuildCrossWarConst.GUILD_LADDER_RANKNUM[index]))
    else
        self._textRank:setString(tonumber(index))
        self._imageRank:loadTexture(Path.getArenaUI(GuildCrossWarConst.GUILD_LADDER_RANKNUM[4]))
    end
end

function GuildCrossWarGuildRankCell:_updateGuildName(index, name)
    -- body
    if index == nil or index <= 0 then
        return
    end
    self._textGuildName:setString(name)
    self._textGuildName:setColor(GuildCrossWarHelper.getGuildNameColor(index))
end

function GuildCrossWarGuildRankCell:_updateHurt(hurt)
    -- body
    local TextHelper = require("app.utils.TextHelper")
	local powerStr = TextHelper.getAmountText(hurt)
    self._textHurt:setString(powerStr)
end

function GuildCrossWarGuildRankCell:updateUI(data)
    -- body
    self:_updateBack(data.index)
    self:_updateRank(data.index)
    self:_updateGuildName(data.index, data.guild_name)
    self:_updateHurt(data.score)
end



return GuildCrossWarGuildRankCell