local NewLevelPkgManager = class("NewLevelPkgManager")
local Queue = require("app.utils.Queue")

local IconData = {
	condition = 0,
	conditionValue = 0, 						
    functionLevel = 0,	
    endTime = 0,	
    callback = nil												
}

function NewLevelPkgManager:ctor()
    self._popupData = {}
    self._showQueue = Queue.new(10)
    self._currUI= nil
end

function NewLevelPkgManager:clear()
	if self._signalWelfareLevelGiftInfo then
		self._signalWelfareLevelGiftInfo:remove()
		self._signalWelfareLevelGiftInfo = nil
    end
    if self._signalNewLevelPkgOpenNotice then
        self._signalNewLevelPkgOpenNotice:remove()
        self._signalNewLevelPkgOpenNotice = nil
    end
end

function NewLevelPkgManager:reset( ... )
end

function NewLevelPkgManager:start()
    self._signalWelfareLevelGiftInfo = G_SignalManager:add(SignalConst.EVENT_WELFARE_LEVEL_GIFT_INFO, 
        handler(self, self._onEventWelfareLevelGiftInfo))    

    self._signalNewLevelPkgOpenNotice = G_SignalManager:add(SignalConst.EVENT_NEW_LEVEL_PKG_OPEN_NOTICE, 
        handler(self, self._onEventNewLevelPkgOpenNotice))   
end

function NewLevelPkgManager:_onEventWelfareLevelGiftInfo(event,newAddUnitList)    
    print("NewLevelPkgManager _onEventWelfareLevelGiftInfo")
    dump(newAddUnitList)
    for k,v in ipairs(newAddUnitList) do
        local config = v:getConfig()
        if not self._popupData[config.condition.."_"..config.require_value] then
            local endTime = v:getStart_time() + v:getLimitTime()
            local data = clone(IconData)
            data.condition = config.condition
            data.conditionValue =  config.require_value
            data.functionLevel = config.fun_id
            data.endTime = endTime
            self._popupData[config.condition.."_"..config.require_value] = data
        end 
    end

end

function NewLevelPkgManager:_onEventNewLevelPkgOpenNotice(event,condition,callback)
    if G_TutorialManager:isDoingStep() then
        return
    end
   
    local curTime = G_ServerTime:getTime()
    local showList = {}
    for k,v in pairs(self._popupData) do
        print("NewLevelPkgManager _onEventNewLevelPkgOpenNotice ss"..v.condition )
        if (v.condition == condition or condition == nil) then
            self._popupData[v.condition.."_"..v.conditionValue] = nil
            if v.endTime > curTime then
                table.insert(showList, v)
            end
        end
    end
    table.sort(showList, function(a, b)
        if a.endTime ~= b.endTime then
            return a.endTime < b.endTime
        else
            return a.conditionValue < b.conditionValue
        end
    end)	
    print(tostring(condition).."NewLevelPkgManager _onEventNewLevelPkgOpenNotice"..#showList)
    if #showList > 0 then
        showList[#showList].callback  = callback
        for k,v in ipairs(showList) do
            self._showQueue:push(v)
        end	
        self:_tryShowUI()
    elseif callback then
        callback()
    end
end

function NewLevelPkgManager:_onPopupClose()
    self._currUI = nil
    self:_tryShowUI()
end

function NewLevelPkgManager:_tryShowUI()
    if self._currUI == nil then
        self._currUI = self._showQueue:pop()
        if self._currUI then
            G_SceneManager:showDialog("app.scene.view.newLevelPkg.PopupLevelPkg", nil, nil,
                self._currUI.condition,self._currUI.conditionValue,function()
                    if self._currUI.callback then
                        self._currUI.callback()
                    end
                    self:_onPopupClose()

                end)
            return true
        end
    end
end

function NewLevelPkgManager:hasPop(condition)
    local curTime = G_ServerTime:getTime()
    local showList = {}
    for k,v in pairs(self._popupData) do
        if (v.condition == condition or condition == nil) then
           --self._popupData[v.condition.."_"..v.conditionValue] = nil
            if v.endTime > curTime then
                table.insert(showList, v)
            end
        end
    end
    return #showList > 0
end

return NewLevelPkgManager
