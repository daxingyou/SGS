local ViewBase = require("app.ui.ViewBase")
local GuildCrossWarBattleMapNode = class("GuildCrossWarBattleMapNode", ViewBase)
local BigImagesNode = require("app.utils.BigImagesNode")
local GuildCrossWarAvatar = import(".GuildCrossWarAvatar")
local GuildCrossWarBosssAvatar = import(".GuildCrossWarBosssAvatar")
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local CurveHelper = require("app.utils.CurveHelper")
local GuildCrossWarHelper = import(".GuildCrossWarHelper")
--local PopupGuildCrossWarEnemy = require("app.scene.view.guildCrossWar.PopupGuildCrossWarEnemy")
local GuildWarNoticeNode = require("app.scene.view.guildwarbattle.GuildWarNoticeNode")
local GuildCrossWarGuildRank = import(".GuildCrossWarGuildRank")



GuildCrossWarBattleMapNode.CAMERA_SPEED = 2200
GuildCrossWarBattleMapNode.USER_KEY   = "userId_"
GuildCrossWarBattleMapNode.BOSS_KEY   = "bossId_"

function GuildCrossWarBattleMapNode:ctor()
    self._scrollView    = nil
    self._panelTouch    = nil
    self._centerNode    = nil
    self._guildRankNode = nil
    self._occupiedNode  = nil

    self._tipsParentNode= nil
    self._fightNotice   = nil
    self._guildRank     = nil

    --self._enemyView     = nil
    self._avatarUserMap = {}
    self._avatarBossMap = {}

    local resource = {
        file = Path.getCSB("GuildCrossWarBattleMapNode", "guildCrossWar"),
    }
    self:setName("GuildCrossWarBattleMapNode")
    GuildCrossWarBattleMapNode.super.ctor(self, resource)
end

function GuildCrossWarBattleMapNode:onCreate()
    self:_createMap()
    self:_registerListenerTouchScroll()

    self._panelTouch:setVisible(false)
    self._fightNotice = GuildWarNoticeNode.new(2)
    self._tipsParentNode:addChild(self._fightNotice)

    self._guildRank  = GuildCrossWarGuildRank.new()
    self._guildRankNode:addChild(self._guildRank)
    self:makeClickRect()
end

function GuildCrossWarBattleMapNode:_registerListenerTouchScroll()
    local listener = cc.EventListenerTouchOneByOne:create()
	listener:setSwallowTouches(false)
	listener:registerScriptHandler(handler(self, self._onTouchBeganEvent), cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(handler(self, self._onTouchMoveEvent), cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(handler(self, self._onTouchEndEvent), cc.Handler.EVENT_TOUCH_ENDED)
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self._scrollView)
end

function GuildCrossWarBattleMapNode:_onTouchBeganEvent(touch, event)
    local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if selfUnit == nil then
        return
    end
   
    local function isExistObstruct(grid)
        local userList = GuildCrossWarHelper.getHoleUserList(grid) or {}
        for k,v in pairs(userList) do
            local userAvatar = self:_getUserAvatar(v)
            if userAvatar ~= nil and not userAvatar:isSelfGuild() then
                return true
            end
        end
        return false
    end

    if state == ccui.TouchEventType.ended or not state then
        local innerContainer = self._scrollView:getInnerContainer()
        local endPos = innerContainer:convertToNodeSpace(touch:getLocation())
        local gridX = math.ceil(endPos.x/GuildCrossWarConst.GRID_SIZE )
        local gridY = math.ceil(endPos.y/GuildCrossWarConst.GRID_SIZE )
        local grid = GuildCrossWarHelper.getWarMapCfgByGrid(gridX, gridY)

        if selfUnit:checkCanMoving(grid) then
            if isExistObstruct(grid.id) then
                return
            end
            
            local needTime = selfUnit:getNeedTime(grid.id)
            G_UserData:getGuildCrossWar():c2sBrawlGuildsMove({key_point_id = grid.point_y, pos = grid.id}, needTime)
        end
    end
end

function GuildCrossWarBattleMapNode:_onTouchMoveEvent(touch,event)
    print("GuildCrossWarBattleMapNode:_onTouchMoveEvent")
end

function GuildCrossWarBattleMapNode:_onTouchEndEvent(touch,event)
    print("GuildCrossWarBattleMapNode:_onTouchEndEvent")
end


function GuildCrossWarBattleMapNode:onEnter()
    self._signalEnter       = G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_ENTRY, handler(self, self._onEventEnter))             -- 进入
    self._signalSelfMove    = G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_SELFMOVE, handler(self, self._onEventSelfMove))       -- 移动
    self._signalUpdateUser  = G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_UPDATEPLAYER, handler(self, self._onEventUpdateUser)) -- 更新用户
    self._signalUpdatePoint = G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_UPDATEPOINT, handler(self, self._onEventUpdatePoint)) -- 更新据点
    self._signalFight       = G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_FIGHT, handler(self, self._onEventFight))             -- 战斗
    self._signalFightNotice = G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_OTHER_SEE_BOSSS, handler(self, self._onEventFightNotice)) -- 据点其他玩家打Boss推送
    self._signalFightSelfDie = G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_SELFDIE, handler(self, self._onEventFightSelfDie)) 
    self._signalFightOtherDie= G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_OTHERDIE, handler(self, self._onEventFightOtherDie))
    
    self:_releaseMap()
    self:_updateUserList()
    self:_updateBossList()
    self:_updatePossession()
    self:_gotoPointCenter(true)
end

function GuildCrossWarBattleMapNode:onExit()
    self:unscheduleUpdate()
    self._signalEnter:remove()
    self._signalEnter = nil
    self._signalSelfMove:remove()
    self._signalSelfMove = nil
    self._signalUpdateUser:remove()
    self._signalUpdateUser = nil
    self._signalUpdatePoint:remove()
    self._signalUpdatePoint = nil
    self._signalFight:remove()
    self._signalFight = nil
    self._signalFightNotice:remove()
    self._signalFightNotice = nil
    self._signalFightSelfDie:remove()
    self._signalFightSelfDie = nil
    self._signalFightOtherDie:remove()
    self._signalFightOtherDie = nil
end

function GuildCrossWarBattleMapNode:_createMap()
    local spriteMap = BigImagesNode.new(Path.getStageGuildCross("guild_cross_stage"))
    local spriteSize = spriteMap:getContentSize()
    spriteMap:setAnchorPoint(cc.p(0, 0))
    spriteMap:setPosition(cc.p(0, 0))
    self._scrollView:addChild(spriteMap)
    self._scrollView:setInnerContainerSize(spriteSize)
    self._scrollView:setContentSize(G_ResolutionManager:getDesignCCSize())
    --self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
end

function GuildCrossWarBattleMapNode:_releaseMap()
    for key, value in pairs(self._avatarUserMap) do
        self:_releaseUserAvatar(key)
    end

    for key, value in pairs(self._avatarBossMap) do
        self:_releaseBossAvatar(key)
    end
end

-- @Role    Release UserAvatar
function GuildCrossWarBattleMapNode:_releaseUserAvatar(userId)
    local avatarUser = self._avatarUserMap[userId]
    if avatarUser then
        avatarUser:removeFromParent()
        self._avatarUserMap[userId] = nil
    end
end

-- @Role    Release BossAvatar
function GuildCrossWarBattleMapNode:_releaseBossAvatar(pointId)
    local avatarBoss = self._avatarBossMap[pointId]
    if avatarBoss then
        avatarBoss:removeFromParent()
        self._avatarBossMap[pointId] = nil
    end
end

-- @Role    PopEnenmy is Flip（可弃用
function GuildCrossWarBattleMapNode:_isFlip(posX, posY)
    -- body
    local bOffsetX, bOffsetY = false, false
    local curX, curY = self:_cameraPosConvert(posX, posY)
    local innerContainer = self._scrollView:getInnerContainer()
    local cameraX, cameraY = innerContainer:getPosition()

    local designWidth = G_ResolutionManager:getDesignWidth()/2 - 300
    local designHeight = G_ResolutionManager:getDesignHeight()/2 - 190
    if (cameraY - curY) > designHeight then
        if (cameraX - curX) > designWidth then
            bOffsetX, bOffsetY = true, true
        else
            bOffsetX, bOffsetY = false, true
        end
    elseif (cameraX - curX) > designWidth then
        bOffsetX, bOffsetY = true, false
    end
    return bOffsetX, bOffsetY
end

-- @@@（可弃用
function GuildCrossWarBattleMapNode:_getMidOffset(posX, posY)
    local curX, curY = self:_cameraPosConvert(posX, posY)
    local innerContainer = self._scrollView:getInnerContainer()
    local cameraX, cameraY = innerContainer:getPosition()
    return cc.pSub(cc.p(cameraX, cameraY), cc.p(curX, curY))
end

--[[function GuildCrossWarBattleMapNode:_closeFunc()
    --self._enemyView = nil 
end]]

-- @Role    Touch Avatar（可弃用
function GuildCrossWarBattleMapNode:_touchAvatar(pointHole, postionX, postionY)
    -- body
    --[[local userList = GuildCrossWarHelper.getHoleUserList(pointHole)
    if userList == nil or table.nums(userList) <= 0 then
        return
    end
   
    --local bFlipX, bFlipY = self:_isFlip(postionX, postionY)
    local offsetP = self:_getMidOffset(postionX, postionY+50)
    local scrollCenterP = clone(G_ResolutionManager:getDesignCCPoint())
    local newPos = cc.pAdd(scrollCenterP, offsetP)]]
    --newPos.x = bFlipX and (newPos.x + GuildCrossWarConst.ENEMY_VIEW_OFFSETPOS.x) or newPos.x
    --newPos.y = bFlipY and (newPos.y + GuildCrossWarConst.ENEMY_VIEW_OFFSETPOS.y) or newPos.y
    
    --[[if self._enemyView == nil then
        local enemy = PopupGuildCrossWarEnemy.new(handler(self, self._closeFunc))
        enemy:updateUI(userList, true)
        enemy:setPointHole(pointHole)
        enemy:open()
        enemy:updatePosition(newPos)
        self._enemyView = enemy
    else
        if GuildCrossWarHelper.isCurPointHole(self._enemyView:getCurPointHole(), pointHole) then
            self._enemyView:closePop()
        else
            self._enemyView:updateUI(userList, false)
            self._enemyView:setPointHole(pointHole)
            self._enemyView:updatePosition(newPos)
        end
    end]]
end

-- @Role    Create UserAvatar
function GuildCrossWarBattleMapNode:_createUserAvatar(userId, actionType)
    local avatar = GuildCrossWarAvatar.new(userId, handler(self, self._touchAvatar))
    avatar:updateUI()
    avatar:setName(GuildCrossWarBattleMapNode.USER_KEY ..userId)
    self._scrollView:addChild(avatar, 10000)
    self._avatarUserMap[userId] = avatar
    return avatar
end

-- @Role    Create BossAvatar
function GuildCrossWarBattleMapNode:_createBossAvatar(pointId)
    local avatar = GuildCrossWarBosssAvatar.new(pointId)
    avatar:updateUI()
    avatar:setName(GuildCrossWarBattleMapNode.BOSS_KEY ..pointId)
    self._scrollView:addChild(avatar, 10000)
    self._avatarBossMap[pointId] = avatar
    return avatar
end

------------------------------------------------------------------------------------------------
-- @Role    Get  CameraPos
function GuildCrossWarBattleMapNode:getCameraPos()
    local innerContainer = self._scrollView:getInnerContainer()
    return cc.p(innerContainer:getPosition()), self._scrollView:getContentSize()
end

-- @Role    Get  Userlist
function GuildCrossWarBattleMapNode:getUserList()
    local selfGuilNumber = {}
    for k,v in pairs(self._avatarUserMap) do
        if self._avatarUserMap[k] and self._avatarUserMap[k]:isSelfGuild() then
            if not self._avatarUserMap[k]:isSelf() then
                if not selfGuilNumber[k] then
                    selfGuilNumber[k] = {}
                end
                selfGuilNumber[k] = self._avatarUserMap[k]
            end
        end
    end

    return selfGuilNumber
end

-- @Role    Move Center Camera action
function GuildCrossWarBattleMapNode:_moveCameraAction(path)
    -- body
    local curveConfigList = path.curLine
    local totalTime = (path.totalTime * 1000)
    local endTime = (G_ServerTime:getMSTime() + path.totalTime * 1000)
    
    local function movingEnd(...)
        self:_loopFollowing()
    end
    local function moveCallback(newPos, oldPos)
        local scrollX, scrollY = self:_cameraPosConvert(newPos.x, newPos.y)
        scrollX, scrollY = math.floor(scrollX), math.floor(scrollY)
        local innerContainer = self._scrollView:getInnerContainer()
        innerContainer:setPosition(scrollX, scrollY)
    end
    
    local CurveHelper = require("app.scene.view.guildCrossWar.CurveHelper")
    CurveHelper.doCurveMove(self._centerNode,
        movingEnd, nil,
        moveCallback,
        curveConfigList,
        totalTime,
        endTime)
end

-- @Role    Goto Center
function GuildCrossWarBattleMapNode:_gotoPointCenter(isFirstEnter)
    isFirstEnter = isFirstEnter or false
    local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if selfUnit == nil then
        return
    end
    
    local pointHole = selfUnit:getCurPointHole()
    if pointHole == nil then
        return
    end

    local hoelCenter = GuildCrossWarHelper.getWarMapGridCenter(pointHole.pos)
    local scrollX, scrollY = self:_cameraPosConvert(hoelCenter.x, hoelCenter.y)
    if isFirstEnter then
        local innerContainer = self._scrollView:getInnerContainer()
        innerContainer:stopAllActions()
        innerContainer:setPosition(scrollX, scrollY)
    else
        self:_cameraMoveToPos(scrollX, scrollY)
    end
end

--在可见区域中的avatar，只显示30个
function GuildCrossWarBattleMapNode:_updateAvatarInTheCamera()
    local cameraPos, cameraSize = self:getCameraPos()
    
    local unitList = G_UserData:getGuildCrossWar():getUserMap()
    local maxViewSize = 30
    for i, value in ipairs(unitList) do
        local unitAvatar = self:_getUserAvatar(value:getUid())
        if unitAvatar then
            unitAvatar:setAvatarModelVisible(false)
            if unitAvatar:isStateVisible() then
                local teamPos = cc.p(unitAvatar:getPosition())
                local cameraRect = cc.rect(-cameraPos.x, -cameraPos.y, cameraSize.width, cameraSize.height)
                if cc.rectContainsPoint(cameraRect, teamPos) and maxViewSize > 0 then
                    unitAvatar:setAvatarModelVisible(true)
                    maxViewSize = maxViewSize - 1
                end
            end
        end
    end
end

-------------------------------------------------------------------------------------
-- @Role    Own Avatar
function GuildCrossWarBattleMapNode:_getOwnAvatar()
    local mySelfId = G_UserData:getGuildCrossWar():getSelfUserId()
    if mySelfId and mySelfId > 0 then
        return self._avatarUserMap[mySelfId]
    end
    return nil
end

-- @Role    User's Avatar
function GuildCrossWarBattleMapNode:_getUserAvatar(userId)
    if userId and userId > 0 then
        return self._avatarUserMap[userId]
    end
    return nil
end

-- @Role    Boss's Avatar
function GuildCrossWarBattleMapNode:_getBossvatar(pointId)
    if pointId and pointId > 0 then
        return self._avatarBossMap[pointId]
    end
    return nil
end

-- @Role    Set Boss's Avatar
function GuildCrossWarBattleMapNode:_setBossvatar(pointId)
    if pointId == nil or pointId <= 0 then
        return
    end
    local bossAvatar = self:_getBossvatar(pointId)
    if bossAvatar ~= nil then
        self._avatarBossMap[pointId] = nil
    end
end

-- @Role    Get Self‘s Positioin
function GuildCrossWarBattleMapNode:getSelfPosition()
    local userAvatar = self:_getOwnAvatar()
    if userAvatar == nil then
        return
    end
    return userAvatar:getPosition()
end

-- @Role    Check BossAvatar & Create
function GuildCrossWarBattleMapNode:_checkCreateBossAvatar(id)
    local bossAvatar = self:_getBossvatar(id)
    if bossAvatar == nil then
        bossAvatar = self:_createBossAvatar(id)
    end
    return bossAvatar
end

-- @Role    Check UserAvatar & Create
function GuildCrossWarBattleMapNode:_checkCreateUserAvatar(userId, action)
    local userAvatar = self:_getUserAvatar(userId)
    if userAvatar == nil then
        userAvatar = self:_createUserAvatar(userId, action)
    end
    return userAvatar
end


-- @Role    Update UserAvatarList
function GuildCrossWarBattleMapNode:_updateUserList()
    local selfPointHole = {}
    local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if selfUnit then
        selfPointHole = selfUnit:getCurPointHole()
    end

    local innerContainer = self._scrollView:getInnerContainer()
    local userList = G_UserData:getGuildCrossWar():getUserMap()
    for k, value in pairs(userList) do
        local userAvatar = self:_checkCreateUserAvatar(value:getUid())
        if not userAvatar:isSelf() --[[and userAvatar:getCurState() ~= GuildCrossWarConst.UNIT_STATE_MOVING]] then
            local bVisible = (not userAvatar:isSelfGuild()) and (GuildCrossWarHelper.checkCanMovedPoint(selfPointHole, 
                                GuildCrossWarHelper.getWarMapCfg(userAvatar:getCurGrid())))
            userAvatar:synServerPos()
            userAvatar:showSword(bVisible)
        end
    end
end

-- @Role    Update Cur's point Avatar
function GuildCrossWarBattleMapNode:_updateCurPointList(userList)
    if type(userList) ~= "table" then
        return
    end

    for k, value in pairs(userList) do
        for i, v in pairs(value) do
            local userAvatar = self:_checkCreateUserAvatar(v)
            if not userAvatar:isSelf() and userAvatar:getCurState() ~= GuildCrossWarConst.UNIT_STATE_MOVING then
                userAvatar:synServerPos()
            end    
        end
    end
end

-- @Role    Update BossList
function GuildCrossWarBattleMapNode:_updateBossList()
    local bossList = G_UserData:getGuildCrossWar():getBossMap()
    for k,v in pairs(bossList) do
        local bossState, __ = v:getCurState()
        if bossState ~= GuildCrossWarConst.BOSS_STATE_DEATH then
            local bossAvatar = self:_checkCreateBossAvatar(v:getId())
            bossAvatar:updateUI()
        else
            self:_setBossvatar(v:getId())
        end
    end
end

-- @Role    Update Cur's Possession
function GuildCrossWarBattleMapNode:_updatePossession()
    -- body
    local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if selfUnit == nil then
        return
    end

    local occupied = ""
    local warCfg = GuildCrossWarHelper.getWarCfg(selfUnit:getCurPointId())
    if warCfg ~= nil then
        occupied = (warCfg.point_name ..Lang.get("guild_cross_war_possession"))
    end

    local guildName = Lang.get("guild_cross_war_noguild")
    local pointUnit = G_UserData:getGuildCrossWar():getPointDataById(selfUnit:getCurPointId())
    if pointUnit ~= nil and pointUnit:getGuild_name() ~= "" then
        guildName = pointUnit:getGuild_name()
    end

    self._occupiedNode:removeAllChildren()
    local richText = ccui.RichText:createRichTextByFormatString(
		Lang.get("guild_cross_war_occupied", {city = occupied, name = guildName}),
        {defaultColor = Colors.DARK_BG_THREE, defaultSize = 22, other ={[1] = {fontSize = 22}
    }})

    self._occupiedNode:addChild(richText)
end


----------------------------------------------------------------------------------
-- @Role    Camera Moving
function GuildCrossWarBattleMapNode:_cameraMoveToPos(targetX, targetY)
    local innerContainer = self._scrollView:getInnerContainer()
    innerContainer:stopAllActions()
    local startX, startY = innerContainer:getPosition()
    local dstX, dstY = targetX, targetY
    
    local distance = cc.pGetDistance(cc.p(startX, startY), cc.p(dstX, dstY))
    local time = distance / GuildCrossWarBattleMapNode.CAMERA_SPEED
    local moveAction = cc.MoveTo:create(time, cc.p(dstX, dstY))
    local callFuncAction = cc.CallFunc:create(function()
    end)
    local action = cc.Sequence:create(moveAction, callFuncAction)
    innerContainer:runAction(action)
end

-- @Role    Convert to Screen coordinates
function GuildCrossWarBattleMapNode:_cameraPosConvert(startX, startY)
    -- body
    local x, y = startX, startY
    local innerContainer = self._scrollView:getInnerContainer()
    local currScale = innerContainer:getScale()
    local size = innerContainer:getContentSize()
    local scrollX = -(x * currScale - G_ResolutionManager:getDesignWidth() * 0.5)
    local scrollY = -(y * currScale - G_ResolutionManager:getDesignHeight() * 0.5)
    scrollX = math.max(math.min(scrollX, 0), -(size.width - G_ResolutionManager:getDesignWidth()))
    scrollY = math.max(math.min(scrollY, 0), -(size.height - G_ResolutionManager:getDesignHeight()))
    return scrollX, scrollY
end

-----------------------------------------------------------------------
-- @Role    Enter
function GuildCrossWarBattleMapNode:_onEventEnter()
    self._fightNotice:clear()
    self:_updateUserList()
    self:_updateBossList()
    self:_gotoPointCenter(true)
end

-- @Role    Update CurP's
function GuildCrossWarBattleMapNode:_updateCurPoint(pointId)
    --dump(pointId)
    --local userIdList = GuildCrossWarHelper.getPointUserList(pointId)
    --dump(userIdList)
    --self:_updateCurPointList(userIdList)
    print("GuildCrossWarBattleMapNode:_updateCurPoint 111")
    self:_updateUserList()
end

-- @Role    移动
function GuildCrossWarBattleMapNode:_onEventSelfMove(id, needTime)
    local selfAvatar = self:_getOwnAvatar()
    if selfAvatar == nil then
        return
    end
    --[[if self._enemyView ~= nil then
        self._enemyView:closePop()
    end]]
    selfAvatar:moving(handler(self, self._cameraFollow), handler(self, self._updateCurPoint))
end

-- @Role    相机跟随
function GuildCrossWarBattleMapNode:_cameraFollow(allPath)
    self._movingpathList = {}
    self._movingpathList  = allPath
    self:_loopFollowing()
end

-- @Role    寻路
function GuildCrossWarBattleMapNode:_loopFollowing()
    if self._movingpathList and #self._movingpathList > 0 then
        local path = self._movingpathList[1]
        self:_moveCameraAction(path)
        table.remove(self._movingpathList, 1)
    end
end

-- @Role    用户更新
function GuildCrossWarBattleMapNode:_onEventUpdateUser(id, message)    
    print("GuildCrossWarBattleMapNode:_onEventUpdateUser 111")
    
    local uid = message.player.uid
    if message.action == GuildCrossWarConst.UPDATE_ACTION_0 then                --0. 移动据点
        local userAvatar = self:_checkCreateUserAvatar(uid, GuildCrossWarConst.UPDATE_ACTION_0)
        userAvatar:moving(nil, handler(self, self._updateCurPoint))
        
    elseif message.action == GuildCrossWarConst.UPDATE_ACTION_1 then            --1. 复活回到源点
        local userAvatar = self:_checkCreateUserAvatar(uid, GuildCrossWarConst.UPDATE_ACTION_1)
        userAvatar:playRebornAction(nil, handler(self, self._updateCurPoint))
        
    elseif message.action == GuildCrossWarConst.UPDATE_ACTION_2 then            --2. 血量更新
        local userAvatar = self:_checkCreateUserAvatar(uid)
        userAvatar:updateAvatarHp()

    elseif message.action == GuildCrossWarConst.UPDATE_ACTION_3 then            --3. 出生点刷新
        self:_updateCurPoint()
    end
end

-- @Role    据点更新
function GuildCrossWarBattleMapNode:_onEventUpdatePoint()
    self:_updatePossession()
end

-- @Role    Fight
function GuildCrossWarBattleMapNode:_onEventFight(id, message)
    -- body
    local selfAvatar = self:_getOwnAvatar()
    if selfAvatar == nil then
        return
    end
    if not message.fight_type then  --1.战斗：打Boss        
        selfAvatar:playAttackAction(function()
            local bossAvatar = self:_getBossvatar(selfAvatar:getCurPointId())
            if bossAvatar ~= nil then
                bossAvatar:updateUI()
            end
        end)  
    else                            --2 战斗：打人

        print("GuildCrossWarBattleMapNode:_onEventFight 111")
        if rawget(message, "battle_result") == nil then
            return
        end

        print("GuildCrossWarBattleMapNode:_onEventFight 222")
        local type = 0
        if rawget(message, "is_attacker") then
            type = (message.battle_result + 1)
        else
            type = (message.battle_result + 7)
        end
        self:_createTipUnit(type, message)
    end
end

-- @Role    Create Tips
function GuildCrossWarBattleMapNode:_createTipUnit(typeValue, message)
    print("GuildCrossWarBattleMapNode:_createTipUnit 111")
    local GuildWarNotice = require("app.data.GuildWarNotice")
    local unit = GuildWarNotice.new()
    unit:setValue("name", rawget(message, "target_name") or "XXXXXXXXX")
    unit:setValue("selfhp", rawget(message, "own_hp") or "00")
    unit:setValue("otherhp", rawget(message, "target_hp") or "01")
    unit:setId(typeValue)
    self._fightNotice:showMsg(unit)

    print("GuildCrossWarBattleMapNode:_createTipUnit 222")
    local selfAvatar = self:_getOwnAvatar()
    dump(typeValue)
    if typeValue ~= 8 and selfAvatar ~= nil then
        print("GuildCrossWarBattleMapNode:_createTipUnit 333")
        selfAvatar:updateAvatarHp()
    end
end

-- @Role    SelfDeath
function GuildCrossWarBattleMapNode:_onEventFightSelfDie(id, message)
    print("GuildCrossWarBattleMapNode:_onEventFightSelfDie 111")
    local type = (message.is_attacker and 2 or 8)
    self:_createTipUnit(type, message)
    --[[if self._enemyView ~= nil then
        self._enemyView:closePop()
    end]]

    local userUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if userUnit == nil then
        return
    end

    print("GuildCrossWarBattleMapNode:_onEventFightSelfDie 222")
    local selfAvatar = self:_checkCreateUserAvatar(G_UserData:getGuildCrossWar():getSelfUserId())
    selfAvatar:playRebornAction(handler(self, self._gotoPointCenter),  handler(self, self._updateCurPoint))
end

-- @Role    OtherDeath
function GuildCrossWarBattleMapNode:_onEventFightOtherDie(id, message)
    --[[if self._enemyView ~= nil then
        self._enemyView:closePop()
    end]]
    local type = (message.is_attacker and 1 or 7)
    self:_createTipUnit(type, message)
end

-- @Role    打Boss推送
function GuildCrossWarBattleMapNode:_onEventFightNotice(id, message)
    if rawget(message, "uid") == nil then
        return
    end

    local userAvatar = self:_getUserAvatar(message.uid)
    if userAvatar == nil then
        return
    end
    userAvatar:playAttackAction(function()
        -- body
        local bossAvatar = self:_getBossvatar(message.key_point_id)
        if bossAvatar ~= nil then
            bossAvatar:updateUI()
        end
    end)
end

----------------------------------------------------------------------------------------------
-- 测试用（弃用）
function GuildCrossWarBattleMapNode:makeClickRect()
    -- body
    local retList = G_UserData:getGuildCrossWar():getWarHoleList()
    for i, value in ipairs(retList) do

        --dump(value.clickRect)
        local color = cc.c4b(255, 0, 0, 60)
        if value.isMove == 1 then
            if value.point ~= 0 then
                color = cc.c4b(255, 144, 238, 144)
            else
                color = cc.c4b(0, 144, 238, 144)
            end
        else
        end
        local clickRectWidget = cc.LayerColor:create(color, value.clickRect.width, value.clickRect.height)
        clickRectWidget:setPosition(cc.p(value.clickRect.x, value.clickRect.y))
        self._scrollView:addChild(clickRectWidget)
    end
end


return GuildCrossWarBattleMapNode
