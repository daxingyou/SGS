
-- Author: zhanglinsen
-- Date:2018-09-19 10:29:22
-- Describle：

local ViewBase = require("app.ui.ViewBase")
local GroupsFixView = class("GroupsFixView", ViewBase)
local GroupsFixViewCell = import(".GroupsFixViewCell")
local PopupGroupsInviteView = import(".PopupGroupsInviteView")
local GroupsDataHelper = require("app.utils.data.GroupsDataHelper")

function GroupsFixView:ctor(cfgType)

	--csb bind var name
	self._commonFullScreen = nil  --CommonFullScreen
	self._listViewParent = nil  --Panel
	self._listViewTab = nil  --ScrollView
	self._btnCreate = nil  --CommonButtonHighLight
	self._btnJoin = nil  --CommonButtonHighLight

	self._cfgType = cfgType or 1 -- 组队活动配置类型id

	local resource = {
		file = Path.getCSB("GroupsFixView", "groups"),
		binding = {
			_btnCreate = {
				events = {{event = "touch", method = "_onBtnCreate"}}
			},
			_btnJoin = {
				events = {{event = "touch", method = "_onBtnJoin"}}
			},
		}
	}
	self:setName("GroupsFixView")
	GroupsFixView.super.ctor(self, resource)
end

-- Describle：
function GroupsFixView:onCreate()
	self._commonFullScreen:setTitle(Lang.get("groups_team_title"))
	self._btnCreate:setString(Lang.get("groups_btn_create"))
	self._btnJoin:setString(Lang.get("groups_btn_join"))
	self:_initListView(self._listViewTab,GroupsFixViewCell)
end

function GroupsFixView:_onBtnCreate()
	local groupType = self._cfgType or 1
	-- G_SceneManager:popToRootScene()
	G_UserData:getGroups():c2sCreateTeam(groupType)
end

function GroupsFixView:_onBtnJoin()
	local groupType = self._cfgType or 1
	local memberId = nil
	G_UserData:getGroups():c2sApplyTeam(groupType,memberId)
	-- G_UserData:getGroups():c2sLeaveTeam()
end

-- Describle：
function GroupsFixView:onEnter()
	self:scheduleUpdateWithPriorityLua(handler(self, self._update), 0)
	self._signalInfoChange = G_SignalManager:add(SignalConst.EVENT_GROUP_INFO_CHANGE, handler(self, self._onGroupInfoChange))
	self._signalMyApplyGroupChange = G_SignalManager:add(SignalConst.EVENT_GROUP_MY_APPLY_GROUP_CHANGE, handler(self, self._onMyApplyGroupChange))
	self:_refreshListData()
end

-- Describle：
function GroupsFixView:onExit()
	self:unscheduleUpdate()
	self._signalInfoChange:remove()
	self._signalInfoChange = nil
	self._signalMyApplyGroupChange:remove()
	self._signalMyApplyGroupChange = nil
end

function GroupsFixView:_update( dt )
	local listData = self:_getListDatas()
	if not listData then return end
	local listCount = #listData
	for i, v in ipairs(listData) do
		if v and v:getApp_time() ~= 0 then
			local isEnd = v:isEndApply()
			if isEnd then v:setApp_time(0) end
			local itemNode = self:_findItemNodeByIndex(i)
			itemNode:updateStatus()
		end
	end
end


function GroupsFixView:_onMyApplyGroupChange(event)
	-- self:refreshView()

	local lineCount = #self._listDatas
	-- self._listViewTab:clearAll()
	self._listViewTab:resize(lineCount)
end

function GroupsFixView:_onGroupInfoChange(event,team_type)
	local groupType = self._cfgType
	if groupType ~= team_type then return end
	print("-------GroupsFixView EVENT_GROUP_INFO_CHANGE---------")
	self:refreshView()
end	

function GroupsFixView:getGroupData()
	local groupData = {}
	local groupCfg = GroupsDataHelper.getGroupUnitConfig(self._cfgType)
	local funcInfo = GroupsDataHelper.getFunctionData(groupCfg.function_id)
	local data = G_UserData:getGroups():getGroups(self._cfgType)
	groupData["data"] = data	
	groupData["cfg"] = groupCfg	
	groupData["funcCfg"] = funcInfo	
	return groupData
end

function GroupsFixView:_initListView(listView,templateCellCalss)
	-- body
	listView:setTemplate(templateCellCalss)
	listView:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	listView:setCustomCallback(handler(self, self._onItemTouch))

end

function GroupsFixView:_refreshListView(listView,itemList)
	local lineCount = #itemList
	listView:clearAll()
	listView:resize(lineCount)
	print("GroupsFixView:_refreshListView  count:" .. lineCount)
end

function GroupsFixView:_refreshItemNodeByIndex(index)
	local itemNode = self:_findItemNodeByIndex(index)
	local data = self._listDatas[index]
	dump(index,data)
	if itemNode then
		itemNode:updateUI(index,data)
	end
end


function GroupsFixView:_findItemNodeByIndex(index)
	local lineIndex = index
	local items = self._listViewTab:getItems()
	if not items then
		return nil
	end
	for k,v in ipairs(items) do
		if v:getTag() == index -1 then
			return v
		end	
	end
	return nil
end

function GroupsFixView:_getListDatas()
	return  self._listDatas 
end

-- Describle：
function GroupsFixView:_onItemUpdate(item, index)
	local itemList = self:_getListDatas()
	local itemData = itemList[index+1]
	item:updateUI(itemData)

end

-- Describle：
function GroupsFixView:_onItemSelected(item, index)

end

-- Describle：
function GroupsFixView:_onItemTouch(index, item, data)
	logWarn("GroupsFixView:_onItemTouch "..tostring(index))
	local items = self._listViewTab:getItems()
	if not items then return nil end

	local memberData = data
	assert(memberData ~= nil, string.format("GroupsFixView _onItemTouch() param data is nil"))
	
	local groupId = memberData:getTeam_id()
	local groupType = memberData:getTeam_type()
	G_UserData:getGroups():c2sApplyTeam(groupType,groupId)

	-- for k,v in ipairs(items) do
	-- 	if v:getTag() ~= index then
	-- 	end	
	-- end
end

function GroupsFixView:_getListViewData()
	local data = self:getGroupData()
	local groupType = self._cfgType or 1
	local listData = G_UserData:getGroups():getGroups(groupType):getDataList()
	dump(listData)
	return listData
end

function GroupsFixView:_refreshListData()
	local listViewData = self:_getListViewData()
	self._listDatas = listViewData
	self:_refreshListView(self._listViewTab ,listViewData)
end

function GroupsFixView:refreshView()
	self:_refreshListData()
end

function GroupsFixView:setListViewParentVisible(trueOrFalse)
	self._listViewParent:setVisible(trueOrFalse)
end

return GroupsFixView