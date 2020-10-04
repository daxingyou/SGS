
-- Author: conley
-- Date:2018-11-23 17:08:13
-- Describle：

local ViewBase = require("app.ui.ViewBase")
local HistoryHeroMainView = class("HistoryHeroMainView", ViewBase)


function HistoryHeroMainView:ctor()

	--csb bind var name
	self._funcIcon1 = nil  --CommonMainMenu
	self._funcIcon2 = nil  --CommonMainMenu
	self._imageBook = nil  --ImageView
	self._listItemSource = nil  --ScrollView
	self._listViewPos = nil  --ListView
	self._nodeLantern1 = nil  --SingleNode
	self._nodeScene = nil  --SingleNode
	self._nodeTrain = nil  --SingleNode
	self._panelDesign = nil  --Panel
	self._static_historyhero_book = nil  --Text
	self._topbarBase = nil  --CommonTopbarBase

	local resource = {
		file = Path.getCSB("HistoryHeroMainView", "historyhero"),

	}
	HistoryHeroMainView.super.ctor(self, resource)
end

-- Describle：
function HistoryHeroMainView:onCreate()
	self:_initListItemSource()
	self:_initListViewPos()
end

-- Describle：
function HistoryHeroMainView:onEnter()

end

-- Describle：
function HistoryHeroMainView:onExit()

end
function HistoryHeroMainView:_initListItemSource()
	-- body
	self._listItemSource:setTemplate()
	self._listItemSource:setCallback(handler(self, self._onListItemSourceItemUpdate), handler(self, self._onListItemSourceItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onListItemSourceItemTouch))

	-- self._listItemSource:resize()
end

-- Describle：
function HistoryHeroMainView:_onListItemSourceItemUpdate(item, index)

	-- item:updateUI()
end

-- Describle：
function HistoryHeroMainView:_onListItemSourceItemSelected(item, index)

end

-- Describle：
function HistoryHeroMainView:_onListItemSourceItemTouch(index, params)

end

function HistoryHeroMainView:_initListViewPos()
	-- body
	self._listViewPos:setTemplate()
	self._listViewPos:setCallback(handler(self, self._onListViewPosItemUpdate), handler(self, self._onListViewPosItemSelected))
	self._listViewPos:setCustomCallback(handler(self, self._onListViewPosItemTouch))

	-- self._listViewPos:resize()
end

-- Describle：
function HistoryHeroMainView:_onListViewPosItemUpdate(item, index)

	-- item:updateUI()
end

-- Describle：
function HistoryHeroMainView:_onListViewPosItemSelected(item, index)

end

-- Describle：
function HistoryHeroMainView:_onListViewPosItemTouch(index, params)

end


return HistoryHeroMainView