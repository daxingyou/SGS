--time_limit_activity

local time_limit_activity = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --限时活动名称-string 
      start_des = 3,    --开启描述-string 
      description = 4,    --活动描述-string 
      is_work = 5,    --是否显示-int 
    
    },
    -- data
    _data = {
        [1] = {1,"军团BOSS","每日","军团BOSS每天12点, 19点开启；军团参与人数越多, 拍卖奖励越多；参与活动均可获得军团拍卖分红.",1,},
        [2] = {2,"军团答题","每日","军团答题每天18点开启；军团参与人数越多, 拍卖奖励越多；参与活动的玩家均可获得军团拍卖分红.",1,},
        [3] = {3,"军团试炼","每日","军团试炼每天18点10分至18点40分开启；军团试炼积分越多, 拍卖奖励越多；参与活动均可获得军团拍卖分红.",1,},
        [4] = {4,"三国战记","每周三, 五, 日","纵横乱世间, 霸气冲云天.三国名将, 战!战!战!每周三, 五, 日的21点准时开启, 等你来战!!!",1,},
        [5] = {5,"阵营竞技","每周一, 四","阵营竞技每周一, 四4点开始报名, 21点准时开战；报名人数越多, 拍卖奖励越多；所有报名玩家都可获得阵营竞技拍卖分红.",1,},
        [6] = {6,"华容道","每日","华容道每天10点, 14点, 16点, 22点各开启2场, 一天共开启8场, 可前去支持参赛的武将, 支持武将跑第一可以获得奖励!",1,},
        [7] = {7,"军团战","每周二, 六","中原风雨来, 三国豪杰聚；沙场秋点兵, 豪气冲天起.\n每周二, 六21点准时开启军团战.来, 战个痛快!",1,},
        [8] = {8,"王者之战","每天","无差别公平竞技, 无视战力, 只比战术!\n每天11-14点和19-22点, 一起来战!",1,},
        [9] = {9,"先秦皇陵","每天","每天10-22点, 组队闯皇陵, 有机会获得春秋战国!",1,},
        [10] = {10,"阵营竞技","每周一","阵营竞技每周一4点开始报名, 21点准时开战；报名人数越多, 拍卖奖励越多；所有报名玩家都可获得阵营竞技, 周四跨服个人竞技拍卖分红.",1,},
        [11] = {11,"跨服军团战","每周六","周二21点开启军团战, 周六21点开启跨服军团战\n占领虎牢关, 函谷关, 剑阁, 逍遥津的军团可参加跨服军团战\n其他军团仍然参加本服军团战.",0,},
        [12] = {12,"跨服个人竞技","每周四","同组8个服务器均开服30天, 每周四开启跨服个人竞技；阵营竞技报名人数越多, 拍卖奖励越多, 报名玩家都可获得跨服个人竞技拍卖分红.",1,},
        [13] = {13,"军团答题","每周二, 四, 六","军团答题周二, 四, 六18点开启；军团参与人数越多, 拍卖奖励越多；参与活动的玩家均可获得军团拍卖分红.",1,},
        [14] = {14,"全服答题","每周一, 三, 五, 日","全服答题每周一, 三, 五, 日18点开启；军团参与人数越多, 拍卖奖励越多；参与活动的玩家均可获得军团拍卖分红.",0,},
    }
}

return time_limit_activity