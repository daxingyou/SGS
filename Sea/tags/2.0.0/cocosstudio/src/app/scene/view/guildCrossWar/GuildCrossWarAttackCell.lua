-- @Author panhoa
-- @Date 3.28.2019
-- @Role 

local ListViewCellBase = require("app.ui.ListViewCellBase")
local GuildCrossWarAttackCell = class("GuildCrossWarAttackCell", ListViewCellBase)
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")


function GuildCrossWarAttackCell:ctor(touchCallBack)
    self._resource = nil
    self._imageBack = nil
    self._textName  = nil
    self._panelTouch= nil
    self._touchCallBack = touchCallBack

    local resource = {
        file = Path.getCSB("GuildCrossWarAttackCell", "guildCrossWar"),
    }
    GuildCrossWarAttackCell.super.ctor(self, resource)
end

function GuildCrossWarAttackCell:onCreate()
    local size = self._resource:getContentSize()
    self:setContentSize(size.width, size.height)
    self._resource:setVisible(false)
end

function GuildCrossWarAttackCell:updateNameColor(bSelected)
    local fontColor = Colors.GUILDCROSSWAR_NOT_ATCCOLOR
    local outsideColor = Colors.GUILDCROSSWAR_NOT_ATCCOLOR_OUT
    if bSelected then
        fontColor = Colors.GUILDCROSSWAR_ATCCOLOR
        outsideColor = Colors.GUILDCROSSWAR_ATCCOLOR_OUT
    else
        fontColor = Colors.GUILDCROSSWAR_NOT_ATCCOLOR
        outsideColor = Colors.GUILDCROSSWAR_NOT_ATCCOLOR_OUT
    end
    self._textName:setColor(fontColor)
    self._textName:enableOutline(outsideColor)
end


function GuildCrossWarAttackCell:updateUI(data)
    if type(data) ~= "table" then return end

    self._resource:setVisible(true)
    self._imageBack:loadTexture(Path.getGuildCrossImage(GuildCrossWarConst.ATTACK_CELL_BG[data.backIndex]))
    self._textName:setString(data.point_name)
    self._panelTouch:addClickEventListenerEx(function()

        if self._touchCallBack then
            dump(data.id)
            self._touchCallBack(data.id)
        end
    end)
end



return GuildCrossWarAttackCell