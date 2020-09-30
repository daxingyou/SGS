local ViewBase = require("app.ui.ViewBase")
local CampSummaryNode = class("CampSummaryNode", ViewBase)

function CampSummaryNode:ctor()
	local resource = {
		file = Path.getCSB("CampSummaryNode", "campRace"),
		binding = {
		}
	}
    CampSummaryNode.super.ctor(self, resource)
end

function CampSummaryNode:onCreate()

    if not Lang.checkLang(Lang.CN) then
        self._nodeRank:setPositionX(self._nodeRank:getPositionX() +12)
        self._nodePoint:setPositionX(self._nodePoint:getPositionX() +12)
    end
end

function CampSummaryNode:onEnter()
end

function CampSummaryNode:onExit()
end

function CampSummaryNode:showRank(old, new)
    self._nodeRank:setVisible(true)
    self._nodePoint:setVisible(false)
    self._textRankOld:setString(old)
    self._textRankNew:setString(new)
    if new < old then 
        self._textRankNew:setColor(Colors.getCampGreen())
    elseif new > old then 
        self._textRankNew:setColor(Colors.getCampRed())
    end
    local size1 = self._textRankOld:getContentSize()
    local size2 = self._imageArrow:getContentSize()
    self._imageArrow:setPositionX(size1.width+10)
    self._textRankNew:setPositionX(size1.width+size2.width)
    --
    if lang.checkUI("ui4") then
        self._nodeRank:setPositionX(self._nodeRank:getPositionX() + 18)
    end
end

function CampSummaryNode:showPoint(now, change)
    self._nodeRank:setVisible(false)
    self._nodePoint:setVisible(true)
    self._textPoint:setString(now)
    if change < 0 then 
        -- i18n change punc
        if not Lang.checkLang(Lang.CN) then
            self._textPointChange:setString("("..change..")")
        else
            self._textPointChange:setString("（"..change.."）")
        end
        self._textPointChange:setColor(Colors.getCampRed())
    else 
        -- i18n change punc
        if not Lang.checkLang(Lang.CN) then
            self._textPointChange:setString("(+"..change..")")
        else
            self._textPointChange:setString("（+"..change.."）")
        end
        self._textPointChange:setColor(Colors.getCampGreen())
    end
    local size1 = self._textPoint:getContentSize()
    self._textPointChange:setPositionX(size1.width)
end

return CampSummaryNode