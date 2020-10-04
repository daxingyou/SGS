
local CarnivalActivityTaskLayer = require("app.scene.view.carnivalActivity.CarnivalActivityTaskLayer")
local CarnivalActivityExchangeLayer = class("CarnivalActivityExchangeLayer", CarnivalActivityTaskLayer)


function CarnivalActivityExchangeLayer:ctor(actType)
    self._actType = actType
    CarnivalActivityExchangeLayer.super.ctor(self)
end

function CarnivalActivityExchangeLayer:onInitCsb(resource)
	local CSHelper = require("yoka.utils.CSHelper")
	local resource = {
		file = Path.getCSB("CarnivalActivityExchangeLayer", "carnivalActivity"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
		},
	}
    CSHelper.createResourceNode(self, resource)
end

function CarnivalActivityExchangeLayer:_initListView()
	local ItemCell = require("app.scene.view.carnivalActivity.CarnivalActivityExchangeCell")
	self._listView:setTemplate(ItemCell)
	self._listView:setCallback(handler(self, self._onListViewItemUpdate), handler(self, self._onListViewItemSelected))
	self._listView:setCustomCallback(handler(self, self._onListViewItemTouch))
end


return CarnivalActivityExchangeLayer
