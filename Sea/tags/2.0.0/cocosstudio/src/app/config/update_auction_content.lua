--update_auction_content

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  reward_id = 2,    --奖励组id-int 
  auction_full_tab = 3,    --所属全服拍卖页签-int 
  type = 4,    --类型-int 
  value = 5,    --类型值id-int 
  size = 6,    --数量-int 
  produce_number1 = 7,    --产出组1数量-int 
  produce_probability1 = 8,    --产出组1权重-int 
  produce_number2 = 9,    --产出组2数量-int 
  produce_probability2 = 10,    --产出组2权重-int 
  produce_number3 = 11,    --产出组3数量-int 
  produce_probability3 = 12,    --产出组3权重-int 
  produce_number4 = 13,    --产出组4数量-int 
  produce_probability4 = 14,    --产出组4权重-int 
  produce_number5 = 15,    --产出组5数量-int 
  produce_probability5 = 16,    --产出组5权重-int 
  hero_order = 17,    --全服拍卖整将排序-int 
  order = 18,    --排序-int 
  start_price = 19,    --起拍价-int 
  fare = 20,    --加价-int 
  net = 21,    --一口价-int 
  redpacket_id = 22,    --红包类型-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  reward_id = "int",    --奖励组id-2 
  auction_full_tab = "int",    --所属全服拍卖页签-3 
  type = "int",    --类型-4 
  value = "int",    --类型值id-5 
  size = "int",    --数量-6 
  produce_number1 = "int",    --产出组1数量-7 
  produce_probability1 = "int",    --产出组1权重-8 
  produce_number2 = "int",    --产出组2数量-9 
  produce_probability2 = "int",    --产出组2权重-10 
  produce_number3 = "int",    --产出组3数量-11 
  produce_probability3 = "int",    --产出组3权重-12 
  produce_number4 = "int",    --产出组4数量-13 
  produce_probability4 = "int",    --产出组4权重-14 
  produce_number5 = "int",    --产出组5数量-15 
  produce_probability5 = "int",    --产出组5权重-16 
  hero_order = "int",    --全服拍卖整将排序-17 
  order = "int",    --排序-18 
  start_price = "int",    --起拍价-19 
  fare = "int",    --加价-20 
  net = "int",    --一口价-21 
  redpacket_id = "int",    --红包类型-22 

}


-- data
local update_auction_content = {
    _data = {
        [1] = {1,101,2,0,0,0,24,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [2] = {2,101,2,0,0,0,69,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [3] = {3,102,4,0,0,0,16,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [4] = {4,102,4,6,81,1,60,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [5] = {5,103,10,6,92,1,24,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [6] = {6,103,10,6,93,1,24,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [7] = {7,104,5,0,0,0,12,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [8] = {8,104,5,0,0,0,15,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [9] = {9,105,10,6,42,1,16,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [10] = {10,105,10,6,43,1,8,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [11] = {11,201,2,0,0,0,21,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [12] = {12,201,2,0,0,0,63,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [13] = {13,202,4,0,0,0,14,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [14] = {14,202,4,6,81,1,56,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [15] = {15,203,10,6,92,1,21,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [16] = {16,203,10,6,93,1,21,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [17] = {17,204,5,0,0,0,10,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [18] = {18,204,5,0,0,0,14,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [19] = {19,205,10,6,42,1,14,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [20] = {20,205,10,6,43,1,6,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [21] = {21,301,2,0,0,0,21,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [22] = {22,301,2,0,0,0,60,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [23] = {23,302,4,0,0,0,14,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [24] = {24,302,4,6,81,1,52,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [25] = {25,303,10,6,92,1,21,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [26] = {26,303,10,6,93,1,21,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [27] = {27,304,5,0,0,0,10,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [28] = {28,304,5,0,0,0,13,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [29] = {29,305,10,6,42,1,14,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [30] = {30,305,10,6,43,1,6,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [31] = {31,401,2,0,0,0,18,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [32] = {32,401,2,0,0,0,54,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [33] = {33,402,4,0,0,0,12,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [34] = {34,402,4,6,81,1,48,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [35] = {35,403,10,6,92,1,18,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [36] = {36,403,10,6,93,1,18,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [37] = {37,404,5,0,0,0,9,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [38] = {38,404,5,0,0,0,12,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [39] = {39,405,10,6,42,1,12,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [40] = {40,405,10,6,43,1,6,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [41] = {41,501,2,0,0,0,18,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [42] = {42,501,2,0,0,0,51,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [43] = {43,502,4,0,0,0,12,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [44] = {44,502,4,6,81,1,44,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [45] = {45,503,10,6,92,1,18,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [46] = {46,503,10,6,93,1,18,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [47] = {47,504,5,0,0,0,9,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [48] = {48,504,5,0,0,0,11,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [49] = {49,505,10,6,42,1,12,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [50] = {50,505,10,6,43,1,6,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [51] = {51,601,2,0,0,0,15,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [52] = {52,601,2,0,0,0,45,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [53] = {53,602,4,0,0,0,10,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [54] = {54,602,4,6,81,1,40,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [55] = {55,603,10,6,92,1,15,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [56] = {56,603,10,6,93,1,15,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [57] = {57,604,5,0,0,0,7,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [58] = {58,604,5,0,0,0,10,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [59] = {59,605,10,6,42,1,10,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [60] = {60,605,10,6,43,1,4,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [61] = {61,701,2,0,0,0,15,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [62] = {62,701,2,0,0,0,45,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [63] = {63,702,4,0,0,0,10,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [64] = {64,702,4,6,81,1,40,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [65] = {65,703,10,6,92,1,15,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [66] = {66,703,10,6,93,1,15,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [67] = {67,704,5,0,0,0,7,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [68] = {68,704,5,0,0,0,10,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [69] = {69,705,10,6,42,1,10,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [70] = {70,705,10,6,43,1,4,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [71] = {71,801,2,0,0,0,15,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [72] = {72,801,2,0,0,0,42,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [73] = {73,802,4,0,0,0,10,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [74] = {74,802,4,6,81,1,36,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [75] = {75,803,10,6,92,1,15,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [76] = {76,803,10,6,93,1,15,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [77] = {77,804,5,0,0,0,7,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [78] = {78,804,5,0,0,0,9,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [79] = {79,805,10,6,42,1,10,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [80] = {80,805,10,6,43,1,4,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [81] = {81,901,2,0,0,0,12,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [82] = {82,901,2,0,0,0,39,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [83] = {83,902,4,0,0,0,8,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [84] = {84,902,4,6,81,1,36,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [85] = {85,903,10,6,92,1,12,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [86] = {86,903,10,6,93,1,12,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [87] = {87,904,5,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [88] = {88,904,5,0,0,0,9,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [89] = {89,905,10,6,42,1,8,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [90] = {90,905,10,6,43,1,4,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [91] = {91,1001,2,0,0,0,12,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [92] = {92,1001,2,0,0,0,36,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [93] = {93,1002,4,0,0,0,8,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [94] = {94,1002,4,6,81,1,32,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [95] = {95,1003,10,6,92,1,12,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [96] = {96,1003,10,6,93,1,12,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [97] = {97,1004,5,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [98] = {98,1004,5,0,0,0,8,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [99] = {99,1005,10,6,42,1,8,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [100] = {100,1005,10,6,43,1,4,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [101] = {101,1101,2,0,0,0,12,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [102] = {102,1101,2,0,0,0,36,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [103] = {103,1102,4,0,0,0,8,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [104] = {104,1102,4,6,81,1,32,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [105] = {105,1103,10,6,92,1,12,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [106] = {106,1103,10,6,93,1,12,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [107] = {107,1104,5,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [108] = {108,1104,5,0,0,0,8,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [109] = {109,1105,10,6,42,1,8,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [110] = {110,1105,10,6,43,1,4,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [111] = {111,1201,2,0,0,0,12,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [112] = {112,1201,2,0,0,0,33,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [113] = {113,1202,4,0,0,0,8,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [114] = {114,1202,4,6,81,1,28,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [115] = {115,1203,10,6,92,1,12,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [116] = {116,1203,10,6,93,1,12,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [117] = {117,1204,5,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [118] = {118,1204,5,0,0,0,7,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [119] = {119,1205,10,6,42,1,8,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [120] = {120,1205,10,6,43,1,4,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [121] = {121,1301,2,0,0,0,9,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [122] = {122,1301,2,0,0,0,30,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [123] = {123,1302,4,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [124] = {124,1302,4,6,81,1,28,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [125] = {125,1303,10,6,92,1,9,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [126] = {126,1303,10,6,93,1,9,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [127] = {127,1304,5,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [128] = {128,1304,5,0,0,0,7,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [129] = {129,1305,10,6,42,1,6,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [130] = {130,1305,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [131] = {131,1401,2,0,0,0,9,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [132] = {132,1401,2,0,0,0,27,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [133] = {133,1402,4,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [134] = {134,1402,4,6,81,1,24,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [135] = {135,1403,10,6,92,1,9,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [136] = {136,1403,10,6,93,1,9,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [137] = {137,1404,5,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [138] = {138,1404,5,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [139] = {139,1405,10,6,42,1,6,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [140] = {140,1405,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [141] = {141,1501,2,0,0,0,9,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [142] = {142,1501,2,0,0,0,27,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [143] = {143,1502,4,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [144] = {144,1502,4,6,81,1,24,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [145] = {145,1503,10,6,92,1,9,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [146] = {146,1503,10,6,93,1,9,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [147] = {147,1504,5,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [148] = {148,1504,5,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [149] = {149,1505,10,6,42,1,6,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [150] = {150,1505,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [151] = {151,1601,2,0,0,0,9,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [152] = {152,1601,2,0,0,0,24,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [153] = {153,1602,4,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [154] = {154,1602,4,6,81,1,20,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [155] = {155,1603,10,6,92,1,9,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [156] = {156,1603,10,6,93,1,9,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [157] = {157,1604,5,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [158] = {158,1604,5,0,0,0,5,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [159] = {159,1605,10,6,42,1,6,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [160] = {160,1605,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [161] = {161,1701,2,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [162] = {162,1701,2,0,0,0,21,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [163] = {163,1702,4,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [164] = {164,1702,4,6,81,1,20,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [165] = {165,1703,10,6,92,1,6,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [166] = {166,1703,10,6,93,1,6,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [167] = {167,1704,5,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [168] = {168,1704,5,0,0,0,5,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [169] = {169,1705,10,6,42,1,4,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [170] = {170,1705,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [171] = {171,1801,2,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [172] = {172,1801,2,0,0,0,18,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [173] = {173,1802,4,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [174] = {174,1802,4,6,81,1,16,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [175] = {175,1803,10,6,92,1,6,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [176] = {176,1803,10,6,93,1,6,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [177] = {177,1804,5,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [178] = {178,1804,5,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [179] = {179,1805,10,6,42,1,4,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [180] = {180,1805,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [181] = {181,1901,2,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [182] = {182,1901,2,0,0,0,18,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [183] = {183,1902,4,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [184] = {184,1902,4,6,81,1,12,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [185] = {185,1903,10,6,92,1,6,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [186] = {186,1903,10,6,93,1,6,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [187] = {187,1904,5,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [188] = {188,1904,5,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [189] = {189,1905,10,6,42,1,4,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [190] = {190,1905,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [191] = {191,2001,2,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [192] = {192,2001,2,0,0,0,15,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [193] = {193,2002,4,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [194] = {194,2002,4,6,81,1,12,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [195] = {195,2003,10,6,92,1,6,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [196] = {196,2003,10,6,93,1,6,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [197] = {197,2004,5,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [198] = {198,2004,5,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [199] = {199,2005,10,6,42,1,4,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [200] = {200,2005,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [201] = {201,2101,2,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [202] = {202,2101,2,0,0,0,12,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [203] = {203,2102,4,0,0,0,4,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [204] = {204,2102,4,6,81,1,8,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [205] = {205,2103,10,6,92,1,6,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [206] = {206,2103,10,6,93,1,6,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [207] = {207,2104,5,0,0,0,1,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [208] = {208,2104,5,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [209] = {209,2105,10,6,42,1,2,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [210] = {210,2105,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [211] = {211,2201,2,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [212] = {212,2201,2,0,0,0,9,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [213] = {213,2202,4,0,0,0,2,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [214] = {214,2202,4,6,81,1,8,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [215] = {215,2203,10,6,92,1,3,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [216] = {216,2203,10,6,93,1,3,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [217] = {217,2204,5,0,0,0,1,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [218] = {218,2204,5,0,0,0,2,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [219] = {219,2205,10,6,42,1,2,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [220] = {220,2205,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [221] = {221,2301,2,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [222] = {222,2301,2,0,0,0,9,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [223] = {223,2302,4,0,0,0,2,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [224] = {224,2302,4,6,81,1,8,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [225] = {225,2303,10,6,92,1,3,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [226] = {226,2303,10,6,93,1,3,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [227] = {227,2304,5,0,0,0,0,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [228] = {228,2304,5,0,0,0,2,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [229] = {229,2305,10,6,42,1,2,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [230] = {230,2305,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [231] = {231,2401,2,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [232] = {232,2401,2,0,0,0,6,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [233] = {233,2402,4,0,0,0,2,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [234] = {234,2402,4,6,81,1,4,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [235] = {235,2403,10,6,92,1,3,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [236] = {236,2403,10,6,93,1,3,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [237] = {237,2404,5,0,0,0,0,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [238] = {238,2404,5,0,0,0,1,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [239] = {239,2405,10,6,42,1,2,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [240] = {240,2405,10,6,43,1,2,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
        [241] = {241,2501,2,0,0,0,0,1000,0,0,0,0,0,0,0,0,0,0,9600,1440,24000,1,},
        [242] = {242,2501,2,0,0,0,3,1000,0,0,0,0,0,0,0,0,0,0,400,60,1000,2,},
        [243] = {243,2502,4,0,0,0,0,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,3,},
        [244] = {244,2502,4,6,81,1,4,1000,0,0,0,0,0,0,0,0,0,0,1200,180,3000,4,},
        [245] = {245,2503,10,6,92,1,0,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,5,},
        [246] = {246,2503,10,6,93,1,0,1000,0,0,0,0,0,0,0,0,0,0,900,135,2250,6,},
        [247] = {247,2504,5,0,0,0,0,1000,0,0,0,0,0,0,0,0,0,0,9000,1350,22500,7,},
        [248] = {248,2504,5,0,0,0,1,1000,0,0,0,0,0,0,0,0,0,0,3000,450,7500,8,},
        [249] = {249,2505,10,6,42,1,0,1000,0,0,0,0,0,0,0,0,0,0,2980,447,7450,9,},
        [250] = {250,2505,10,6,43,1,0,1000,0,0,0,0,0,0,0,0,0,0,6480,972,16200,10,},
    }
}

-- index
local __index_id = {
    [1] = 1,
    [10] = 10,
    [100] = 100,
    [101] = 101,
    [102] = 102,
    [103] = 103,
    [104] = 104,
    [105] = 105,
    [106] = 106,
    [107] = 107,
    [108] = 108,
    [109] = 109,
    [11] = 11,
    [110] = 110,
    [111] = 111,
    [112] = 112,
    [113] = 113,
    [114] = 114,
    [115] = 115,
    [116] = 116,
    [117] = 117,
    [118] = 118,
    [119] = 119,
    [12] = 12,
    [120] = 120,
    [121] = 121,
    [122] = 122,
    [123] = 123,
    [124] = 124,
    [125] = 125,
    [126] = 126,
    [127] = 127,
    [128] = 128,
    [129] = 129,
    [13] = 13,
    [130] = 130,
    [131] = 131,
    [132] = 132,
    [133] = 133,
    [134] = 134,
    [135] = 135,
    [136] = 136,
    [137] = 137,
    [138] = 138,
    [139] = 139,
    [14] = 14,
    [140] = 140,
    [141] = 141,
    [142] = 142,
    [143] = 143,
    [144] = 144,
    [145] = 145,
    [146] = 146,
    [147] = 147,
    [148] = 148,
    [149] = 149,
    [15] = 15,
    [150] = 150,
    [151] = 151,
    [152] = 152,
    [153] = 153,
    [154] = 154,
    [155] = 155,
    [156] = 156,
    [157] = 157,
    [158] = 158,
    [159] = 159,
    [16] = 16,
    [160] = 160,
    [161] = 161,
    [162] = 162,
    [163] = 163,
    [164] = 164,
    [165] = 165,
    [166] = 166,
    [167] = 167,
    [168] = 168,
    [169] = 169,
    [17] = 17,
    [170] = 170,
    [171] = 171,
    [172] = 172,
    [173] = 173,
    [174] = 174,
    [175] = 175,
    [176] = 176,
    [177] = 177,
    [178] = 178,
    [179] = 179,
    [18] = 18,
    [180] = 180,
    [181] = 181,
    [182] = 182,
    [183] = 183,
    [184] = 184,
    [185] = 185,
    [186] = 186,
    [187] = 187,
    [188] = 188,
    [189] = 189,
    [19] = 19,
    [190] = 190,
    [191] = 191,
    [192] = 192,
    [193] = 193,
    [194] = 194,
    [195] = 195,
    [196] = 196,
    [197] = 197,
    [198] = 198,
    [199] = 199,
    [2] = 2,
    [20] = 20,
    [200] = 200,
    [201] = 201,
    [202] = 202,
    [203] = 203,
    [204] = 204,
    [205] = 205,
    [206] = 206,
    [207] = 207,
    [208] = 208,
    [209] = 209,
    [21] = 21,
    [210] = 210,
    [211] = 211,
    [212] = 212,
    [213] = 213,
    [214] = 214,
    [215] = 215,
    [216] = 216,
    [217] = 217,
    [218] = 218,
    [219] = 219,
    [22] = 22,
    [220] = 220,
    [221] = 221,
    [222] = 222,
    [223] = 223,
    [224] = 224,
    [225] = 225,
    [226] = 226,
    [227] = 227,
    [228] = 228,
    [229] = 229,
    [23] = 23,
    [230] = 230,
    [231] = 231,
    [232] = 232,
    [233] = 233,
    [234] = 234,
    [235] = 235,
    [236] = 236,
    [237] = 237,
    [238] = 238,
    [239] = 239,
    [24] = 24,
    [240] = 240,
    [241] = 241,
    [242] = 242,
    [243] = 243,
    [244] = 244,
    [245] = 245,
    [246] = 246,
    [247] = 247,
    [248] = 248,
    [249] = 249,
    [25] = 25,
    [250] = 250,
    [26] = 26,
    [27] = 27,
    [28] = 28,
    [29] = 29,
    [3] = 3,
    [30] = 30,
    [31] = 31,
    [32] = 32,
    [33] = 33,
    [34] = 34,
    [35] = 35,
    [36] = 36,
    [37] = 37,
    [38] = 38,
    [39] = 39,
    [4] = 4,
    [40] = 40,
    [41] = 41,
    [42] = 42,
    [43] = 43,
    [44] = 44,
    [45] = 45,
    [46] = 46,
    [47] = 47,
    [48] = 48,
    [49] = 49,
    [5] = 5,
    [50] = 50,
    [51] = 51,
    [52] = 52,
    [53] = 53,
    [54] = 54,
    [55] = 55,
    [56] = 56,
    [57] = 57,
    [58] = 58,
    [59] = 59,
    [6] = 6,
    [60] = 60,
    [61] = 61,
    [62] = 62,
    [63] = 63,
    [64] = 64,
    [65] = 65,
    [66] = 66,
    [67] = 67,
    [68] = 68,
    [69] = 69,
    [7] = 7,
    [70] = 70,
    [71] = 71,
    [72] = 72,
    [73] = 73,
    [74] = 74,
    [75] = 75,
    [76] = 76,
    [77] = 77,
    [78] = 78,
    [79] = 79,
    [8] = 8,
    [80] = 80,
    [81] = 81,
    [82] = 82,
    [83] = 83,
    [84] = 84,
    [85] = 85,
    [86] = 86,
    [87] = 87,
    [88] = 88,
    [89] = 89,
    [9] = 9,
    [90] = 90,
    [91] = 91,
    [92] = 92,
    [93] = 93,
    [94] = 94,
    [95] = 95,
    [96] = 96,
    [97] = 97,
    [98] = 98,
    [99] = 99,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in update_auction_content")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function update_auction_content.length()
    return #update_auction_content._data
end

-- 
function update_auction_content.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function update_auction_content.indexOf(index)
    if index == nil or not update_auction_content._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/update_auction_content.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "update_auction_content" )
        return setmetatable({_raw = update_auction_content._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = update_auction_content._data[index]}, mt)
end

--
function update_auction_content.get(id)
    
    return update_auction_content.indexOf(__index_id[id])
        
end

--
function update_auction_content.set(id, key, value)
    local record = update_auction_content.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function update_auction_content.index()
    return __index_id
end

return update_auction_content