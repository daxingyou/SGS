-- Author: panhoa
-- Date:
-- 
local ViewBase = require("app.ui.ViewBase")
local GuildCrossWarAvatar = class("GuildCrossWarAvatar", ViewBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local StateMachine = require("app.utils.StateMachine")
local CurveHelper = require("app.scene.view.guildCrossWar.CurveHelper")
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local UserDataHelper = require("app.utils.UserDataHelper")
local GuildCrossWarHelper = require("app.scene.view.guildCrossWar.GuildCrossWarHelper")


function GuildCrossWarAvatar:ctor(unitId, touchCallback)
    self._commonHeroAvatar = nil
    self._panelbk = nil --Panel
    self._avatarName = nil
    self._avatarGuild = nil
    self._touchPanel = nil
    self._percentText= nil
    self._swordEffect  = nil
    self._swordEfcPanel= nil
    self._swordPanel = nil
    

    self._unitId        = unitId
    self._touchCallback = touchCallback
    self._curPointId = 0
    self._moving     = false 
    
    local resource = {
        file = Path.getCSB("GuildCrossWarAvatar", "guildCrossWar"),
    }
    GuildCrossWarAvatar.super.ctor(self, resource)
end

function GuildCrossWarAvatar:onCreate()
    self:_updateUnitData()
    self:_createSwordEffect()
    self:_initSwallowTouches()
    self:setVisible(true)
    self._touchPanel:setVisible(false)

    --self._touchPanel:addClickEventListenerEx(handler(self, self.onClickHero))
    self._swordPanel:addClickEventListenerEx(handler(self, self.onAttackHero))
end

function GuildCrossWarAvatar:onEnter()
end

function GuildCrossWarAvatar:onExit()
end

function GuildCrossWarAvatar:_initSwallowTouches()
    self._nodeRole:setSwallowTouches(false)
    self._swordEfcPanel:setSwallowTouches(false)
    self._imageProc:setSwallowTouches(false)
    self._monsterBlood:setSwallowTouches(false)
    self._avatarTitle:setSwallowTouches(false)
    self._avatarName:setSwallowTouches(false)
    self._avatarGuild:setSwallowTouches(false)
end

function GuildCrossWarAvatar:_createSwordEffect()
    local EffectGfxNode = require("app.effect.EffectGfxNode")
	local function effectFunction(effect)
        if effect == "effect_shuangjian"then
            local subEffect = EffectGfxNode.new("effect_shuangjian")
            subEffect:play()
            return subEffect 
        end
    end
    self._swordEffect = G_EffectGfxMgr:createPlayMovingGfx(self._swordEfcPanel, "moving_shuangjian", effectFunction, nil, false )
	self._swordEffect:setPosition(0,0)
    self._swordEffect:setAnchorPoint(cc.p(0.5,0.5))
    self._swordEffect:setVisible(false)
    self._swordPanel:setVisible(false)
end


function GuildCrossWarAvatar:onClickHero()
    print("GuildCrossWarAvatar:onClickHero")
    self:_updateUnitData()
    if self._userData == nil or self._userData:getCurPointHole() == nil then
        return
    end

    if self._userData:getCurrState() ~= GuildCrossWarConst.UNIT_STATE_IDLE then
        return
    end
    if self._touchCallback then
        local posX, posY = self:getPosition()
        self._touchCallback(self._userData:getCurPointHole(), posX, posY)
    end
end

function GuildCrossWarAvatar:onAttackHero()
    G_UserData:getGuildCrossWar():c2sBrawlGuildsFight(self._userData:getUid())
end

-- @Role    Reborn
function GuildCrossWarAvatar:playRebornAction(callback, updateCallback)
    local curTime = G_ServerTime:getTime()
    local time = self._userData:getRevive_time()
    local leftTime = math.max(0.01, time - curTime)
    
    local seq = cc.Sequence:create(
        cc.CallFunc:create(function()
            self._commonHeroAvatar:setAction("dizzy", false)
        end),
        cc.DelayTime:create(1.0),
        cc.FadeOut:create(0.2),
        cc.CallFunc:create(function()
            self:_synPosition()
            if callback then
                callback()
            end
        end),
        cc.DelayTime:create(2.0),
        cc.CallFunc:create(handler(self, self._playAvatarBornEffect)),
        cc.FadeIn:create(0.1),
        cc.CallFunc:create(function()
            self._commonHeroAvatar:setAction("idle", true)
            self._userData:setHp(self._userData:getMax_hp())
            self:updateAvatarHp()
            if updateCallback then
                updateCallback()
            end
        end)
    )
    self._nodeRole:stopAllActions()
    self._nodeRole:runAction(seq)
end

function GuildCrossWarAvatar:getCurState()
    return self._userData:getCurrState()
end

-- @Role    Set ModelVisible
function GuildCrossWarAvatar:setAvatarModelVisible(visible)
    visible = visible == nil and false
    --self:setVisible(visible)
end

function GuildCrossWarAvatar:showSword(bVisible)
    if not self._swordEffect then 
		self:_createSwordEffect()
	end
    self._swordPanel:setVisible(bVisible)
    self._swordEffect:setVisible(bVisible)
end

-- @Role    Reborn Action
function GuildCrossWarAvatar:_playAvatarBornEffect()
    local function effectFunction(effect)
		local EffectGfxNode = require("app.effect.EffectGfxNode")
		if effect == "effect_zm_boom" then
			local subEffect = EffectGfxNode.new("effect_zm_boom")
            subEffect:play()
			return subEffect
		end
    end
    local function eventFunction(event)
		if event == "finish" then
        elseif event == "hero" then
        end
    end
    G_EffectGfxMgr:createPlayMovingGfx(self._nodeRebornEffect, "moving_wuchabiebuzhen_wujiang", effectFunction, eventFunction , false)
end

-- @Role    Move and Attack
function GuildCrossWarAvatar:playAttackAction(attackBack)
    -- body
    local bExistBoss, bossUnit = self:_isExistBossUnit()
    if not bExistBoss then
        return
    end

    local bossCfg = bossUnit:getConfig()
    local targetPos = GuildCrossWarHelper.getWarMapGridCenter(bossCfg.boss_place)--cc.p(bossCfg.boss_x, bossCfg.boss_y)
    local startPos  = self._userData:getCurrPointKeyPos()

    local distance  = cc.pGetDistance(cc.p(startPos.x, startPos.y), cc.p(targetPos.x, targetPos.y))
    local moveTime  = (distance / GuildCrossWarConst.AVATAR_MOVING_RATE)
    local newTargetPos = cc.pGoldenPoint(startPos, targetPos, GuildCrossWarConst.BOSS_AVATAR_DISTANCE)
    local coolingTime = tonumber(GuildCrossWarHelper.getParameterContent(G_ParameterIDConst.GUILDCROSS_ATTACK_COOLINGTIME))
    coolingTime = (coolingTime - 0.5)


    local function rotateCallback(oldPos, newPos)
        local avatarNode = self._commonHeroAvatar
        if avatarNode then
            if math.floor(math.abs(newPos.x - oldPos.x)) <= 1 then
                avatarNode:turnBack(newPos.x < newPos.x)
            else
                avatarNode:turnBack(newPos.x < oldPos.x)
            end
            self._commonHeroAvatar:setAction("run", true)
        end
    end

    self._moving = true
    self._nodeRebornEffect:removeAllChildren()
    self._nodeRole:stopAllActions()
    local action = cc.Spawn:create(
        cc.CallFunc:create(function()
            rotateCallback(startPos, newTargetPos) 
        end),
        cc.Sequence:create(
            cc.MoveBy:create(moveTime, cc.pSub(newTargetPos, startPos)),
            cc.CallFunc:create(function()
                self._commonHeroAvatar:setAction("skill1", false)
            end),
            cc.DelayTime:create(0.5),
            cc.CallFunc:create(function()
                if attackBack then
                    attackBack()
                end
            end),
            cc.FadeOut:create(0.2),
            cc.MoveBy:create(0.1, cc.pSub(startPos, newTargetPos)),
            cc.DelayTime:create(0.3),
            cc.CallFunc:create(handler(self, self._playAvatarBornEffect)),
            cc.CallFunc:create(function()
                self._moving = false
                self._commonHeroAvatar:setAction("idle", true)
            end),
            cc.FadeIn:create(0.1)
        )
    )
    self._nodeRole:runAction(action)
end

function GuildCrossWarAvatar:checkMoving()
    return self._moving
end

function GuildCrossWarAvatar:setMoving(isMoving)
    self._moving = isMoving
end

-- @Role    AvatarModel Visible
function GuildCrossWarAvatar:isAvatarModelVisible()
    return self:isVisible()
end

-- @Role    Return Cur's Point
function GuildCrossWarAvatar:getCurPointId()
    return self._curPointId
end

-- @Role    Init Position
function GuildCrossWarAvatar:_synPosition()
    self:_updateUnitData()
    local selfPosX, selfPosY = self:getPosition()
    local gridId = GuildCrossWarHelper.getGridIdByPosition(selfPosX, selfPosY)
    if rawequal(gridId, self._userData:getCurPointHole().pos) then
        return
    end

    local currPos = self._userData:getCurrPointKeyPos()
    if currPos then
        self:setPosition(currPos)
	end
end

-- @Role    UpdateUI
function GuildCrossWarAvatar:updateUI(action)
    self:_updateAvatar()
    self:_updateBaseUI()
    self:updateAvatarHp()
    self:_updatePosition(action)
end

-- @Role    Is Self
function GuildCrossWarAvatar:isSelf()
    return self._userData:isSelf()
end

function GuildCrossWarAvatar:isSelfGuild()
    return self._userData:isSelfGuild()
end

function GuildCrossWarAvatar:getUserId()
    return self._userData:getUid()
end

function GuildCrossWarAvatar:getCurGrid()
    return self._userData:getCurGrid()
end

-- @Role    Update Position
function GuildCrossWarAvatar:_updatePosition(actionType)
    if not self:_isExistAvatar() or not self:isVisible() then
        return
    end

    local currPos = self._userData:getCurrPointKeyPos()
    if currPos then
        self:setPosition(currPos)
    end
end

-- @Role    Isn't Nil Boss
function GuildCrossWarAvatar:_isExistBossUnit()
    if not self:_isExistAvatar() then
        return false, nil
    end

    self._curPointId = self._userData:getCurPointId()
    local bossUnit = G_UserData:getGuildCrossWar():getBossUnitById(self._curPointId)
    if bossUnit == nil then
        return false, nil
    end
    return true, bossUnit
end

-- @Role    Isn't Nil Avatar
function GuildCrossWarAvatar:_isExistAvatar()
    if self._userData == nil or type(self._userData) ~= "table" then
        return false
    end
    return true
end

-- @Role    Update Avatar
function GuildCrossWarAvatar:_updateAvatar()
    if not self:_isExistAvatar() or not self:isVisible() then
        return
    end

    local unitId = self._unitId
    if unitId then
        self:_updateUnitData()
        local baseId, userTable = UserDataHelper.convertAvatarId(self._userData)
        self._commonHeroAvatar:updateAvatar(userTable)
    end
end

-- @Role    Update BaseInfo
function GuildCrossWarAvatar:_updateBaseUI()
    if not self:_isExistAvatar() or not self:isVisible() then
        return
    end
    
    self:_updateTitle()
    self._avatarName:setString(self._userData:getName())
    self._avatarGuild:setString(self._userData:getGuild_name())
    local guildColor = GuildCrossWarHelper.getPlayerColor(self._userData:getUid())
    self._avatarGuild:setColor(guildColor)
    self._avatarName:setColor(guildColor)
end

function GuildCrossWarAvatar:updateAvatarHp()
    self:_updateUnitData()
    local percent = string.format("%.2f", (100 * self._userData:getHp() / self._userData:getMax_hp()))

    if self._userData:getHp() > 0 then
        self._percentText:setString(self._userData:getHp())
    else
        self._percentText:setString(" ")
    end
    self._monsterBlood:setPercent(tonumber(percent))
end

-- @Role    Update Title(Horor)
function GuildCrossWarAvatar:_updateTitle()
    local resource = GuildCrossWarHelper.getGameTile(self._userData:getTitle())
    if resource == nil then
        self._avatarTitle:setVisible(false)        
    else
        self._avatarTitle:setVisible(true)
        self._avatarTitle:loadTexture(resource)
    end
end

-- @Role    Update _userData
function GuildCrossWarAvatar:_updateUnitData()
    if self._unitId then
        local unitData = G_UserData:getGuildCrossWar():getUnitById(self._unitId)
        self._userData = unitData
    end
end

--------------------------------------------------------------------------------
-- @Role    相机移动路径
function GuildCrossWarAvatar:_getAllPath()
    local selfPosX, selfPosY = self:getPosition()
    local finalPath = self._userData:getMovingPath(selfPosX, selfPosY)
    if type(finalPath) == "number" then
        return {}
    end

    local path = clone(finalPath)
    --[[table.remove(path, #path) --- 人机分离
    local _, finalPos = GuildCrossWarHelper.getCurPointRect(self._userData:getCurPointId())
    local targetPath = GuildCrossWarHelper.getLastPath(path[#path].curLine[2], finalPos) 
    table.insert(path, targetPath)]]
    return path
end

-- @Role    PathFinding
function GuildCrossWarAvatar:moving(cameraFollow, callback)
    self._moving = true
    self._userData:setReachEdge(false)
    self._userData:setMoving(true)
    self._cameraFollow = cameraFollow or nil
    self._lastPathCallBack = callback or nil
    self._commonHeroAvatar:setAction("run", true)
    self:_doMoveAvatar()
end

-- @Role    Moving
function GuildCrossWarAvatar:_doMoveAvatar()
    self:_updateUnitData()
    local selfPosX, selfPosY = self:getPosition()
    local finalPath = self._userData:getMovingPath(selfPosX, selfPosY)
    local cameraPath = self._userData:getCameraPath()
    if type(finalPath) == "number" then
        return
    end

    local curveLine = {}
    self._movePathList = finalPath
    if self._cameraFollow then
        self._cameraFollow(cameraPath)
    end
    self:_loopMoveAvatar()
end

-- @Role    
function GuildCrossWarAvatar:_loopMoveAvatar()
    if self._movePathList and #self._movePathList > 0 then
        local path = self._movePathList[1]
        self:_moveAvatar(path)
        table.remove(self._movePathList, 1)
    else
        self._commonHeroAvatar:setAction("idle", true)
        self._userData:setReachEdge(true)
        self._userData:setMoving(false)
        self._moving = false

        if self._lastPathCallBack then
            self._lastPathCallBack()--self._userData:getCurPointId())
        end
        -- Gp home and return blood
        if GuildCrossWarHelper.isOriPoint(self._userData:getCurPointId()) then
            self._userData:setHp(self._userData:getMax_hp())
            self:updateAvatarHp()
        end
    end
end

-- @Role    Moving
function GuildCrossWarAvatar:_moveAvatar(path)
    -- body
    local curveConfigList = path.curLine
    local totalTime = (path.totalTime * 1000)
    local endTime = (G_ServerTime:getMSTime() + path.totalTime * 1000)
    
    local function movingEnd(...)
        self:_loopMoveAvatar()
    end
    
    local function rotateCallback(angle, oldPos, newPos)
        local avatarNode = self._commonHeroAvatar
        if avatarNode then
            if math.floor(math.abs(newPos.x - oldPos.x)) <= 1 then
                avatarNode:turnBack(newPos.x < newPos.x)
            else
                avatarNode:turnBack(newPos.x < oldPos.x)
            end
        end
        local posY = self:getPositionY()
        self:setLocalZOrder(GuildCrossWarConst.UNIT_ZORDER - posY)
    end
    
    local function moveCallback(newPos, oldPos)
        self:setPosition(newPos)
    end
    
    CurveHelper.doCurveMove(self,
        movingEnd,
        rotateCallback,
        moveCallback,
        curveConfigList,
        totalTime,
        endTime)
end


--是否在可见状态（暂无用）
function GuildCrossWarAvatar:isStateVisible(...)
    local serverState = self._userData:getCurrState()
    if serverState == GuildCrossWarConst.UNIT_STATE_MOVING then
        return true
    end
    if serverState == GuildCrossWarConst.UNIT_STATE_IDLE then
        return true
    end
    return false
end

-- @Role    Syn ServerState
function GuildCrossWarAvatar:synServerPos()
    if not self:isVisible() then
        return
    end
    self:_synPosition()
    self._commonHeroAvatar:setAction("idle", true)
end


return GuildCrossWarAvatar
