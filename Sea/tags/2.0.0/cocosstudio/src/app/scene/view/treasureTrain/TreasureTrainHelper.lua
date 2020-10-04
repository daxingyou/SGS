--
-- Author: Liangxu
-- Date: 2017-05-10 14:45:55
-- 宝物培养帮助类
local TreasureTrainHelper = {}
local UserDataHelper = require("app.utils.UserDataHelper")
local ParameterIDConst = require("app.const.ParameterIDConst")

local curTreasureId = 0


--检查功能开启
function TreasureTrainHelper.isOpen(funcId)
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	local isOpen, des = LogicCheckHelper.funcIsOpened(funcId)
	if not isOpen then
		G_Prompt:showTip(des)
		return false
	end
	return true
end

--检查是否达到了精炼的最大等级
function TreasureTrainHelper.checkIsReachRefineMaxLevel(data)
	local curLevel = data:getRefine_level()
	local maxLevel = data:getMaxRefineLevel()

	return curLevel >= maxLevel
end

return TreasureTrainHelper