-- 
-- Author: JerryHe
-- Date: 2020-05-26
-- Desc: pcm调试工具，mp3 cell
-- 

local ListViewCellBase  = require("app.ui.ListViewCellBase")
local PcmDebugCell1     = class("PcmDebugCell1",ListViewCellBase)

function PcmDebugCell1:ctor()
    local resource = {
        file = Path.getCSB("PcmDebugCell1", "pcm"),
		binding = {
		}
    }
    
    self:setName("PcmDebugCell1")
	PcmDebugCell1.super.ctor(self, resource)
end

function PcmDebugCell1:onCreate()
    self:setContentSize(self._content:getContentSize())
end

function PcmDebugCell1:onEnter()
    
end

function PcmDebugCell1:onExit()
    
end

function PcmDebugCell1:update(data)
    self._textID:setString(data)
end

return PcmDebugCell1