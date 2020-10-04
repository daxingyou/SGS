--
-- 队伍位置数据
-- Author: zhanglinsen
-- Date: 2018-08-30 10:05:31
-- 
local BaseData = require("app.data.BaseData")
local GroupsMemberLocationData = class("GroupsMemberLocationData", BaseData)
local GroupsConst = require("app.const.GroupsConst")
local GroupsUserData = require("app.data.GroupsUserData")

local schema = {}
schema["user"]               = {"table", {}} --//玩家信息
schema["team_no"] 		     = {"number", 0} --//几号位

-- message TeamMember {
-- 	optional TeamUserInfo user = 1;//
-- 	optional uint32 team_no = 2;//几号位
-- }
GroupsMemberLocationData.schema = schema


function GroupsMemberLocationData:ctor(properties)
	GroupsMemberLocationData.super.ctor(self, properties)
	self._userData = nil --玩家数据
end

function GroupsMemberLocationData:clear()
	self._userData = nil 

end

function GroupsMemberLocationData:reset()
	
end

--当前位置
function GroupsMemberLocationData:getLocation()
	return self:getTeam_no()
end

-- 自己队伍数据
function GroupsMemberLocationData:getUserData()
	if self._userData == nil then
		local user = self:getUser()
		local userData = GroupsUserData.new()
		-- dump(user)
		userData:updateData(user)
		self._userData = userData
		-- dump(userData)
	end
	return self._userData
end

--更新组队信息
--@param groups 队伍信息
function GroupsMemberLocationData:updateData(myData)
	self._userData = nil
	self:setProperties(myData)

end	

--=========================测试数据部分=============================================


return GroupsMemberLocationData