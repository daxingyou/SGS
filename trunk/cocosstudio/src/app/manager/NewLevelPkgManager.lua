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
    self._showQueue = Queue.new()
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
    self._popupData = {}
end

function NewLevelPkgManager:reset( ... )
end

function NewLevelPkgManager:start()
    self:clear()
    self._signalWelfareLevelGiftInfo = G_SignalManager:add(SignalConst.EVENT_WELFARE_LEVEL_GIFT_INFO, 
        handler(self, self._onEventWelfareLevelGiftInfo))    

    self._signalNewLevelPkgOpenNotice = G_SignalManager:add(SignalConst.EVENT_NEW_LEVEL_PKG_OPEN_NOTICE, 
        handler(self, self._onEventNewLevelPkgOpenNotice))   
end

function NewLevelPkgManager:_onEventWelfareLevelGiftInfo(event,newAddUnitList)    
    print("NewLevelPkgManager _onEventWelfareLevelGiftInfo")
    --dump(newAddUnitList)
    crashPrint("[Level Gift]  NewLevelPkgManager onEventWelfareLevelGiftInfo "..tostring(#newAddUnitList))
    crashPrint("[Level Gift]  NewLevelPkgManager onEventWelfareLevelGiftInfo start "..tostring(#table.keys(self._popupData)))
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
    crashPrint("[Level Gift]  NewLevelPkgManager onEventWelfareLevelGiftInfo end "..tostring(#table.keys(self._popupData)))
end

function NewLevelPkgManager:_onEventNewLevelPkgOpenNotice(event,condition,callback)
    if G_TutorialManager:isDoingStep() then
        return
    end
    crashPrint("[Level Gift]  NewLevelPkgManager onEventNewLevelPkgOpenNotice pop num "..tostring(#table.keys(self._popupData)))
    local curTime = G_ServerTime:getTime()
    local showList = {}
    local num = 0
    local num1 = 0
    for k,v in pairs(self._popupData) do
        print("NewLevelPkgManager _onEventNewLevelPkgOpenNotice ss"..v.condition )
        if (v.condition == condition or condition == nil) then
            num = num + 1
            self._popupData[v.condition.."_"..v.conditionValue] = nil
            if v.endTime > curTime then
                num1 = num1 + 1
                table.insert(showList, v)
            end
        end
    end

    
    table.sort(showList, function(a, b)
        if a.endTime ~= b.endTime then
            return a.endTime < b.endTime
        elseif a.condition ~= b.condition then
            return a.condition < b.condition
        else
            return a.conditionValue < b.conditionValue
        end
    end)	

    crashPrint("[Level Gift]  NewLevelPkgManager onEventNewLevelPkgOpenNotice num "..tostring(num).." "..tostring(num1))
    --print(tostring(condition).."NewLevelPkgManager _onEventNewLevelPkgOpenNotice"..#showList)

    crashPrint("[Level Gift] NewLevelPkgManager "..tostring(condition).." onEventNewLevelPkgOpenNotice show num "..#showList)

    if #showList > 0 then
        showList[#showList].callback  = callback

        crashPrint("[Level Gift] NewLevelPkgManager "..tostring(condition).." onEventNewLevelPkgOpenNotice queue start ".. tostring(self._showQueue:size()))

        for k,v in ipairs(showList) do
            self._showQueue:push(v)
        end	
        crashPrint("[Level Gift] NewLevelPkgManager "..tostring(condition).." onEventNewLevelPkgOpenNotice queue end ".. tostring(self._showQueue:size()))

        self:_tryShowUI()
    elseif callback then
        callback()
    end
    crashPrint("[Level Gift] NewLevelPkgManager "..tostring(condition).." onEventNewLevelPkgOpenNotice enddddd ")
end

function NewLevelPkgManager:_onPopupClose()
    self._currUI = nil
    self:_tryShowUI()
end

function NewLevelPkgManager:_tryShowUI()
    if self._currUI == nil then
        self._currUI = self._showQueue:pop()
        if self._currUI then
            crashPrint("[Level Gift] NewLevelPkgManager "..tostring(condition).." onEventNewLevelPkgOpenNotice show UI tryShowUI ok ")        
            G_SceneManager:showDialog("app.scene.view.newLevelPkg.PopupLevelPkg", nil, nil,
                self._currUI.condition,self._currUI.conditionValue,function()
                    if self._currUI.callback then
                        self._currUI.callback()
                    end
                    self:_onPopupClose()

                end)
            return true
        else
            crashPrint("[Level Gift] NewLevelPkgManager "..tostring(condition).." onEventNewLevelPkgOpenNotice show UI tryShowUI not ui ")        
        end
    else
        crashPrint("[Level Gift] NewLevelPkgManager "..tostring(condition).." onEventNewLevelPkgOpenNotice show UI tryShowUI is showing ")
    end
end

function NewLevelPkgManager:hasPop(condition)
    local curTime = G_ServerTime:getTime()
    local showList = {}
    local num = 0
    local num1 = 0
    local num2 = 0
    for k,v in pairs(self._popupData) do
        num = num + 1
        if (v.condition == condition or condition == nil) then
            num1 = num1 + 1
           --self._popupData[v.condition.."_"..v.conditionValue] = nil
            if v.endTime > curTime then
                num2 = num2 + 1
                table.insert(showList, v)
            end
        end
    end
    crashPrint("[Level Gift] hasPop "..tostring(num).." "..tostring(num1).." "..tostring(num2))
    return #showList > 0
end

return NewLevelPkgManager
