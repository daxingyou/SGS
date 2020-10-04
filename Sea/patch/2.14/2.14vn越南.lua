-- iphoneX公告清除缓存
local NativeAgent = require("app.agent.NativeAgent")
local name = NativeAgent.callStaticFunction("getDeviceModel", nil, "string")
if name == "iPhone10,3" or name == "iPhone10,6" then
    local PopupNotice = require("app.ui.PopupNotice")
    PopupNotice.onShowFinish = function(self)
        local discSize = self._webLayer:getContentSize()
        if ccexp.WebView then
            self._webView = ccexp.WebView:create()
            self._webView:setPosition(cc.p(discSize.width / 2, discSize.height / 2))
            self._webView:setContentSize(discSize.width, discSize.height)
            self._webView:loadURL(self._url, true)
            self._webView:setScalesPageToFit(false)
            self._webView:setBounces(false)

            self._webLayer:addChild(self._webView)
        end
    end
end


xpcall(function ()
    local language = require("app.i18n.vn.LangTemplate")
    language["HELP_GUILD_WAGE"] = {{["list"]={"Mỗi thành viên khi tham gia các hoạt động Quân Đoàn sẽ nhận được Năng Động Quân Đoàn.","Nếu có ít hơn 27 thành viên, đồng thời liên tục 3 ngày Năng Động Quân Đoàn bằng 0, Quân Đoàn sẽ tự động giải tán."},["title"]="Năng Động Quân Đoàn: "},{["list"]={"Quỹ Quân Đoàn sẽ được tích lũy theo mức năng động mỗi ngày.  ","Quỹ được tích lũy theo số ngày năng động của mỗi thành viên Quân Đoàn.","4:00 sáng T2 hàng tuần sẽ phát thưởng quỹ quân đoàn tuần trước."},["title"]="Quỹ Quân Đoàn: "}}
 end,function( ... )
 end)

xpcall(function ()
    local function_level_1 = require("app.i18n.vn.config.function_level_1")
    function_level_1._data[246] = {639,"Hè Mát\nMẻ","2","30,0","","",}
    local function_level = require("app.config.function_level")
    function_level.set(639,"icon","btn_main_enter_summer")
end,function( ... )
end)


xpcall(function ()
    local AchievementInfo = require("app.config.achievement")
    local AchievementData = require("app.data.AchievementData")
    local ACHI_CONFIG_PREV = "achi_config_"
    local ACHI_TYPE_PREV = "achi_type_"

    --根据限制等级遍历AchievementInfo表 缓存起来 提高性能
    AchievementData._getAchievementConfigData = function(self,tabIndex)
    tabIndex = tabIndex or 1
    if type(self._achiCfgData[tabIndex]) == "table" and table.nums(self._achiCfgData[tabIndex]) > 0 then
       
        return self._achiCfgData[tabIndex]
    end

    self._achiCfgData[tabIndex] = {}

    local function procCfgData(tabIndex, record)
        if tabIndex == 1 then -- 目标
            --获取对应模块并满足等级条件的成就记录
            local FunctionLevelInfo = require("app.config.function_level")
            local funcInfo = FunctionLevelInfo.get(record.level)
            if funcInfo and funcInfo.level <= G_UserData:getBase():getLevel() then
                self._achiCfgData[tabIndex][ACHI_CONFIG_PREV..record.id] = record
            end
        end
        
        if tabIndex == 2 then -- 趣味
            self._achiCfgData[tabIndex][ACHI_CONFIG_PREV..record.id] = record
        end

         if tabIndex == AchievementData.FIRST_MEET_TYPE then -- 金将初见
            self._achiCfgData[tabIndex][ACHI_CONFIG_PREV..record.id] = record
        end
    end

    for loopi = 1, AchievementInfo.length() do 
        local record = AchievementInfo.indexOf(loopi)
        --屏蔽第四批金将
        if Lang.checkLang(Lang.VN)  and (record.id == 501004 or record.id == 502004 or record.id == 503004 or record.id == 504004) then
        else
        if record.tab == tabIndex then
            procCfgData(tabIndex, record)
        end
        end
    end

    return self._achiCfgData[tabIndex]
end

end,function( ... )
end)

xpcall(function ()
    local VipRechargePageView = require("app.scene.view.vip.VipRechargePageView")
    local VipRechargeJadePageView = require("app.scene.view.vip.VipRechargeJadePageView")
    local VipRechargeView = require("app.scene.view.vip.VipRechargeView")
    local DataConst = require("app.const.DataConst")
    VipRechargeView.onCreate = function(self)
        local template = nil
	    local jadeTipShow = false
	    if self._itemType == DataConst.RES_JADE2 then
		    template = VipRechargeJadePageView
		    jadeTipShow = true
	    else
		    template = VipRechargePageView
		    jadeTipShow = false
	    end
	    self._listItemSource:setTemplate(template)
	    self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	    self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))
	    self._textJadeTip:setVisible(jadeTipShow)
	    -- 越南处理
	    if Lang.checkLang(Lang.VN) then
            self._textJadeTip:setVisible(false)
	    end
    end
end,function( ... )
end)

xpcall(function ()
    local LimitCostConst = require("app.const.LimitCostConst")
    local PetTrainHelper = require("app.scene.view.petTrain.PetTrainHelper")
    PetTrainHelper.isPromptPetLimit = function(petUnit)
        if not PetTrainHelper.canEnterLimit(petUnit) then
            return false
        end
        if (petUnit:getStar() < PetTrainHelper.getCanLimitMinStar()) then
            return false
        end
        local PetConst = require("app.const.PetConst")
        if petUnit:getQuality() ~= PetConst.QUALITY_ORANGE then
            return false
        end
        local isAllFull = true
        for key = LimitCostConst.LIMIT_COST_KEY_1, LimitCostConst.LIMIT_COST_KEY_4 do
            local isOk, isFull = PetTrainHelper.isPromptPetLimitWithCostKey(petUnit, key)
            isAllFull = isAllFull and isFull
            if isOk then
                return true
            end
        end
        if isAllFull then
            local info = PetTrainHelper.getLimitCostInfo(petUnit)
            local isOk = require("app.utils.LogicCheckHelper").enoughMoney(info.coin_size)
            if isOk then
                return true
            end
        end
        return false
    end
end,function( ... )
end)


xpcall(function ()
         
    local Instrument = require("app.config.instrument")
    Instrument.set(151, "change_type",0)
    Instrument.set(251, "change_type",0)
    Instrument.set(351, "change_type",0)
    Instrument.set(451, "change_type",0)
end,function( ... )
end)


xpcall(function ()
    local des1 = "Gây 235% sát thương vật lý cho 2 mục tiêu tiêu nộ thấp nhất, khiến mục tiêu bị Áp Chế 1 lượt. Võ tướng khác không thể hồi nộ cho mục tiêu bị Áp Chế"
    local hero_skill_active = require("app.config.hero_skill_active")
    hero_skill_active.set(4510020, "description",des1)
    hero_skill_active.set(4510021, "description",des1)
    hero_skill_active.set(4510120, "description",des1)
    hero_skill_active.set(4510121, "description",des1)
    hero_skill_active.set(4510320, "description",des1)
    hero_skill_active.set(4510321, "description",des1)
    hero_skill_active.set(4510520, "description",des1)
    hero_skill_active.set(4510521, "description",des1)
    


    local des1 = "Gây 223% sát thương vật lý cho 2 mục tiêu tiêu nộ cao nhất, 48% khiến mục tiêu bị Suy Yếu 1 lượt. Mỗi ra trận 1 võ tướng Ngụy, xác suất tăng thêm 8%. (Suy Yếu không thể giải trừ, nếu như lượt này tướng địch đủ nộ sử dụng kỹ năng thì Suy Yếu sẽ làm cho tướng địch không thể hành động trong lượt. Nếu tướng địch không đủ nộ để sử dụng kỹ năng thì vẫn đánh thường lượt này)"
    local hero_skill_active = require("app.config.hero_skill_active")
    hero_skill_active.set(4510020, "description",des1)
    hero_skill_active.set(4510021, "description",des1)
    hero_skill_active.set(4510120, "description",des1)
    hero_skill_active.set(4510121, "description",des1)
    hero_skill_active.set(4510320, "description",des1)
    hero_skill_active.set(4510321, "description",des1)
    hero_skill_active.set(4510520, "description",des1)
    hero_skill_active.set(4510521, "description",des1)




end,function( ... )
end)
