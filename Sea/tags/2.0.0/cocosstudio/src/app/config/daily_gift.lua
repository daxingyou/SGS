--daily_gift

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --id-int 
  day_begin = 2,    --开始天数-int 
  day_end = 3,    --结束天数-int 
  hour_begin = 4,    --开始时间-int 
  hour_end = 5,    --结束时间-int 
  type_1 = 6,    --奖励类型1-int 
  value_1 = 7,    --类型值1-int 
  size_1 = 8,    --数量1-int 
  type_2 = 9,    --奖励类型2-int 
  value_2 = 10,    --类型值2-int 
  size_2 = 11,    --数量2-int 
  type_3 = 12,    --奖励类型3-int 
  value_3 = 13,    --类型值3-int 
  size_3 = 14,    --数量3-int 

}

-- key type
local __key_type = {
  id = "int",    --id-1 
  day_begin = "int",    --开始天数-2 
  day_end = "int",    --结束天数-3 
  hour_begin = "int",    --开始时间-4 
  hour_end = "int",    --结束时间-5 
  type_1 = "int",    --奖励类型1-6 
  value_1 = "int",    --类型值1-7 
  size_1 = "int",    --数量1-8 
  type_2 = "int",    --奖励类型2-9 
  value_2 = "int",    --类型值2-10 
  size_2 = "int",    --数量2-11 
  type_3 = "int",    --奖励类型3-12 
  value_3 = "int",    --类型值3-13 
  size_3 = "int",    --数量3-14 

}


-- data
local daily_gift = {
    _data = {
        [1] = {1,1,1,8,10,5,1,77,0,0,0,0,0,0,},
        [2] = {2,2,2,8,10,5,2,70000,0,0,0,0,0,0,},
        [3] = {3,3,3,8,10,6,21,1,0,0,0,0,0,0,},
        [4] = {4,4,4,8,10,6,3,50,0,0,0,0,0,0,},
        [5] = {5,5,5,8,10,6,19,50,0,0,0,0,0,0,},
        [6] = {6,6,6,8,10,6,20,1,0,0,0,0,0,0,},
        [7] = {7,7,7,8,10,5,2,70000,0,0,0,0,0,0,},
        [8] = {8,8,8,8,10,5,1,77,0,0,0,0,0,0,},
        [9] = {9,9,9,8,10,5,2,70000,0,0,0,0,0,0,},
        [10] = {10,10,10,8,10,6,21,1,0,0,0,0,0,0,},
        [11] = {11,11,11,8,10,6,3,50,0,0,0,0,0,0,},
        [12] = {12,12,12,8,10,6,19,50,0,0,0,0,0,0,},
        [13] = {13,13,13,8,10,6,20,1,0,0,0,0,0,0,},
        [14] = {14,14,14,8,10,5,2,70000,0,0,0,0,0,0,},
        [15] = {15,15,15,8,10,5,1,77,0,0,0,0,0,0,},
        [16] = {16,16,16,8,10,5,2,70000,0,0,0,0,0,0,},
        [17] = {17,17,17,8,10,6,21,1,0,0,0,0,0,0,},
        [18] = {18,18,18,8,10,6,3,50,0,0,0,0,0,0,},
        [19] = {19,19,19,8,10,6,19,50,0,0,0,0,0,0,},
        [20] = {20,20,20,8,10,6,20,1,0,0,0,0,0,0,},
        [21] = {21,21,21,8,10,5,2,70000,0,0,0,0,0,0,},
        [22] = {22,22,22,8,10,5,1,77,0,0,0,0,0,0,},
        [23] = {23,23,23,8,10,5,2,70000,0,0,0,0,0,0,},
        [24] = {24,24,24,8,10,6,21,1,0,0,0,0,0,0,},
        [25] = {25,25,25,8,10,6,3,50,0,0,0,0,0,0,},
        [26] = {26,26,26,8,10,6,19,50,0,0,0,0,0,0,},
        [27] = {27,27,27,8,10,6,20,1,0,0,0,0,0,0,},
        [28] = {28,28,28,8,10,5,2,70000,0,0,0,0,0,0,},
        [29] = {29,29,29,8,10,5,1,77,0,0,0,0,0,0,},
        [30] = {30,30,30,8,10,5,2,70000,0,0,0,0,0,0,},
        [31] = {31,31,31,8,10,6,21,1,0,0,0,0,0,0,},
        [32] = {32,32,32,8,10,6,3,50,0,0,0,0,0,0,},
        [33] = {33,33,33,8,10,6,19,50,0,0,0,0,0,0,},
        [34] = {34,34,34,8,10,6,20,1,0,0,0,0,0,0,},
        [35] = {35,35,35,8,10,5,2,70000,0,0,0,0,0,0,},
        [36] = {36,36,36,8,10,5,1,77,0,0,0,0,0,0,},
        [37] = {37,37,37,8,10,5,2,70000,0,0,0,0,0,0,},
        [38] = {38,38,38,8,10,6,21,1,0,0,0,0,0,0,},
        [39] = {39,39,39,8,10,6,3,50,0,0,0,0,0,0,},
        [40] = {40,40,40,8,10,6,19,50,0,0,0,0,0,0,},
        [41] = {41,41,41,8,10,6,20,1,0,0,0,0,0,0,},
        [42] = {42,42,42,8,10,5,2,70000,0,0,0,0,0,0,},
        [43] = {43,43,43,8,10,5,1,77,0,0,0,0,0,0,},
        [44] = {44,44,44,8,10,5,2,70000,0,0,0,0,0,0,},
        [45] = {45,45,45,8,10,6,21,1,0,0,0,0,0,0,},
        [46] = {46,46,46,8,10,6,3,50,0,0,0,0,0,0,},
        [47] = {47,47,47,8,10,6,19,50,0,0,0,0,0,0,},
        [48] = {48,48,48,8,10,6,20,1,0,0,0,0,0,0,},
        [49] = {49,49,49,8,10,5,2,70000,0,0,0,0,0,0,},
        [50] = {50,50,50,8,10,5,1,77,0,0,0,0,0,0,},
        [51] = {51,51,51,8,10,5,2,70000,0,0,0,0,0,0,},
        [52] = {52,52,52,8,10,6,21,1,0,0,0,0,0,0,},
        [53] = {53,53,53,8,10,6,3,50,0,0,0,0,0,0,},
        [54] = {54,54,54,8,10,6,19,50,0,0,0,0,0,0,},
        [55] = {55,55,55,8,10,6,20,1,0,0,0,0,0,0,},
        [56] = {56,56,56,8,10,5,2,70000,0,0,0,0,0,0,},
        [57] = {57,57,57,8,10,5,1,77,0,0,0,0,0,0,},
        [58] = {58,58,58,8,10,5,2,70000,0,0,0,0,0,0,},
        [59] = {59,59,59,8,10,6,21,1,0,0,0,0,0,0,},
        [60] = {60,60,60,8,10,6,3,50,0,0,0,0,0,0,},
        [61] = {61,61,61,8,10,6,19,50,0,0,0,0,0,0,},
        [62] = {62,62,62,8,10,6,20,1,0,0,0,0,0,0,},
        [63] = {63,63,63,8,10,5,2,70000,0,0,0,0,0,0,},
        [64] = {64,64,64,8,10,5,1,77,0,0,0,0,0,0,},
        [65] = {65,65,65,8,10,5,2,70000,0,0,0,0,0,0,},
        [66] = {66,66,66,8,10,6,21,1,0,0,0,0,0,0,},
        [67] = {67,67,67,8,10,6,3,50,0,0,0,0,0,0,},
        [68] = {68,68,68,8,10,6,19,50,0,0,0,0,0,0,},
        [69] = {69,69,69,8,10,6,20,1,0,0,0,0,0,0,},
        [70] = {70,70,70,8,10,5,2,70000,0,0,0,0,0,0,},
        [71] = {71,71,71,8,10,5,1,77,0,0,0,0,0,0,},
        [72] = {72,72,72,8,10,5,2,70000,0,0,0,0,0,0,},
        [73] = {73,73,73,8,10,6,21,1,0,0,0,0,0,0,},
        [74] = {74,74,74,8,10,6,3,50,0,0,0,0,0,0,},
        [75] = {75,75,75,8,10,6,19,50,0,0,0,0,0,0,},
        [76] = {76,76,76,8,10,6,20,1,0,0,0,0,0,0,},
        [77] = {77,77,77,8,10,5,2,70000,0,0,0,0,0,0,},
        [78] = {78,78,78,8,10,5,1,77,0,0,0,0,0,0,},
        [79] = {79,79,79,8,10,5,2,70000,0,0,0,0,0,0,},
        [80] = {80,80,80,8,10,6,21,1,0,0,0,0,0,0,},
        [81] = {81,81,81,8,10,6,3,50,0,0,0,0,0,0,},
        [82] = {82,82,82,8,10,6,19,50,0,0,0,0,0,0,},
        [83] = {83,83,83,8,10,6,20,1,0,0,0,0,0,0,},
        [84] = {84,84,84,8,10,5,2,70000,0,0,0,0,0,0,},
        [85] = {85,85,85,8,10,5,1,77,0,0,0,0,0,0,},
        [86] = {86,86,86,8,10,5,2,70000,0,0,0,0,0,0,},
        [87] = {87,87,87,8,10,6,21,1,0,0,0,0,0,0,},
        [88] = {88,88,88,8,10,6,3,50,0,0,0,0,0,0,},
        [89] = {89,89,89,8,10,6,19,50,0,0,0,0,0,0,},
        [90] = {90,90,90,8,10,6,20,1,0,0,0,0,0,0,},
        [91] = {91,91,91,8,10,5,2,70000,0,0,0,0,0,0,},
        [92] = {92,92,92,8,10,5,1,77,0,0,0,0,0,0,},
        [93] = {93,93,93,8,10,5,2,70000,0,0,0,0,0,0,},
        [94] = {94,94,94,8,10,6,21,1,0,0,0,0,0,0,},
        [95] = {95,95,95,8,10,6,3,50,0,0,0,0,0,0,},
        [96] = {96,96,96,8,10,6,19,50,0,0,0,0,0,0,},
        [97] = {97,97,97,8,10,6,20,1,0,0,0,0,0,0,},
        [98] = {98,98,98,8,10,5,2,70000,0,0,0,0,0,0,},
        [99] = {99,99,99,8,10,5,1,77,0,0,0,0,0,0,},
        [100] = {100,100,100,8,10,5,2,70000,0,0,0,0,0,0,},
        [101] = {101,101,101,8,10,6,21,1,0,0,0,0,0,0,},
        [102] = {102,102,102,8,10,6,3,50,0,0,0,0,0,0,},
        [103] = {103,103,103,8,10,6,19,50,0,0,0,0,0,0,},
        [104] = {104,104,104,8,10,6,20,1,0,0,0,0,0,0,},
        [105] = {105,105,105,8,10,5,2,70000,0,0,0,0,0,0,},
        [106] = {106,106,106,8,10,5,1,77,0,0,0,0,0,0,},
        [107] = {107,107,107,8,10,5,2,70000,0,0,0,0,0,0,},
        [108] = {108,108,108,8,10,6,21,1,0,0,0,0,0,0,},
        [109] = {109,109,109,8,10,6,3,50,0,0,0,0,0,0,},
        [110] = {110,110,110,8,10,6,19,50,0,0,0,0,0,0,},
        [111] = {111,111,111,8,10,6,20,1,0,0,0,0,0,0,},
        [112] = {112,112,112,8,10,5,2,70000,0,0,0,0,0,0,},
        [113] = {113,113,113,8,10,5,1,77,0,0,0,0,0,0,},
        [114] = {114,114,114,8,10,5,2,70000,0,0,0,0,0,0,},
        [115] = {115,115,115,8,10,6,21,1,0,0,0,0,0,0,},
        [116] = {116,116,116,8,10,6,3,50,0,0,0,0,0,0,},
        [117] = {117,117,117,8,10,6,19,50,0,0,0,0,0,0,},
        [118] = {118,118,118,8,10,6,20,1,0,0,0,0,0,0,},
        [119] = {119,119,119,8,10,5,2,70000,0,0,0,0,0,0,},
        [120] = {120,120,120,8,10,5,1,77,0,0,0,0,0,0,},
        [121] = {121,121,121,8,10,5,2,70000,0,0,0,0,0,0,},
        [122] = {122,122,122,8,10,6,21,1,0,0,0,0,0,0,},
        [123] = {123,123,123,8,10,6,3,50,0,0,0,0,0,0,},
        [124] = {124,124,124,8,10,6,19,50,0,0,0,0,0,0,},
        [125] = {125,125,125,8,10,6,20,1,0,0,0,0,0,0,},
        [126] = {126,126,126,8,10,5,2,70000,0,0,0,0,0,0,},
        [127] = {127,127,127,8,10,5,1,77,0,0,0,0,0,0,},
        [128] = {128,128,128,8,10,5,2,70000,0,0,0,0,0,0,},
        [129] = {129,129,129,8,10,6,21,1,0,0,0,0,0,0,},
        [130] = {130,130,130,8,10,6,3,50,0,0,0,0,0,0,},
        [131] = {131,131,131,8,10,6,19,50,0,0,0,0,0,0,},
        [132] = {132,132,132,8,10,6,20,1,0,0,0,0,0,0,},
        [133] = {133,133,133,8,10,5,2,70000,0,0,0,0,0,0,},
        [134] = {134,134,134,8,10,5,1,77,0,0,0,0,0,0,},
        [135] = {135,135,135,8,10,5,2,70000,0,0,0,0,0,0,},
        [136] = {136,136,136,8,10,6,21,1,0,0,0,0,0,0,},
        [137] = {137,137,137,8,10,6,3,50,0,0,0,0,0,0,},
        [138] = {138,138,138,8,10,6,19,50,0,0,0,0,0,0,},
        [139] = {139,139,139,8,10,6,20,1,0,0,0,0,0,0,},
        [140] = {140,140,140,8,10,5,2,70000,0,0,0,0,0,0,},
        [141] = {141,141,141,8,10,5,1,77,0,0,0,0,0,0,},
        [142] = {142,142,142,8,10,5,2,70000,0,0,0,0,0,0,},
        [143] = {143,143,143,8,10,6,21,1,0,0,0,0,0,0,},
        [144] = {144,144,144,8,10,6,3,50,0,0,0,0,0,0,},
        [145] = {145,145,145,8,10,6,19,50,0,0,0,0,0,0,},
        [146] = {146,146,146,8,10,6,20,1,0,0,0,0,0,0,},
        [147] = {147,147,147,8,10,5,2,70000,0,0,0,0,0,0,},
        [148] = {148,148,148,8,10,5,1,77,0,0,0,0,0,0,},
        [149] = {149,149,149,8,10,5,2,70000,0,0,0,0,0,0,},
        [150] = {150,150,150,8,10,6,21,1,0,0,0,0,0,0,},
        [151] = {151,151,151,8,10,6,3,50,0,0,0,0,0,0,},
        [152] = {152,152,152,8,10,6,19,50,0,0,0,0,0,0,},
        [153] = {153,153,153,8,10,6,20,1,0,0,0,0,0,0,},
        [154] = {154,154,154,8,10,5,2,70000,0,0,0,0,0,0,},
        [155] = {155,155,155,8,10,5,1,77,0,0,0,0,0,0,},
        [156] = {156,156,156,8,10,5,2,70000,0,0,0,0,0,0,},
        [157] = {157,157,157,8,10,6,21,1,0,0,0,0,0,0,},
        [158] = {158,158,158,8,10,6,3,50,0,0,0,0,0,0,},
        [159] = {159,159,159,8,10,6,19,50,0,0,0,0,0,0,},
        [160] = {160,160,160,8,10,6,20,1,0,0,0,0,0,0,},
        [161] = {161,161,161,8,10,5,2,70000,0,0,0,0,0,0,},
        [162] = {162,162,162,8,10,5,1,77,0,0,0,0,0,0,},
        [163] = {163,163,163,8,10,5,2,70000,0,0,0,0,0,0,},
        [164] = {164,164,164,8,10,6,21,1,0,0,0,0,0,0,},
        [165] = {165,165,165,8,10,6,3,50,0,0,0,0,0,0,},
        [166] = {166,166,166,8,10,6,19,50,0,0,0,0,0,0,},
        [167] = {167,167,167,8,10,6,20,1,0,0,0,0,0,0,},
        [168] = {168,168,168,8,10,5,2,70000,0,0,0,0,0,0,},
        [169] = {169,169,169,8,10,5,1,77,0,0,0,0,0,0,},
        [170] = {170,170,170,8,10,5,2,70000,0,0,0,0,0,0,},
        [171] = {171,171,171,8,10,6,21,1,0,0,0,0,0,0,},
        [172] = {172,172,172,8,10,6,3,50,0,0,0,0,0,0,},
        [173] = {173,173,173,8,10,6,19,50,0,0,0,0,0,0,},
        [174] = {174,174,174,8,10,6,20,1,0,0,0,0,0,0,},
        [175] = {175,175,175,8,10,5,2,70000,0,0,0,0,0,0,},
        [176] = {176,176,176,8,10,5,1,77,0,0,0,0,0,0,},
        [177] = {177,177,177,8,10,5,2,70000,0,0,0,0,0,0,},
        [178] = {178,178,178,8,10,6,21,1,0,0,0,0,0,0,},
        [179] = {179,179,179,8,10,6,3,50,0,0,0,0,0,0,},
        [180] = {180,180,180,8,10,6,19,50,0,0,0,0,0,0,},
        [181] = {181,181,181,8,10,6,20,1,0,0,0,0,0,0,},
        [182] = {182,182,182,8,10,5,2,70000,0,0,0,0,0,0,},
        [183] = {183,183,183,8,10,5,1,77,0,0,0,0,0,0,},
        [184] = {184,184,184,8,10,5,2,70000,0,0,0,0,0,0,},
        [185] = {185,185,185,8,10,6,21,1,0,0,0,0,0,0,},
        [186] = {186,186,186,8,10,6,3,50,0,0,0,0,0,0,},
        [187] = {187,187,187,8,10,6,19,50,0,0,0,0,0,0,},
        [188] = {188,188,188,8,10,6,20,1,0,0,0,0,0,0,},
        [189] = {189,189,189,8,10,5,2,70000,0,0,0,0,0,0,},
        [190] = {190,190,190,8,10,5,1,77,0,0,0,0,0,0,},
        [191] = {191,191,191,8,10,5,2,70000,0,0,0,0,0,0,},
        [192] = {192,192,192,8,10,6,21,1,0,0,0,0,0,0,},
        [193] = {193,193,193,8,10,6,3,50,0,0,0,0,0,0,},
        [194] = {194,194,194,8,10,6,19,50,0,0,0,0,0,0,},
        [195] = {195,195,195,8,10,6,20,1,0,0,0,0,0,0,},
        [196] = {196,196,196,8,10,5,2,70000,0,0,0,0,0,0,},
        [197] = {197,197,197,8,10,5,1,77,0,0,0,0,0,0,},
        [198] = {198,198,198,8,10,5,2,70000,0,0,0,0,0,0,},
        [199] = {199,199,199,8,10,6,21,1,0,0,0,0,0,0,},
        [200] = {200,200,200,8,10,6,3,50,0,0,0,0,0,0,},
        [201] = {201,201,201,8,10,6,19,50,0,0,0,0,0,0,},
        [202] = {202,202,202,8,10,6,20,1,0,0,0,0,0,0,},
        [203] = {203,203,203,8,10,5,2,70000,0,0,0,0,0,0,},
        [204] = {204,204,204,8,10,5,1,77,0,0,0,0,0,0,},
        [205] = {205,205,205,8,10,5,2,70000,0,0,0,0,0,0,},
        [206] = {206,206,206,8,10,6,21,1,0,0,0,0,0,0,},
        [207] = {207,207,207,8,10,6,3,50,0,0,0,0,0,0,},
        [208] = {208,208,208,8,10,6,19,50,0,0,0,0,0,0,},
        [209] = {209,209,209,8,10,6,20,1,0,0,0,0,0,0,},
        [210] = {210,210,210,8,10,5,2,70000,0,0,0,0,0,0,},
        [211] = {211,211,211,8,10,5,1,77,0,0,0,0,0,0,},
        [212] = {212,212,212,8,10,5,2,70000,0,0,0,0,0,0,},
        [213] = {213,213,213,8,10,6,21,1,0,0,0,0,0,0,},
        [214] = {214,214,214,8,10,6,3,50,0,0,0,0,0,0,},
        [215] = {215,215,215,8,10,6,19,50,0,0,0,0,0,0,},
        [216] = {216,216,216,8,10,6,20,1,0,0,0,0,0,0,},
        [217] = {217,217,217,8,10,5,2,70000,0,0,0,0,0,0,},
        [218] = {218,218,218,8,10,5,1,77,0,0,0,0,0,0,},
        [219] = {219,219,219,8,10,5,2,70000,0,0,0,0,0,0,},
        [220] = {220,220,220,8,10,6,21,1,0,0,0,0,0,0,},
        [221] = {221,221,221,8,10,6,3,50,0,0,0,0,0,0,},
        [222] = {222,222,222,8,10,6,19,50,0,0,0,0,0,0,},
        [223] = {223,223,223,8,10,6,20,1,0,0,0,0,0,0,},
        [224] = {224,224,224,8,10,5,2,70000,0,0,0,0,0,0,},
        [225] = {225,225,225,8,10,5,1,77,0,0,0,0,0,0,},
        [226] = {226,226,226,8,10,5,2,70000,0,0,0,0,0,0,},
        [227] = {227,227,227,8,10,6,21,1,0,0,0,0,0,0,},
        [228] = {228,228,228,8,10,6,3,50,0,0,0,0,0,0,},
        [229] = {229,229,229,8,10,6,19,50,0,0,0,0,0,0,},
        [230] = {230,230,230,8,10,6,20,1,0,0,0,0,0,0,},
        [231] = {231,231,231,8,10,5,2,70000,0,0,0,0,0,0,},
        [232] = {232,232,232,8,10,5,1,77,0,0,0,0,0,0,},
        [233] = {233,233,233,8,10,5,2,70000,0,0,0,0,0,0,},
        [234] = {234,234,234,8,10,6,21,1,0,0,0,0,0,0,},
        [235] = {235,235,235,8,10,6,3,50,0,0,0,0,0,0,},
        [236] = {236,236,236,8,10,6,19,50,0,0,0,0,0,0,},
        [237] = {237,237,237,8,10,6,20,1,0,0,0,0,0,0,},
        [238] = {238,238,238,8,10,5,2,70000,0,0,0,0,0,0,},
        [239] = {239,239,239,8,10,5,1,77,0,0,0,0,0,0,},
        [240] = {240,240,240,8,10,5,2,70000,0,0,0,0,0,0,},
        [241] = {241,241,241,8,10,6,21,1,0,0,0,0,0,0,},
        [242] = {242,242,242,8,10,6,3,50,0,0,0,0,0,0,},
        [243] = {243,243,243,8,10,6,19,50,0,0,0,0,0,0,},
        [244] = {244,244,244,8,10,6,20,1,0,0,0,0,0,0,},
        [245] = {245,245,245,8,10,5,2,70000,0,0,0,0,0,0,},
        [246] = {246,246,246,8,10,5,1,77,0,0,0,0,0,0,},
        [247] = {247,247,247,8,10,5,2,70000,0,0,0,0,0,0,},
        [248] = {248,248,248,8,10,6,21,1,0,0,0,0,0,0,},
        [249] = {249,249,249,8,10,6,3,50,0,0,0,0,0,0,},
        [250] = {250,250,250,8,10,6,19,50,0,0,0,0,0,0,},
        [251] = {251,251,251,8,10,6,20,1,0,0,0,0,0,0,},
        [252] = {252,252,252,8,10,5,2,70000,0,0,0,0,0,0,},
        [253] = {253,253,253,8,10,5,1,77,0,0,0,0,0,0,},
        [254] = {254,254,254,8,10,5,2,70000,0,0,0,0,0,0,},
        [255] = {255,255,255,8,10,6,21,1,0,0,0,0,0,0,},
        [256] = {256,256,256,8,10,6,3,50,0,0,0,0,0,0,},
        [257] = {257,257,257,8,10,6,19,50,0,0,0,0,0,0,},
        [258] = {258,258,258,8,10,6,20,1,0,0,0,0,0,0,},
        [259] = {259,259,259,8,10,5,2,70000,0,0,0,0,0,0,},
        [260] = {260,260,260,8,10,5,1,77,0,0,0,0,0,0,},
        [261] = {261,261,261,8,10,5,2,70000,0,0,0,0,0,0,},
        [262] = {262,262,262,8,10,6,21,1,0,0,0,0,0,0,},
        [263] = {263,263,263,8,10,6,3,50,0,0,0,0,0,0,},
        [264] = {264,264,264,8,10,6,19,50,0,0,0,0,0,0,},
        [265] = {265,265,265,8,10,6,20,1,0,0,0,0,0,0,},
        [266] = {266,266,266,8,10,5,2,70000,0,0,0,0,0,0,},
        [267] = {267,267,267,8,10,5,1,77,0,0,0,0,0,0,},
        [268] = {268,268,268,8,10,5,2,70000,0,0,0,0,0,0,},
        [269] = {269,269,269,8,10,6,21,1,0,0,0,0,0,0,},
        [270] = {270,270,270,8,10,6,3,50,0,0,0,0,0,0,},
        [271] = {271,271,271,8,10,6,19,50,0,0,0,0,0,0,},
        [272] = {272,272,272,8,10,6,20,1,0,0,0,0,0,0,},
        [273] = {273,273,273,8,10,5,2,70000,0,0,0,0,0,0,},
        [274] = {274,274,274,8,10,5,1,77,0,0,0,0,0,0,},
        [275] = {275,275,275,8,10,5,2,70000,0,0,0,0,0,0,},
        [276] = {276,276,276,8,10,6,21,1,0,0,0,0,0,0,},
        [277] = {277,277,277,8,10,6,3,50,0,0,0,0,0,0,},
        [278] = {278,278,278,8,10,6,19,50,0,0,0,0,0,0,},
        [279] = {279,279,279,8,10,6,20,1,0,0,0,0,0,0,},
        [280] = {280,280,280,8,10,5,2,70000,0,0,0,0,0,0,},
        [281] = {281,281,281,8,10,5,1,77,0,0,0,0,0,0,},
        [282] = {282,282,282,8,10,5,2,70000,0,0,0,0,0,0,},
        [283] = {283,283,283,8,10,6,21,1,0,0,0,0,0,0,},
        [284] = {284,284,284,8,10,6,3,50,0,0,0,0,0,0,},
        [285] = {285,285,285,8,10,6,19,50,0,0,0,0,0,0,},
        [286] = {286,286,286,8,10,6,20,1,0,0,0,0,0,0,},
        [287] = {287,287,287,8,10,5,2,70000,0,0,0,0,0,0,},
        [288] = {288,288,288,8,10,5,1,77,0,0,0,0,0,0,},
        [289] = {289,289,289,8,10,5,2,70000,0,0,0,0,0,0,},
        [290] = {290,290,290,8,10,6,21,1,0,0,0,0,0,0,},
        [291] = {291,291,291,8,10,6,3,50,0,0,0,0,0,0,},
        [292] = {292,292,292,8,10,6,19,50,0,0,0,0,0,0,},
        [293] = {293,293,293,8,10,6,20,1,0,0,0,0,0,0,},
        [294] = {294,294,294,8,10,5,2,70000,0,0,0,0,0,0,},
        [295] = {295,295,295,8,10,5,1,77,0,0,0,0,0,0,},
        [296] = {296,296,296,8,10,5,2,70000,0,0,0,0,0,0,},
        [297] = {297,297,297,8,10,6,21,1,0,0,0,0,0,0,},
        [298] = {298,298,298,8,10,6,3,50,0,0,0,0,0,0,},
        [299] = {299,299,299,8,10,6,19,50,0,0,0,0,0,0,},
        [300] = {300,300,300,8,10,6,20,1,0,0,0,0,0,0,},
        [301] = {301,301,301,8,10,5,2,70000,0,0,0,0,0,0,},
        [302] = {302,302,302,8,10,5,1,77,0,0,0,0,0,0,},
        [303] = {303,303,303,8,10,5,2,70000,0,0,0,0,0,0,},
        [304] = {304,304,304,8,10,6,21,1,0,0,0,0,0,0,},
        [305] = {305,305,305,8,10,6,3,50,0,0,0,0,0,0,},
        [306] = {306,306,306,8,10,6,19,50,0,0,0,0,0,0,},
        [307] = {307,307,307,8,10,6,20,1,0,0,0,0,0,0,},
        [308] = {308,308,308,8,10,5,2,70000,0,0,0,0,0,0,},
        [309] = {309,309,309,8,10,5,1,77,0,0,0,0,0,0,},
        [310] = {310,310,310,8,10,5,2,70000,0,0,0,0,0,0,},
        [311] = {311,311,311,8,10,6,21,1,0,0,0,0,0,0,},
        [312] = {312,312,312,8,10,6,3,50,0,0,0,0,0,0,},
        [313] = {313,313,313,8,10,6,19,50,0,0,0,0,0,0,},
        [314] = {314,314,314,8,10,6,20,1,0,0,0,0,0,0,},
        [315] = {315,315,315,8,10,5,2,70000,0,0,0,0,0,0,},
        [316] = {316,316,316,8,10,5,1,77,0,0,0,0,0,0,},
        [317] = {317,317,317,8,10,5,2,70000,0,0,0,0,0,0,},
        [318] = {318,318,318,8,10,6,21,1,0,0,0,0,0,0,},
        [319] = {319,319,319,8,10,6,3,50,0,0,0,0,0,0,},
        [320] = {320,320,320,8,10,6,19,50,0,0,0,0,0,0,},
        [321] = {321,321,321,8,10,6,20,1,0,0,0,0,0,0,},
        [322] = {322,322,322,8,10,5,2,70000,0,0,0,0,0,0,},
        [323] = {323,323,323,8,10,5,1,77,0,0,0,0,0,0,},
        [324] = {324,324,324,8,10,5,2,70000,0,0,0,0,0,0,},
        [325] = {325,325,325,8,10,6,21,1,0,0,0,0,0,0,},
        [326] = {326,326,326,8,10,6,3,50,0,0,0,0,0,0,},
        [327] = {327,327,327,8,10,6,19,50,0,0,0,0,0,0,},
        [328] = {328,328,328,8,10,6,20,1,0,0,0,0,0,0,},
        [329] = {329,329,329,8,10,5,2,70000,0,0,0,0,0,0,},
        [330] = {330,330,330,8,10,5,1,77,0,0,0,0,0,0,},
        [331] = {331,331,331,8,10,5,2,70000,0,0,0,0,0,0,},
        [332] = {332,332,332,8,10,6,21,1,0,0,0,0,0,0,},
        [333] = {333,333,333,8,10,6,3,50,0,0,0,0,0,0,},
        [334] = {334,334,334,8,10,6,19,50,0,0,0,0,0,0,},
        [335] = {335,335,335,8,10,6,20,1,0,0,0,0,0,0,},
        [336] = {336,336,336,8,10,5,2,70000,0,0,0,0,0,0,},
        [337] = {337,337,337,8,10,5,1,77,0,0,0,0,0,0,},
        [338] = {338,338,338,8,10,5,2,70000,0,0,0,0,0,0,},
        [339] = {339,339,339,8,10,6,21,1,0,0,0,0,0,0,},
        [340] = {340,340,340,8,10,6,3,50,0,0,0,0,0,0,},
        [341] = {341,341,341,8,10,6,19,50,0,0,0,0,0,0,},
        [342] = {342,342,342,8,10,6,20,1,0,0,0,0,0,0,},
        [343] = {343,343,343,8,10,5,2,70000,0,0,0,0,0,0,},
        [344] = {344,344,344,8,10,5,1,77,0,0,0,0,0,0,},
        [345] = {345,345,345,8,10,5,2,70000,0,0,0,0,0,0,},
        [346] = {346,346,346,8,10,6,21,1,0,0,0,0,0,0,},
        [347] = {347,347,347,8,10,6,3,50,0,0,0,0,0,0,},
        [348] = {348,348,348,8,10,6,19,50,0,0,0,0,0,0,},
        [349] = {349,349,349,8,10,6,20,1,0,0,0,0,0,0,},
        [350] = {350,350,350,8,10,5,2,70000,0,0,0,0,0,0,},
        [351] = {351,351,351,8,10,5,1,77,0,0,0,0,0,0,},
        [352] = {352,352,352,8,10,5,2,70000,0,0,0,0,0,0,},
        [353] = {353,353,353,8,10,6,21,1,0,0,0,0,0,0,},
        [354] = {354,354,354,8,10,6,3,50,0,0,0,0,0,0,},
        [355] = {355,355,355,8,10,6,19,50,0,0,0,0,0,0,},
        [356] = {356,356,356,8,10,6,20,1,0,0,0,0,0,0,},
        [357] = {357,357,357,8,10,5,2,70000,0,0,0,0,0,0,},
        [358] = {358,358,358,8,10,5,1,77,0,0,0,0,0,0,},
        [359] = {359,359,359,8,10,5,2,70000,0,0,0,0,0,0,},
        [360] = {360,360,360,8,10,6,21,1,0,0,0,0,0,0,},
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
    [251] = 251,
    [252] = 252,
    [253] = 253,
    [254] = 254,
    [255] = 255,
    [256] = 256,
    [257] = 257,
    [258] = 258,
    [259] = 259,
    [26] = 26,
    [260] = 260,
    [261] = 261,
    [262] = 262,
    [263] = 263,
    [264] = 264,
    [265] = 265,
    [266] = 266,
    [267] = 267,
    [268] = 268,
    [269] = 269,
    [27] = 27,
    [270] = 270,
    [271] = 271,
    [272] = 272,
    [273] = 273,
    [274] = 274,
    [275] = 275,
    [276] = 276,
    [277] = 277,
    [278] = 278,
    [279] = 279,
    [28] = 28,
    [280] = 280,
    [281] = 281,
    [282] = 282,
    [283] = 283,
    [284] = 284,
    [285] = 285,
    [286] = 286,
    [287] = 287,
    [288] = 288,
    [289] = 289,
    [29] = 29,
    [290] = 290,
    [291] = 291,
    [292] = 292,
    [293] = 293,
    [294] = 294,
    [295] = 295,
    [296] = 296,
    [297] = 297,
    [298] = 298,
    [299] = 299,
    [3] = 3,
    [30] = 30,
    [300] = 300,
    [301] = 301,
    [302] = 302,
    [303] = 303,
    [304] = 304,
    [305] = 305,
    [306] = 306,
    [307] = 307,
    [308] = 308,
    [309] = 309,
    [31] = 31,
    [310] = 310,
    [311] = 311,
    [312] = 312,
    [313] = 313,
    [314] = 314,
    [315] = 315,
    [316] = 316,
    [317] = 317,
    [318] = 318,
    [319] = 319,
    [32] = 32,
    [320] = 320,
    [321] = 321,
    [322] = 322,
    [323] = 323,
    [324] = 324,
    [325] = 325,
    [326] = 326,
    [327] = 327,
    [328] = 328,
    [329] = 329,
    [33] = 33,
    [330] = 330,
    [331] = 331,
    [332] = 332,
    [333] = 333,
    [334] = 334,
    [335] = 335,
    [336] = 336,
    [337] = 337,
    [338] = 338,
    [339] = 339,
    [34] = 34,
    [340] = 340,
    [341] = 341,
    [342] = 342,
    [343] = 343,
    [344] = 344,
    [345] = 345,
    [346] = 346,
    [347] = 347,
    [348] = 348,
    [349] = 349,
    [35] = 35,
    [350] = 350,
    [351] = 351,
    [352] = 352,
    [353] = 353,
    [354] = 354,
    [355] = 355,
    [356] = 356,
    [357] = 357,
    [358] = 358,
    [359] = 359,
    [36] = 36,
    [360] = 360,
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
        assert(__key_map[k], "cannot find " .. k .. " in daily_gift")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function daily_gift.length()
    return #daily_gift._data
end

-- 
function daily_gift.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function daily_gift.indexOf(index)
    if index == nil or not daily_gift._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/daily_gift.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "daily_gift" )
        return setmetatable({_raw = daily_gift._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = daily_gift._data[index]}, mt)
end

--
function daily_gift.get(id)
    
    return daily_gift.indexOf(__index_id[id])
        
end

--
function daily_gift.set(id, key, value)
    local record = daily_gift.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function daily_gift.index()
    return __index_id
end

return daily_gift