--story_chat_length

local story_chat_length = {
    -- key
    __key_map = {
      chat = 1,    --语音文件名-string 
      length = 2,    --语音长度/毫秒-int 
    
    },
    -- data
    _data = {
        [1] = {"1_skill",2000,},
        [2] = {"1_voice1",4000,},
        [3] = {"1_voice2",5000,},
        [4] = {"1_voice3",3000,},
        [5] = {"1_voice4",3000,},
        [6] = {"1_voice5",4000,},
        [7] = {"1_voice6",5000,},
        [8] = {"11_skill",2000,},
        [9] = {"11_voice1",4000,},
        [10] = {"11_voice2",9000,},
        [11] = {"11_voice3",3000,},
        [12] = {"11_voice3_2",2000,},
        [13] = {"11_voice4",3000,},
        [14] = {"11_voice5",4000,},
        [15] = {"11_voice6",4000,},
        [16] = {"101_hj",2000,},
        [17] = {"101_skill",2000,},
        [18] = {"101_voice1",4000,},
        [19] = {"101_voice2",7000,},
        [20] = {"101_voice3",6000,},
        [21] = {"101_voice4",4000,},
        [22] = {"102_skill",3000,},
        [23] = {"102_voice1",4000,},
        [24] = {"102_voice2",4000,},
        [25] = {"102_voice3",6000,},
        [26] = {"103_hj",3000,},
        [27] = {"103_skill",3000,},
        [28] = {"103_voice1",6000,},
        [29] = {"103_voice2",7000,},
        [30] = {"103_voice3",4000,},
        [31] = {"103_voice4",6000,},
        [32] = {"104_skill",2000,},
        [33] = {"104_voice1",4000,},
        [34] = {"104_voice2",5000,},
        [35] = {"104_voice3",4000,},
        [36] = {"105_hj",2000,},
        [37] = {"105_skill",2000,},
        [38] = {"105_voice1",4000,},
        [39] = {"105_voice2",4000,},
        [40] = {"105_voice3",5000,},
        [41] = {"106_skill",3000,},
        [42] = {"106_voice1",3000,},
        [43] = {"106_voice2",4000,},
        [44] = {"106_voice3",4000,},
        [45] = {"107_hj",2000,},
        [46] = {"107_skill",2000,},
        [47] = {"107_voice1",2000,},
        [48] = {"107_voice2",3000,},
        [49] = {"107_voice3",6000,},
        [50] = {"108_skill",2000,},
        [51] = {"108_voice1",4000,},
        [52] = {"108_voice2",4000,},
        [53] = {"108_voice3",5000,},
        [54] = {"109_hj",2000,},
        [55] = {"109_skill",3000,},
        [56] = {"109_voice1",2000,},
        [57] = {"109_voice2",3000,},
        [58] = {"109_voice3",5000,},
        [59] = {"110_skill",2000,},
        [60] = {"110_voice1",4000,},
        [61] = {"110_voice2",4000,},
        [62] = {"110_voice3",6000,},
        [63] = {"111_hj",2000,},
        [64] = {"111_skill",3000,},
        [65] = {"111_voice1",2000,},
        [66] = {"111_voice2",5000,},
        [67] = {"111_voice3",4000,},
        [68] = {"112_skill",2000,},
        [69] = {"112_voice1",6000,},
        [70] = {"112_voice2",2000,},
        [71] = {"112_voice3",4000,},
        [72] = {"113_hj",2000,},
        [73] = {"113_skill",2000,},
        [74] = {"113_voice1",5000,},
        [75] = {"113_voice2",4000,},
        [76] = {"113_voice3",4000,},
        [77] = {"114_skill",3000,},
        [78] = {"114_voice1",4000,},
        [79] = {"114_voice2",2000,},
        [80] = {"114_voice3",3000,},
        [81] = {"115_skill",2000,},
        [82] = {"115_voice1",5000,},
        [83] = {"115_voice2",3000,},
        [84] = {"115_voice3",8000,},
        [85] = {"116_skill",2000,},
        [86] = {"116_voice1",4000,},
        [87] = {"116_voice2",7000,},
        [88] = {"116_voice3",5000,},
        [89] = {"117_skill",2000,},
        [90] = {"117_voice1",4000,},
        [91] = {"117_voice2",4000,},
        [92] = {"117_voice3",5000,},
        [93] = {"118_skill",2000,},
        [94] = {"118_voice1",5000,},
        [95] = {"118_voice2",4000,},
        [96] = {"118_voice3",7000,},
        [97] = {"119_skill",3000,},
        [98] = {"119_voice1",4000,},
        [99] = {"119_voice2",4000,},
        [100] = {"119_voice3",4000,},
        [101] = {"201_hj",2000,},
        [102] = {"201_skill",2000,},
        [103] = {"201_voice1",3000,},
        [104] = {"201_voice2",6000,},
        [105] = {"201_voice3",3000,},
        [106] = {"201_voice4",6000,},
        [107] = {"202_skill",3000,},
        [108] = {"202_voice1",4000,},
        [109] = {"202_voice2",3000,},
        [110] = {"202_voice3",4000,},
        [111] = {"203_hj",3000,},
        [112] = {"203_skill",2000,},
        [113] = {"203_voice1",5000,},
        [114] = {"203_voice2",6000,},
        [115] = {"203_voice3",7000,},
        [116] = {"203_voice4",4000,},
        [117] = {"204_skill",2000,},
        [118] = {"204_voice1",5000,},
        [119] = {"204_voice2",8000,},
        [120] = {"204_voice3",4000,},
        [121] = {"205_hj",2000,},
        [122] = {"205_skill",3000,},
        [123] = {"205_voice1",4000,},
        [124] = {"205_voice2",3000,},
        [125] = {"205_voice3",5000,},
        [126] = {"206_skill",3000,},
        [127] = {"206_voice1",3000,},
        [128] = {"206_voice2",5000,},
        [129] = {"206_voice3",4000,},
        [130] = {"207_hj",2000,},
        [131] = {"207_skill",2000,},
        [132] = {"207_voice1",3000,},
        [133] = {"207_voice2",4000,},
        [134] = {"207_voice3",3000,},
        [135] = {"208_skill",2000,},
        [136] = {"208_voice1",4000,},
        [137] = {"208_voice2",4000,},
        [138] = {"208_voice3",3000,},
        [139] = {"209_hj",3000,},
        [140] = {"209_skill",2000,},
        [141] = {"209_voice1",4000,},
        [142] = {"209_voice2",5000,},
        [143] = {"209_voice3",4000,},
        [144] = {"210_skill",3000,},
        [145] = {"210_voice1",4000,},
        [146] = {"210_voice2",3000,},
        [147] = {"210_voice3",3000,},
        [148] = {"211_hj",2000,},
        [149] = {"211_skill",3000,},
        [150] = {"211_voice1",4000,},
        [151] = {"211_voice2",6000,},
        [152] = {"211_voice3",5000,},
        [153] = {"212_skill",2000,},
        [154] = {"212_voice1",4000,},
        [155] = {"212_voice2",2000,},
        [156] = {"212_voice3",3000,},
        [157] = {"213_hj",2000,},
        [158] = {"213_skill",2000,},
        [159] = {"213_voice1",3000,},
        [160] = {"213_voice2",4000,},
        [161] = {"213_voice3",6000,},
        [162] = {"213_voice3_2",4000,},
        [163] = {"214_skill",3000,},
        [164] = {"214_voice1",4000,},
        [165] = {"214_voice2",5000,},
        [166] = {"214_voice3",3000,},
        [167] = {"215_skill",2000,},
        [168] = {"215_voice1",5000,},
        [169] = {"215_voice2",4000,},
        [170] = {"215_voice3",3000,},
        [171] = {"216_skill",2000,},
        [172] = {"216_voice1",4000,},
        [173] = {"216_voice2",2000,},
        [174] = {"216_voice3",3000,},
        [175] = {"217_hj",3000,},
        [176] = {"217_skill",2000,},
        [177] = {"217_voice1",4000,},
        [178] = {"217_voice2",4000,},
        [179] = {"217_voice3",4000,},
        [180] = {"218_skill",2000,},
        [181] = {"218_voice1",5000,},
        [182] = {"218_voice2",5000,},
        [183] = {"218_voice3",3000,},
        [184] = {"219_skill",3000,},
        [185] = {"219_voice1",6000,},
        [186] = {"219_voice2",5000,},
        [187] = {"219_voice3",4000,},
        [188] = {"301_hj",2000,},
        [189] = {"301_skill",3000,},
        [190] = {"301_voice1",5000,},
        [191] = {"301_voice2",4000,},
        [192] = {"301_voice3",6000,},
        [193] = {"301_voice4",4000,},
        [194] = {"302_skill",2000,},
        [195] = {"302_voice1",4000,},
        [196] = {"302_voice2",3000,},
        [197] = {"302_voice3",10000,},
        [198] = {"303_hj",3000,},
        [199] = {"303_skill",3000,},
        [200] = {"303_voice1",6000,},
        [201] = {"303_voice2",7000,},
        [202] = {"303_voice3",5000,},
        [203] = {"303_voice4",6000,},
        [204] = {"304_skill",3000,},
        [205] = {"304_voice1",3000,},
        [206] = {"304_voice2",3000,},
        [207] = {"304_voice3",4000,},
        [208] = {"305_hj",2000,},
        [209] = {"305_skill",2000,},
        [210] = {"305_voice1",4000,},
        [211] = {"305_voice2",5000,},
        [212] = {"305_voice3",5000,},
        [213] = {"306_skill",3000,},
        [214] = {"306_voice1",5000,},
        [215] = {"306_voice2",4000,},
        [216] = {"306_voice3",7000,},
        [217] = {"307_hj",2000,},
        [218] = {"307_skill",3000,},
        [219] = {"307_voice1",5000,},
        [220] = {"307_voice2",4000,},
        [221] = {"307_voice3",5000,},
        [222] = {"308_skill",2000,},
        [223] = {"308_voice1",5000,},
        [224] = {"308_voice2",5000,},
        [225] = {"308_voice3",3000,},
        [226] = {"309_hj",2000,},
        [227] = {"309_skill",2000,},
        [228] = {"309_voice1",4000,},
        [229] = {"309_voice2",4000,},
        [230] = {"309_voice3",5000,},
        [231] = {"310_skill",2000,},
        [232] = {"310_voice1",3000,},
        [233] = {"310_voice2",4000,},
        [234] = {"310_voice3",3000,},
        [235] = {"311_hj",2000,},
        [236] = {"311_skill",3000,},
        [237] = {"311_voice1",4000,},
        [238] = {"311_voice2",6000,},
        [239] = {"311_voice3",5000,},
        [240] = {"312_skill",2000,},
        [241] = {"312_voice1",4000,},
        [242] = {"312_voice2",5000,},
        [243] = {"312_voice3",3000,},
        [244] = {"313_hj",2000,},
        [245] = {"313_skill",2000,},
        [246] = {"313_voice1",3000,},
        [247] = {"313_voice2",3000,},
        [248] = {"313_voice3",2000,},
        [249] = {"314_skill",2000,},
        [250] = {"314_voice1",3000,},
        [251] = {"314_voice2",6000,},
        [252] = {"314_voice3",4000,},
        [253] = {"315_skill",2000,},
        [254] = {"315_voice1",6000,},
        [255] = {"315_voice2",5000,},
        [256] = {"315_voice3",5000,},
        [257] = {"316_skill",2000,},
        [258] = {"316_voice1",3000,},
        [259] = {"316_voice2",4000,},
        [260] = {"316_voice3",4000,},
        [261] = {"317_skill",3000,},
        [262] = {"317_voice1",4000,},
        [263] = {"317_voice2",5000,},
        [264] = {"317_voice3",6000,},
        [265] = {"318_skill",2000,},
        [266] = {"318_voice1",3000,},
        [267] = {"318_voice2",2000,},
        [268] = {"318_voice3",2000,},
        [269] = {"319_skill",3000,},
        [270] = {"319_voice1",4000,},
        [271] = {"319_voice2",3000,},
        [272] = {"319_voice3",3000,},
        [273] = {"401_hj",2000,},
        [274] = {"401_skill",2000,},
        [275] = {"401_voice1",5000,},
        [276] = {"401_voice2",3000,},
        [277] = {"401_voice3",5000,},
        [278] = {"401_voice4",5000,},
        [279] = {"402_skill",2000,},
        [280] = {"402_voice1",6000,},
        [281] = {"402_voice2",5000,},
        [282] = {"402_voice3",5000,},
        [283] = {"403_hj",2000,},
        [284] = {"403_skill",3000,},
        [285] = {"403_voice1",4000,},
        [286] = {"403_voice2",5000,},
        [287] = {"403_voice3",4000,},
        [288] = {"403_voice4",3000,},
        [289] = {"404_skill",2000,},
        [290] = {"404_voice1",14000,},
        [291] = {"404_voice2",3000,},
        [292] = {"404_voice3",6000,},
        [293] = {"405_hj",3000,},
        [294] = {"405_skill",3000,},
        [295] = {"405_voice1",3000,},
        [296] = {"405_voice2",6000,},
        [297] = {"405_voice3",5000,},
        [298] = {"405_voice4",5000,},
        [299] = {"406_skill",2000,},
        [300] = {"406_voice1",4000,},
        [301] = {"406_voice2",5000,},
        [302] = {"406_voice3",4000,},
        [303] = {"407_hj",2000,},
        [304] = {"407_skill",3000,},
        [305] = {"407_voice1",8000,},
        [306] = {"407_voice2",7000,},
        [307] = {"407_voice3",6000,},
        [308] = {"408_skill",2000,},
        [309] = {"408_voice1",4000,},
        [310] = {"408_voice2",3000,},
        [311] = {"408_voice3",5000,},
        [312] = {"409_hj",2000,},
        [313] = {"409_skill",2000,},
        [314] = {"409_voice1",4000,},
        [315] = {"409_voice2",4000,},
        [316] = {"409_voice3",5000,},
        [317] = {"410_skill",2000,},
        [318] = {"410_voice1",3000,},
        [319] = {"410_voice2",4000,},
        [320] = {"410_voice3",6000,},
        [321] = {"411_hj",2000,},
        [322] = {"411_skill",3000,},
        [323] = {"411_voice1",4000,},
        [324] = {"411_voice2",3000,},
        [325] = {"411_voice3",6000,},
        [326] = {"412_skill",2000,},
        [327] = {"412_voice1",5000,},
        [328] = {"412_voice2",4000,},
        [329] = {"412_voice3",4000,},
        [330] = {"413_hj",2000,},
        [331] = {"413_skill",2000,},
        [332] = {"413_voice1",3000,},
        [333] = {"413_voice2",3000,},
        [334] = {"413_voice3",3000,},
        [335] = {"414_skill",3000,},
        [336] = {"414_voice1",3000,},
        [337] = {"414_voice2",3000,},
        [338] = {"414_voice3",3000,},
        [339] = {"415_skill",2000,},
        [340] = {"415_voice1",6000,},
        [341] = {"415_voice2",5000,},
        [342] = {"415_voice3",7000,},
        [343] = {"416_skill",3000,},
        [344] = {"416_voice1",4000,},
        [345] = {"416_voice2",4000,},
        [346] = {"416_voice3",4000,},
        [347] = {"417_skill",2000,},
        [348] = {"417_voice1",6000,},
        [349] = {"417_voice2",5000,},
        [350] = {"417_voice3",4000,},
        [351] = {"418_skill",2000,},
        [352] = {"418_voice1",4000,},
        [353] = {"418_voice2",2000,},
        [354] = {"418_voice3",3000,},
        [355] = {"419_skill",2000,},
        [356] = {"419_voice1",4000,},
        [357] = {"419_voice2",4000,},
        [358] = {"419_voice3",3000,},
        [359] = {"501_skill",2000,},
        [360] = {"501_voice1",4000,},
        [361] = {"502_skill",2000,},
        [362] = {"502_voice1",3000,},
        [363] = {"503_skill",2000,},
        [364] = {"503_voice1",4000,},
        [365] = {"504_skill",3000,},
        [366] = {"504_voice1",4000,},
        [367] = {"505_skill",3000,},
        [368] = {"505_voice1",5000,},
        [369] = {"506_skill",3000,},
        [370] = {"506_voice1",4000,},
        [371] = {"507_skill",2000,},
        [372] = {"507_voice1",4000,},
        [373] = {"508_skill",3000,},
        [374] = {"508_voice1",5000,},
        [375] = {"509_skill",2000,},
        [376] = {"509_voice1",3000,},
        [377] = {"510_skill",2000,},
        [378] = {"510_voice1",6000,},
        [379] = {"511_skill",3000,},
        [380] = {"511_voice1",3000,},
        [381] = {"512_skill",2000,},
        [382] = {"512_voice1",2000,},
        [383] = {"513_skill",3000,},
        [384] = {"513_voice1",4000,},
        [385] = {"514_skill",2000,},
        [386] = {"514_voice1",5000,},
        [387] = {"515_skill",2000,},
        [388] = {"515_voice1",4000,},
        [389] = {"516_skill",3000,},
        [390] = {"516_voice1",2000,},
        [391] = {"517_skill",2000,},
        [392] = {"517_voice1",5000,},
        [393] = {"518_skill",2000,},
        [394] = {"518_voice1",4000,},
        [395] = {"519_skill",3000,},
        [396] = {"519_voice1",3000,},
        [397] = {"520_skill",3000,},
        [398] = {"520_voice1",3000,},
        [399] = {"521_skill",2000,},
        [400] = {"521_voice1",4000,},
        [401] = {"522_skill",2000,},
        [402] = {"522_voice1",4000,},
        [403] = {"601_skill",2000,},
        [404] = {"601_voice1",3000,},
        [405] = {"602_skill",2000,},
        [406] = {"602_voice1",2000,},
        [407] = {"603_skill",2000,},
        [408] = {"603_voice1",2000,},
        [409] = {"604_skill",2000,},
        [410] = {"604_voice1",4000,},
        [411] = {"guide206",4000,},
        [412] = {"guide302",5000,},
        [413] = {"guide402",3000,},
        [414] = {"guide404",3000,},
        [415] = {"guide602",5000,},
        [416] = {"guide702",4000,},
        [417] = {"guide704",4000,},
        [418] = {"guide803",4000,},
        [419] = {"guide902",5000,},
        [420] = {"guide1002",4000,},
        [421] = {"guide1004",6000,},
        [422] = {"guide1102",6000,},
        [423] = {"guide1206",5000,},
        [424] = {"guide1306",4000,},
        [425] = {"guide1502",3000,},
        [426] = {"guide1705",4000,},
        [427] = {"guide1806",3000,},
        [428] = {"guide1906",3000,},
        [429] = {"guide2006",3000,},
        [430] = {"guide2009",3000,},
        [431] = {"guide2102",4000,},
        [432] = {"guide2106",3000,},
        [433] = {"guide2204",3000,},
        [434] = {"guide2308",3000,},
        [435] = {"guide3006",4000,},
        [436] = {"guide3205",4000,},
        [437] = {"guide4507",4000,},
        [438] = {"story_cc_4",9000,},
        [439] = {"story_cc_5",12000,},
        [440] = {"story_cc_6",12000,},
        [441] = {"story_cc_7",14000,},
        [442] = {"story_cc_8",6000,},
        [443] = {"story_cc_9",5000,},
        [444] = {"story_cc_10",9000,},
        [445] = {"story_cc_11",9600,},
        [446] = {"story_cc_12",10000,},
        [447] = {"story_cc_13",9600,},
        [448] = {"story_cc_14",12800,},
        [449] = {"story_cc_15",14000,},
        [450] = {"story_cc_16",9000,},
        [451] = {"story_cc_16_1",13000,},
        [452] = {"story_cc_17",6000,},
        [453] = {"story_cc_18",8000,},
        [454] = {"story_cc_19",10000,},
        [455] = {"story_cc_20",8000,},
        [456] = {"story_cc_21",8000,},
        [457] = {"story_cg_1",11200,},
        [458] = {"story_cg_2",20800,},
        [459] = {"story_cg_3",12800,},
        [460] = {"story_cg_4",13000,},
        [461] = {"story_cg_5",10000,},
        [462] = {"story_dz_3",11000,},
        [463] = {"story_dz_4",9600,},
        [464] = {"story_dz_5",12800,},
        [465] = {"story_dz_6",8000,},
        [466] = {"story_dz_7",13000,},
        [467] = {"story_gyp_30",7000,},
        [468] = {"story_gyp_31",5000,},
        [469] = {"story_gyp_32",6000,},
        [470] = {"story_gyp_33",7000,},
        [471] = {"story_gyp_34",9000,},
        [472] = {"story_gyp_35",7000,},
        [473] = {"story_gyp_36",11000,},
        [474] = {"story_gyp_37",7000,},
        [475] = {"story_gyp_38",8000,},
        [476] = {"story_gyp_39",6000,},
        [477] = {"story_gyp_40",4000,},
        [478] = {"story_gyp_41",8000,},
        [479] = {"story_gyp_42",12000,},
        [480] = {"story_gyp_43",6000,},
        [481] = {"story_hj_1_1",6000,},
        [482] = {"story_hj_1_2",6000,},
        [483] = {"story_hj_2_1",12000,},
        [484] = {"story_hj_2_2",12000,},
        [485] = {"story_hth_1_1",9000,},
        [486] = {"story_hth_2_1",7500,},
        [487] = {"story_hxd_3",10000,},
        [488] = {"story_lb_4",7000,},
        [489] = {"story_lb_4_1",7000,},
        [490] = {"story_lb_5",5000,},
        [491] = {"story_nzj_15",4000,},
        [492] = {"story_nzj_16",4000,},
        [493] = {"story_nzj_17",5000,},
        [494] = {"story_nzj_18",5000,},
        [495] = {"story_nzj_19",5000,},
        [496] = {"story_nzj_20",5000,},
        [497] = {"story_nzj_21",6000,},
        [498] = {"story_nzj_22",7000,},
        [499] = {"story_nzj_23",4000,},
        [500] = {"story_nzj_24",11200,},
        [501] = {"story_nzj_25",6000,},
        [502] = {"story_nzj_26",7000,},
        [503] = {"story_nzj_27",6000,},
        [504] = {"story_nzj_28",5000,},
        [505] = {"story_nzj_29",6000,},
        [506] = {"story_xy_1",13000,},
        [507] = {"story_xy_2",15000,},
        [508] = {"story_xy_3",12000,},
        [509] = {"story_xy_4",11000,},
        [510] = {"story_ys_2",14000,},
        [511] = {"story_zhangj_9",15000,},
        [512] = {"story_zj_15",4000,},
        [513] = {"story_zj_16",6000,},
        [514] = {"story_zj_17",5000,},
        [515] = {"story_zj_18",4000,},
        [516] = {"story_zj_19",6000,},
        [517] = {"story_zj_20",5000,},
        [518] = {"story_zj_21",6000,},
        [519] = {"story_zj_22",7000,},
        [520] = {"story_zj_23",4000,},
        [521] = {"story_zj_24",8000,},
        [522] = {"story_zj_25",6000,},
        [523] = {"story_zj_26",7000,},
        [524] = {"story_zj_27",5000,},
        [525] = {"story_zj_28",5000,},
        [526] = {"story_zj_29",6000,},
        [527] = {"story_zl_2",4000,},
        [528] = {"story_zxc_50",13000,},
        [529] = {"story_zxc_51",10000,},
        [530] = {"story_zxc_52",10000,},
        [531] = {"story_zxc_53",8000,},
        [532] = {"story_zxc_54",6000,},
        [533] = {"story_zxc_55",8000,},
        [534] = {"story_zxc_56",7000,},
        [535] = {"story_zxc_57",6000,},
        [536] = {"story_zxc_58",9000,},
        [537] = {"story_zxc_59",8000,},
        [538] = {"story_zxc_60",4000,},
        [539] = {"story_zxc_61",8000,},
        [540] = {"story_zxc_62",4000,},
        [541] = {"story_zxc_63",10000,},
        [542] = {"story_zxc_64",8000,},
        [543] = {"story_zxc_65",7000,},
        [544] = {"story_zxc_66",8000,},
        [545] = {"story_zxc_67",7000,},
        [546] = {"story_zxc_68",12000,},
        [547] = {"story_zxc_69",5000,},
        [548] = {"story_zxc_70",9000,},
        [549] = {"story_zxc_71",9000,},
        [550] = {"story_zxc_72",8000,},
        [551] = {"story_zxc_73",9000,},
        [552] = {"story_zxc_74",13000,},
        [553] = {"story_zy_1 (2)",6000,},
        [554] = {"story_cc_1",7800,},
        [555] = {"story_cc_2",13000,},
        [556] = {"story_cc_3",16900,},
        [557] = {"story_dc_1",4000,},
        [558] = {"story_dc_2",6500,},
        [559] = {"story_dq_1",5000,},
        [560] = {"story_dz_1",7800,},
        [561] = {"story_dz_2",7800,},
        [562] = {"story_gyp_1",6000,},
        [563] = {"story_gyp_10",5200,},
        [564] = {"story_gyp_11",11700,},
        [565] = {"story_gyp_12",6000,},
        [566] = {"story_gyp_13",5200,},
        [567] = {"story_gyp_14",5200,},
        [568] = {"story_gyp_15",7000,},
        [569] = {"story_gyp_16",6000,},
        [570] = {"story_gyp_17",8000,},
        [571] = {"story_gyp_18",4000,},
        [572] = {"story_gyp_19",6400,},
        [573] = {"story_gyp_2",5000,},
        [574] = {"story_gyp_20",8000,},
        [575] = {"story_gyp_21",10000,},
        [576] = {"story_gyp_22",10000,},
        [577] = {"story_gyp_23",3000,},
        [578] = {"story_gyp_24",11000,},
        [579] = {"story_gyp_25",6000,},
        [580] = {"story_gyp_26",5000,},
        [581] = {"story_gyp_27",17600,},
        [582] = {"story_gyp_28",11000,},
        [583] = {"story_gyp_29",5000,},
        [584] = {"story_gyp_3",7000,},
        [585] = {"story_gyp_4",6000,},
        [586] = {"story_gyp_5",6000,},
        [587] = {"story_gyp_6",6000,},
        [588] = {"story_gyp_7",4000,},
        [589] = {"story_gyp_8",8000,},
        [590] = {"story_gyp_9",6000,},
        [591] = {"story_gy_1",9100,},
        [592] = {"story_gy_2",5200,},
        [593] = {"story_gy_3",14300,},
        [594] = {"story_hj_1",9600,},
        [595] = {"story_hj_2",17600,},
        [596] = {"story_hth_1",9100,},
        [597] = {"story_hth_2",7800,},
        [598] = {"story_hxd_1",4000,},
        [599] = {"story_hxd_2",9000,},
        [600] = {"story_lb_1",6000,},
        [601] = {"story_lb_2",6000,},
        [602] = {"story_lb_3",6500,},
        [603] = {"story_nzj_1",6000,},
        [604] = {"story_nzj_10",5200,},
        [605] = {"story_nzj_11",6500,},
        [606] = {"story_nzj_12",5000,},
        [607] = {"story_nzj_13",6000,},
        [608] = {"story_nzj_14",5000,},
        [609] = {"story_nzj_2",3900,},
        [610] = {"story_nzj_3",6500,},
        [611] = {"story_nzj_4",3000,},
        [612] = {"story_nzj_5",7000,},
        [613] = {"story_nzj_6",10400,},
        [614] = {"story_nzj_7",9000,},
        [615] = {"story_nzj_8",7800,},
        [616] = {"story_nzj_9",10400,},
        [617] = {"story_sc_1",8000,},
        [618] = {"story_yj_1",5200,},
        [619] = {"story_yj_2",9100,},
        [620] = {"story_yj_3",5200,},
        [621] = {"story_yj_4",14300,},
        [622] = {"story_yj_5",6500,},
        [623] = {"story_ys_1",6500,},
        [624] = {"story_zc_1",7000,},
        [625] = {"story_zf_1",7800,},
        [626] = {"story_zf_2",14300,},
        [627] = {"story_zgl_1",7800,},
        [628] = {"story_zhangj_1",7000,},
        [629] = {"story_zhangj_2",7800,},
        [630] = {"story_zhangj_3",7800,},
        [631] = {"story_zhangj_4",13000,},
        [632] = {"story_zhangj_5",7000,},
        [633] = {"story_zhangj_6",7000,},
        [634] = {"story_zhangj_7",19500,},
        [635] = {"story_zhangj_8",13000,},
        [636] = {"story_zj_1",5000,},
        [637] = {"story_zj_10",5200,},
        [638] = {"story_zj_11",5200,},
        [639] = {"story_zj_12",5000,},
        [640] = {"story_zj_13",5000,},
        [641] = {"story_zj_14",5000,},
        [642] = {"story_zj_2",3900,},
        [643] = {"story_zj_3",6500,},
        [644] = {"story_zj_4",3000,},
        [645] = {"story_zj_5",6000,},
        [646] = {"story_zj_6",9100,},
        [647] = {"story_zj_7",8000,},
        [648] = {"story_zj_8",6500,},
        [649] = {"story_zj_9",9100,},
        [650] = {"story_zl_1",7800,},
        [651] = {"story_zr_1",7000,},
        [652] = {"story_zr_2",7000,},
        [653] = {"story_zr_3",14400,},
        [654] = {"story_zr_4",19200,},
        [655] = {"story_zr_5",11200,},
        [656] = {"story_zr_6",14400,},
        [657] = {"story_zr_7",13000,},
        [658] = {"story_zr_8",8000,},
        [659] = {"story_zxc_1",11700,},
        [660] = {"story_zxc_10",7000,},
        [661] = {"story_zxc_11",8000,},
        [662] = {"story_zxc_12",5000,},
        [663] = {"story_zxc_13",9000,},
        [664] = {"story_zxc_14",7000,},
        [665] = {"story_zxc_15",10400,},
        [666] = {"story_zxc_16",8000,},
        [667] = {"story_zxc_17",7000,},
        [668] = {"story_zxc_18",4000,},
        [669] = {"story_zxc_19",4000,},
        [670] = {"story_zxc_2",6000,},
        [671] = {"story_zxc_20",6000,},
        [672] = {"story_zxc_21",7000,},
        [673] = {"story_zxc_22",6000,},
        [674] = {"story_zxc_23",7800,},
        [675] = {"story_zxc_24",7800,},
        [676] = {"story_zxc_25",7800,},
        [677] = {"story_zxc_26",9100,},
        [678] = {"story_zxc_27",10400,},
        [679] = {"story_zxc_28",5200,},
        [680] = {"story_zxc_29",7000,},
        [681] = {"story_zxc_3",3000,},
        [682] = {"story_zxc_30",12000,},
        [683] = {"story_zxc_31",8000,},
        [684] = {"story_zxc_32",7000,},
        [685] = {"story_zxc_33",9100,},
        [686] = {"story_zxc_34",7000,},
        [687] = {"story_zxc_35",7000,},
        [688] = {"story_zxc_36",8000,},
        [689] = {"story_zxc_37",8000,},
        [690] = {"story_zxc_38",11200,},
        [691] = {"story_zxc_39",12800,},
        [692] = {"story_zxc_4",7000,},
        [693] = {"story_zxc_40",7000,},
        [694] = {"story_zxc_41",8000,},
        [695] = {"story_zxc_42",5000,},
        [696] = {"story_zxc_43",15000,},
        [697] = {"story_zxc_44",6000,},
        [698] = {"story_zxc_45",4000,},
        [699] = {"story_zxc_46",11000,},
        [700] = {"story_zxc_47",11200,},
        [701] = {"story_zxc_48",8000,},
        [702] = {"story_zxc_49",11000,},
        [703] = {"story_zxc_5",8000,},
        [704] = {"story_zxc_6",6000,},
        [705] = {"story_zxc_7",7000,},
        [706] = {"story_zxc_8",9000,},
        [707] = {"story_zxc_9",8000,},
        [708] = {"story_zy_1",4000,},
    }
}

return story_chat_length