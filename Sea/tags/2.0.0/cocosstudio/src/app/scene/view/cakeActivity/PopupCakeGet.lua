--
-- Author: Liangxu
-- Date: 2019-4-29
-- 蛋糕材料获取弹框

local PopupBase = require("app.ui.PopupBase")
local PopupCakeGet = class("PopupCakeGet", PopupBase)
local CakeActivityConst = require("app.const.CakeActivityConst")
local CakeGetEggCell = require("app.scene.view.cakeActivity.CakeGetEggCell")
local CakeGetCreamCell = require("app.scene.view.cakeActivity.CakeGetCreamCell")
local CakeActivityDataHelper = require("app.utils.data.CakeActivityDataHelper")
local SchedulerHelper = require ("app.utils.SchedulerHelper")
local TimeConst = require("app.const.TimeConst")

function PopupCakeGet:ctor(index)
	self._selectTabIndex = index or CakeActivityConst.MATERIAL_TYPE_1
	local resource = {
		file = Path.getCSB("PopupCakeGet", "cakeActivity"),
		binding = {
			_buttonClose = {
				events = {{event = "touch", method = "_onClickClose"}}
			},
		}
	}
	PopupCakeGet.super.ctor(self, resource)
end

function PopupCakeGet:onCreate()
	if not Lang.checkLang(Lang.CN) then
		self:_swapImageByI18n()
		self:_dealPosByI18n()
	end

	self._datas1 = {}
	self._datas2 = {}
	self._targetTime = 0

	self:_initTabGroup()
end

function PopupCakeGet:_initTabGroup()
	self._listView1:setTemplate(CakeGetEggCell)
	self._listView1:setCallback(handler(self, self._onItemUpdate1), handler(self, self._onItemSelected1))
	self._listView1:setCustomCallback(handler(self, self._onItemTouch1))
	self._listView2:setTemplate(CakeGetCreamCell)
	self._listView2:setCallback(handler(self, self._onItemUpdate2), handler(self, self._onItemSelected2))
	self._listView2:setCustomCallback(handler(self, self._onItemTouch2))
	self._textImagePayTip:setVisible(false)

	local tabNameList = {}
	table.insert(tabNameList, Lang.get("cake_activity_get_tab_title_1"))
	table.insert(tabNameList, Lang.get("cake_activity_get_tab_title_2"))

	local param = {
		callback = handler(self, self._onTabSelect),
		textList = tabNameList,
	}
	
	self._nodeTabRoot:setCustomColor({
		{cc.c3b(0x5d, 0x70, 0xa4)},
		{cc.c3b(0xce, 0x68, 0x24)},
	})
	self._nodeTabRoot:recreateTabs(param)
end

function PopupCakeGet:onEnter()
	self._signalGetTaskReward = G_SignalManager:add(SignalConst.EVENT_CAKE_ACTIVITY_GET_TASK_REWARD, handler(self, self._onEventGetTaskReward))
	self._signalUpdateTaskInfo = G_SignalManager:add(SignalConst.EVENT_CAKE_ACTIVITY_UPDATE_TASK_INFO, handler(self, self._onEventUpdateTaskInfo))
	self._signalGetRechargeReward = G_SignalManager:add(SignalConst.EVENT_CAKE_ACTIVITY_GET_RECHARGE_REWARD, handler(self, self._onEventGetRechargeReward))
	self._signalEnterSuccess = G_SignalManager:add(SignalConst.EVENT_CAKE_ACTIVITY_ENTER_SUCCESS, handler(self, self._onEventEnterSuccess))
	
	if G_UserData:getCakeActivity():isExpired(TimeConst.RESET_TIME_24) then
		G_UserData:getCakeActivity():c2sEnterCakeActivity()
	end

	self._nodeTabRoot:setTabIndex(self._selectTabIndex)
	self:_updateList()

	local startTime1 = G_UserData:getCakeActivity():getActivityStartTime() --本服阶段开始时间
    local endTime1 = startTime1 + CakeActivityConst.CAKE_LOCAL_TIME --本服阶段结束时间
    local startTime2 = endTime1 + CakeActivityConst.CAKE_TIME_GAP --全服阶段开始时间
    local endTime2 = startTime2 + CakeActivityConst.CAKE_CROSS_TIME --全服阶段结束时间
    self._targetTime = endTime2
    self:_startCountDown()
	self:_updateRp()
end

function PopupCakeGet:onExit()
	self:_stopCountDown()

    self._signalGetTaskReward:remove()
    self._signalGetTaskReward = nil
    self._signalUpdateTaskInfo:remove()
    self._signalUpdateTaskInfo = nil
    self._signalGetRechargeReward:remove()
    self._signalGetRechargeReward = nil
    self._signalEnterSuccess:remove()
    self._signalEnterSuccess = nil
end

function PopupCakeGet:_startCountDown()
    self:_stopCountDown()
    self._scheduleHandler = SchedulerHelper.newSchedule(handler(self, self._updateCountDown), 1)
    self:_updateCountDown()
end

function PopupCakeGet:_stopCountDown()
    if self._scheduleHandler ~= nil then
        SchedulerHelper.cancelSchedule(self._scheduleHandler)
        self._scheduleHandler = nil
    end
end

function PopupCakeGet:_updateCountDown()
	local countDown = self._targetTime - G_ServerTime:getTime()
	if countDown >= 0 then
		self._textCountDownTitle:setString(Lang.get("cake_activity_countdown_common_title"))
		self._textCountDownTitle:setPositionX(58)
		local timeString = G_ServerTime:getLeftDHMSFormatEx(self._targetTime)
    	self._textCountDown:setString(timeString)
    else
		self._textCountDownTitle:setString(Lang.get("cake_activity_countdown_finish"))
		self._textCountDownTitle:setPositionX(100)
    	self._textCountDown:setString("")
    	self:_stopCountDown()
	end

	-- i18n change pos
	if not Lang.checkLang(Lang.CN) then
		self:_alignNodeByI18n()
	end
	
end

function PopupCakeGet:_onTabSelect(index, sender)
	if index == self._selectTabIndex then
		return
	end

	self._selectTabIndex = index
	self:_updateList()
	if self._selectTabIndex == CakeActivityConst.MATERIAL_TYPE_2 then --获取奶油页签红点判断
		G_SignalManager:dispatch(SignalConst.EVENT_RED_POINT_CLICK,
			FunctionConst.FUNC_CAKE_ACTIVITY_GET_MATERIAL,{index = CakeActivityConst.MATERIAL_TYPE_2})
		self._nodeTabRoot:setRedPointByTabIndex(index, false)
	end
end

function PopupCakeGet:_updateList()
	if self._selectTabIndex == CakeActivityConst.MATERIAL_TYPE_1 then
		self:_updateList1()
	else
		self:_updateList2()
	end
end

function PopupCakeGet:_updateList1()
	self._listView1:setVisible(true)
	self._listView2:setVisible(false)
	self._textImagePayTip:setVisible(false)
	self._imageDes:loadTexture(Path.getTextAnniversaryImg("txt_anniversary04"))
	self._imageTip:setVisible(true)
	self._datas1 = G_UserData:getCakeActivity():getTaskList()
	self._listView1:clearAll()
	self._listView1:resize(#self._datas1)
end

function PopupCakeGet:_updateList2()
	self._listView1:setVisible(false)
	self._listView2:setVisible(true)
	self._textImagePayTip:setVisible(true)
	self._imageDes:loadTexture(Path.getTextAnniversaryImg("txt_anniversary05"))
	self._imageTip:setVisible(false)
	self._datas2 = G_UserData:getCakeActivity():getChargeList()
	self._listView2:clearAll()
	self._listView2:resize(#self._datas2)
end

function PopupCakeGet:_onItemUpdate1(item, index)
	local data = self._datas1[index + 1]
	if data then
		item:update(data)
	end
end

function PopupCakeGet:_onItemSelected1(item, index)

end

function PopupCakeGet:_onItemTouch1(index, t, state)
	local index = index + t
	local data = self._datas1[index]
	local taskId = data:getCurShowId()
	if state == CakeActivityConst.TASK_STATE_1 then
		local actStage = CakeActivityDataHelper.getActStage()
		if actStage == CakeActivityConst.ACT_STAGE_0 or actStage == CakeActivityConst.ACT_STAGE_4 then
			G_Prompt:showTip(Lang.get("cake_activity_act_end_tip"))
			return
		end
		local info = CakeActivityDataHelper.getCakeTaskConfig(taskId)
		local functionId = 0
		if taskId == 600 then --此处写死，600是答题活动，有2个参数，要特殊处理
			local ids = string.split(info.function_id, "|")
			local GuildServerAnswerHelper = require("app.scene.view.guildServerAnswer.GuildServerAnswerHelper")
			local isToday = GuildServerAnswerHelper.isTodayOpen()
			if isToday then --是全服答题的当天
				functionId = tonumber(ids[2])
			else
				functionId = tonumber(ids[1])
			end
		else
			functionId = tonumber(info.function_id)
		end
		local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
		WayFuncDataHelper.gotoModuleByFuncId(functionId)
	elseif state == CakeActivityConst.TASK_STATE_2 then
		G_UserData:getCakeActivity():c2sGetCakeActivityTaskReward(taskId)
	end
end

function PopupCakeGet:_onItemUpdate2(item, index)
	local data = self._datas2[index + 1]
	if data then
		item:update(data)
	end
end

function PopupCakeGet:_onItemSelected2(item, index)

end

function PopupCakeGet:_onItemTouch2(index, t)
	
end

function PopupCakeGet:_onClickClose()
	self:close()
end

function PopupCakeGet:_onEventGetTaskReward(eventName, taskId, awards)
	G_Prompt:showAwards(awards)
	if self._selectTabIndex == CakeActivityConst.MATERIAL_TYPE_1 then
		self:_updateList1()
	end
	self:_updateRp()
end

function PopupCakeGet:_onEventUpdateTaskInfo(eventName)
	if self._selectTabIndex == CakeActivityConst.MATERIAL_TYPE_1 then
		self:_updateList1()
	end
end

function PopupCakeGet:_onEventGetRechargeReward(eventName, awards)
	G_Prompt:showAwards(awards)
end

function PopupCakeGet:_onEventEnterSuccess()
	self:_updateList()
end

function PopupCakeGet:_updateRp()
	local show1 = G_UserData:getCakeActivity():isHaveCanGetMaterial()
	self._nodeTabRoot:setRedPointByTabIndex(CakeActivityConst.MATERIAL_TYPE_1, show1)
	local show2 = G_UserData:getCakeActivity():isPromptRecharge()
	self._nodeTabRoot:setRedPointByTabIndex(CakeActivityConst.MATERIAL_TYPE_2, show2)
end

-- i18n change lable
function PopupCakeGet:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
	    self._textImagePayTip = UIHelper.swapWithLabel(self._textImagePayTip,{
			 style = "text_1",
			 text = Lang.getImgText("txt_com_shop_tips01") ,
		})

	end
	if Lang.checkHorizontal() then
		local UIHelper  = require("yoka.utils.UIHelper")
		local img = UIHelper.seekNodeByName(self,"Image_43")
		img:loadTexture(Path.getCustomActivityUI("img_activity_you_h"))
		local titleBg = display.newSprite(Path.getCustomActivityUI("img_activity_title_h"))
		local bg = UIHelper.seekNodeByName(self,"Image_38")
		bg:addChild(titleBg)
		local size = bg:getContentSize()
		titleBg:setPosition(size.width/2,size.height)
		local img42 = UIHelper.seekNodeByName(self,"Image_42")
		img42:ignoreContentAdaptWithSize(true)
		img42:setPosition(-352,568)
	end
end

-- i18n change lable
function PopupCakeGet:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		
		local image40 = UIHelper.seekNodeByName(self,"Image_40")
		local text1 = UIHelper.seekNodeByName(self._imageTip,"Text_148_0")
		text1:setAnchorPoint(cc.p(0,0.5))
		text1:setPositionX(self._imageTip:getContentSize().width)
		self._imageTip:setAnchorPoint(cc.p(1,0.5))
		self._imageTip:setPositionX(image40:getContentSize().width-text1:getContentSize().width-8)

		self._textImagePayTip:setAnchorPoint(cc.p(1,0.5))
		self._textImagePayTip:setPositionX(
			self._listView1:getPositionX() + 
			self._listView1:getContentSize().width
		)
		local image = UIHelper.seekNodeByName(self,"Image_39","Image_47")
		if Lang.checkLang(Lang.KR) then
			image:setPositionY(image:getPositionY()+25)
		end

    end
end

-- i18n change lable
function PopupCakeGet:_alignNodeByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image = UIHelper.seekNodeByName(self,"Image_39","Image_47")
		UIHelper.alignCenter(image,{self._textCountDownTitle,self._textCountDown})
    end
end


return PopupCakeGet