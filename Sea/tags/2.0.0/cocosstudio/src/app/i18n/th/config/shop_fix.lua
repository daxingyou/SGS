--shop_fix

local shop_fix = {
    -- key
    __key_map = {
      id = 1,    --商品编号-int 
      button = 2,    --购买按钮-泰语-string 
      level_show = 3,    --显示等级_math-int 
    
    },
    -- data
    _data = {
        [1] = {100,"",1,},
        [2] = {101,"",1,},
        [3] = {102,"",1,},
        [4] = {103,"",1,},
        [5] = {104,"",1,},
        [6] = {105,"",1,},
        [7] = {106,"",40,},
        [8] = {107,"",50,},
        [9] = {108,"",46,},
        [10] = {109,"",1,},
        [11] = {110,"",1,},
        [12] = {111,"",10,},
        [13] = {112,"",10,},
        [14] = {113,"",10,},
        [15] = {121,"",75,},
        [16] = {122,"",75,},
        [17] = {123,"",75,},
        [18] = {124,"",75,},
        [19] = {125,"",75,},
        [20] = {126,"",75,},
        [21] = {127,"",999,},
        [22] = {128,"",75,},
        [23] = {129,"",999,},
        [24] = {130,"",999,},
        [25] = {131,"",999,},
        [26] = {197,"",999,},
        [27] = {132,"",80,},
        [28] = {133,"",85,},
        [29] = {134,"",85,},
        [30] = {201,"",1,},
        [31] = {202,"",1,},
        [32] = {203,"",1,},
        [33] = {204,"",1,},
        [34] = {205,"",1,},
        [35] = {206,"",1,},
        [36] = {207,"",1,},
        [37] = {208,"",1,},
        [38] = {211,"",1,},
        [39] = {212,"",1,},
        [40] = {213,"",1,},
        [41] = {214,"",1,},
        [42] = {215,"",1,},
        [43] = {216,"",1,},
        [44] = {217,"",1,},
        [45] = {218,"",1,},
        [46] = {219,"",1,},
        [47] = {220,"",1,},
        [48] = {221,"",1,},
        [49] = {222,"",1,},
        [50] = {223,"",1,},
        [51] = {224,"",1,},
        [52] = {225,"",1,},
        [53] = {226,"",1,},
        [54] = {227,"",1,},
        [55] = {228,"",1,},
        [56] = {229,"",1,},
        [57] = {230,"",1,},
        [58] = {231,"",1,},
        [59] = {232,"",1,},
        [60] = {233,"",1,},
        [61] = {234,"",1,},
        [62] = {235,"",1,},
        [63] = {236,"",1,},
        [64] = {237,"",1,},
        [65] = {238,"",1,},
        [66] = {239,"",1,},
        [67] = {240,"",1,},
        [68] = {241,"",1,},
        [69] = {242,"",1,},
        [70] = {243,"",1,},
        [71] = {244,"",1,},
        [72] = {245,"",1,},
        [73] = {246,"",1,},
        [74] = {247,"",1,},
        [75] = {248,"",1,},
        [76] = {249,"",1,},
        [77] = {250,"",1,},
        [78] = {251,"",1,},
        [79] = {252,"",1,},
        [80] = {253,"",1,},
        [81] = {254,"",1,},
        [82] = {255,"",1,},
        [83] = {256,"",1,},
        [84] = {257,"",1,},
        [85] = {258,"",1,},
        [86] = {259,"",1,},
        [87] = {260,"",1,},
        [88] = {261,"",1,},
        [89] = {262,"",1,},
        [90] = {263,"",0,},
        [91] = {701,"",1,},
        [92] = {702,"",1,},
        [93] = {703,"",1,},
        [94] = {704,"",1,},
        [95] = {705,"",999,},
        [96] = {706,"",999,},
        [97] = {707,"",999,},
        [98] = {708,"",999,},
        [99] = {709,"",1,},
        [100] = {710,"",1,},
        [101] = {711,"",1,},
        [102] = {712,"",1,},
        [103] = {713,"",1,},
        [104] = {714,"",1,},
        [105] = {715,"",1,},
        [106] = {716,"",1,},
        [107] = {751,"",1,},
        [108] = {752,"",1,},
        [109] = {753,"",1,},
        [110] = {754,"",1,},
        [111] = {755,"",1,},
        [112] = {756,"",1,},
        [113] = {757,"",1,},
        [114] = {758,"",1,},
        [115] = {759,"",1,},
        [116] = {760,"",1,},
        [117] = {761,"",1,},
        [118] = {762,"",1,},
        [119] = {763,"",1,},
        [120] = {764,"",1,},
        [121] = {765,"",0,},
        [122] = {780,"",100,},
        [123] = {781,"",100,},
        [124] = {782,"",100,},
        [125] = {783,"",100,},
        [126] = {784,"",100,},
        [127] = {785,"",100,},
        [128] = {786,"",100,},
        [129] = {787,"",100,},
        [130] = {790,"",120,},
        [131] = {791,"",120,},
        [132] = {792,"",120,},
        [133] = {793,"",120,},
        [134] = {794,"",120,},
        [135] = {795,"",120,},
        [136] = {796,"",120,},
        [137] = {797,"",120,},
        [138] = {801,"",1,},
        [139] = {802,"",1,},
        [140] = {803,"",1,},
        [141] = {804,"",1,},
        [142] = {805,"",1,},
        [143] = {806,"",40,},
        [144] = {807,"",50,},
        [145] = {808,"",46,},
        [146] = {809,"",60,},
        [147] = {810,"",60,},
        [148] = {811,"",60,},
        [149] = {812,"",60,},
        [150] = {813,"",60,},
        [151] = {814,"",60,},
        [152] = {815,"",60,},
        [153] = {816,"",60,},
        [154] = {857,"",60,},
        [155] = {858,"",60,},
        [156] = {859,"",60,},
        [157] = {860,"",60,},
        [158] = {861,"",60,},
        [159] = {862,"",60,},
        [160] = {863,"",60,},
        [161] = {864,"",60,},
        [162] = {865,"",60,},
        [163] = {866,"",60,},
        [164] = {867,"",60,},
        [165] = {868,"",60,},
        [166] = {869,"",60,},
        [167] = {870,"",60,},
        [168] = {871,"",60,},
        [169] = {872,"",60,},
        [170] = {873,"",60,},
        [171] = {874,"",60,},
        [172] = {875,"",60,},
        [173] = {876,"",60,},
        [174] = {877,"",85,},
        [175] = {878,"",100,},
        [176] = {879,"",100,},
        [177] = {880,"",100,},
        [178] = {881,"",100,},
        [179] = {882,"",100,},
        [180] = {883,"",100,},
        [181] = {884,"",100,},
        [182] = {885,"",120,},
        [183] = {886,"",120,},
        [184] = {887,"",120,},
        [185] = {888,"",120,},
        [186] = {889,"",120,},
        [187] = {890,"",120,},
        [188] = {891,"",120,},
        [189] = {817,"",70,},
        [190] = {818,"",70,},
        [191] = {819,"",70,},
        [192] = {820,"",70,},
        [193] = {821,"",70,},
        [194] = {822,"",70,},
        [195] = {823,"",70,},
        [196] = {824,"",70,},
        [197] = {825,"",1,},
        [198] = {826,"",1,},
        [199] = {827,"",1,},
        [200] = {828,"",1,},
        [201] = {829,"",1,},
        [202] = {830,"",1,},
        [203] = {831,"",1,},
        [204] = {832,"",1,},
        [205] = {833,"",1,},
        [206] = {834,"",1,},
        [207] = {835,"",1,},
        [208] = {836,"",1,},
        [209] = {837,"",1,},
        [210] = {838,"",1,},
        [211] = {839,"",1,},
        [212] = {840,"",1,},
        [213] = {841,"",1,},
        [214] = {842,"",1,},
        [215] = {843,"",1,},
        [216] = {844,"",1,},
        [217] = {845,"",1,},
        [218] = {846,"",1,},
        [219] = {847,"",1,},
        [220] = {848,"",1,},
        [221] = {849,"",1,},
        [222] = {850,"",1,},
        [223] = {851,"",1,},
        [224] = {852,"",1,},
        [225] = {853,"",1,},
        [226] = {854,"",1,},
        [227] = {855,"",1,},
        [228] = {856,"",1,},
        [229] = {901,"",1,},
        [230] = {902,"",1,},
        [231] = {903,"",1,},
        [232] = {904,"",1,},
        [233] = {905,"",1,},
        [234] = {906,"",1,},
        [235] = {907,"",1,},
        [236] = {908,"",1,},
        [237] = {909,"",1,},
        [238] = {910,"",1,},
        [239] = {911,"",1,},
        [240] = {912,"",1,},
        [241] = {913,"",1,},
        [242] = {914,"",1,},
        [243] = {915,"",1,},
        [244] = {916,"",1,},
        [245] = {917,"",1,},
        [246] = {918,"",1,},
        [247] = {919,"",1,},
        [248] = {920,"",1,},
        [249] = {921,"",1,},
        [250] = {922,"",1,},
        [251] = {923,"",1,},
        [252] = {924,"",1,},
        [253] = {925,"",1,},
        [254] = {926,"",1,},
        [255] = {927,"",1,},
        [256] = {928,"",1,},
        [257] = {929,"",1,},
        [258] = {930,"",1,},
        [259] = {1001,"",1,},
        [260] = {1002,"",1,},
        [261] = {1003,"",1,},
        [262] = {1004,"",1,},
        [263] = {1005,"",1,},
        [264] = {1006,"",1,},
        [265] = {1007,"",1,},
        [266] = {1008,"",1,},
        [267] = {1009,"",1,},
        [268] = {1010,"",1,},
        [269] = {1011,"",1,},
        [270] = {1012,"",1,},
        [271] = {1013,"",1,},
        [272] = {1014,"",1,},
        [273] = {1015,"",1,},
        [274] = {1016,"",1,},
        [275] = {1017,"",1,},
        [276] = {1018,"",1,},
        [277] = {1019,"",1,},
        [278] = {1020,"",1,},
        [279] = {1021,"",1,},
        [280] = {1022,"",1,},
        [281] = {1023,"",1,},
        [282] = {1024,"",1,},
        [283] = {1501,"",70,},
        [284] = {1502,"",70,},
        [285] = {1503,"",70,},
        [286] = {1504,"",70,},
        [287] = {1505,"",70,},
        [288] = {1506,"",70,},
        [289] = {1507,"",70,},
        [290] = {1508,"",70,},
        [291] = {1509,"",70,},
        [292] = {1510,"",70,},
        [293] = {1511,"",70,},
        [294] = {1512,"",999,},
        [295] = {1601,"",85,},
        [296] = {1602,"",85,},
        [297] = {1603,"",85,},
        [298] = {1604,"",85,},
        [299] = {1605,"",85,},
        [300] = {1606,"",85,},
        [301] = {1607,"",85,},
        [302] = {1608,"",85,},
        [303] = {1609,"",85,},
        [304] = {1610,"",85,},
        [305] = {1611,"",85,},
        [306] = {1612,"",85,},
        [307] = {1613,"",85,},
        [308] = {1614,"",85,},
        [309] = {1615,"",85,},
        [310] = {1616,"",85,},
        [311] = {1617,"",85,},
        [312] = {1618,"",85,},
        [313] = {1619,"",85,},
        [314] = {1620,"",85,},
        [315] = {1621,"",85,},
        [316] = {1622,"",85,},
        [317] = {1623,"",85,},
        [318] = {1624,"",85,},
        [319] = {1625,"",85,},
        [320] = {1626,"",85,},
        [321] = {1627,"",85,},
        [322] = {1628,"",85,},
        [323] = {1629,"",85,},
        [324] = {1630,"",85,},
        [325] = {1631,"",85,},
        [326] = {1632,"",85,},
        [327] = {1633,"",85,},
        [328] = {1634,"",85,},
        [329] = {1635,"",85,},
        [330] = {1636,"",85,},
        [331] = {1637,"",85,},
        [332] = {1638,"",85,},
        [333] = {1639,"",85,},
        [334] = {1640,"",85,},
        [335] = {1641,"",85,},
        [336] = {1642,"",85,},
        [337] = {1643,"",85,},
        [338] = {1644,"",85,},
        [339] = {1645,"",85,},
        [340] = {1646,"",85,},
        [341] = {1647,"",85,},
        [342] = {1648,"",85,},
        [343] = {1649,"",85,},
        [344] = {1650,"",85,},
        [345] = {1651,"",85,},
        [346] = {1652,"",85,},
        [347] = {1653,"",85,},
        [348] = {1654,"",85,},
        [349] = {1655,"",85,},
        [350] = {1656,"",85,},
        [351] = {1657,"",85,},
        [352] = {1658,"",85,},
        [353] = {1659,"",85,},
        [354] = {1660,"",85,},
        [355] = {1801,"แลกเปลี่ยน",90,},
        [356] = {1802,"แลกเปลี่ยน",90,},
        [357] = {1803,"แลกเปลี่ยน",90,},
        [358] = {1804,"",90,},
        [359] = {1805,"",90,},
        [360] = {1806,"",90,},
        [361] = {1807,"",90,},
        [362] = {1808,"",90,},
        [363] = {1809,"",90,},
        [364] = {1810,"",90,},
        [365] = {1811,"",90,},
        [366] = {1851,"",90,},
        [367] = {1852,"",90,},
        [368] = {1853,"",90,},
        [369] = {1854,"",95,},
        [370] = {1855,"",95,},
        [371] = {1856,"",95,},
        [372] = {1901,"",60,},
        [373] = {1902,"",60,},
        [374] = {1903,"",60,},
        [375] = {1904,"",60,},
        [376] = {1905,"",60,},
        [377] = {1906,"",60,},
        [378] = {1907,"",60,},
        [379] = {1908,"",60,},
        [380] = {2001,"",75,},
        [381] = {2002,"",75,},
        [382] = {2003,"",75,},
        [383] = {2004,"",75,},
        [384] = {2401,"",1,},
        [385] = {2402,"",1,},
        [386] = {2403,"",1,},
        [387] = {2404,"",1,},
        [388] = {2405,"",1,},
        [389] = {2406,"",1,},
        [390] = {2407,"",1,},
        [391] = {2408,"",1,},
        [392] = {2409,"",1,},
        [393] = {2410,"",1,},
        [394] = {2411,"",1,},
        [395] = {2412,"",1,},
        [396] = {2413,"",1,},
        [397] = {2414,"",1,},
        [398] = {2415,"",1,},
        [399] = {2416,"",1,},
    }
}

return shop_fix