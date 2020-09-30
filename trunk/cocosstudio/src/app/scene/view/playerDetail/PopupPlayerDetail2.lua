--玩家信息弹框

local PopupBase = require("app.ui.PopupBase")
local PopupPlayerDetail = class("PopupPlayerDetail", PopupBase)
local PlayerDetailNode = require("app.scene.view.playerDetail.PlayerDetailNode")
local AudioSettingNode = require("app.scene.view.playerDetail.AudioSettingNode")
local ServiceNode = require("app.scene.view.playerDetail.ServiceNode")
local GiftCodeNode = require("app.scene.view.playerDetail.GiftCodeNode")
local tabList = {
    PlayerDetailNode,
    AudioSettingNode,
    ServiceNode,
    GiftCodeNode,
}

local Path = require("app.utils.Path")

function PopupPlayerDetail:ctor()
    self._selectTabIndex = 0
    self._viewList = {}

    local resource = {
		file = Path.getCSB("PopupPlayerDetail2", "playerDetail"),
		binding = {

		}
	}
	PopupPlayerDetail.super.ctor(self, resource, true)
end

function PopupPlayerDetail:onCreate()
	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._commonNodeBk:setTitle(Lang.get("player_detail_title"))
	self:_initTabGroup()
end

function PopupPlayerDetail:_initTabGroup()
	local tabNameList = {}
	table.insert(tabNameList, Lang.get("player_detail_tab_1"))
	table.insert(tabNameList, Lang.get("player_detail_tab_2"))
	table.insert(tabNameList, Lang.get("player_detail_tab_3"))
	-- 非送审且后台开启礼品码
	if not G_ConfigManager:isAppstore() and G_ConfigManager:isGiftcode() then
		table.insert(tabNameList, Lang.get("player_detail_tab_4"))
	end
	local param = {
		callback = handler(self, self._onTabSelect),
		textList = tabNameList,
	}

	self._nodeTabRoot:recreateTabs(param)
end

function PopupPlayerDetail:_onTabSelect(index, sender)
	if index == self._selectTabIndex then
		return
	end
    self._selectTabIndex = index

	for i, view in pairs(self._viewList) do
		view:setVisible(false)
	end
	local chooseView = self:getView(index)
	chooseView:setVisible(true)

	self:_refreshRedPoint()
end

function PopupPlayerDetail:getView(index)
	local view = self._viewList[index]
	if view == nil then
        view = tabList[index].new()
		self._nodeRight:addChild(view)
		view:setCascadeOpacityEnabled(true)
		self._viewList[index] = view
	end
	return view
end

function PopupPlayerDetail:onEnter()
	self._signalRedPoint = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._onEventRedUpdate))
	self._nodeTabRoot:setTabIndex(1)

end

function PopupPlayerDetail:onExit()
	self._signalRedPoint:remove()
	self._signalRedPoint = nil
end

function PopupPlayerDetail:onBtnCancel()
    self:close()
end

function PopupPlayerDetail:_refreshRedPoint()
    local frameRed = G_UserData:getHeadFrame():hasRedPoint()
    local titleRed = G_UserData:getTitles():isHasRedPoint()
	local redValue = titleRed or frameRed
	self._nodeTabRoot:setRedPointByTabIndex(1, redValue)
end

function PopupPlayerDetail:_onEventRedUpdate()
	self:_refreshRedPoint()
end

return PopupPlayerDetail
