local PopupBase = require("app.ui.PopupBase")
local PopupGuildCrossWarSmallMap = class("PopupGuildCrossWarSmallMap", PopupBase)
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local GuildCrossWarHelper = import(".GuildCrossWarHelper")
local GuildCrossStrongHold = import(".GuildCrossStrongHold")
local GuildCrossWarAttackCell = import(".GuildCrossWarAttackCell")
local scheduler = require("cocos.framework.scheduler")


function PopupGuildCrossWarSmallMap:ctor()
    self._panelBk       = nil
    self._imageMapBG    = nil --背景图
    self._autoMovingNode= nil
    self._listView      = nil
    self._btnAttackList = nil

    self._strongHoldMap = {}
    --self._delayUpTime   = 0

	local resource = {
		file = Path.getCSB("PopupGuildCrossWarSmallMap", "guildCrossWar"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onPanelClick"}}
			}
		}
	}
	PopupGuildCrossWarSmallMap.super.ctor(self, resource, false, true)
end

function PopupGuildCrossWarSmallMap:onCreate()
    self._buttonClose:addClickEventListenerEx(handler(self, self._onClickButton))
    self:_initPointName()
    self:_initStrongHold()
    self:_initListView()
    --self:_initState()

	G_EffectGfxMgr:createPlayGfx(self._autoMovingNode, "effect_xianqinhuangling_zidongxunluzhong", nil, true)
	self._autoMovingNode:setVisible(false)
end

function PopupGuildCrossWarSmallMap:_onClickButton( sender )
	self:close()
end

function PopupGuildCrossWarSmallMap:onEnter()
    self._signalUpdatePoint = G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_UPDATEPOINT, handler(self, self._onEventUpdatePoint)) -- 更新据点
    
    self:_initAttackView()
    self:_initAttackEnable()
    self:_updateStrongHold()
    self:scheduleUpdateWithPriorityLua(handler(self, self._update), 0)
end

function PopupGuildCrossWarSmallMap:onExit()
    self._signalUpdatePoint:remove()
    self._signalUpdatePoint = nil
    self:unscheduleUpdate()
end

function PopupGuildCrossWarSmallMap:_initAttackEnable()
    if G_UserData:getGuildCrossWar():getSelfUnit() then
        self._btnAttackList:setEnabled(G_UserData:getGuildCrossWar():getSelfUnit():isGuildLeader())
    end
end

function PopupGuildCrossWarSmallMap:_initPointName()
    for index = 17, 25 do
        local itemData = GuildCrossWarHelper.getWarCfg(index)
        self["_fileNode"..index]:updateUI(GuildCrossWarHelper.replaceStr(itemData.point_name))
    end
end

function PopupGuildCrossWarSmallMap:_initStrongHold()
    for point = 1, GuildCrossWarHelper.getPointCount() do
        local strongHold = GuildCrossStrongHold.new(point)
        self._strongHoldMap[point] = strongHold
        self._imageMapBG:addChild(strongHold, 5000)

        strongHold:updateHold(false)
        strongHold:updateAttack(false)
    end
end

function PopupGuildCrossWarSmallMap:_initState()
    local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if selfUnit == nil or selfUnit:isReachEdge() ~= true then
        selfUnit:setReachEdge(true)
    end
end

function PopupGuildCrossWarSmallMap:_initAttackView()
    for point = 1, GuildCrossWarHelper.getPointCount() do
        self._strongHoldMap[point]:updateAttack(true)
    end
end

function PopupGuildCrossWarSmallMap:_initListView()
    -- body
    local function updateAtcTarget(attackId)
        self:_fadeListView()
        if type(attackId) ~= "number" then return end

        for index = 17, 25 do
            self._listCellMap[index]:updateNameColor(index == attackId)
        end

        if G_UserData:getGuildCrossWar():getSelfGuildTarget() ~= attackId then
            G_UserData:getGuildCrossWar():c2sBrawlGuildsFollowMe(attackId)
        end
    end

    self._listCellMap = {}
    self._listView:removeAllChildren()
    self._listView:setVisible(false)
    for index = 17, 25 do
        local warCfg = GuildCrossWarHelper.getWarCfg(index)
        warCfg.backIndex = (index % 2 + 1)
        local cell = GuildCrossWarAttackCell.new(updateAtcTarget)
        cell:updateUI(warCfg)
        self._listCellMap[index] = cell
        self._listView:pushBackCustomItem(cell)
    end
    self._listView:adaptWithContainerSize()
    local contentsize = self._listView:getInnerContainerSize()
    self._listView:setContentSize(contentsize)
    self._btnAttackList:addClickEventListenerEx(handler(self, self._fadeListView))
end

function PopupGuildCrossWarSmallMap:_updateAtcTargetName(pointId)
    if pointId == 0 then
        self._textPlaceAttackName:setString(Lang.get("guild_cross_war_noguild"))
    else
        local warCfg = GuildCrossWarHelper.getWarCfg(pointId)
        self._textPlaceAttackName:setString(warCfg.point_name)
        self._textPlaceAttackName:setColor(Colors.GUILDCROSSWAR_ATCCOLOR)
        self._textPlaceAttackName:enableOutline(Colors.GUILDCROSSWAR_ATCCOLOR_OUT)
    end
end

function PopupGuildCrossWarSmallMap:_fadeListView()
    local bVisible = (not self._listView:isVisible())
    self._btnAttackList:setFlippedY(bVisible)
    if bVisible then
        self._listView:setVisible(true)
        self._listView:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.2, 1, 1.0),
        cc.FadeIn:create(0.2)
        ))
    else
        self._listView:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.2, 1, 0.1),
        cc.FadeOut:create(0.2),
        cc.CallFunc:create(function()
            self._listView:setVisible(false)
        end)
        ))
    end
end

-- @Role    Update Point
function PopupGuildCrossWarSmallMap:_onEventUpdatePoint()
    local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if selfUnit == nil or selfUnit:isMoving() then
        return
    end
    self:_updateHoldView()
end

-- @Role    Update Hole
function PopupGuildCrossWarSmallMap:_updateHoldView()
    local pointMap = G_UserData:getGuildCrossWar():getPointMap() or {}
    for k, unit in pairs(pointMap) do
        if not GuildCrossWarHelper.isOriPoint(unit:getKey_point_id()) then
            self._strongHoldMap[unit:getKey_point_id()]:updateHold(unit:isSelfGuild())
        end
    end
end

-- @Role    Update Hold & Attack
function PopupGuildCrossWarSmallMap:_updateStrongHold(dt)
    -- body
    local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if selfUnit == nil --[[or selfUnit:isReachEdge() ~= true]] then
        return
    end

    local function updateAttackAndHoldView(unit)
        --unit:setReachEdge(false)
        self:_updateHoldView()
    end 

    if type(dt) == "number" then
        --[[self._delayUpTime = (self._delayUpTime + dt)
        if self._delayUpTime >= 0.7 then
            self._delayUpTime = 0
            updateAttackAndHoldView(selfUnit)
        end]]
        if G_ServerTime:getLeftSeconds(selfUnit:getMove_cd()) >= 0 and not selfUnit:isMoving() then
            updateAttackAndHoldView(selfUnit)
        elseif selfUnit:isMoving() then
            self:_updateHoldView()
        end
    else
        updateAttackAndHoldView(selfUnit)
    end
end

function PopupGuildCrossWarSmallMap:convertToBigMapPos( pos )
	pos.x = pos.x *GuildCrossWarConst.CAMERA_SCALE_MAX
	pos.y = pos.y *GuildCrossWarConst.CAMERA_SCALE_MAX
	return pos
end

function PopupGuildCrossWarSmallMap:updateSelf(selfPosX, selfPosY )
    GuildCrossWarHelper.updateSelfNode(self._imageMapBG, selfPosX, selfPosY)
end

function PopupGuildCrossWarSmallMap:updateSelfGuildNumber(userList)
    GuildCrossWarHelper.updateSelfGuildMemeber(self._imageMapBG, userList)
end

function PopupGuildCrossWarSmallMap:_onPanelClick( sender,state )
    -- body
    local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if selfUnit == nil then
        return
    end

	if state == ccui.TouchEventType.ended or not state then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then
            local endPos = self._panelTouch:convertToNodeSpace(sender:getTouchEndPosition())
            local convertPos = self:convertToBigMapPos(endPos)
            local clickPoint = G_UserData:getGuildCrossWar():findPointHoleKey(convertPos)
            
            --[[if selfUnit:checkCanMoving(clickPoint) then
                local needTime = selfUnit:getNeedTime(clickPoint)
                G_UserData:getGuildCrossWar():c2sBrawlGuildsMove(clickPoint, needTime)
            end]]
		end
	end
end

-- @Role    Update moving Effect
function PopupGuildCrossWarSmallMap:_updateAuotMovingEffect()
	local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
	if selfUnit == nil then
		return
	end

    if self._autoMovingNode:isVisible() ~= selfUnit:isMoving() then
        self._autoMovingNode:setVisible(selfUnit:isMoving())
    end
end

-- @Role    实时渲染
function PopupGuildCrossWarSmallMap:_update(dt)
    self:_updateStrongHold(dt)
    self:_updateAuotMovingEffect()
    self:_updateAtcTargetName(G_UserData:getGuildCrossWar():getSelfGuildTarget())
end


return PopupGuildCrossWarSmallMap
