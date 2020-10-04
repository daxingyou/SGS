
local PopupBase = require("app.ui.PopupBase")
local PopupVipSelectAward = class("PopupVipSelectAward", PopupBase)
local UIHelper  = require("yoka.utils.UIHelper")
local VipConst = require("app.const.VipConst")
local LINE_ITEM_COUNT = 3  -- 一行3个ICON
local ComponentIconHelper = require("app.ui.component.ComponentIconHelper")
local vip_content = require("app.config.vip_content")

function PopupVipSelectAward:ctor(callback,receiveList,num,maxNum)
    self._callback = callback
    self._selectIds = {}
    self._awards = {}
    self._receiveList = receiveList
    dump(self._receiveList)
    self._leftTimes = num-- temp
    self._maxTimes = maxNum -- temp
	local resource = {
		file = Path.getCSB("PopupVipSelectAward", "vip"),
		binding = {
			_buttonBuy = {
				events = {{event = "touch", method = "_onClickButtonBuy"}}
			},
		}
	}
	PopupVipSelectAward.super.ctor(self, resource)
end

function PopupVipSelectAward:onCreate()
    self._commonTip:updateLangName("FUNC_vip_select_award_HELP") -- temp
    self._popupBg:setTitle(Lang.get("vip_select_award_title"))
    self._popupBg:addCloseEventListener(handler(self, self._onClickButtonCancel))
	self._buttonBuy:setString(Lang.get("common_receive"))
    self._buttonBuy:getDesc():setFontName(Path.getFontW8())
    self:_initData()
	self:_updateView()
end

function PopupVipSelectAward:onEnter()
    self._signalPosterGirlBoxInfoUpdate = G_SignalManager:add(SignalConst.EVENT_POSTER_GIRL_BOX_INFO_UPDATE, 
    handler(self,self._onEventPosterGirlBoxInfoUpdate))
end

function PopupVipSelectAward:onExit()
    self._signalPosterGirlBoxInfoUpdate:remove()
	self._signalPosterGirlBoxInfoUpdate = nil
end

function PopupVipSelectAward:_onEventPosterGirlBoxInfoUpdate(event)
    local UserDataHelper = require("app.utils.UserDataHelper")
    local canShowEffectNum,maxNum = UserDataHelper.getPGCanReceiveNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
    local receiveNum = UserDataHelper.getPosterGirlReceiveBoxNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
    local receiveList = UserDataHelper.getPGReceiveRewardIds(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
    local num = canShowEffectNum-receiveNum
    self._selectIds = {}
    self._awards = {}
    self._receiveList = receiveList
    self._leftTimes = num-- temp
    self._maxTimes = maxNum -- temp

    self:_initData()
	self:_updateView()
end

function PopupVipSelectAward:_initData()
    for i = 1, vip_content.length() do
        local data = vip_content.indexOf(i)
        local openDay = G_UserData:getBase():getOpenServerDayNum()
        print("PopupVipSelectAward "..openDay)
        if openDay >= data.day_min and openDay <= data.day_max then
            table.insert(self._awards,data)
        end
    end
end

function PopupVipSelectAward:_updateView()
    self._textDes:setString(Lang.get("vip_select_award_desc"))
    self:_updateTimes()
    self:_updateAwards()
end

function PopupVipSelectAward:_updateTimes()
    local leftTimes = self._leftTimes - #table.keys(self._selectIds)
    local text = string.format("%d/%d",leftTimes,self._maxTimes)
    self._textTimes:setString(text)
    local UIHelper  = require("yoka.utils.UIHelper")
    UIHelper.alignCenter(self._imgBg,{self._textDes,self._textTimes},{10,0})
end

function PopupVipSelectAward:_updateAwards()
    self._awardsNode:removeAllChildren()

    local awards = self._awards
   
    local lineNum = math.ceil(#awards/LINE_ITEM_COUNT)--行数
    
    local startXList = { -152, -152, -152}
    local posYList = {0,59,88}
    local scaleList = {1,1,0.8}
    local hGapList = {152,152,152}
    local vGapList = {0,115,88}
    local startX = startXList[lineNum]
    local startY = posYList[lineNum]
    local hGap = hGapList[lineNum]
    local vGap = vGapList[lineNum]
    local maxCol = lineNum <= 1 and #awards or LINE_ITEM_COUNT
    for i = 1, #awards, 1 do
        local award = awards[i]
        local itemNode = ComponentIconHelper.createIcon(award.type, award.value, award.size)
        itemNode:setScale(scaleList[lineNum])
        if self._receiveList[award.id] then
            self:setIconReceived(itemNode)
        else
            itemNode:setCallBack(function()
                self:setIconSelect(itemNode,award)
                self:_updateTimes()
            end)
        end
        
        self._awardsNode:addChild(itemNode)

        local currLineNum = math.ceil(i/LINE_ITEM_COUNT)--行数
        local currCol = i - (currLineNum -1) * LINE_ITEM_COUNT

        local x = startX + (currCol - 1) * hGap
        local y = startY - (currLineNum -1) * vGap
        itemNode:setPosition(x,y)
    end
end

function PopupVipSelectAward:_onClickButtonBuy()
    local list = {}
    for k,v in pairs(self._selectIds) do
        table.insert(list, k)
    end
	if self._callback then
		self._callback(list)
	end
    self:close()
end

function PopupVipSelectAward:_onClickButtonCancel()
	self:close()
end

function PopupVipSelectAward:setIconReceived(icon)
    local params = {
        texture = Path.getVip2("img_xuanze1"),
        adaptWithSize = true,
        position = cc.p(49, 49),
        anchorPoint = cc.p(0.5, 0.5)
    }
    local coverImg = UIHelper.createImage(params)
    icon:appendUI(coverImg)
    local scale = 1/icon:getScale()
    coverImg:setScale(scale)

    local params = {
        texture = Path.getUICommon("img_com_check05b"),
        adaptWithSize = true,
        position = cc.p(49, 49),
        anchorPoint = cc.p(0.5, 0.5)
    }
    local selectImg = UIHelper.createImage(params)
    icon:appendUI(selectImg)

    icon:setTouchEnabled(false)
end

function PopupVipSelectAward:setIconSelect(icon,award)
    if self._receiveList[award.id] then
        return 
    end
    if icon._vipSelectImg == nil then
        local params = {
            texture = Path.getVip2("img_xuanze2"),
            adaptWithSize = true,
            position = cc.p(49, 49),
            anchorPoint = cc.p(0.5, 0.5)
        }
        local selectImg = UIHelper.createImage(params)
        selectImg:setVisible(false)
        icon:appendUI(selectImg)
        local scale = 1/icon:getScale()
        selectImg:setScale(scale)
        icon._vipSelectImg = selectImg
    end
    if self._selectIds[award.id] then
        icon._vipSelectImg:setVisible(false)
        self._selectIds[award.id] = nil
    else
        if #table.keys(self._selectIds) < self._leftTimes then
            icon._vipSelectImg:setVisible(true)
            self._selectIds[award.id] = true
        end
    end
    -- dump(table.keys(self._selectIds),"lkm")
end

return PopupVipSelectAward