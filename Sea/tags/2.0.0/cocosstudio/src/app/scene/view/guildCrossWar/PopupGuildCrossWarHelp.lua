-- @Author  panhoa
-- @Date  4.1.2019
-- @Role 

local PopupBase = require("app.ui.PopupBase")
local PopupGuildCrossWarHelp = class("PopupGuildCrossWarHelp", PopupBase)
local UIHelper = require("yoka.utils.UIHelper")
local PopupHelpInfoCell = require("app.ui.PopupHelpInfoCell")
local PopupHelpInfoTitleCell = require("app.ui.PopupHelpInfoTitleCell")

function PopupGuildCrossWarHelp:ctor()
    self._scrollView = nil
	local resource = {
		file = Path.getCSB("PopupGuildCrossWarHelp", "guildCrossWar"),
		binding = {
            _buttonClose = {
				events = {{event = "touch", method = "_onClickClose"}}
			},
		}
	}
	PopupGuildCrossWarHelp.super.ctor(self, resource, true)
end


function PopupGuildCrossWarHelp:onCreate()
end

function PopupGuildCrossWarHelp:onEnter()
end

function PopupGuildCrossWarHelp:onExit()
end

function PopupGuildCrossWarHelp:updateUI(txtList)
	self._listView:removeAllChildren()
	for k, txt in ipairs(txtList) do
		local itemWidget = self:_createItem(txt)
		self._listView:pushBackCustomItem(itemWidget)
	end
end

function PopupGuildCrossWarHelp:updateUIForHasSubTitle(txtData)
	self._listView:removeAllChildren()
	for k,v in ipairs(txtData) do
		local itemWidget = self:_createTitle(v.title)
		self._listView:pushBackCustomItem(itemWidget)
		for k, txt in ipairs(v.list) do
			local itemWidget = self:_createItem(txt)
			self._listView:pushBackCustomItem(itemWidget)
		end
	end
end


function PopupGuildCrossWarHelp:updateByFunctionId(functionId)
	local funcName = FunctionConst.getFuncName(functionId)
	local txtData = Lang.get(funcName)
	if self:_isTxtList(txtData) then
		self:updateUI(txtData)
	else
		self:updateUIForHasSubTitle(txtData)
	end
end


function PopupGuildCrossWarHelp:_createItem(txt)
    local cell = PopupHelpInfoCell.new()
    cell:updateUI(txt,280)
    return cell
end

function PopupGuildCrossWarHelp:_createTitle(txt)
    local cell = PopupHelpInfoTitleCell.new()
    cell:updateUI(txt)
    return cell
end


function PopupGuildCrossWarHelp:_isTxtList(data)
	for k,v in pairs(data) do
		if type(v) == "table" then
			return false
		end
	end
	return true
end


function PopupGuildCrossWarHelp:_onClickClose()
	self:close()
end

return PopupGuildCrossWarHelp