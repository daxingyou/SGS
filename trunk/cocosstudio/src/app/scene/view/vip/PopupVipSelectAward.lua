
local PopupBase = require("app.ui.PopupBase")
local PopupVipSelectAward = class("PopupVipSelectAward", PopupBase)
local UIHelper  = require("yoka.utils.UIHelper")
local VipConst = require("app.const.VipConst")
local ComponentIconHelper = require("app.ui.component.ComponentIconHelper")
local vip_content = require("app.config.vip_content")
local UserDataHelper = require("app.utils.UserDataHelper")
local PopupVipSelectAwardItemCell = require("app.scene.view.vip.PopupVipSelectAwardItemCell")
function PopupVipSelectAward:ctor(callback,receiveList,num,maxNum)
    self._callback = callback
    self._awards = {}
    self._receiveList = receiveList
    dump(self._receiveList)
    self._leftTimes = num-- temp
    self._maxTimes = maxNum -- temp
    self._boxInfoList = {}
    self._currOpenServerTime = 0
    self._dataDirty = false
	local resource = {
		file = Path.getCSB("PopupVipSelectAward", "vip"),
		binding = {
            _buttonClose = {
				events = {{event = "touch", method = "_onClickClose"}}
			}
		}
	}
	PopupVipSelectAward.super.ctor(self, resource)
end


function PopupVipSelectAward:_onClickClose()
    self:close()
end

function PopupVipSelectAward:_onClickButtonCancel()
	self:close()
end

function PopupVipSelectAward:onCreate()
    --self._commonTip:updateLangName("FUNC_vip_select_award_HELP") -- temp
    --self._popupBg:setTitle(Lang.get("vip_select_award_title"))
    --self._popupBg:addCloseEventListener(handler(self, self._onClickButtonCancel))
	--self._buttonBuy:setString(Lang.get("common_receive"))
    --self._buttonBuy:getDesc():setFontName(Path.getFontW8())
    self._textTips:setString(Lang.get("vip_select_award_hint1"))
    self._textDes1:setString(Lang.get("vip_select_award_hint2"))
    self._textDes2:setString(Lang.get("vip_select_award_hint4"))
    
end

function PopupVipSelectAward:onEnter()
    self._signalPosterGirlBoxInfoUpdate = G_SignalManager:add(SignalConst.EVENT_POSTER_GIRL_BOX_INFO_UPDATE, 
    handler(self,self._onEventPosterGirlBoxInfoUpdate))
    self:scheduleUpdateWithPriorityLua(handler(self, self._update),1)

    self:_initData()
    self:_createItemsView()
    self:_updateView()
    self:_startTimer()
end

function PopupVipSelectAward:onExit()
    self._signalPosterGirlBoxInfoUpdate:remove()
    self._signalPosterGirlBoxInfoUpdate = nil
    self:unscheduleUpdate()

    G_ServiceManager:DeleteOneAlarmClock("PopupVipSelectAward")

end

function PopupVipSelectAward:_getNextTime()
    local nextTime = nil
    local onlineTime = G_UserData:getBase():getOnlineTime()
    for k,v in ipairs(self._boxInfoList) do
		if onlineTime < v.config.require_value * 60 then
            nextTime = v.config.require_value * 60
            break
		end
    end
    return nextTime
end

function PopupVipSelectAward:_startTimer()
    local nextTime = self:_getNextTime()
    if nextTime then
        local onlineTime = G_UserData:getBase():getOnlineTime() 
        local remainTime = math.max(0,nextTime-onlineTime)
        local curTime = G_ServerTime:getTime()
        G_ServiceManager:registerOneAlarmClock("PopupVipSelectAward", curTime + remainTime, function()
            local canShowEffectNum = UserDataHelper.getPGCanReceiveNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
            local receiveNum = UserDataHelper.getPosterGirlReceiveBoxNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
            local leftTimes = canShowEffectNum-receiveNum
            --if self._leftTimes ~= leftTimes then
               self._leftTimes = leftTimes
                self:_updateView()
            --end
        end)
    end
end


function PopupVipSelectAward:_update(dt)
    local nextTime = self:_getNextTime()
    local onlineTime = G_UserData:getBase():getOnlineTime() 
 
    

    if nextTime then
        local remainTime = math.max(0,nextTime-onlineTime)
        local hour = (remainTime-remainTime%3600)/3600
        local minute = (remainTime-hour*3600 -remainTime%60)/60
        local second = remainTime%60
        local timeStr = string.format("%02d:%02d:%02d",hour,minute,second)
        self._textDes2:setString(Lang.get("vip_select_award_hint3",{time = timeStr}))
    else
        self._textDes2:setString(Lang.get("vip_select_award_hint4"))
    end
    UIHelper.alignCenter(self._awardsNode,{self._textDes1,self._textTimes,self._textDes2},nil,nil,nil)
end

function PopupVipSelectAward:_onEventPosterGirlBoxInfoUpdate(event)
    --print("PopupVipSelectAward _onEventPosterGirlBoxInfoUpdate ")
    self:_initData()
    self:_createItemsView()
    self:_updateView()
    self:_startTimer()
end

function PopupVipSelectAward:_initData()
    local canShowEffectNum,maxNum = UserDataHelper.getPGCanReceiveNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
    local receiveNum = UserDataHelper.getPosterGirlReceiveBoxNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
    local receiveList = UserDataHelper.getPGReceiveRewardIds(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
    local num = canShowEffectNum-receiveNum
    self._receiveList = receiveList
    self._leftTimes = num-- temp
    self._maxTimes = maxNum -- temp


    self._boxInfoList = UserDataHelper.getPosterGirlBoxInfoList(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
    local TimeConst = require("app.const.TimeConst")
    local openDay = G_UserData:getBase():getOpenServerDayNum(TimeConst.RESET_TIME_24)
    if self._currOpenServerTime ~= openDay then
        self._currOpenServerTime = openDay
        local list = {}
        for i = 1, vip_content.length() do
            local data = vip_content.indexOf(i)
            print("PopupVipSelectAward "..openDay)
            if openDay >= data.day_min and openDay <= data.day_max then
                table.insert(list,data)
            end
        end
        self._awards = list
        self._dataDirty = true
    end
   
end

function PopupVipSelectAward:_updateView()
    --self._buttonBuy:setEnabled(self._leftTimes > 0)
    --self._textDes:setString(Lang.get("vip_select_award_desc"))
    self:_updateTimes()
    self:_refreshItemState()
end

function PopupVipSelectAward:_updateTimes()
    local leftTimes = self._leftTimes 
    self._textTimes:setString(tostring(leftTimes))
    self._textTimes:setColor(leftTimes <= 0 and Colors.uiColors.RED or 
        Colors.BRIGHT_BG_GREEN)
    local UIHelper  = require("yoka.utils.UIHelper")
    UIHelper.alignCenter(self._awardsNode,{self._textDes1,self._textTimes,self._textDes2},nil,nil,nil)
end

function PopupVipSelectAward:_createItemsView()
    if not self._dataDirty then
        --print("PopupVipSelectAward _dataDirty ")
        return 
    end
    --print("PopupVipSelectAward _createItemsView ")
    self._dataDirty = false

    self._awardsNode:removeAllChildren()
    local awards = self._awards
    local lineItemCount = 3
    local posType = 1
    if #awards <= 6 then
        lineItemCount = 3
        posType = 1
    else
        lineItemCount = 4
        posType = 2
    end
    local lineNum = math.ceil(#awards/lineItemCount)--行数
    print("PopupVipSelectAward "..lineNum)
    local startXList = {-167, -243}
    local posYList = {88.6,88.6}
    local scaleList = {1,1}
    local hGapList = {159,160}
    local vGapList = {180,180}
    local startX = startXList[posType]
    local startY = posYList[posType]
    local hGap = hGapList[posType]
    local vGap = vGapList[posType]
    local maxCol = lineNum <= 1 and #awards or lineItemCount
    for i = 1, #awards, 1 do
        local award = awards[i]

        local itemNode  = PopupVipSelectAwardItemCell.new()
        itemNode:setTag(i)
        itemNode:updateUI(award)
        itemNode:setCustomCallback(handler(self,self._onItemClick))

        
        self._awardsNode:addChild(itemNode)

        local currLineNum = math.ceil(i/lineItemCount)--行数
        local currCol = i - (currLineNum -1) * lineItemCount

        local x = startX + (currCol - 1) * hGap
        local y = startY - (currLineNum -1) * vGap
        itemNode:setPosition(x,y)
    end

end

function PopupVipSelectAward:_refreshItemState()
    local children = self._awardsNode:getChildren()
    for k,v in ipairs(children) do
        local award = self._awards[k]
        local state =  PopupVipSelectAwardItemCell.STATE_NOT_RECEIVE
        if self._receiveList[award.id]  then
            state = PopupVipSelectAwardItemCell.STATE_HAS_RECEIVED
        elseif self._leftTimes > 0 then
            state = PopupVipSelectAwardItemCell.STATE_CAN_RECEIVE
        else
            state = PopupVipSelectAwardItemCell.STATE_NOT_RECEIVE
        end
        v:setIconState(state)
    end
end

function PopupVipSelectAward:_onItemClick(tag)
    if self._leftTimes <= 0 then
        local MessageError = require("app.config.net_msg_error")
        local errMsg = MessageError.get(10312)
        assert(errMsg,"can not find id "..tostring(10312))
        local txt = errMsg and errMsg.error_msg or ""
        G_Prompt:showTip(txt)
        return
    end

    local award =  self._awards[tag]
    local list = {}
    table.insert(list, award.id)
	if self._callback then
		self._callback(list)
	end
end


return PopupVipSelectAward