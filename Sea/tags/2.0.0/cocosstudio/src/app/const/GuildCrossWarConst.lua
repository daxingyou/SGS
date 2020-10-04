--
-- Author: hedl
-- Date: 2018-12-05 15:51:32
-- 跨服军团战
local GuildCrossWarConst = {}

GuildCrossWarConst.CAMERA_SCALE_MIN = 0.2 --相机偏移
GuildCrossWarConst.CAMERA_SCALE_MAX = 5   --放大4倍
GuildCrossWarConst.AVATAR_MOVING_RATE   = 120     --移动速率


-- Guild CrossWar State
GuildCrossWarConst.ACTIVITY_STAGE_1 = 1 -- 集结阶段
GuildCrossWarConst.ACTIVITY_STAGE_2 = 2 -- PVE阶段/PVP阶段
GuildCrossWarConst.ACTIVITY_STAGE_3 = 3 -- 尚未开始（或已结束）

-- Update Self
GuildCrossWarConst.SELF_ENTER = 1   -- 进入或重连
GuildCrossWarConst.SELF_MOVE  = 2   -- 移动
GuildCrossWarConst.SELF_FIGHT = 3   -- 战斗

-- Avatar State
GuildCrossWarConst.UNIT_STATE_IDLE   = 0 -- 常  态
GuildCrossWarConst.UNIT_STATE_MOVING = 1 -- 移动态
GuildCrossWarConst.UNIT_STATE_CD     = 2 -- CD  态
GuildCrossWarConst.UNTI_STATE_PK     = 3 -- PK  态
GuildCrossWarConst.UNIT_STATE_DEATH  = 4 -- 死亡态,等待复活
GuildCrossWarConst.UNIT_ZORDER = 1000000

-- Boss State
GuildCrossWarConst.BOSS_STATE_IDLE   = 0 -- 常  态
GuildCrossWarConst.BOSS_STATE_PK     = 1 -- PK  态
GuildCrossWarConst.BOSS_STATE_DEATH  = 2 -- 死亡态

-- Attack Type
GuildCrossWarConst.GUILD_CROSS_ATKTARGET_TYPE1  = 1 -- Boss
GuildCrossWarConst.GUILD_CROSS_ATKTARGET_TYPE2  = 2 -- User

-- Update Player
GuildCrossWarConst.UPDATE_ACTION_0     = 0 -- 0. 移动据点
GuildCrossWarConst.UPDATE_ACTION_1     = 1 -- 1. 复活回到原始点
GuildCrossWarConst.UPDATE_ACTION_2     = 2 -- 2. 血量更新
GuildCrossWarConst.UPDATE_ACTION_3     = 3 -- 3. 出生据点有人进来

GuildCrossWarConst.GRID_SIZE          = 120 --格子大小


GuildCrossWarConst.BOSS_AVATAR_INFO_POS = cc.p(0, 60) 
GuildCrossWarConst.BOSS_AVATAR_DISTANCE = 80    --人兽间距

GuildCrossWarConst.ENEMY_CELL_MAX   = 3         -- 显示最大战斗列表数目
GuildCrossWarConst.ENEMY_VIEW_OFFSETPOS = cc.p(-420, -80)


GuildCrossWarConst.ENEMY_CELL_POS = {           -- 战斗列表位置（右侧）
    cc.p(60, 135), cc.p(100, 73), cc.p(65, 12)
}
GuildCrossWarConst.ENEMY_CELL_OFFSETPOS = {     -- 战斗列表位置（左侧）
    cc.p(-300, 75), cc.p(-340, 13), cc.p(-305, -48)
}

GuildCrossWarConst.ATTACK_CELL_BG = {           -- 攻击目标背景条
    "img_target02",
    "img_target03",
}

GuildCrossWarConst.GUILD_LADDER_CELL_BG = {     -- 军团排行背景条
    "img_war_com01a",
    "img_war_com01c",
}

GuildCrossWarConst.PERSONNAL_LADDER_CELL_BG = {  -- 个人排行榜底
    "img_com_ranking04",
    "img_com_ranking05",
}

GuildCrossWarConst.GUILD_LADDER_RANKNUM = {      -- 军团排行序
    "img_qizhi01",
    "img_qizhi02",
    "img_qizhi03",
    "img_qizhi04",
}


GuildCrossWarConst.USER_HP = {              -- user 血量图
    "img_blood01",
    "img_blood02",
    "img_blood03",
    "img_blood04",
    "img_blood05",
}

return readOnly(GuildCrossWarConst)