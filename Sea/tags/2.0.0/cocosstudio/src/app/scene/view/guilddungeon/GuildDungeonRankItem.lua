
local ListViewCellBase = require("app.ui.ListViewCellBase")
local GuildDungeonRankItem = class("GuildDungeonRankItem", ListViewCellBase)
local TextHelper = require("app.utils.TextHelper")

function GuildDungeonRankItem:ctor()
    self._imageBg = nil
    self._imageRank = nil
    self._textGuildName = nil
    self._textNum = nil
    self._textPoint = nil
    self._textRank = nil

    local resource = {
        file = Path.getCSB("GuildDungeonRankItem", "guildDungeon"),
        binding = {
		}
    }
    GuildDungeonRankItem.super.ctor(self, resource)
end

function GuildDungeonRankItem:onCreate()
    -- i18n pos lable
    self:_dealPosByI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end

function GuildDungeonRankItem:updateUI(data,index)
    self._data = data
    local rank = data:getRank()
    if rank <= 3 and rank > 0 then
        self._imageRank:setVisible(true)
        self._imageRank:loadTexture( Path.getArenaUI("img_qizhi0"..rank))
        self._textRank:setVisible(false)
    elseif rank == 0 then
        self._imageRank:setVisible(false)
        self._textRank:setVisible(false)
	else
        self._imageRank:setVisible(true)
        self._textRank:setVisible(true)
        self._textRank:setString(tostring(rank))
		self._imageRank:loadTexture( Path.getArenaUI("img_qizhi04"))
	end
    local function getRankColor(rank)
        if rank <=3 and rank > 0  then
            return Colors["GUILD_DUNGEON_RANK_COLOR"..rank]
        end
        return Colors["DARK_BG_ONE"]
    end

    self._imageBg:setVisible(index % 2 == 0)
    self._textGuildName:setString(data:getName())
    self._textNum:setString(data:getNum())
    self._textPoint:setString(data:getPoint())

    self._textGuildName:setColor(getRankColor(rank))
    self._textNum:setColor(getRankColor(rank))
    self._textPoint:setColor(getRankColor(rank))
end


-- i18n pos lable
function GuildDungeonRankItem:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")	
        self._imageRank:setPositionX(self._imageRank:getPositionX())
        self._textRank:setPositionX(self._textRank:getPositionX())
        self._textGuildName:setPositionX(self._textGuildName:getPositionX()-10)
        self._textGuildName:setFontSize(self._textGuildName:getFontSize()-2)
        self._textNum:setPositionX(self._textNum:getPositionX())
        self._textPoint:setPositionX(self._textPoint:getPositionX())

        if Lang.checkLang(Lang.TW) then
            self._textGuildName:setAnchorPoint(0.5,0.5)
            self._textGuildName:setPositionX(122)
        end
	end
end


return GuildDungeonRankItem
