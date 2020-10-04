local CSHelper = require("yoka.utils.CSHelper")
local UIHelper  = require("yoka.utils.UIHelper")
local DailyGiftHelper = {}

function DailyGiftHelper.createMenu(funBtnList,menuLayer)
    if not Lang.checkLang(Lang.KR) then
    	return
    end
    local menuData = DailyGiftHelper:_createData()

    local iconDataFunc = menuLayer._menuDailyGiftData
    if iconDataFunc ~= nil and iconDataFunc.node ~= nil then
        if menuData.isShow then
            iconDataFunc.node:setVisible(true)
            iconDataFunc.customData = menuData.customData
            iconDataFunc.cfg = menuData.cfg
            table.insert(funBtnList,iconDataFunc)
        else
            iconDataFunc.node:setVisible(false)
        end
        return
    end
    if menuData.isShow == false then
        return
    end

    local node = CSHelper.loadResourceNode(Path.getCSB("CommonMainMenu", "common"))

    menuLayer._panelDesign:addChild(node)
    node:showRedPoint(false)

    menuData.node = node
    menuData.node:setVisible(true)
    menuLayer._menuDailyGiftData = menuData
    local button = node:getButton()
    button:addClickEventListenerEx(function()
        DailyGiftHelper._showReward(menuLayer._menuDailyGiftData.cfg)
    end)
    
    local effectA = ccui.Helper:seekNodeByName(node,"Node_a")
    effectA:setPosition(0,4)
    local effectB = ccui.Helper:seekNodeByName(node,"Node_b")
    effectB:setPosition(0,4)
    effectA:removeAllChildren()
    G_EffectGfxMgr:createPlayGfx(effectA,"effect_youxiangtishi")
    effectB:removeAllChildren()
    G_EffectGfxMgr:createPlayGfx(effectB,"effect_youxiangtishi_b")

    UIHelper.showMenuName(node,80001)
    
    table.insert(funBtnList,menuData)

end

function DailyGiftHelper._createData()
    local visible = false
    local endTime
    local startTime
    local giftData
    local dailyGift = require("app.config.daily_gift")

    for i = 1, dailyGift.length() do
        local cfg = dailyGift.indexOf(i)
        local nowDay = G_UserData:getBase():getOpenServerDayNum()
        if cfg.day_begin <= nowDay and cfg.day_end >= nowDay then
            local hasGot = false
            local giftInfo = G_UserData:getBase():getDailyGiftInfo()
            for i,v in ipairs(giftInfo) do
                if v == cfg.id then
                    hasGot = true
                    break
                end
            end
            if not hasGot then
                local object = G_ServerTime:getDateObject()
                local curHour = object.hour
                local curTime = G_ServerTime:getTime()
                local curZeroTime = curTime - curHour*3600 - object.min*60 - object.sec
                if curHour < cfg.hour_begin then
                    local tempTime = curZeroTime + cfg.hour_begin*3600
                    if startTime == nil or tempTime < startTime then
                        startTime = tempTime
                        giftData = cfg
                    end
                elseif curHour >= cfg.hour_end then
                    -- startTime = curZeroTime + (cfg.hour_begin + 24)*3600
                elseif curHour >= cfg.hour_begin and curHour < cfg.hour_end then
                    visible = true
                    endTime = curZeroTime + cfg.hour_end*3600
                    giftData = cfg
                    startTime = nil
                    break
                end
            end
        end
    end

    local menuData = {}
    menuData.isShow = visible
    menuData.cfg = giftData
    local customData = {}
    customData.icon = Path.getCommonIcon("main","btn_main_enter_children2")
    customData.callFunc = function(menuBtn, menuData)
        menuBtn:removeCustomLabel()
        if endTime then
            menuBtn:openCountDown(endTime, function(menuBtnImp)
                G_SignalManager:dispatch(SignalConst.EVENT_MAIN_CITY_CHECK_BTNS)
            end)
        end
    end
    menuData.customData = customData

    if startTime then
        G_ServiceManager:registerOneAlarmClock("MAIN_MENU_DAILY_GIFT", startTime, function()
            G_SignalManager:dispatch(SignalConst.EVENT_MAIN_CITY_CHECK_BTNS)
        end)
    end

    return menuData
end

function DailyGiftHelper._showReward(cfg)
    local popup = require("app.i18n.extends.ui.PopupDailyGift").new(cfg)
    popup:openWithAction()

end


return DailyGiftHelper