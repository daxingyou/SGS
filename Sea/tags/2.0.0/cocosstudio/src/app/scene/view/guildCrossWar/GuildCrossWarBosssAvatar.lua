-- @Author  panhoa
-- @Date    2.18.2019
-- @Role    Monster

local ViewBase = require("app.ui.ViewBase")
local GuildCrossWarBosssAvatar = class("GuildCrossWarBosssAvatar", ViewBase)
local StateMachine = require("app.utils.StateMachine")
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local GuildCrossWarHelper = require("app.scene.view.guildCrossWar.GuildCrossWarHelper")


function GuildCrossWarBosssAvatar:ctor(pointId)
    self._commonBossAvatar = nil
    self._bossName         = nil
    self._touchPanel       = nil
    self._monsterBlood     = nil
    self._percentText      = nil

    self._pointId = pointId     -- 据点Id

    -- body
    local resource = {
        file = Path.getCSB("GuildCrossWarBosssAvatar", "guildCrossWar"),
    }
    GuildCrossWarBosssAvatar.super.ctor(self, resource)
end

function GuildCrossWarBosssAvatar:onCreate()
    self._nodeEffect:setVisible(false)
    self._touchPanel:setVisible(false)
    self._touchPanel:addClickEventListenerEx(handler(self, self.onClickBoss))
end

function GuildCrossWarBosssAvatar:onEnter()
end

function GuildCrossWarBosssAvatar:onExit()
end

function GuildCrossWarBosssAvatar:onClickBoss(sender)
    local bExistBoss, bossUnit = self:_isExistBoss()
    if not bExistBoss then
        return
    end

    local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if selfUnit == nil or selfUnit:getCurrPointKeyPos() == nil then
        return
    end

    local selfPointHole = selfUnit:getCurPointHole()
    local bossGridData  = GuildCrossWarHelper.getWarMapCfg(bossUnit:getConfig().boss_place)
    if GuildCrossWarHelper.checkCanMovedPoint(selfPointHole, bossGridData) then
        G_UserData:getGuildCrossWar():c2sBrawlGuildsFight(0)
    end
end

function GuildCrossWarBosssAvatar:getCurState()
    local bExistBoss, curBossUnit = self:_isExistBoss()
    if not bExistBoss then
        return GuildCrossWarConst.BOSS_STATE_DEATH
    end

    local bossState, __ = curBossUnit:getCurState()
    return bossState
end

-- @Role    Exist Boss
function GuildCrossWarBosssAvatar:_isExistBoss()
    local bossMap = G_UserData:getGuildCrossWar():getBossMap()
    dump(bossMap)
    if type(bossMap) ~= "table" then
        return false, nil
    end

    local curBossUnit = bossMap[self._pointId]
    if curBossUnit == nil or curBossUnit:getConfig().boss_res == nil then
        return false, nil
    end

    if curBossUnit:getConfig().boss_res <= 0 then 
        return false, nil
    end
    return true, curBossUnit
end

-- @Role    Update BaseInfo
function GuildCrossWarBosssAvatar:_updateBase()
    local bExistBoss, curBossUnit = self:_isExistBoss()
    if not bExistBoss then
        return
    end
    
    local data = curBossUnit:getConfig()
    self._commonBossAvatar:setBaseId(data.boss_res)
    self._commonBossAvatar:setAsset(data.boss_res)
    self._commonBossAvatar:setAction("idle", true)
    self._commonBossAvatar:setLocalZOrder(0)
    self._commonBossAvatar:setScale(0.7)

    self._bossName:setString(""..data.name)
    self._bossName:setColor(Colors.getColor(data.color))
    self._bossName:enableOutline(Colors.getColorOutline(data.color), 2)
    self:setPosition(GuildCrossWarHelper.getWarMapGridCenter(data.boss_place))
    self._nodeAvatarInfo:setPosition(GuildCrossWarConst.BOSS_AVATAR_INFO_POS)
end

-- @Role    Update Boss's HP
function GuildCrossWarBosssAvatar:_updateHP()
    local bExistBoss, curBossUnit = self:_isExistBoss()
    if not bExistBoss then
        return
    end

    if curBossUnit == nil or curBossUnit:getMax_hp() == 0 then
        self:_playDieAction()
        return
    end

    local percent = string.format("%.2f", (100 * curBossUnit:getHp() / curBossUnit:getMax_hp()))
    if curBossUnit:getHp() > 0 then
        self._touchPanel:setVisible(true)
        self._percentText:setString(percent.."%")
    else
        self._percentText:setString(" ")
        self:setVisible(false)
    end
    self._monsterBlood:setPercent(tonumber(percent))
end

-- @Role    Update Boss's label && effect
function GuildCrossWarBosssAvatar:_updateState()
    local bExistBoss, curBossUnit = self:_isExistBoss()
    if not bExistBoss then
        return
    end

    local bossState, stateStr = curBossUnit:getCurState()
    self._bossState:setString(stateStr)
    local bAttacking = (GuildCrossWarConst.BOSS_STATE_PK == bossState)
    self:_playAttackEffect(bAttacking)
    self:_playAttackAction(bAttacking)
end

-- @Role    UpdateBoss
function GuildCrossWarBosssAvatar:updateUI()
    local bExistBoss, __ = self:_isExistBoss()
    if not bExistBoss then
        return
    end 

    self:_updateBase()
    self:_updateState()
    self:_updateHP()
end

-- @Role    Set ModelVisible
function GuildCrossWarBosssAvatar:setAvatarModelVisible(visible)
    visible = visible == nil and false
    --self:setVisible(visible)
end

-- @Role    AvatarModel Visible
function GuildCrossWarBosssAvatar:isAvatarModelVisible()
    return self:isVisible()
end

function GuildCrossWarBosssAvatar:_playDieAction()
    local function playBossDieAction()
        self._commonBossAvatar:setAction("die", false)
    end

    local function dieFinishCallBack()
        self:setVisible(false)
        G_UserData:getGuildCrossWar():setBossUnitById(self._pointId)
    end

    self._nodeRole:stopAllActions()
    self:stopAllActions()
    self._nodeRole:runAction(cc.Sequence:create(
        cc.CallFunc:create(playBossDieAction),
        cc.FadeOut:create(0.2),
        cc.CallFunc:create(dieFinishCallBack)
    ))
end

-- @Role    Boss AttackEffect
function GuildCrossWarBosssAvatar:_playAttackEffect(bAttacking)
    if bAttacking then
        self._nodeEffect:setVisible(true)
        self._nodeEffect:removeAllChildren()
        G_EffectGfxMgr:createPlayGfx(self._nodeEffect, "effect_xianqinhuangling_shuangjian", nil, true)
    else
        self._nodeEffect:setVisible(false)        
    end
end

-- @Role    Boss Action
function GuildCrossWarBosssAvatar:_playAttackAction(bAttacking)
    local bExistBoss, curBossUnit = self:_isExistBoss()
    if not bExistBoss then
        return
    end

    if not bAttacking then
        return
    end

    local seq = cc.Sequence:create(
        cc.DelayTime:create(0.8),
        cc.CallFunc:create(function()
            local dirIndex = math.random(1, 2)
            local dir = 1.0
            if dirIndex == 2 then
                dir = -1.0
            end
            self._commonBossAvatar:setAction("skill1", false)
            self._commonBossAvatar:setScaleX(dir)
        end),
        cc.DelayTime:create(1.8),
        cc.CallFunc:create(function()
            self._commonBossAvatar:setAction("idle", true)
        end),
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
        end)
    )
    local rep = cc.RepeatForever:create(seq)
    self:stopAllActions()
    self:runAction(rep)
end



return GuildCrossWarBosssAvatar