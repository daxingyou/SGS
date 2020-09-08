
local ViewBase = require("app.ui.ViewBase")
local FunctionConst = require("app.const.FunctionConst")
local SchedulerHelper = require("app.utils.SchedulerHelper")
local BannerPageView = class("BannerPageView", ViewBase)

function BannerPageView:ctor(mainMenuLayer)
	self._mainMenuLayer = mainMenuLayer
	self._bannerDataList = {}
	local resource = {
		file = Path.getCSB("BannerPageView", "main"),
		binding = {

		}
	}

	BannerPageView.super.ctor(self, resource)
end

function BannerPageView:onCreate()
	self._pageView:setSwallowTouches(false)
	self._pageView:setScrollDuration(0.3)
    self._pageView:addTouchEventListener(handler(self,self._onPageTouch))
end

function BannerPageView:_onPageTouch(sender, state)
    if state == ccui.TouchEventType.began then
        if self._schedulePageHandler then
            SchedulerHelper.cancelSchedule(self._schedulePageHandler)
            self._schedulePageHandler = nil
        end
		return true
	elseif state == ccui.TouchEventType.moved then
		
	elseif state == ccui.TouchEventType.ended or state == ccui.TouchEventType.canceled then
		self:_autoTurnPage()
	end
end

function BannerPageView:_turnPage()
    local curPage = self._pageView:getCurrentPageIndex()
    if curPage == -1 then
        curPage = 0
    end
    local nextPage = curPage + 1
    if nextPage >= #self._bannerDataList then
        nextPage = 0
    end
    self._pageView:scrollToPage(nextPage)
    self._commonPageViewIndicator:setCurrentPageIndex(nextPage)
end

function BannerPageView:_autoTurnPage()
    if self._schedulePageHandler then
        SchedulerHelper.cancelSchedule(self._schedulePageHandler)
        self._schedulePageHandler = nil
    end
    local UserDataHelper = require("app.utils.UserDataHelper")
    local time = UserDataHelper.getParameter(51001)/1000
    self._schedulePageHandler = SchedulerHelper.newSchedule(handler(self, self._turnPage), time)
end

function BannerPageView:updateUI()
    self._bannerDataList = self:_getBannerList()
    self._pageView:removeAllPages()
	for i, v in ipairs(self._bannerDataList) do
        local item = ccui.Layout:create()
        local btn = ccui.Button:create()
        local funcInfo = require("app.config.function_level").get(v.funcId)
        btn:loadTextureNormal(Path.getMain2(funcInfo.banner))
        btn:addClickEventListenerEx(handler(self, self._onBannerClick))
	    btn:setSwallowTouches(false)
        item:addChild(btn)
        btn:setZoomScale(0)
        btn:setAnchorPoint(0,0)
        btn:setTag(i)
        if v.funcId ~= FunctionConst.FUNC_WELFARE then
            local startTime,endTime = self:_getBannerStartEndTime(v.funcId)
            if startTime and endTime then
                local startStr = G_ServerTime:getBannerTimeString(startTime)
                local endStr = G_ServerTime:getBannerTimeString(endTime)
                local timeText = string.format(Lang.get("main_banner_time"),startStr,endStr)
                local label1 = cc.Label:createWithTTF(timeText, Path.getCommonFont(), 16)
                label1:setColor(cc.c3b(255, 255, 255))
                label1:setPosition(95,24)
                label1:setAnchorPoint(0,0.5)
                label1:enableBold()
                btn:addChild(label1)
            end
        end
        self._pageView:insertPage(item, i - 1)
	end
    self._commonPageViewIndicator:refreshPageData(self._pageView,#self._bannerDataList,0,-10)
    self:_autoTurnPage()
    self._pageView:setCurrentPageIndex(0)
end

function BannerPageView:_onBannerClick(sender)
    local funcData = self._bannerDataList[sender:getTag()]
    local menuData = self._mainMenuLayer:_createMenuData(funcData)
    local funcSubIdStr = menuData.funcSubId and tostring(menuData.funcSubId) or ""
    local iconDataFunc = self._mainMenuLayer._menusMapData["k" .. funcData.funcId .. funcSubIdStr]

    local LogicCheckHelper = require("app.utils.LogicCheckHelper")
    local isOpened, errMsg = LogicCheckHelper.funcIsOpened(funcData.funcId)
    if isOpened == false then
        if errMsg then
            G_Prompt:showTip(errMsg)
        end
        return
    end


    if iconDataFunc ~= nil and iconDataFunc.node ~= nil then
        self._mainMenuLayer:_onButtonClick(iconDataFunc.node:getButton())
    end
end

function BannerPageView:_getBannerList()
    local bannerList = {}
    local checkBanner = function(funcData)
        local funcInfo = require("app.config.function_level").get(funcData.funcId)
        if funcInfo.banner_index ~= 0 then
            local menuData = self._mainMenuLayer:_createMenuData(funcData)
            if menuData.isShow then
                table.insert(bannerList,funcData)
            end
        end
	end
	local MainMenuLayer = require("app.scene.view.main.MainMenuLayer2")
    for i, v in ipairs(MainMenuLayer.RIGHT_TOP_ICON_A2) do
        checkBanner(v)
    end
    table.insert(bannerList,{funcId = FunctionConst.FUNC_WELFARE})
    -- checkBanner({funcId = FunctionConst.FUNC_WELFARE})
    table.sort(
        bannerList,
        function(item1, item2)
            local data1 = require("app.config.function_level").get(item1.funcId)
            local data2 = require("app.config.function_level").get(item2.funcId)
            return data1.banner_index < data2.banner_index
        end
    )
    return bannerList
end

function BannerPageView:_getBannerStartEndTime(funcId)
    local function getEquipTime()
        local data = G_UserData:getCustomActivity():getEquipActivity()
        if data then
            return data:getStart_time(),data:getEnd_time()
        end
    end
    local function getPetTime()
        local data = G_UserData:getCustomActivity():getPetActivity()
        if data then
            return data:getStart_time(),data:getEnd_time()
        end
    end
    local function getHorseTime()
        local data = G_UserData:getCustomActivity():getHorseConquerActivity()
        if data then
            return data:getStart_time(),data:getEnd_time()
        end
    end
    local function getAvatarTime()
        local data = G_UserData:getCustomActivity():getAvatarActivity()
        if data then
            return data:getStart_time(),data:getEnd_time()
        end
    end
    local function getWeekTime()
        local data = G_UserData:getDay7Activity()
        if data then
            local rewardTime = data:getActRewardEndTime()
            local startTime = rewardTime - 24*3600*(data:getReward_time()-data:getStart_time()+1)
            return startTime,rewardTime
        end
    end
    local function getGoldenTime()
        local data = G_UserData:getGachaGoldenHero()
        if data then
            return data:getStart_time(),data:getShow_time()
        end
    end
    local function getCarnivalTime()
        local data = G_UserData:getCarnivalActivity():getVisibleUnitData()
        if data then
            return data:getStart_time(),data:getAward_time()
        end
    end
    local function getCakeTime()
        local CakeActivityConst = require("app.const.CakeActivityConst")
        local startTime1 = G_UserData:getCakeActivity():getActivityStartTime() --本服阶段开始时间
        local endTime1 = startTime1 + CakeActivityConst.CAKE_LOCAL_TIME --本服阶段结束时间
        local startTime2 = endTime1 + CakeActivityConst.CAKE_TIME_GAP --全服阶段开始时间
        local endTime2 = startTime2 + CakeActivityConst.CAKE_CROSS_TIME --全服阶段结束时间
        local showEndTime = endTime2 + CakeActivityConst.CAKE_TIME_LEFT --整个活动结束显示的时间
        if startTime1 ~= 0 then
            return startTime1,showEndTime
        end
    end

    local checkFuncs = {
        [FunctionConst.FUNC_EQUIP_ACTIVITY] = getEquipTime,
        [FunctionConst.FUNC_PET_ACTIVITY] = getPetTime,
        [FunctionConst.FUNC_HORSE_CONQUER_ACTIVITY] = getHorseTime,
        [FunctionConst.FUNC_AVATAR_ACTIVITY] = getAvatarTime,
        [FunctionConst.FUNC_WEEK_ACTIVITY] = getWeekTime,
        [FunctionConst.FUNC_GACHA_GOLDENHERO] = getGoldenTime,
        [FunctionConst.FUNC_CARNIVAL_ACTIVITY] = getCarnivalTime,
        [FunctionConst.FUNC_CAKE_ACTIVITY] = getCakeTime,
        

    }
    local func = checkFuncs[funcId]
    if func then
        return func()
    end
end

function BannerPageView:onEnter()

end

function BannerPageView:onExit()
	if self._schedulePageHandler then
        SchedulerHelper.cancelSchedule(self._schedulePageHandler)
        self._schedulePageHandler = nil
    end
end


return BannerPageView