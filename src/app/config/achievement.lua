--achievement

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  id = 1,    --编号-int 
  pre_id = 2,    --前置成就id-int 
  level = 3,    --功能开启等级id-int 
  function_id = 4,    --功能跳转id-int 
  tab = 5,    --所在页签-int 
  theme = 6,    --主题-string 
  content = 7,    --成就内容-string 
  require_type = 8,    --完成条件类型-int 
  if_display = 9,    --是否显示进度-int 
  calculation = 10,    --计算类型-int 
  require_value = 11,    --完成要求值-int 
  reward_type1 = 12,    --奖励1类型-int 
  reward_value1 = 13,    --奖励1类型值-int 
  reward_size1 = 14,    --奖励1数量-int 
  reward_type2 = 15,    --奖励2类型-int 
  reward_value2 = 16,    --奖励2类型值-int 
  reward_size2 = 17,    --奖励2数量-int 
  order = 18,    --排序-int 
  icon = 19,    --显示icon-string 
  color = 20,    --icon底板颜色-int 

}

-- key type
local __key_type = {
  id = "int",    --编号-1 
  pre_id = "int",    --前置成就id-2 
  level = "int",    --功能开启等级id-3 
  function_id = "int",    --功能跳转id-4 
  tab = "int",    --所在页签-5 
  theme = "string",    --主题-6 
  content = "string",    --成就内容-7 
  require_type = "int",    --完成条件类型-8 
  if_display = "int",    --是否显示进度-9 
  calculation = "int",    --计算类型-10 
  require_value = "int",    --完成要求值-11 
  reward_type1 = "int",    --奖励1类型-12 
  reward_value1 = "int",    --奖励1类型值-13 
  reward_size1 = "int",    --奖励1数量-14 
  reward_type2 = "int",    --奖励2类型-15 
  reward_value2 = "int",    --奖励2类型值-16 
  reward_size2 = "int",    --奖励2数量-17 
  order = "int",    --排序-18 
  icon = "string",    --显示icon-19 
  color = "int",    --icon底板颜色-20 

}


-- data
local achievement = {
    version =  1,
    _data = {
        [1] = {102001,0,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,100,5,1,100,0,0,0,28,"icon_achievement1",5,},
        [2] = {102002,102001,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,200,5,1,100,0,0,0,29,"icon_achievement1",5,},
        [3] = {102003,102002,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,400,5,1,100,0,0,0,30,"icon_achievement1",5,},
        [4] = {102004,102003,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,600,5,1,100,0,0,0,31,"icon_achievement1",5,},
        [5] = {102005,102004,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,650,5,1,100,0,0,0,32,"icon_achievement1",5,},
        [6] = {102006,102005,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,700,5,1,100,0,0,0,33,"icon_achievement1",5,},
        [7] = {102007,102006,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,750,5,1,200,0,0,0,34,"icon_achievement1",5,},
        [8] = {102008,102007,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,800,5,1,200,0,0,0,35,"icon_achievement1",5,},
        [9] = {102009,102008,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,850,5,1,200,0,0,0,36,"icon_achievement1",5,},
        [10] = {102010,102009,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,900,5,1,200,0,0,0,37,"icon_achievement1",5,},
        [11] = {102011,102010,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,950,5,1,200,0,0,0,38,"icon_achievement1",5,},
        [12] = {102012,102011,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1000,5,1,200,0,0,0,39,"icon_achievement1",5,},
        [13] = {102013,102012,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1050,5,1,200,0,0,0,40,"icon_achievement1",5,},
        [14] = {102014,102013,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1100,5,1,300,0,0,0,41,"icon_achievement1",5,},
        [15] = {102015,102014,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1150,5,1,300,0,0,0,42,"icon_achievement1",5,},
        [16] = {102016,102015,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1200,5,1,300,0,0,0,43,"icon_achievement1",5,},
        [17] = {102017,102016,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1250,5,1,300,0,0,0,44,"icon_achievement1",5,},
        [18] = {102018,102017,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1300,5,1,300,0,0,0,45,"icon_achievement1",5,},
        [19] = {102019,102018,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1350,5,1,300,0,0,0,46,"icon_achievement1",5,},
        [20] = {102020,102019,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1400,5,1,300,0,0,0,47,"icon_achievement1",5,},
        [21] = {102021,102020,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1450,5,1,300,0,0,0,48,"icon_achievement1",5,},
        [22] = {102022,102021,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1500,5,1,300,0,0,0,49,"icon_achievement1",5,},
        [23] = {102023,102022,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1550,5,1,300,0,0,0,50,"icon_achievement1",5,},
        [24] = {102024,102023,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1600,5,1,300,0,0,0,51,"icon_achievement1",5,},
        [25] = {102025,102024,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1650,5,1,300,0,0,0,52,"icon_achievement1",5,},
        [26] = {102026,102025,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1700,5,1,300,0,0,0,53,"icon_achievement1",5,},
        [27] = {102027,102026,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1750,5,1,300,0,0,0,54,"icon_achievement1",5,},
        [28] = {102028,102027,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1800,5,1,300,0,0,0,55,"icon_achievement1",5,},
        [29] = {102029,102028,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1850,5,1,300,0,0,0,56,"icon_achievement1",5,},
        [30] = {102030,102029,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1900,5,1,300,0,0,0,57,"icon_achievement1",5,},
        [31] = {102031,102030,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,1950,5,1,300,0,0,0,58,"icon_achievement1",5,},
        [32] = {102032,102031,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,2000,5,1,300,0,0,0,59,"icon_achievement1",5,},
        [33] = {102033,102032,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,2050,5,1,300,0,0,0,60,"icon_achievement1",5,},
        [34] = {102034,102033,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,2100,5,1,300,0,0,0,61,"icon_achievement1",5,},
        [35] = {102035,102034,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,2150,5,1,300,0,0,0,62,"icon_achievement1",5,},
        [36] = {102036,102035,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,2200,5,1,300,0,0,0,63,"icon_achievement1",5,},
        [37] = {102037,102036,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,2250,5,1,300,0,0,0,64,"icon_achievement1",5,},
        [38] = {102038,102037,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,2300,5,1,300,0,0,0,65,"icon_achievement1",5,},
        [39] = {102039,102038,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,2350,5,1,300,0,0,0,66,"icon_achievement1",5,},
        [40] = {102040,102039,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,2400,5,1,300,0,0,0,67,"icon_achievement1",5,},
        [41] = {102041,102040,51,51,1,"星星点灯","主线副本星数达到%d星",102,1,1,2450,5,1,300,0,0,0,68,"icon_achievement1",5,},
        [42] = {104001,0,51,0,1,"成长快乐","等级到达%d级",104,1,1,20,6,62,10,5,2,200000,42,"icon_achievement1",5,},
        [43] = {104002,104001,51,0,1,"成长快乐","等级到达%d级",104,1,1,30,6,62,20,5,2,250000,43,"icon_achievement1",5,},
        [44] = {104003,104002,51,0,1,"成长快乐","等级到达%d级",104,1,1,40,6,62,30,5,2,300000,44,"icon_achievement1",5,},
        [45] = {104004,104003,51,0,1,"成长快乐","等级到达%d级",104,1,1,50,6,62,40,5,2,350000,45,"icon_achievement1",5,},
        [46] = {104005,104004,51,0,1,"成长快乐","等级到达%d级",104,1,1,60,6,63,10,5,2,400000,46,"icon_achievement1",5,},
        [47] = {104006,104005,51,0,1,"成长快乐","等级到达%d级",104,1,1,65,6,63,20,5,2,450000,47,"icon_achievement1",5,},
        [48] = {104007,104006,51,0,1,"成长快乐","等级到达%d级",104,1,1,70,6,63,20,5,2,500000,48,"icon_achievement1",5,},
        [49] = {104008,104007,51,0,1,"成长快乐","等级到达%d级",104,1,1,75,6,63,20,5,2,500000,49,"icon_achievement1",5,},
        [50] = {104009,104008,51,0,1,"成长快乐","等级到达%d级",104,1,1,80,6,63,20,5,2,500000,50,"icon_achievement1",5,},
        [51] = {104010,104009,51,0,1,"成长快乐","等级到达%d级",104,1,1,85,6,63,20,5,2,500000,51,"icon_achievement1",5,},
        [52] = {104011,104010,51,0,1,"成长快乐","等级到达%d级",104,1,1,90,6,63,20,5,2,500000,52,"icon_achievement1",5,},
        [53] = {104012,104011,51,0,1,"成长快乐","等级到达%d级",104,1,1,95,6,63,20,5,2,500000,53,"icon_achievement1",5,},
        [54] = {104013,104012,51,0,1,"成长快乐","等级到达%d级",104,1,1,100,6,63,20,5,2,500000,54,"icon_achievement1",5,},
        [55] = {105001,0,3,3,1,"蒸蒸日上","战斗力达到%d",105,1,1,100000,5,1,200,0,0,0,53,"icon_achievement1",5,},
        [56] = {105002,105001,3,3,1,"蒸蒸日上","战斗力达到%d",105,1,1,200000,5,1,300,0,0,0,54,"icon_achievement1",5,},
        [57] = {105003,105002,3,3,1,"蒸蒸日上","战斗力达到%d",105,1,1,500000,5,1,400,0,0,0,55,"icon_achievement1",5,},
        [58] = {105004,105003,3,3,1,"蒸蒸日上","战斗力达到%d",105,1,1,2000000,5,1,500,0,0,0,56,"icon_achievement1",5,},
        [59] = {105005,105004,3,3,1,"蒸蒸日上","战斗力达到%d",105,1,1,4000000,5,1,500,0,0,0,57,"icon_achievement1",5,},
        [60] = {105006,105005,3,3,1,"蒸蒸日上","战斗力达到%d",105,1,1,8000000,5,1,500,0,0,0,58,"icon_achievement1",5,},
        [61] = {105007,105006,3,3,1,"蒸蒸日上","战斗力达到%d",105,1,1,10000000,5,1,500,0,0,0,59,"icon_achievement1",5,},
        [62] = {105008,105007,3,3,1,"蒸蒸日上","战斗力达到%d",105,1,1,20000000,5,1,500,0,0,0,60,"icon_achievement1",5,},
        [63] = {105009,105008,3,3,1,"蒸蒸日上","战斗力达到%d",105,1,1,30000000,5,1,500,0,0,0,61,"icon_achievement1",5,},
        [64] = {105010,105009,3,3,1,"蒸蒸日上","战斗力达到%d",105,1,1,40000000,5,1,500,0,0,0,62,"icon_achievement1",5,},
        [65] = {107001,0,104,3,1,"加油加油","上阵武将全体突破达到%d级",107,1,1,1,5,2,10000,0,0,0,73,"icon_achievement1",5,},
        [66] = {107002,107001,104,3,1,"加油加油","上阵武将全体突破达到%d级",107,1,1,2,5,2,20000,0,0,0,74,"icon_achievement1",5,},
        [67] = {107003,107002,104,3,1,"加油加油","上阵武将全体突破达到%d级",107,1,1,3,5,2,40000,0,0,0,75,"icon_achievement1",5,},
        [68] = {107004,107003,104,3,1,"加油加油","上阵武将全体突破达到%d级",107,1,1,4,5,2,100000,0,0,0,76,"icon_achievement1",5,},
        [69] = {107005,107004,104,3,1,"加油加油","上阵武将全体突破达到%d级",107,1,1,5,5,2,200000,0,0,0,77,"icon_achievement1",5,},
        [70] = {107006,107005,104,3,1,"加油加油","上阵武将全体突破达到%d级",107,1,1,6,5,2,400000,0,0,0,78,"icon_achievement1",5,},
        [71] = {107007,107006,104,3,1,"加油加油","上阵武将全体突破达到%d级",107,1,1,7,5,2,600000,0,0,0,79,"icon_achievement1",5,},
        [72] = {107008,107007,104,3,1,"加油加油","上阵武将全体突破达到%d级",107,1,1,8,5,2,800000,0,0,0,80,"icon_achievement1",5,},
        [73] = {107009,107008,104,3,1,"加油加油","上阵武将全体突破达到%d级",107,1,1,9,5,2,1000000,0,0,0,81,"icon_achievement1",5,},
        [74] = {107010,107009,104,3,1,"加油加油","上阵武将全体突破达到%d级",107,1,1,10,5,2,1200000,0,0,0,82,"icon_achievement1",5,},
        [75] = {109001,0,122,132,1,"宝物升级","宝物全部升级到%d级",109,1,1,5,6,72,5,0,0,0,93,"icon_achievement1",5,},
        [76] = {109002,109001,122,132,1,"宝物升级","宝物全部升级到%d级",109,1,1,7,6,72,8,0,0,0,94,"icon_achievement1",5,},
        [77] = {109003,109002,122,132,1,"宝物升级","宝物全部升级到%d级",109,1,1,9,6,72,10,0,0,0,95,"icon_achievement1",5,},
        [78] = {109004,109003,122,132,1,"宝物升级","宝物全部升级到%d级",109,1,1,12,6,72,15,0,0,0,96,"icon_achievement1",5,},
        [79] = {109005,109004,122,132,1,"宝物升级","宝物全部升级到%d级",109,1,1,15,6,72,20,0,0,0,97,"icon_achievement1",5,},
        [80] = {109006,109005,122,132,1,"宝物升级","宝物全部升级到%d级",109,1,1,20,6,73,5,0,0,0,98,"icon_achievement1",5,},
        [81] = {109007,109006,122,132,1,"宝物升级","宝物全部升级到%d级",109,1,1,25,6,73,8,0,0,0,99,"icon_achievement1",5,},
        [82] = {109008,109007,122,132,1,"宝物升级","宝物全部升级到%d级",109,1,1,30,6,73,10,0,0,0,100,"icon_achievement1",5,},
        [83] = {109009,109008,122,132,1,"宝物升级","宝物全部升级到%d级",109,1,1,35,6,73,12,0,0,0,101,"icon_achievement1",5,},
        [84] = {109010,109009,122,132,1,"宝物升级","宝物全部升级到%d级",109,1,1,40,6,73,15,0,0,0,102,"icon_achievement1",5,},
        [85] = {110001,0,123,132,1,"宝物精炼","宝物全部精炼到%d阶",110,1,1,1,6,10,100,0,0,0,103,"icon_achievement1",5,},
        [86] = {110002,110001,123,132,1,"宝物精炼","宝物全部精炼到%d阶",110,1,1,3,6,10,200,0,0,0,104,"icon_achievement1",5,},
        [87] = {110003,110002,123,132,1,"宝物精炼","宝物全部精炼到%d阶",110,1,1,5,6,10,200,0,0,0,105,"icon_achievement1",5,},
        [88] = {110004,110003,123,132,1,"宝物精炼","宝物全部精炼到%d阶",110,1,1,6,6,10,200,0,0,0,106,"icon_achievement1",5,},
        [89] = {110005,110004,123,132,1,"宝物精炼","宝物全部精炼到%d阶",110,1,1,7,6,10,200,0,0,0,107,"icon_achievement1",5,},
        [90] = {110006,110005,123,132,1,"宝物精炼","宝物全部精炼到%d阶",110,1,1,8,6,10,200,0,0,0,108,"icon_achievement1",5,},
        [91] = {110007,110006,123,132,1,"宝物精炼","宝物全部精炼到%d阶",110,1,1,9,6,10,200,0,0,0,109,"icon_achievement1",5,},
        [92] = {110008,110007,123,132,1,"宝物精炼","宝物全部精炼到%d阶",110,1,1,10,6,10,200,0,0,0,110,"icon_achievement1",5,},
        [93] = {110009,110008,123,132,1,"宝物精炼","宝物全部精炼到%d阶",110,1,1,11,6,10,200,0,0,0,111,"icon_achievement1",5,},
        [94] = {110010,110009,123,132,1,"宝物精炼","宝物全部精炼到%d阶",110,1,1,12,6,10,200,0,0,0,112,"icon_achievement1",5,},
        [95] = {112001,0,301,3,1,"招兵买马","上阵武将达到%d人",112,2,1,4,6,62,10,0,0,0,113,"icon_achievement1",5,},
        [96] = {112002,112001,301,3,1,"招兵买马","上阵武将达到%d人",112,2,1,5,6,62,10,0,0,0,114,"icon_achievement1",5,},
        [97] = {112003,112002,301,3,1,"招兵买马","上阵武将达到%d人",112,2,1,6,6,62,15,0,0,0,115,"icon_achievement1",5,},
        [98] = {113001,0,13,13,1,"加官进爵","官衔晋升到护军",113,2,1,1,5,1,200,0,0,0,116,"icon_achievement1",5,},
        [99] = {113002,113001,13,13,1,"加官进爵","官衔晋升到司马",113,2,1,2,5,1,200,0,0,0,117,"icon_achievement1",5,},
        [100] = {113003,113002,13,13,1,"加官进爵","官衔晋升到都尉",113,2,1,3,5,1,300,0,0,0,118,"icon_achievement1",5,},
        [101] = {113004,113003,13,13,1,"加官进爵","官衔晋升到校尉",113,2,1,4,5,1,300,0,0,0,119,"icon_achievement1",5,},
        [102] = {113005,113004,13,13,1,"加官进爵","官衔晋升到太守",113,2,1,5,5,1,400,0,0,0,120,"icon_achievement1",5,},
        [103] = {113006,113005,13,13,1,"加官进爵","官衔晋升到刺史",113,2,1,6,5,1,400,0,0,0,121,"icon_achievement1",5,},
        [104] = {113007,113006,13,13,1,"加官进爵","官衔晋升到中郎将",113,2,1,7,5,1,500,0,0,0,122,"icon_achievement1",5,},
        [105] = {113008,113007,13,13,1,"加官进爵","官衔晋升到京兆尹",113,2,1,8,5,1,500,0,0,0,123,"icon_achievement1",5,},
        [106] = {113009,113008,13,13,1,"加官进爵","官衔晋升到尚书令",113,2,1,9,5,1,500,0,0,0,124,"icon_achievement1",5,},
        [107] = {113010,113009,13,13,1,"加官进爵","官衔晋升到卫将军",113,2,1,10,5,1,500,0,0,0,125,"icon_achievement1",5,},
        [108] = {113011,113010,13,13,1,"加官进爵","官衔晋升到大都督",113,2,1,11,5,1,500,0,0,0,126,"icon_achievement1",5,},
        [109] = {113012,113011,13,13,1,"加官进爵","官衔晋升到大将军",113,2,1,12,5,1,500,0,0,0,127,"icon_achievement1",5,},
        [110] = {114001,0,131,0,1,"紫装加持","上阵武将总共穿戴%d件紫色装备",114,1,1,4,5,2,50000,0,0,0,128,"icon_achievement1",5,},
        [111] = {114002,114001,131,0,1,"紫装加持","上阵武将总共穿戴%d件紫色装备",114,1,1,8,5,2,60000,0,0,0,129,"icon_achievement1",5,},
        [112] = {114003,114002,131,0,1,"紫装加持","上阵武将总共穿戴%d件紫色装备",114,1,1,12,5,2,75000,0,0,0,130,"icon_achievement1",5,},
        [113] = {114004,114003,131,0,1,"橙装加持","上阵武将总共穿戴%d件橙色装备",115,1,1,4,5,2,90000,0,0,0,131,"icon_achievement1",5,},
        [114] = {114005,114004,131,0,1,"橙装加持","上阵武将总共穿戴%d件橙色装备",115,1,1,8,5,2,100000,0,0,0,132,"icon_achievement1",5,},
        [115] = {114006,114005,131,0,1,"橙装加持","上阵武将总共穿戴%d件橙色装备",115,1,1,12,5,2,125000,0,0,0,133,"icon_achievement1",5,},
        [116] = {114007,114006,131,0,1,"橙装加持","上阵武将总共穿戴%d件橙色装备",115,1,1,16,5,2,150000,0,0,0,134,"icon_achievement1",5,},
        [117] = {114008,114007,131,0,1,"橙装加持","上阵武将总共穿戴%d件橙色装备",115,1,1,20,5,2,175000,0,0,0,135,"icon_achievement1",5,},
        [118] = {114009,114008,131,0,1,"橙装加持","上阵武将总共穿戴%d件橙色装备",115,1,1,24,5,2,200000,0,0,0,136,"icon_achievement1",5,},
        [119] = {115001,0,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,2,6,12,10,0,0,0,137,"icon_achievement1",5,},
        [120] = {115002,115001,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,5,6,12,25,0,0,0,138,"icon_achievement1",5,},
        [121] = {115003,115002,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,8,6,13,15,0,0,0,139,"icon_achievement1",5,},
        [122] = {115004,115003,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,10,6,13,20,0,0,0,140,"icon_achievement1",5,},
        [123] = {115005,115004,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,12,6,13,25,0,0,0,141,"icon_achievement1",5,},
        [124] = {115006,115005,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,14,6,13,30,0,0,0,142,"icon_achievement1",5,},
        [125] = {115007,115006,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,16,6,13,35,0,0,0,143,"icon_achievement1",5,},
        [126] = {115008,115007,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,18,6,13,40,0,0,0,144,"icon_achievement1",5,},
        [127] = {115009,115008,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,20,6,13,45,0,0,0,145,"icon_achievement1",5,},
        [128] = {115010,115009,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,22,6,13,50,0,0,0,146,"icon_achievement1",5,},
        [129] = {115011,115010,114,131,1,"装备精炼","装备全部精炼到%d级",116,1,1,24,6,13,55,0,0,0,147,"icon_achievement1",5,},
        [130] = {116001,0,25,0,1,"商店达人","武将商店刷新%d次",119,1,1,20,6,5,20,0,0,0,147,"icon_achievement1",5,},
        [131] = {116002,116001,25,0,1,"商店达人","武将商店刷新%d次",119,1,1,50,6,5,20,0,0,0,148,"icon_achievement1",5,},
        [132] = {116003,116002,25,0,1,"商店达人","武将商店刷新%d次",119,1,1,80,6,5,20,0,0,0,149,"icon_achievement1",5,},
        [133] = {116004,116003,25,0,1,"商店达人","武将商店刷新%d次",119,1,1,100,6,5,20,0,0,0,150,"icon_achievement1",5,},
        [134] = {116005,116004,25,0,1,"商店达人","武将商店刷新%d次",119,1,1,300,6,5,20,0,0,0,151,"icon_achievement1",5,},
        [135] = {116006,116005,25,0,1,"商店达人","武将商店刷新%d次",119,1,1,400,6,5,20,0,0,0,152,"icon_achievement1",5,},
        [136] = {116007,116006,25,0,1,"商店达人","武将商店刷新%d次",119,1,1,500,6,5,20,0,0,0,153,"icon_achievement1",5,},
        [137] = {116008,116007,25,0,1,"商店达人","武将商店刷新%d次",119,1,1,800,6,5,20,0,0,0,154,"icon_achievement1",5,},
        [138] = {116009,116008,25,0,1,"商店达人","武将商店刷新%d次",119,1,1,1100,6,5,20,0,0,0,155,"icon_achievement1",5,},
        [139] = {116010,116009,25,0,1,"商店达人","武将商店刷新%d次",119,1,1,1400,6,5,20,0,0,0,156,"icon_achievement1",5,},
        [140] = {117001,0,28,0,1,"聚宝盆","使用聚宝盆%d次",120,1,1,5,5,1,50,0,0,0,157,"icon_achievement1",5,},
        [141] = {117002,117001,28,0,1,"聚宝盆","使用聚宝盆%d次",120,1,1,10,5,1,100,0,0,0,158,"icon_achievement1",5,},
        [142] = {117003,117002,28,0,1,"聚宝盆","使用聚宝盆%d次",120,1,1,20,5,1,150,0,0,0,159,"icon_achievement1",5,},
        [143] = {117004,117003,28,0,1,"聚宝盆","使用聚宝盆%d次",120,1,1,40,5,1,200,0,0,0,160,"icon_achievement1",5,},
        [144] = {117005,117004,28,0,1,"聚宝盆","使用聚宝盆%d次",120,1,1,60,5,1,200,0,0,0,161,"icon_achievement1",5,},
        [145] = {117006,117005,28,0,1,"聚宝盆","使用聚宝盆%d次",120,1,1,80,5,1,200,0,0,0,162,"icon_achievement1",5,},
        [146] = {117007,117006,28,0,1,"聚宝盆","使用聚宝盆%d次",120,1,1,100,5,1,200,0,0,0,163,"icon_achievement1",5,},
        [147] = {117008,117007,28,0,1,"聚宝盆","使用聚宝盆%d次",120,1,1,120,5,1,200,0,0,0,164,"icon_achievement1",5,},
        [148] = {117009,117008,28,0,1,"聚宝盆","使用聚宝盆%d次",120,1,1,140,5,1,200,0,0,0,165,"icon_achievement1",5,},
        [149] = {117010,117009,28,0,1,"聚宝盆","使用聚宝盆%d次",120,1,1,160,5,1,200,0,0,0,166,"icon_achievement1",5,},
        [150] = {118001,0,134,135,1,"神兵进阶","神兵全部进阶到%d阶",121,1,1,1,6,19,200,5,2,200000,167,"icon_achievement1",5,},
        [151] = {118002,118001,134,135,1,"神兵进阶","神兵全部进阶到%d阶",121,1,1,3,6,19,400,5,2,400000,168,"icon_achievement1",5,},
        [152] = {118003,118002,134,135,1,"神兵进阶","神兵全部进阶到%d阶",121,1,1,5,6,80,1,6,19,360,169,"icon_achievement1",5,},
        [153] = {118004,118003,134,135,1,"神兵进阶","神兵全部进阶到%d阶",121,1,1,10,6,19,500,5,2,500000,170,"icon_achievement1",5,},
        [154] = {118005,118004,134,135,1,"神兵进阶","神兵全部进阶到%d阶",121,1,1,15,6,19,700,5,2,640000,171,"icon_achievement1",5,},
        [155] = {118006,118005,134,135,1,"神兵进阶","神兵全部进阶到%d阶",121,1,1,20,6,19,1200,5,2,1000000,172,"icon_achievement1",5,},
        [156] = {118007,118006,134,135,1,"神兵进阶","神兵全部进阶到%d阶",121,1,1,25,6,19,1600,5,2,1500000,173,"icon_achievement1",5,},
        [157] = {130001,0,107,3,1,"武将觉醒","武将最高觉醒到%d星",130,1,1,1,6,40,100,0,0,0,174,"icon_achievement1",5,},
        [158] = {130002,130001,107,3,1,"武将觉醒","武将最高觉醒到%d星",130,1,1,2,6,40,200,0,0,0,175,"icon_achievement1",5,},
        [159] = {130003,130002,107,3,1,"武将觉醒","武将最高觉醒到%d星",130,1,1,3,6,40,300,0,0,0,176,"icon_achievement1",5,},
        [160] = {130004,130003,107,3,1,"武将觉醒","武将最高觉醒到%d星",130,1,1,4,6,40,300,0,0,0,177,"icon_achievement1",5,},
        [161] = {130005,130004,107,3,1,"武将觉醒","武将最高觉醒到%d星",130,1,1,5,6,40,300,0,0,0,178,"icon_achievement1",5,},
        [162] = {131001,0,107,3,1,"奋发图强","全体6个上阵武将觉醒到%d星",131,1,1,1,5,2,50000,0,0,0,180,"icon_achievement1",5,},
        [163] = {131002,131001,107,3,1,"奋发图强","全体6个上阵武将觉醒到%d星",131,1,1,2,5,2,150000,0,0,0,181,"icon_achievement1",5,},
        [164] = {131003,131002,107,3,1,"奋发图强","全体6个上阵武将觉醒到%d星",131,1,1,3,5,2,250000,0,0,0,182,"icon_achievement1",5,},
        [165] = {131004,131003,107,3,1,"奋发图强","全体6个上阵武将觉醒到%d星",131,1,1,4,5,2,400000,0,0,0,183,"icon_achievement1",5,},
        [166] = {131005,131004,107,3,1,"奋发图强","全体6个上阵武将觉醒到%d星",131,1,1,5,5,2,600000,0,0,0,184,"icon_achievement1",5,},
        [167] = {201001,0,0,0,2,"温酒斩华雄","我方关羽击杀敌方华雄",201,2,1,1,5,1,50,0,0,0,205,"icon_achievement1",5,},
        [168] = {202002,0,0,0,2,"生死缠绵","曹丕将甄姬击杀",202,2,1,1,5,1,50,0,0,0,206,"icon_achievement1",5,},
        [169] = {203003,0,0,0,2,"火烧连营","陆逊击杀刘备",203,2,1,1,5,1,50,0,0,0,207,"icon_achievement1",5,},
        [170] = {204004,0,0,0,2,"赤壁之战","刘备、孙权同时上阵击杀敌方曹操",204,2,1,1,5,1,50,0,0,0,208,"icon_achievement1",5,},
        [171] = {205005,0,0,0,2,"赔了夫人又折兵","刘备、孙尚香同时上阵击杀敌方周瑜",205,2,1,1,5,1,50,0,0,0,209,"icon_achievement1",5,},
        [172] = {211001,0,0,0,2,"凤仪亭","场上只剩吕布、董卓、貂蝉",211,2,1,1,5,1,50,0,0,0,210,"icon_achievement1",5,},
        [173] = {212002,0,0,0,2,"三英战吕布","己方只剩刘关张，敌方只剩吕布",212,2,1,1,5,1,50,0,0,0,211,"icon_achievement1",5,},
        [174] = {221001,0,0,0,2,"美女缘分","甄姬、黄月英、孙尚香、大小乔、貂蝉同时上场",221,2,1,1,5,1,50,0,0,0,212,"icon_achievement1",5,},
        [175] = {222002,0,0,0,2,"曹氏家族","曹丕、曹操、曹植、曹仁、曹冲同时上场",222,2,1,1,5,1,50,0,0,0,213,"icon_achievement1",5,},
        [176] = {223003,0,0,0,2,"孙氏家族","孙权、孙坚、孙策、孙尚香同时上场",223,2,1,1,5,1,50,0,0,0,214,"icon_achievement1",5,},
        [177] = {301001,0,0,0,2,"死不妥协","司马懿前3回合出手全是技能",301,2,1,1,5,1,50,0,0,0,215,"icon_achievement1",5,},
        [178] = {303001,0,0,0,2,"七进七出","赵云在3回合连续4次出手",303,2,1,1,5,1,50,0,0,0,216,"icon_achievement1",5,},
        [179] = {401001,0,0,0,2,"持久战","十回合内没有分出胜负",401,2,1,1,5,1,50,0,0,0,217,"icon_achievement1",5,},
        [180] = {402002,0,0,0,2,"探囊取物","首次出手敌方6人全灭",402,2,1,1,5,1,50,0,0,0,218,"icon_achievement1",5,},
        [181] = {501001,0,0,0,3,"幽冥诛仙刃","首次获得金将子上可领取25阶专属金色神兵",501,1,1,1,4,150,1,0,0,0,1,"150",5,},
        [182] = {502001,0,0,0,3,"苍松水韵琴","首次获得金将水镜可领取25阶专属金色神兵",502,1,1,1,4,250,1,0,0,0,2,"250",5,},
        [183] = {503001,0,0,0,3,"烈焰霓凰刀","首次获得金将周姬可领取25阶专属金色神兵",503,1,1,1,4,350,1,0,0,0,3,"350",5,},
        [184] = {504001,0,0,0,3,"延阳追魂杖","首次获得金将南华可领取25阶专属金色神兵",504,1,1,1,4,450,1,0,0,0,4,"450",5,},
        [185] = {501002,0,0,0,3,"千叶流霜刀","首次获得金将王异可领取25阶专属金色神兵",505,1,1,1,4,151,1,0,0,0,1,"151",5,},
        [186] = {502002,0,0,0,3,"神机灵巧牛","首次获得金将诸葛果可领取25阶专属金色神兵",506,1,1,1,4,251,1,0,0,0,2,"251",5,},
        [187] = {503002,0,0,0,3,"含光幻玉剑","首次获得金将陆抗可领取25阶专属金色神兵",507,1,1,1,4,351,1,0,0,0,3,"351",5,},
        [188] = {504002,0,0,0,3,"自在轻云烟","首次获得金将卢植可领取25阶专属金色神兵",508,1,1,1,4,451,1,0,0,0,4,"451",5,},
        [189] = {501003,0,0,0,3,"璇玑镇魂灯","首次获得金将管辂可领取25阶专属金色神兵",509,1,1,1,4,152,1,0,0,0,1,"152",5,},
        [190] = {502003,0,0,0,3,"灵霄穿云枪","首次获得金将马云禄可领取25阶专属金色神兵",510,1,1,1,4,252,1,0,0,0,2,"252",5,},
        [191] = {503003,0,0,0,3,"十方青玉刃","首次获得金将朱桓可领取25阶专属金色神兵",511,1,1,1,4,352,1,0,0,0,3,"352",5,},
        [192] = {504003,0,0,0,3,"灵觋破魔斧","首次获得金将木鹿大王可领取25阶专属金色神兵",512,1,1,1,4,452,1,0,0,0,4,"452",5,},
        [193] = {501004,0,0,0,3,"鬼灵奇韫笔","首次获得金将周不疑可领取25阶专属金色神兵",513,1,1,1,4,153,1,0,0,0,1,"153",5,},
        [194] = {502004,0,0,0,3,"百鸟朝凤枪","首次获得金将童渊可领取25阶专属金色神兵",514,1,1,1,4,253,1,0,0,0,2,"253",5,},
        [195] = {503004,0,0,0,3,"仙蝶凤箜篌","首次获得金将孙姬可领取25阶专属金色神兵",515,1,1,1,4,353,1,0,0,0,3,"353",5,},
        [196] = {504004,0,0,0,3,"寒冥破星锤","首次获得金将董白可领取25阶专属金色神兵",516,1,1,1,4,453,1,0,0,0,4,"453",5,},
    }
}

-- index
local __index_id = {
    [102001] = 1,
    [102002] = 2,
    [102003] = 3,
    [102004] = 4,
    [102005] = 5,
    [102006] = 6,
    [102007] = 7,
    [102008] = 8,
    [102009] = 9,
    [102010] = 10,
    [102011] = 11,
    [102012] = 12,
    [102013] = 13,
    [102014] = 14,
    [102015] = 15,
    [102016] = 16,
    [102017] = 17,
    [102018] = 18,
    [102019] = 19,
    [102020] = 20,
    [102021] = 21,
    [102022] = 22,
    [102023] = 23,
    [102024] = 24,
    [102025] = 25,
    [102026] = 26,
    [102027] = 27,
    [102028] = 28,
    [102029] = 29,
    [102030] = 30,
    [102031] = 31,
    [102032] = 32,
    [102033] = 33,
    [102034] = 34,
    [102035] = 35,
    [102036] = 36,
    [102037] = 37,
    [102038] = 38,
    [102039] = 39,
    [102040] = 40,
    [102041] = 41,
    [104001] = 42,
    [104002] = 43,
    [104003] = 44,
    [104004] = 45,
    [104005] = 46,
    [104006] = 47,
    [104007] = 48,
    [104008] = 49,
    [104009] = 50,
    [104010] = 51,
    [104011] = 52,
    [104012] = 53,
    [104013] = 54,
    [105001] = 55,
    [105002] = 56,
    [105003] = 57,
    [105004] = 58,
    [105005] = 59,
    [105006] = 60,
    [105007] = 61,
    [105008] = 62,
    [105009] = 63,
    [105010] = 64,
    [107001] = 65,
    [107002] = 66,
    [107003] = 67,
    [107004] = 68,
    [107005] = 69,
    [107006] = 70,
    [107007] = 71,
    [107008] = 72,
    [107009] = 73,
    [107010] = 74,
    [109001] = 75,
    [109002] = 76,
    [109003] = 77,
    [109004] = 78,
    [109005] = 79,
    [109006] = 80,
    [109007] = 81,
    [109008] = 82,
    [109009] = 83,
    [109010] = 84,
    [110001] = 85,
    [110002] = 86,
    [110003] = 87,
    [110004] = 88,
    [110005] = 89,
    [110006] = 90,
    [110007] = 91,
    [110008] = 92,
    [110009] = 93,
    [110010] = 94,
    [112001] = 95,
    [112002] = 96,
    [112003] = 97,
    [113001] = 98,
    [113002] = 99,
    [113003] = 100,
    [113004] = 101,
    [113005] = 102,
    [113006] = 103,
    [113007] = 104,
    [113008] = 105,
    [113009] = 106,
    [113010] = 107,
    [113011] = 108,
    [113012] = 109,
    [114001] = 110,
    [114002] = 111,
    [114003] = 112,
    [114004] = 113,
    [114005] = 114,
    [114006] = 115,
    [114007] = 116,
    [114008] = 117,
    [114009] = 118,
    [115001] = 119,
    [115002] = 120,
    [115003] = 121,
    [115004] = 122,
    [115005] = 123,
    [115006] = 124,
    [115007] = 125,
    [115008] = 126,
    [115009] = 127,
    [115010] = 128,
    [115011] = 129,
    [116001] = 130,
    [116002] = 131,
    [116003] = 132,
    [116004] = 133,
    [116005] = 134,
    [116006] = 135,
    [116007] = 136,
    [116008] = 137,
    [116009] = 138,
    [116010] = 139,
    [117001] = 140,
    [117002] = 141,
    [117003] = 142,
    [117004] = 143,
    [117005] = 144,
    [117006] = 145,
    [117007] = 146,
    [117008] = 147,
    [117009] = 148,
    [117010] = 149,
    [118001] = 150,
    [118002] = 151,
    [118003] = 152,
    [118004] = 153,
    [118005] = 154,
    [118006] = 155,
    [118007] = 156,
    [130001] = 157,
    [130002] = 158,
    [130003] = 159,
    [130004] = 160,
    [130005] = 161,
    [131001] = 162,
    [131002] = 163,
    [131003] = 164,
    [131004] = 165,
    [131005] = 166,
    [201001] = 167,
    [202002] = 168,
    [203003] = 169,
    [204004] = 170,
    [205005] = 171,
    [211001] = 172,
    [212002] = 173,
    [221001] = 174,
    [222002] = 175,
    [223003] = 176,
    [301001] = 177,
    [303001] = 178,
    [401001] = 179,
    [402002] = 180,
    [501001] = 181,
    [501002] = 185,
    [501003] = 189,
    [501004] = 193,
    [502001] = 182,
    [502002] = 186,
    [502003] = 190,
    [502004] = 194,
    [503001] = 183,
    [503002] = 187,
    [503003] = 191,
    [503004] = 195,
    [504001] = 184,
    [504002] = 188,
    [504003] = 192,
    [504004] = 196,

}

-- index mainkey map
local __main_key_map = {
    [1] = 102001,
    [2] = 102002,
    [3] = 102003,
    [4] = 102004,
    [5] = 102005,
    [6] = 102006,
    [7] = 102007,
    [8] = 102008,
    [9] = 102009,
    [10] = 102010,
    [11] = 102011,
    [12] = 102012,
    [13] = 102013,
    [14] = 102014,
    [15] = 102015,
    [16] = 102016,
    [17] = 102017,
    [18] = 102018,
    [19] = 102019,
    [20] = 102020,
    [21] = 102021,
    [22] = 102022,
    [23] = 102023,
    [24] = 102024,
    [25] = 102025,
    [26] = 102026,
    [27] = 102027,
    [28] = 102028,
    [29] = 102029,
    [30] = 102030,
    [31] = 102031,
    [32] = 102032,
    [33] = 102033,
    [34] = 102034,
    [35] = 102035,
    [36] = 102036,
    [37] = 102037,
    [38] = 102038,
    [39] = 102039,
    [40] = 102040,
    [41] = 102041,
    [42] = 104001,
    [43] = 104002,
    [44] = 104003,
    [45] = 104004,
    [46] = 104005,
    [47] = 104006,
    [48] = 104007,
    [49] = 104008,
    [50] = 104009,
    [51] = 104010,
    [52] = 104011,
    [53] = 104012,
    [54] = 104013,
    [55] = 105001,
    [56] = 105002,
    [57] = 105003,
    [58] = 105004,
    [59] = 105005,
    [60] = 105006,
    [61] = 105007,
    [62] = 105008,
    [63] = 105009,
    [64] = 105010,
    [65] = 107001,
    [66] = 107002,
    [67] = 107003,
    [68] = 107004,
    [69] = 107005,
    [70] = 107006,
    [71] = 107007,
    [72] = 107008,
    [73] = 107009,
    [74] = 107010,
    [75] = 109001,
    [76] = 109002,
    [77] = 109003,
    [78] = 109004,
    [79] = 109005,
    [80] = 109006,
    [81] = 109007,
    [82] = 109008,
    [83] = 109009,
    [84] = 109010,
    [85] = 110001,
    [86] = 110002,
    [87] = 110003,
    [88] = 110004,
    [89] = 110005,
    [90] = 110006,
    [91] = 110007,
    [92] = 110008,
    [93] = 110009,
    [94] = 110010,
    [95] = 112001,
    [96] = 112002,
    [97] = 112003,
    [98] = 113001,
    [99] = 113002,
    [100] = 113003,
    [101] = 113004,
    [102] = 113005,
    [103] = 113006,
    [104] = 113007,
    [105] = 113008,
    [106] = 113009,
    [107] = 113010,
    [108] = 113011,
    [109] = 113012,
    [110] = 114001,
    [111] = 114002,
    [112] = 114003,
    [113] = 114004,
    [114] = 114005,
    [115] = 114006,
    [116] = 114007,
    [117] = 114008,
    [118] = 114009,
    [119] = 115001,
    [120] = 115002,
    [121] = 115003,
    [122] = 115004,
    [123] = 115005,
    [124] = 115006,
    [125] = 115007,
    [126] = 115008,
    [127] = 115009,
    [128] = 115010,
    [129] = 115011,
    [130] = 116001,
    [131] = 116002,
    [132] = 116003,
    [133] = 116004,
    [134] = 116005,
    [135] = 116006,
    [136] = 116007,
    [137] = 116008,
    [138] = 116009,
    [139] = 116010,
    [140] = 117001,
    [141] = 117002,
    [142] = 117003,
    [143] = 117004,
    [144] = 117005,
    [145] = 117006,
    [146] = 117007,
    [147] = 117008,
    [148] = 117009,
    [149] = 117010,
    [150] = 118001,
    [151] = 118002,
    [152] = 118003,
    [153] = 118004,
    [154] = 118005,
    [155] = 118006,
    [156] = 118007,
    [157] = 130001,
    [158] = 130002,
    [159] = 130003,
    [160] = 130004,
    [161] = 130005,
    [162] = 131001,
    [163] = 131002,
    [164] = 131003,
    [165] = 131004,
    [166] = 131005,
    [167] = 201001,
    [168] = 202002,
    [169] = 203003,
    [170] = 204004,
    [171] = 205005,
    [172] = 211001,
    [173] = 212002,
    [174] = 221001,
    [175] = 222002,
    [176] = 223003,
    [177] = 301001,
    [178] = 303001,
    [179] = 401001,
    [180] = 402002,
    [181] = 501001,
    [185] = 501002,
    [189] = 501003,
    [193] = 501004,
    [182] = 502001,
    [186] = 502002,
    [190] = 502003,
    [194] = 502004,
    [183] = 503001,
    [187] = 503002,
    [191] = 503003,
    [195] = 503004,
    [184] = 504001,
    [188] = 504002,
    [192] = 504003,
    [196] = 504004,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in achievement")
        if _lang ~= "cn" and _isDataExist  and t._data_key_map[k] then
            return t._data[t._data_key_map[k]]
        end
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[key_map[k]]
    end
}

-- 
function achievement.length()
    return #achievement._data
end

-- 
function achievement.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function achievement.isVersionValid(v)
    if achievement.version then
        if v then
            return achievement.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function achievement.indexOf(index)
    if index == nil or not achievement._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/achievement.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/achievement.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/achievement.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "achievement" )
                _isDataExist = achievement.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "achievement" )
                _isBaseExist = achievement.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "achievement" )
                _isExist = achievement.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "achievement" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "achievement" )
        local main_key = __main_key_map[index]
		local index_key = "__index_id"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = achievement._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "achievement" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function achievement.get(id)
    
    return achievement.indexOf(__index_id[id])
        
end

--
function achievement.set(id, key, value)
    local record = achievement.get(id)
    if record then
        if _lang ~= "cn" and _isDataExist then
            local keyIndex =  record._data_key_map[key]
            if keyIndex then
                record._data[keyIndex] = value
                return
            end
        end
        if _lang ~= "cn" and _isExist then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
                return
            end
        end
        local keyIndex = record._raw_key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function achievement.index()
    return __index_id
end

return achievement