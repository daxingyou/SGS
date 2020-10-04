--hero_friend

local hero_friend = {
    -- key
    __key_map = {
      friend_id = 1,    --缘分id-int 
      friend_name = 2,    --缘分名称-string 
    
    },
    -- data
    _data = {
        [1] = {90101,"HP Volume I",},
        [2] = {90102,"DEF Volume I",},
        [3] = {90103,"ATK Volume II",},
        [4] = {90201,"HP Volume I",},
        [5] = {90202,"DEF Volume I",},
        [6] = {90203,"ATK Volume II",},
        [7] = {90204,"DEF Volume II",},
        [8] = {90301,"HP Volume I",},
        [9] = {90302,"DEF Volume I",},
        [10] = {90303,"ATK Volume II",},
        [11] = {90304,"DEF Volume II",},
        [12] = {90305,"HP Volume III",},
        [13] = {90401,"HP Volume I",},
        [14] = {90402,"DEF Volume I",},
        [15] = {90403,"ATK Volume II",},
        [16] = {90404,"DEF Volume II",},
        [17] = {90405,"HP Volume III",},
        [18] = {90406,"ATK Volume III",},
        [19] = {90501,"HP Volume I",},
        [20] = {90502,"DEF Volume I",},
        [21] = {90503,"ATK Volume II",},
        [22] = {90504,"DEF Volume II",},
        [23] = {90505,"HP Volume III",},
        [24] = {90506,"ATK Volume III",},
        [25] = {91101,"HP Volume I",},
        [26] = {91102,"DEF Volume I",},
        [27] = {91103,"ATK Volume II",},
        [28] = {91201,"HP Volume I",},
        [29] = {91202,"DEF Volume I",},
        [30] = {91203,"ATK Volume II",},
        [31] = {91204,"DEF Volume II",},
        [32] = {91301,"HP Volume I",},
        [33] = {91302,"DEF Volume I",},
        [34] = {91303,"ATK Volume II",},
        [35] = {91304,"DEF Volume II",},
        [36] = {91305,"HP Volume III",},
        [37] = {91401,"HP Volume I",},
        [38] = {91402,"DEF Volume I",},
        [39] = {91403,"ATK Volume II",},
        [40] = {91404,"DEF Volume II",},
        [41] = {91405,"HP Volume III",},
        [42] = {91406,"ATK Volume III",},
        [43] = {91501,"HP Volume I",},
        [44] = {91502,"DEF Volume I",},
        [45] = {91503,"ATK Volume II",},
        [46] = {91504,"DEF Volume II",},
        [47] = {91505,"HP Volume III",},
        [48] = {91506,"ATK Volume III",},
        [49] = {10101,"ATK Volume I",},
        [50] = {10102,"DEF Volume I",},
        [51] = {10103,"ATK Volume II",},
        [52] = {10104,"DEF Volume II",},
        [53] = {10105,"HP Volume III",},
        [54] = {10106,"ATK Volume III",},
        [55] = {10201,"HP Volume I",},
        [56] = {10202,"DEF Volume I",},
        [57] = {10203,"ATK Volume II",},
        [58] = {10204,"DEF Volume II",},
        [59] = {10205,"HP Volume III",},
        [60] = {10206,"ATK Volume III",},
        [61] = {10301,"HP Volume I",},
        [62] = {10302,"DEF Volume I",},
        [63] = {10303,"ATK Volume II",},
        [64] = {10304,"DEF Volume II",},
        [65] = {10305,"HP Volume III",},
        [66] = {10306,"ATK Volume III",},
        [67] = {10401,"HP Volume I",},
        [68] = {10402,"DEF Volume I",},
        [69] = {10403,"ATK Volume II",},
        [70] = {10404,"DEF Volume II",},
        [71] = {10405,"HP Volume III",},
        [72] = {10406,"ATK Volume III",},
        [73] = {10501,"HP Volume I",},
        [74] = {10502,"DEF Volume I",},
        [75] = {10503,"HP Volume II",},
        [76] = {10504,"DEF Volume II",},
        [77] = {10505,"HP Volume III",},
        [78] = {10506,"ATK Volume III",},
        [79] = {10601,"HP Volume I",},
        [80] = {10602,"DEF Volume I",},
        [81] = {10603,"ATK Volume II",},
        [82] = {10604,"DEF Volume II",},
        [83] = {10605,"HP Volume III",},
        [84] = {10606,"ATK Volume III",},
        [85] = {10701,"ATK Volume I",},
        [86] = {10702,"DEF Volume I",},
        [87] = {10703,"ATK Volume II",},
        [88] = {10704,"DEF Volume II",},
        [89] = {10705,"HP Volume III",},
        [90] = {10706,"ATK Volume III",},
        [91] = {10801,"ATK Volume I",},
        [92] = {10802,"DEF Volume I",},
        [93] = {10803,"ATK Volume II",},
        [94] = {10804,"DEF Volume II",},
        [95] = {10805,"HP Volume III",},
        [96] = {10806,"ATK Volume III",},
        [97] = {10901,"ATK Volume I",},
        [98] = {10902,"DEF Volume I",},
        [99] = {10903,"ATK Volume II",},
        [100] = {10904,"DEF Volume II",},
        [101] = {10905,"HP Volume III",},
        [102] = {10906,"ATK Volume III",},
        [103] = {11001,"HP Volume I",},
        [104] = {11002,"DEF Volume I",},
        [105] = {11003,"ATK Volume II",},
        [106] = {11004,"DEF Volume II",},
        [107] = {11005,"HP Volume III",},
        [108] = {11006,"ATK Volume III",},
        [109] = {11101,"ATK Volume I",},
        [110] = {11102,"DEF Volume I",},
        [111] = {11103,"ATK Volume II",},
        [112] = {11104,"DEF Volume II",},
        [113] = {11105,"HP Volume III",},
        [114] = {11106,"ATK Volume III",},
        [115] = {11201,"HP Volume I",},
        [116] = {11202,"DEF Volume I",},
        [117] = {11203,"ATK Volume II",},
        [118] = {11204,"DEF Volume II",},
        [119] = {11205,"HP Volume III",},
        [120] = {11206,"ATK Volume III",},
        [121] = {15001,"ATK Volume I",},
        [122] = {15002,"DEF Volume I",},
        [123] = {15003,"ATK Volume II",},
        [124] = {15004,"DEF Volume II",},
        [125] = {15005,"HP Volume III",},
        [126] = {15006,"ATK Volume III",},
        [127] = {20101,"ATK Volume I",},
        [128] = {20102,"DEF Volume I",},
        [129] = {20103,"ATK Volume II",},
        [130] = {20104,"DEF Volume II",},
        [131] = {20105,"HP Volume III",},
        [132] = {20106,"ATK Volume III",},
        [133] = {20201,"HP Volume I",},
        [134] = {20202,"DEF Volume I",},
        [135] = {20203,"ATK Volume II",},
        [136] = {20204,"DEF Volume II",},
        [137] = {20205,"HP Volume III",},
        [138] = {20206,"ATK Volume III",},
        [139] = {20301,"ATK Volume I",},
        [140] = {20302,"DEF Volume I",},
        [141] = {20303,"ATK Volume II",},
        [142] = {20304,"DEF Volume II",},
        [143] = {20305,"HP Volume III",},
        [144] = {20306,"ATK Volume III",},
        [145] = {20401,"HP Volume I",},
        [146] = {20402,"DEF Volume I",},
        [147] = {20403,"ATK Volume II",},
        [148] = {20404,"DEF Volume II",},
        [149] = {20405,"HP Volume III",},
        [150] = {20406,"ATK Volume III",},
        [151] = {20501,"ATK Volume I",},
        [152] = {20502,"DEF Volume I",},
        [153] = {20503,"ATK Volume II",},
        [154] = {20504,"DEF Volume II",},
        [155] = {20505,"HP Volume III",},
        [156] = {20506,"ATK Volume III",},
        [157] = {20601,"ATK Volume I",},
        [158] = {20602,"DEF Volume I",},
        [159] = {20603,"ATK Volume II",},
        [160] = {20604,"DEF Volume II",},
        [161] = {20605,"HP Volume III",},
        [162] = {20606,"ATK Volume III",},
        [163] = {20701,"HP Volume I",},
        [164] = {20702,"DEF Volume I",},
        [165] = {20703,"HP Volume II",},
        [166] = {20704,"DEF Volume II",},
        [167] = {20705,"HP Volume III",},
        [168] = {20706,"ATK Volume III",},
        [169] = {20801,"ATK Volume I",},
        [170] = {20802,"DEF Volume I",},
        [171] = {20803,"ATK Volume II",},
        [172] = {20804,"DEF Volume II",},
        [173] = {20805,"HP Volume III",},
        [174] = {20806,"ATK Volume III",},
        [175] = {20901,"ATK Volume I",},
        [176] = {20902,"DEF Volume I",},
        [177] = {20903,"ATK Volume II",},
        [178] = {20904,"DEF Volume II",},
        [179] = {20905,"HP Volume III",},
        [180] = {20906,"ATK Volume III",},
        [181] = {21001,"HP Volume I",},
        [182] = {21002,"DEF Volume I",},
        [183] = {21003,"ATK Volume II",},
        [184] = {21004,"DEF Volume II",},
        [185] = {21005,"HP Volume III",},
        [186] = {21006,"ATK Volume III",},
        [187] = {21101,"HP Volume I",},
        [188] = {21102,"DEF Volume I",},
        [189] = {21103,"ATK Volume II",},
        [190] = {21104,"DEF Volume II",},
        [191] = {21105,"HP Volume III",},
        [192] = {21106,"ATK Volume III",},
        [193] = {21201,"HP Volume I",},
        [194] = {21202,"DEF Volume I",},
        [195] = {21203,"ATK Volume II",},
        [196] = {21204,"DEF Volume II",},
        [197] = {21205,"HP Volume III",},
        [198] = {21206,"ATK Volume III",},
        [199] = {25001,"ATK Volume I",},
        [200] = {25002,"DEF Volume I",},
        [201] = {25003,"ATK Volume II",},
        [202] = {25004,"DEF Volume II",},
        [203] = {25005,"HP Volume III",},
        [204] = {25006,"ATK Volume III",},
        [205] = {30101,"ATK Volume I",},
        [206] = {30102,"DEF Volume I",},
        [207] = {30103,"ATK Volume II",},
        [208] = {30104,"DEF Volume II",},
        [209] = {30105,"HP Volume III",},
        [210] = {30106,"ATK Volume III",},
        [211] = {30201,"HP Volume I",},
        [212] = {30202,"DEF Volume I",},
        [213] = {30203,"ATK Volume II",},
        [214] = {30204,"DEF Volume II",},
        [215] = {30205,"HP Volume III",},
        [216] = {30206,"ATK Volume III",},
        [217] = {30301,"HP Volume I",},
        [218] = {30302,"DEF Volume I",},
        [219] = {30303,"ATK Volume II",},
        [220] = {30304,"DEF Volume II",},
        [221] = {30305,"HP Volume III",},
        [222] = {30306,"ATK Volume III",},
        [223] = {30401,"HP Volume I",},
        [224] = {30402,"DEF Volume I",},
        [225] = {30403,"ATK Volume II",},
        [226] = {30404,"DEF Volume II",},
        [227] = {30405,"HP Volume III",},
        [228] = {30406,"ATK Volume III",},
        [229] = {30501,"HP Volume I",},
        [230] = {30502,"DEF Volume I",},
        [231] = {30503,"ATK Volume II",},
        [232] = {30504,"DEF Volume II",},
        [233] = {30505,"HP Volume III",},
        [234] = {30506,"ATK Volume III",},
        [235] = {30601,"ATK Volume I",},
        [236] = {30602,"DEF Volume I",},
        [237] = {30603,"ATK Volume II",},
        [238] = {30604,"DEF Volume II",},
        [239] = {30605,"HP Volume III",},
        [240] = {30606,"ATK Volume III",},
        [241] = {30701,"HP Volume I",},
        [242] = {30702,"DEF Volume I",},
        [243] = {30703,"ATK Volume II",},
        [244] = {30704,"DEF Volume II",},
        [245] = {30705,"HP Volume III",},
        [246] = {30706,"ATK Volume III",},
        [247] = {30801,"ATK Volume I",},
        [248] = {30802,"DEF Volume I",},
        [249] = {30803,"ATK Volume II",},
        [250] = {30804,"DEF Volume II",},
        [251] = {30805,"HP Volume III",},
        [252] = {30806,"ATK Volume III",},
        [253] = {30901,"HP Volume I",},
        [254] = {30902,"DEF Volume I",},
        [255] = {30903,"HP Volume II",},
        [256] = {30904,"DEF Volume II",},
        [257] = {30905,"HP Volume III",},
        [258] = {30906,"ATK Volume III",},
        [259] = {31001,"ATK Volume I",},
        [260] = {31002,"DEF Volume I",},
        [261] = {31003,"ATK Volume II",},
        [262] = {31004,"DEF Volume II",},
        [263] = {31005,"HP Volume III",},
        [264] = {31006,"ATK Volume III",},
        [265] = {31101,"HP Volume I",},
        [266] = {31102,"DEF Volume I",},
        [267] = {31103,"ATK Volume II",},
        [268] = {31104,"DEF Volume II",},
        [269] = {31105,"HP Volume III",},
        [270] = {31106,"ATK Volume III",},
        [271] = {31201,"HP Volume I",},
        [272] = {31202,"DEF Volume I",},
        [273] = {31203,"ATK Volume II",},
        [274] = {31204,"DEF Volume II",},
        [275] = {31205,"HP Volume III",},
        [276] = {31206,"ATK Volume III",},
        [277] = {35001,"ATK Volume I",},
        [278] = {35002,"DEF Volume I",},
        [279] = {35003,"ATK Volume II",},
        [280] = {35004,"DEF Volume II",},
        [281] = {35005,"HP Volume III",},
        [282] = {35006,"ATK Volume III",},
        [283] = {40101,"HP Volume I",},
        [284] = {40102,"DEF Volume I",},
        [285] = {40103,"ATK Volume II",},
        [286] = {40104,"DEF Volume II",},
        [287] = {40105,"HP Volume III",},
        [288] = {40106,"ATK Volume III",},
        [289] = {40201,"HP Volume I",},
        [290] = {40202,"DEF Volume I",},
        [291] = {40203,"ATK Volume II",},
        [292] = {40204,"DEF Volume II",},
        [293] = {40205,"HP Volume III",},
        [294] = {40206,"ATK Volume III",},
        [295] = {40301,"ATK Volume I",},
        [296] = {40302,"DEF Volume I",},
        [297] = {40303,"ATK Volume II",},
        [298] = {40304,"DEF Volume II",},
        [299] = {40305,"HP Volume III",},
        [300] = {40306,"ATK Volume III",},
        [301] = {40401,"HP Volume I",},
        [302] = {40402,"DEF Volume I",},
        [303] = {40403,"ATK Volume II",},
        [304] = {40404,"DEF Volume II",},
        [305] = {40405,"HP Volume III",},
        [306] = {40406,"ATK Volume III",},
        [307] = {40501,"HP Volume I",},
        [308] = {40502,"DEF Volume I",},
        [309] = {40503,"HP Volume II",},
        [310] = {40504,"DEF Volume II",},
        [311] = {40505,"HP Volume III",},
        [312] = {40506,"ATK Volume III",},
        [313] = {40601,"ATK Volume I",},
        [314] = {40602,"DEF Volume I",},
        [315] = {40603,"ATK Volume II",},
        [316] = {40604,"DEF Volume II",},
        [317] = {40605,"HP Volume III",},
        [318] = {40606,"ATK Volume III",},
        [319] = {40701,"HP Volume I",},
        [320] = {40702,"DEF Volume I",},
        [321] = {40703,"ATK Volume II",},
        [322] = {40704,"DEF Volume II",},
        [323] = {40705,"HP Volume III",},
        [324] = {40706,"ATK Volume III",},
        [325] = {40801,"HP Volume I",},
        [326] = {40802,"DEF Volume I",},
        [327] = {40803,"ATK Volume II",},
        [328] = {40804,"DEF Volume II",},
        [329] = {40805,"HP Volume III",},
        [330] = {40806,"ATK Volume III",},
        [331] = {40901,"HP Volume I",},
        [332] = {40902,"DEF Volume I",},
        [333] = {40903,"ATK Volume II",},
        [334] = {40904,"DEF Volume II",},
        [335] = {40905,"HP Volume III",},
        [336] = {40906,"ATK Volume III",},
        [337] = {41001,"HP Volume I",},
        [338] = {41002,"DEF Volume I",},
        [339] = {41003,"ATK Volume II",},
        [340] = {41004,"DEF Volume II",},
        [341] = {41005,"HP Volume III",},
        [342] = {41006,"ATK Volume III",},
        [343] = {41101,"HP Volume I",},
        [344] = {41102,"DEF Volume I",},
        [345] = {41103,"ATK Volume II",},
        [346] = {41104,"DEF Volume II",},
        [347] = {41105,"HP Volume III",},
        [348] = {41106,"ATK Volume III",},
        [349] = {41201,"HP Volume I",},
        [350] = {41202,"DEF Volume I",},
        [351] = {41203,"ATK Volume II",},
        [352] = {41204,"DEF Volume II",},
        [353] = {41205,"HP Volume III",},
        [354] = {41206,"ATK Volume III",},
        [355] = {45001,"ATK Volume I",},
        [356] = {45002,"DEF Volume I",},
        [357] = {45003,"ATK Volume II",},
        [358] = {45004,"DEF Volume II",},
        [359] = {45005,"HP Volume III",},
        [360] = {45006,"ATK Volume III",},
        [361] = {12001,"ATK Volume I",},
        [362] = {12002,"HP Volume II",},
        [363] = {12003,"ATK Volume II",},
        [364] = {12004,"DEF Volume III",},
        [365] = {12101,"ATK Volume I",},
        [366] = {12102,"HP Volume II",},
        [367] = {12103,"ATK Volume II",},
        [368] = {12104,"DEF Volume III",},
        [369] = {12201,"HP Volume I",},
        [370] = {12202,"ATK Volume II",},
        [371] = {12203,"ATK Volume II",},
        [372] = {12204,"DEF Volume III",},
        [373] = {12301,"HP Volume I",},
        [374] = {12302,"ATK Volume II",},
        [375] = {12303,"ATK Volume II",},
        [376] = {12304,"DEF Volume III",},
        [377] = {12401,"ATK Volume I",},
        [378] = {12402,"HP Volume II",},
        [379] = {12403,"ATK Volume II",},
        [380] = {12404,"DEF Volume III",},
        [381] = {12501,"HP Volume I",},
        [382] = {12502,"ATK Volume II",},
        [383] = {12503,"ATK Volume II",},
        [384] = {12504,"DEF Volume III",},
        [385] = {12601,"ATK Volume I",},
        [386] = {12602,"ATK Volume II",},
        [387] = {12603,"HP Volume II",},
        [388] = {12604,"DEF Volume III",},
        [389] = {12701,"HP Volume I",},
        [390] = {12702,"ATK Volume II",},
        [391] = {12703,"ATK Volume II",},
        [392] = {12704,"DEF Volume III",},
        [393] = {12801,"HP Volume I",},
        [394] = {12802,"ATK Volume II",},
        [395] = {12803,"ATK Volume II",},
        [396] = {12804,"DEF Volume III",},
        [397] = {12901,"HP Volume I",},
        [398] = {12902,"ATK Volume II",},
        [399] = {12903,"ATK Volume II",},
        [400] = {12904,"DEF Volume III",},
        [401] = {13001,"ATK Volume I",},
        [402] = {13002,"HP Volume II",},
        [403] = {13003,"ATK Volume II",},
        [404] = {13004,"DEF Volume III",},
        [405] = {13101,"ATK Volume I",},
        [406] = {13102,"HP Volume II",},
        [407] = {13103,"ATK Volume II",},
        [408] = {13104,"DEF Volume III",},
        [409] = {22001,"HP Volume I",},
        [410] = {22002,"ATK Volume II",},
        [411] = {22003,"ATK Volume II",},
        [412] = {22004,"DEF Volume III",},
        [413] = {22101,"ATK Volume I",},
        [414] = {22102,"HP Volume II",},
        [415] = {22103,"ATK Volume II",},
        [416] = {22104,"DEF Volume III",},
        [417] = {22201,"ATK Volume I",},
        [418] = {22202,"ATK Volume II",},
        [419] = {22203,"HP Volume II",},
        [420] = {22204,"DEF Volume III",},
        [421] = {22301,"ATK Volume I",},
        [422] = {22302,"HP Volume II",},
        [423] = {22303,"ATK Volume II",},
        [424] = {22304,"DEF Volume III",},
        [425] = {22401,"HP Volume I",},
        [426] = {22402,"ATK Volume II",},
        [427] = {22403,"ATK Volume II",},
        [428] = {22404,"DEF Volume III",},
        [429] = {22501,"HP Volume I",},
        [430] = {22502,"ATK Volume II",},
        [431] = {22503,"ATK Volume II",},
        [432] = {22504,"DEF Volume III",},
        [433] = {22601,"HP Volume I",},
        [434] = {22602,"ATK Volume II",},
        [435] = {22603,"ATK Volume II",},
        [436] = {22604,"DEF Volume III",},
        [437] = {22701,"ATK Volume I",},
        [438] = {22702,"HP Volume II",},
        [439] = {22703,"ATK Volume II",},
        [440] = {22704,"DEF Volume III",},
        [441] = {22801,"ATK Volume I",},
        [442] = {22802,"HP Volume II",},
        [443] = {22803,"ATK Volume II",},
        [444] = {22804,"DEF Volume III",},
        [445] = {22901,"HP Volume I",},
        [446] = {22902,"ATK Volume II",},
        [447] = {22903,"ATK Volume II",},
        [448] = {22904,"DEF Volume III",},
        [449] = {23001,"HP Volume I",},
        [450] = {23002,"ATK Volume II",},
        [451] = {23003,"ATK Volume II",},
        [452] = {23004,"DEF Volume III",},
        [453] = {23101,"HP Volume I",},
        [454] = {23102,"ATK Volume II",},
        [455] = {23103,"ATK Volume II",},
        [456] = {23104,"DEF Volume III",},
        [457] = {32001,"ATK Volume I",},
        [458] = {32002,"HP Volume II",},
        [459] = {32003,"ATK Volume II",},
        [460] = {32004,"DEF Volume III",},
        [461] = {32101,"ATK Volume I",},
        [462] = {32102,"HP Volume II",},
        [463] = {32103,"ATK Volume II",},
        [464] = {32104,"DEF Volume III",},
        [465] = {32201,"ATK Volume I",},
        [466] = {32202,"HP Volume II",},
        [467] = {32203,"ATK Volume II",},
        [468] = {32204,"DEF Volume III",},
        [469] = {32301,"HP Volume I",},
        [470] = {32302,"ATK Volume II",},
        [471] = {32303,"ATK Volume II",},
        [472] = {32304,"DEF Volume III",},
        [473] = {32401,"HP Volume I",},
        [474] = {32402,"ATK Volume II",},
        [475] = {32403,"ATK Volume II",},
        [476] = {32404,"DEF Volume III",},
        [477] = {32501,"HP Volume I",},
        [478] = {32502,"ATK Volume II",},
        [479] = {32503,"ATK Volume II",},
        [480] = {32504,"DEF Volume III",},
        [481] = {32601,"ATK Volume I",},
        [482] = {32602,"HP Volume II",},
        [483] = {32603,"ATK Volume II",},
        [484] = {32604,"DEF Volume III",},
        [485] = {32701,"HP Volume I",},
        [486] = {32702,"ATK Volume II",},
        [487] = {32703,"ATK Volume II",},
        [488] = {32704,"DEF Volume III",},
        [489] = {32801,"ATK Volume I",},
        [490] = {32802,"ATK Volume II",},
        [491] = {32803,"HP Volume II",},
        [492] = {32804,"DEF Volume III",},
        [493] = {32901,"ATK Volume I",},
        [494] = {32902,"HP Volume II",},
        [495] = {32903,"ATK Volume II",},
        [496] = {32904,"DEF Volume III",},
        [497] = {33001,"HP Volume I",},
        [498] = {33002,"ATK Volume II",},
        [499] = {33003,"ATK Volume II",},
        [500] = {33004,"DEF Volume III",},
        [501] = {33101,"HP Volume I",},
        [502] = {33102,"ATK Volume II",},
        [503] = {33103,"ATK Volume II",},
        [504] = {33104,"DEF Volume III",},
        [505] = {42001,"HP Volume I",},
        [506] = {42002,"ATK Volume II",},
        [507] = {42003,"ATK Volume II",},
        [508] = {42004,"DEF Volume III",},
        [509] = {42101,"HP Volume I",},
        [510] = {42102,"ATK Volume II",},
        [511] = {42103,"ATK Volume II",},
        [512] = {42104,"DEF Volume III",},
        [513] = {42201,"ATK Volume I",},
        [514] = {42202,"HP Volume II",},
        [515] = {42203,"ATK Volume II",},
        [516] = {42204,"DEF Volume III",},
        [517] = {42301,"HP Volume I",},
        [518] = {42302,"ATK Volume II",},
        [519] = {42303,"ATK Volume II",},
        [520] = {42304,"DEF Volume III",},
        [521] = {42401,"ATK Volume I",},
        [522] = {42402,"HP Volume II",},
        [523] = {42403,"ATK Volume II",},
        [524] = {42404,"DEF Volume III",},
        [525] = {42501,"HP Volume I",},
        [526] = {42502,"ATK Volume II",},
        [527] = {42503,"ATK Volume II",},
        [528] = {42504,"DEF Volume III",},
        [529] = {42601,"HP Volume I",},
        [530] = {42602,"ATK Volume II",},
        [531] = {42603,"ATK Volume II",},
        [532] = {42604,"DEF Volume III",},
        [533] = {42701,"ATK Volume I",},
        [534] = {42702,"HP Volume II",},
        [535] = {42703,"ATK Volume II",},
        [536] = {42704,"DEF Volume III",},
        [537] = {42801,"HP Volume I",},
        [538] = {42802,"ATK Volume II",},
        [539] = {42803,"ATK Volume II",},
        [540] = {42804,"DEF Volume III",},
        [541] = {42901,"ATK Volume I",},
        [542] = {42902,"HP Volume II",},
        [543] = {42903,"ATK Volume II",},
        [544] = {42904,"DEF Volume III",},
        [545] = {43001,"ATK Volume I",},
        [546] = {43002,"HP Volume II",},
        [547] = {43003,"ATK Volume II",},
        [548] = {43004,"DEF Volume III",},
        [549] = {43101,"HP Volume I",},
        [550] = {43102,"ATK Volume II",},
        [551] = {43103,"ATK Volume II",},
        [552] = {43104,"DEF Volume III",},
        [553] = {13201,"DEF Volume I",},
        [554] = {13202,"HP Volume II",},
        [555] = {13203,"ATK Volume III",},
        [556] = {13301,"HP Volume I",},
        [557] = {13302,"DEF Volume II",},
        [558] = {13303,"ATK Volume III",},
        [559] = {13401,"HP Volume I",},
        [560] = {13402,"DEF Volume II",},
        [561] = {13403,"ATK Volume III",},
        [562] = {13501,"DEF Volume I",},
        [563] = {13502,"HP Volume II",},
        [564] = {13503,"ATK Volume III",},
        [565] = {13601,"HP Volume I",},
        [566] = {13602,"DEF Volume II",},
        [567] = {13603,"ATK Volume III",},
        [568] = {13701,"DEF Volume I",},
        [569] = {13702,"HP Volume II",},
        [570] = {13703,"ATK Volume III",},
        [571] = {13801,"DEF Volume I",},
        [572] = {13802,"HP Volume II",},
        [573] = {13803,"ATK Volume III",},
        [574] = {13901,"DEF Volume I",},
        [575] = {13902,"HP Volume II",},
        [576] = {13903,"ATK Volume III",},
        [577] = {14001,"DEF Volume I",},
        [578] = {14002,"HP Volume II",},
        [579] = {14003,"ATK Volume III",},
        [580] = {14101,"HP Volume I",},
        [581] = {14102,"DEF Volume II",},
        [582] = {14103,"ATK Volume III",},
        [583] = {14201,"DEF Volume I",},
        [584] = {14202,"ATK Volume II",},
        [585] = {14203,"HP Volume III",},
        [586] = {14301,"HP Volume I",},
        [587] = {14302,"DEF Volume II",},
        [588] = {14303,"ATK Volume III",},
        [589] = {14401,"DEF Volume I",},
        [590] = {14402,"HP Volume II",},
        [591] = {14403,"ATK Volume III",},
        [592] = {14501,"DEF Volume I",},
        [593] = {14502,"HP Volume II",},
        [594] = {14503,"ATK Volume III",},
        [595] = {14601,"DEF Volume I",},
        [596] = {14602,"HP Volume II",},
        [597] = {14603,"ATK Volume III",},
        [598] = {14701,"DEF Volume I",},
        [599] = {14702,"HP Volume II",},
        [600] = {14703,"ATK Volume III",},
        [601] = {14801,"DEF Volume I",},
        [602] = {14802,"HP Volume II",},
        [603] = {14803,"ATK Volume III",},
        [604] = {23201,"DEF Volume I",},
        [605] = {23202,"HP Volume II",},
        [606] = {23203,"ATK Volume III",},
        [607] = {23301,"HP Volume I",},
        [608] = {23302,"DEF Volume II",},
        [609] = {23303,"ATK Volume III",},
        [610] = {23401,"DEF Volume I",},
        [611] = {23402,"ATK Volume II",},
        [612] = {23403,"HP Volume III",},
        [613] = {23501,"HP Volume I",},
        [614] = {23502,"DEF Volume II",},
        [615] = {23503,"ATK Volume III",},
        [616] = {23601,"DEF Volume I",},
        [617] = {23602,"HP Volume II",},
        [618] = {23603,"ATK Volume III",},
        [619] = {23701,"HP Volume I",},
        [620] = {23702,"DEF Volume II",},
        [621] = {23703,"ATK Volume III",},
        [622] = {23801,"HP Volume I",},
        [623] = {23802,"DEF Volume II",},
        [624] = {23803,"ATK Volume III",},
        [625] = {23901,"DEF Volume I",},
        [626] = {23902,"HP Volume II",},
        [627] = {23903,"ATK Volume III",},
        [628] = {24001,"DEF Volume I",},
        [629] = {24002,"HP Volume II",},
        [630] = {24003,"ATK Volume III",},
        [631] = {24101,"DEF Volume I",},
        [632] = {24102,"HP Volume II",},
        [633] = {24103,"ATK Volume III",},
        [634] = {24201,"DEF Volume I",},
        [635] = {24202,"HP Volume II",},
        [636] = {24203,"ATK Volume III",},
        [637] = {24301,"DEF Volume I",},
        [638] = {24302,"HP Volume II",},
        [639] = {24303,"ATK Volume III",},
        [640] = {24401,"DEF Volume I",},
        [641] = {24402,"HP Volume II",},
        [642] = {24403,"ATK Volume III",},
        [643] = {24501,"DEF Volume I",},
        [644] = {24502,"HP Volume II",},
        [645] = {24503,"ATK Volume III",},
        [646] = {24601,"DEF Volume I",},
        [647] = {24602,"HP Volume II",},
        [648] = {24603,"ATK Volume III",},
        [649] = {24701,"DEF Volume I",},
        [650] = {24702,"HP Volume II",},
        [651] = {24703,"ATK Volume III",},
        [652] = {24801,"DEF Volume I",},
        [653] = {24802,"HP Volume II",},
        [654] = {24803,"ATK Volume III",},
        [655] = {33201,"DEF Volume I",},
        [656] = {33202,"HP Volume II",},
        [657] = {33203,"ATK Volume III",},
        [658] = {33301,"DEF Volume I",},
        [659] = {33302,"HP Volume II",},
        [660] = {33303,"ATK Volume III",},
        [661] = {33401,"HP Volume I",},
        [662] = {33402,"DEF Volume II",},
        [663] = {33403,"ATK Volume III",},
        [664] = {33501,"DEF Volume I",},
        [665] = {33502,"HP Volume II",},
        [666] = {33503,"ATK Volume III",},
        [667] = {33601,"HP Volume I",},
        [668] = {33602,"DEF Volume II",},
        [669] = {33603,"ATK Volume III",},
        [670] = {33701,"DEF Volume I",},
        [671] = {33702,"HP Volume II",},
        [672] = {33703,"ATK Volume III",},
        [673] = {33801,"HP Volume I",},
        [674] = {33802,"DEF Volume II",},
        [675] = {33803,"ATK Volume III",},
        [676] = {33901,"DEF Volume I",},
        [677] = {33902,"HP Volume II",},
        [678] = {33903,"ATK Volume III",},
        [679] = {34001,"DEF Volume I",},
        [680] = {34002,"HP Volume II",},
        [681] = {34003,"ATK Volume III",},
        [682] = {34101,"HP Volume I",},
        [683] = {34102,"DEF Volume II",},
        [684] = {34103,"ATK Volume III",},
        [685] = {34201,"HP Volume I",},
        [686] = {34202,"DEF Volume II",},
        [687] = {34203,"ATK Volume III",},
        [688] = {34301,"HP Volume I",},
        [689] = {34302,"DEF Volume II",},
        [690] = {34303,"ATK Volume III",},
        [691] = {34401,"DEF Volume I",},
        [692] = {34402,"HP Volume II",},
        [693] = {34403,"ATK Volume III",},
        [694] = {34501,"HP Volume I",},
        [695] = {34502,"DEF Volume II",},
        [696] = {34503,"ATK Volume III",},
        [697] = {34601,"DEF Volume I",},
        [698] = {34602,"HP Volume II",},
        [699] = {34603,"ATK Volume III",},
        [700] = {34701,"DEF Volume I",},
        [701] = {34702,"HP Volume II",},
        [702] = {34703,"ATK Volume III",},
        [703] = {34801,"DEF Volume I",},
        [704] = {34802,"HP Volume II",},
        [705] = {34803,"ATK Volume III",},
        [706] = {43201,"DEF Volume I",},
        [707] = {43202,"HP Volume II",},
        [708] = {43203,"ATK Volume III",},
        [709] = {43301,"DEF Volume I",},
        [710] = {43302,"HP Volume II",},
        [711] = {43303,"ATK Volume III",},
        [712] = {43401,"HP Volume I",},
        [713] = {43402,"DEF Volume II",},
        [714] = {43403,"ATK Volume III",},
        [715] = {43501,"DEF Volume I",},
        [716] = {43502,"HP Volume II",},
        [717] = {43503,"ATK Volume III",},
        [718] = {43601,"DEF Volume I",},
        [719] = {43602,"HP Volume II",},
        [720] = {43603,"ATK Volume III",},
        [721] = {43701,"DEF Volume I",},
        [722] = {43702,"HP Volume II",},
        [723] = {43703,"ATK Volume III",},
        [724] = {43801,"DEF Volume I",},
        [725] = {43802,"ATK Volume II",},
        [726] = {43803,"HP Volume III",},
        [727] = {43901,"HP Volume I",},
        [728] = {43902,"DEF Volume II",},
        [729] = {43903,"ATK Volume III",},
        [730] = {44001,"DEF Volume I",},
        [731] = {44002,"HP Volume II",},
        [732] = {44003,"ATK Volume III",},
        [733] = {44101,"HP Volume I",},
        [734] = {44102,"DEF Volume II",},
        [735] = {44103,"ATK Volume III",},
        [736] = {44201,"HP Volume I",},
        [737] = {44202,"DEF Volume II",},
        [738] = {44203,"ATK Volume III",},
        [739] = {44301,"DEF Volume I",},
        [740] = {44302,"ATK Volume II",},
        [741] = {44303,"HP Volume III",},
        [742] = {44401,"DEF Volume I",},
        [743] = {44402,"HP Volume II",},
        [744] = {44403,"ATK Volume III",},
        [745] = {44501,"DEF Volume I",},
        [746] = {44502,"HP Volume II",},
        [747] = {44503,"ATK Volume III",},
        [748] = {44601,"DEF Volume I",},
        [749] = {44602,"HP Volume II",},
        [750] = {44603,"ATK Volume III",},
        [751] = {44701,"DEF Volume I",},
        [752] = {44702,"HP Volume II",},
        [753] = {44703,"ATK Volume III",},
        [754] = {44801,"DEF Volume I",},
        [755] = {44802,"HP Volume II",},
        [756] = {44803,"ATK Volume III",},
        [757] = {11301,"ATK Volume I",},
        [758] = {11302,"ATK Volume II",},
        [759] = {11303,"ATK Volume II",},
        [760] = {11304,"HP Volume III",},
        [761] = {11305,"DEF Volume III",},
        [762] = {11401,"ATK Volume I",},
        [763] = {11402,"ATK Volume II",},
        [764] = {11403,"ATK Volume II",},
        [765] = {11404,"HP Volume III",},
        [766] = {11405,"DEF Volume III",},
        [767] = {11501,"ATK Volume I",},
        [768] = {11502,"HP Volume II",},
        [769] = {11503,"HP Volume II",},
        [770] = {11504,"DEF Volume III",},
        [771] = {11505,"ATK Volume III",},
        [772] = {11601,"ATK Volume I",},
        [773] = {11602,"HP Volume II",},
        [774] = {11603,"HP Volume II",},
        [775] = {11604,"DEF Volume III",},
        [776] = {11605,"ATK Volume III",},
        [777] = {11701,"ATK Volume I",},
        [778] = {11702,"HP Volume II",},
        [779] = {11703,"HP Volume II",},
        [780] = {11704,"DEF Volume III",},
        [781] = {11705,"ATK Volume III",},
        [782] = {11801,"ATK Volume I",},
        [783] = {11802,"HP Volume II",},
        [784] = {11803,"HP Volume II",},
        [785] = {11804,"DEF Volume III",},
        [786] = {11805,"ATK Volume III",},
        [787] = {11901,"ATK Volume I",},
        [788] = {11902,"ATK Volume II",},
        [789] = {11903,"HP Volume II",},
        [790] = {11904,"HP Volume III",},
        [791] = {11905,"DEF Volume III",},
        [792] = {21301,"ATK Volume I",},
        [793] = {21302,"ATK Volume II",},
        [794] = {21303,"ATK Volume II",},
        [795] = {21304,"HP Volume III",},
        [796] = {21305,"DEF Volume III",},
        [797] = {21401,"ATK Volume I",},
        [798] = {21402,"HP Volume II",},
        [799] = {21403,"HP Volume II",},
        [800] = {21404,"DEF Volume III",},
        [801] = {21405,"ATK Volume III",},
        [802] = {21501,"ATK Volume I",},
        [803] = {21502,"ATK Volume II",},
        [804] = {21503,"HP Volume II",},
        [805] = {21504,"HP Volume III",},
        [806] = {21505,"DEF Volume III",},
        [807] = {21601,"ATK Volume I",},
        [808] = {21602,"HP Volume II",},
        [809] = {21603,"HP Volume II",},
        [810] = {21604,"DEF Volume III",},
        [811] = {21605,"ATK Volume III",},
        [812] = {21701,"ATK Volume I",},
        [813] = {21702,"ATK Volume II",},
        [814] = {21703,"ATK Volume II",},
        [815] = {21704,"HP Volume III",},
        [816] = {21705,"DEF Volume III",},
        [817] = {21801,"ATK Volume I",},
        [818] = {21802,"ATK Volume II",},
        [819] = {21803,"ATK Volume II",},
        [820] = {21804,"HP Volume III",},
        [821] = {21805,"DEF Volume III",},
        [822] = {21901,"ATK Volume I",},
        [823] = {21902,"HP Volume II",},
        [824] = {21903,"HP Volume II",},
        [825] = {21904,"DEF Volume III",},
        [826] = {21905,"ATK Volume III",},
        [827] = {31301,"ATK Volume I",},
        [828] = {31302,"HP Volume II",},
        [829] = {31303,"HP Volume II",},
        [830] = {31304,"DEF Volume III",},
        [831] = {31305,"ATK Volume III",},
        [832] = {31401,"ATK Volume I",},
        [833] = {31402,"ATK Volume II",},
        [834] = {31403,"HP Volume II",},
        [835] = {31404,"HP Volume III",},
        [836] = {31405,"DEF Volume III",},
        [837] = {31501,"ATK Volume I",},
        [838] = {31502,"HP Volume II",},
        [839] = {31503,"HP Volume II",},
        [840] = {31504,"DEF Volume III",},
        [841] = {31505,"ATK Volume III",},
        [842] = {31601,"ATK Volume I",},
        [843] = {31602,"ATK Volume II",},
        [844] = {31603,"ATK Volume II",},
        [845] = {31604,"HP Volume III",},
        [846] = {31605,"DEF Volume III",},
        [847] = {31701,"ATK Volume I",},
        [848] = {31702,"HP Volume II",},
        [849] = {31703,"HP Volume II",},
        [850] = {31704,"DEF Volume III",},
        [851] = {31705,"ATK Volume III",},
        [852] = {31801,"ATK Volume I",},
        [853] = {31802,"ATK Volume II",},
        [854] = {31803,"ATK Volume II",},
        [855] = {31804,"HP Volume III",},
        [856] = {31805,"DEF Volume III",},
        [857] = {31901,"ATK Volume I",},
        [858] = {31902,"HP Volume II",},
        [859] = {31903,"HP Volume II",},
        [860] = {31904,"DEF Volume III",},
        [861] = {31905,"ATK Volume III",},
        [862] = {41301,"ATK Volume I",},
        [863] = {41302,"ATK Volume II",},
        [864] = {41303,"ATK Volume II",},
        [865] = {41304,"HP Volume III",},
        [866] = {41305,"DEF Volume III",},
        [867] = {41401,"ATK Volume I",},
        [868] = {41402,"ATK Volume II",},
        [869] = {41403,"ATK Volume II",},
        [870] = {41404,"HP Volume III",},
        [871] = {41405,"DEF Volume III",},
        [872] = {41501,"ATK Volume I",},
        [873] = {41502,"HP Volume II",},
        [874] = {41503,"HP Volume II",},
        [875] = {41504,"DEF Volume III",},
        [876] = {41505,"ATK Volume III",},
        [877] = {41601,"ATK Volume I",},
        [878] = {41602,"ATK Volume II",},
        [879] = {41603,"ATK Volume II",},
        [880] = {41604,"HP Volume III",},
        [881] = {41605,"DEF Volume III",},
        [882] = {41701,"ATK Volume I",},
        [883] = {41702,"HP Volume II",},
        [884] = {41703,"HP Volume II",},
        [885] = {41704,"DEF Volume III",},
        [886] = {41705,"ATK Volume III",},
        [887] = {41801,"ATK Volume I",},
        [888] = {41802,"ATK Volume II",},
        [889] = {41803,"HP Volume II",},
        [890] = {41804,"HP Volume III",},
        [891] = {41805,"DEF Volume III",},
        [892] = {41901,"ATK Volume I",},
        [893] = {41902,"HP Volume II",},
        [894] = {41903,"HP Volume II",},
        [895] = {41904,"DEF Volume III",},
        [896] = {41905,"ATK Volume III",},
    }
}

return hero_friend