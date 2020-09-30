-- 
-- Author: JerryHe
-- Date: 2020-05-18
-- Desc: spine 高度检查，读取hero表，并生成idle和sit，并显示
-- 

local Scheduler         = require("cocos.framework.scheduler")

local StoryChatConst    = require("app.const.StoryChatConst")

local AudioHelper       = require("app.utils.AudioHelper")

local PcmDebugCell1     = require("app.scene.view.pcmDebug.PcmDebugCell1")
local PcmDebugCell2     = require("app.scene.view.pcmDebug.PcmDebugCell2")

local ViewBase          = require("app.ui.ViewBase")
local PcmDebugView      = class("PcmDebugView",ViewBase)

local FRAME_PER_SECOND  = 40

local FileUtils         = cc.FileUtils:getInstance()

function PcmDebugView:ctor()
    local resource = {
        file = Path.getCSB("PcmDebugView", "pcm"),
        size = G_ResolutionManager:getDesignSize(),
		binding = {
            _btnGoFix    = {
                events = {{event = "touch", method = "_onClickGoFix"}}
            },
            _btnPlay        = {
                events = {{event = "touch", method = "_onClickPlay"}}
            },
            _btnPause        = {
                events = {{event = "touch", method = "_onClickPause"}}
            },
		}
    }
    
    self:setName("PcmDebugView")
	PcmDebugView.super.ctor(self, resource)
end

function PcmDebugView:onCreate()
    self._btnGoFix:setString(Lang.get("lang_pcm_debug_fix_go"))

    self._scroll1:setPositionX(150)
    self._scroll2:setPositionX(1250)

    -- 这里写死，用3504播放嘴巴动作
    self._nodeHero:updateChatUI(316)

    self:_init()
end

function PcmDebugView:onEnter()
    self._scheduler = Scheduler.scheduleUpdateGlobal(handler(self, self._update))
end

function PcmDebugView:onExit()
    if self._scheduler then 
		Scheduler.unscheduleGlobal(self._scheduler)
		self._scheduler = nil
	end
end

function PcmDebugView:_init()
    -- AudioHelper.setAudioMode(1)

    self._nowPlayId     = nil
    self._mp3Index      = -1
    self._mp3List       = {}
    self._choosePcm     = nil

    self._startPlay     = false
    self._startTime     = 0

    self._mouthState    = -1

    self._imageTotalLength  = self._imgVoiceTotal:getContentSize().width

    self:_parsePcmData()
    self:_preloadMp3()

    self:_initMp3Scroll()

    self:_resetPcmScroll(1)
end

function PcmDebugView:_parsePcmData()

    package.loaded["app.config.soundtrack"]     = nil

    self._pcmData       = {}
    local SoundTrack    = require("app.config.soundtrack")
    for i = 1, SoundTrack.length() do
        local data      = SoundTrack.indexOf(i)
        local content   = string.split(data.soundtrack,"|")
        local length    = 0
        local key       = data.voice_id
        local temp      = {}
        for i1 = 1, #content do
            if content[i1] then
                table.insert(temp,content[i1])

                local sub   = string.split(content[i1],"-")
                length      = length + tonumber(sub[2])
            end
        end
        self._pcmData[key]  = {length = length,pcm = temp}
    end


    -- self:_parseFromLocal()
    -- if self._pcmData then
    --     logWarn("[ 读取了本地已经生成的配置，不用重新解析 ]")
    --     return
    -- end

    -- self._pcmData       = {}

    -- local audioFiles    = FileUtils:listFiles("pcm/")
    -- for i, file in ipairs(audioFiles) do
    --     local content 	= string.split(file,"/")
    --     local num 		= #content
    --     if content[num - 1] ~= "." and content[num - 1] ~= ".." then
    --         local fileName 	= content[num]
    --         self:_parseEachFile(file,fileName)
    --     end
    -- end

    -- self:_savePcmDataToLocal()
end

-- function PcmDebugView:_parseFromLocal()
--     if FileUtils:isFileExist("pcmJson/pcmJson.json") then
--         logWarn("[ 本地有pcmJson数据，直接读取 ]")
--         local pcmJson       = FileUtils:getStringFromFile("pcmJson/pcmJson.json")
--         local content       = json.decode(pcmJson)

--         self._pcmData       = {}
--         for key, v in pairs(content) do
--             local length    = 0
--             for index, v in ipairs(v) do
--                 local sub   = string.split(v,"-")
--                 length      = length + tonumber(sub[2])
--             end

--             self._pcmData[key]  = {length = length,pcm = v}
--         end
--     else
--         logWarn("[ 本地没有pcmJson数据，需要读取pcm文件并解析生成 ]")
--     end
-- end

-- function PcmDebugView:_savePcmDataToLocal()
--     local fileName      = "pcmJson.json"
--     local list          = {}
--     for k, v in pairs(self._pcmData) do
--         list[k]         = v.pcm
--     end

--     G_StorageManager:save(fileName,list)
-- end

-- function PcmDebugView:_parseEachFile(file,fileName)
    
--     local nameContent   = string.split(fileName,".")
--     local id            = nameContent[1]
    
--     local fileContent   = cc.FileUtils:getInstance():getStringFromFile(file)
--     local splitContent  = string.split(fileContent,"-")

--     local temp      = {}
--     local zero      = 0
--     local one       = 0

--     local totalLen  = #splitContent - 1

--     for index = 1, totalLen do
--         local value  = tonumber(splitContent[index])

--         if index == 1 then
--             if value == 0 then
--                 zero = 1
--             else
--                 one = 1
--             end
--         else
--             if value == 0 then
--                 if one == 0 then
--                     zero    = zero + 1
--                 else
--                     table.insert(temp,"1-"..(one * 1000 / FRAME_PER_SECOND))
--                     zero    = 1
--                     one     = 0
--                 end
--             else
--                 if zero == 0 then
--                     one     = one + 1
--                 else
--                     table.insert(temp,"0-"..(zero * 1000 / FRAME_PER_SECOND))
--                     one     = 1
--                     zero    = 0
--                 end
--             end
--         end
--     end

--     if zero ~= 0 then
--         table.insert(temp,"0-"..(zero * 1000 / FRAME_PER_SECOND))
--     else
--         table.insert(temp,"1-"..(one * 1000 / FRAME_PER_SECOND))
--     end

--     self._pcmData[id]     = {length = totalLen * 1000 / FRAME_PER_SECOND,pcm = temp}
-- end

-- 预加载音效
function PcmDebugView:_preloadMp3()
    for mp3, v in pairs(self._pcmData) do
        table.insert(self._mp3List,mp3)
    end
end

function PcmDebugView:_initMp3Scroll()
    self._scroll1:clearAll()
	self._scroll1:setTemplate(PcmDebugCell1)
    self._scroll1:setCallback(handler(self, self._onMp3Update), handler(self, self._onMp3Selected))
    self._scroll1:resize(#self._mp3List)
end

function PcmDebugView:_onMp3Update(item,index)
    local data  = self._mp3List[index + 1]
    item:update(data)
end

function PcmDebugView:_onMp3Selected(item,index)
    self:_resetPcmScroll(index + 1)
end

function PcmDebugView:_resetPcmScroll(index,noCheck)
    if self._mp3Index == index and not noCheck then
        return
    end

    self._mp3Index  = index

    local mp3       = self._mp3List[index]

    self._textChoose:setString(mp3)

    local pcmData   = self._pcmData[mp3]

    -- self._choosePcm = pcmData
    -- 解析选中的pcm数据
    self._choosePcm             = {}
    self._choosePcm.pcmInfo     = {}
    local time      = 0
    for i, v in ipairs(pcmData.pcm) do
        local data      = string.split(v,"-")
        local interval  = tonumber(data[2])
        table.insert(self._choosePcm.pcmInfo,{
            voice       = tonumber(data[1]),
            from        = time,
            to          = (time + interval),
            interval    = interval,
        })
        time        = time + interval
    end

    self._choosePcm.length  = pcmData.length

    -- 声音时长，总体时长后，延迟0.5秒
    self._soundLength   = pcmData.length / 1000 + 0.5

    self._scroll2:clearAll()
    self._scroll2:setTemplate(PcmDebugCell2)
    self._scroll2:setCallback(handler(self, self._onPcmUpdate), handler(self, self._onPcmSelected))
    self._scroll2:resize(#pcmData.pcm)

    self:_resetPcmProgress()

    self:_onClickPause()
end

function PcmDebugView:_resetPcmProgress()
    self._textTotal:setString(Lang.get("lang_pcm_debug_total_length")..self._choosePcm.length)

    self._imgVoiceTotal:removeAllChildren()

    local posX          = 0
    for i, data in ipairs(self._choosePcm.pcmInfo) do
        local len       = data.interval / self._choosePcm.length * self._imageTotalLength
        local imgVoice  = nil
        if data.voice == 1 then
            imgVoice    = self._imgPcm1:clone()
        else
            imgVoice    = self._imgPcm0:clone()
        end

        imgVoice:getChildByName("index"):setString(i)
        imgVoice:setVisible(true)
        imgVoice:setAnchorPoint(0,0.5)
        imgVoice:setPosition(posX,5)
        
        imgVoice:setContentSize(cc.size(len,10))
        imgVoice:getChildByName("index"):setPositionX(len/2)


        self._imgVoiceTotal:addChild(imgVoice)

        posX            = posX + len
    end
end

function PcmDebugView:_onPcmUpdate(item,index)
    local data  = self._choosePcm.pcmInfo[index + 1]

    item:update(data.voice,data.interval,index,data.from,data.to)
end

function PcmDebugView:_onPcmSelected()
    
end

function PcmDebugView:_stopSound()
    if self._nowPlayId then 
        G_AudioManager:stopSound(self._nowPlayId)
        self._nowPlayId = nil
    end
end

function PcmDebugView:_playSound()
    local sound     = self._mp3List[self._mp3Index]
    local mp3       = Path.getSkillVoice(sound)
    if self._nowPlayId then 
        G_AudioManager:stopSound(self._nowPlayId)
        self._nowPlayId = nil
    end
    self._nowPlayId = G_AudioManager:playSound(mp3)
end

function PcmDebugView:_onClickPlay()
    self._btnPlay:setVisible(false)
    self._btnPause:setVisible(true)

    self._startTime     = 0
    self._startPlay     = true

    self._mouthState    = -1

    self:_playSound()
end

function PcmDebugView:_onClickPause()
    self._btnPlay:setVisible(true)
    self._btnPause:setVisible(false)

    self._startPlay     = false
    self._startTime     = 0

    self:_playSpeakerCloseMouthAnimation()

    self:_stopSound()
end

-- 跳转到固定mp3 id
function PcmDebugView:_onClickGoFix()
    local mp3Id     = self._textFixIdInput:getString()
    if not self._pcmData[mp3Id] then
        G_Prompt:showTip(Lang.get("lang_pcm_debug_no_mp3"))
        return
    end

    local mp3Index  = nil
    for i, v in ipairs(self._mp3List) do
        if v == mp3Id then
            mp3Index    = i
            break
        end
    end

    if self._mp3Index == mp3Index then
        return
    end

    self._scroll1:setLocation(mp3Index)
    self:_resetPcmScroll(mp3Index)
end

function PcmDebugView:_update(f)
	if self._startPlay then
        self._startTime = self._startTime + f

        self:_checkMouthState()

		if self._soundLength ~= 0 and self._startTime >= self._soundLength then 
            self:_onClickPause()
        end
	end

end

function PcmDebugView:_checkMouthState()
    for i, v in ipairs(self._choosePcm.pcmInfo) do
        if self._startTime >= v.from / 1000 and self._startTime <= v.to / 1000 then
            if self._mouthState ~= v.voice then
                self._mouthState    = v.voice

                if self._mouthState == 1 then
                    self:_playSpeakerMouthAnimation()
                else
                    self:_playSpeakerCloseMouthAnimation()
                end
            end
        end
    end
end

-- 播放讲话者嘴巴动作
function PcmDebugView:_playSpeakerMouthAnimation()
    self._nodeHero:playPointAnimationOnceWithCallback("mouth","talk",handler(self,self._talkActionFinish))
end

-- 播放闭嘴动作
function PcmDebugView:_playSpeakerCloseMouthAnimation()
    self._nodeHero:playPointDefaultAnimation("mouth")
end

function PcmDebugView:_talkActionFinish()
    self._mouthState    = -1
end

return PcmDebugView