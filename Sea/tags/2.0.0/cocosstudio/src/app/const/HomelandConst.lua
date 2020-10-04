--
-- Author: hedili
-- Date: 2018-05-04 15:57:29
-- 种树常量
local HomelandConst = {}
HomelandConst.HOMELAND_TREE_DEFAULT_LEVEL = 1 --子树默认等级，方便策划调试

HomelandConst.SELF_TREE = 1
HomelandConst.FRIEND_TREE = 2

HomelandConst.DLG_MAIN_TREE = 1
HomelandConst.DLG_SUB_TREE  = 2

HomelandConst.DLG_FRIEND_MAIN_TREE  = 3
HomelandConst.DLG_FRIEND_SUB_TREE  = 4


HomelandConst.MAIN_TREE_POSITION = cc.p(0,0)

HomelandConst.MAX_SUB_TREE = 6

HomelandConst.MAX_SUB_TREE_TYPE6 = 6 --玲珑玉块

HomelandConst.SUB_TREE_POSITION =
{
    [1] = cc.p(0,0),
    [2] = cc.p(0,0),
    [3] = cc.p(0,0),
    [4] = cc.p(0,0),
    [5] = cc.p(0,0),
    [6] = cc.p(0,0),
}
return readOnly(HomelandConst)