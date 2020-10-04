--秦皇陵帮助界面

local PopupBase = require("app.ui.PopupBase")
local PopupQinTombHelp = class("PopupQinTombHelp", PopupBase)
local UIHelper = require("yoka.utils.UIHelper")
local PopupHelpInfoCell = require("app.ui.PopupHelpInfoCell")
local PopupHelpInfoTitleCell = require("app.ui.PopupHelpInfoTitleCell")

function PopupQinTombHelp:ctor()
    self._scrollView = nil
	local resource = {
		file = Path.getCSB("PopupQinTombHelp", "qinTomb"),
		binding = {
            _buttonClose = {
				events = {{event = "touch", method = "_onClickClose"}}
			},
		}
	}
	PopupQinTombHelp.super.ctor(self, resource, true)
end


function PopupQinTombHelp:onCreate()
	-- i18n change lable
	if not Lang.checkLang(Lang.CN) then
		self:_createLabelByI18n()
	end
	
end

function PopupQinTombHelp:onEnter()
end

function PopupQinTombHelp:onExit()
end

function PopupQinTombHelp:updateUI(txtList)
	--self._listView:setScrollBarEnabled(true)
	self._listView:removeAllChildren()
	for k, txt in ipairs(txtList) do
		local itemWidget = self:_createItem(txt)
		self._listView:pushBackCustomItem(itemWidget)
	end
end

function PopupQinTombHelp:updateUIForHasSubTitle(txtData)
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


function PopupQinTombHelp:updateByFunctionId(functionId)
	local funcName = FunctionConst.getFuncName(functionId)
	local txtData = Lang.get(funcName)
	if self:_isTxtList(txtData) then
		self:updateUI(txtData)
	else
		self:updateUIForHasSubTitle(txtData)
	end
end


function PopupQinTombHelp:_createItem(txt)
    local cell = PopupHelpInfoCell.new()
	if Lang.checkLang(Lang.CN) then
		cell:updateUI(txt,280)
	else
		cell:updateUI(txt,260)
	end
    return cell
end

function PopupQinTombHelp:_createTitle(txt)
	local cell = PopupHelpInfoTitleCell.new()
	-- i18n pos lable
	if Lang.checkLang(Lang.CN) then
        cell:updateUI(txt)
    else
        cell:updateUI(txt,300)
	end
    return cell
end


function PopupQinTombHelp:_isTxtList(data)
	for k,v in pairs(data) do
		if type(v) == "table" then
			return false
		end
	end
	return true
end


function PopupQinTombHelp:_onClickClose()
	self:close()
end

-- i18n change lable
function PopupQinTombHelp:_createLabelByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
	
		local label = UIHelper.createLabel({
			style = "qintomb_1",
			text = Lang.getImgText("img_qintomb_explain01_1") ,
			position = cc.p(120,387),
		})
		local labe2 = UIHelper.createLabel({
			style = "qintomb_2",
			text = Lang.getImgText("img_qintomb_explain01_2") ,
			position = cc.p(609,429),
		})
		local labe3 = UIHelper.createLabel({
			style = "qintomb_2",
			text = Lang.getImgText("img_qintomb_explain01_3") ,
			position = cc.p(119,116),
		})
		local labe4 = UIHelper.createLabel({
			style = "qintomb_2",
			text = Lang.getImgText("img_qintomb_explain01_4") ,
			position = cc.p(604,93),
		})
		local labe5 = UIHelper.createLabel({
			style = "qintomb_3",
			text = Lang.getImgText("img_qintomb_explain01_5") ,
			position = cc.p(625,255),
		})
		local labe6 = UIHelper.createLabel({
			style = "qintomb_4",
			text = Lang.getImgText("img_qintomb_explain01_6") ,
			position = cc.p(868,432),
		})
		self._resourceNode:addChild(label)
		self._resourceNode:addChild(labe2)
		self._resourceNode:addChild(labe3)
		self._resourceNode:addChild(labe4)
		self._resourceNode:addChild(labe5)
		self._resourceNode:addChild(labe6)
	end
end

return PopupQinTombHelp