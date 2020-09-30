local UserDataHelper = require("app.utils.UserDataHelper")
local VipPrivilegeView = require("app.scene.view.vip.VipPrivilegeView")
local PopupBase = require("app.ui.PopupBase")
local PopupPrivilegeView = class("PopupPrivilegeView", PopupBase)

function PopupPrivilegeView:ctor()
    self._listData = nil
    self._vipList  = {}
    self._maxVipShowLevel = nil
    self._privilegeNode = nil
	self._privilegePageView = nil
	local resource = {
		file = Path.getCSB("PopupPrivilegeView", "vip"),
		binding = {
		}
	}
	PopupPrivilegeView.super.ctor(self, resource,true)
end

function PopupPrivilegeView:onCreate()
	cc.bind(self._commonProgressNode,"CommonProgressNode")

    self._resourceNode:updateButton("Button_turn_left", function ()
		local currentPage = self._privilegePageView:getCurrentPageIndex()
		if currentPage > 0 then
			self._privilegePageView:scrollToPageEx(currentPage - 1)
			self:_refreshVipCurrLevelInfo(currentPage - 1)
		end
	end)

	self._resourceNode:updateButton("Button_turn_right", function ()
		local currentPage = self._privilegePageView:getCurrentPageIndex()
		local pageSize = self._privilegePageView:getPageSize()
		if currentPage + 1 < pageSize then
			self._privilegePageView:scrollToPageEx(currentPage + 1)
			self:_refreshVipCurrLevelInfo(currentPage + 1)
		end
    end)
    
    local privilegePageView = self._nodePageView:getSubNodeByName("PageView_privilege")
    cc.bind(privilegePageView,"CommonPageView")
    self._privilegePageView = self._nodePageView:getSubNodeByName("PageView_privilege")
    self._privilegePageView:setScrollDuration(0.7)
    self._privilegePageView:initPageView(VipPrivilegeView,
        handler(self,self._onPageViewUpdateItem),handler(self, self._onPageViewEvent),true)
end

function PopupPrivilegeView:onEnter()
    self._signalRechargeGetInfo = G_SignalManager:add(SignalConst.EVENT_RECHARGE_GET_INFO, handler(self, self._onEventRechargeGetInfo ))
    logWarn("PopupPrivilegeView ---------------- onEnter")
    
    self:_updatePageView()
	self:_scrollToVipLevel()
	self:_updateLevelView()
end

function PopupPrivilegeView:onExit()
	self._signalRechargeGetInfo:remove()
	self._signalRechargeGetInfo = nil
end

function PopupPrivilegeView:_onEventRechargeGetInfo(id, message)
    self:_updatePageView()
end

function PopupPrivilegeView:_onPageViewUpdateItem(item,i)
	logWarn("########___________ update "..i)
	item:updateUI(self._vipList[i+1])
end

---pageview页码变化
function PopupPrivilegeView:_onPageViewEvent(sender, eventType)
    if eventType == ccui.PageViewEventType.turning and sender == self._privilegePageView then
		self:_refreshVipCurrLevelInfo(self._privilegePageView:getCurrentPageIndex())
    end
end

function PopupPrivilegeView:_onItemUpdate(item, index)
	if self._listData[index + 1] then
		item:updateUI(self._listData[index + 1] )
	end
end

function PopupPrivilegeView:_onItemSelected(item, index)
end

function PopupPrivilegeView:_onItemTouch(lineIndex,index)
end

function PopupPrivilegeView:_onBtnClose()
	self:close()
end


function PopupPrivilegeView:_updatePageView()
    local oldVipNum = #self._vipList 
    self._vipList =  UserDataHelper.getVipGiftPkgList()  or {}
    self._maxVipShowLevel = self._vipList[#self._vipList]:getId()
    if oldVipNum ~= #self._vipList then
        self._privilegePageView:refreshPage(self._vipList)
    end
end

function PopupPrivilegeView:_scrollToVipLevel()
	local vipLevel = G_UserData:getVip():getLevel()
	self._privilegePageView:setCurrentPageIndexEx(vipLevel)
	local vipData = G_UserData:getVip():getVipDataByLevel(vipLevel)
	local currentPage = self._privilegePageView:getItemEx(vipLevel)
	if currentPage then
		currentPage:updateUI(vipData)
	end
	self:_refreshVipCurrLevelInfo(vipLevel)
end

function PopupPrivilegeView:_refreshVipCurrLevelInfo(pageIndex)
	local currLevel = pageIndex 
	local maxVipLv = self._maxVipShowLevel  or G_UserData:getVip():getShowMaxLevel()
	self:getSubNodeByName("Button_turn_left"):setVisible(currLevel ~= 0)
	self:getSubNodeByName("Button_turn_right"):setVisible(currLevel < maxVipLv)
end


---顶部基础信息
function PopupPrivilegeView:_updateLevelView()
	local VipLevelInfo = require("app.config.vip_level")
	local maxVipLv = G_UserData:getVip():getShowMaxLevel()
	local currentVipLv = G_UserData:getVip():getLevel()
	local currentVipExp = G_UserData:getVip():getExp()
	local nextVipLv = currentVipLv == maxVipLv and maxVipLv or currentVipLv + 1
	local curVipLvInfo = G_UserData:getVip():getVipDataByLevel(currentVipLv):getInfo()

    
	if maxVipLv ~= currentVipLv then
		--[[
		local imageVip = self._nodeLevelNotFull:getSubNodeByName("_nextVipValue")
		local nextGoldValueText1 = self._nodeLevelNotFull:getSubNodeByName("Text_next_gold_value_1")
		local nextGoldValueText2 = self._nodeLevelNotFull:getSubNodeByName("Text_next_gold_value_2")
		local nextGoldValueText3 = self._nodeLevelNotFull:getSubNodeByName("Text_next_gold_value_3")

		self._nodeLevelNotFull:setVisible(true)
		self._textLevelFull:setVisible(false)

		imageVip:setString(Lang.get("lang_vip_value", {num = nextVipLv}))

		
		local textProgress = self._commonProgressNode:getSubNodeByName("TextProgress")
		textProgress:setString(tostring(currentVipExp) .. "/" .. tostring(curVipLvInfo.vip_exp))
        
        nextGoldValueText1:setString(Lang.get("lang_vip_next_level_title_1"))
        nextGoldValueText2:setString(curVipLvInfo.vip_exp - currentVipExp)
        nextGoldValueText3:setString(Lang.get("lang_vip_next_level_title_4"))
		nextGoldValueText2:setPositionX(nextGoldValueText1:getPositionX() + nextGoldValueText1:getContentSize().width + 4)
        nextGoldValueText3:setPositionX(nextGoldValueText2:getPositionX() + nextGoldValueText2:getContentSize().width + 4)

		

		local totalWidth   = 0
		totalWidth = totalWidth + nextGoldValueText1:getContentSize().width + nextGoldValueText2:getContentSize().width + nextGoldValueText3:getContentSize().width
		imageVip:setPositionX(nextGoldValueText1:getPositionX() + totalWidth + 8)

]]
		self._nodeLevelNotFull:setVisible(true)
		self:_refreshRichText(Lang.get("vip_privilege_tips",{vip = nextVipLv,exp = curVipLvInfo.vip_exp - currentVipExp}))

		local textProgress = self._commonProgressNode:getSubNodeByName("TextProgress")
		textProgress:setString(tostring(currentVipExp) .. "/" .. tostring(curVipLvInfo.vip_exp) )
	else
		self._nodeLevelNotFull:setVisible(false)
		self._textLevelFull:setString(Lang.get("lang_level_full"))
		self._textLevelFull:setVisible(true)

		local textProgress = self._commonProgressNode:getSubNodeByName("TextProgress")
		textProgress:setString(tostring(currentVipExp) )
	end


	local progressBar = self._commonProgressNode:getSubNodeByName("LoadingBar")
	progressBar:setPercent(currentVipExp >= curVipLvInfo.vip_exp and  100 or (currentVipExp / curVipLvInfo.vip_exp) * 100)
end


function PopupPrivilegeView:_refreshRichText(content)
	local textDesc = ccui.RichText:createWithContent(content)
	textDesc:setAnchorPoint(cc.p(0.5, 0.5))
	self._nodeLevelNotFull:removeAllChildren()
	self._nodeLevelNotFull:addChild(textDesc)
end




return PopupPrivilegeView