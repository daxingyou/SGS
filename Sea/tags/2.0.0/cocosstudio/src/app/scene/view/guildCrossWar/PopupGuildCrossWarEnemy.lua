-- @Author  panhoa
-- @Date  3.20.2019
-- @Role
local PopupBase = require("app.ui.PopupBase")
local PopupGuildCrossWarEnemy = class("PopupGuildCrossWarEnemy", PopupBase)
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local GuildCrossWarHelper = import(".GuildCrossWarHelper")


function PopupGuildCrossWarEnemy:ctor(closeFunc)
    self._resource  = nil
    self._imagePanel= nil
    self._imageCenter = nil
    self._closeCallBack = closeFunc

    self._oriCellPos = {} 

	local resource = {
		file = Path.getCSB("PopupGuildCrossWarEnemy", "guildCrossWar"),
	}
	PopupGuildCrossWarEnemy.super.ctor(self, resource, false, true)
end

function PopupGuildCrossWarEnemy:onCreate()
    local szie = self._resource:getContentSize()
    self:setContentSize(szie.width, szie.height)
    self._resource:setSwallowTouches(false)

    self._oriImageCenterPos = cc.p(self._imagePanel:getPositionX(), self._imagePanel:getPositionY())
    self:_initView()
end

function PopupGuildCrossWarEnemy:onEnter()
end

function PopupGuildCrossWarEnemy:onExit()
    if self._closeCallBack then
        self._closeCallBack()
    end
end

function PopupGuildCrossWarEnemy:close()
	self:onClose()
	self.signal:dispatch("close")
    self:removeFromParent()
end

function PopupGuildCrossWarEnemy:_initView()
    self._imagePanel:setVisible(false)
    for i=1, GuildCrossWarConst.ENEMY_CELL_MAX do
        self["_fileNode"..i]:setVisible(false)
        table.insert(self._oriCellPos, cc.p(self["_fileNode"..i]:getPositionX(), self["_fileNode"..i]:getPositionY()))
    end
end

function PopupGuildCrossWarEnemy:_closeAllCell(finishCallback)
    self._finishCallback = finishCallback
    for i=1, GuildCrossWarConst.ENEMY_CELL_MAX do
        self:_fadeOutView(i, 0.25)
    end
end

function PopupGuildCrossWarEnemy:_fadeOutView(index, delay)
    local addDelay = delay--(delay + (index - 1) * 0.1)
    self["_fileNode"..index]:stopAllActions()
    self["_fileNode"..index]:runAction(cc.Spawn:create(
        cc.MoveTo:create(addDelay, self._oriImageCenterPos),
        cc.FadeOut:create(addDelay),
        cc.ScaleTo:create(addDelay, 0),
        cc.Sequence:create(
            cc.DelayTime:create(delay + 0.15),
            cc.CallFunc:create(function()
                if index == 3 then
                    self._imagePanel:setVisible(false)
                    if self._finishCallback then
                        self._finishCallback()
                    end
                end
            end)
        )
    ))
end

function PopupGuildCrossWarEnemy:_fadeInView(index, delay)
    local addDelay = delay--(delay + ((index - 1) * 0.1))
    self["_fileNode"..index]:stopAllActions()
    self["_fileNode"..index]:runAction(cc.Spawn:create(
        cc.MoveTo:create(addDelay, self._oriCellPos[index]),
        cc.FadeIn:create(addDelay),    
        cc.ScaleTo:create(addDelay, 1.0),
        cc.Sequence:create(
            cc.DelayTime:create(0.1),
            cc.CallFunc:create(function()
                if index == 1 then
                    self._imagePanel:setVisible(true)
                end
            end)
        )
    ))
end

function PopupGuildCrossWarEnemy:updateUI(userList, isPlayAction)
    userList = userList or {}
    local recordCount = 0
    for k,v in pairs(userList) do
        local userUnit = G_UserData:getGuildCrossWar():getUnitById(v)
        if userUnit ~= nil and not userUnit:isSelfGuild() then
            if userUnit ~= nil then
                recordCount = (recordCount + 1)
                if recordCount > GuildCrossWarConst.ENEMY_CELL_MAX then break end
                self["_fileNode"..recordCount]:setVisible(true)
                self["_fileNode"..recordCount]:updateUI(userUnit)
                if isPlayAction then
                    self["_fileNode"..recordCount]:setScale(0)
                end
            end
        end
    end

    for i=1, GuildCrossWarConst.ENEMY_CELL_MAX do
        if isPlayAction and self["_fileNode"..i]:isVisible() then
            self:_fadeInView(i, 0.25)            
        end
    end
end

function PopupGuildCrossWarEnemy:setPointHole(pointHole)
    -- body
    self._pointHole = pointHole or {}
end

function PopupGuildCrossWarEnemy:getCurPointHole()
    -- body
    return self._pointHole
end

function PopupGuildCrossWarEnemy:updatePosition(position)
    -- body
    self:setPosition(position)
end

function PopupGuildCrossWarEnemy:closePop()
    -- body
    self:_closeAllCell(function()
        self:close()
    end)
end



return PopupGuildCrossWarEnemy