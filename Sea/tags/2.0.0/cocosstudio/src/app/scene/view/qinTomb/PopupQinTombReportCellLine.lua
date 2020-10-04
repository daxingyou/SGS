--秦皇陵战报
local ViewBase = require("app.ui.ViewBase")
local PopupQinTombReportCellLine = class("PopupQinTombReportCellLine", ViewBase)
local Path = require("app.utils.Path")
local AudioConst = require("app.const.AudioConst")


function PopupQinTombReportCellLine:ctor()
	self._commonHero = nil	
	self._playerName = nil	

	local resource = {
		file = Path.getCSB("PopupQinTombReportCellLine", "qinTomb"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
		}
	}
	self:setName("PopupQinTombReportCellLine")
	PopupQinTombReportCellLine.super.ctor(self, resource)
end

function PopupQinTombReportCellLine:onCreate()

end

function PopupQinTombReportCellLine:updateUI( data )
	-- body
	
end

function PopupQinTombReportCellLine:onEnter()

end

function PopupQinTombReportCellLine:onExit()

end

return PopupQinTombReportCellLine
