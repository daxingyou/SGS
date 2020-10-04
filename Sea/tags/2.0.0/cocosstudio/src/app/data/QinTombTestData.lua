-- Author: hedili
-- Date:2018-08-31 10:16:30
-- Describle：先秦皇陵
-- 测试用例模块
local BaseData = require("app.data.BaseData")
local QinTombTestData = class("QinTombTestData", BaseData)



function QinTombTestData:createGraveTeamList( ... )
	-- body
	local retList = {}
	for i=1, 5 do
		local temp = self:createGraveTeam(i)
		table.insert( retList, temp )
	end
	return retList
end

--[[
message GraveTeam {
	optional TeamInfo  team_info= 1;
	repeated uint32  path =2;
	optional uint32  begin_time =3;
	optional uint32  need_time =4;
}
]]

function QinTombTestData:_buildPath( ... )
	-- body
	local qin_point = require("app.config.qin_point")
	local index1 = 1
	local index2 = math.random(2,22)
	local qinData1 = qin_point.indexOf(index1)
	local qinData2 = qin_point.indexOf(index2)
	local moveList, pathTable, totalTime = G_UserData:getQinTomb():getMovingPath({pointId = qinData1.point_id},
		{pointId = qinData2.point_id})

	return pathTable,totalTime
end


function QinTombTestData:createGraveTeam(i)
	local teamInfo = self:createTeamInfo(i)
	local path,totalTime = self:_buildPath(i)

	--dump(totalTime)
	local graveTeam = {
		team_info = teamInfo,
		begin_time = G_ServerTime:getTime(),
		need_time = totalTime,
		path = {101},
	}
	return graveTeam
end

function QinTombTestData:createMonsterList( ... )
	-- body
	local qin_point = require("app.config.qin_point")
	
	local monsterList = {}
	for i= 301, 309 do
		local monster = {}
		monster.point_id =i
		monster.monster_type = math.random(1, 2)
		monster.begin_time = G_ServerTime:getTime()
		monster.left_time	=  10
		monster.stop_time = G_ServerTime:getTime() + 10
		monster.own_team_id =0
		monster.battle_team_id = 0
		if monster.point_id == 301 then
			monster.own_team_id = 2
			monster.battle_team_id = 0
		end
		table.insert( monsterList, monster )
	end

	return monsterList
end

--[[
message TeamUserInfo {
	optional uint64 user_id = 1;
	optional uint32 base_id = 2;
	optional uint32 avatar_base_id = 3;
	optional string name = 4;
	optional uint32 office_level = 5;
	optional uint32 level = 6;
	optional uint64 power = 7;
	optional string guild_name = 8;
}
message TeamInfo {
	optional uint32 team_id = 1;//队伍id
	optional uint32 team_type = 2;//队伍类型
	optional uint32 team_target = 3;//队伍目标
	optional uint32 min_level = 4;//队伍等级限制
	optional uint32 max_level = 5;//队伍等级限制
	optional uint64 team_leader = 6;//队长
	repeated TeamMember members = 7;//成员
	optional bool is_scene = 8;//是否进入场景
}
message TeamMember {
	optional TeamUserInfo user = 1;//
	optional uint32 team_no = 2;//几号位
}	
]]

function QinTombTestData:createTeamMember( team_no )
	-- body
	local userId =  math.random(1, 10000)
	local teamUserInfo = {
		user_id = userId,
		base_id = 100 + math.random(1,10),
		avatar_base_id = 1212+ math.random(0,3),
		name = "testUser"..userId,
		office_level = 5,
		level =10,
		power = 1001,
		guild_name = "test"..userId
	}
	local teamMember = {
		user = teamUserInfo,
		team_no = team_no,
	}
	return teamMember
end

function QinTombTestData:createTeamInfo( teamId )
	-- body
	local teamMembers = {}
	for i=1, 3 do
		local member=  self:createTeamMember(i)
		table.insert(teamMembers,member)
	end
	local teamInfo = {
		team_id = teamId,
		team_type = 1,
		team_target = 1,
		min_level = 1,
		max_level = 10,
		team_leader = 1,
		members = teamMembers,
		is_app = false,
	}

	return teamInfo
end



--初始化刚进入的数据
function QinTombTestData:s2cGraveEnterScene( ... )
	-- body
	logWarn("QinTombTestData:s2cGraveEnterScene")

	local graveList = self:createGraveTeamList()
	local monsterList = self:createMonsterList()
	--dump(graveList)
	G_UserData:getQinTomb():_s2cGraveEnterScene(MessageIDConst.ID_S2C_GraveEnterScene, {teams = graveList, mosters = monsterList,
	my_team_id = 1})

	--self:s2cUpdateGrave(1,0)
	--self:s2cUpdateGrave(2,0)
	--self:_s2cGraveEnterScene(ID_S2C_GraveEnterScene, {teams = graveList})
end


--初始化刚进入的数据
function QinTombTestData:s2cUpdateGrave( teamId, del)
	-- body
	local graveTeam = self:createGraveTeam()

	if teamId then
		graveTeam.team_info.team_id = teamId
		graveTeam.path = {101}
	end
	--dump(graveList)
	G_UserData:getQinTomb():_s2cUpdateGrave(MessageIDConst.ID_S2C_UpdateGrave, {team = graveTeam, del = del})
	--self:_s2cGraveEnterScene(ID_S2C_GraveEnterScene, {teams = graveList})
end

function QinTombTestData:s2cHookGrave( ... )
	-- body
end

function QinTombTestData:s2cAttackGrave( ... )
	-- body
end

function QinTombTestData:s2cDeathGrave( ... )
	-- body
end

function QinTombTestData:s2cUpdateMovingGrave( teamId, path,needTime)
	-- body
	local graveTeam = self:createGraveTeam()

	if teamId then
		graveTeam.team_info.team_id = teamId
	end
	if path then
		graveTeam.path = path
	end
	if needTime then
		graveTeam.need_time = needTime
	end

	--dump(graveTeam.path)
	--dump(graveTeam.need_time)
	--dump(graveList)
	G_UserData:getQinTomb():_s2cUpdateGrave(MessageIDConst.ID_S2C_UpdateGrave, {team = graveTeam, del = del})
	--self:_s2cGraveEnterScene(ID_S2C_GraveEnterScene, {teams = graveList})
end

function QinTombTestData:s2cUpdateMonsterGrave( ... )
	-- body
	local monster = {
		battle_team_id = 0,
		begin_time = G_ServerTime:getTime(),
		left_time = 600,
		monster_type = 2,
		own_team_id = 2,
		point_id = 301,
		stop_time = 0,
	}

	G_UserData:getQinTomb():_s2cUpdateGrave(MessageIDConst.ID_S2C_UpdateGrave, {monster = monster})
end



function QinTombTestData:s2cGraveBattleNotice( ... )
	-- body
local report = {
	report = {
	[1] = 
		{
			result = 1,
			team_no = 1,
			attack = 
			{
				avatar_base_id = 0,
				base_id = 12,
				guild_name  = "",
				level= 100,
				name = "t2",
				office_level = 2,
				power = 115757917,
				user_id= 290001000006,
			},
			defense = 
			{
				avatar_base_id = 0,
				base_id = 12,
				guild_name = "bbxx",
				level = 100,
				name = "t1",
				office_level= 2,
				power= 120880158,
				user_id= 290001000004,
			},
		},

	[2] = {
		result  = 1,
		team_no = 2,
		defense = 
			{
				avatar_base_id = 0,
				base_id = 12,
				guild_name = "bbxx",
				level = 100,
				name = "t1",
				office_level= 2,
				power= 120880158,
				user_id= 290001000004,
			},
		},

	[3] = {
		result  = 0,
		team_no = 3,
		}
	},
	fail_team   = 15,
	report_time = 1540801617,
	win_team   = 16,
}
	G_UserData:getQinTomb():_s2cGraveBattleNotice(MessageIDConst.ID_S2C_UpdateGrave, {report = report})
end
return QinTombTestData
