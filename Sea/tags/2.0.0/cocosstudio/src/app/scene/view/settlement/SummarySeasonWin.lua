-- @Author panhoa
-- @Date 9.10.2018
-- @Role 

local SummaryBase = require("app.scene.view.settlement.SummaryBase")
local SummarySeasonWin = class("SummarySeasonWin", SummaryBase)
local ComponentLine = require("app.scene.view.settlement.ComponentLine")


function SummarySeasonWin:ctor(battleData, callback)
    local size = G_ResolutionManager:getDesignCCSize()
    local width = size.width
    local height = size.height
    local midXPos = SummaryBase.NORMAL_FIX_X

    local list = {}
    local componentLine = ComponentLine.new("txt_sys_reward02", cc.p(midXPos, 253 - height*0.5))
    table.insert(list, componentLine)
    SummarySeasonWin.super.ctor(self,battleData, callback, list, midXPos, true)
end

function SummarySeasonWin:onEnter()
    SummarySeasonWin.super.onEnter(self)
    self:_createAnimation()
end

function SummarySeasonWin:onExit()
    G_UserData:getSeasonSport():c2sFightsEntrance()
    SummarySeasonWin.super.onExit(self)
end

function SummarySeasonWin:_createAnimation()
    G_EffectGfxMgr:createPlayMovingGfx( self, "moving_jwin_2", handler(self, self._playWinText), handler(self, self.checkStart) , false )    
end


return SummarySeasonWin