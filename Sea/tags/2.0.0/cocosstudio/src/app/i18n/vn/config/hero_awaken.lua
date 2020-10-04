--hero_awaken

local hero_awaken = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      detail_description = 2,    --详情界面描述-string 
      talent_description = 3,    --觉醒天赋描述-string 
    
    },
    -- data
    _data = {
        [1] = {0,"","",},
        [2] = {1,"","",},
        [3] = {2,"","",},
        [4] = {3,"","",},
        [5] = {4,"","",},
        [6] = {5,"Công, Thủ, HP tăng 3%","Thức tỉnh thiên phú 1: Công, thủ, sinh lực mỗi loại tăng 3%",},
        [7] = {6,"","",},
        [8] = {7,"","",},
        [9] = {8,"","",},
        [10] = {9,"","",},
        [11] = {10,"Công, Thủ, HP tăng 4%","Thức tỉnh thiên phú 2: Công, thủ, sinh lực mỗi loại tăng 4%",},
        [12] = {11,"","",},
        [13] = {12,"","",},
        [14] = {13,"","",},
        [15] = {14,"","",},
        [16] = {15,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 3: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [17] = {16,"","",},
        [18] = {17,"","",},
        [19] = {18,"","",},
        [20] = {19,"","",},
        [21] = {20,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 4: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [22] = {21,"","",},
        [23] = {22,"","",},
        [24] = {23,"","",},
        [25] = {24,"","",},
        [26] = {25,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 5: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [27] = {26,"","",},
        [28] = {27,"","",},
        [29] = {28,"","",},
        [30] = {29,"","",},
        [31] = {30,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 6: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [32] = {31,"","",},
        [33] = {32,"","",},
        [34] = {33,"","",},
        [35] = {34,"","",},
        [36] = {35,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 7: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [37] = {36,"","",},
        [38] = {37,"","",},
        [39] = {38,"","",},
        [40] = {39,"","",},
        [41] = {40,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 8: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [42] = {41,"","",},
        [43] = {42,"","",},
        [44] = {43,"","",},
        [45] = {44,"","",},
        [46] = {45,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 9: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [47] = {46,"","",},
        [48] = {47,"","",},
        [49] = {48,"","",},
        [50] = {49,"","",},
        [51] = {50,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 10: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [52] = {51,"","",},
        [53] = {52,"","",},
        [54] = {53,"","",},
        [55] = {54,"","",},
        [56] = {55,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 11: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [57] = {56,"","",},
        [58] = {57,"","",},
        [59] = {58,"","",},
        [60] = {59,"","",},
        [61] = {60,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 12: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [62] = {61,"","",},
        [63] = {62,"","",},
        [64] = {63,"","",},
        [65] = {64,"","",},
        [66] = {65,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 13: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [67] = {66,"","",},
        [68] = {67,"","",},
        [69] = {68,"","",},
        [70] = {69,"","",},
        [71] = {70,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 14: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [72] = {71,"","",},
        [73] = {72,"","",},
        [74] = {73,"","",},
        [75] = {74,"","",},
        [76] = {75,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 15: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [77] = {76,"","",},
        [78] = {77,"","",},
        [79] = {78,"","",},
        [80] = {79,"","",},
        [81] = {80,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 16: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [82] = {0,"","",},
        [83] = {1,"","",},
        [84] = {2,"","",},
        [85] = {3,"","",},
        [86] = {4,"","",},
        [87] = {5,"Công, Thủ, HP tăng 3%","Thức tỉnh thiên phú 1: Công, thủ, sinh lực mỗi loại tăng 3%",},
        [88] = {6,"","",},
        [89] = {7,"","",},
        [90] = {8,"","",},
        [91] = {9,"","",},
        [92] = {10,"Công, Thủ, HP tăng 4%","Thức tỉnh thiên phú 2: Công, thủ, sinh lực mỗi loại tăng 4%",},
        [93] = {11,"","",},
        [94] = {12,"","",},
        [95] = {13,"","",},
        [96] = {14,"","",},
        [97] = {15,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 3: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [98] = {16,"","",},
        [99] = {17,"","",},
        [100] = {18,"","",},
        [101] = {19,"","",},
        [102] = {20,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 4: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [103] = {21,"","",},
        [104] = {22,"","",},
        [105] = {23,"","",},
        [106] = {24,"","",},
        [107] = {25,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 5: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [108] = {26,"","",},
        [109] = {27,"","",},
        [110] = {28,"","",},
        [111] = {29,"","",},
        [112] = {30,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 6: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [113] = {31,"","",},
        [114] = {32,"","",},
        [115] = {33,"","",},
        [116] = {34,"","",},
        [117] = {35,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 7: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [118] = {36,"","",},
        [119] = {37,"","",},
        [120] = {38,"","",},
        [121] = {39,"","",},
        [122] = {40,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 8: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [123] = {41,"","",},
        [124] = {42,"","",},
        [125] = {43,"","",},
        [126] = {44,"","",},
        [127] = {45,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 9: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [128] = {46,"","",},
        [129] = {47,"","",},
        [130] = {48,"","",},
        [131] = {49,"","",},
        [132] = {50,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 10: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [133] = {51,"","",},
        [134] = {52,"","",},
        [135] = {53,"","",},
        [136] = {54,"","",},
        [137] = {55,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 11: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [138] = {56,"","",},
        [139] = {57,"","",},
        [140] = {58,"","",},
        [141] = {59,"","",},
        [142] = {60,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 12: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [143] = {61,"","",},
        [144] = {62,"","",},
        [145] = {63,"","",},
        [146] = {64,"","",},
        [147] = {65,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 13: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [148] = {66,"","",},
        [149] = {67,"","",},
        [150] = {68,"","",},
        [151] = {69,"","",},
        [152] = {70,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 14: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [153] = {71,"","",},
        [154] = {72,"","",},
        [155] = {73,"","",},
        [156] = {74,"","",},
        [157] = {75,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 15: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [158] = {76,"","",},
        [159] = {77,"","",},
        [160] = {78,"","",},
        [161] = {79,"","",},
        [162] = {80,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 16: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [163] = {0,"","",},
        [164] = {1,"","",},
        [165] = {2,"","",},
        [166] = {3,"","",},
        [167] = {4,"","",},
        [168] = {5,"Công, Thủ, HP tăng 3%","Thức tỉnh thiên phú 1: Công, thủ, sinh lực mỗi loại tăng 3%",},
        [169] = {6,"","",},
        [170] = {7,"","",},
        [171] = {8,"","",},
        [172] = {9,"","",},
        [173] = {10,"Công, Thủ, HP tăng 4%","Thức tỉnh thiên phú 2: Công, thủ, sinh lực mỗi loại tăng 4%",},
        [174] = {11,"","",},
        [175] = {12,"","",},
        [176] = {13,"","",},
        [177] = {14,"","",},
        [178] = {15,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 3: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [179] = {16,"","",},
        [180] = {17,"","",},
        [181] = {18,"","",},
        [182] = {19,"","",},
        [183] = {20,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 4: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [184] = {21,"","",},
        [185] = {22,"","",},
        [186] = {23,"","",},
        [187] = {24,"","",},
        [188] = {25,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 5: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [189] = {26,"","",},
        [190] = {27,"","",},
        [191] = {28,"","",},
        [192] = {29,"","",},
        [193] = {30,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 6: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [194] = {31,"","",},
        [195] = {32,"","",},
        [196] = {33,"","",},
        [197] = {34,"","",},
        [198] = {35,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 7: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [199] = {36,"","",},
        [200] = {37,"","",},
        [201] = {38,"","",},
        [202] = {39,"","",},
        [203] = {40,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 8: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [204] = {41,"","",},
        [205] = {42,"","",},
        [206] = {43,"","",},
        [207] = {44,"","",},
        [208] = {45,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 9: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [209] = {46,"","",},
        [210] = {47,"","",},
        [211] = {48,"","",},
        [212] = {49,"","",},
        [213] = {50,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 10: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [214] = {51,"","",},
        [215] = {52,"","",},
        [216] = {53,"","",},
        [217] = {54,"","",},
        [218] = {55,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 11: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [219] = {56,"","",},
        [220] = {57,"","",},
        [221] = {58,"","",},
        [222] = {59,"","",},
        [223] = {60,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 12: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [224] = {61,"","",},
        [225] = {62,"","",},
        [226] = {63,"","",},
        [227] = {64,"","",},
        [228] = {65,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 13: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [229] = {66,"","",},
        [230] = {67,"","",},
        [231] = {68,"","",},
        [232] = {69,"","",},
        [233] = {70,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 14: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [234] = {71,"","",},
        [235] = {72,"","",},
        [236] = {73,"","",},
        [237] = {74,"","",},
        [238] = {75,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 15: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [239] = {76,"","",},
        [240] = {77,"","",},
        [241] = {78,"","",},
        [242] = {79,"","",},
        [243] = {80,"Công, Thủ, HP tăng 5%","Thức tỉnh thiên phú 16: Công, thủ, sinh lực mỗi loại tăng 5%",},
        [244] = {0,"","",},
        [245] = {1,"","",},
        [246] = {2,"","",},
        [247] = {3,"","",},
        [248] = {4,"","",},
        [249] = {5,"","",},
        [250] = {6,"","",},
        [251] = {7,"","",},
        [252] = {8,"","",},
        [253] = {9,"","",},
        [254] = {10,"","",},
        [255] = {11,"","",},
        [256] = {12,"","",},
        [257] = {13,"","",},
        [258] = {14,"","",},
        [259] = {15,"","",},
        [260] = {16,"","",},
        [261] = {17,"","",},
        [262] = {18,"","",},
        [263] = {19,"","",},
        [264] = {20,"","",},
        [265] = {21,"","",},
        [266] = {22,"","",},
        [267] = {23,"","",},
        [268] = {24,"","",},
        [269] = {25,"","",},
        [270] = {26,"","",},
        [271] = {27,"","",},
        [272] = {28,"","",},
        [273] = {29,"","",},
        [274] = {30,"","",},
        [275] = {31,"","",},
        [276] = {32,"","",},
        [277] = {33,"","",},
        [278] = {34,"","",},
        [279] = {35,"","",},
        [280] = {36,"","",},
        [281] = {37,"","",},
        [282] = {38,"","",},
        [283] = {39,"","",},
        [284] = {40,"","",},
        [285] = {41,"","",},
        [286] = {42,"","",},
        [287] = {43,"","",},
        [288] = {44,"","",},
        [289] = {45,"","",},
        [290] = {46,"","",},
        [291] = {47,"","",},
        [292] = {48,"","",},
        [293] = {49,"","",},
        [294] = {50,"","",},
        [295] = {51,"","",},
        [296] = {52,"","",},
        [297] = {53,"","",},
        [298] = {54,"","",},
        [299] = {55,"","",},
        [300] = {56,"","",},
        [301] = {57,"","",},
        [302] = {58,"","",},
        [303] = {59,"","",},
        [304] = {60,"","",},
        [305] = {61,"","",},
        [306] = {62,"","",},
        [307] = {63,"","",},
        [308] = {64,"","",},
        [309] = {65,"","",},
        [310] = {66,"","",},
        [311] = {67,"","",},
        [312] = {68,"","",},
        [313] = {69,"","",},
        [314] = {70,"","",},
        [315] = {71,"","",},
        [316] = {72,"","",},
        [317] = {73,"","",},
        [318] = {74,"","",},
        [319] = {75,"","",},
        [320] = {76,"","",},
        [321] = {77,"","",},
        [322] = {78,"","",},
        [323] = {79,"","",},
        [324] = {80,"","",},
    }
}

return hero_awaken