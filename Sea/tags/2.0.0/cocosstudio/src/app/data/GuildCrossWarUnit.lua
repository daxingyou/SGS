-- Author: hedili
-- Date:2018-12-05 10:16:30
-- Describle：跨服军团战, 战斗单位

local BaseData = require("app.data.BaseData")
local GuildCrossWarUnit = class("GuildCrossWarUnit", BaseData)
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local GuildCrossWarHelper = require("app.scene.view.guildCrossWar.GuildCrossWarHelper")
local schema = {}


GuildCrossWarUnit.schema = schema

--[[
//玩家对象
message BrawlGuildsPlayer {
	optional uint64 uid = 1; //玩家id
	optional uint64 sid = 2; //玩家服务器id
	optional string sname = 3; //服务器名称
	optional string name = 4; //玩家昵称
	optional uint32 base_id = 5; //主角id
	optional uint32 avatar_base_id = 6; //变身卡id
	optional uint32 hp = 7; //体力
	optional string guild_name = 8; //军团名称
	optional uint64 power = 9; //战力
	optional uint32 move_end_time = 10; //移动结束时间
	optional uint32 move_cd = 11; //移动cd
}	
]]

schema["uid"] = {"number", 0} --玩家id
schema["sid"] = {"number", 0} --玩家服务器id
schema["sname"] = {"string", ""} 
schema["name"] = {"string", ""} --玩家昵称
schema["base_id"] = {"number", 0 }  --主角id
schema["avatar_base_id"] = {"number", 0 } --变身卡id
schema["hp"] = {"number", 0 } --体力
schema["guild_name"] = {"string", "" } --军团名称
schema["power"] = {"number", 0} --战力 
schema["move_end_time"] = {"number", 0} --移动结束时间
schema["move_cd"] = {"number", 0} --移动cd

schema["from_pos"] = {"table", {}} --
schema["to_pos"] = {"table",{}}
schema["revive_time"] ={"number", 0 }--复活时间
---这个数据需要自己设置读取


function GuildCrossWarUnit:ctor(properties)
	GuildCrossWarUnit.super.ctor(self, properties)
end

function GuildCrossWarUnit:clear()

end

function GuildCrossWarUnit:reset()

end

function GuildCrossWarUnit:getCurrPointKeyPos()
	-- body
	if GuildCrossWarUnit:getCurrState( ) == GuildCrossWarConst.UNIT_STATE_IDLE then
		local targetPos = self:getTo_pos()
		return GuildCrossWarHelper.getOffsetPointRange(targetPos.id, targetPos.key_point_id)
	end
	return nil
end


function GuildCrossWarUnit:getCurrState( )
	-- body
	local reviveTime = G_ServerTime:getLeftSeconds(self:getRevive_time())
	if reviveTime > 0 then
		return GuildCrossWarConst.UNIT_STATE_DEATH
	end

	local cdLeftTime = G_ServerTime:getLeftSeconds(self:getMove_cd())
	if cdLeftTime > 0 then
		return GuildCrossWarConst.UNIT_STATE_CD
	end

	local movingEnd = G_ServerTime:getLeftSeconds(self:getMove_end_time())
	if movingEnd > 0 then
		return GuildCrossWarConst.UNIT_STATE_MOVING
	end


	return GuildCrossWarConst.UNIT_STATE_IDLE

end

function GuildCrossWarUnit:_getMovingPathByTime( ... )
	-- body
	--到达终点，返回终点坐标
	local movingEnd = G_ServerTime:getLeftSeconds(self:getMove_end_time())
	if movingEnd <= 0 then
		return 
	end
	local movingNeedTime = 0
	return movingNeedTime - movingEnd
end

function GuildCrossWarUnit:getMovingPath( selfX, selfY )
	-- body
	local fromPos = self:getFrom_pos()
	local targetPos = self:getTo_pos()


	local movingLine = GuildCrossWarHelper.getMovingLine( 
		fromPos.id, 
		fromPos.key_point_id, 
		targetPos.id, 
		targetPos.key_point_id )

	if movingLine and #movingLine > 0 then
		movingLine[1] = cc.p(selfX,selfY)
		return movingLine
	end
	return {}
end


--是否是玩家自己
function GuildCrossWarUnit:isSelf( ... )
	-- body
	return self:getUid() == G_UserData:getBase():getId()
end

--是否是本军团
function GuildCrossWarUnit:isSelfGuild( ... )
	-- body
end

--该用户是否在可见区域
function GuildCrossWarUnit:isPlayerNeedShow( ... )
	-- body
end


return GuildCrossWarUnit
