--蛋糕活动常量
local CakeActivityConst = {}
local Config = require("app.config.parameter")
local AudioConst = require("app.const.AudioConst")

CakeActivityConst.MATERIAL_TYPE_1 = 1 --鸡蛋
CakeActivityConst.MATERIAL_TYPE_2 = 2 --奶油
CakeActivityConst.MATERIAL_TYPE_3 = 3 --水果

CakeActivityConst.RANK_TYPE_1 = 1 --军团
CakeActivityConst.RANK_TYPE_2 = 2 --个人

--材料Id
CakeActivityConst.MATERIAL_ITEM_ID_1 = tonumber(Config.get(691).content) --鸡蛋
CakeActivityConst.MATERIAL_ITEM_ID_2 = tonumber(Config.get(692).content) --奶油
CakeActivityConst.MATERIAL_ITEM_ID_3 = tonumber(Config.get(693).content) --水果

--材料对应的经验值
CakeActivityConst.MATERIAL_VALUE_1 = tonumber(string.split(Config.get(682).content, "|")[2])
CakeActivityConst.MATERIAL_VALUE_2 = tonumber(string.split(Config.get(683).content, "|")[2])
CakeActivityConst.MATERIAL_VALUE_3 = tonumber(string.split(Config.get(684).content, "|")[2])

--通知样式
CakeActivityConst.NOTICE_TYPE_COMMON = 1 --普通
CakeActivityConst.NOTICE_TYPE_LEVEL_UP = 2 --蛋糕升级
CakeActivityConst.NOTICE_TYPE_GET_FRUIT = 3 --获得水果

--领奖箱
CakeActivityConst.AWARD_STATE_1 = 1 --不可领
CakeActivityConst.AWARD_STATE_2 = 2 --可领
CakeActivityConst.AWARD_STATE_3 = 3 --已领

--任务状态
CakeActivityConst.TASK_STATE_1 = 1 --前往
CakeActivityConst.TASK_STATE_2 = 2 --可领取
CakeActivityConst.TASK_STATE_3 = 3 --已领取

--活动阶段
CakeActivityConst.ACT_STAGE_0 = 0 --活动未开阶段
CakeActivityConst.ACT_STAGE_1 = 1 --本服活动阶段
CakeActivityConst.ACT_STAGE_2 = 2 --中间等待阶段
CakeActivityConst.ACT_STAGE_3 = 3 --全服活动阶段
CakeActivityConst.ACT_STAGE_4 = 4 --全服活动结束后展示阶段

--蛋糕最大等级
CakeActivityConst.MAX_LEVEL = 10

--排名奖励类型
CakeActivityConst.RANK_AWARD_TYPE_1 = 1 --本服个人
CakeActivityConst.RANK_AWARD_TYPE_2 = 2 --本服军团
CakeActivityConst.RANK_AWARD_TYPE_3 = 3 --跨服个人
CakeActivityConst.RANK_AWARD_TYPE_4 = 4 --跨服军团

--信息保留最大条数
CakeActivityConst.INFO_LIST_MAX_COUNT = tonumber(Config.get(688).content)

CakeActivityConst.CAKE_LOCAL_TIME = tonumber(Config.get(680).content) --本服比赛持续时间（秒）
CakeActivityConst.CAKE_CROSS_TIME = tonumber(Config.get(681).content) --全服比赛持续时间（秒）
CakeActivityConst.CAKE_TIME_GAP = tonumber(Config.get(701).content) --本服比赛和全服比赛间隔（秒）
CakeActivityConst.CAKE_TIME_LEFT = tonumber(Config.get(702).content) --全服蛋糕活动结束后保留时间（秒）

function CakeActivityConst.getMaterialTypeWithId(id)
	for materialType = CakeActivityConst.MATERIAL_TYPE_1, CakeActivityConst.MATERIAL_TYPE_3 do
		if id == CakeActivityConst["MATERIAL_ITEM_ID_"..materialType] then
			return materialType
		end
	end
	assert(false, string.format("CakeActivityConst.getMaterialTypeWithId id is wrong, id = %d", id))
end

function CakeActivityConst.getMaterialIconWithId(id)
	local res = nil
	if id == CakeActivityConst.MATERIAL_ITEM_ID_1 then
		res = Path.getAnniversaryImg("img_prop_egg")
	elseif id == CakeActivityConst.MATERIAL_ITEM_ID_2 then
		res = Path.getAnniversaryImg("img_prop_cream")
	elseif id == CakeActivityConst.MATERIAL_ITEM_ID_3 then
		res = Path.getAnniversaryImg("img_prop_fruits")
	end
	if res == nil then
		local TypeConvertHelper = require("app.utils.TypeConvertHelper")
		local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_ITEM, id)
		res = param.icon
	end
	return res
end

function CakeActivityConst.getMaterialSoundIdWithId(id)
	local soundId = 0
	if id == CakeActivityConst.MATERIAL_ITEM_ID_1 then
		soundId = AudioConst.SOUND_CAKE_EGG
	elseif id == CakeActivityConst.MATERIAL_ITEM_ID_2 then
		soundId = AudioConst.SOUND_CAKE_CREAM
	elseif id == CakeActivityConst.MATERIAL_ITEM_ID_3 then
		soundId = AudioConst.SOUND_CAKE_FRUIT
	end
	return soundId
end

return readOnly(CakeActivityConst)