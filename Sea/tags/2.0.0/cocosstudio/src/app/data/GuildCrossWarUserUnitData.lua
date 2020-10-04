-- Author: hedili
-- Date:2018-12-05 10:16:30
-- Describle：跨服军团战, 战斗单位

local BaseData = require("app.data.BaseData")
local GuildCrossWarUserUnitData = class("GuildCrossWarUserUnitData", BaseData)
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local GuildCrossWarHelper = require("app.scene.view.guildCrossWar.GuildCrossWarHelper")
local schema = {}


schema["uid"]           = {"number", 0}     --玩家id
schema["sid"]           = {"number", 0}     --玩家服务器id
schema["sname"]         = {"string", ""}    --服务器名称
schema["name"]          = {"string", ""}    --玩家昵称
schema["base_id"]       = {"number", 0}     --主角id
schema["avatar_base_id"]= {"number", 0}     --变身卡id
schema["guild_id"]      = {"number", 0}     --军团Id
schema["guild_name"]    = {"string", ""}    --军团名称
schema["officer_level"] = {"number", 0}     --官衔
schema["title"]         = {"number", 0}     --称号title
schema["hp"]            = {"number", 0}     --体力
schema["max_hp"]        = {"number", 0}     --最大体力
schema["power"]         = {"number", 0}     --战力

schema["action"]        = {"number", 0}     --0-移动据点 1-复活返回初始点 2-血量更新
schema["move_end_time"] = {"number", 0}     --移动结束时间
schema["need_time"]     = {"number", 0}     --移动所需时间
schema["move_cd"]       = {"number", 0}     --移动cd
schema["fight_cd"]      = {"number", 0}     --挑战cd
schema["revive_time"]   = {"number", 0}     --复活时间
schema["from_pos"]      = {"table", {}}     --起点（key_point_id据点、pos坑点）
schema["to_pos"]        = {"table", {}}     --终点（key_point_id据点、pos坑点）


GuildCrossWarUserUnitData.schema = schema
function GuildCrossWarUserUnitData:ctor(properties)
    self._isReachEdge = false   -- 终点边缘
    self._isMoving    = false   -- 移动中
    GuildCrossWarUserUnitData.super.ctor(self, properties)
end

function GuildCrossWarUserUnitData:clear()
end

function GuildCrossWarUserUnitData:reset()
end

-- @Role    Update Obj
function GuildCrossWarUserUnitData:updateData(data)
    self:setProperties(data)
    self:updatePosition(data)
    self:setMaxHp()
end

function GuildCrossWarUserUnitData:updatePosition(data)
    if rawget(data, "key_point_id") == nil then
        return
    end

    if rawget(data, "pos") ~= nil and rawget(data, "pos") ~= 0 then
        self:setTo_pos({key_point_id = data.key_point_id, pos = data.pos})
        return
    end

    local holeMap = G_UserData:getGuildCrossWar():getWarPointMap()
    local holeKeys= table.keys(holeMap[data.key_point_id])

    local pos = math.random(1, #holeKeys)
    self:setTo_pos({key_point_id = data.key_point_id, pos = holeKeys[pos]})
end

function GuildCrossWarUserUnitData:setMaxHp()
    local GuildCrossWarHelper = require("app.scene.view.guildCrossWar.GuildCrossWarHelper")
    local maxHp = tonumber(GuildCrossWarHelper.getParameterContent(G_ParameterIDConst.GUILDCROSS_USER_MAXHP))
    self:setMax_hp(maxHp)
end

-- @Role    Cur's Point
function GuildCrossWarUserUnitData:getCurPointId()
    return self:getTo_pos().key_point_id
end

-- @Role    Cur's hole
function GuildCrossWarUserUnitData:getCurPointHole()
    return self:getTo_pos()
end

-- @Role    Cur's Grid
function GuildCrossWarUserUnitData:getCurGrid()
    return self:getTo_pos().pos
end

-- @Role    Get Target's Pos
function GuildCrossWarUserUnitData:getCurrPointKeyPos()
    local curState = self:getCurrState()
    if curState == GuildCrossWarConst.UNIT_STATE_MOVING then
        return GuildCrossWarHelper.getOffsetPointRange(self:getFrom_pos().pos)
    else
        return GuildCrossWarHelper.getOffsetPointRange(self:getTo_pos().pos)
    end
	return nil
end

-- @Role    Get User's State
function GuildCrossWarUserUnitData:getCurrState()
    -- body
    --dump(self:getRevive_time())
    --dump(G_ServerTime:getLeftSeconds(self:getRevive_time()))
	local reviveTime = self:getRevive_time() > 0 and G_ServerTime:getLeftSeconds(self:getRevive_time()) or 0
	if reviveTime > 0 then      -- 4. 死亡态
		return GuildCrossWarConst.UNIT_STATE_DEATH
	end

    --dump(G_ServerTime:getMSTime())
    --dump(G_ServerTime:getTime())
    --dump(self:getMove_end_time())
    --dump(G_ServerTime:getLeftSeconds(self:getMove_end_time()))
    local movingEnd = self:getMove_end_time() > 0 and G_ServerTime:getLeftSeconds(self:getMove_end_time()) or 0
    --dump(movingEnd)
	if movingEnd > 0 then       -- 1. 移动态
		return GuildCrossWarConst.UNIT_STATE_MOVING
    end

    --dump(self:getMove_cd())
    --dump(G_ServerTime:getLeftSeconds(self:getMove_cd()))
	local cdLeftTime = self:getMove_cd() > 0 and G_ServerTime:getLeftSeconds(self:getMove_cd()) or 0
	if cdLeftTime > 0 then      -- 2. CD态
		return GuildCrossWarConst.UNIT_STATE_CD
	end
                                
	return GuildCrossWarConst.UNIT_STATE_IDLE   -- 0. 等待态
end

function GuildCrossWarUserUnitData:getNeedTime(target)
    -- body
    local fromPos = self:getTo_pos()
    local targetPos = target
    if table.nums(fromPos) ~= 2 and type(targetPos) ~= "number" then
        return {}
    end

    local movingLine = GuildCrossWarHelper.getMovingLine(fromPos.pos, targetPos)
    local totalTime = 0
    for index, value in ipairs(movingLine) do
        if index > 1 then
            local point1 = movingLine[index-1]
            local point2 = movingLine[index]
            local time = cc.pGetDistance(point1, point2) or 0
            totalTime = (totalTime + time)
        end    
    end
    
    --dump(totalTime)
    totalTime = tonumber(string.format("%.2f", (totalTime / GuildCrossWarConst.AVATAR_MOVING_RATE)))
    return math.ceil(totalTime)
end

-- @Role    Get Camera's MovingPath
function GuildCrossWarUserUnitData:getCameraPath()   
	local fromPos = self:getFrom_pos()
	local targetPos = self:getTo_pos()
    if table.nums(fromPos) ~= 2 and table.nums(targetPos) ~= 2 then
        return {}
    end
    
    local line = {}
    local srcPos = GuildCrossWarHelper.getWarMapGridCenter(fromPos.pos)
    local destPos = GuildCrossWarHelper.getWarMapGridCenter(targetPos.pos)
    table.insert(line, srcPos)
    table.insert(line, destPos)

    local moveData = {}
    local distance = cc.pGetDistance(srcPos, destPos)
    local lineData = {
        curLine = line,
        totalTime = tonumber(string.format("%.2f", (distance / GuildCrossWarConst.AVATAR_MOVING_RATE))),
        endTime = self:getMove_end_time()
    }
    table.insert(moveData, lineData)
    return moveData
end

-- @Role    Get MovingPath
function GuildCrossWarUserUnitData:getMovingPath(selfX, selfY)
    -- body    
	local fromPos = self:getFrom_pos()
	local targetPos = self:getTo_pos()
    --dump(fromPos)
    --dump(targetPos)
    if table.nums(fromPos) ~= 2 and table.nums(targetPos) ~= 2 then
        return {}
    end
    
	local movingLine = GuildCrossWarHelper.getMovingLine(fromPos.pos, targetPos.pos)
    if movingLine and #movingLine > 0 then
        movingLine[1] = cc.p(selfX,selfY)
        
        local moveData = {}
        for index, value in ipairs(movingLine) do
            if index > 1 then
                local line = {}
                local lineData = {}
                local point1 = movingLine[index-1]
                local point2 = movingLine[index]
                table.insert(line, point1)
                table.insert(line, point2)
                local distance = cc.pGetDistance(point1, point2)
                lineData = {
                    curLine = line,
                    totalTime = tonumber(string.format("%.2f", (distance / GuildCrossWarConst.AVATAR_MOVING_RATE))),
                    endTime = self:getMove_end_time()
                }
                table.insert(moveData, lineData)
            end    
        end
		return moveData
	end
	return {}
end

-- @Role   Check Moving
function GuildCrossWarUserUnitData:checkCanMoving(gridData)
    if type(gridData) ~= "table" then
        return false
    end

    if rawequal(gridData.is_move, 0) then
        return false
    end

    if not GuildCrossWarHelper.checkCanMovedPoint(self:getTo_pos(), gridData) then
        return false
    end

    local curPointId = self:getCurPointId()
    local bossUnit = G_UserData:getGuildCrossWar():getBossUnitById(curPointId)
    if bossUnit == nil then
        dump(self:getCurrState())
        return self:getCurrState() == GuildCrossWarConst.UNIT_STATE_IDLE
    end

    print("GuildCrossWarUserUnitData:checkCanMoving 555")
    local bossState, __ = bossUnit:getCurState()
    dump(bossState)
    if bossState ~= GuildCrossWarConst.BOSS_STATE_DEATH then
        print("GuildCrossWarUserUnitData:checkCanMoving 555 1")
        dump(gridData.point_y)
        if gridData.point_y ~= 0 then
            return true
        end
        return false
    end

    return true
end

-- @Role    Is Self
function GuildCrossWarUserUnitData:isSelf()
	return self:getUid() == G_UserData:getBase():getId()
end

--  @Role   Is Self's Guild
function GuildCrossWarUserUnitData:isSelfGuild()
    return self:getGuild_id() == G_UserData:getGuild():getMyGuildId()
end

-- @Role    is GuildLeader
function GuildCrossWarUserUnitData:isGuildLeader()
    local guildData = G_UserData:getGuild():getMyGuild()
    if guildData == nil then
        return false
    end
    local leaderId = guildData:getLeader()
    if leaderId == 0 or leaderId == nil then
        return false
    end 
    return self:getUid() == guildData:getLeader()
end

-- @Role    Is Moving Edge
function GuildCrossWarUserUnitData:setReachEdge(bReach)
    self._isReachEdge = bReach
end

-- @Role    Is Moving Edge
function GuildCrossWarUserUnitData:isReachEdge()
    return self._isReachEdge
end

-- @Role    Is Moving
function GuildCrossWarUserUnitData:setMoving(bMoving)
    self._isMoving = bMoving
end

-- @Role    Is Moving
function GuildCrossWarUserUnitData:isMoving()
    return self._isMoving
end


return GuildCrossWarUserUnitData
