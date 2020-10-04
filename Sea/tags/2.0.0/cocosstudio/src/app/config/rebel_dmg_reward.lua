--rebel_dmg_reward

local _lang = "cn"
local _isExist = false

-- key
local __key_map = {
  id = 1,    --奖励id-int 
  type = 2,    --奖励类型-int 
  lv_min = 3,    --等级下限-int 
  lv_max = 4,    --等级上限-int 
  index = 5,    --排序-int 
  target_size = 6,    --数量-int 
  award_type = 7,    --奖励类型-int 
  award_value = 8,    --参数-int 
  award_size = 9,    --数量-int 

}

-- key type
local __key_type = {
  id = "int",    --奖励id-1 
  type = "int",    --奖励类型-2 
  lv_min = "int",    --等级下限-3 
  lv_max = "int",    --等级上限-4 
  index = "int",    --排序-5 
  target_size = "int",    --数量-6 
  award_type = "int",    --奖励类型-7 
  award_value = "int",    --参数-8 
  award_size = "int",    --数量-9 

}


-- data
local rebel_dmg_reward = {
    _data = {
        [1] = {10001,1,1,50,1,250,5,2,10000,},
        [2] = {10002,1,1,50,2,500,5,8,500,},
        [3] = {10003,1,1,50,3,750,6,19,50,},
        [4] = {10004,1,1,50,4,1000,5,2,20000,},
        [5] = {10005,1,1,50,5,1250,5,8,500,},
        [6] = {10006,1,1,50,6,1500,6,19,50,},
        [7] = {10007,1,1,50,7,1750,5,2,40000,},
        [8] = {10008,1,1,50,8,2000,5,8,800,},
        [9] = {10009,1,1,50,9,2250,6,19,80,},
        [10] = {10010,1,1,50,10,2500,5,2,80000,},
        [11] = {10011,1,1,50,11,2750,5,8,800,},
        [12] = {10012,1,1,50,12,3000,6,19,80,},
        [13] = {10013,1,1,50,13,3250,5,2,100000,},
        [14] = {10014,1,1,50,14,3500,5,8,1000,},
        [15] = {10015,1,1,50,15,3750,6,19,100,},
        [16] = {10016,1,1,50,16,4000,5,2,120000,},
        [17] = {10017,1,1,50,17,4250,5,8,1000,},
        [18] = {10018,1,1,50,18,4500,6,19,100,},
        [19] = {10019,1,1,50,19,4750,5,2,140000,},
        [20] = {10020,1,1,50,20,5000,5,8,1200,},
        [21] = {10021,1,51,55,1,350,5,2,10000,},
        [22] = {10022,1,51,55,2,700,5,8,500,},
        [23] = {10023,1,51,55,3,1050,6,19,50,},
        [24] = {10024,1,51,55,4,1400,5,2,20000,},
        [25] = {10025,1,51,55,5,1750,5,8,500,},
        [26] = {10026,1,51,55,6,2100,6,19,50,},
        [27] = {10027,1,51,55,7,2450,5,2,40000,},
        [28] = {10028,1,51,55,8,2800,5,8,800,},
        [29] = {10029,1,51,55,9,3150,6,19,80,},
        [30] = {10030,1,51,55,10,3500,5,2,80000,},
        [31] = {10031,1,51,55,11,3850,5,8,800,},
        [32] = {10032,1,51,55,12,4200,6,19,80,},
        [33] = {10033,1,51,55,13,4550,5,2,100000,},
        [34] = {10034,1,51,55,14,4900,5,8,1000,},
        [35] = {10035,1,51,55,15,5250,6,19,100,},
        [36] = {10036,1,51,55,16,5600,5,2,120000,},
        [37] = {10037,1,51,55,17,5950,5,8,1000,},
        [38] = {10038,1,51,55,18,6300,6,19,100,},
        [39] = {10039,1,51,55,19,6650,5,2,140000,},
        [40] = {10040,1,51,55,20,7000,5,8,1200,},
        [41] = {10041,1,56,60,1,500,5,2,10000,},
        [42] = {10042,1,56,60,2,1000,5,8,500,},
        [43] = {10043,1,56,60,3,1500,6,19,50,},
        [44] = {10044,1,56,60,4,2000,5,2,20000,},
        [45] = {10045,1,56,60,5,2500,5,8,500,},
        [46] = {10046,1,56,60,6,3000,6,19,50,},
        [47] = {10047,1,56,60,7,3500,5,2,40000,},
        [48] = {10048,1,56,60,8,4000,5,8,800,},
        [49] = {10049,1,56,60,9,4500,6,19,80,},
        [50] = {10050,1,56,60,10,5000,5,2,80000,},
        [51] = {10051,1,56,60,11,5500,5,8,800,},
        [52] = {10052,1,56,60,12,6000,6,19,80,},
        [53] = {10053,1,56,60,13,6500,5,2,100000,},
        [54] = {10054,1,56,60,14,7000,5,8,1000,},
        [55] = {10055,1,56,60,15,7500,6,19,100,},
        [56] = {10056,1,56,60,16,8000,5,2,120000,},
        [57] = {10057,1,56,60,17,8500,5,8,1000,},
        [58] = {10058,1,56,60,18,9000,6,19,100,},
        [59] = {10059,1,56,60,19,9500,5,2,140000,},
        [60] = {10060,1,56,60,20,10000,5,8,1200,},
        [61] = {10061,1,61,65,1,750,5,2,10000,},
        [62] = {10062,1,61,65,2,1500,5,8,500,},
        [63] = {10063,1,61,65,3,2250,6,19,50,},
        [64] = {10064,1,61,65,4,3000,5,2,20000,},
        [65] = {10065,1,61,65,5,3750,5,8,500,},
        [66] = {10066,1,61,65,6,4500,6,19,50,},
        [67] = {10067,1,61,65,7,5250,5,2,40000,},
        [68] = {10068,1,61,65,8,6000,5,8,800,},
        [69] = {10069,1,61,65,9,6750,6,19,80,},
        [70] = {10070,1,61,65,10,7500,5,2,80000,},
        [71] = {10071,1,61,65,11,8250,5,8,800,},
        [72] = {10072,1,61,65,12,9000,6,19,80,},
        [73] = {10073,1,61,65,13,9750,5,2,100000,},
        [74] = {10074,1,61,65,14,10500,5,8,1000,},
        [75] = {10075,1,61,65,15,11250,6,19,100,},
        [76] = {10076,1,61,65,16,12000,5,2,120000,},
        [77] = {10077,1,61,65,17,12750,5,8,1000,},
        [78] = {10078,1,61,65,18,13500,6,19,100,},
        [79] = {10079,1,61,65,19,14250,5,2,140000,},
        [80] = {10080,1,61,65,20,15000,5,8,1200,},
        [81] = {10081,1,66,70,1,1100,5,2,10000,},
        [82] = {10082,1,66,70,2,2200,5,8,500,},
        [83] = {10083,1,66,70,3,3300,6,19,50,},
        [84] = {10084,1,66,70,4,4400,5,2,20000,},
        [85] = {10085,1,66,70,5,5500,5,8,500,},
        [86] = {10086,1,66,70,6,6600,6,19,50,},
        [87] = {10087,1,66,70,7,7700,5,2,40000,},
        [88] = {10088,1,66,70,8,8800,5,8,800,},
        [89] = {10089,1,66,70,9,9900,6,19,80,},
        [90] = {10090,1,66,70,10,11000,5,2,80000,},
        [91] = {10091,1,66,70,11,12100,5,8,800,},
        [92] = {10092,1,66,70,12,13200,6,19,80,},
        [93] = {10093,1,66,70,13,14300,5,2,100000,},
        [94] = {10094,1,66,70,14,15400,5,8,1000,},
        [95] = {10095,1,66,70,15,16500,6,19,100,},
        [96] = {10096,1,66,70,16,17600,5,2,120000,},
        [97] = {10097,1,66,70,17,18700,5,8,1000,},
        [98] = {10098,1,66,70,18,19800,6,19,100,},
        [99] = {10099,1,66,70,19,20900,5,2,140000,},
        [100] = {10100,1,66,70,20,22000,5,8,1200,},
        [101] = {10101,1,71,75,1,1600,5,2,10000,},
        [102] = {10102,1,71,75,2,3200,5,8,500,},
        [103] = {10103,1,71,75,3,4800,6,19,50,},
        [104] = {10104,1,71,75,4,6400,5,2,20000,},
        [105] = {10105,1,71,75,5,8000,5,8,500,},
        [106] = {10106,1,71,75,6,9600,6,19,50,},
        [107] = {10107,1,71,75,7,11200,5,2,40000,},
        [108] = {10108,1,71,75,8,12800,5,8,800,},
        [109] = {10109,1,71,75,9,14400,6,19,80,},
        [110] = {10110,1,71,75,10,16000,5,2,80000,},
        [111] = {10111,1,71,75,11,17600,5,8,800,},
        [112] = {10112,1,71,75,12,19200,6,19,80,},
        [113] = {10113,1,71,75,13,20800,5,2,100000,},
        [114] = {10114,1,71,75,14,22400,5,8,1000,},
        [115] = {10115,1,71,75,15,24000,6,19,100,},
        [116] = {10116,1,71,75,16,25600,5,2,120000,},
        [117] = {10117,1,71,75,17,27200,5,8,1000,},
        [118] = {10118,1,71,75,18,28800,6,19,100,},
        [119] = {10119,1,71,75,19,30400,5,2,140000,},
        [120] = {10120,1,71,75,20,32000,5,8,1200,},
        [121] = {10121,1,76,80,1,2350,5,2,10000,},
        [122] = {10122,1,76,80,2,4700,5,8,500,},
        [123] = {10123,1,76,80,3,7050,6,19,50,},
        [124] = {10124,1,76,80,4,9400,5,2,20000,},
        [125] = {10125,1,76,80,5,11750,5,8,500,},
        [126] = {10126,1,76,80,6,14100,6,19,50,},
        [127] = {10127,1,76,80,7,16450,5,2,40000,},
        [128] = {10128,1,76,80,8,18800,5,8,800,},
        [129] = {10129,1,76,80,9,21150,6,19,80,},
        [130] = {10130,1,76,80,10,23500,5,2,80000,},
        [131] = {10131,1,76,80,11,25850,5,8,800,},
        [132] = {10132,1,76,80,12,28200,6,19,80,},
        [133] = {10133,1,76,80,13,30550,5,2,100000,},
        [134] = {10134,1,76,80,14,32900,5,8,1000,},
        [135] = {10135,1,76,80,15,35250,6,19,100,},
        [136] = {10136,1,76,80,16,37600,5,2,120000,},
        [137] = {10137,1,76,80,17,39950,5,8,1000,},
        [138] = {10138,1,76,80,18,42300,6,19,100,},
        [139] = {10139,1,76,80,19,44650,5,2,140000,},
        [140] = {10140,1,76,80,20,47000,5,8,1200,},
        [141] = {10141,1,81,85,1,2500,5,2,10000,},
        [142] = {10142,1,81,85,2,5000,5,8,500,},
        [143] = {10143,1,81,85,3,7500,6,19,50,},
        [144] = {10144,1,81,85,4,10000,5,2,20000,},
        [145] = {10145,1,81,85,5,12500,5,8,500,},
        [146] = {10146,1,81,85,6,15000,6,19,50,},
        [147] = {10147,1,81,85,7,17500,5,2,40000,},
        [148] = {10148,1,81,85,8,20000,5,8,800,},
        [149] = {10149,1,81,85,9,22500,6,19,80,},
        [150] = {10150,1,81,85,10,25000,5,2,80000,},
        [151] = {10151,1,81,85,11,27500,5,8,800,},
        [152] = {10152,1,81,85,12,30000,6,19,80,},
        [153] = {10153,1,81,85,13,32500,5,2,100000,},
        [154] = {10154,1,81,85,14,35000,5,8,1000,},
        [155] = {10155,1,81,85,15,37500,6,19,100,},
        [156] = {10156,1,81,85,16,40000,5,2,120000,},
        [157] = {10157,1,81,85,17,42500,5,8,1000,},
        [158] = {10158,1,81,85,18,45000,6,19,100,},
        [159] = {10159,1,81,85,19,47500,5,2,140000,},
        [160] = {10160,1,81,85,20,50000,5,8,1200,},
        [161] = {10161,1,86,90,1,3500,5,2,10000,},
        [162] = {10162,1,86,90,2,7000,5,8,500,},
        [163] = {10163,1,86,90,3,10500,6,19,50,},
        [164] = {10164,1,86,90,4,14000,5,2,20000,},
        [165] = {10165,1,86,90,5,17500,5,8,500,},
        [166] = {10166,1,86,90,6,21000,6,19,50,},
        [167] = {10167,1,86,90,7,24500,5,2,40000,},
        [168] = {10168,1,86,90,8,28000,5,8,800,},
        [169] = {10169,1,86,90,9,31500,6,19,80,},
        [170] = {10170,1,86,90,10,35000,5,2,80000,},
        [171] = {10171,1,86,90,11,38500,5,8,800,},
        [172] = {10172,1,86,90,12,42000,6,19,80,},
        [173] = {10173,1,86,90,13,45500,5,2,100000,},
        [174] = {10174,1,86,90,14,49000,5,8,1000,},
        [175] = {10175,1,86,90,15,52500,6,19,100,},
        [176] = {10176,1,86,90,16,56000,5,2,120000,},
        [177] = {10177,1,86,90,17,59500,5,8,1000,},
        [178] = {10178,1,86,90,18,63000,6,19,100,},
        [179] = {10179,1,86,90,19,66500,5,2,140000,},
        [180] = {10180,1,86,90,20,70000,5,8,1200,},
        [181] = {10181,1,91,95,1,5000,5,2,10000,},
        [182] = {10182,1,91,95,2,10000,5,8,500,},
        [183] = {10183,1,91,95,3,15000,6,19,50,},
        [184] = {10184,1,91,95,4,20000,5,2,20000,},
        [185] = {10185,1,91,95,5,25000,5,8,500,},
        [186] = {10186,1,91,95,6,30000,6,19,50,},
        [187] = {10187,1,91,95,7,35000,5,2,40000,},
        [188] = {10188,1,91,95,8,40000,5,8,800,},
        [189] = {10189,1,91,95,9,45000,6,19,80,},
        [190] = {10190,1,91,95,10,50000,5,2,80000,},
        [191] = {10191,1,91,95,11,55000,5,8,800,},
        [192] = {10192,1,91,95,12,60000,6,19,80,},
        [193] = {10193,1,91,95,13,65000,5,2,100000,},
        [194] = {10194,1,91,95,14,70000,5,8,1000,},
        [195] = {10195,1,91,95,15,75000,6,19,100,},
        [196] = {10196,1,91,95,16,80000,5,2,120000,},
        [197] = {10197,1,91,95,17,85000,5,8,1000,},
        [198] = {10198,1,91,95,18,90000,6,19,100,},
        [199] = {10199,1,91,95,19,95000,5,2,140000,},
        [200] = {10200,1,91,95,20,100000,5,8,1200,},
        [201] = {10201,1,96,100,1,7500,5,2,10000,},
        [202] = {10202,1,96,100,2,15000,5,8,500,},
        [203] = {10203,1,96,100,3,22500,6,19,50,},
        [204] = {10204,1,96,100,4,30000,5,2,20000,},
        [205] = {10205,1,96,100,5,37500,5,8,500,},
        [206] = {10206,1,96,100,6,45000,6,19,50,},
        [207] = {10207,1,96,100,7,52500,5,2,40000,},
        [208] = {10208,1,96,100,8,60000,5,8,800,},
        [209] = {10209,1,96,100,9,67500,6,19,80,},
        [210] = {10210,1,96,100,10,75000,5,2,80000,},
        [211] = {10211,1,96,100,11,82500,5,8,800,},
        [212] = {10212,1,96,100,12,90000,6,19,80,},
        [213] = {10213,1,96,100,13,97500,5,2,100000,},
        [214] = {10214,1,96,100,14,105000,5,8,1000,},
        [215] = {10215,1,96,100,15,112500,6,19,100,},
        [216] = {10216,1,96,100,16,120000,5,2,120000,},
        [217] = {10217,1,96,100,17,127500,5,8,1000,},
        [218] = {10218,1,96,100,18,135000,6,19,100,},
        [219] = {10219,1,96,100,19,142500,5,2,140000,},
        [220] = {10220,1,96,100,20,150000,5,8,1200,},
        [221] = {10221,1,101,105,1,10000,5,2,10000,},
        [222] = {10222,1,101,105,2,20000,5,8,500,},
        [223] = {10223,1,101,105,3,30000,6,19,50,},
        [224] = {10224,1,101,105,4,40000,5,2,20000,},
        [225] = {10225,1,101,105,5,50000,5,8,500,},
        [226] = {10226,1,101,105,6,60000,6,19,50,},
        [227] = {10227,1,101,105,7,70000,5,2,40000,},
        [228] = {10228,1,101,105,8,80000,5,8,800,},
        [229] = {10229,1,101,105,9,90000,6,19,80,},
        [230] = {10230,1,101,105,10,100000,5,2,80000,},
        [231] = {10231,1,101,105,11,110000,5,8,800,},
        [232] = {10232,1,101,105,12,120000,6,19,80,},
        [233] = {10233,1,101,105,13,130000,5,2,100000,},
        [234] = {10234,1,101,105,14,140000,5,8,1000,},
        [235] = {10235,1,101,105,15,150000,6,19,100,},
        [236] = {10236,1,101,105,16,160000,5,2,120000,},
        [237] = {10237,1,101,105,17,170000,5,8,1000,},
        [238] = {10238,1,101,105,18,180000,6,19,100,},
        [239] = {10239,1,101,105,19,190000,5,2,140000,},
        [240] = {10240,1,101,105,20,200000,5,8,1200,},
        [241] = {10241,1,106,110,1,15000,5,2,10000,},
        [242] = {10242,1,106,110,2,30000,5,8,500,},
        [243] = {10243,1,106,110,3,45000,6,19,50,},
        [244] = {10244,1,106,110,4,60000,5,2,20000,},
        [245] = {10245,1,106,110,5,75000,5,8,500,},
        [246] = {10246,1,106,110,6,90000,6,19,50,},
        [247] = {10247,1,106,110,7,105000,5,2,40000,},
        [248] = {10248,1,106,110,8,120000,5,8,800,},
        [249] = {10249,1,106,110,9,135000,6,19,80,},
        [250] = {10250,1,106,110,10,150000,5,2,80000,},
        [251] = {10251,1,106,110,11,165000,5,8,800,},
        [252] = {10252,1,106,110,12,180000,6,19,80,},
        [253] = {10253,1,106,110,13,195000,5,2,100000,},
        [254] = {10254,1,106,110,14,210000,5,8,1000,},
        [255] = {10255,1,106,110,15,225000,6,19,100,},
        [256] = {10256,1,106,110,16,240000,5,2,120000,},
        [257] = {10257,1,106,110,17,255000,5,8,1000,},
        [258] = {10258,1,106,110,18,270000,6,19,100,},
        [259] = {10259,1,106,110,19,285000,5,2,140000,},
        [260] = {10260,1,106,110,20,300000,5,8,1200,},
        [261] = {10261,1,111,115,1,20000,5,2,10000,},
        [262] = {10262,1,111,115,2,40000,5,8,500,},
        [263] = {10263,1,111,115,3,60000,6,19,50,},
        [264] = {10264,1,111,115,4,80000,5,2,20000,},
        [265] = {10265,1,111,115,5,100000,5,8,500,},
        [266] = {10266,1,111,115,6,120000,6,19,50,},
        [267] = {10267,1,111,115,7,140000,5,2,40000,},
        [268] = {10268,1,111,115,8,160000,5,8,800,},
        [269] = {10269,1,111,115,9,180000,6,19,80,},
        [270] = {10270,1,111,115,10,200000,5,2,80000,},
        [271] = {10271,1,111,115,11,220000,5,8,800,},
        [272] = {10272,1,111,115,12,240000,6,19,80,},
        [273] = {10273,1,111,115,13,260000,5,2,100000,},
        [274] = {10274,1,111,115,14,280000,5,8,1000,},
        [275] = {10275,1,111,115,15,300000,6,19,100,},
        [276] = {10276,1,111,115,16,320000,5,2,120000,},
        [277] = {10277,1,111,115,17,340000,5,8,1000,},
        [278] = {10278,1,111,115,18,360000,6,19,100,},
        [279] = {10279,1,111,115,19,380000,5,2,140000,},
        [280] = {10280,1,111,115,20,400000,5,8,1200,},
        [281] = {10281,1,116,120,1,25000,5,2,10000,},
        [282] = {10282,1,116,120,2,50000,5,8,500,},
        [283] = {10283,1,116,120,3,75000,6,19,50,},
        [284] = {10284,1,116,120,4,100000,5,2,20000,},
        [285] = {10285,1,116,120,5,125000,5,8,500,},
        [286] = {10286,1,116,120,6,150000,6,19,50,},
        [287] = {10287,1,116,120,7,175000,5,2,40000,},
        [288] = {10288,1,116,120,8,200000,5,8,800,},
        [289] = {10289,1,116,120,9,225000,6,19,80,},
        [290] = {10290,1,116,120,10,250000,5,2,80000,},
        [291] = {10291,1,116,120,11,275000,5,8,800,},
        [292] = {10292,1,116,120,12,300000,6,19,80,},
        [293] = {10293,1,116,120,13,325000,5,2,100000,},
        [294] = {10294,1,116,120,14,350000,5,8,1000,},
        [295] = {10295,1,116,120,15,375000,6,19,100,},
        [296] = {10296,1,116,120,16,400000,5,2,120000,},
        [297] = {10297,1,116,120,17,425000,5,8,1000,},
        [298] = {10298,1,116,120,18,450000,6,19,100,},
        [299] = {10299,1,116,120,19,475000,5,2,140000,},
        [300] = {10300,1,116,120,20,500000,5,8,1200,},
        [301] = {10501,2,1,50,1,5,6,15,10,},
        [302] = {10502,2,1,50,2,10,5,8,1500,},
        [303] = {10503,2,1,50,3,15,6,19,500,},
        [304] = {10504,2,1,50,4,20,6,80,1,},
        [305] = {10511,2,51,55,1,5,6,15,10,},
        [306] = {10512,2,51,55,2,10,5,8,1500,},
        [307] = {10513,2,51,55,3,15,6,19,500,},
        [308] = {10514,2,51,55,4,20,6,80,1,},
        [309] = {10521,2,56,60,1,5,6,15,10,},
        [310] = {10522,2,56,60,2,10,5,8,1500,},
        [311] = {10523,2,56,60,3,15,6,19,500,},
        [312] = {10524,2,56,60,4,20,6,80,1,},
        [313] = {10531,2,61,65,1,5,6,15,10,},
        [314] = {10532,2,61,65,2,10,5,8,1500,},
        [315] = {10533,2,61,65,3,15,6,19,500,},
        [316] = {10534,2,61,65,4,20,6,80,1,},
        [317] = {10541,2,66,70,1,5,6,15,10,},
        [318] = {10542,2,66,70,2,10,5,8,1500,},
        [319] = {10543,2,66,70,3,15,6,19,500,},
        [320] = {10544,2,66,70,4,20,6,80,1,},
        [321] = {10551,2,71,75,1,5,6,15,10,},
        [322] = {10552,2,71,75,2,10,5,8,1500,},
        [323] = {10553,2,71,75,3,15,6,19,500,},
        [324] = {10554,2,71,75,4,20,6,80,1,},
        [325] = {10561,2,76,80,1,5,6,15,10,},
        [326] = {10562,2,76,80,2,10,5,8,1500,},
        [327] = {10563,2,76,80,3,15,6,19,500,},
        [328] = {10564,2,76,80,4,20,6,80,1,},
        [329] = {10571,2,81,85,1,5,6,15,10,},
        [330] = {10572,2,81,85,2,10,5,8,1500,},
        [331] = {10573,2,81,85,3,15,6,19,500,},
        [332] = {10574,2,81,85,4,20,6,80,1,},
        [333] = {10581,2,86,90,1,5,6,15,10,},
        [334] = {10582,2,86,90,2,10,5,8,1500,},
        [335] = {10583,2,86,90,3,15,6,19,500,},
        [336] = {10584,2,86,90,4,20,6,80,1,},
        [337] = {10591,2,91,95,1,5,6,15,10,},
        [338] = {10592,2,91,95,2,10,5,8,1500,},
        [339] = {10593,2,91,95,3,15,6,19,500,},
        [340] = {10594,2,91,95,4,20,6,80,1,},
        [341] = {10601,2,96,100,1,5,6,15,10,},
        [342] = {10602,2,96,100,2,10,5,8,1500,},
        [343] = {10603,2,96,100,3,15,6,19,500,},
        [344] = {10604,2,96,100,4,20,6,80,1,},
        [345] = {10611,2,101,105,1,5,6,15,10,},
        [346] = {10612,2,101,105,2,10,5,8,1500,},
        [347] = {10613,2,101,105,3,15,6,19,500,},
        [348] = {10614,2,101,105,4,20,6,80,1,},
        [349] = {10621,2,106,110,1,5,6,15,10,},
        [350] = {10622,2,106,110,2,10,5,8,1500,},
        [351] = {10623,2,106,110,3,15,6,19,500,},
        [352] = {10624,2,106,110,4,20,6,80,1,},
        [353] = {10631,2,111,115,1,5,6,15,10,},
        [354] = {10632,2,111,115,2,10,5,8,1500,},
        [355] = {10633,2,111,115,3,15,6,19,500,},
        [356] = {10634,2,111,115,4,20,6,80,1,},
        [357] = {10641,2,116,120,1,5,6,15,10,},
        [358] = {10642,2,116,120,2,10,5,8,1500,},
        [359] = {10643,2,116,120,3,15,6,19,500,},
        [360] = {10644,2,116,120,4,20,6,80,1,},
    }
}

-- index
local __index_id = {
    [10001] = 1,
    [10002] = 2,
    [10003] = 3,
    [10004] = 4,
    [10005] = 5,
    [10006] = 6,
    [10007] = 7,
    [10008] = 8,
    [10009] = 9,
    [10010] = 10,
    [10011] = 11,
    [10012] = 12,
    [10013] = 13,
    [10014] = 14,
    [10015] = 15,
    [10016] = 16,
    [10017] = 17,
    [10018] = 18,
    [10019] = 19,
    [10020] = 20,
    [10021] = 21,
    [10022] = 22,
    [10023] = 23,
    [10024] = 24,
    [10025] = 25,
    [10026] = 26,
    [10027] = 27,
    [10028] = 28,
    [10029] = 29,
    [10030] = 30,
    [10031] = 31,
    [10032] = 32,
    [10033] = 33,
    [10034] = 34,
    [10035] = 35,
    [10036] = 36,
    [10037] = 37,
    [10038] = 38,
    [10039] = 39,
    [10040] = 40,
    [10041] = 41,
    [10042] = 42,
    [10043] = 43,
    [10044] = 44,
    [10045] = 45,
    [10046] = 46,
    [10047] = 47,
    [10048] = 48,
    [10049] = 49,
    [10050] = 50,
    [10051] = 51,
    [10052] = 52,
    [10053] = 53,
    [10054] = 54,
    [10055] = 55,
    [10056] = 56,
    [10057] = 57,
    [10058] = 58,
    [10059] = 59,
    [10060] = 60,
    [10061] = 61,
    [10062] = 62,
    [10063] = 63,
    [10064] = 64,
    [10065] = 65,
    [10066] = 66,
    [10067] = 67,
    [10068] = 68,
    [10069] = 69,
    [10070] = 70,
    [10071] = 71,
    [10072] = 72,
    [10073] = 73,
    [10074] = 74,
    [10075] = 75,
    [10076] = 76,
    [10077] = 77,
    [10078] = 78,
    [10079] = 79,
    [10080] = 80,
    [10081] = 81,
    [10082] = 82,
    [10083] = 83,
    [10084] = 84,
    [10085] = 85,
    [10086] = 86,
    [10087] = 87,
    [10088] = 88,
    [10089] = 89,
    [10090] = 90,
    [10091] = 91,
    [10092] = 92,
    [10093] = 93,
    [10094] = 94,
    [10095] = 95,
    [10096] = 96,
    [10097] = 97,
    [10098] = 98,
    [10099] = 99,
    [10100] = 100,
    [10101] = 101,
    [10102] = 102,
    [10103] = 103,
    [10104] = 104,
    [10105] = 105,
    [10106] = 106,
    [10107] = 107,
    [10108] = 108,
    [10109] = 109,
    [10110] = 110,
    [10111] = 111,
    [10112] = 112,
    [10113] = 113,
    [10114] = 114,
    [10115] = 115,
    [10116] = 116,
    [10117] = 117,
    [10118] = 118,
    [10119] = 119,
    [10120] = 120,
    [10121] = 121,
    [10122] = 122,
    [10123] = 123,
    [10124] = 124,
    [10125] = 125,
    [10126] = 126,
    [10127] = 127,
    [10128] = 128,
    [10129] = 129,
    [10130] = 130,
    [10131] = 131,
    [10132] = 132,
    [10133] = 133,
    [10134] = 134,
    [10135] = 135,
    [10136] = 136,
    [10137] = 137,
    [10138] = 138,
    [10139] = 139,
    [10140] = 140,
    [10141] = 141,
    [10142] = 142,
    [10143] = 143,
    [10144] = 144,
    [10145] = 145,
    [10146] = 146,
    [10147] = 147,
    [10148] = 148,
    [10149] = 149,
    [10150] = 150,
    [10151] = 151,
    [10152] = 152,
    [10153] = 153,
    [10154] = 154,
    [10155] = 155,
    [10156] = 156,
    [10157] = 157,
    [10158] = 158,
    [10159] = 159,
    [10160] = 160,
    [10161] = 161,
    [10162] = 162,
    [10163] = 163,
    [10164] = 164,
    [10165] = 165,
    [10166] = 166,
    [10167] = 167,
    [10168] = 168,
    [10169] = 169,
    [10170] = 170,
    [10171] = 171,
    [10172] = 172,
    [10173] = 173,
    [10174] = 174,
    [10175] = 175,
    [10176] = 176,
    [10177] = 177,
    [10178] = 178,
    [10179] = 179,
    [10180] = 180,
    [10181] = 181,
    [10182] = 182,
    [10183] = 183,
    [10184] = 184,
    [10185] = 185,
    [10186] = 186,
    [10187] = 187,
    [10188] = 188,
    [10189] = 189,
    [10190] = 190,
    [10191] = 191,
    [10192] = 192,
    [10193] = 193,
    [10194] = 194,
    [10195] = 195,
    [10196] = 196,
    [10197] = 197,
    [10198] = 198,
    [10199] = 199,
    [10200] = 200,
    [10201] = 201,
    [10202] = 202,
    [10203] = 203,
    [10204] = 204,
    [10205] = 205,
    [10206] = 206,
    [10207] = 207,
    [10208] = 208,
    [10209] = 209,
    [10210] = 210,
    [10211] = 211,
    [10212] = 212,
    [10213] = 213,
    [10214] = 214,
    [10215] = 215,
    [10216] = 216,
    [10217] = 217,
    [10218] = 218,
    [10219] = 219,
    [10220] = 220,
    [10221] = 221,
    [10222] = 222,
    [10223] = 223,
    [10224] = 224,
    [10225] = 225,
    [10226] = 226,
    [10227] = 227,
    [10228] = 228,
    [10229] = 229,
    [10230] = 230,
    [10231] = 231,
    [10232] = 232,
    [10233] = 233,
    [10234] = 234,
    [10235] = 235,
    [10236] = 236,
    [10237] = 237,
    [10238] = 238,
    [10239] = 239,
    [10240] = 240,
    [10241] = 241,
    [10242] = 242,
    [10243] = 243,
    [10244] = 244,
    [10245] = 245,
    [10246] = 246,
    [10247] = 247,
    [10248] = 248,
    [10249] = 249,
    [10250] = 250,
    [10251] = 251,
    [10252] = 252,
    [10253] = 253,
    [10254] = 254,
    [10255] = 255,
    [10256] = 256,
    [10257] = 257,
    [10258] = 258,
    [10259] = 259,
    [10260] = 260,
    [10261] = 261,
    [10262] = 262,
    [10263] = 263,
    [10264] = 264,
    [10265] = 265,
    [10266] = 266,
    [10267] = 267,
    [10268] = 268,
    [10269] = 269,
    [10270] = 270,
    [10271] = 271,
    [10272] = 272,
    [10273] = 273,
    [10274] = 274,
    [10275] = 275,
    [10276] = 276,
    [10277] = 277,
    [10278] = 278,
    [10279] = 279,
    [10280] = 280,
    [10281] = 281,
    [10282] = 282,
    [10283] = 283,
    [10284] = 284,
    [10285] = 285,
    [10286] = 286,
    [10287] = 287,
    [10288] = 288,
    [10289] = 289,
    [10290] = 290,
    [10291] = 291,
    [10292] = 292,
    [10293] = 293,
    [10294] = 294,
    [10295] = 295,
    [10296] = 296,
    [10297] = 297,
    [10298] = 298,
    [10299] = 299,
    [10300] = 300,
    [10501] = 301,
    [10502] = 302,
    [10503] = 303,
    [10504] = 304,
    [10511] = 305,
    [10512] = 306,
    [10513] = 307,
    [10514] = 308,
    [10521] = 309,
    [10522] = 310,
    [10523] = 311,
    [10524] = 312,
    [10531] = 313,
    [10532] = 314,
    [10533] = 315,
    [10534] = 316,
    [10541] = 317,
    [10542] = 318,
    [10543] = 319,
    [10544] = 320,
    [10551] = 321,
    [10552] = 322,
    [10553] = 323,
    [10554] = 324,
    [10561] = 325,
    [10562] = 326,
    [10563] = 327,
    [10564] = 328,
    [10571] = 329,
    [10572] = 330,
    [10573] = 331,
    [10574] = 332,
    [10581] = 333,
    [10582] = 334,
    [10583] = 335,
    [10584] = 336,
    [10591] = 337,
    [10592] = 338,
    [10593] = 339,
    [10594] = 340,
    [10601] = 341,
    [10602] = 342,
    [10603] = 343,
    [10604] = 344,
    [10611] = 345,
    [10612] = 346,
    [10613] = 347,
    [10614] = 348,
    [10621] = 349,
    [10622] = 350,
    [10623] = 351,
    [10624] = 352,
    [10631] = 353,
    [10632] = 354,
    [10633] = 355,
    [10634] = 356,
    [10641] = 357,
    [10642] = 358,
    [10643] = 359,
    [10644] = 360,

}

-- metatable
local mt = { 
    __index = function(t, k) 
        assert(__key_map[k], "cannot find " .. k .. " in rebel_dmg_reward")
        if _lang ~= "cn" and _isExist  and t._lang_key_map[k] then
            return t._lang[t._lang_key_map[k]]
        end
        return t._raw[__key_map[k]]
    end
}

-- 
function rebel_dmg_reward.length()
    return #rebel_dmg_reward._data
end

-- 
function rebel_dmg_reward.hasKey(k)
    if __key_map[k] == nil then
        return false
    else
        return true
    end
end

--
function rebel_dmg_reward.indexOf(index)
    if index == nil or not rebel_dmg_reward._data[index] then
        return nil
    end
    if Lang.lang ~= "cn" and Lang.lang ~= _lang then 
        _lang = Lang.lang 
        if Lang.isFileExist("app/i18n/".. _lang .."/config/rebel_dmg_reward.lua") then _isExist =  true end
    end
    if _lang ~= "cn" and _isExist then
        local table = require( "app.i18n.".. _lang ..".config." .. "rebel_dmg_reward" )
        return setmetatable({_raw = rebel_dmg_reward._data[index], _lang=table._data[index], _lang_key_map=table.__key_map}, mt)
    end
    return setmetatable({_raw = rebel_dmg_reward._data[index]}, mt)
end

--
function rebel_dmg_reward.get(id)
    
    return rebel_dmg_reward.indexOf(__index_id[id])
        
end

--
function rebel_dmg_reward.set(id, key, value)
    local record = rebel_dmg_reward.get(id)
    if record then
        local keyIndex = __key_map[key]
        if keyIndex then
            record._raw[keyIndex] = value
        end
    end
end

--
function rebel_dmg_reward.index()
    return __index_id
end

return rebel_dmg_reward