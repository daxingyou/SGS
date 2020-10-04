--treasure_levelup

local _lang = "cn"
local _isExist = false
local _isBaseExist = false
local _isDataExist = false

-- key
local __key_map = {
  level = 1,    --宝物等级-int 
  templet = 2,    --经验模板-int 
  exp = 3,    --强化经验-int 
  levelup_type_1 = 4,    --强化1属性类型-int 
  levelup_value_1 = 5,    --强化1属性数值-int 
  levelup_type_2 = 6,    --强化2属性类型-int 
  levelup_value_2 = 7,    --强化2属性数值-int 

}

-- key type
local __key_type = {
  level = "int",    --宝物等级-1 
  templet = "int",    --经验模板-2 
  exp = "int",    --强化经验-3 
  levelup_type_1 = "int",    --强化1属性类型-4 
  levelup_value_1 = "int",    --强化1属性数值-5 
  levelup_type_2 = "int",    --强化2属性类型-6 
  levelup_value_2 = "int",    --强化2属性数值-7 

}


-- data
local treasure_levelup = {
    version =  1,
    _data = {
        [1] = {1,1,600,1,300,7,2250,},
        [2] = {2,1,720,1,24,7,183,},
        [3] = {3,1,840,1,24,7,186,},
        [4] = {4,1,960,1,24,7,189,},
        [5] = {5,1,1080,1,27,7,192,},
        [6] = {6,1,1200,1,27,7,195,},
        [7] = {7,1,1320,1,27,7,201,},
        [8] = {8,1,1440,1,27,7,210,},
        [9] = {9,1,1560,1,30,7,216,},
        [10] = {10,1,1680,1,30,7,222,},
        [11] = {11,1,1800,1,30,7,231,},
        [12] = {12,1,2040,1,33,7,240,},
        [13] = {13,1,2280,1,33,7,252,},
        [14] = {14,1,2520,1,36,7,264,},
        [15] = {15,1,2760,1,36,7,276,},
        [16] = {16,1,3000,1,39,7,288,},
        [17] = {17,1,3300,1,39,7,303,},
        [18] = {18,1,3600,1,42,7,321,},
        [19] = {19,1,3900,1,45,7,339,},
        [20] = {20,1,4200,1,48,7,354,},
        [21] = {21,1,4440,1,51,7,372,},
        [22] = {22,1,4980,1,54,7,393,},
        [23] = {23,1,5520,1,57,7,417,},
        [24] = {24,1,6060,1,60,7,444,},
        [25] = {25,1,6600,1,63,7,468,},
        [26] = {26,1,7500,1,66,7,492,},
        [27] = {27,1,8640,1,69,7,519,},
        [28] = {28,1,9840,1,75,7,552,},
        [29] = {29,1,11040,1,78,7,585,},
        [30] = {30,1,12240,1,81,7,618,},
        [31] = {31,1,14040,1,87,7,651,},
        [32] = {32,1,16560,1,93,7,687,},
        [33] = {33,1,19020,1,96,7,729,},
        [34] = {34,1,21540,1,102,7,771,},
        [35] = {35,1,24000,1,108,7,810,},
        [36] = {36,1,27360,1,114,7,852,},
        [37] = {37,1,31560,1,120,7,900,},
        [38] = {38,1,35760,1,126,7,951,},
        [39] = {39,1,39960,1,135,7,1002,},
        [40] = {40,1,44220,1,141,7,1053,},
        [41] = {41,1,49500,1,147,7,1104,},
        [42] = {42,1,55860,1,156,7,1161,},
        [43] = {43,1,62220,1,162,7,1224,},
        [44] = {44,1,68580,1,171,7,1287,},
        [45] = {45,1,75000,1,180,7,1350,},
        [46] = {46,1,82740,1,189,7,1413,},
        [47] = {47,1,91920,1,198,7,1482,},
        [48] = {48,1,101100,1,207,7,1557,},
        [49] = {49,1,110280,1,216,7,1632,},
        [50] = {50,1,119460,1,228,7,1707,},
        [51] = {51,1,130380,1,237,7,1782,},
        [52] = {52,1,143040,1,249,7,1863,},
        [53] = {53,1,155640,1,261,7,1950,},
        [54] = {54,1,168300,1,273,7,2040,},
        [55] = {55,1,180900,1,285,7,2127,},
        [56] = {56,1,195720,1,294,7,2214,},
        [57] = {57,1,212700,1,309,7,2310,},
        [58] = {58,1,229620,1,321,7,2412,},
        [59] = {59,1,246600,1,336,7,2517,},
        [60] = {60,1,263520,1,348,7,2619,},
        [61] = {1,2,800,1,500,7,3750,},
        [62] = {2,2,960,1,40,7,305,},
        [63] = {3,2,1120,1,40,7,310,},
        [64] = {4,2,1280,1,40,7,315,},
        [65] = {5,2,1440,1,45,7,320,},
        [66] = {6,2,1600,1,45,7,325,},
        [67] = {7,2,1760,1,45,7,335,},
        [68] = {8,2,1920,1,45,7,350,},
        [69] = {9,2,2080,1,50,7,360,},
        [70] = {10,2,2240,1,50,7,370,},
        [71] = {11,2,2400,1,50,7,385,},
        [72] = {12,2,2720,1,55,7,400,},
        [73] = {13,2,3040,1,55,7,420,},
        [74] = {14,2,3360,1,60,7,440,},
        [75] = {15,2,3680,1,60,7,460,},
        [76] = {16,2,4000,1,65,7,480,},
        [77] = {17,2,4400,1,65,7,505,},
        [78] = {18,2,4800,1,70,7,535,},
        [79] = {19,2,5200,1,75,7,565,},
        [80] = {20,2,5600,1,80,7,590,},
        [81] = {21,2,5920,1,85,7,620,},
        [82] = {22,2,6640,1,90,7,655,},
        [83] = {23,2,7360,1,95,7,695,},
        [84] = {24,2,8080,1,100,7,740,},
        [85] = {25,2,8800,1,105,7,780,},
        [86] = {26,2,10000,1,110,7,820,},
        [87] = {27,2,11520,1,115,7,865,},
        [88] = {28,2,13120,1,125,7,920,},
        [89] = {29,2,14720,1,130,7,975,},
        [90] = {30,2,16320,1,135,7,1030,},
        [91] = {31,2,18720,1,145,7,1085,},
        [92] = {32,2,22080,1,155,7,1145,},
        [93] = {33,2,25360,1,160,7,1215,},
        [94] = {34,2,28720,1,170,7,1285,},
        [95] = {35,2,32000,1,180,7,1350,},
        [96] = {36,2,36480,1,190,7,1420,},
        [97] = {37,2,42080,1,200,7,1500,},
        [98] = {38,2,47680,1,210,7,1585,},
        [99] = {39,2,53280,1,225,7,1670,},
        [100] = {40,2,58960,1,235,7,1755,},
        [101] = {41,2,66000,1,245,7,1840,},
        [102] = {42,2,74480,1,260,7,1935,},
        [103] = {43,2,82960,1,270,7,2040,},
        [104] = {44,2,91440,1,285,7,2145,},
        [105] = {45,2,100000,1,300,7,2250,},
        [106] = {46,2,110320,1,315,7,2355,},
        [107] = {47,2,122560,1,330,7,2470,},
        [108] = {48,2,134800,1,345,7,2595,},
        [109] = {49,2,147040,1,360,7,2720,},
        [110] = {50,2,159280,1,380,7,2845,},
        [111] = {51,2,173840,1,395,7,2970,},
        [112] = {52,2,190720,1,415,7,3105,},
        [113] = {53,2,207520,1,435,7,3250,},
        [114] = {54,2,224400,1,455,7,3400,},
        [115] = {55,2,241200,1,475,7,3545,},
        [116] = {56,2,260960,1,490,7,3690,},
        [117] = {57,2,283600,1,515,7,3850,},
        [118] = {58,2,306160,1,535,7,4020,},
        [119] = {59,2,328800,1,560,7,4195,},
        [120] = {60,2,351360,1,580,7,4365,},
        [121] = {1,3,1000,1,2400,7,18000,},
        [122] = {2,3,1200,1,80,7,610,},
        [123] = {3,3,1400,1,80,7,620,},
        [124] = {4,3,1600,1,80,7,630,},
        [125] = {5,3,1800,1,90,7,640,},
        [126] = {6,3,2000,1,90,7,650,},
        [127] = {7,3,2200,1,90,7,670,},
        [128] = {8,3,2400,1,90,7,700,},
        [129] = {9,3,2600,1,100,7,720,},
        [130] = {10,3,2800,1,100,7,740,},
        [131] = {11,3,3000,1,100,7,770,},
        [132] = {12,3,3400,1,110,7,800,},
        [133] = {13,3,3800,1,110,7,840,},
        [134] = {14,3,4200,1,120,7,880,},
        [135] = {15,3,4600,1,120,7,920,},
        [136] = {16,3,5000,1,130,7,960,},
        [137] = {17,3,5500,1,130,7,1010,},
        [138] = {18,3,6000,1,140,7,1070,},
        [139] = {19,3,6500,1,150,7,1130,},
        [140] = {20,3,7000,1,160,7,1180,},
        [141] = {21,3,7400,1,170,7,1240,},
        [142] = {22,3,8300,1,180,7,1310,},
        [143] = {23,3,9200,1,190,7,1390,},
        [144] = {24,3,10100,1,200,7,1480,},
        [145] = {25,3,11000,1,210,7,1560,},
        [146] = {26,3,12500,1,220,7,1640,},
        [147] = {27,3,14400,1,230,7,1730,},
        [148] = {28,3,16400,1,250,7,1840,},
        [149] = {29,3,18400,1,260,7,1950,},
        [150] = {30,3,20400,1,270,7,2060,},
        [151] = {31,3,23400,1,290,7,2170,},
        [152] = {32,3,27600,1,310,7,2290,},
        [153] = {33,3,31700,1,320,7,2430,},
        [154] = {34,3,35900,1,340,7,2570,},
        [155] = {35,3,40000,1,360,7,2700,},
        [156] = {36,3,45600,1,380,7,2840,},
        [157] = {37,3,52600,1,400,7,3000,},
        [158] = {38,3,59600,1,420,7,3170,},
        [159] = {39,3,66600,1,450,7,3340,},
        [160] = {40,3,73700,1,470,7,3510,},
        [161] = {41,3,82500,1,490,7,3680,},
        [162] = {42,3,93100,1,520,7,3870,},
        [163] = {43,3,103700,1,540,7,4080,},
        [164] = {44,3,114300,1,570,7,4290,},
        [165] = {45,3,125000,1,600,7,4500,},
        [166] = {46,3,137900,1,630,7,4710,},
        [167] = {47,3,153200,1,660,7,4940,},
        [168] = {48,3,168500,1,690,7,5190,},
        [169] = {49,3,183800,1,720,7,5440,},
        [170] = {50,3,199100,1,760,7,5690,},
        [171] = {51,3,217300,1,790,7,5940,},
        [172] = {52,3,238400,1,830,7,6210,},
        [173] = {53,3,259400,1,870,7,6500,},
        [174] = {54,3,280500,1,910,7,6800,},
        [175] = {55,3,301500,1,950,7,7090,},
        [176] = {56,3,326200,1,980,7,7380,},
        [177] = {57,3,354500,1,1030,7,7700,},
        [178] = {58,3,382700,1,1070,7,8040,},
        [179] = {59,3,411000,1,1120,7,8390,},
        [180] = {60,3,439200,1,1160,7,8730,},
        [181] = {1,4,1000,1,7400,7,55500,},
        [182] = {2,4,1200,1,80,7,610,},
        [183] = {3,4,1400,1,80,7,620,},
        [184] = {4,4,1600,1,80,7,630,},
        [185] = {5,4,1800,1,90,7,640,},
        [186] = {6,4,2000,1,90,7,650,},
        [187] = {7,4,2200,1,90,7,670,},
        [188] = {8,4,2400,1,90,7,700,},
        [189] = {9,4,2600,1,100,7,720,},
        [190] = {10,4,2800,1,100,7,740,},
        [191] = {11,4,3000,1,100,7,770,},
        [192] = {12,4,3400,1,110,7,800,},
        [193] = {13,4,3800,1,110,7,840,},
        [194] = {14,4,4200,1,120,7,880,},
        [195] = {15,4,4600,1,120,7,920,},
        [196] = {16,4,5000,1,130,7,960,},
        [197] = {17,4,5500,1,130,7,1010,},
        [198] = {18,4,6000,1,140,7,1070,},
        [199] = {19,4,6500,1,150,7,1130,},
        [200] = {20,4,7000,1,160,7,1180,},
        [201] = {21,4,7400,1,170,7,1240,},
        [202] = {22,4,8300,1,180,7,1310,},
        [203] = {23,4,9200,1,190,7,1390,},
        [204] = {24,4,10100,1,200,7,1480,},
        [205] = {25,4,11000,1,210,7,1560,},
        [206] = {26,4,12500,1,220,7,1640,},
        [207] = {27,4,14400,1,230,7,1730,},
        [208] = {28,4,16400,1,250,7,1840,},
        [209] = {29,4,18400,1,260,7,1950,},
        [210] = {30,4,20400,1,270,7,2060,},
        [211] = {31,4,23400,1,290,7,2170,},
        [212] = {32,4,27600,1,310,7,2290,},
        [213] = {33,4,31700,1,320,7,2430,},
        [214] = {34,4,35900,1,340,7,2570,},
        [215] = {35,4,40000,1,360,7,2700,},
        [216] = {36,4,45600,1,380,7,2840,},
        [217] = {37,4,52600,1,400,7,3000,},
        [218] = {38,4,59600,1,420,7,3170,},
        [219] = {39,4,66600,1,450,7,3340,},
        [220] = {40,4,73700,1,470,7,3510,},
        [221] = {41,4,82500,1,490,7,3680,},
        [222] = {42,4,93100,1,520,7,3870,},
        [223] = {43,4,103700,1,540,7,4080,},
        [224] = {44,4,114300,1,570,7,4290,},
        [225] = {45,4,125000,1,600,7,4500,},
        [226] = {46,4,137900,1,630,7,4710,},
        [227] = {47,4,153200,1,660,7,4940,},
        [228] = {48,4,168500,1,690,7,5190,},
        [229] = {49,4,183800,1,720,7,5440,},
        [230] = {50,4,199100,1,760,7,5690,},
        [231] = {51,4,217300,1,790,7,5940,},
        [232] = {52,4,238400,1,830,7,6210,},
        [233] = {53,4,259400,1,870,7,6500,},
        [234] = {54,4,280500,1,910,7,6800,},
        [235] = {55,4,301500,1,950,7,7090,},
        [236] = {56,4,326200,1,980,7,7380,},
        [237] = {57,4,354500,1,1030,7,7700,},
        [238] = {58,4,382700,1,1070,7,8040,},
        [239] = {59,4,411000,1,1120,7,8390,},
        [240] = {60,4,439200,1,1160,7,8730,},
        [241] = {61,4,470400,1,1210,7,9070,},
        [242] = {62,4,505900,1,1250,7,9410,},
        [243] = {63,4,541300,1,1300,7,9750,},
        [244] = {64,4,576800,1,1350,7,10120,},
        [245] = {65,4,612200,1,1400,7,10510,},
        [246] = {66,4,650900,1,1450,7,10900,},
        [247] = {67,4,694600,1,1510,7,11290,},
        [248] = {68,4,738200,1,1560,7,11680,},
        [249] = {69,4,781900,1,1610,7,12100,},
        [250] = {70,4,825500,1,1670,7,12540,},
        [251] = {71,4,872700,1,1730,7,12990,},
        [252] = {72,4,925600,1,1790,7,13430,},
        [253] = {73,4,978400,1,1850,7,13880,},
        [254] = {74,4,1031300,1,1910,7,14360,},
        [255] = {75,4,1084100,1,1980,7,14860,},
        [256] = {76,4,1140800,1,2050,7,15360,},
        [257] = {77,4,1203900,1,2120,7,15870,},
        [258] = {78,4,1266900,1,2180,7,16370,},
        [259] = {79,4,1330000,1,2260,7,16920,},
        [260] = {80,4,1393000,1,2330,7,17490,},
        [261] = {1,5,1000,1,14900,7,111750,},
        [262] = {2,5,1200,1,80,7,610,},
        [263] = {3,5,1400,1,80,7,620,},
        [264] = {4,5,1600,1,80,7,630,},
        [265] = {5,5,1800,1,90,7,640,},
        [266] = {6,5,2000,1,90,7,650,},
        [267] = {7,5,2200,1,90,7,670,},
        [268] = {8,5,2400,1,90,7,700,},
        [269] = {9,5,2600,1,100,7,720,},
        [270] = {10,5,2800,1,100,7,740,},
        [271] = {11,5,3000,1,100,7,770,},
        [272] = {12,5,3400,1,110,7,800,},
        [273] = {13,5,3800,1,110,7,840,},
        [274] = {14,5,4200,1,120,7,880,},
        [275] = {15,5,4600,1,120,7,920,},
        [276] = {16,5,5000,1,130,7,960,},
        [277] = {17,5,5500,1,130,7,1010,},
        [278] = {18,5,6000,1,140,7,1070,},
        [279] = {19,5,6500,1,150,7,1130,},
        [280] = {20,5,7000,1,160,7,1180,},
        [281] = {21,5,7400,1,170,7,1240,},
        [282] = {22,5,8300,1,180,7,1310,},
        [283] = {23,5,9200,1,190,7,1390,},
        [284] = {24,5,10100,1,200,7,1480,},
        [285] = {25,5,11000,1,210,7,1560,},
        [286] = {26,5,12500,1,220,7,1640,},
        [287] = {27,5,14400,1,230,7,1730,},
        [288] = {28,5,16400,1,250,7,1840,},
        [289] = {29,5,18400,1,260,7,1950,},
        [290] = {30,5,20400,1,270,7,2060,},
        [291] = {31,5,23400,1,290,7,2170,},
        [292] = {32,5,27600,1,310,7,2290,},
        [293] = {33,5,31700,1,320,7,2430,},
        [294] = {34,5,35900,1,340,7,2570,},
        [295] = {35,5,40000,1,360,7,2700,},
        [296] = {36,5,45600,1,380,7,2840,},
        [297] = {37,5,52600,1,400,7,3000,},
        [298] = {38,5,59600,1,420,7,3170,},
        [299] = {39,5,66600,1,450,7,3340,},
        [300] = {40,5,73700,1,470,7,3510,},
        [301] = {41,5,82500,1,490,7,3680,},
        [302] = {42,5,93100,1,520,7,3870,},
        [303] = {43,5,103700,1,540,7,4080,},
        [304] = {44,5,114300,1,570,7,4290,},
        [305] = {45,5,125000,1,600,7,4500,},
        [306] = {46,5,137900,1,630,7,4710,},
        [307] = {47,5,153200,1,660,7,4940,},
        [308] = {48,5,168500,1,690,7,5190,},
        [309] = {49,5,183800,1,720,7,5440,},
        [310] = {50,5,199100,1,760,7,5690,},
        [311] = {51,5,217300,1,790,7,5940,},
        [312] = {52,5,238400,1,830,7,6210,},
        [313] = {53,5,259400,1,870,7,6500,},
        [314] = {54,5,280500,1,910,7,6800,},
        [315] = {55,5,301500,1,950,7,7090,},
        [316] = {56,5,326200,1,980,7,7380,},
        [317] = {57,5,354500,1,1030,7,7700,},
        [318] = {58,5,382700,1,1070,7,8040,},
        [319] = {59,5,411000,1,1120,7,8390,},
        [320] = {60,5,439200,1,1160,7,8730,},
        [321] = {61,5,470400,1,1210,7,9070,},
        [322] = {62,5,505900,1,1250,7,9410,},
        [323] = {63,5,541300,1,1300,7,9750,},
        [324] = {64,5,576800,1,1350,7,10120,},
        [325] = {65,5,612200,1,1400,7,10510,},
        [326] = {66,5,650900,1,1450,7,10900,},
        [327] = {67,5,694600,1,1510,7,11290,},
        [328] = {68,5,738200,1,1560,7,11680,},
        [329] = {69,5,781900,1,1610,7,12100,},
        [330] = {70,5,825500,1,1670,7,12540,},
        [331] = {71,5,872700,1,1730,7,12990,},
        [332] = {72,5,925600,1,1790,7,13430,},
        [333] = {73,5,978400,1,1850,7,13880,},
        [334] = {74,5,1031300,1,1910,7,14360,},
        [335] = {75,5,1084100,1,1980,7,14860,},
        [336] = {76,5,1140800,1,2050,7,15360,},
        [337] = {77,5,1203900,1,2120,7,15870,},
        [338] = {78,5,1266900,1,2180,7,16370,},
        [339] = {79,5,1330000,1,2260,7,16920,},
        [340] = {80,5,1393000,1,2330,7,17490,},
        [341] = {81,5,1450000,1,2400,7,18000,},
        [342] = {82,5,1500000,1,2400,7,18000,},
        [343] = {83,5,1550000,1,2400,7,18000,},
        [344] = {84,5,1600000,1,2400,7,18000,},
        [345] = {85,5,1650000,1,2400,7,18000,},
        [346] = {86,5,1700000,1,2400,7,18000,},
        [347] = {87,5,1750000,1,2400,7,18000,},
        [348] = {88,5,1800000,1,2400,7,18000,},
        [349] = {89,5,1850000,1,2400,7,18000,},
        [350] = {90,5,1900000,1,2400,7,18000,},
        [351] = {91,5,1950000,1,2400,7,18000,},
        [352] = {92,5,2000000,1,2400,7,18000,},
        [353] = {93,5,2050000,1,2400,7,18000,},
        [354] = {94,5,2100000,1,2400,7,18000,},
        [355] = {95,5,2150000,1,2400,7,18000,},
        [356] = {96,5,2200000,1,2400,7,18000,},
        [357] = {97,5,2250000,1,2400,7,18000,},
        [358] = {98,5,2300000,1,2400,7,18000,},
        [359] = {99,5,2350000,1,2400,7,18000,},
        [360] = {100,5,2400000,1,2400,7,18000,},
    }
}

-- index
local __index_level_templet = {
    ["100_5"] = 360,
    ["10_1"] = 10,
    ["10_2"] = 70,
    ["10_3"] = 130,
    ["10_4"] = 190,
    ["10_5"] = 270,
    ["11_1"] = 11,
    ["11_2"] = 71,
    ["11_3"] = 131,
    ["11_4"] = 191,
    ["11_5"] = 271,
    ["12_1"] = 12,
    ["12_2"] = 72,
    ["12_3"] = 132,
    ["12_4"] = 192,
    ["12_5"] = 272,
    ["13_1"] = 13,
    ["13_2"] = 73,
    ["13_3"] = 133,
    ["13_4"] = 193,
    ["13_5"] = 273,
    ["14_1"] = 14,
    ["14_2"] = 74,
    ["14_3"] = 134,
    ["14_4"] = 194,
    ["14_5"] = 274,
    ["15_1"] = 15,
    ["15_2"] = 75,
    ["15_3"] = 135,
    ["15_4"] = 195,
    ["15_5"] = 275,
    ["16_1"] = 16,
    ["16_2"] = 76,
    ["16_3"] = 136,
    ["16_4"] = 196,
    ["16_5"] = 276,
    ["17_1"] = 17,
    ["17_2"] = 77,
    ["17_3"] = 137,
    ["17_4"] = 197,
    ["17_5"] = 277,
    ["18_1"] = 18,
    ["18_2"] = 78,
    ["18_3"] = 138,
    ["18_4"] = 198,
    ["18_5"] = 278,
    ["19_1"] = 19,
    ["19_2"] = 79,
    ["19_3"] = 139,
    ["19_4"] = 199,
    ["19_5"] = 279,
    ["1_1"] = 1,
    ["1_2"] = 61,
    ["1_3"] = 121,
    ["1_4"] = 181,
    ["1_5"] = 261,
    ["20_1"] = 20,
    ["20_2"] = 80,
    ["20_3"] = 140,
    ["20_4"] = 200,
    ["20_5"] = 280,
    ["21_1"] = 21,
    ["21_2"] = 81,
    ["21_3"] = 141,
    ["21_4"] = 201,
    ["21_5"] = 281,
    ["22_1"] = 22,
    ["22_2"] = 82,
    ["22_3"] = 142,
    ["22_4"] = 202,
    ["22_5"] = 282,
    ["23_1"] = 23,
    ["23_2"] = 83,
    ["23_3"] = 143,
    ["23_4"] = 203,
    ["23_5"] = 283,
    ["24_1"] = 24,
    ["24_2"] = 84,
    ["24_3"] = 144,
    ["24_4"] = 204,
    ["24_5"] = 284,
    ["25_1"] = 25,
    ["25_2"] = 85,
    ["25_3"] = 145,
    ["25_4"] = 205,
    ["25_5"] = 285,
    ["26_1"] = 26,
    ["26_2"] = 86,
    ["26_3"] = 146,
    ["26_4"] = 206,
    ["26_5"] = 286,
    ["27_1"] = 27,
    ["27_2"] = 87,
    ["27_3"] = 147,
    ["27_4"] = 207,
    ["27_5"] = 287,
    ["28_1"] = 28,
    ["28_2"] = 88,
    ["28_3"] = 148,
    ["28_4"] = 208,
    ["28_5"] = 288,
    ["29_1"] = 29,
    ["29_2"] = 89,
    ["29_3"] = 149,
    ["29_4"] = 209,
    ["29_5"] = 289,
    ["2_1"] = 2,
    ["2_2"] = 62,
    ["2_3"] = 122,
    ["2_4"] = 182,
    ["2_5"] = 262,
    ["30_1"] = 30,
    ["30_2"] = 90,
    ["30_3"] = 150,
    ["30_4"] = 210,
    ["30_5"] = 290,
    ["31_1"] = 31,
    ["31_2"] = 91,
    ["31_3"] = 151,
    ["31_4"] = 211,
    ["31_5"] = 291,
    ["32_1"] = 32,
    ["32_2"] = 92,
    ["32_3"] = 152,
    ["32_4"] = 212,
    ["32_5"] = 292,
    ["33_1"] = 33,
    ["33_2"] = 93,
    ["33_3"] = 153,
    ["33_4"] = 213,
    ["33_5"] = 293,
    ["34_1"] = 34,
    ["34_2"] = 94,
    ["34_3"] = 154,
    ["34_4"] = 214,
    ["34_5"] = 294,
    ["35_1"] = 35,
    ["35_2"] = 95,
    ["35_3"] = 155,
    ["35_4"] = 215,
    ["35_5"] = 295,
    ["36_1"] = 36,
    ["36_2"] = 96,
    ["36_3"] = 156,
    ["36_4"] = 216,
    ["36_5"] = 296,
    ["37_1"] = 37,
    ["37_2"] = 97,
    ["37_3"] = 157,
    ["37_4"] = 217,
    ["37_5"] = 297,
    ["38_1"] = 38,
    ["38_2"] = 98,
    ["38_3"] = 158,
    ["38_4"] = 218,
    ["38_5"] = 298,
    ["39_1"] = 39,
    ["39_2"] = 99,
    ["39_3"] = 159,
    ["39_4"] = 219,
    ["39_5"] = 299,
    ["3_1"] = 3,
    ["3_2"] = 63,
    ["3_3"] = 123,
    ["3_4"] = 183,
    ["3_5"] = 263,
    ["40_1"] = 40,
    ["40_2"] = 100,
    ["40_3"] = 160,
    ["40_4"] = 220,
    ["40_5"] = 300,
    ["41_1"] = 41,
    ["41_2"] = 101,
    ["41_3"] = 161,
    ["41_4"] = 221,
    ["41_5"] = 301,
    ["42_1"] = 42,
    ["42_2"] = 102,
    ["42_3"] = 162,
    ["42_4"] = 222,
    ["42_5"] = 302,
    ["43_1"] = 43,
    ["43_2"] = 103,
    ["43_3"] = 163,
    ["43_4"] = 223,
    ["43_5"] = 303,
    ["44_1"] = 44,
    ["44_2"] = 104,
    ["44_3"] = 164,
    ["44_4"] = 224,
    ["44_5"] = 304,
    ["45_1"] = 45,
    ["45_2"] = 105,
    ["45_3"] = 165,
    ["45_4"] = 225,
    ["45_5"] = 305,
    ["46_1"] = 46,
    ["46_2"] = 106,
    ["46_3"] = 166,
    ["46_4"] = 226,
    ["46_5"] = 306,
    ["47_1"] = 47,
    ["47_2"] = 107,
    ["47_3"] = 167,
    ["47_4"] = 227,
    ["47_5"] = 307,
    ["48_1"] = 48,
    ["48_2"] = 108,
    ["48_3"] = 168,
    ["48_4"] = 228,
    ["48_5"] = 308,
    ["49_1"] = 49,
    ["49_2"] = 109,
    ["49_3"] = 169,
    ["49_4"] = 229,
    ["49_5"] = 309,
    ["4_1"] = 4,
    ["4_2"] = 64,
    ["4_3"] = 124,
    ["4_4"] = 184,
    ["4_5"] = 264,
    ["50_1"] = 50,
    ["50_2"] = 110,
    ["50_3"] = 170,
    ["50_4"] = 230,
    ["50_5"] = 310,
    ["51_1"] = 51,
    ["51_2"] = 111,
    ["51_3"] = 171,
    ["51_4"] = 231,
    ["51_5"] = 311,
    ["52_1"] = 52,
    ["52_2"] = 112,
    ["52_3"] = 172,
    ["52_4"] = 232,
    ["52_5"] = 312,
    ["53_1"] = 53,
    ["53_2"] = 113,
    ["53_3"] = 173,
    ["53_4"] = 233,
    ["53_5"] = 313,
    ["54_1"] = 54,
    ["54_2"] = 114,
    ["54_3"] = 174,
    ["54_4"] = 234,
    ["54_5"] = 314,
    ["55_1"] = 55,
    ["55_2"] = 115,
    ["55_3"] = 175,
    ["55_4"] = 235,
    ["55_5"] = 315,
    ["56_1"] = 56,
    ["56_2"] = 116,
    ["56_3"] = 176,
    ["56_4"] = 236,
    ["56_5"] = 316,
    ["57_1"] = 57,
    ["57_2"] = 117,
    ["57_3"] = 177,
    ["57_4"] = 237,
    ["57_5"] = 317,
    ["58_1"] = 58,
    ["58_2"] = 118,
    ["58_3"] = 178,
    ["58_4"] = 238,
    ["58_5"] = 318,
    ["59_1"] = 59,
    ["59_2"] = 119,
    ["59_3"] = 179,
    ["59_4"] = 239,
    ["59_5"] = 319,
    ["5_1"] = 5,
    ["5_2"] = 65,
    ["5_3"] = 125,
    ["5_4"] = 185,
    ["5_5"] = 265,
    ["60_1"] = 60,
    ["60_2"] = 120,
    ["60_3"] = 180,
    ["60_4"] = 240,
    ["60_5"] = 320,
    ["61_4"] = 241,
    ["61_5"] = 321,
    ["62_4"] = 242,
    ["62_5"] = 322,
    ["63_4"] = 243,
    ["63_5"] = 323,
    ["64_4"] = 244,
    ["64_5"] = 324,
    ["65_4"] = 245,
    ["65_5"] = 325,
    ["66_4"] = 246,
    ["66_5"] = 326,
    ["67_4"] = 247,
    ["67_5"] = 327,
    ["68_4"] = 248,
    ["68_5"] = 328,
    ["69_4"] = 249,
    ["69_5"] = 329,
    ["6_1"] = 6,
    ["6_2"] = 66,
    ["6_3"] = 126,
    ["6_4"] = 186,
    ["6_5"] = 266,
    ["70_4"] = 250,
    ["70_5"] = 330,
    ["71_4"] = 251,
    ["71_5"] = 331,
    ["72_4"] = 252,
    ["72_5"] = 332,
    ["73_4"] = 253,
    ["73_5"] = 333,
    ["74_4"] = 254,
    ["74_5"] = 334,
    ["75_4"] = 255,
    ["75_5"] = 335,
    ["76_4"] = 256,
    ["76_5"] = 336,
    ["77_4"] = 257,
    ["77_5"] = 337,
    ["78_4"] = 258,
    ["78_5"] = 338,
    ["79_4"] = 259,
    ["79_5"] = 339,
    ["7_1"] = 7,
    ["7_2"] = 67,
    ["7_3"] = 127,
    ["7_4"] = 187,
    ["7_5"] = 267,
    ["80_4"] = 260,
    ["80_5"] = 340,
    ["81_5"] = 341,
    ["82_5"] = 342,
    ["83_5"] = 343,
    ["84_5"] = 344,
    ["85_5"] = 345,
    ["86_5"] = 346,
    ["87_5"] = 347,
    ["88_5"] = 348,
    ["89_5"] = 349,
    ["8_1"] = 8,
    ["8_2"] = 68,
    ["8_3"] = 128,
    ["8_4"] = 188,
    ["8_5"] = 268,
    ["90_5"] = 350,
    ["91_5"] = 351,
    ["92_5"] = 352,
    ["93_5"] = 353,
    ["94_5"] = 354,
    ["95_5"] = 355,
    ["96_5"] = 356,
    ["97_5"] = 357,
    ["98_5"] = 358,
    ["99_5"] = 359,
    ["9_1"] = 9,
    ["9_2"] = 69,
    ["9_3"] = 129,
    ["9_4"] = 189,
    ["9_5"] = 269,

}

-- index mainkey map
local __main_key_map = {
    [360] = "100_5",
    [10] = "10_1",
    [70] = "10_2",
    [130] = "10_3",
    [190] = "10_4",
    [270] = "10_5",
    [11] = "11_1",
    [71] = "11_2",
    [131] = "11_3",
    [191] = "11_4",
    [271] = "11_5",
    [12] = "12_1",
    [72] = "12_2",
    [132] = "12_3",
    [192] = "12_4",
    [272] = "12_5",
    [13] = "13_1",
    [73] = "13_2",
    [133] = "13_3",
    [193] = "13_4",
    [273] = "13_5",
    [14] = "14_1",
    [74] = "14_2",
    [134] = "14_3",
    [194] = "14_4",
    [274] = "14_5",
    [15] = "15_1",
    [75] = "15_2",
    [135] = "15_3",
    [195] = "15_4",
    [275] = "15_5",
    [16] = "16_1",
    [76] = "16_2",
    [136] = "16_3",
    [196] = "16_4",
    [276] = "16_5",
    [17] = "17_1",
    [77] = "17_2",
    [137] = "17_3",
    [197] = "17_4",
    [277] = "17_5",
    [18] = "18_1",
    [78] = "18_2",
    [138] = "18_3",
    [198] = "18_4",
    [278] = "18_5",
    [19] = "19_1",
    [79] = "19_2",
    [139] = "19_3",
    [199] = "19_4",
    [279] = "19_5",
    [1] = "1_1",
    [61] = "1_2",
    [121] = "1_3",
    [181] = "1_4",
    [261] = "1_5",
    [20] = "20_1",
    [80] = "20_2",
    [140] = "20_3",
    [200] = "20_4",
    [280] = "20_5",
    [21] = "21_1",
    [81] = "21_2",
    [141] = "21_3",
    [201] = "21_4",
    [281] = "21_5",
    [22] = "22_1",
    [82] = "22_2",
    [142] = "22_3",
    [202] = "22_4",
    [282] = "22_5",
    [23] = "23_1",
    [83] = "23_2",
    [143] = "23_3",
    [203] = "23_4",
    [283] = "23_5",
    [24] = "24_1",
    [84] = "24_2",
    [144] = "24_3",
    [204] = "24_4",
    [284] = "24_5",
    [25] = "25_1",
    [85] = "25_2",
    [145] = "25_3",
    [205] = "25_4",
    [285] = "25_5",
    [26] = "26_1",
    [86] = "26_2",
    [146] = "26_3",
    [206] = "26_4",
    [286] = "26_5",
    [27] = "27_1",
    [87] = "27_2",
    [147] = "27_3",
    [207] = "27_4",
    [287] = "27_5",
    [28] = "28_1",
    [88] = "28_2",
    [148] = "28_3",
    [208] = "28_4",
    [288] = "28_5",
    [29] = "29_1",
    [89] = "29_2",
    [149] = "29_3",
    [209] = "29_4",
    [289] = "29_5",
    [2] = "2_1",
    [62] = "2_2",
    [122] = "2_3",
    [182] = "2_4",
    [262] = "2_5",
    [30] = "30_1",
    [90] = "30_2",
    [150] = "30_3",
    [210] = "30_4",
    [290] = "30_5",
    [31] = "31_1",
    [91] = "31_2",
    [151] = "31_3",
    [211] = "31_4",
    [291] = "31_5",
    [32] = "32_1",
    [92] = "32_2",
    [152] = "32_3",
    [212] = "32_4",
    [292] = "32_5",
    [33] = "33_1",
    [93] = "33_2",
    [153] = "33_3",
    [213] = "33_4",
    [293] = "33_5",
    [34] = "34_1",
    [94] = "34_2",
    [154] = "34_3",
    [214] = "34_4",
    [294] = "34_5",
    [35] = "35_1",
    [95] = "35_2",
    [155] = "35_3",
    [215] = "35_4",
    [295] = "35_5",
    [36] = "36_1",
    [96] = "36_2",
    [156] = "36_3",
    [216] = "36_4",
    [296] = "36_5",
    [37] = "37_1",
    [97] = "37_2",
    [157] = "37_3",
    [217] = "37_4",
    [297] = "37_5",
    [38] = "38_1",
    [98] = "38_2",
    [158] = "38_3",
    [218] = "38_4",
    [298] = "38_5",
    [39] = "39_1",
    [99] = "39_2",
    [159] = "39_3",
    [219] = "39_4",
    [299] = "39_5",
    [3] = "3_1",
    [63] = "3_2",
    [123] = "3_3",
    [183] = "3_4",
    [263] = "3_5",
    [40] = "40_1",
    [100] = "40_2",
    [160] = "40_3",
    [220] = "40_4",
    [300] = "40_5",
    [41] = "41_1",
    [101] = "41_2",
    [161] = "41_3",
    [221] = "41_4",
    [301] = "41_5",
    [42] = "42_1",
    [102] = "42_2",
    [162] = "42_3",
    [222] = "42_4",
    [302] = "42_5",
    [43] = "43_1",
    [103] = "43_2",
    [163] = "43_3",
    [223] = "43_4",
    [303] = "43_5",
    [44] = "44_1",
    [104] = "44_2",
    [164] = "44_3",
    [224] = "44_4",
    [304] = "44_5",
    [45] = "45_1",
    [105] = "45_2",
    [165] = "45_3",
    [225] = "45_4",
    [305] = "45_5",
    [46] = "46_1",
    [106] = "46_2",
    [166] = "46_3",
    [226] = "46_4",
    [306] = "46_5",
    [47] = "47_1",
    [107] = "47_2",
    [167] = "47_3",
    [227] = "47_4",
    [307] = "47_5",
    [48] = "48_1",
    [108] = "48_2",
    [168] = "48_3",
    [228] = "48_4",
    [308] = "48_5",
    [49] = "49_1",
    [109] = "49_2",
    [169] = "49_3",
    [229] = "49_4",
    [309] = "49_5",
    [4] = "4_1",
    [64] = "4_2",
    [124] = "4_3",
    [184] = "4_4",
    [264] = "4_5",
    [50] = "50_1",
    [110] = "50_2",
    [170] = "50_3",
    [230] = "50_4",
    [310] = "50_5",
    [51] = "51_1",
    [111] = "51_2",
    [171] = "51_3",
    [231] = "51_4",
    [311] = "51_5",
    [52] = "52_1",
    [112] = "52_2",
    [172] = "52_3",
    [232] = "52_4",
    [312] = "52_5",
    [53] = "53_1",
    [113] = "53_2",
    [173] = "53_3",
    [233] = "53_4",
    [313] = "53_5",
    [54] = "54_1",
    [114] = "54_2",
    [174] = "54_3",
    [234] = "54_4",
    [314] = "54_5",
    [55] = "55_1",
    [115] = "55_2",
    [175] = "55_3",
    [235] = "55_4",
    [315] = "55_5",
    [56] = "56_1",
    [116] = "56_2",
    [176] = "56_3",
    [236] = "56_4",
    [316] = "56_5",
    [57] = "57_1",
    [117] = "57_2",
    [177] = "57_3",
    [237] = "57_4",
    [317] = "57_5",
    [58] = "58_1",
    [118] = "58_2",
    [178] = "58_3",
    [238] = "58_4",
    [318] = "58_5",
    [59] = "59_1",
    [119] = "59_2",
    [179] = "59_3",
    [239] = "59_4",
    [319] = "59_5",
    [5] = "5_1",
    [65] = "5_2",
    [125] = "5_3",
    [185] = "5_4",
    [265] = "5_5",
    [60] = "60_1",
    [120] = "60_2",
    [180] = "60_3",
    [240] = "60_4",
    [320] = "60_5",
    [241] = "61_4",
    [321] = "61_5",
    [242] = "62_4",
    [322] = "62_5",
    [243] = "63_4",
    [323] = "63_5",
    [244] = "64_4",
    [324] = "64_5",
    [245] = "65_4",
    [325] = "65_5",
    [246] = "66_4",
    [326] = "66_5",
    [247] = "67_4",
    [327] = "67_5",
    [248] = "68_4",
    [328] = "68_5",
    [249] = "69_4",
    [329] = "69_5",
    [6] = "6_1",
    [66] = "6_2",
    [126] = "6_3",
    [186] = "6_4",
    [266] = "6_5",
    [250] = "70_4",
    [330] = "70_5",
    [251] = "71_4",
    [331] = "71_5",
    [252] = "72_4",
    [332] = "72_5",
    [253] = "73_4",
    [333] = "73_5",
    [254] = "74_4",
    [334] = "74_5",
    [255] = "75_4",
    [335] = "75_5",
    [256] = "76_4",
    [336] = "76_5",
    [257] = "77_4",
    [337] = "77_5",
    [258] = "78_4",
    [338] = "78_5",
    [259] = "79_4",
    [339] = "79_5",
    [7] = "7_1",
    [67] = "7_2",
    [127] = "7_3",
    [187] = "7_4",
    [267] = "7_5",
    [260] = "80_4",
    [340] = "80_5",
    [341] = "81_5",
    [342] = "82_5",
    [343] = "83_5",
    [344] = "84_5",
    [345] = "85_5",
    [346] = "86_5",
    [347] = "87_5",
    [348] = "88_5",
    [349] = "89_5",
    [8] = "8_1",
    [68] = "8_2",
    [128] = "8_3",
    [188] = "8_4",
    [268] = "8_5",
    [350] = "90_5",
    [351] = "91_5",
    [352] = "92_5",
    [353] = "93_5",
    [354] = "94_5",
    [355] = "95_5",
    [356] = "96_5",
    [357] = "97_5",
    [358] = "98_5",
    [359] = "99_5",
    [9] = "9_1",
    [69] = "9_2",
    [129] = "9_3",
    [189] = "9_4",
    [269] = "9_5",

}

-- metatable
local mt = { 
    __index = function(t, k) 
        local key_map = t._raw_key_map
        assert(key_map[k], "cannot find " .. k .. " in treasure_levelup")
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
function treasure_levelup.length()
    return #treasure_levelup._data
end

-- 
function treasure_levelup.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function treasure_levelup.isVersionValid(v)
    if treasure_levelup.version then
        if v then
            return treasure_levelup.version <= v
        else
            return false
        end
    else
        return true
    end
end

--
function treasure_levelup.indexOf(index)
    if index == nil or not treasure_levelup._data[index] then
        return nil
    end
    if Lang.lang ~= _lang then 
        _lang = Lang.lang
        if Lang.lang ~= "cn" then
            _isDataExist = Lang.isFileExist("app/i18n/".. _lang .."/data/treasure_levelup.lua")
            _isExist = Lang.isFileExist("app/i18n/".. _lang .."/config/treasure_levelup.lua")
            _isBaseExist =  Lang.isFileExist("app/i18n/".. _lang .."/base/treasure_levelup.lua")

            if _isDataExist then
                local table = require( "app.i18n.".. _lang ..".data." .. "treasure_levelup" )
                _isDataExist = treasure_levelup.isVersionValid(table.version)
            end
            if _isBaseExist then
                local table = require( "app.i18n.".. _lang ..".base." .. "treasure_levelup" )
                _isBaseExist = treasure_levelup.isVersionValid(table.version)
            end
            if _isExist then
                local table = require( "app.i18n.".. _lang ..".config." .. "treasure_levelup" )
                _isExist = treasure_levelup.isVersionValid(table.version)
            end
        end
    end
    local config = {_raw = nil,_raw_key_map = __key_map,_lang = nil,_lang_key_map = nil,_data = nil,_data_key_map = nil}
    if _lang ~= "cn" and _isDataExist then
        local table = require( "app.i18n.".. _lang ..".data." .. "treasure_levelup" )
        local main_key = __main_key_map[index]
		local index_key = "__index_level_templet"
        local data_index = table[index_key][main_key]
        config._data = table._data[data_index]
        config._data_key_map = table.__key_map
    end

    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "treasure_levelup" )
        local main_key = __main_key_map[index]
		local index_key = "__index_level_templet"
        local lang_index = table[index_key][main_key]
        config._lang = table._data[lang_index]
        config._lang_key_map = table.__key_map
    end
    config._raw = treasure_levelup._data[index]
    if _lang ~= "cn" and _isBaseExist then
        local table_base = require( "app.i18n.".. _lang ..".base." .. "treasure_levelup" )
        config._raw = table_base._data[index] 
    end
    return setmetatable(config, mt)
end

--
function treasure_levelup.get(level,templet)
    
    local k = level .. '_' .. templet
    return treasure_levelup.indexOf(__index_level_templet[k])
        
end

--
function treasure_levelup.set(level,templet, key, value)
    local record = treasure_levelup.get(level,templet)
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
function treasure_levelup.index()
    return __index_level_templet
end

return treasure_levelup