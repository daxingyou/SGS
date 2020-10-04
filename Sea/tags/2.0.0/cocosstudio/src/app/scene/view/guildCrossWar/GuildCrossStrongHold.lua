-- @Author  panhoa
-- @Date  3.20.2019
-- @Role 
local ViewBase = require("app.ui.ViewBase")
local GuildCrossStrongHold = class("GuildCrossStrongHold", ViewBase)


function GuildCrossStrongHold:ctor(pointId)
    -- body
    self._resourcePanel = nil
    self._imageHold     = nil
    self._attackPanel   = nil
    self._effectNode    = nil
    self._textCd        = nil
    self._pointId       = pointId --据点Id

    local resource = {
        file = Path.getCSB("GuildCrossStrongHold", "guildCrossWar"),
    }
    GuildCrossStrongHold.super.ctor(self, resource)
end

function GuildCrossStrongHold:onCreate()
    self:_initView()
    self:_initPosition()
end

function GuildCrossStrongHold:onEnter()
end

function GuildCrossStrongHold:onExit()
end

function GuildCrossStrongHold:_initView()
    -- body
    local size = self._resourcePanel:getContentSize()
    self:setContentSize(size.width, size.height)
    self._resourcePanel:setSwallowTouches(false)
    self._imageHold:setSwallowTouches(false)
    self._attackPanel:setSwallowTouches(false)

    self._imageHold:setVisible(false)
    self._attackPanel:setScale(0.7)
    self._effectNode = G_EffectGfxMgr:createPlayMovingGfx(self._attackPanel, "moving_juntuanzhan_jiantou", nil, nil, false)
end
 
function GuildCrossStrongHold:_initPosition()
    -- body
    local GuildCrossWarHelper = require("app.scene.view.guildCrossWar.GuildCrossWarHelper")
    local itemData = GuildCrossWarHelper.getWarCfg(self._pointId)
    if itemData == nil then
        return
    end

    local postion = GuildCrossWarHelper.convertToSmallMapPos(cc.p(itemData.map_x * 0.75, itemData.map_y * 0.75))
    self:setPosition(postion)
end

function GuildCrossStrongHold:updateHold(isHold)
    self._imageHold:setVisible(isHold)
end

function GuildCrossStrongHold:updateAttack(isAttack, leftSecond)
    leftSecond = (leftSecond or 0)
    --self._textCd:setString(tostring(leftSecond) .."S")
    --self._textCd:setVisible(leftSecond > 0)
    --self._effectNode:setVisible(isAttack)
    self._effectNode:setVisible(false)
    self._textCd:setVisible(false)
end



return GuildCrossStrongHold