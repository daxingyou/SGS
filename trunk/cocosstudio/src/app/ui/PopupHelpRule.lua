-- i18n ja 
-- 规则界面
local PopupBase = require("app.ui.PopupBase")
local PopupHelpRule = class("PopupHelpRule", PopupBase)


function PopupHelpRule:ctor(titleLangName, contentLangname)
	self._scrollView = nil
	self._strTitle = Lang.get(titleLangName)
	self._strContent = Lang.get(contentLangname)
	local resource = {
		file = Path.getCSB("PopupHelpRule", "common"),
		binding = {
            _buttonClose = {
				events = {{event = "touch", method = "_onClickClose"}}
			},
		}
	}
	PopupHelpRule.super.ctor(self, resource, true)
end


function PopupHelpRule:onCreate()
	self._title:setString(self._strTitle)
	self:updateUI()
end

function PopupHelpRule:onEnter()
end

function PopupHelpRule:onExit()
end

function PopupHelpRule:updateUI( )
	self._listView:removeAllChildren()
	local itemWidget = self._listCell:clone()
	itemWidget:setVisible(true)
	local text = itemWidget:getChildren()[1]

	text:ignoreContentAdaptWithSize(true)
	text:setTextAreaSize(cc.size(itemWidget:getContentSize().width, 0)) 
	text:setString(self._strContent)
	itemWidget:setContentSize(cc.size(itemWidget:getContentSize().width, text:getContentSize().height))
	self._listView:pushBackCustomItem(itemWidget)
end

 
function PopupHelpRule:_onClickClose()
	self:close()
end

-- i18n change lable
function PopupHelpRule:_createTitleLabelByI18n()
	if not Lang.checkLang(Lang.CN) then
		local TypeConst = require("app.i18n.utils.TypeConst")
		local UIHelper  = require("yoka.utils.UIHelper")

	end
end

return PopupHelpRule

 
 