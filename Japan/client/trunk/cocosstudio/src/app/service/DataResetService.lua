local BaseService = require("app.service.BaseService")
local TimeConst = require("app.const.TimeConst")
local DataResetService = class("DataResetService",BaseService)

function DataResetService:ctor()
    DataResetService.super.ctor(self)
    self:start()

    self._lastNoticeTimeList = {}
end

function DataResetService:tick()
    --场景检测
    local runningSceneName = display.getRunningScene():getName() 
    if  runningSceneName == "fight" or runningSceneName == "login" then
        return
    end
    local loginTime = G_UserData:getBase():getOnline_time_update_time()
    if loginTime <= 0 then
        return 
    end
    local time = G_ServerTime:getTime()
    for k,v in ipairs(TimeConst.RESET_TIME_LIST) do
        self._lastNoticeTimeList[k] = self._lastNoticeTimeList[k] or loginTime
        local expired = G_ServerTime:isTimeExpired(self._lastNoticeTimeList[k] or 0,v)
        if expired then
            self._lastNoticeTimeList[k] = time
            G_SignalManager:dispatch(SignalConst.EVENT_COMMON_ZERO_NOTICE,v)
            if v == TimeConst.RESET_TIME  then
                 print("------------------------------------------DataResetService:xxx") 
                self:_checkResetI18n(require("app.i18n.utils.DataResetFunc"))
            elseif  v == TimeConst.RESET_TIME_24 then
                 print("------------------------------------------DataResetService:xxx") 
				 self:_checkResetI18n(require("app.i18n.utils.DataResetFunc24"))
            end
            print("------------------------------------------DataResetService:EVENT_COMMON_ZERO_NOTICE")
        end
    end
end

function DataResetService:_checkResetI18n(resetFunc)
    if not Lang.checkLang(Lang.CN) then
        for key, value in pairs(resetFunc) do
            if string.find(key,"FUNC_") and type(value) == "function" then
                --判断是否开启功能
                local LogicCheckHelper = require("app.utils.LogicCheckHelper")
                local FunctionConst = require("app.const.FunctionConst")
				--i18n ja 
                local funcitonId = FunctionConst.getFuncId(string.sub(key,2,-1))
                if not funcitonId or LogicCheckHelper.funcIsOpened(funcitonId) then
                    local callFunc = value()
                    callFunc()
                    print("------------------------------------------DataResetService reset"..key)
                end
               
            end
        end
    end
end



return DataResetService

