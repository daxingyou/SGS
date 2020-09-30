-- 
-- Author: JerryHe
-- Date: 2020-05-26
-- Desc: pcm调试工具，Pcm cell
-- 

local ListViewCellBase  = require("app.ui.ListViewCellBase")
local PcmDebugCell2     = class("PcmDebugCell2",ListViewCellBase)

function PcmDebugCell2:ctor()
    local resource = {
        file = Path.getCSB("PcmDebugCell2", "pcm"),
		binding = {
		}
    }
    
    self:setName("PcmDebugCell2")
	PcmDebugCell2.super.ctor(self, resource)
end

function PcmDebugCell2:onCreate()
    self:setContentSize(self._content:getContentSize())

    -- self._textInput:setupCursorAndListener(cc.c3b(255,255,255),handler(self,self.onInputEvent))
end

function PcmDebugCell2:onEnter()

end

function PcmDebugCell2:onExit()
    
end

function PcmDebugCell2:onInputEvent(txt,eventType)
    if(eventType==ccui.TextFiledEventType.attach_with_ime)then
        txt:setHighlighted(true)
    elseif(eventType==ccui.TextFiledEventType.detach_with_ime)then
        txt:setHighlighted(false)
        self:_checkPcmDataDiff()
    elseif(eventType==ccui.TextFiledEventType.insert_text)then
        
    elseif(eventType==ccui.TextFiledEventType.delete_backward)then
    
    end
end

function PcmDebugCell2:update(voice,interval,index,from,to)

    self._pcmIndex      = index
    self._defaultValue  = interval

    self._defaultVoice  = voice

    local text  = Lang.get("lang_pcm_debug_close_mouth")
    if self._defaultVoice == 1 then
        text    = Lang.get("lang_pcm_debug_open_mouth")
    end

    text        = text..interval
    self._textInfo:setString(text.."("..from.."-"..to..")")

    self._textInput:setString(interval)
end

function PcmDebugCell2:_checkPcmDataDiff()
    local inputValue    = tonumber(self._textInput:getString())
    if inputValue == self._defaultValue then
        return
    end

    if not inputValue then
        inputValue      = 0
    end

    if self._customCallback then
        self._customCallback(self._defaultVoice.."-"..inputValue,self._pcmIndex)
    end
end

return PcmDebugCell2