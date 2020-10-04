local MineReportBarNode = class("MineReportBarNode")

function MineReportBarNode:ctor(target)
    self._target = target
    self._barGreen = nil
    self._barYellow = nil
    self._barRed = nil
    self._textArmy = nil
    self._nodeText = nil
    
    self:_init()
end

function MineReportBarNode:_init()
    self._barGreen = ccui.Helper:seekNodeByName(self._target, "BarGreen")
    self._barYellow = ccui.Helper:seekNodeByName(self._target, "BarYellow")
    self._barRed = ccui.Helper:seekNodeByName(self._target, "BarRed")
    self._textArmy = ccui.Helper:seekNodeByName(self._target, "TextArmy")
    self._nodeText = ccui.Helper:seekNodeByName(self._target, "NodeText")

    self._barGreen:setVisible(false)
    self._barYellow:setVisible(false)
    self._barRed:setVisible(false)
end

function MineReportBarNode:updateUI(army, redArmy, needTurnBack)
    self:_setArmy(army)
    self:_setRedArmy(redArmy)
    self:_turnBack(needTurnBack)  
end

function MineReportBarNode:_setArmy(army)
    self._barGreen:setVisible(false)
    self._barYellow:setVisible(false)
    self._barRed:setVisible(false)
    local bar = self._barGreen
    if army > 25 and army <= 75 then 
        bar = self._barYellow
    elseif army <= 25 then 
        bar = self._barRed
    end
    bar:setVisible(true)
    bar:setPercent(army)

    self._textArmy:setString(army)
    local fontColor = Colors.getMinePercentColor(army)
    self._textArmy:setColor(fontColor.color)
    self._textArmy:enableOutline(fontColor.outlineColor, 2)
end

function MineReportBarNode:_setRedArmy(redArmy)
    self._nodeText:removeAllChildren()
    local text = ccui.RichText:createWithContent(Lang.get("mine_report_red_army", {count = redArmy}))
    text:setAnchorPoint(cc.p(0, 0))
    self._nodeText:addChild(text)
end

function MineReportBarNode:_turnBack(needTurn)
    local scaleX = 1
    if not Lang.checkLang(Lang.CN) then 
       self._nodeText:setPositionX(-70)
    else
       self._nodeText:setPositionX(-76)    
    end
    if needTurn then 
        scaleX = -1
        if not Lang.checkLang(Lang.CN) then 
            local text = self._nodeText:getChildren()[1]
            if text then text:setAnchorPoint(cc.p(1, 0)) end
            self._nodeText:setPositionX(70)
        else
            self._nodeText:setPositionX(-50)
        end
        
    end
    self._barGreen:setScale(scaleX)
    self._barYellow:setScale(scaleX)
    self._barRed:setScale(scaleX)
end

return MineReportBarNode