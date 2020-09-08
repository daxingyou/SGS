
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupHelpInfoTitleCell = class("PopupHelpInfoTitleCell", ListViewCellBase)

function PopupHelpInfoTitleCell:ctor()
    self._text = nil
	local resource = {
		file = Path.getCSB("PopupHelpInfoTitleCell", "common"),
	}
	PopupHelpInfoTitleCell.super.ctor(self, resource)
end

function PopupHelpInfoTitleCell:onCreate()
	local size = self._resourceNode:getContentSize()
    self:setContentSize(size.width, size.height)
    -- ui4界面变化
	if Lang.checkUI("ui4") then
        self._text:setFontSize(22)
        self._text:setColor(cc.c4b( 0xb4, 0x64, 0x14, 0xff))
	end
end

-- i18n pos lable �޸Ĳ���
function PopupHelpInfoTitleCell:updateUI(msg,maxLineWidth)
    local resourceNodeSize = self._resourceNode:getContentSize()
    local render = self._text:getVirtualRenderer()
    -- i18n pos lable
    if not Lang.checkLang(Lang.CN) and maxLineWidth then
        logWarn("-------------- xxxs"..maxLineWidth)
        local size =  self._text:getContentSize()
        self._text:setContentSize(cc.size(maxLineWidth,size.height))
        render:setMaxLineWidth(maxLineWidth )
    else
    render:setMaxLineWidth(616)
    end
   
    self._text:setString(msg)
    local size = render:getContentSize()
    if not Lang.checkLang(Lang.CN) and maxLineWidth then
        self._text:setContentSize(cc.size(maxLineWidth,size.height))
    end
    self:setContentSize(resourceNodeSize.width,size.height)
    self._resourceNode:setPositionY(size.height-resourceNodeSize.height)
end



return PopupHelpInfoTitleCell