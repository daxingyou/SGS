
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupHelpInfoCell = class("PopupHelpInfoCell", ListViewCellBase)

function PopupHelpInfoCell:ctor()
    self._text = nil
	local resource = {
		file = Path.getCSB("PopupHelpInfoCell", "common"),
    }
    	-- ui4界面变化
	if Lang.checkUI("ui4") then
		resource = {
			file = Path.getCSB("PopupHelpInfoCell1", "common"),		
		}
	end
	PopupHelpInfoCell.super.ctor(self, resource)
end

function PopupHelpInfoCell:onCreate()
    -- i18n
    self:_dealByI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end


function PopupHelpInfoCell:updateUI(msg,maxLine,from)
    local resourceNodeSize = self._resourceNode:getContentSize()
    local render = self._text:getVirtualRenderer()
    maxLine = maxLine or 616
    if Lang.checkUI("ui4") then
        maxLine = 570
        self._text:setFontSize(20)
    end

    -- i18n ja 文本宽度特殊处理 不能走上面的ui4
    if from == "PopupQinTombHelp" and Lang.checkLang(Lang.JA) then
        maxLine = 260
    end

    render:setMaxLineWidth(maxLine)
    self._text:setString(msg)
    local size = render:getContentSize()
    self:setContentSize(resourceNodeSize.width,size.height)
    self._resourceNode:setPositionY(size.height-resourceNodeSize.height)
end

-- i18n
function PopupHelpInfoCell:_dealByI18n()
end

return PopupHelpInfoCell