local PosterGirlManager = class("PosterGirlManager")

function PosterGirlManager:ctor()
    self._vipVoiceMap = {}
    self._stayTime = {}
    self._waitPlayVoiceList = {}
    self._tempSates = {}
    self._voiceStateData = nil
    self._lastPlayTime = nil
    self._lastPlayVoice = nil
    self._lastPlayAudioId = nil
end

function PosterGirlManager:clear()
	if self._signalPosterGirlVoiceUpdate then
		self._signalPosterGirlVoiceUpdate:remove()
		self._signalPosterGirlVoiceUpdate = nil
    end
    
    if self._signalFinishLogin then
        self._signalFinishLogin:remove()
        self._signalFinishLogin = nil
    end

    if self._signalPosterGirlVoiceClear then
		self._signalPosterGirlVoiceClear:remove()
		self._signalPosterGirlVoiceClear = nil
    end

    
    if self._voiceStateData then
        self._voiceStateData:clear()
        self._voiceStateData = nil
    end
    
    if self._request then
        self._request.signal:removeAll()
        self._request = nil
    end

    self:_closeUpdate()
end

function PosterGirlManager:reset( ... )
end


function PosterGirlManager:start()

    self._signalFinishLogin = G_SignalManager:add(SignalConst.EVENT_FINISH_LOGIN, 
        handler(self, self._onEventFinishLogin))    

    self._signalPosterGirlVoiceUpdate = G_SignalManager:add(SignalConst.EVENT_POSTER_GIRL_VOICE_UPDATE,
        handler(self, self._onEventPosterGirlVoiceUpdate))
    
    self._signalPosterGirlVoiceClear = G_SignalManager:add(SignalConst.EVENT_POSTER_GIRL_VOICE_CLEAR,
        handler(self, self._onEventPosterGirlVoiceClear))

        

    self:_initVipVoice()
    self:_initVoiceWhenStayVipView()
    self:_clearTempState()
    self:_startUpdate()

    local KeyValueUrlRequest = require("app.manager.KeyValueUrlRequest")
    self._request = KeyValueUrlRequest.new()  
    self._request.signal:registerListenerWithPriority(handler(self,self._onGetValueHttpCallBack),false,1)

   

    self._voiceStateData = require("app.data.PosterGirlVoiceStateData").new()
    self._waitPlayVoiceList = {}
    self._lastPlayTime = nil
    self._lastPlayVoice = nil
end

function PosterGirlManager:_startUpdate()
    local SchedulerHelper = require("app.utils.SchedulerHelper")
    if self._tickHandler ~= nil then
        return
    end
    self._tickHandler = SchedulerHelper.newSchedule(handler(self,self._tick),1)
    
end 

function PosterGirlManager:_closeUpdate()
    local SchedulerHelper = require("app.utils.SchedulerHelper")
    if self._tickHandler ~= nil then
        SchedulerHelper.cancelSchedule(self._tickHandler)
        self._tickHandler = nil
    end    
end 

function PosterGirlManager:_tick(t)
    if not self._waitPlayVoiceList[1] then
        return 
    end
    local time = G_ServerTime:getTime()
    if self._lastPlayVoice ~= nil and  (time - self._lastPlayTime) < self._lastPlayVoice.voice.length/1000 then
        logWarn("PosterGirlManager hhh ...".. (time - self._lastPlayTime).." / "..self._lastPlayVoice.voice.length)
        return
    end
    logWarn("PosterGirlManager start ...")
    self._lastPlayTime = time
    self._lastPlayVoice = self._waitPlayVoiceList[1]  
    self._lastPlayAudioId = nil
    table.remove(self._waitPlayVoiceList,1)
    if self._lastPlayVoice.voice.voice1 ~= "" then
        logWarn("PosterGirlManager play sound :"..Path.getPosterGirlVoice(self._lastPlayVoice.voice.voice1).."  time"..self._lastPlayVoice.voice.length)
        self._lastPlayAudioId = G_AudioManager:playSound(Path.getPosterGirlVoice(self._lastPlayVoice.voice.voice1))
        G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_PLAY_VOICE,self._lastPlayVoice.voice.voice1)
    end
    
end

function PosterGirlManager:_playVoice(voiceInfo)
    self:_clearVoice()
    local time = G_ServerTime:getTime()
    self._lastPlayTime = time
    self._lastPlayVoice = voiceInfo
    self._lastPlayAudioId = nil
    if self._lastPlayVoice.voice.voice1 ~= "" then
        logWarn("PosterGirlManager play sound :"..Path.getPosterGirlVoice(self._lastPlayVoice.voice.voice1).."  time"..self._lastPlayVoice.voice.length)
        self._lastPlayAudioId = G_AudioManager:playSound(Path.getPosterGirlVoice(self._lastPlayVoice.voice.voice1))

        local actionStr = self._lastPlayVoice.voice.skin_action
        local actionName = nil
        if actionStr and actionStr ~= "" then
            local actionList = string.split(actionStr,",")
            local index = math.random(1,#actionList)
            actionName = actionList[index]
        end 
        
        G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_PLAY_VOICE,self._lastPlayVoice.voice.voice1,actionName)
    end
end

function PosterGirlManager:_getPlayingVoiceData()
    local time = G_ServerTime:getTime()
    if self._lastPlayVoice ~= nil and  (time - self._lastPlayTime) < self._lastPlayVoice.voice.length/1000 then
        return self._lastPlayVoice
    end
    return nil
end

function PosterGirlManager:_onEventFinishLogin()
    --进入vip界面需要加载setting
    self._voiceStateData:loadLocalSetting()
    if self._voiceStateData:getState("version") ~= 0 then--保存设置
        local data = self._voiceStateData:getSettingData()
        local jsonStr = json.encode(data)
        local value = base64.encode(jsonStr)
        self._request:doRequestSetKeyValue("posterGirl",value,false)
    end
    self._request:doRequestGetKeyValue("posterGirl")
end


function PosterGirlManager:_onGetValueHttpCallBack(e,param)
    if e == "success" then
        self._voiceStateData:getSettingData().version = 1
        --[[
        if param.field ~= "" then
            local fieldJson = base64.decode(param.field)
            local remoteSettingData = json.decode(fieldJson)
            self._voiceStateData:loadRemoteSetting(remoteSettingData)
        elseif self._voiceStateData:getSettingData().version == 0 then
            self._voiceStateData:getSettingData().version = 1
        end
        ]]
    end
end


function PosterGirlManager:_initVipVoice()
    self._vipVoiceMap = {}
    local PosterGirlVoiceConst = require("app.const.PosterGirlVoiceConst")
    local VipVoice = require("app.config.vip_voice")
    for k = 1,VipVoice.length(),1 do
        local config = VipVoice.indexOf(k)
        if config.requirement == PosterGirlVoiceConst.TYPE_CLICK_AVATAR and 
            config.trigger_id == PosterGirlVoiceConst.TRIGGER_POS_CLICK_AVATAR and 
            config.date_star == 0 and config.date_end == 0 
            then
            table.insert(self._vipVoiceMap,{min = config.vip_level_min,max = config.vip_level_max,voice = config.voice})
        end
    end
    dump(self._vipVoiceMap,"PosterGirlManager") 
end

function PosterGirlManager:_initVoiceWhenStayVipView()
    self._stayTime = {}
    local PosterGirlVoiceConst = require("app.const.PosterGirlVoiceConst")
    local VipVoice = require("app.config.vip_voice")
    for k = 1,VipVoice.length(),1 do
        local config = VipVoice.indexOf(k)
        if config.trigger_id == PosterGirlVoiceConst.TRIGGER_POS_RECHARGE_STAY then
            table.insert(self._stayTime,config.value)
        end
    end
    dump(self._stayTime,"PosterGirlManager") 
end

function PosterGirlManager:_clearTempState()
    self._tempSates = {}
end

function PosterGirlManager:_findBaseVoiceByVip()
    local vip = G_UserData:getVip():getLevel()
    for k,v in ipairs(self._vipVoiceMap) do
        if vip >= v.min and vip <= v.max then
            return v.voice
        end
    end
    return nil
end


function PosterGirlManager:_clearVoice()
    self._waitPlayVoiceList = {}
    local playingVoiceData = self:_getPlayingVoiceData()
    if playingVoiceData and self._lastPlayAudioId then
        logWarn("PosterGirlManager onEventPosterGirlVoiceClear ok "..self._lastPlayAudioId )
        G_AudioManager:stopSound(self._lastPlayAudioId)
    end
end


function PosterGirlManager:_onEventPosterGirlVoiceClear(event)
    logWarn("PosterGirlManager onEventPosterGirlVoiceClear ")
    self:_clearVoice()
end

function PosterGirlManager:_onEventPosterGirlVoiceUpdate(event,triggerId,param)
    --[[
    --剔除和正在播放的语音相同TRIGGER_ID的语音
    local playingVoiceData = self:_getPlayingVoiceData()
    if playingVoiceData then
        if playingVoiceData.cfg.trigger_id == triggerId then
            logWarn("PosterGirlManager cancel "..triggerId)
            return 
        end
    end
]]

    local PosterGirlVoiceConst = require("app.const.PosterGirlVoiceConst")
    local PosterGirlVoiceHelper = require("app.utils.data.PosterGirlVoiceHelper")
    local VipVoice = require("app.config.vip_voice")
    local VipVoiceLibrary = require("app.config.vip_voice_library")
    --遍历找出所有能被触发的语音规则
    local cfgList = {}
    for k  = 1,VipVoice.length(),1 do
        local config = VipVoice.indexOf(k)
        if config.voice ~= "" then
            if config.trigger_id == triggerId then
                table.insert(cfgList,config.id)
            end 
        end
    end
    if #cfgList <= 0 then
        return 
    end
    self:_clearTempState()
    --检查哪些语音规则能触发
    local triggerSuccessList = {}
    for k,v in ipairs(cfgList) do
        local success = PosterGirlVoiceHelper.isConditionReach(v,param)
        if success then
            table.insert(triggerSuccessList,v)
        end
    end
    self:_saveTempState()
    --筛出互斥的语音
    local replaceList = {}
    for k,v in ipairs(triggerSuccessList) do
        local config = VipVoice.get(v)
        assert(config,"vip_voice can not find id :  "..tostring(v))
        if config.replace ~= "" then
            local replaceArr = string.split(config.replace,",") 
            for k,v in ipairs(replaceArr) do
                replaceList[v] = true
            end
        end
    end 

    --剔除互斥的语音
    local newTriggerSuccessList = {}
    for k,v in ipairs(triggerSuccessList) do
        if not replaceList[tostring(v)] then
            local config = VipVoice.get(v)
            assert(config,"vip_voice can not find id :  "..tostring(v))
            table.insert(newTriggerSuccessList,config)
        end
    end


    --排序
    table.sort(newTriggerSuccessList,function (a,b)
        if a.order ~= b.order then
            return a.order > b.order
        else
            return a.id > b.id
        end
    end)

    local dateVoiceList = {}
    --独占处理
    for k,config in ipairs(newTriggerSuccessList) do
        if  config.date_star ~= 0 and config.date_end ~= 0 then
            table.insert(dateVoiceList,config)
        end
    end
    if #dateVoiceList > 0 then
        newTriggerSuccessList = dateVoiceList
    end
    local playVoiceList = {}
    local currSkinVoiceConfig = self:_getCurrSkinVoiceConfig()
    for k,config in ipairs(newTriggerSuccessList) do
        local voiceStr = config.voice
        assert(voiceStr ~= "","vip_voice can not find voice in id:  "..tostring(config.id))
        if config.vip_flag ~= 0 then
            --需要读取VIP数值
            local addVoice = self:_findBaseVoiceByVip()
            if addVoice then
                voiceStr = voiceStr..","..addVoice
            end
        end
        if config.requirement == PosterGirlVoiceConst.TYPE_CLICK_AVATAR and currSkinVoiceConfig then
            voiceStr = voiceStr..","..currSkinVoiceConfig.id
        end
        local voiceArr = string.split(voiceStr,",") 
        if voiceArr then
            local index = math.random(1,#voiceArr)
            if tonumber(voiceArr[index]) ~= 0 then
                local voiceConfig = VipVoiceLibrary.get(tonumber(voiceArr[index]))
                assert(voiceConfig,"vip_voice_library can not find id :  "..tostring(voiceArr[index]).." "..tostring(voiceStr))
                table.insert(playVoiceList,{cfg = config,voice = voiceConfig})
            end
        end
    end
    if #playVoiceList > 0 then
        self:_playVoice(playVoiceList[1])
    end
     
   
end

function PosterGirlManager:getState(key)
    return self._voiceStateData:getState(key)
end


function PosterGirlManager:_saveTempState()
    for k,v in pairs(self._tempSates) do
        self._voiceStateData:setState(k,v)
    end
end

function PosterGirlManager:setState(key,state)
    self._tempSates[key] = state
end

function PosterGirlManager:doRequestGetKeyValue(onMsgCallBack)
    self._request:doRequestGetKeyValue("posterGirl")
    local function callback(e,param)
        onMsgCallBack(e,param)
    end
    return self._request.signal:add(callback)
end

function PosterGirlManager:getStayTime()
    return self._stayTime
end

function PosterGirlManager:_getCurrSkinVoiceConfig()
    local skinId = G_UserData:getPosterGirl():getWear_skin()
    local VipVoiceLibrary = require("app.config.vip_voice_library")
    for k = 1,VipVoiceLibrary.length(),1 do  
        local config = VipVoiceLibrary.indexOf(k)
        if config.skin_id == skinId then
            return config
        end
    end
    return nil
end

return PosterGirlManager
