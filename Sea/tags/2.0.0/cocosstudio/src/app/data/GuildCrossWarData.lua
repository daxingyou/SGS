-- Author: hedili
-- Date:2018-12-05 10:16:30
-- Describle：跨服军团战
local BaseData = require("app.data.BaseData")
local GuildCrossWarData = class("GuildCrossWarData", BaseData)
local GuildCrossWarUserUnitData = require("app.data.GuildCrossWarUserUnitData")
local GuildCrossWarPointUnitData = require("app.data.GuildCrossWarPointUnitData")
local GuildCrossWarBossUnitData = require("app.data.GuildCrossWarBossUnitData")
local GuildCrossWarHelper = require("app.scene.view.guildCrossWar.GuildCrossWarHelper")
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")


local schema = {}
GuildCrossWarData.schema = schema
schema["pointMap"]  = {"table", {}}     -- 据点表
schema["userMap"]   = {"table", {}}     -- 玩家表
schema["bossMap"]   = {"table", {}}     -- Boss表
schema["pointHoleMap"]   = {"table", {}}-- 坑位玩家表


function GuildCrossWarData:ctor(properties)
    GuildCrossWarData.super.ctor(self, properties)
    self._oriPoinId = 0     -- 原始据点
    self._atcktarget= 0
    self._warKeyMap = {}    -- 跨服战据点id
    self._warHoleMap = {}    -- 坑位ID

    self._warPointMap= {}    -- 据点坑位
    self:_initWarPointCfg()
    self:_initWarHioleCfg()
    self:_initWarMapCfg()

    self._warHoleList = {}  -- Test
    self:_initWarHoleList()

    self._msgGuildCrossWarEnter       = G_NetworkManager:add(MessageIDConst.ID_S2C_BrawlGuildsEntry, handler(self, self._s2cGuildCrossWarEnter))               -- 入口
    self._msgGuildCrossUpdatePlayer   = G_NetworkManager:add(MessageIDConst.ID_S2C_BrawlGuildsUpdatePlayer, handler(self, self._s2cGuildCrossUpdatePlayer))    -- 服务器推送玩家移动
    self._msgGuildCrossUpdateKeyPoint = G_NetworkManager:add(MessageIDConst.ID_S2C_BrawlGuildsUpdateKeyPoint, handler(self, self._s2cGuildCrossUpdateKeyPoint))-- 服务器推送玩家移动
    self._msgGuildCrossMove           = G_NetworkManager:add(MessageIDConst.ID_S2C_BrawlGuildsMove, handler(self, self._s2cGuildCrossMove))                    -- 回收移动信息
    self._msgGuildCrossFight          = G_NetworkManager:add(MessageIDConst.ID_S2C_BrawlGuildsFight, handler(self, self._s2cBrawlGuildsFight))                 -- 战斗
    self._msgGuildCrossFightNotice    = G_NetworkManager:add(MessageIDConst.ID_S2C_BrawlGuildsFightNotice, handler(self, self._s2cBrawlGuildsFightNotice))     -- 据点其他玩家打Boss推送
    self._msgGuildCrossFollowMe       = G_NetworkManager:add(MessageIDConst.ID_S2C_BrawlGuildsFollowMe, handler(self, self._s2cBrawlGuildsFollowMe))           -- 军团长指令
    self._msgGuildCrossLadder         = G_NetworkManager:add(MessageIDConst.ID_S2C_BrawlGuildsLadder, handler(self, self._s2cBrawlGuildsLadder))               -- 军团成员排行
    self._signalAllDataReady          = G_SignalManager:add(SignalConst.EVENT_RECV_FLUSH_DATA, handler(self, self._onAllDataReady))
end

function GuildCrossWarData:clear()
    self._msgGuildCrossWarEnter:remove()
    self._msgGuildCrossWarEnter = nil
    self._msgGuildCrossUpdatePlayer:remove()
    self._msgGuildCrossUpdatePlayer = nil
    self._msgGuildCrossUpdateKeyPoint:remove()
    self._msgGuildCrossUpdateKeyPoint = nil
    self._msgGuildCrossMove:remove()
    self._msgGuildCrossMove = nil
    self._msgGuildCrossFight:remove()
    self._msgGuildCrossFight = nil
    self._msgGuildCrossFightNotice:remove()
    self._msgGuildCrossFightNotice = nil
    self._msgGuildCrossFollowMe:remove()
    self._msgGuildCrossFollowMe = nil
    self._signalAllDataReady:remove()
    self._signalAllDataReady = nil
end

--============================================================
-- 网络消息
-- @Role    跨服军团入口
function GuildCrossWarData:c2sBrawlGuildsEntry()
    G_NetworkManager:send(MessageIDConst.ID_C2S_BrawlGuildsEntry, {})
end

-- @Role    入口消息
function GuildCrossWarData:_s2cGuildCrossWarEnter(id, message)
    self:_updateKeyPoint(message)
    self:_updateUsers(message, GuildCrossWarConst.SELF_ENTER)
    self._oriPoinId = rawget(message, "init_key_point_id") or 0

    G_SignalManager:dispatch(SignalConst.EVENT_GUILDCROSS_WAR_ENTRY)
end

-- @Role    移动同步信息
-- @Param   key_point_id 移动点
function GuildCrossWarData:c2sBrawlGuildsMove(to, needTime)
    G_NetworkManager:send(MessageIDConst.ID_C2S_BrawlGuildsMove, {to = to, need_time = needTime})
end

-- @Role    移动同步信息自己
function GuildCrossWarData:_s2cGuildCrossMove(id, message)
    if rawget(message, "to") == nil then
        return
    end

    self:_updateUsers(message)
    self:_updateKeyPoint(message)
    self:_updateSelfUnit(message, GuildCrossWarConst.SELF_MOVE)
    G_SignalManager:dispatch(SignalConst.EVENT_GUILDCROSS_WAR_SELFMOVE, message.need_time)
end

-- @Role    攻击指令
function GuildCrossWarData:c2sBrawlGuildsFollowMe(atckId)
    G_NetworkManager:send(MessageIDConst.ID_C2S_BrawlGuildsFollowMe, {key_point_id = atckId})
end

-- @Role    攻击指令
function GuildCrossWarData:_s2cBrawlGuildsFollowMe(id, message)
    if rawget(message, "key_point_id") == nil then
        return
    end
    self._atcktarget =  message.key_point_id
end

-- @Role    战斗
-- @Param   target 攻击目标(0/攻击守卫  or  玩家传玩家id)
function GuildCrossWarData:c2sBrawlGuildsFight(target)
    G_NetworkManager:send(MessageIDConst.ID_C2S_BrawlGuildsFight, {target = target})
end

-- @Role    战斗返回信息
function GuildCrossWarData:_s2cBrawlGuildsFight(id, message)
    local selfUnit = self:getSelfUnit()
    if selfUnit ~= nil then
        local curBossUnit = self:getBossUnitById(selfUnit:getCurPointId())
        if not rawget(message, "fight_type") then   -- 1. Boss
            if curBossUnit and rawget(message, "hurt") then
                local hp = (curBossUnit:getHp() - message.hurt)
                local curHp = hp > 0 and hp or 0
                curBossUnit:setHp(curHp)
                G_SignalManager:dispatch(SignalConst.EVENT_GUILDCROSS_WAR_FIGHT, message)
            end
        else                                        -- 2. 玩家
            self:_updateKeyPoint(message)
            self:_updateUsers(message)
            self:_updateSelfUnit(message, GuildCrossWarConst.SELF_FIGHT)
            if rawget(message, "players") ~= nil then       ---- 2.1 玩家：被搞死
                selfUnit:setHp(0)
            elseif rawget(message, "own_hp") ~= nil then    ---- 2.2 玩家：受伤
                local selfHp = (selfUnit:getHp() - message.own_hp)
                selfUnit:setHp(selfHp > 0 and selfHp or 0)
            end

            if rawget(message, "key_point") ~= nil and rawget(message, "players") ~= nil then
                G_SignalManager:dispatch(SignalConst.EVENT_GUILDCROSS_WAR_SELFDIE, message)
            else
                local isKill = rawget(message, "is_kill") or false
                if isKill == true then
                    G_SignalManager:dispatch(SignalConst.EVENT_GUILDCROSS_WAR_OTHERDIE, message)
                else
                    G_SignalManager:dispatch(SignalConst.EVENT_GUILDCROSS_WAR_FIGHT, message)
                end 
            end
        end
    end
end

-- @Role    推送更新玩家移动
function GuildCrossWarData:_s2cGuildCrossUpdatePlayer(id, message)
    local player = rawget(message, "player")
    if player == nil or rawget(player, "uid") == nil then
        return
    end
    if rawget(message, "action") == nil then
        return
    end

    self:_updateUsers(message)
    G_SignalManager:dispatch(SignalConst.EVENT_GUILDCROSS_WAR_UPDATEPLAYER, message)
end

-- @Role    推送更新据点
function GuildCrossWarData:_s2cGuildCrossUpdateKeyPoint(id, message)
    self:_updateKeyPoint(message)
    G_SignalManager:dispatch(SignalConst.EVENT_GUILDCROSS_WAR_UPDATEPOINT)
end

-- @Role    推送其他玩家打Boss
function GuildCrossWarData:_s2cBrawlGuildsFightNotice(id, message)
    if rawget(message, "key_point_id") == nil then
        return
    end

    local curBossUnit = self:getBossUnitById(message.key_point_id)
    if curBossUnit and rawget(message, "hurt") then
        curBossUnit:setHp(curBossUnit:getHp() - message.hurt)
    end
    G_SignalManager:dispatch(SignalConst.EVENT_GUILDCROSS_WAR_OTHER_SEE_BOSSS, message)
end

-- @Role    本军团排行榜
function GuildCrossWarData:c2sBrawlGuildsLadder(type)
    G_NetworkManager:send(MessageIDConst.ID_C2S_BrawlGuildsLadder, {ladder_type = type})
end

-- @Role    本军团排行榜
function GuildCrossWarData:_s2cBrawlGuildsLadder(id, message)
    if message.ret ~= MessageErrorConst.RET_OK then
		return
    end
    G_SignalManager:dispatch(SignalConst.EVENT_GUILDCROSS_WAR_LADDER, message)
end

-- @Role    断线重连
function GuildCrossWarData:_onAllDataReady()
    local bInGuild = false
    local FunctionConst = require("app.const.FunctionConst")
    local FunctionCheck = require("app.utils.logic.FunctionCheck")
    local isOpen = FunctionCheck.funcIsOpened(FunctionConst.FUNC_GUILD_CROSS_WAR)
    if isOpen and GuildCrossWarHelper.isTodayOpen() then
        local state, __ GuildCrossWarHelper.getCurCrossWarStage()
        if state ~= GuildCrossWarConst.ACTIVITY_STAGE_3 then
            bInGuild = GuildCrossWarHelper.isGuildCrossWarEntry()
        end
    end

    if G_UserData:isFlush() and bInGuild then
        self:c2sBrawlGuildsEntry()
    end
end

--------------------------------------------------------------
-- @Role    Update Players
function GuildCrossWarData:_updateUsers(message, stage)
    if self:_createPlayer(message) then --1. Update
        return
    end
    self:_createPlayers(message, stage) --2. Entry/Move/Fight
end

-- @Role 
function GuildCrossWarData:_createUserUnit(data)
    local key = data.uid
    local playerUnit = GuildCrossWarUserUnitData.new()
    playerUnit:updateData(data)
    return key, playerUnit
end

-- @Role    Create Player
function GuildCrossWarData:_createPlayer(message)
    local player = rawget(message, "player")
    if player ~= nil then
        local userMap = self:getUserMap()
        local key, unit = self:_createUserUnit(player)
        if rawget(message, "action") ~= nil then unit:setAction(message.action) end
        if rawget(message, "move_end_time") ~= nil then unit:setMove_end_time(message.move_end_time) end
        if rawget(message, "need_time") ~= nil then
            local endTime = (G_ServerTime:getTime() + message.need_time)
            unit:setMove_end_time(endTime)
        end
        if rawget(message, "revive_time") ~= nil then
            unit:setRevive_time(message.revive_time)
        end
        if rawget(message, "from") ~= nil then
            unit:setFrom_pos(message.from)
        end
        if rawget(message, "to") ~= nil then
            unit:setTo_pos(message.to)
            self:_updatePointHoleMap(message.to.pos, key)
        end
        userMap[key] = unit
        return true
    end
    return false
end

-- @Role    Update PointHole
function GuildCrossWarData:_updatePointHoleMap(grid, uId)
    if type(grid) ~= "number" then
        return nil
    end

    local pointHoleMap = self:getPointHoleMap() or {}
    if not pointHoleMap[grid] then
        pointHoleMap[grid] = {}
    end
    
    for pos, holeMap in pairs(pointHoleMap) do
        if type(holeMap) == "table" then
            for k,value in pairs(holeMap) do
                if rawequal(uId, value) then
                    table.remove(pointHoleMap[pos], k)
                    if table.nums(pointHoleMap[pos]) <= 0 then
                        pointHoleMap[pos] = nil 
                    end
                    break
                end
            end
        end
    end
    
    if not pointHoleMap[grid] then
        pointHoleMap[grid] = {}
    end
    table.insert(pointHoleMap[grid], uId)
end

-- @Role    Create Players
function GuildCrossWarData:_createPlayers(message, state)
    local players = rawget(message, "players")
    if players ~= nil then
        local userMap = self:getUserMap()
        for k,v in pairs(players) do
            v.index = tonumber(k)
            if not GuildCrossWarHelper.isSelf(v.uid) or rawequal(state, GuildCrossWarConst.SELF_ENTER) then
                local key, unit = self:_createUserUnit(v)
                userMap[key] = unit
                self:_updatePointHoleMap(unit:getCurGrid(), key)
            end
        end
    end
end

-- @Role    更新self数据
function GuildCrossWarData:_updateSelfUnit(data, state)
    local unit = self:getSelfUnit()
    if unit == nil then
        return
    end
    
    if rawequal(state, GuildCrossWarConst.SELF_MOVE) then           -- 1. Self Move
        if rawget(data, "move_cd")       ~= nil then
            local cdTime = (data.move_cd)
            unit:setMove_cd(cdTime)
        end
        if rawget(data, "need_time") ~= nil then
            unit:setNeed_time(rawget(data, "need_time"))
            unit:setMove_end_time((G_ServerTime:getTime() + data.need_time))
        end
        if rawget(data, "to") ~= nil then
            local tempToPos = unit:getTo_pos()
            unit:setFrom_pos(tempToPos)
            unit:setTo_pos(rawget(data, "to"))
            self:_updatePointHoleMap(unit:getCurGrid(), unit:getUid())
        end

    elseif rawequal(state, GuildCrossWarConst.SELF_FIGHT) then      -- 2. Self Fight
        if rawget(data, "revive_time")   ~= nil then
            unit:setRevive_time(rawget(data, "revive_time"))
        end    
        if rawget(data, "fight_cd") ~= nil then
            unit:setFight_cd(rawget(data, "fight_cd"))
        end
        if rawget(data, "key_point") ~= nil and rawget(data, "players") ~= nil then
            for k,v in pairs(data.players) do
                if GuildCrossWarHelper.isSelf(v.uid) then
                    local tempToPos = unit:getTo_pos()
                    unit:setFrom_pos(tempToPos)
                    unit:setTo_pos({key_point_id = v.key_point_id, pos = v.pos})
                    self:_updatePointHoleMap(unit:getCurGrid(), unit:getUid())
                    break
                end
            end
        end
    end
    return unit
end

-- @Role    Updata KeyPoint
function GuildCrossWarData:_updateKeyPoint(message)
    -- Create   Point
    local function createPointUnit(data)
        local keyPointUnit = GuildCrossWarPointUnitData.new()
        keyPointUnit:updateData(data)
        return keyPointUnit
    end

    -- Create  Boss
    local function createBossUnit(data)
        local bossUnit = GuildCrossWarBossUnitData.new()
        bossUnit:updateData(data)
        return bossUnit
    end

    local keyPoint = rawget(message, "key_point")
    if keyPoint ~= nil then
        -- Create Point
        if rawget(keyPoint, "key_point_id") == nil then
            return
        end

        local unitData = {
            key_point_id = rawget(keyPoint, "key_point_id"),
            guild_id     = rawget(keyPoint, "guild_id"),
            guild_name   = rawget(keyPoint, "guild_name"),
            sid          = rawget(keyPoint, "sid"),
            sname        = rawget(keyPoint, "sname"),
            action       = rawget(keyPoint, "action")
        }
        local pointMap = self:getPointMap()
        pointMap[keyPoint.key_point_id] = createPointUnit(unitData)

        -- Create Boss
        local bExist, bossCfg = GuildCrossWarHelper.isExistBossInPoint(keyPoint.key_point_id)
        if not bExist then
            return
        end
        local bossData = {
            id      = rawget(keyPoint, "key_point_id"),
            hp      = rawget(keyPoint, "hp"),
            max_hp  = rawget(keyPoint, "max_hp"),
            config  = bossCfg,
        }
        local bossMap = self:getBossMap()
        if not bossMap[keyPoint.key_point_id] then
            bossMap[keyPoint.key_point_id] = createBossUnit(bossData)
        end
    end
end

-- @Role    Get PointData
function GuildCrossWarData:getPointDataById(pointId)
    -- body
    if pointId == nil or type(pointId) ~= "number" then
        return nil
    end

    local pointMap = self:getPointMap()
    if type(pointMap) ~= "table" or next(pointMap) == nil then
        return nil
    end

    if pointMap[pointId] == nil then
        return nil
    end
    return pointMap[pointId]
end

-- @Role    Get Data
function GuildCrossWarData:getBossUnitById(pointId)
    -- body
    if pointId == nil or type(pointId) ~= "number" then
        return nil
    end

    local bossUnitMap = self:getBossMap()
    if type(bossUnitMap) ~= "table" or next(bossUnitMap) == nil then
        return nil
    end

    if bossUnitMap[pointId] == nil then
        return nil
    end
    return bossUnitMap[pointId]
end

-- @Role    
function GuildCrossWarData:setBossUnitById(pointId)
    local bossMap = self:getBossMap()
    bossMap[pointId] = nil
end

-- @Role    Get Cur's Hole Users
function GuildCrossWarData:getCurPointData(pointId)
    if type(pointId) ~= "number" then
        return nil
    end

    local pointHoleMap = self:getPointHoleMap() or nil
    if pointHoleMap == nil or not pointHoleMap[pointId] then
        return nil
    end

    return pointHoleMap[pointId]
end


-- @Role    Get Cur's Hole Users
function GuildCrossWarData:getCurHoleData(pointHole)
    local pointHoleMap = self:getPointHoleMap() or nil
    if pointHoleMap == nil then
        return nil
    end

    if not pointHoleMap[pointHole] then
        return nil
    end

    return pointHoleMap[pointHole]
end

--============================================================
-- @Role    获取据点信息
function GuildCrossWarData:getWarKeyMap()
    return self._warKeyMap
end

-- @Role    获取坑位消息
function GuildCrossWarData:getWarHoleMap()
    return self._warHoleMap
end


-- @Role    获取坑位消息
function GuildCrossWarData:getWarPointMap()
    return self._warPointMap
end

-- @Role   所有格子
function GuildCrossWarData:getWarHoleList()
    return self._warHoleList
end
--------------------------------------------------------------

function GuildCrossWarData:reset()
end

function GuildCrossWarData:_stringToNumber(strList)
    local moveStrList = string.split(strList, "|")
    local retList = {}
    for i, value in ipairs(moveStrList) do
        table.insert(retList, tonumber(value))
    end
    return retList
end

-- @Role    Get Point's Cfg
function GuildCrossWarData:_initWarPointCfg()
    -- body
    local function makeClickRect(cfg)
        local pointKey = cc.p(cfg["map_x"], cfg["map_y"])
        local rangeX = cfg.range_x
        local rangeY = cfg.range_y
        local clickRect = cc.rect(pointKey.x - rangeX * 0.5, pointKey.y - rangeY * 0.5, rangeX, rangeY)
        return clickRect
    end
    local guild_cross_war = require("app.config.guild_cross_war")
    for i = 1, guild_cross_war.length() do
        local indexData = guild_cross_war.indexOf(i)
        local keyData = {
            cfg = indexData,
            keyList = self:_stringToNumber(indexData.move), -- 可到达的据点
            clickRect = makeClickRect(indexData)            -- 据点可点击区域
        }
        self._warKeyMap[indexData.id] = keyData
    end
end

-- TODO::test
function GuildCrossWarData:_initWarHoleList()
    -- body
    local function makeClickRect(cfg)
        local pointKeyX = ((cfg.axis_x - 1) * GuildCrossWarConst.GRID_SIZE + 5)
        local pointKeyY = ((cfg.axis_y - 1) * GuildCrossWarConst.GRID_SIZE + 5)
        local clickRect = cc.rect(pointKeyX, pointKeyY, GuildCrossWarConst.GRID_SIZE - 5, GuildCrossWarConst.GRID_SIZE - 5)
        return clickRect
    end
    local guild_cross_war = require("app.config.guild_cross_war_map")
    for i = 1, guild_cross_war.length() do
        local indexData = guild_cross_war.indexOf(i)
        local data  ={
            clickRect = makeClickRect(indexData),
            isMove = indexData.is_move,
            point = indexData.point_y
        }
        self._warHoleList[indexData.id] = data
    end
end

-- @Role    War Hole Cfg
function GuildCrossWarData:_initWarHioleCfg()
    -- body
    local function makeClickRect(cfg)
        local holeKey = cc.p(cfg["point_x"], cfg["point_y"])
        local range = cfg.point_range
        local clickRect = cc.rect(holeKey.x - range * 0.5, holeKey.y - range * 0.5, range, range)
        return clickRect
    end

    local guild_cross_war_point = require("app.config.guild_cross_war_point")
    for i = 1, guild_cross_war_point.length() do
        local indexData = guild_cross_war_point.indexOf(i)
        local keyData = {
            cfg = indexData,
            centerPoint = cc.p(indexData.point_x, indexData.point_y),
            clickRect = makeClickRect(indexData)            -- 据点可点击区域
        }

        if self._warHoleMap[indexData.point_id] == nil then
            self._warHoleMap[indexData.point_id] = {}
        end
        self._warHoleMap[indexData.point_id][indexData.hole_id] = keyData
    end
end


--------------------------------------------------------------------------
-- @Role    War Map Cfg
function GuildCrossWarData:_initWarMapCfg()
    -- body
    local guild_cross_war_map = require("app.config.guild_cross_war_map")
    for i = 1, guild_cross_war_map.length() do
        local indexData = guild_cross_war_map.indexOf(i)
        if indexData.point_y ~= 0 then
            if self._warPointMap[indexData.point_y] == nil then
                self._warPointMap[indexData.point_y] = {}
            end
            self._warPointMap[indexData.point_y][indexData.id] = indexData
        end
    end
end


--------------------------------------------------------------------------

-- @Role    GetData according to Map buyId
function GuildCrossWarData:getUnitById(userId)
    local userMap = self:getUserMap()
    local unit = userMap[userId]
    if unit then
        return unit
    end
    return nil
end

--根据某个坐标点，找到路径Key点
function GuildCrossWarData:findPointKey(position)
    for key, value in pairs(self._warKeyMap) do
        if value.clickRect ~= nil then
            if cc.rectContainsPoint(value.clickRect, position) then
                return key
            end
        end
    end
    return nil
end

-- @Role    Find Hole
function GuildCrossWarData:findPointHoleKey(position)
    local point = self:findPointKey(position)
    if point == nil then
        return nil
    end

    local pointHole = {key_point_id = point, pos = 1}
    local preDistance = 0
    local holeMap = self._warHoleMap[point]
    for hole, value in pairs(holeMap) do
        if value.clickRect ~= nil then
            if cc.rectContainsPoint(value.clickRect, position) then
                return {key_point_id = point, pos = hole}
            end
        end

        if value.centerPoint ~= nil then
            local positionX, positionY = position.x, position.y
            local curDistance = math.abs(cc.pGetDistance(cc.p(positionX, positionY), value.centerPoint))
            preDistance = preDistance == 0 and curDistance or preDistance
            pointHole = curDistance < preDistance and {key_point_id = point, pos = hole} or pointHole
        end
    end
    return pointHole
end

--获得可点击区域列表（测试用）
function GuildCrossWarData:getClickKeyRectList()
    local retList = {}
    for key, value in pairs(self._warKeyMap) do
        if value.clickRect ~= nil then
            table.insert(retList, value.clickRect)
        end
    end
    return retList
end

-- @Role    Get Self UId
function GuildCrossWarData:getSelfUserId()
    return G_UserData:getBase():getId()
end

-- @Role    Get  Self Unit
function GuildCrossWarData:getSelfUnit()
    local unit = self:getUnitById(self:getSelfUserId())
    if unit then
        return unit
    end
    return nil
end

-- @Role    Get  Self Ori'sPoint
function GuildCrossWarData:getSelfOriPoint()
    return self._oriPoinId
end

-- @Role    Get  Self target
function GuildCrossWarData:setSelfGuildTarget(attackId)
    self._atcktarget = attackId
end
function GuildCrossWarData:getSelfGuildTarget()
    return self._atcktarget
end



return GuildCrossWarData
