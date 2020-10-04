--
-- Author: Liangxu
-- Date: 2019-4-30
-- 蛋糕活动信息列表

local CakeActivityInfoList = class("CakeActivityInfoList")
local CakeGivePushNode = require("app.scene.view.cakeActivity.CakeGivePushNode")
local CakeActivityConst = require("app.const.CakeActivityConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local SchedulerHelper = require ("app.utils.SchedulerHelper")

local NOTICE_BG = {
	[CakeActivityConst.NOTICE_TYPE_GET_FRUIT] = "img_special_02",
	[CakeActivityConst.NOTICE_TYPE_LEVEL_UP] = "img_special_01",
}

function CakeActivityInfoList:ctor(target, doAddMaterical)
	self._target = target
	self._doAddMaterical = doAddMaterical
	self._bulletDatas = {}
	self._scheduleHandler = nil
	self._noticeIndex = 0
	self._listTouching = false --是否正在触摸着list
	self._listScrolling = false --list是否正在滚动

	self._listView = ccui.Helper:seekNodeByName(self._target, "ListView")
	self._listView:addTouchEventListener(handler(self, self._onTouchList))
	self._listView:addScrollViewEventListener(handler(self, self._onScrollEvent))
	self._panelBullet = ccui.Helper:seekNodeByName(self._target, "PanelBullet")
	for i = 1, 5 do
		local nodeBullet = ccui.Helper:seekNodeByName(self._target, "NodeBullet"..i)
		self["_bullet"..i] = CakeGivePushNode.new(nodeBullet, i, handler(self, self._onBulletReset), handler(self, self._onDoGive))
	end
end

function CakeActivityInfoList:onExit()
	for i = 1, 5 do
		self["_bullet"..i]:onExit()
	end
	self:_stopAddInfo()
end

function CakeActivityInfoList:initInfoList()
	G_UserData:getCakeActivity():removeNoticeBeyond()
	local noticeDatas = G_UserData:getCakeActivity():getNoticeDatas()
	self._noticeIndex = 0
	for i, data in ipairs(noticeDatas) do
		self._noticeIndex = self._noticeIndex + 1
		self:addNotice(data)
	end
	self._listView:jumpToBottom()
	self:_startAddInfo()
end

function CakeActivityInfoList:_startAddInfo()
    self:_stopAddInfo()
    self._scheduleHandler = SchedulerHelper.newSchedule(handler(self, self._updateAddInfo), 0.1)
end

function CakeActivityInfoList:_stopAddInfo()
    if self._scheduleHandler ~= nil then
        SchedulerHelper.cancelSchedule(self._scheduleHandler)
        self._scheduleHandler = nil
    end
end

function CakeActivityInfoList:_updateAddInfo()
	local nextIndex = self._noticeIndex + 1
	local noticeData = G_UserData:getCakeActivity():getNoticeDataWithIndex(nextIndex)
	if noticeData then
		self._noticeIndex = nextIndex
		self:addNotice(noticeData)
		if self._listTouching == false and self._listScrolling == false then
			self._listView:jumpToBottom()
		end
	end
end

function CakeActivityInfoList:addNotice(data)
	local notice = self:_createNotice(data)
	self._listView:pushBackCustomItem(notice)
	local items = self._listView:getItems()
	if #items > CakeActivityConst.INFO_LIST_MAX_COUNT then --到最大数后，删除第一个
		self._listView:removeItem(1)
	end
end

function CakeActivityInfoList:_createNotice(data)
	local noticeId = data:getNotice_id()
	local widget = ccui.Widget:create()
	local formatStr = nil
	local params = nil
	local serverName = data:getContentDesWithKey("sname")
	if noticeId == CakeActivityConst.NOTICE_TYPE_COMMON then
		local itemId = tonumber(data:getContentDesWithKey("itemid1"))
		local itemParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, itemId)
		local official = tonumber(data:getContentDesWithKey("uol"))
		formatStr = Lang.get("cake_activity_notice_des_1", 
								{guildName1 = serverName..""..data:getContentDesWithKey("sgname"), 
								userName = data:getContentDesWithKey("uname"), 
								guildName2 = data:getContentDesWithKey("tgname"),
								itemName = itemParam.name,
								count = data:getContentDesWithKey("itemnum")})
		params = {defaultColor = Colors.CLASS_WHITE, defaultSize = 18, other = {{},{color = Colors.getOfficialColor(official)}, {}, {color = itemParam.icon_color}}}
		if Lang.checkLang(Lang.EN) then
			params = {defaultColor = Colors.CLASS_WHITE, defaultSize = 18, other = {{color = Colors.getOfficialColor(official)}, {}, {color = itemParam.icon_color},{}}}
		end

	elseif noticeId == CakeActivityConst.NOTICE_TYPE_LEVEL_UP then
		formatStr = Lang.get("cake_activity_notice_des_2", 
								{guildName = serverName..""..data:getContentDesWithKey("sgname"), 
								level = data:getContentDesWithKey("clv")})
		params = {defaultColor = Colors.DARK_BG_THREE, defaultSize = 18}

	elseif noticeId == CakeActivityConst.NOTICE_TYPE_GET_FRUIT then
		local itemId1 = tonumber(data:getContentDesWithKey("itemid1"))
		local itemId2 = tonumber(data:getContentDesWithKey("itemid2"))
		local itemParam1 = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, itemId1)
		local itemParam2 = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, itemId2)
		local official = tonumber(data:getContentDesWithKey("uol"))
		formatStr = Lang.get("cake_activity_notice_des_3", 
								{name = serverName..""..data:getContentDesWithKey("uname"), 
								itemName1 = itemParam1.name,
								itemName2 = itemParam2.name})
		params = {defaultColor = Colors.DARK_BG_THREE, defaultSize = 18, other = {{color = Colors.getOfficialColor(official)}, 
																					{color = itemParam1.icon_color}, 
																					{color = itemParam2.icon_color}}}
	end
	local richText = ccui.RichText:createRichTextByFormatString(formatStr, params)
	richText:setAnchorPoint(cc.p(0, 0.5))
	richText:ignoreContentAdaptWithSize(false)
	richText:setVerticalSpace(4)
	richText:setContentSize(cc.size(310,0))
	richText:formatText()
	local textHeight = richText:getContentSize().height + 8
	local widgetHeight = textHeight + 8
	widget:setContentSize(cc.size(350, widgetHeight))
	local bgRes = NOTICE_BG[noticeId]
	if bgRes then
		local imageBg = ccui.ImageView:create()
		imageBg:loadTexture(Path.getAnniversaryImg(bgRes))
		imageBg:setScale9Enabled(true)
		imageBg:setCapInsets(cc.rect(20,12,1,1))
		imageBg:setAnchorPoint(cc.p(0, 0.5))
		imageBg:setContentSize(cc.size(330, textHeight))
		imageBg:setPosition(cc.p(10, widgetHeight/2))
		widget:addChild(imageBg)
	end
	richText:setPosition(cc.p(20, widgetHeight/2))
	widget:addChild(richText)
	return widget
end

function CakeActivityInfoList:pushBullet(noticeDatas)
	self:_pushBulletData(noticeDatas)
	self:_pushBulletNode()
end

function CakeActivityInfoList:_pushBulletData(noticeDatas)
	for i, noticeData in ipairs(noticeDatas) do
		local exitBullet = self:_getExistBullet(noticeData)
		if exitBullet then
			exitBullet:addCount(tonumber(noticeData:getContentDesWithKey("itemnum")))
		else
			if noticeData:isFake() then --假的（自己发出的）插到最前面
				table.insert(self._bulletDatas, 1, noticeData)
				self:_checkBullet()
			else
				table.insert(self._bulletDatas, noticeData)
			end
		end
	end
end

--检查bullet，保证有个空bullet来显示之前插到最前面的数据
function CakeActivityInfoList:_checkBullet()
	local bullet = nil
	for i = 1, 5 do --先找空的
		if self["_bullet"..i]:isEmpty() then
			bullet = self["_bullet"..i]
			break
		end
	end
	if bullet == nil then --空的没找到，找显示真数据的
		for i = 1, 5 do
			if self["_bullet"..i]:isFake() == false then
				bullet = self["_bullet"..i]
				break
			end
		end
	end
	if bullet == nil then --还没找到，用第一个
		bullet = self._bullet1
	end
	bullet:forceReset()
end

function CakeActivityInfoList:_pushBulletNode()
	for i = 1, 5 do
		if self["_bullet"..i]:isEmpty() then
			local data = self._bulletDatas[1]
			if data then
				self["_bullet"..i]:playStart(data)
				table.remove(self._bulletDatas, 1)
			end
		end
	end
end

function CakeActivityInfoList:_onBulletReset()
	self:_pushBulletNode()
end

function CakeActivityInfoList:_onDoGive(item)
	if item and self._doAddMaterical then
		self._doAddMaterical(item)
	end
end

--获取还存在的bullet
function CakeActivityInfoList:_getExistBullet(data)
	for i = 1, 5 do
		if self["_bullet"..i]:isEmpty() == false and self["_bullet"..i]:isSameNode(data) then
			return self["_bullet"..i]
		end
	end
	return nil
end

function CakeActivityInfoList:_onTouchList(sender, state)
	if state == ccui.TouchEventType.began then
		self._listTouching = true
	elseif state == ccui.TouchEventType.moved then
		self._listTouching = true
	elseif state == ccui.TouchEventType.ended or state == ccui.TouchEventType.canceled then
		self._listTouching = false
	end
end

function CakeActivityInfoList:_onScrollEvent(sender, eventType)
	if eventType == 10 then
        self._listScrolling = false
    elseif eventType ~= 9 then
    	self._listScrolling = true
    end
end

return CakeActivityInfoList