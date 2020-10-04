--rebel_base

local rebel_base = {
    -- key
    __key_map = {
      id = 1,    --叛军id-int 
      name = 2,    --叛军名称-英语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"[Victorious] Wutugu",},
        [2] = {2,"[Victorious] Sha Moke",},
        [3] = {3,"[Victorious] Zhu Rong",},
        [4] = {4,"[Victorious] Meng Huo",},
        [5] = {5,"[Veteran] Wutugu",},
        [6] = {6,"[Veteran] Sha Moke",},
        [7] = {7,"[Veteran] Zhu Rong",},
        [8] = {8,"[Veteran] Meng Huo",},
        [9] = {9,"[Invincible] Wutugu",},
        [10] = {10,"[Invincible] Sha Moke",},
        [11] = {11,"[Invincible] Zhu Rong",},
        [12] = {12,"[Invincible] Meng Huo",},
        [13] = {13,"[Divine] Meng Huo",},
        [14] = {14,"[Victorious] Wutugu",},
        [15] = {15,"[Victorious] Sha Moke",},
        [16] = {16,"[Victorious] Zhu Rong",},
        [17] = {17,"[Victorious] Meng Huo",},
        [18] = {18,"[Veteran] Wutugu",},
        [19] = {19,"[Veteran] Sha Moke",},
        [20] = {20,"[Veteran] Zhu Rong",},
        [21] = {21,"[Veteran] Meng Huo",},
        [22] = {22,"[Invincible] Wutugu",},
        [23] = {23,"[Invincible] Sha Moke",},
        [24] = {24,"[Invincible] Zhu Rong",},
        [25] = {25,"[Invincible] Meng Huo",},
        [26] = {26,"[Victorious] Wutugu",},
        [27] = {27,"[Victorious] Sha Moke",},
        [28] = {28,"[Victorious] Zhu Rong",},
        [29] = {29,"[Victorious] Meng Huo",},
        [30] = {30,"[Veteran] Wutugu",},
        [31] = {31,"[Veteran] Sha Moke",},
        [32] = {32,"[Veteran] Zhu Rong",},
        [33] = {33,"[Veteran] Meng Huo",},
        [34] = {34,"[Invincible] Wutugu",},
        [35] = {35,"[Invincible] Sha Moke",},
        [36] = {36,"[Invincible] Zhu Rong",},
        [37] = {37,"[Invincible] Meng Huo",},
        [38] = {38,"[Victorious] Wutugu",},
        [39] = {39,"[Victorious] Sha Moke",},
        [40] = {40,"[Victorious] Zhu Rong",},
        [41] = {41,"[Victorious] Meng Huo",},
        [42] = {42,"[Veteran] Wutugu",},
        [43] = {43,"[Veteran] Sha Moke",},
        [44] = {44,"[Veteran] Zhu Rong",},
        [45] = {45,"[Veteran] Meng Huo",},
        [46] = {46,"[Invincible] Wutugu",},
        [47] = {47,"[Invincible] Sha Moke",},
        [48] = {48,"[Invincible] Zhu Rong",},
        [49] = {49,"[Invincible] Meng Huo",},
        [50] = {50,"[Victorious] Wutugu",},
        [51] = {51,"[Victorious] Sha Moke",},
        [52] = {52,"[Victorious] Zhu Rong",},
        [53] = {53,"[Victorious] Meng Huo",},
        [54] = {54,"[Veteran] Wutugu",},
        [55] = {55,"[Veteran] Sha Moke",},
        [56] = {56,"[Veteran] Zhu Rong",},
        [57] = {57,"[Veteran] Meng Huo",},
        [58] = {58,"[Invincible] Wutugu",},
        [59] = {59,"[Invincible] Sha Moke",},
        [60] = {60,"[Invincible] Zhu Rong",},
        [61] = {61,"[Invincible] Meng Huo",},
        [62] = {62,"[Victorious] Wutugu",},
        [63] = {63,"[Victorious] Sha Moke",},
        [64] = {64,"[Victorious] Zhu Rong",},
        [65] = {65,"[Victorious] Meng Huo",},
        [66] = {66,"[Veteran] Wutugu",},
        [67] = {67,"[Veteran] Sha Moke",},
        [68] = {68,"[Veteran] Zhu Rong",},
        [69] = {69,"[Veteran] Meng Huo",},
        [70] = {70,"[Invincible] Wutugu",},
        [71] = {71,"[Invincible] Sha Moke",},
        [72] = {72,"[Invincible] Zhu Rong",},
        [73] = {73,"[Invincible] Meng Huo",},
        [74] = {74,"[Victorious] Wutugu",},
        [75] = {75,"[Victorious] Sha Moke",},
        [76] = {76,"[Victorious] Zhu Rong",},
        [77] = {77,"[Victorious] Meng Huo",},
        [78] = {78,"[Veteran] Wutugu",},
        [79] = {79,"[Veteran] Sha Moke",},
        [80] = {80,"[Veteran] Zhu Rong",},
        [81] = {81,"[Veteran] Meng Huo",},
        [82] = {82,"[Invincible] Wutugu",},
        [83] = {83,"[Invincible] Sha Moke",},
        [84] = {84,"[Invincible] Zhu Rong",},
        [85] = {85,"[Invincible] Meng Huo",},
        [86] = {86,"[Victorious] Wutugu",},
        [87] = {87,"[Victorious] Sha Moke",},
        [88] = {88,"[Victorious] Zhu Rong",},
        [89] = {89,"[Victorious] Meng Huo",},
        [90] = {90,"[Veteran] Wutugu",},
        [91] = {91,"[Veteran] Sha Moke",},
        [92] = {92,"[Veteran] Zhu Rong",},
        [93] = {93,"[Veteran] Meng Huo",},
        [94] = {94,"[Invincible] Wutugu",},
        [95] = {95,"[Invincible] Sha Moke",},
        [96] = {96,"[Invincible] Zhu Rong",},
        [97] = {97,"[Invincible] Meng Huo",},
        [98] = {98,"[Victorious] Wutugu",},
        [99] = {99,"[Victorious] Sha Moke",},
        [100] = {100,"[Victorious] Zhu Rong",},
        [101] = {101,"[Victorious] Meng Huo",},
        [102] = {102,"[Veteran] Wutugu",},
        [103] = {103,"[Veteran] Sha Moke",},
        [104] = {104,"[Veteran] Zhu Rong",},
        [105] = {105,"[Veteran] Meng Huo",},
        [106] = {106,"[Invincible] Wutugu",},
        [107] = {107,"[Invincible] Sha Moke",},
        [108] = {108,"[Invincible] Zhu Rong",},
        [109] = {109,"[Invincible] Meng Huo",},
        [110] = {110,"[Victorious] Wutugu",},
        [111] = {111,"[Victorious] Sha Moke",},
        [112] = {112,"[Victorious] Zhu Rong",},
        [113] = {113,"[Victorious] Meng Huo",},
        [114] = {114,"[Veteran] Wutugu",},
        [115] = {115,"[Veteran] Sha Moke",},
        [116] = {116,"[Veteran] Zhu Rong",},
        [117] = {117,"[Veteran] Meng Huo",},
        [118] = {118,"[Invincible] Wutugu",},
        [119] = {119,"[Invincible] Sha Moke",},
        [120] = {120,"[Invincible] Zhu Rong",},
        [121] = {121,"[Invincible] Meng Huo",},
    }
}

return rebel_base