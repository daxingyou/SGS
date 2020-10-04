
local GuildCrossWarHelper = {}
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local UIHelper = require("yoka.utils.UIHelper")


--============================================================
-- @Role    获取称号
function GuildCrossWarHelper.getGameTile(titleId)
    local titleInfo = require("app.config.title")
    if titleId >= 1 and titleId < titleInfo.length() then
        return titleInfo.get(titleId).resource
    end
    return nil
end

--配置读取处理（要弃用
function GuildCrossWarHelper._decodeNums(str)
    local strArr = string.split(str, "|")
    local nums = {}
    for k, v in ipairs(strArr) do
        nums[k] = tonumber(v)
    end
    return nums, cc.p(nums[1], nums[2])
end

-- @Role    PointCfg位置信息
-- @Param1  据点
-- @Param2  坑位
--[[function GuildCrossWarHelper.getPointCfg(pointId, pos)
    -- body
    local guild_cross_war_point = require("app.config.guild_cross_war_point")
    for i = 1, guild_cross_war_point.length() do
        local indexData = guild_cross_war_point.indexOf(i)
        if indexData.point_id == pointId and indexData.hole_id == pos then
            return indexData
        end
    end
    assert(false, string.format("can not find guild_cross_war_point cfg by pointId[%d] pos[%d]", pointId, pos))
end]]

-- @Role    RoadCfg路径配置（可弃用
-- @Param1  起始据点
-- @Param2  目标据点
function GuildCrossWarHelper.getRoadCfg(key1, key2)
    local guild_cross_war_road = require("app.config.guild_cross_war_road")
    for i = 1, guild_cross_war_road.length() do
        local indexData = guild_cross_war_road.indexOf(i)
        if indexData.point_1 == key1 and indexData.point_2 == key2 then
            return indexData
        end
    end
    assert(false, string.format("can not find guild_cross_war_road cfg by point_1[%d] point_2[%d]", key1, key2))
end

-- @Role    MapCfg位置信息（新
-- @Param1  据点
function GuildCrossWarHelper.getWarMapCfg(id)
    local guild_cross_war_map = require("app.config.guild_cross_war_map")
    local indexData = guild_cross_war_map.indexOf(id)
    if indexData then
        return indexData
    end
    assert(false, string.format("can not find guild_cross_war_map cfg by Grid[%d]", id))
end

-- @Role    MapCfg位置信息（新
-- @Param1  横坐标
-- @Param2  众坐标
function GuildCrossWarHelper.getWarMapCfgByGrid(gridX, gridY)
    local guild_cross_war_map = require("app.config.guild_cross_war_map")
    for i = 1, guild_cross_war_map.length() do
        local indexData = guild_cross_war_map.indexOf(i)
        if rawequal(gridX, indexData.axis_x) and rawequal(gridY, indexData.axis_y) then 
            return indexData
        end
    end
    assert(false, string.format("can not find guild_cross_war_map cfg by Grid[%d],[%d]", gridX, gridY))
end

-- @Role    格子中心（新
-- @Param1  横坐标
-- @Param2  众坐标
function GuildCrossWarHelper.getWarMapGridCenter(gridId)
    local warMapCfg = GuildCrossWarHelper.getWarMapCfg(gridId)
    if warMapCfg then
        return cc.p((warMapCfg.axis_x - 0.5) * GuildCrossWarConst.GRID_SIZE, 
                    (warMapCfg.axis_y - 0.5) * GuildCrossWarConst.GRID_SIZE)
    end
end

-- @Role    Get GridId by position
function GuildCrossWarHelper.getGridIdByPosition(x, y)
    local gridX = math.ceil((x / GuildCrossWarConst.GRID_SIZE))
    local gridY = math.ceil((y / GuildCrossWarConst.GRID_SIZE))
    local holeCfg = GuildCrossWarHelper.getWarMapCfgByGrid(gridX, gridY)
    return holeCfg.id
end

-- @Role    坑点位置上的随机点（实际位置）
-- @Param1  据点
-- @Param2  坑位
function GuildCrossWarHelper.getOffsetPointRange(holeId)
    local holeData = GuildCrossWarHelper.getWarMapCfg(holeId)
    local holeX = ((holeData.axis_x - 1) * GuildCrossWarConst.GRID_SIZE)
    local holeY = ((holeData.axis_y - 1) * GuildCrossWarConst.GRID_SIZE)
    local holePos = cc.p(holeX, holeY)
    local randomOffsetX = math.random(20, GuildCrossWarConst.GRID_SIZE - 20)
    local randomOffsetY = math.random(20, GuildCrossWarConst.GRID_SIZE - 20)

    local resultPoint = cc.pAdd(holePos, cc.p(randomOffsetX, randomOffsetY))
    return resultPoint
end

-- @Role    根据起始、终点据点获得所有中间路径点
-- @Param1   起始据点
-- @Param2   终点据点
--[[local MAX_MID_SIZE = 5
function GuildCrossWarHelper.getMidPointList(key1, key2)
    local roadData = GuildCrossWarHelper.getRoadCfg(key1, key2)
    local returnTable = {}
    for i = 1, MAX_MID_SIZE do
        local midStr = roadData["mid_point_" .. i]
        if midStr ~= "" then
            local midArray, midPoint = GuildCrossWarHelper._decodeNums(midStr)
            table.insert(returnTable, midPoint)
        end
    end
    return returnTable
end]]

-- @Role    获得移动路径 (（据点+坑点）+ (midp1+ midp2+...) （下一个据点+坑点）
-- @Param1  起始坑位
-- @Param2  终点坑位
function GuildCrossWarHelper.getMovingLine(slot1, slot2)
    local starPos = GuildCrossWarHelper.getOffsetPointRange(slot1)
    local endPos = GuildCrossWarHelper.getOffsetPointRange(slot2)
    local linePointList = {}
    table.insert(linePointList, starPos)
    table.insert(linePointList, endPos)
    return linePointList
end

-- @Role    Get Guild_Cross_War Config
function GuildCrossWarHelper.getWarCfg(point)
    local guild_cross_war = require("app.config.guild_cross_war")
    return guild_cross_war.indexOf(point)
end

--- （可弃用，人机分离时用到
function GuildCrossWarHelper.getLastPath(linearPos, targetPos)
    -- body
    local line = {}
    local path = {}
    table.insert(line, linearPos)
    table.insert(line, targetPos)
    local distance = cc.pGetDistance(linearPos, targetPos)
    path.curLine = line
    path.totalTime = tonumber(string.format("%.2f", (distance / GuildCrossWarConst.AVATAR_MOVING_RATE)))
    return path
end

function GuildCrossWarHelper.getPointCount()
    local guild_cross_war = require("app.config.guild_cross_war")
    return guild_cross_war.length()
end

-- @Role    Get Cur's PointCenter（可弃用，人机分离时用到
function GuildCrossWarHelper.getCurPointRect(point)
    if type(point) ~= "number" then
        return nil
    end

    local warCfg = GuildCrossWarHelper.getWarCfg(point)
    if warCfg == nil then return nil end

    return cc.rect(warCfg.map_x - warCfg.range_x/2, 
                    warCfg.map_y - warCfg.range_y/2,
                    warCfg.range_x, warCfg.range_y),
            cc.p(warCfg.map_x, warCfg.map_y)
end

-- @Role    Can Moveto's point（要弃用
function GuildCrossWarHelper.getAttackPoint(selfPoint)
    local pointData = GuildCrossWarHelper.getWarCfg(selfPoint)
    if pointData == nil then
        return false
    end
    local movePoint = pointData.move

    if pointData.type == 1 then
        return tonumber(movePoint)
    elseif pointData.type == 2 then
        local movePointList = {}
        local points, _ = GuildCrossWarHelper._decodeNums(movePoint)
        for i,v in ipairs(points) do
            table.insert(movePointList, tonumber(v))
        end
        return movePointList
    end
    return nil
end

-- @Role    是否是当前可移动到的点
-- @Param   point 当前点
function GuildCrossWarHelper.checkCanMovedPoint(selfPoint, targetGrid)
    --[[print("GuildCrossWarHelper.checkCanMovedPoint 111")
    dump(selfPoint)
    dump(targetGrid)]]
    if selfPoint == nil or table.nums(selfPoint) < 2 then
        return false
    end

    local oriPoint = G_UserData:getGuildCrossWar():getSelfOriPoint()
    local warMap = GuildCrossWarHelper.getWarMapCfg(selfPoint.pos)

    --[[dump(rawequal(warMap.axis_x, targetGrid.axis_x))
    dump(math.abs(warMap.axis_y - targetGrid.axis_y))
    dump(rawequal(warMap.axis_y, targetGrid.axis_y))
    dump(math.abs(warMap.axis_x - targetGrid.axis_x))]]

    if targetGrid.point_y == 0 then         -- 1. 通道内移动
        if rawequal(warMap.axis_x, targetGrid.axis_x) and math.abs(warMap.axis_y - targetGrid.axis_y) == 1 then
            --print("GuildCrossWarHelper.checkCanMovedPoint 222")
            return true
        elseif rawequal(warMap.axis_y, targetGrid.axis_y) and math.abs(warMap.axis_x - targetGrid.axis_x) == 1 then
            --print("GuildCrossWarHelper.checkCanMovedPoint 333")
            return true
        end
        --print("GuildCrossWarHelper.checkCanMovedPoint 333 1")
        return false
    end

                                            -- 2. 据点内移动
    local targetData = GuildCrossWarHelper.getWarCfg(targetGrid.point_y)
    --[[dump(oriPoint)
    dump(warMap)
    dump(targetData.type)
    dump(targetGrid.point_y)]]
    if rawequal(warMap.axis_x, targetGrid.axis_x) and math.abs(warMap.axis_y - targetGrid.axis_y) == 1 then
        --print("GuildCrossWarHelper.checkCanMovedPoint 444")
        --dump((targetData.type == 1 and targetGrid.point_y ~= oriPoint))
        return not (targetData.type == 1 and targetGrid.point_y ~= oriPoint)
    elseif rawequal(warMap.axis_y, targetGrid.axis_y) and math.abs(warMap.axis_x - targetGrid.axis_x) == 1 then
        --print("GuildCrossWarHelper.checkCanMovedPoint 555")
        return not (targetData.type == 1 and targetGrid.point_y ~= oriPoint)
    end
    return false
end

--------------------------------------------------------------
-- @Role    获取Parameter
function GuildCrossWarHelper.getParameterContent(constId)
    local UserDataHelper = require("app.utils.UserDataHelper")
    return UserDataHelper.getParameter(constId)
end

-- 时间处理
-- @Role    是否今日开启
function GuildCrossWarHelper.isTodayOpen()
    -- body
    local function canOpenToday(day)
        -- body
        local openDay = tonumber(GuildCrossWarHelper.getParameterContent(G_ParameterIDConst.GUILDCROSS_OPEN_WEEK))
        openDay = (openDay + 1)
        openDay = (openDay > 7 and (openDay - 7) or openDay)
        return (openDay == day)
    end

    local date = G_ServerTime:getDateObject(nil, 0)
    return canOpenToday(date.wday) -- wday (weekday, Sunday is 1)
end

-- @Role    时间集合(开始时间、集结结束时间、活动结束)
function GuildCrossWarHelper.getConfigTimeRegion()
    local zeroTime = G_ServerTime:secondsFromZero()
    local startTime = zeroTime + GuildCrossWarHelper.getParameterContent(G_ParameterIDConst.GUILDCROSS_OPEN_TIME)

    local timeLen1 = GuildCrossWarHelper.getParameterContent(G_ParameterIDConst.GUILDCROSS_READY_TIME)
    local timeLen2 = GuildCrossWarHelper.getParameterContent(G_ParameterIDConst.GUILDCROSS_CONDUCTING_TIME)
    local endTime = (startTime + timeLen1 + timeLen2)

    return {startTime = startTime, readyEndTime = (startTime + timeLen1), endTime = endTime}
end

-- @Role    活动当前阶段
function GuildCrossWarHelper.getCurCrossWarStage()
    if not GuildCrossWarHelper.isTodayOpen() then
        return GuildCrossWarConst.ACTIVITY_STAGE_3, 0
    end

    local curTime = G_ServerTime:getTime()
    local timeData = GuildCrossWarHelper.getConfigTimeRegion()

    if timeData.startTime <= curTime and timeData.readyEndTime > curTime then
        return GuildCrossWarConst.ACTIVITY_STAGE_1, timeData.readyEndTime
    elseif timeData.readyEndTime <= curTime and timeData.endTime > curTime then
        return GuildCrossWarConst.ACTIVITY_STAGE_2, timeData.endTime
    else
        return GuildCrossWarConst.ACTIVITY_STAGE_3, 0
    end
end

--============================================================
-- @Role    大地图坐标转换成小地图
function GuildCrossWarHelper.convertToSmallMapPos(pos)
    pos.x = pos.x * GuildCrossWarConst.CAMERA_SCALE_MIN
    pos.y = pos.y * GuildCrossWarConst.CAMERA_SCALE_MIN
    return pos
end

-- @Role    检查是否可以移动
function GuildCrossWarHelper.checkUnitCanMoving(selfUnit, clickPoint)
    -- body
    if selfUnit == nil or clickPoint == nil then
        return false
    end
    
    local curPointId = selfUnit:getCurPointId()
    local bossUnit = G_UserData:getGuildCrossWar():getBossUnitById(curPointId)
    if bossUnit == nil then
        return selfUnit:getCurrState() == GuildCrossWarConst.UNIT_STATE_IDLE
    end

    local bossState, __ = bossUnit:getCurState()
    if bossState ~= GuildCrossWarConst.BOSS_STATE_DEATH then
        return false
    end

    local curState = selfUnit:getCurrState()
    if curState ~= GuildCrossWarConst.UNIT_STATE_IDLE then
        return false
    end
    return true
end

-- @Role    Create Flag In Mini/Small Map
function GuildCrossWarHelper.createFlagInMap()
    local flagNode = cc.Node:create()
    local flagImg = UIHelper.createImage({texture = Path.getQinTomb("img_qintomb_map03a")})
    flagNode:addChild(flagImg)
    return flagNode
end

-- @Role    同步更新用户小地图坐标
-- @Param1  RootNode
-- @Param2  大地图横向坐标
-- @Param3  大地图纵向坐标
function GuildCrossWarHelper.updateSelfNode(rootNode, selfPosX, selfPosY)
    -- body
    if G_UserData:getGuildCrossWar():getSelfUnit() == nil then
        return
    end

    local function createFlagInMap()
        local flagNode = cc.Node:create()
        local flagImg = UIHelper.createImage({texture = Path.getQinTomb("img_qintomb_map03a")})
        flagNode:addChild(flagImg)
        return flagNode
    end

    -- Update Flag's pos
    local selfNode = rootNode:getChildByName("self_node")
    if selfNode == nil then
        selfNode = GuildCrossWarHelper.createFlagInMap()
        if selfNode then
            selfNode:setName("self_node")
            rootNode:addChild(selfNode, 10000)
        end
    end

    -- Synchro Pos
    local tempPosition = GuildCrossWarHelper.convertToSmallMapPos(cc.p(selfPosX, selfPosY))
    selfNode:setPosition(tempPosition)
end

function GuildCrossWarHelper.createGuildNumFlag()
    local flagNode = cc.Node:create()
    local flagImg = UIHelper.createImage({texture = Path.getQinTomb("img_qintomb_map03b")})
    flagNode:addChild(flagImg)
    return flagNode
end

-- @Role    同步更新同工会小地图坐标
-- @Param1  RootNode
function GuildCrossWarHelper.updateSelfGuildMemeber(rootNode, users)
    users = users or {}
    for k,v in pairs(users) do
        local guildNumber = rootNode:getChildByName("guildNumber_" ..k)
        if guildNumber == nil then
            guildNumber = GuildCrossWarHelper.createGuildNumFlag()
            guildNumber:setName("guildNumber_" ..k)
            rootNode:addChild(guildNumber, 10000)
        end

        local x, y = v:getPosition()
        local tempPosition = GuildCrossWarHelper.convertToSmallMapPos(cc.p(x, y))
        guildNumber:setPosition(tempPosition)
    end
end

-- @Role    同步小地图目标点位置及状态（Visible）
-- @Param   场景层
function GuildCrossWarHelper.updateTargetNode(rootNode)
    -- body
    local userUnit = G_UserData:getGuildCrossWar():getSelfUnit()
    if userUnit == nil then
        return
    end

    local function createTargetFlag()
        local targetFlag = cc.Node:create()
        local qizi = UIHelper.createImage({texture = Path.getQinTomb("img_qintomb_map03d")})
        local kuang = UIHelper.createImage({texture = Path.getQinTomb("img_qintomb_map03e")})
        targetFlag:addChild(kuang)
        targetFlag:addChild(qizi)
        targetFlag:setName("target_node")
        return targetFlag
    end

    local targetNode = rootNode:getChildByName("target_node")
    if targetNode == nil then
        targetNode = createTargetFlag()
        rootNode:addChild(targetNode)
    end

    -- TODO::待处理 ...
end

-- @Role    Require Move（暂时弃用）
-- @Param1  用户Id
-- @Param2  目标据点
function GuildCrossWarHelper.moving(userId, targetPoint)
    -- body
    --dump(userId)
    --dump(targetPoint)
    if userId == nil or targetPoint == nil then
        return
    end

    local userUnit = G_UserData:getGuildCrossWar():getUnitById(userId)
    if userUnit == nil then
        return
    end
    if userUnit:getTo_pos().key_point_id == targetPoint.key_point_id then
        return
    end
    
    if userUnit:getCurrState() ~= GuildCrossWarConst.UNIT_STATE_IDLE then
        return
    end    
end

--构建小地图队伍原点
function GuildCrossWarHelper.updateMiniMapSelf(targetNode)
    -- body
end

-- @Role   Get Color For User
-- @Param   用户Id
function GuildCrossWarHelper.getPlayerColor(userId)
    -- body
    local unitData = G_UserData:getGuildCrossWar():getUnitById(userId)
    if unitData == nil then
        return Colors.getColor(6)
    end
    if unitData:isSelf() then
        return Colors.getColor(2)--自己
    end
    if unitData:isSelfGuild() then
        return Colors.getColor(3)--自己军团
    end
    --非本军团
    return Colors.getColor(6)
end

-- @Role    Update hero's Icon
function GuildCrossWarHelper.updateHeroIcon(node, userUnit)
    local UserDataHelper = require("app.utils.UserDataHelper")
    local limit = require("app.utils.data.AvatarDataHelper").getAvatarConfig(userUnit:getAvatar_base_id()).limit == 1 and 3 
    local avatarId = UserDataHelper.convertAvatarId({base_id = userUnit:getBase_id(), avatar_base_id = userUnit:getAvatar_base_id() })
    node:updateUI(avatarId, nil, limit)
end

-- @Role    获取Boss配置
function GuildCrossWarHelper.isExistBossInPoint(pointId)
    local warKeyMap = G_UserData:getGuildCrossWar():getWarKeyMap()
    for i,v in ipairs(warKeyMap) do
        if v.cfg and v.cfg.boss_res > 0 and v.cfg.id == pointId then
            return true, v.cfg
        end
    end
    return false, nil
end

-- @Role    当前是否一个据点坑位
function GuildCrossWarHelper.isCurPointHole(pointHole1, pointHole2)
    if type(pointHole1) ~= "table" or type(pointHole2) ~= "table" then
        return false
    end
    if pointHole1.key_point_id == pointHole2.key_point_id and pointHole1.pos == pointHole2.pos then
        return true
    end
    return false
end

-- @Role    获取坑中玩家列表
function GuildCrossWarHelper.getHoleUserList(pointHole)
    local userList = G_UserData:getGuildCrossWar():getCurHoleData(pointHole)
    if userList == nil or table.nums(userList) <= 0 then
        return {}
    end
    return userList
end

-- @Role    获取据点中玩家列表（可弃用
function GuildCrossWarHelper.getPointUserList(point)
    local userList = G_UserData:getGuildCrossWar():getCurPointData(point)
    if userList == nil or table.nums(userList) <= 0 then
        return nil
    end
    return userList
end

-- @Role    是否可进行跨服军团战     
function GuildCrossWarHelper.isGuildCrossWarEntry()
    local guildData = G_UserData:getGuild():getMyGuild()
    if guildData == nil then
        return false
    end

    return guildData:isEntry()
end

-- @Role    是否自身
function GuildCrossWarHelper.isSelf(userId)
    return userId == G_UserData:getBase():getId()
end

-- @Role    是否回到原始据点
function GuildCrossWarHelper.isOriPoint(point)
    return rawequal(point, G_UserData:getGuildCrossWar():getSelfOriPoint())
end

-- @Role    PointName's convert
function GuildCrossWarHelper.replaceStr(name)
    local strTable = getWordTable(name)
    return table.concat(strTable, "\n", 1, #strTable)
end

-- @Role    GuildRank's GuildName Color
function GuildCrossWarHelper.getGuildNameColor(rank)
    if rank <=3 and rank > 0  then
        return Colors["GUILD_DUNGEON_RANK_COLOR"..rank]
    end
    return Colors["DARK_BG_ONE"]
end


return GuildCrossWarHelper
