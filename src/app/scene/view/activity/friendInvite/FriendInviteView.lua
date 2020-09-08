--@Author:Conley
local ActivitySubView = require("app.scene.view.activity.ActivitySubView")
local FriendInviteItemCell = import(".FriendInviteItemCell")
local TabButtonGroup = require("app.utils.TabButtonGroup")
local FriendInviteView = class("FriendInviteView", ActivitySubView)
local friend_invite = require("app.config.friend_invite")
local ActivityConst = require("app.const.ActivityConst")
local InputUtils = require("app.utils.InputUtils")
local UIHelper = require("yoka.utils.UIHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local RedPointHelper = require("app.data.RedPointHelper")
 
FriendInviteView.FUND_TYPE_INVITE_REWARD = 1	--邀请基金
FriendInviteView.FUND_TYPE_INVITED_REWARD = 2	--受邀奖励

FriendInviteView.CODE_LEN = 10			      -- 邀请码长度
FriendInviteView.INVITE_END_TIME = 56000      --开服后多少天该活动消失
FriendInviteView.CODE_MAX_TIMES = 56001       --  被邀最大次数
FriendInviteView.BIND_CODE_COUNT = 56002      --  受邀请最大次数
 
FriendInviteView.RET_INVITE_OVER_MAX = 10521  -- 邀请码填写已超上限
FriendInviteView.INVALID_INVITE_CODE = 10529  -- 无效邀请码
FriendInviteView.SELF_CODE_INVALID = 10527    -- 无法使用自己的邀请码
function FriendInviteView:ctor(mainView,activityId,showFundGroup) 
	self._mainView = mainView
	self._activityId = activityId
	self._paramShowFundGroup = showFundGroup
	self._listItemSource = nil
	self._commonBuy = nil--充值按钮
 
	self._tabGroup = nil
	self._listDatas = nil
	self._selectTabIndex = nil
 

    local resource = {
        file = Path.getCSB("FriendInviteView", "activity/friendInvite"),
      	binding = {
			_btnCopy = {
				events = {{event = "touch", method = "_onButtonCopyClick"}}
			},
			_btnConfirm = {
				events = {{event = "touch", method = "_onButtonConfirmClick"}}
			},
			_btnState = {
				events = {{event = "touch", method = "_onButtonStateClick"}}
			}
		},
    }
    FriendInviteView.super.ctor(self, resource)
end

-- 拉去邀请信息
function FriendInviteView:_pullData()
	local hasActivityServerData = G_UserData:getActivity():hasActivityData(self._activityId)
	if not hasActivityServerData  then
		G_UserData:getActivity():pullActivityData(self._activityId)
	end
	return hasActivityServerData
end

function FriendInviteView:onCreate()
	self._textTimeDes:setPositionX(745)
	self:_initTabGroup()	-- 创建2tab
	self:_initListView(self._listItemSource) 
	self._commonHelp:updateLangName("FUNC_FRIEND_INVITE_HELP")
end

function FriendInviteView:onEnter()
	self._signalWelfareFundOpenServerGetInfo = G_SignalManager:add(SignalConst.EVENT_WELFARE_FRIEND_INVITE_INFO, handler(self, self._onEventWelfriendInviteInfo))
	self._signalWelfareFundOpenServerGetReward = G_SignalManager:add(SignalConst.EVENT_WELFARE_WRITE_INVITE, handler(self, self._onEventWelfareWriteInvite )) 
	self._signalServerRecordChange = G_SignalManager:add(SignalConst.EVENT_WELFARE_INVITE_REWARD, handler(self, self._onEventInviteReward))
	self._signalRedPointUpdate = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self,self._onEventRedPointUpdate))
 
	-- if self:_UnitTest() then
	-- 	return
	-- end

	-- 每次点击按钮打开页面时  要请求 获取最新信息 <无需拉去 pullData()是用于晚上12点过期会重置才用 >
	local hasServerData = self:_pullData() 
	if hasServerData   then
		G_UserData:getActivity():pullActivityData(self._activityId)
	end

	self:_initData()
	self:_initInviteCode()
	self:_refreshData()
 
	if not self._selectTabIndex then
		self._tabGroup:setTabIndex(1)		
	end
end

function FriendInviteView:onExit()
	self._signalWelfareFundOpenServerGetInfo:remove()
	self._signalWelfareFundOpenServerGetInfo = nil

	self._signalWelfareFundOpenServerGetReward:remove()
	self._signalWelfareFundOpenServerGetReward = nil

	self._signalServerRecordChange:remove()
    self._signalServerRecordChange = nil

	self._signalRedPointUpdate:remove()
	self._signalRedPointUpdate = nil

	self:_endTimer()
end

function FriendInviteView:_UnitTest()
	local bTest = true
 
	self._code = "123456789A"
	self._becode = "B12345678B"
	self._day = 2 -- 0 1 2 3 
	self._rewardid = {5, 11} -- {1, 2, 3, 4}   -- 已领取   数据要按id排序  
	self._UserInviteInfo = { {uid=123, name="xxx1", level=10, power=50, sname="server1", olevel=1}}   --{ {}, {}, {uid:  name level power }} 
	self:_initData()
	self:_initInviteCode()

	self:_refreshData()

	if not self._selectTabIndex then
		self._tabGroup:setTabIndex(1)		
	end
	return bTest
end

-- 获取好友邀请信息 （登录成功会主动tui)
function FriendInviteView:_onEventWelfriendInviteInfo(event,id,message)  
	self:_initData()
	self:_initInviteCode()
	self:_refreshData()
end

function FriendInviteView:_onEventRedPointUpdate(event,funcId,param)
	if funcId ~= FunctionConst.FUNC_WELFARE then
		return
	end
	if not param or type(param) ~= 'table' then
		return
	end

	if param.actId ==  ActivityConst.ACT_ID_FRIEND_INVITE  then
		self:_refreshRedPoint()
    end
end

function FriendInviteView:_refreshRedPoint()
	local redPointShow = false
	for i = 1, #self._inviteInfo do
		 if self._inviteInfo[i].state == ActivityConst.CHECKIN_STATE_RIGHT_TIME then
			redPointShow = true
		 end
	end

	local redPointShow2 = false
	for i = 1, #self._invitedInfo do
		 if self._invitedInfo[i].state == ActivityConst.CHECKIN_STATE_RIGHT_TIME then
			redPointShow2 = true
		 end
	end
 
	self._tabGroup:setRedPointByTabIndex(1,redPointShow)
	self._tabGroup:setRedPointByTabIndex(2,redPointShow2)
end

-- 玩家填写邀请码
function FriendInviteView:_onEventWelfareWriteInvite(event,id,message)
	if message.ret == MessageErrorConst.RET_OK then  
		self._btnConfirm:setVisible(false) --setTouchEnabled(false)
		G_UserData:getActivityFriendInvite():setBecode(self._inputCode:getText()) -- 以G_UserData中数据为标准
		self._becode = G_UserData:getActivityFriendInvite():getBecode()    
		G_Prompt:showTip(Lang.get("activity_invite_input_tips")) 
		self._inputCode:removeFromParent(true)
		self._inputCode = nil
		self._textOtherCode:setString(self._becode)

		self:_refreshData()
		G_UserData:getActivityFriendInvite():c2sMyInviteInfo()  -- 要再次请求 因为self.day累计登录天数变了
	elseif rawget(message, "ret") == FriendInviteView.RET_INVITE_OVER_MAX then  
		local msgInfo = require("app.config.net_msg_error").get(FriendInviteView.RET_INVITE_OVER_MAX)
		if msgInfo.error_msg then
			G_Prompt:showTip(Lang.get(msgInfo.error_msg))
		end
		self._textOtherCode:setString("")
	else 
		local msgInfo = require("app.config.net_msg_error").get(FriendInviteView.INVALID_INVITE_CODE)
		if msgInfo.error_msg then
			G_Prompt:showTip(Lang.get(msgInfo.error_msg))
		end
		self._textOtherCode:setString("")
	end
end

-- 请求奖励响应
function FriendInviteView:_onEventInviteReward(event,id,message)
	if friend_invite.get(message.id) == nil then
		return 
	end

	local cfg = friend_invite.get(message.id)
	local awards = {}
	local len = self:_getLen(cfg)

	for n = 1, len do
		if cfg["reward_type"..n] ~= 0 and cfg["reward_size"..n] ~= 0 then
			table.insert(awards, {type = cfg["reward_type"..n], value = cfg["reward_value"..n], size = cfg["reward_size"..n] })
		end
    end
	if #awards > 0 then
		G_Prompt:showAwards(awards)
	end

	self._rewardid = G_UserData:getActivityFriendInvite():getRewardid() -- 以G_UserData中数据为标准
	self:_refreshData()
end

function FriendInviteView:_initTabGroup()
	local param = {
		rootNode = nil,
		isVertical = 2,
		callback = handler(self, self._onTabSelect),
		textList = Lang.get("lang_activity_Invite_tab_names"),
		imageList = {Path.getUICommon("img_btn_ctrl_classify02_down"), Path.getUICommon("img_btn_ctrl_classify02_nml")},
	}
	self._tabGroup:recreateTabs(param)
end

function FriendInviteView:_initListView(listView)
	listView:setTemplate(FriendInviteItemCell)
	listView:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	listView:setCustomCallback(handler(self, self._onItemTouch))
end

function FriendInviteView:_initInviteCode()	
	self._btnState:setString(Lang.get("activity_invite_btn_state")) 

	self._textCode:setString(Lang.get("activity_invite_text_code_title1")) 
	self._textFriendCode:setString(Lang.get("activity_invite_text_code_title2"))
	self._textInviteTimes:setString(Lang.get("activity_invite_text_code_title3"))
	self._textInvitedTimes:setString(Lang.get("activity_invite_text_code_title4"))
	self._textTimeDes:setString(Lang.get("activity_invite_text_code_title5"))

	-- 好友邀请码
	if self._inputCode then
		self._inputCode:removeFromParent(true)
		self._inputCode = nil
	end

	if self._becode ~= "" then
		self._btnConfirm:setVisible(false) --setTouchEnabled(false)
		-- self._inputCode = InputUtils.createInputView(
		-- 	{
		-- 		bgPanel = self._imageInput,
		-- 		fontSize = 18,
		-- 		placeholderFontColor = Colors.NUMBER_WHITE,
		-- 		-- fontColor = Colors.LIST_TEXT,
		-- 		fontColor = Colors.NUMBER_WHITE,
		-- 		placeholder = self._becode,  
		-- 		maxLength = FriendInviteView.CODE_LEN, 
		-- 	})
		-- self._inputCode:setEnabled(false) 

		
		self._textOtherCode:setString(self._becode)
		self._textCount1:setColor(Colors.BRIGHT_BG_RED) 
		self._textCount1:setString("0" .. "/" .. self:getParameterCfg(FriendInviteView.BIND_CODE_COUNT)) 
	else  
		self._inputCode = InputUtils.createInputView(
			{
				bgPanel = self._imageInput,
				fontSize = 18,
				placeholderFontColor = Colors.NUMBER_WHITE, --INPUT_PLACEHOLDER,
				-- fontColor = Colors.LIST_TEXT,
				fontColor = Colors.NUMBER_WHITE,
				placeholder = "", --Lang.get("citation_des_input_code"),
				maxLength = FriendInviteView.CODE_LEN, 
			})
		self._btnConfirm:setEnabled(true)
		self._textCount1:setColor(Colors.NUMBER_WHITE) 
		self._textCount1:setString("1" .. "/" .. self:getParameterCfg(FriendInviteView.BIND_CODE_COUNT)) 
	end		
	self._textSelfCode:setString(self._code) 

	-- 邀请次数
   local count = self:getParameterCfg(FriendInviteView.CODE_MAX_TIMES) - #self._UserInviteInfo
   self._textCount2:setString(count .. "/" .. self:getParameterCfg(FriendInviteView.CODE_MAX_TIMES))
   self._textCount2:setPositionX(self._textInvitedTimes:getPositionX() + self._textInvitedTimes:getContentSize().width + 2) 
   if count == 0 then
	 self._textCount2:setColor(Colors.BRIGHT_BG_RED) 
   else  
	self._textCount2:setColor(Colors.NUMBER_WHITE)
   end
   self._textCount1:setPositionX(self._textInviteTimes:getPositionX() + self._textInviteTimes:getContentSize().width + 2) 
   -- 开服时间
   self:_getRemainderTime()
end
  
function FriendInviteView:_getListViewData(index) 
	if index == FriendInviteView.FUND_TYPE_INVITE_REWARD then
		return self._inviteInfo
	elseif index == FriendInviteView.FUND_TYPE_INVITED_REWARD then   
		return self._invitedInfo 
	end 
end

-- 切换页签
function FriendInviteView:_onTabSelect(index, sender)
	if self._selectTabIndex == index then
		return
	end
	self._selectTabIndex = index
	local listViewData = self:_getListViewData(index)
	self._listDatas = listViewData
	self:_refreshListView(self._listItemSource ,listViewData)
end

function FriendInviteView:_refreshListView(listView,itemList)
	if itemList == nil then
		return
	end
	local lineCount = #itemList
	listView:clearAll()
	listView:resize(lineCount)
	listView:jumpToTop()
end

function FriendInviteView:_refreshItemNodeByIndex(index)
	local itemNode = self:_findItemNodeByIndex(index)
	if itemNode then
		local data = self._listDatas[index]
		itemNode:updateUI(data)
	end
end
 

function FriendInviteView:_findItemNodeByIndex(index)
	local lineIndex = index
	local items = self._listItemSource:getItems()
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

function FriendInviteView:_getListDatas()
	return  self._listDatas
end

function FriendInviteView:_onItemUpdate(item, index)
	local itemList = self:_getListDatas()
	local itemData = itemList[index+1] -- ??? +1对吗
	item:updateUI(itemData)
end

function FriendInviteView:_onItemSelected(item, index)
	logWarn("FriendInviteView:_onItemSelected ")
end

-- 点击按钮回调
function FriendInviteView:_onItemTouch(index, itemPos)
	logWarn("FriendInviteView:_onItemTouch "..tostring(index).." "..tostring(itemPos))
	local data = self._listDatas[itemPos+1]
	G_UserData:getActivityFriendInvite():c2sInviteReward(data.id)
	
	-- local ActAdmin = require("app.config.act_admin")
	-- local info = ActAdmin.get(ActivityConst.ACT_ID_FRIEND_INVITE)
	-- local ActivityDataHelper = require("app.utils.data.ActivityDataHelper")
	-- if ActivityDataHelper.checkPackBeforeGetActReward(data) then
	--  	G_UserData:getActivityFriendInvite():c2sInviteReward(data.id)
	-- end
end

function FriendInviteView:_refreshListData()
	if self._selectTabIndex == nil then
		return
	end
	
	local index = self._selectTabIndex
	local listViewData = self:_getListViewData(index)
	self._listDatas = listViewData
	self:_refreshListView(self._listItemSource ,listViewData)
end
 
function FriendInviteView:_onButtonCopyClick(sender)
	G_NativeAgent:clipboard(self._textSelfCode:getString()) 
	G_Prompt:showTip(Lang.get("linkage_activity_copy_tip"))  
end

function FriendInviteView:_onButtonConfirmClick(sender)
	local UTF8 = require("app.utils.UTF8")
	local code = self._inputCode:getText()  

	if code == self._code then
		local msgInfo = require("app.config.net_msg_error").get(FriendInviteView.RET_INVITE_OVER_MAX)
		if msgInfo.error_msg then
			G_Prompt:showTip(msgInfo.error_msg) 
		end
	elseif UTF8.utf8len (code) ~= FriendInviteView.CODE_LEN then    	 
		local msgInfo = require("app.config.net_msg_error").get(FriendInviteView.INVALID_INVITE_CODE)
		if msgInfo.error_msg then
			G_Prompt:showTip(msgInfo.error_msg) 
		end
	else  
		G_UserData:getActivityFriendInvite():c2sGetWriteInvite(code)
	end 
end

function FriendInviteView:_onButtonStateClick(sender)
	local PopupFriendState = require("app.scene.view.activity.friendInvite.PopupFriendState").new(self._UserInviteInfo) 
	PopupFriendState:openWithAction() 
end

-----------------------------数据处理

function FriendInviteView:_initData()
	self._level = G_UserData:getBase():getLevel()
	self._code = G_UserData:getActivityFriendInvite():getCode()
	self._becode = G_UserData:getActivityFriendInvite():getBecode()
	self._day = G_UserData:getActivityFriendInvite():getDay()
	self._rewardid = G_UserData:getActivityFriendInvite():getRewardid()  -- 已领取   数据要按id排序  
	self._UserInviteInfo = G_UserData:getActivityFriendInvite():getUserInviteInfo()   --{ {}, {}, {uid:  name level power day}} 

	self._cfg = {}
	local getCfg = function ()
		local len = friend_invite.length()
		for i = 1, len do
			local info = friend_invite.indexOf(i)
			self._cfg[info.id] = info
		end
	end
	getCfg() --配表信息
	
	self._tab1 = {} 
	self._tab2 = {}
	for index = 1, #self._cfg do
		if self._cfg[index].tab == 1 then
			table.insert(self._tab1, self._cfg[index])	
		elseif self._cfg[index].tab == 2 then   
			table.insert(self._tab2, self._cfg[index])	
		end	
	end
end

function FriendInviteView:_refreshData()  
	table.sort(self._rewardid, function(id1, id2) 
		return id1 < id2
	end)

	self._inviteInfo = self:getInviteInfo()
	self._invitedInfo = self:getBeInvitedInfo()

	self:_refreshListData()
	self:_refreshRedPoint()
end

function FriendInviteView:getReward()
	local inviteReward = {}
	local invitedReward = {} 

	for key, id in pairs(self._rewardid) do
		local info = friend_invite.get(id)  
		if info then
			--assert(info, string.format("friend_invite config can not find id = %d", info.id))
			if info.tab == 1 then 
				table.insert(inviteReward,  id)
			elseif info.tab == 2 then
				table.insert(invitedReward,  id)
			end	
		end
	end

	return inviteReward, invitedReward 
end

function FriendInviteView:isUnReceiveState(id)
	local info = friend_invite.get(id)
	if id <= 3 then
		return #self._UserInviteInfo >= info.require_value1
	elseif id > 3 and id < 7 then
		local bNum = #self._UserInviteInfo >= info.require_value1
		-- 等级
		local nNum = 0
		local bLevel = false 
		for index = 1, #self._UserInviteInfo do
			if self._UserInviteInfo[index].level >=  info.require_value2 then
				nNum = nNum + 1
			end
		end
		if nNum >= info.require_value1 then
			bLevel = true
		end

		return (bNum and bLevel)
	elseif id >= 7 and id <= 9 then
		local bNum = #self._UserInviteInfo >= info.require_value1

		-- 战力
		local nNum = 0
		local bPower = false 
		for index = 1, #self._UserInviteInfo do
			if self._UserInviteInfo[index].power >= info.require_value2 then
				nNum = nNum + 1
			end
		end
		if nNum >= info.require_value1 then
			bPower = true
		end

		return (bNum and bPower)
	end
end

function FriendInviteView:getInviteInfo()
	local rewardID = self:getReward()-- 已领取
	local id = (#rewardID > 0) and (rewardID[#rewardID] + 1) or 1 -- 获取已领取奖励下个id
	local unComplete = {} 			-- 未完成
	local unReceive = {}  			-- 已完成可领取
 	
	for index = 1, #self._tab1 do
		local id = self._tab1[index].id
		if self:_isHaveGetRewardCode(id) == false then
			if self:isUnReceiveState(id) then
				if self._tab1[index].pre_id ~= 0 and self:_isHaveGetRewardCode(self._tab1[index].pre_id) then -- 条件达到，但是前置条件的未领取 则不显示
					table.insert(unReceive, id)	
				elseif self._tab1[index].pre_id == 0 then 
					table.insert(unReceive, id)	
				end
			elseif self._tab1[index].pre_id == 0 then
				table.insert(unComplete, id)		
			elseif self._tab1[index].pre_id ~= 0 and self:_isHaveGetRewardCode(self._tab1[index].pre_id) then -- 若前置任务已领取 则显下个id才能显示“未完成”
				table.insert(unComplete, id)		
			end
		end
	end

	-- 按照优先级依次排序数据
	local tab = {}
	for index = 1, #unReceive do
		table.insert(tab, {id=unReceive[index], state=ActivityConst.CHECKIN_STATE_RIGHT_TIME})
	end
	for index = 1, #unComplete do
		table.insert(tab, {id=unComplete[index], state=ActivityConst.CHECKIN_STATE_WRONG_TIME})
	end
	for index = 1, #rewardID do
		table.insert(tab, {id=rewardID[index], state=ActivityConst.CHECKIN_STATE_PASS_TIME})
	end
	dump(tab, "#tab print->")
	return tab
end

function FriendInviteView:getBeInvitedInfo()
	local _, rewardID = self:getReward()-- 已领取
	local unComplete = {} 			-- 未完成
	local unReceive = {}  			-- 已完成可领取

	for i=1, #self._tab2 do
		if self:_isHaveGetReward(self._tab2[i].id) == false then
			if i == 1 then
				table.insert((self._becode ~= "") and unReceive or unComplete, self._tab2[i].id)
			elseif i >= 2 and i <= 4 then  -- 登录天数
				if self._day >= self._tab2[i].require_value1 then 
					table.insert((self._becode ~= "") and unReceive or unComplete, self._tab2[i].id)
				elseif self._day < self._tab2[i].require_value1 and self._tab2[i].pre_id == 0 then
					table.insert(unComplete, self._tab2[i].id)
				elseif self._tab2[i].pre_id ~= 0 and self:_isHaveGetRewardCode(self._tab2[i].pre_id) then-- 若前置任务已领&&条件不满足 则显下个id才能显示“未完成”	
					table.insert(unComplete, self._tab2[i].id)
				end
			elseif i >= 5 and i <= 7 then	-- 玩家等级
				if self._level >= self._tab2[i].require_value1 then 
					table.insert((self._becode ~= "") and unReceive or unComplete, self._tab2[i].id) -- 如果填写过邀请码，才显示未领取，Or未完成
				elseif self._level < self._tab2[i].require_value1 and self._tab2[i].pre_id == 0 then
					table.insert(unComplete, self._tab2[i].id)
				elseif self._tab2[i].pre_id ~= 0 and self:_isHaveGetRewardCode(self._tab2[i].pre_id) then-- 若前置任务已领&&条件不满足 则显下个id才能显示“未完成”	
					table.insert(unComplete, self._tab2[i].id)
				end
			end	
		end
	end

	
 	-- 按照优先级依次排序数据
	 local tab = {}
	 for index = 1, #unReceive do
		 table.insert(tab, {id=unReceive[index], state=ActivityConst.CHECKIN_STATE_RIGHT_TIME})
	 end
	 for index = 1, #unComplete do
		 table.insert(tab, {id=unComplete[index], state=ActivityConst.CHECKIN_STATE_WRONG_TIME})
	 end
	 for index = 1, #rewardID do
		 table.insert(tab, {id=rewardID[index], state=ActivityConst.CHECKIN_STATE_PASS_TIME})
	 end
	 dump(tab, "#tab print->")
	 return tab
end
 
function FriendInviteView:_isHaveGetReward(id)
	local _, rewardID = self:getReward()
	for index = 1, #rewardID do
		if rewardID[index] == id then
			return true
		end
	end

	return false
end

function FriendInviteView:_isHaveGetRewardCode(id)
	local rewardID, _ = self:getReward()
	for key, tt_id in pairs(rewardID) do
		if tt_id == id then
			return true
		end
	end

	return false
end

function FriendInviteView:_getLen(cfg)
    local nIndex = 0
    for key, value in pairs(cfg._raw_key_map) do
        nIndex = nIndex + 1
    end

    nIndex = (nIndex-8)/3
    return nIndex
end

function FriendInviteView:getParameterCfg(id)
	local ParameterIDConst = require("app.const.ParameterIDConst")
	local Parameter = require("app.config.parameter")
	
    local info = Parameter.get(id)  -- 不可直接写数字 写const配表(多)或类常量(少)  
    assert(info, string.format("graincar parameter config can not find id = %d", info.content))
	return tonumber(info.content)
end

------------------------剩余时间
function FriendInviteView:_getRemainderTime()
	local dayCfg = self:getParameterCfg(FriendInviteView.INVITE_END_TIME)
	local secondToday = tonumber(dayCfg) * 24 * 3600

	local openServerTime = G_UserData:getBase():getServer_open_time() -- 开服时间
	self.endTime =  openServerTime + secondToday  -- 截止时间戳
	local currTime = G_ServerTime:getTime()       -- 当前时间戳


	local timeLeft = self.endTime - currTime
    local day = math.floor(timeLeft/3600/24)  
	local h = (timeLeft-timeLeft%3600)/3600
	local m = (timeLeft-h*3600 -timeLeft%60)/60
	local sec = timeLeft%60

	G_ServerTime:getLeftSecondsString(self.endTime , "00:00:00") 
	if day > 1 then
		h = h%24  
	    self._textTime:setString(day .. Lang.get("activity_invite_time_day") .. h .. Lang.get("activity_invite_time_hour"))  
	else  
		--   local time =string.format("%02d-%02d-%02d", h, m, sec)
		--   self._textTime:setString(time)
		self:_startTimer() 	  -- 开启定时器 onExit移除
		local txt = G_ServerTime:getLeftSecondsString(self.endTime , "00:00:00") 
		self._textTime:setString(txt)
	end
	self._textTime:setPositionX(self._textTimeDes:getPositionX() + 2) 
end

function FriendInviteView:_startTimer()
	local SchedulerHelper = require("app.utils.SchedulerHelper")
	if self._refreshHandler ~= nil then
        return
	end
	self._refreshHandler = SchedulerHelper.newSchedule(handler(self,self._onRefreshTick),1)
end

function FriendInviteView:_endTimer()
	local SchedulerHelper = require("app.utils.SchedulerHelper")
	if self._refreshHandler ~= nil then
		SchedulerHelper.cancelSchedule(self._refreshHandler)
		self._refreshHandler = nil
	end
end

function FriendInviteView:_onRefreshTick(dt)
	local txt = G_ServerTime:getLeftSecondsString(self.endTime , "00:00:00") 
	self._textTime:setString(txt)
end


return FriendInviteView




