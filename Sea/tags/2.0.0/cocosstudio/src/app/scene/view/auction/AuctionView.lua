--拍卖界面
local ViewBase = require("app.ui.ViewBase")
local AuctionView = class("AuctionView", ViewBase)

local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local AuctionConst = require("app.const.AuctionConst")
local TextHelper = require("app.utils.TextHelper")

local TabScrollView = require("app.utils.TabScrollView")
local AuctionHelper = require("app.scene.view.auction.AuctionHelper")
local AuctionItemCell = import(".AuctionItemCell")
local PopupAuctionLog = import(".PopupAuctionLog")
local scheduler = require("cocos.framework.scheduler")

function AuctionView:waitEnterMsg(callBack)
	local function onMsgCallBack()
		callBack()
		self._needRequest = false
	end

	G_UserData:getAuction():c2sGetAllAuctionInfo()

    local signal = G_SignalManager:add(SignalConst.EVENT_GET_ALL_AUCTION_INFO, onMsgCallBack)
	return signal
end


function AuctionView:ctor(tabIndex)
	--csb bind var name
	self._commonFullScreen = nil  --CommonFullScreen
	self._textAuctionShare = nil  --Text
	self._commonRes = nil  --CommonResourceInfo
	self._listView = nil  --ScrollView
	self._nodeTabRoot = nil  --CommonTabGroupTree
	self._commonBtnAuction = nil  --CommonButtonHighLight
	self._topbarBase = nil  --CommonTopbarBase
	self._panelBk = nil  --Panel
	self._commonHelpBig = nil
	-----自定义数据
	self._dataList = nil
	self._popupAuctionLogSignal = nil
	self._popupAuctionLog = nil

	self._tabIndex = AuctionConst.AC_TYPE_WORLD --AuctionHelper.getAuctionStartIndex()
	self._selectTabIndex = 0
    local resource = {
        file = Path.getCSB("AuctionView", "auction"),
        size =  G_ResolutionManager:getDesignSize(),
        binding = {
			_commonBtnAuction = {
				events = {{event = "touch", method = "_onBtnAuctionLog"}}
			},
		}
    }
	self:setName("AuctionView")
    AuctionView.super.ctor(self, resource)
end


function AuctionView:onCreate()
	-- i18n pos lable
	self:_dealPosByI18n()

	self._topbarBase:setImageTitle("txt_sys_com_paimai")
	self._commonFullScreen:setTitle(Lang.get("auction_view_title1"))

	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)

	self._commonHelpBig:updateUI(FunctionConst.FUNC_AUCTION)

	local scrollViewParam = {
		template = AuctionItemCell,
		updateFunc = handler(self, self._onItemUpdate),
		selectFunc = handler(self, self._onItemSelected),
		touchFunc = handler(self, self._onItemTouch),
	}
	self._tabListView = TabScrollView.new(self._listView,scrollViewParam)


	self:_updateTabList()
	self._nodeTabRoot:setTabIndex(self._tabIndex)
	self._nodeTabRoot:openTreeTab(self._tabIndex)
	local tabType = self:getTabType(self._tabIndex)

	self._commonBtnAuction:setString(Lang.get("auction_log_title"..tabType))
	-- self._imageNoTimes:setVisible(true)
	self._imageNone:setVisible(true)
	--self._textNone:setVisible(true)
	--self._textNone:setString(Lang.get("none_auction"))
	--self._commonBtnLeft
end

function AuctionView:_updateTabList()
	local textList, groupData = AuctionHelper.getAuctionTextListEx()
	
	local param = {
		callback = handler(self, self._onTabSelect),
		textList = textList,
		groupData = groupData,
	}
	--dump(textList)
	--dump(groupData)
	--如果军团拍卖开启，则返回军团子节点
	--如果阵营开启，则返回阵营节点
	--不然就返回全服节点
	local function getAuctionStartIndex( groupData )
		-- body
		for i, mainData in pairs( groupData ) do
			--军团处理
			for j, subData in ipairs(mainData.subList) do
				if subData.type == AuctionConst.AC_TYPE_GUILD then
					if subData.tabIndex > 0 then
						return subData.tabIndex
					end
				end
			end
			--阵营竞技处理
			if mainData.type == AuctionConst.AC_TYPE_ARENA or
				 mainData.type == AuctionConst.AC_TYPE_TRADE or
				 mainData.type == AuctionConst.AC_TYPE_GM or 
				 mainData.type == AuctionConst.AC_TYPE_PERSONAL_ARENA then
				return mainData.tabIndex
			end
		end
		return AuctionConst.AC_TYPE_WORLD
	end

	self._tabIndex = getAuctionStartIndex(groupData) --AuctionHelper.getAuctionStartIndex()


	self._groupData = groupData
	self._nodeTabRoot:recreateTabs(param)
end

function AuctionView:_checkInTheGuild(index)
	--如果没加入公会，则会弹出进入公会弹框
	local tabType = self:getTabType(index)
	if tabType == AuctionConst.AC_TYPE_GUILD then
		local isInGuild = G_UserData:getGuild():isInGuild()
		if isInGuild == false then
			local function onOkClick()
				G_SceneManager:showDialog("app.scene.view.guild.PopupGuildListView")
			end
			local popupAlert = require("app.ui.PopupAlert").new(nil,Lang.get("auction_no_guild_notice"),onOkClick)
			popupAlert:setOKBtn(Lang.get("auction_no_guild_btn"))
			popupAlert:openWithAction()
			return false
		end
	end
	return true
end

function AuctionView:_onTabSelect(index, sender, groupData)
	local tabType = self:getTabType(index)
	--不在公会里，则点击无效，弹出
	if self:_checkInTheGuild(index) == false then
		return false
	end

	if self._selectTabIndex == index then
		return true
	end

	self._selectTabIndex = index
	if groupData.isMain == true then
		G_UserData:getAuction():c2sGetAuctionInfo(tabType)
		self._commonBtnAuction:setString(Lang.get("auction_log_title"..tabType))
	else
		self:_updateListView(index)
		self._commonBtnAuction:setString(Lang.get("auction_log_title"..tabType))
	end

	return true
	--self:_updateListView(self._selectTabIndex)
end

function AuctionView:onEnter()
	self._signalGetAuctionInfo = G_SignalManager:add(SignalConst.EVENT_GET_AUCTION_INFO, handler(self, self._onEventAuctionInfo))
	self._signalAuctionItem = G_SignalManager:add(SignalConst.EVENT_AUCTION_ITEM, handler(self, self._onEventAuctionItem))

	self._signalAuctionLog = G_SignalManager:add(SignalConst.EVENT_AUCTION_LOG, handler(self, self._onEventAuctionLog))

	self._signalAuctionUpdateItem =G_SignalManager:add(SignalConst.EVENT_AUCTION_UPDATE_ITEM,handler(self,
	self._onEventAuctionUpdateItem))

	self:_registerScheduler()
	self:_updateListView(self._selectTabIndex)

end

function AuctionView:onExit()
	self:_deleteScheduler()
	self._signalGetAuctionInfo:remove()
	self._signalGetAuctionInfo = nil

	self._signalAuctionItem:remove()
	self._signalAuctionItem = nil

	self._signalAuctionLog:remove()
	self._signalAuctionLog = nil

	self._signalAuctionUpdateItem:remove()
	self._signalAuctionUpdateItem =nil
--	self._signalAuctionBuyerReplace:remove()
--	self._signalAuctionBuyerReplace= nil
	if self._popupAuctionLogSignal then
		self._popupAuctionLogSignal:remove()
		self._popupAuctionLogSignal = nil
	end
end

function AuctionView:_onRequestTick( ... )
	-- boss开启则请求刷新
	--local tabType = self:getTabType(self._selectTabIndex)

	--G_UserData:getAuction():c2sGetAuctionInfo(tabType)
	--G_UserData:getAuction():c2sGetAuctionInfo(1)
end

--拍卖纪录
function AuctionView:_onBtnAuctionLog()
	local tabType = self:getTabType(self._selectTabIndex)
	G_UserData:getAuction():c2sGetAuctionLog(tabType)
end

function AuctionView:_updateListView(tabIndex)
	tabIndex = tabIndex or 1
	self._nodeInfo:setVisible(false)

	local tabType,configId,rootId = self:getTabType(tabIndex)
	--dump(configId)
	local dataList = AuctionHelper.getConfigIdByIndex(rootId,configId)
	--dump(dataList)
	self._commonFullScreen:setTitle(Lang.get("auction_view_title"..tabType))
	
	if not Lang.checkLang(Lang.CN) then
		self:_updateHelpPosByI18n()
	end
	if dataList then
		self._dataList = dataList
		self._tabListView:updateListView(tabIndex,#self._dataList)
		if #dataList == 0 then
			-- self._imageNoTimes:setVisible(true)
			self._imageNone:setVisible(true)
			--self._textNone:setVisible(true)
		else
			-- self._imageNoTimes:setVisible(false)
			self._imageNone:setVisible(false)
			--self._textNone:setVisible(false)
		end
	end

	local function procGuildAuctionShare()
		--军团拍卖，与阵营竞技，加入拍卖分红
		if AuctionConst.AC_BOUNS_TYPE_LIST[tabType] then
			local tabType,configId,rootCfgId = self:getTabType(self._selectTabIndex)
			local bouns = G_UserData:getAuction():getBonus(rootCfgId)
			self._nodeInfo:setVisible(true)
			self._commonRes:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_DIAMOND, bouns)
			-- self._commonRes:setTextColorToDTypeColor()

			

			local canBonus = false
			if rootCfgId and rootCfgId > 0 then
				canBonus = G_UserData:getAuction():isAuctionCanBonus(rootCfgId)
			end
		
			self._commonRes:setVisible(canBonus)
			self._textAuctionNoShare:setVisible(not canBonus)
			self._textAuctionNoShare:setString(Lang.get("auction_no_share"))
			self._textAuctionNoShare:setColor(Colors.TITLE_ONE)
		end
	end
	--处理公会拍卖，分红显示逻辑
	procGuildAuctionShare()
end



function AuctionView:_onItemUpdate(item, index)
	local data = self._dataList[index+1]

	if data then
		item:updateUI(index,data)
	end
end

function AuctionView:_onItemSelected(item, index)

end

function AuctionView:_onItemTouch(index, data,  buttonType)
	--self._listView:setLocation(10)

	local itemId = data:getId()
	local buyerId = data:getNow_buyer()
	local itemAward = data:getItem()
	local addPrice = data:getAdd_price()
	local nowPrice = data:getNow_price()
	local initPrice = data:getInit_price()
	local totalPrice = data:getFinal_price()
	local startTime = data:getStart_time()
	local timeLeft = G_ServerTime:getLeftSeconds(startTime)
    if timeLeft > 0 then
		G_Prompt:showTip(Lang.get("auction_time_no_reach"))
		return
	end
	if nowPrice == 0 then
		addPrice = initPrice
	end

	local function converTotalPrice(totalPrice)
		local retValue = totalPrice
		if buyerId == G_UserData:getBase():getId() then
			retValue = retValue - nowPrice
		end
		return retValue
	end
	local function onOkCallBack(addPrice, dlgType)
		local UserCheck = require("app.utils.logic.UserCheck")
		local retValue, dlgFunc = UserCheck.enoughCash(addPrice)
		if retValue == false then
			dlgFunc()
			return
		end

		local tabType,configId,rootCfgId = self:getTabType(self._selectTabIndex)
		G_UserData:getAuction():c2sAuction(tabType, itemId,rootCfgId, buttonType)
	end

	--竞拍逻辑，一口价逻辑，走dlg3
	--加价逻辑，走dlg2
	--首次竞拍，dlg1
	if buttonType == AuctionConst.BUTTON_TYPE_BUY then--一口价
		 self:_showBuyDlg3(itemAward,converTotalPrice(totalPrice),onOkCallBack,totalPrice)
	elseif buttonType == AuctionConst.BUTTON_TYPE_ADD then
		if buyerId and buyerId == G_UserData:getBase():getId() then
			if nowPrice + addPrice >= totalPrice then
			 	self:_showAddPriceDlg5(itemAward,totalPrice,onOkCallBack,converTotalPrice(totalPrice))
			else
			 	self:_showAddPriceDlg2(itemAward,addPrice,onOkCallBack)
			end
		else
			if nowPrice + addPrice >= totalPrice then
			 	self:_showBuyDlg3(itemAward,converTotalPrice(totalPrice),onOkCallBack)
			else
			 	self:_showAuctionDlg1(itemAward,nowPrice + addPrice,onOkCallBack)
			end
		end
	end

end


function AuctionView:_showAuctionDlg1(itemAward,addPrice,onOkCallBack)
  	local itemParams = TypeConvertHelper.convert(itemAward.type, itemAward.value, itemAward.size)
    if itemParams == nil then
        return
    end

    local richList = {}
    local richText1 = Lang.get("auction_add_price1",
    {
        resIcon = Path.getResourceMiniIcon(DataConst.RES_DIAMOND),
        resNum =  addPrice,

    })
	local numText = "x"..itemParams.size
	if itemParams.size == 1 then
		numText = ""
	end
    local richText2 = Lang.get("auciton_buy_item",
    {
        itemName = itemParams.name,
		itemColor = Colors.colorToNumber(itemParams.icon_color),
       -- outlineColor =  Colors.colorToNumber(itemParams.icon_color_outline ),
        itemNum = numText,
    })
    table.insert( richList, richText1)
    table.insert( richList, richText2)

	local function onCallBackFunc()
		onOkCallBack(addPrice,1)
	end

    local PopupAlert = require("app.ui.PopupAlert").new(Lang.get("common_title_notice"),"",onCallBackFunc)
    PopupAlert:addRichTextList(richList)
    PopupAlert:openWithAction()
end


function AuctionView:_showAddPriceDlg2(itemAward, addPrice,onOkCallBack)
  	local itemParams = TypeConvertHelper.convert(itemAward.type, itemAward.value, itemAward.size)
    if itemParams == nil then
        return
    end

    local richList = {}
    local richText1 = Lang.get("auction_add_price2",
    {
        resIcon = Path.getResourceMiniIcon(1),
        resNum =  addPrice,

    })

	local numText = "x"..itemParams.size
	if itemParams.size == 1 then
		numText = ""
	end
    local richText2 = Lang.get("auciton_buy_item",
    {
        itemName = itemParams.name,
		itemColor = Colors.colorToNumber(itemParams.icon_color),
       -- outlineColor =  Colors.colorToNumber(itemParams.icon_color_outline ),
        itemNum = numText,
    })
	table.insert( richList, Lang.get("auction_add_price_top2") )
    table.insert( richList, richText1)
    table.insert( richList, richText2)

	local function onCallBackFunc()
		onOkCallBack(addPrice,2)
	end
    local PopupAlert = require("app.ui.PopupAlert").new(Lang.get("common_title_notice"),"",onCallBackFunc)
    PopupAlert:addRichTextList(richList)
    PopupAlert:openWithAction()
end

function AuctionView:_showAddPriceDlg5(itemAward, totalPrice, onOkCallBack,addPrice)
  	local itemParams = TypeConvertHelper.convert(itemAward.type, itemAward.value, itemAward.size)
    if itemParams == nil then
        return
    end

    local richList = {}
    local richText1 = Lang.get("auction_add_price5",
    {
        resIcon = Path.getResourceMiniIcon(1),
        resNum =  totalPrice,

    })

	local numText = "x"..itemParams.size
	if itemParams.size == 1 then
		numText = ""
	end
    local richText2 = Lang.get("auciton_buy_item",
    {
        itemName = itemParams.name,
		itemColor = Colors.colorToNumber(itemParams.icon_color),
       -- outlineColor =  Colors.colorToNumber(itemParams.icon_color_outline ),
        itemNum = numText,
    })

    table.insert( richList, richText1)
    table.insert( richList, richText2)

	local function onCallBackFunc()
		onOkCallBack(addPrice,2)
	end
    local PopupAlert = require("app.ui.PopupAlert").new(Lang.get("common_title_notice"),"",onCallBackFunc)
    PopupAlert:addRichTextList(richList)
    PopupAlert:openWithAction()
end

function AuctionView:_showBuyDlg3(itemAward,addPrice, onOkCallBack,totalPrice)
  	local itemParams = TypeConvertHelper.convert(itemAward.type, itemAward.value, itemAward.size)
    if itemParams == nil then
        return
    end


	local richText1 = {}

	--差价描述内容修改
	if totalPrice and totalPrice > addPrice then
		richText1 = Lang.get("auction_add_price4",
		{
			resIcon = Path.getResourceMiniIcon(1),
			resNum =  addPrice,
		})
	else
		richText1 = Lang.get("auction_add_price3",
		{
			resIcon = Path.getResourceMiniIcon(1),
			resNum =  addPrice,
		})
	end
    local richList = {}


	local numText = "x"..itemParams.size
	if itemParams.size == 1 then
		numText = ""
	end
    local richText2 = Lang.get("auciton_buy_item",
    {
        itemName = itemParams.name,
		itemColor = Colors.colorToNumber(itemParams.icon_color),
        --outlineColor =  Colors.colorToNumber(itemParams.icon_color_outline ),
        itemNum = numText,
    })

    table.insert( richList, richText1)
    table.insert( richList, richText2)
	local function onCallBackFunc()
		onOkCallBack(addPrice,3)
	end
    local PopupAlert = require("app.ui.PopupAlert").new(Lang.get("common_title_notice"),"",onCallBackFunc)
    PopupAlert:addRichTextList(richList)
    PopupAlert:openWithAction()
end


--拍卖信息
function AuctionView:_onEventAuctionInfo(id, message)

	self:_updateListView(self._selectTabIndex)
end

--拍卖购买事件
function AuctionView:_onEventAuctionItem(id, message)
	if(message == nil)then return end

    self:_updateListView(self._selectTabIndex)
	if message.auction_type == AuctionConst.AC_TYPE_GUILD then
		G_Prompt:showTip(Lang.get("auction_add_price_ok"))
	elseif message.auction_type == AuctionConst.AC_TYPE_WORLD then
		G_Prompt:showTip(Lang.get("auction_once_buy_ok"))
	elseif message.auction_type == AuctionConst.AC_TYPE_ARENA then
		G_Prompt:showTip(Lang.get("auction_once_buy_ok"))
	elseif message.auction_type == AuctionConst.AC_TYPE_TRADE then
		G_Prompt:showTip(Lang.get("auction_once_buy_ok"))
	elseif message.auction_type == AuctionConst.AC_TYPE_PERSONAL_ARENA then
		G_Prompt:showTip(Lang.get("auction_once_buy_ok"))
	end
end

function AuctionView:_onEventAuctionUpdateItem( id, message)
	-- body
	if(message == nil)then return end

    self:_updateListView(self._selectTabIndex)
end
--拍卖纪录
function AuctionView:_onEventAuctionLog(id, message)
	if(message == nil)then return end
	--dump(message)

	if self._popupAuctionLog then
		return
	end


	local tabType = self:getTabType(self._selectTabIndex)

	local popupDlg =  PopupAuctionLog.new(Lang.get("auction_log_title"..tabType))
	self._popupAuctionLog = popupDlg
	self._popupAuctionLogSignal = self._popupAuctionLog.signal:add(handler(self, self._onPopupAuctionLogClose))

	local logList = rawget(message, "logs") or {}
	local showList = {}

	for i, log in ipairs(logList) do
		if log.main_type == tabType then
			table.insert( showList, log )
		end
	end

	table.sort(showList, function(log1, log2)
							return log1.deal_time > log2.deal_time
						 end)

	popupDlg:updateUI(showList)
	popupDlg:openWithAction()
	popupDlg:setName("PopupAuctionLog")

end

--判定是否是主节点，并返回节点类型
function AuctionView:getTabType(tabIndex)
    local groupData = self._nodeTabRoot:getGroupDataByIndex(tabIndex)
	--dump(groupData)
	return groupData.type, groupData.cfgId,groupData.rootCfgId
end



--一键领取框关闭事件
function AuctionView:_onPopupAuctionLogClose(event)
    if event == "close" then
        self._popupAuctionLog = nil
        self._popupAuctionLogSignal:remove()
        self._popupAuctionLogSignal = nil
    end
end




-- 清空时间 拍卖结束的
function AuctionView:_registerScheduler()
	self:_deleteScheduler()
	self._schedulerId = scheduler.scheduleGlobal(function()
		local tabIndex = self._selectTabIndex or 1
		local auctionType,cfgId,rootId = self:getTabType(tabIndex)
		--dump(configId)
		local dataList = AuctionHelper.getConfigIdByIndex(rootId,cfgId)
		if self._dataList and dataList then
			if #self._dataList ~= #dataList then
				self:_updateListView(self._selectTabIndex)
			end
		end
	end, 1)
end

function AuctionView:_deleteScheduler()
	if self._schedulerId then
		scheduler.unscheduleGlobal(self._schedulerId)
		self._schedulerId = nil
	end
end

-- i18n pos lable
function AuctionView:_dealPosByI18n()
    if not Lang.checkLang(Lang.CN) then
        local size = self._textAuctionShare:getContentSize()
		local newPosX = size.width + 10
		self._commonRes:setPositionX(newPosX)
		self._textAuctionShare:setPositionX(-newPosX)

		local UIHelper  = require("yoka.utils.UIHelper")
		
		local panelTab = UIHelper.seekNodeByName(self._nodeTabRoot,"Panel_tab")
		local image1 = UIHelper.seekNodeByName(self._nodeTabRoot,"Panel_tab","Image_1")
		local textDesc = UIHelper.seekNodeByName(self._nodeTabRoot,"Panel_tab","Text_desc")
		local size = panelTab:getContentSize()
		image1:setPosition(size.width*0.5,20)
		textDesc:setPositionX(size.width*0.5+15)

		
		
	end
end

-- i18n pos lable
function AuctionView:_updateHelpPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		logWarn("_-----------------_")
		local UIHelper  = require("yoka.utils.UIHelper")
		local textTitle = UIHelper.seekNodeByName(self._commonFullScreen,"TextTitle")
		self._commonHelpBig:setAnchorPoint(cc.p(0.5,0.5))
		UIHelper.alignCenter(self._commonFullScreen,{textTitle,self._commonHelpBig},{5,0},{nil,32})
	end
end

return AuctionView
