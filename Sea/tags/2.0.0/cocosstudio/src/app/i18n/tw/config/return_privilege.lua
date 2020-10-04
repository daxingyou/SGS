--return_privilege

local return_privilege = {
    -- key
    __key_map = {
      id = 1,    --编号_key-int 
      privilege_txt = 2,    --特权说明-string 
      button_txt = 3,    --按钮文字-string 
    
    },
    -- data
    _data = {
        [1] = {1,"重置日常副本","重置|去戰鬥",},
        [2] = {2,"重置過關斬將","重置|去戰鬥",},
        [3] = {3,"攻打主線副本獲得雙倍獎勵","去戰鬥",},
        [4] = {4,"攻打精英副本獲得雙倍獎勵","去戰鬥",},
        [5] = {5,"攻打名將副本獲得雙倍獎勵","去戰鬥",},
        [6] = {6,"遊歷行動產出雙倍寶物經驗和銀兩","去遊歷",},
        [7] = {7,"軍團祭祀和今日軍團聲望雙倍","去軍團",},
        [8] = {8,"每日簽到獲得的獎勵雙倍","去領取",},
        [9] = {9,"五穀豐登獲得的獎勵雙倍","去領取",},
        [10] = {10,"每日任務獎勵雙倍","去領取",},
        [11] = {11,"重置日常副本","重置|去戰鬥",},
        [12] = {12,"重置過關斬將","重置|去戰鬥",},
        [13] = {13,"攻打主線副本獲得雙倍獎勵","去戰鬥",},
        [14] = {14,"攻打精英副本獲得雙倍獎勵","去戰鬥",},
        [15] = {15,"攻打名將副本獲得雙倍獎勵","去戰鬥",},
        [16] = {16,"遊歷行動產出雙倍寶物經驗和銀兩","去遊歷",},
        [17] = {17,"軍團祭祀和今日軍團聲望雙倍","去軍團",},
        [18] = {18,"每日簽到獲得的獎勵雙倍","去領取",},
        [19] = {19,"五穀豐登獲得的獎勵雙倍","去領取",},
        [20] = {20,"每日任務獎勵雙倍","去領取",},
        [21] = {21,"重置日常副本","重置|去戰鬥",},
        [22] = {22,"重置過關斬將","重置|去戰鬥",},
        [23] = {23,"攻打主線副本獲得雙倍獎勵","去戰鬥",},
        [24] = {24,"攻打精英副本獲得雙倍獎勵","去戰鬥",},
        [25] = {25,"攻打名將副本獲得雙倍獎勵","去戰鬥",},
        [26] = {26,"遊歷行動產出雙倍寶物經驗和銀兩","去遊歷",},
        [27] = {27,"軍團祭祀和今日軍團聲望雙倍","去軍團",},
        [28] = {28,"每日簽到獲得的獎勵雙倍","去領取",},
        [29] = {29,"五穀豐登獲得的獎勵雙倍","去領取",},
        [30] = {30,"每日任務獎勵雙倍","去領取",},
        [31] = {31,"重置日常副本","重置|去戰鬥",},
        [32] = {32,"重置過關斬將","重置|去戰鬥",},
        [33] = {33,"攻打主線副本獲得雙倍獎勵","去戰鬥",},
        [34] = {34,"攻打精英副本獲得雙倍獎勵","去戰鬥",},
        [35] = {35,"攻打名將副本獲得雙倍獎勵","去戰鬥",},
        [36] = {36,"遊歷行動產出雙倍寶物經驗和銀兩","去遊歷",},
        [37] = {37,"軍團祭祀和今日軍團聲望雙倍","去軍團",},
        [38] = {38,"每日簽到獲得的獎勵雙倍","去領取",},
        [39] = {39,"五穀豐登獲得的獎勵雙倍","去領取",},
        [40] = {40,"每日任務獎勵雙倍","去領取",},
        [41] = {41,"重置日常副本","重置|去戰鬥",},
        [42] = {42,"重置過關斬將","重置|去戰鬥",},
        [43] = {43,"攻打主線副本獲得雙倍獎勵","去戰鬥",},
        [44] = {44,"攻打精英副本獲得雙倍獎勵","去戰鬥",},
        [45] = {45,"攻打名將副本獲得雙倍獎勵","去戰鬥",},
        [46] = {46,"遊歷行動產出雙倍寶物經驗和銀兩","去遊歷",},
        [47] = {47,"軍團祭祀和今日軍團聲望雙倍","去軍團",},
        [48] = {48,"每日簽到獲得的獎勵雙倍","去領取",},
        [49] = {49,"五穀豐登獲得的獎勵雙倍","去領取",},
        [50] = {50,"每日任務獎勵雙倍","去領取",},
        [51] = {51,"重置日常副本","重置|去戰鬥",},
        [52] = {52,"重置過關斬將","重置|去戰鬥",},
        [53] = {53,"攻打主線副本獲得雙倍獎勵","去戰鬥",},
        [54] = {54,"攻打精英副本獲得雙倍獎勵","去戰鬥",},
        [55] = {55,"攻打名將副本獲得雙倍獎勵","去戰鬥",},
        [56] = {56,"遊歷行動產出雙倍寶物經驗和銀兩","去遊歷",},
        [57] = {57,"軍團祭祀和今日軍團聲望雙倍","去軍團",},
        [58] = {58,"每日簽到獲得的獎勵雙倍","去領取",},
        [59] = {59,"五穀豐登獲得的獎勵雙倍","去領取",},
        [60] = {60,"每日任務獎勵雙倍","去領取",},
    }
}

return return_privilege