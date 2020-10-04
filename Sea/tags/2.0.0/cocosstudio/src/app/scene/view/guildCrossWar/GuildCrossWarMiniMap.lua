--跨服军团战你小地图
local ViewBase = require("app.ui.ViewBase")
local GuildCrossWarMiniMap = class("GuildCrossWarMiniMap", ViewBase)
local PopupGuildCrossWarSmallMap = import(".PopupGuildCrossWarSmallMap")
local Path = require("app.utils.Path")
local GuildCrossWarHelper = import(".GuildCrossWarHelper")
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
function GuildCrossWarMiniMap:ctor()
    self._scrollView = nil --底图
    self._topBar = nil --顶部条 
    self._smallMapDlg = nil
    
    local resource = {
        file = Path.getCSB("GuildCrossWarMiniMap", "guildCrossWar"),
        size = G_ResolutionManager:getDesignSize(),
        binding = {
        }
    }
    self:setName("GuildCrossWarMiniMap")
    GuildCrossWarMiniMap.super.ctor(self, resource)
end

function GuildCrossWarMiniMap:onCreate()
    self._panelBk:addClickEventListenerEx(handler(self, self._onClickButton))
end

function GuildCrossWarMiniMap:_onClickButton(sender)
    if self._smallMapDlg == nil then
        local dlg = PopupGuildCrossWarSmallMap.new()
        self._smallMapDlg = dlg
        self._smallMapDlgSignal = self._smallMapDlg.signal:add(handler(self, self._onPopupSmallMapDlgClose))     
        dlg:open()
    end
end

--dlg框关闭事件
function GuildCrossWarMiniMap:_onPopupSmallMapDlgClose(event)
    if event == "close" then
        self._smallMapDlg = nil
        if self._smallMapDlgSignal then
            self._smallMapDlgSignal:remove()
            self._smallMapDlgSignal = nil
        end
    end
end

function GuildCrossWarMiniMap:onEnter()
end

function GuildCrossWarMiniMap:onExit()
end

function GuildCrossWarMiniMap:convertToSmallMapPos(pos)
    pos.x = pos.x * GuildCrossWarConst.CAMERA_SCALE_MIN
    pos.y = pos.y * GuildCrossWarConst.CAMERA_SCALE_MIN
    return pos
end

--刷新迷你地图
function GuildCrossWarMiniMap:updateCamera(cameraX, cameraY)
    local innerContainer = self._scrollView:getInnerContainer()
    innerContainer:setPosition(cameraX, cameraY)
end

-- @Role    
function GuildCrossWarMiniMap:updateSelf(selfPosX, selfPosY)
    GuildCrossWarHelper.updateSelfNode(self._scrollView, selfPosX, selfPosY)
    if self._smallMapDlg then
        self._smallMapDlg:updateSelf(selfPosX, selfPosY)
    end
end

-- @Role    
function GuildCrossWarMiniMap:updateSelfGuildNumber(users)
    if self._smallMapDlg then
        self._smallMapDlg:updateSelfGuildNumber(users)
    end
end


return GuildCrossWarMiniMap
