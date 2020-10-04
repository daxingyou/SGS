
local ActivitySubView = require("app.scene.view.activity.ActivitySubView")
local CSHelper = require("yoka.utils.CSHelper")
local UIHelper  = require("yoka.utils.UIHelper")
local TimeConst  = require("app.const.TimeConst")
local LateRegistView = class("LateRegistView", ActivitySubView)

function LateRegistView:ctor(mainView,activityId)
	LateRegistView.super.ctor(self)
	self._activityId = activityId
	self._actTitle = nil  --CommonFullScreen
	self._listViewTab = nil  --ScrollView
	self._tabGroup = nil  --CommonTabGroup
	self._cdBg,self._cdImage,self._cdDesc,self._cdTime = nil	--countdown
	
	self._curSelectTabIndex = 0
	self._datas = {}

	self:_initUI()
	-- self:_updateData()
	self:_initListViewTab()
	self:_initTab()
	self:_refreshActTime()
	self:_refreshRedPoint()
end

function LateRegistView:_initUI()
	local upBg = UIHelper.createImage({texture = Path.getActivityRes("img_zhoulibao_bg") })
	upBg:setPosition(639,481)
	self:addChild(upBg)

	self._actTitle = CSHelper.loadResourceNode( Path.getCSB("CommonFullScreenActivityTitle", "common") )
	self:addChild(self._actTitle)

	self._tabGroup = CSHelper.loadResourceNode( Path.getCSB("CommonTabGroupHorizon", "common") )
	self._tabGroup:setPosition(336,487)
	self:addChild(self._tabGroup)

	local downBg = UIHelper.createImage({texture = Path.getUICommon("img_com_board03") })
	downBg:setScale9Enabled(true)
	downBg:setCapInsets(cc.rect(20,20,1,1))
	downBg:setContentSize(cc.size(938,416))
	downBg:setPosition(636,227)
	self:addChild(downBg)

	self._listViewTab = ccui.ScrollView:create()
    self._listViewTab:setClippingType(1)
    self._listViewTab:setBounceEnabled(true)
    self._listViewTab:setDirection(ccui.ScrollViewDir.vertical)
    -- self._listViewTab:setTouchEnabled(true)
    -- self._listViewTab:setScrollBarEnabled(true)
    self._listViewTab:setPosition(cc.p(7,6))
	-- self._listViewTab:setInnerContainerSize(cc.size(924, 400))
	self._listViewTab:setContentSize(cc.size(924, 400))
	downBg:addChild(self._listViewTab)
	cc.bind(self._listViewTab, "ScrollView")

	local cdNode = display.newNode():addTo(self)
	cdNode:setPosition(920,447)
	self._cdBg = UIHelper.createImage({texture = Path.getCustomActivityUI("img_activity_time01") })
	cdNode:addChild(self._cdBg)
	self._cdImage = UIHelper.createImage({texture = Path.getUICommon("img_com_gantanhao") })
	cdNode:addChild(self._cdImage)
	self._cdImage:setPositionX(-95)
	self._cdDesc = UIHelper.createLabel({
		text = Lang.get("activity_guild_sprint_downtime_title") ,
		position = cc.p(-83,0),
		color = cc.c3b(0xff, 0xb8, 0x0c),
		size = 22,
		anchorPoint = cc.p(0,0.5)
	})
	cdNode:addChild(self._cdDesc)
	self._cdTime = UIHelper.createLabel({
		text = "" ,
		position = cc.p(40,0),
		color = cc.c3b(0xff, 0xf7, 0xe8),
		size = 20,
		anchorPoint = cc.p(0,0.5)
	})
	cdNode:addChild(self._cdTime)
end

function LateRegistView:_pullData()
	local hasActivityServerData = G_UserData:getActivity():hasActivityData(self._activityId)
	if not hasActivityServerData  then
		G_UserData:getActivity():pullActivityData(self._activityId)
	end
	return hasActivityServerData
end

function LateRegistView:onEnter()
	self._signalGetAward = G_SignalManager:add(SignalConst.EVENT_ACT_LATE_REGIST_AWARD_SUCCESS, handler(self, self._onEventGetAwards))
	self._signalGetInfo = G_SignalManager:add(SignalConst.EVENT_ACT_LATE_REGIST_TASK_INFO, handler(self, self._onEventGetInfo))
	self._signalRedPointUpdate = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self,self._onEventRedPointUpdate))
	self:_startRefreshHandler()

	local hasServerData = self:_pullData()
	if hasServerData and G_UserData:getActivityLateRegist():isExpired() then
		G_UserData:getActivity():pullActivityData(self._activityId)
	end
end

function LateRegistView:onExit()
	self._signalGetAward:remove()
	self._signalGetAward =  nil
	self._signalGetInfo:remove()
	self._signalGetInfo =  nil
	self._signalRedPointUpdate:remove()
	self._signalRedPointUpdate = nil
	self:_endRefreshHandler()
end

function LateRegistView:_onEventGetAwards(event, awards)
	if awards then
		G_Prompt:showAwards(awards)
	end
	self:_updateData()
	self:_refreshView()
end

function LateRegistView:_onEventGetInfo(event,id,message)
	self:_updateData()
	self:_refreshView()
end

function LateRegistView:_startRefreshHandler()
	local SchedulerHelper = require("app.utils.SchedulerHelper")
	if self._refreshHandler ~= nil then
        return
	end
	self._refreshHandler = SchedulerHelper.newSchedule(handler(self,self._onRefreshTick),1)
end

function LateRegistView:_endRefreshHandler()
	local SchedulerHelper = require("app.utils.SchedulerHelper")
	if self._refreshHandler ~= nil then
		SchedulerHelper.cancelSchedule(self._refreshHandler)
		self._refreshHandler = nil
	end
end

function LateRegistView:_onRefreshTick( dt )
	self:_refreshActTime()
end
function LateRegistView:_refreshActTime( )
	if G_UserData:getActivityLateRegist():isOpen() then
		local CustomActivityUIHelper = require("app.scene.view.customactivity.CustomActivityUIHelper")
		local endTime = G_ServerTime:secondsFromZero(G_UserData:getBase():getCreate_time()) + TimeConst.SECONDS_ONE_DAY
		self._cdTime:setString(CustomActivityUIHelper.getLeftDHMSFormat(endTime))
	else
		self._cdTime:setString(Lang.get("customactivity_avatar_act_end"))
	end

	UIHelper.alignCenter(self._cdBg,{self._cdImage,self._cdDesc,self._cdTime},{0,5,0})
end

function LateRegistView:_initTab()
	local sheets = G_UserData:getActivityLateRegist():getDays()
	local textList = {}
	for i,v in ipairs(sheets) do
		textList[i] = Lang.getImgText("late_regist_day_num", {num = v})
	end
	local param2 = {
		callback = handler(self, self._onTabSelect),
		isVertical = 2,
		offset = -2,
		textList = textList
	}
	self._tabGroup:recreateTabs(param2)
	self._tabGroup:setTabIndex(1)
end

function LateRegistView:_onTabSelect(index, sender)
	if self._curSelectTabIndex == index then
		return
	end
	self._curSelectTabIndex = index
	self:_updateData()
	self:_refreshView(true)
end

function LateRegistView:_initListViewTab()
	local LateRegistItemCell = require("app.i18n.extends.ui.LateRegistItemCell")
	self._listViewTab:setTemplate(LateRegistItemCell)
	self._listViewTab:setCallback(handler(self, self._onListViewTabItemUpdate), handler(self, self._onListViewTabItemSelected))
	self._listViewTab:setCustomCallback(handler(self, self._onListViewTabItemTouch))
end

function LateRegistView:_updateData()
	local days = G_UserData:getActivityLateRegist():getDays()
	local day = days[self._curSelectTabIndex]
	self._datas = G_UserData:getActivityLateRegist():getUnitDatasByDay(day,true)
end

function LateRegistView:_refreshView(reset)
	self._listViewTab:clearAll()
	self._listViewTab:resize(math.ceil(#self._datas))
	if reset then
		self._listViewTab:jumpToTop()
	end
end

function LateRegistView:_onListViewTabItemUpdate(item, index)
	local data = self._datas[index+1]
	item:updateInfo(data)
end

function LateRegistView:_onListViewTabItemSelected(item, index)

end

function LateRegistView:_onListViewTabItemTouch(index, itemPos)
	local itemData = self._datas[itemPos+1]
	if not itemData then
		return
	end
	if not G_UserData:getActivityLateRegist():isOpen() then
		G_Prompt:showTip(Lang.get("customactivity_avatar_act_end_tip"))
		return
	end
    local reachReceiveCondition = itemData:isReachReceiveCondition()
	local canReceive = itemData:isCanReceive()
	local id = itemData:getId()
	if reachReceiveCondition and canReceive then
		G_UserData:getActivityLateRegist():c2sGetLateRegistTaskAward(id)
	end
end

function LateRegistView:_refreshRedPoint()
	local sheets = G_UserData:getActivityLateRegist():getDays()

	for k,day in ipairs(sheets) do
		local redPointShow =  G_UserData:getActivityLateRegist():hasRedPointByDay(day)
		self._tabGroup:setRedPointByTabIndex(k,redPointShow)
	end
end

function LateRegistView:_onEventRedPointUpdate(event,funcId,param)
	if funcId ~= FunctionConst.FUNC_WELFARE then
		return
	end
	if not param or type(param) ~= 'table' then
		return
	end
	local ActivityConst = require("app.const.ActivityConst")
	if param.actId ==  ActivityConst.ACT_ID_LATE_REGIST  then
		self:_refreshRedPoint()
    end
end

return LateRegistView
