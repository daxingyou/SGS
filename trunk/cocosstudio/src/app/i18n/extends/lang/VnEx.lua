local function matchPlatform()
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    -- if targetPlatform == cc.PLATFORM_OS_IPHONE or targetPlatform == cc.PLATFORM_OS_IPAD then
    return targetPlatform == PLATFORM_OS_ANDROID
    --return targetPlatform == cc.PLATFORM_OS_IPHONE
end    
local NativeAgent = require("app.agent.NativeAgent")
local name = NativeAgent.callStaticFunction("getDeviceModel", nil, "string")
-- if name ~= nil and name ~= "" and true then
if name ~= nil and name ~= "" and matchPlatform() then
    local ChatSetting = require("app.data.ChatSetting")
    local ChatConst = require("app.const.ChatConst")
    local function matchLowerAndroid(name)
        local matchTable = {}
        matchTable[string.upper("MediaPad T1 8.0")] = 1
        matchTable[string.upper("NokiaX2DS")] = 1
        matchTable[string.upper("N5111")] = 1
        matchTable[string.upper("ASUS_Z008D")] = 1
        matchTable[string.upper("ASUS_Z00AD")] = 1
        matchTable[string.upper("SM-G900F")] = 1
        matchTable[string.upper("SM-G900P")] = 1
        matchTable[string.upper("SM-N900")] = 1
        matchTable[string.upper("SM-N900L")] = 1
        matchTable[string.upper("SM-N900S")] = 1
        matchTable[string.upper("SM-G900V")] = 1
        matchTable[string.upper("B1-723")] = 1
        matchTable[string.upper("itel it1508 Plus")] = 1
        matchTable[string.upper("itel it1703")] = 1
        matchTable[string.upper("itel it1703")] = 1
        matchTable[string.upper("Lenovo TB3-710I")] = 1
        matchTable[string.upper("LG-F500S")] = 1
        matchTable[string.upper("m3 note")] = 1
        matchTable[string.upper("Tab 8i")] = 1
        matchTable[string.upper("mobiistar PRIME X Grand")] = 1
        matchTable[string.upper("1201")] = 1
        matchTable[string.upper("A1601")] = 1
        matchTable[string.upper("A33w")] = 1
        matchTable[string.upper("CPH1605")] = 1
        matchTable[string.upper("X9009")] = 1
        matchTable[string.upper("Philips S337")] = 1
        matchTable[string.upper("E5333")] = 1
        matchTable[string.upper("vivo Y31")] = 1
        matchTable[string.upper("SO-03G")] = 1
        matchTable[string.upper("Dream_8")] = 1
        matchTable[string.upper("FTJ161E-VN")] = 1
        matchTable[string.upper("831C")] = 1
        matchTable[string.upper("HTC Desire 10 pro")] = 1
        matchTable[string.upper("HTC Desire 816 dual sim")] = 1
        matchTable[string.upper("CAM-L21")] = 1
        matchTable[string.upper("HUAWEI NMO-L31")] = 1
        matchTable[string.upper("MYA-L22")] = 1
        matchTable[string.upper("itel S31")] = 1
        matchTable[string.upper("J7")] = 1
        matchTable[string.upper("Lenovo A7000-a")] = 1
        matchTable[string.upper("Lenovo A7010a48")] = 1
        matchTable[string.upper("Lenovo PB2-650M")] = 1
        matchTable[string.upper("LG-F600L")] = 1
        matchTable[string.upper("Masstel N6")] = 1
        matchTable[string.upper("nova_i7")] = 1
        matchTable[string.upper("mobiistar PRIME X1")] = 1
        matchTable[string.upper("A1601")] = 1
        matchTable[string.upper("CPH1609")] = 1
        matchTable[string.upper("K10000")] = 1
        matchTable[string.upper("E5663")] = 1
        matchTable[string.upper("vivo 1601")] = 1
        matchTable[string.upper("ROBBY")] = 1
        matchTable[string.upper("ASUS_X008D")] = 1
        matchTable[string.upper("AGS-L09")] = 1
        matchTable[string.upper("BLL-L22")] = 1
        matchTable[string.upper("BTV-DL09")] = 1
        matchTable[string.upper("HUAWEI NMO-L31")] = 1
        matchTable[string.upper("KOB-L09")] = 1
        matchTable[string.upper("TRT-L21A")] = 1
        matchTable[string.upper("WAS-LX2J")] = 1
        matchTable[string.upper("itel P51")] = 1
        matchTable[string.upper("Lenovo P2a42")] = 1
        matchTable[string.upper("LG-F800L")] = 1
        matchTable[string.upper("LG-H910")] = 1
        matchTable[string.upper("LG-LS993")] = 1
        matchTable[string.upper("LG-M430")] = 1
        matchTable[string.upper("LGM-X800L")] = 1
        matchTable[string.upper("15 Plus")] = 1
        matchTable[string.upper("Mobell S50")] = 1
        matchTable[string.upper("mobiistar Zumbo S2")] = 1
        matchTable[string.upper("mobiistar ZUMBO S2 Dual")] = 1
        matchTable[string.upper("mobiistar_LAI_Z2")] = 1
        matchTable[string.upper("PRIME X MAX 2018")] = 1
        matchTable[string.upper("Zumbo S 2017")] = 1
        matchTable[string.upper("Zumbo_S_2017")] = 1
        matchTable[string.upper("Moto C")] = 1
        matchTable[string.upper("Moto C Plus")] = 1
        matchTable[string.upper("SAMSUNG-SM-G928A")] = 1
        matchTable[string.upper("SM-A310F")] = 1
        matchTable[string.upper("SM-A510F")] = 1
        matchTable[string.upper("SM-A710F")] = 1
        matchTable[string.upper("SM-G610F")] = 1
        matchTable[string.upper("SM-G920P")] = 1
        matchTable[string.upper("SM-G925F")] = 1
        matchTable[string.upper("SM-G928C")] = 1
        matchTable[string.upper("SM-G930U")] = 1
        matchTable[string.upper("SM-G935F")] = 1
        matchTable[string.upper("SM-G950F")] = 1
        matchTable[string.upper("SM-G955F")] = 1
        matchTable[string.upper("SM-J710F")] = 1
        matchTable[string.upper("SM-J730G")] = 1
        matchTable[string.upper("SM-N920C")] = 1
        matchTable[string.upper("SM-N920L")] = 1
        matchTable[string.upper("SM-N920P")] = 1
        matchTable[string.upper("SM-N920S")] = 1
        matchTable[string.upper("SM-N920W8")] = 1
        matchTable[string.upper("SM-N935F")] = 1
        matchTable[string.upper("F3116")] = 1
        matchTable[string.upper("G3312")] = 1
        matchTable[string.upper("SM-N920V")] = 1
        matchTable[string.upper("JERRY2")] = 1
        matchTable[string.upper("KENNY")] = 1
        matchTable[string.upper("Sunny2 Plus")] = 1
        matchTable[string.upper("U PULSE")] = 1
        matchTable[string.upper("Redmi Note 4")] = 1
        --测试的
        -- matchTable[string.upper("Nexus 5X")] = 1
        -- matchTable[string.upper("iPhone10,2")] = 1
        -- matchTable[string.upper("SM-G9350")] = 1
    
        if matchTable[string.upper(name)] == 1 then
            return true
        end
        return false
    end
    local isLowerAndroid = matchLowerAndroid(name)
    -- local isLowerAndroid = true
    if isLowerAndroid then
        ChatSetting.getCheckBoxValue = function(self,id)
            local SETTING_CHECK_BOX_DEFAULT = {1,0,1,1,1} --复选框设置默认值，1是选中 世界频道默认不选中
            local checkboxData = self:_getSettingValue("checkbox") 
            local checkValue = nil
            -- if  checkboxData then
            --     checkValue = checkboxData[id] --checkboxData[id] or   ChatConst.SETTING_CHECK_BOX_DEFAULT[id]
            -- end
            if not checkValue then
                if id == ChatConst.SETTING_KEY_AUTO_VOICE_WORLD  or 
                    id == ChatConst.SETTING_KEY_AUTO_VOICE_GANG  then
                    checkValue = G_ConfigManager:isVoiceAutoPay() and 1 or 0
                    checkValue = SETTING_CHECK_BOX_DEFAULT[id]
                else
                    checkValue = ChatConst.SETTING_CHECK_BOX_DEFAULT[id]	
                end

                --i18n
                if G_ConfigManager:isAppstoreFeatureOpen() and G_NativeAgent:getNativeType() == "ios" then
                    checkValue = 0
                end
            end
            return checkValue
        end	
    end
end



local SeasonSportView = require("app.scene.view.seasonSport.SeasonSportView")
local SeasonSportConst = require("app.const.SeasonSportConst")
SeasonSportView._updateSeasonView = function(self)
    local bCancel = G_UserData:getSeasonSport():getCancelMatch()
    self:_initWaitingView(not bCancel)
    self:_initNewerView()

    self._suspendTime = G_UserData:getSeasonSport():getSuspendTime()
    self._seasonEndTime = G_UserData:getSeasonSport():getSeasonEndTime()

    local saesonLastDays = math.floor(G_ServerTime:getLeftSeconds(self._seasonEndTime) / SeasonSportConst.SEASON_COUNTDOWN)
    local curSeason = G_UserData:getSeasonSport():getCurSeason()
    if Lang.checkLang(Lang.VN) and curSeason > 17 then 
        curSeason = curSeason - 17
    end
    local dateStr = (Lang.get("season_nexttime", {num = curSeason}) ..saesonLastDays)
    self._textSeasonTime:setString(dateStr)
    self:_updateRedPoint()
    self:_updateReport()
    self._curStar = G_UserData:getSeasonSport():getCurSeason_Star()
    self:_playHuiZhangSpine()
end

if name ~= nil and name ~= "" then
    local function matchLowerDevice(name)
        local matchTable = {}
        matchTable[string.upper("iPhone5,1")] = 1   --iphone5
        matchTable[string.upper("iPhone5,2")] = 1   --iphone5
        matchTable[string.upper("iPhone6,1")] = 1   --iphone5s
        matchTable[string.upper("iPhone6,2")] = 1   --iphone5s
        matchTable[string.upper("iPhone7,1")] = 1   --iphone6p
        matchTable[string.upper("iPhone7,2")] = 1   --iphone6
        matchTable[string.upper("iPad4,1")] = 1     --iPad Air
        matchTable[string.upper("iPad4,2")] = 1     --iPad Air
        matchTable[string.upper("SAMSUNG Galaxy J2 Prime")] = 1
        matchTable[string.upper("SAMSUNG J3")] = 1
        matchTable[string.upper("SAMSUNG J7")] = 1
        if matchTable[string.upper(name)] == 1 then
            return true
        end
        return false
    end
    Lang.isLowDevice = matchLowerDevice(name)
    print("device name = ",name,"Lang.isLowDevice=",Lang.isLowDevice)
end
print("------VnEX.lua execute------")