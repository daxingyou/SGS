--equip_boss

local equip_boss = {
    -- key
    __key_map = {
      id = 1,    --强敌id-int 
      talk = 2,    --强敌对话-string 
      name = 3,    --强敌名称-string 
    
    },
    -- data
    _data = {
        [1] = {1001,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [2] = {1002,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [3] = {1003,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [4] = {1004,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [5] = {1005,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [6] = {1006,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [7] = {1007,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [8] = {1008,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [9] = {1009,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [10] = {1010,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [11] = {1011,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [12] = {1012,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [13] = {1013,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [14] = {1014,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [15] = {1015,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [16] = {1016,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [17] = {1017,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [18] = {1018,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [19] = {1019,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [20] = {1020,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [21] = {1021,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [22] = {1022,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [23] = {1023,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [24] = {1024,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [25] = {1025,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [26] = {1026,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [27] = {1027,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [28] = {1028,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [29] = {1029,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [30] = {1030,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [31] = {1031,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [32] = {1032,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [33] = {1033,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [34] = {1034,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [35] = {1035,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [36] = {1036,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [37] = {1037,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [38] = {1038,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [39] = {1039,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [40] = {1040,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [41] = {1041,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [42] = {1042,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [43] = {1043,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [44] = {1044,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [45] = {1045,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [46] = {1046,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [47] = {1047,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [48] = {1048,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [49] = {1049,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [50] = {1050,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [51] = {1051,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [52] = {1052,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [53] = {1053,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [54] = {1054,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [55] = {1055,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [56] = {1056,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [57] = {1057,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [58] = {1058,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [59] = {1059,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [60] = {1060,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [61] = {1061,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [62] = {1062,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [63] = {1063,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [64] = {1064,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [65] = {1065,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [66] = {1066,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [67] = {1067,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [68] = {1068,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [69] = {1069,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [70] = {1070,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [71] = {1071,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [72] = {1072,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [73] = {1073,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [74] = {1074,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [75] = {1075,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [76] = {1076,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [77] = {1077,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [78] = {1078,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [79] = {1079,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [80] = {1080,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [81] = {1081,"Ta là Thượng Tướng Hà Bắc Nhan Lương, dám đấu 300 hiệp với ta không?","Nhan Lương",},
        [82] = {2001,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [83] = {2002,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [84] = {2003,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [85] = {2004,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [86] = {2005,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [87] = {2006,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [88] = {2007,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [89] = {2008,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [90] = {2009,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [91] = {2010,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [92] = {2011,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [93] = {2012,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [94] = {2013,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [95] = {2014,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [96] = {2015,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [97] = {2016,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [98] = {2017,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [99] = {2018,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [100] = {2019,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [101] = {2020,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [102] = {2021,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [103] = {2022,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [104] = {2023,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [105] = {2024,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [106] = {2025,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [107] = {2026,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [108] = {2027,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [109] = {2028,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [110] = {2029,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [111] = {2030,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [112] = {2031,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [113] = {2032,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [114] = {2033,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [115] = {2034,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [116] = {2035,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [117] = {2036,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [118] = {2037,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [119] = {2038,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [120] = {2039,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [121] = {2040,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [122] = {2041,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [123] = {2042,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [124] = {2043,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [125] = {2044,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [126] = {2045,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [127] = {2046,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [128] = {2047,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [129] = {2048,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [130] = {2049,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [131] = {2050,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [132] = {2051,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [133] = {2052,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [134] = {2053,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [135] = {2054,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [136] = {2055,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [137] = {2056,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [138] = {2057,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [139] = {2058,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [140] = {2059,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [141] = {2060,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [142] = {2061,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [143] = {2062,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [144] = {2063,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [145] = {2064,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [146] = {2065,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [147] = {2066,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [148] = {2067,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [149] = {2068,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [150] = {2069,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [151] = {2070,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [152] = {2071,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [153] = {2072,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [154] = {2073,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [155] = {2074,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [156] = {2075,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [157] = {2076,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [158] = {2077,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [159] = {2078,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [160] = {2079,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [161] = {2080,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [162] = {2081,"Hoa Hùng ở đây! Ai dám làm càn!","Hoa Hùng",},
        [163] = {3001,"Ai có thể cản ta!","Lữ Bố",},
        [164] = {3002,"Ai có thể cản ta!","Lữ Bố",},
        [165] = {3003,"Ai có thể cản ta!","Lữ Bố",},
        [166] = {3004,"Ai có thể cản ta!","Lữ Bố",},
        [167] = {3005,"Ai có thể cản ta!","Lữ Bố",},
        [168] = {3006,"Ai có thể cản ta!","Lữ Bố",},
        [169] = {3007,"Ai có thể cản ta!","Lữ Bố",},
        [170] = {3008,"Ai có thể cản ta!","Lữ Bố",},
        [171] = {3009,"Ai có thể cản ta!","Lữ Bố",},
        [172] = {3010,"Ai có thể cản ta!","Lữ Bố",},
        [173] = {3011,"Ai có thể cản ta!","Lữ Bố",},
        [174] = {3012,"Ai có thể cản ta!","Lữ Bố",},
        [175] = {3013,"Ai có thể cản ta!","Lữ Bố",},
        [176] = {3014,"Ai có thể cản ta!","Lữ Bố",},
        [177] = {3015,"Ai có thể cản ta!","Lữ Bố",},
        [178] = {3016,"Ai có thể cản ta!","Lữ Bố",},
        [179] = {3017,"Ai có thể cản ta!","Lữ Bố",},
        [180] = {3018,"Ai có thể cản ta!","Lữ Bố",},
        [181] = {3019,"Ai có thể cản ta!","Lữ Bố",},
        [182] = {3020,"Ai có thể cản ta!","Lữ Bố",},
        [183] = {3021,"Ai có thể cản ta!","Lữ Bố",},
        [184] = {3022,"Ai có thể cản ta!","Lữ Bố",},
        [185] = {3023,"Ai có thể cản ta!","Lữ Bố",},
        [186] = {3024,"Ai có thể cản ta!","Lữ Bố",},
        [187] = {3025,"Ai có thể cản ta!","Lữ Bố",},
        [188] = {3026,"Ai có thể cản ta!","Lữ Bố",},
        [189] = {3027,"Ai có thể cản ta!","Lữ Bố",},
        [190] = {3028,"Ai có thể cản ta!","Lữ Bố",},
        [191] = {3029,"Ai có thể cản ta!","Lữ Bố",},
        [192] = {3030,"Ai có thể cản ta!","Lữ Bố",},
        [193] = {3031,"Ai có thể cản ta!","Lữ Bố",},
        [194] = {3032,"Ai có thể cản ta!","Lữ Bố",},
        [195] = {3033,"Ai có thể cản ta!","Lữ Bố",},
        [196] = {3034,"Ai có thể cản ta!","Lữ Bố",},
        [197] = {3035,"Ai có thể cản ta!","Lữ Bố",},
        [198] = {3036,"Ai có thể cản ta!","Lữ Bố",},
        [199] = {3037,"Ai có thể cản ta!","Lữ Bố",},
        [200] = {3038,"Ai có thể cản ta!","Lữ Bố",},
        [201] = {3039,"Ai có thể cản ta!","Lữ Bố",},
        [202] = {3040,"Ai có thể cản ta!","Lữ Bố",},
        [203] = {3041,"Ai có thể cản ta!","Lữ Bố",},
        [204] = {3042,"Ai có thể cản ta!","Lữ Bố",},
        [205] = {3043,"Ai có thể cản ta!","Lữ Bố",},
        [206] = {3044,"Ai có thể cản ta!","Lữ Bố",},
        [207] = {3045,"Ai có thể cản ta!","Lữ Bố",},
        [208] = {3046,"Ai có thể cản ta!","Lữ Bố",},
        [209] = {3047,"Ai có thể cản ta!","Lữ Bố",},
        [210] = {3048,"Ai có thể cản ta!","Lữ Bố",},
        [211] = {3049,"Ai có thể cản ta!","Lữ Bố",},
        [212] = {3050,"Ai có thể cản ta!","Lữ Bố",},
        [213] = {3051,"Ai có thể cản ta!","Lữ Bố",},
        [214] = {3052,"Ai có thể cản ta!","Lữ Bố",},
        [215] = {3053,"Ai có thể cản ta!","Lữ Bố",},
        [216] = {3054,"Ai có thể cản ta!","Lữ Bố",},
        [217] = {3055,"Ai có thể cản ta!","Lữ Bố",},
        [218] = {3056,"Ai có thể cản ta!","Lữ Bố",},
        [219] = {3057,"Ai có thể cản ta!","Lữ Bố",},
        [220] = {3058,"Ai có thể cản ta!","Lữ Bố",},
        [221] = {3059,"Ai có thể cản ta!","Lữ Bố",},
        [222] = {3060,"Ai có thể cản ta!","Lữ Bố",},
        [223] = {3061,"Ai có thể cản ta!","Lữ Bố",},
        [224] = {3062,"Ai có thể cản ta!","Lữ Bố",},
        [225] = {3063,"Ai có thể cản ta!","Lữ Bố",},
        [226] = {3064,"Ai có thể cản ta!","Lữ Bố",},
        [227] = {3065,"Ai có thể cản ta!","Lữ Bố",},
        [228] = {3066,"Ai có thể cản ta!","Lữ Bố",},
        [229] = {3067,"Ai có thể cản ta!","Lữ Bố",},
        [230] = {3068,"Ai có thể cản ta!","Lữ Bố",},
        [231] = {3069,"Ai có thể cản ta!","Lữ Bố",},
        [232] = {3070,"Ai có thể cản ta!","Lữ Bố",},
        [233] = {3071,"Ai có thể cản ta!","Lữ Bố",},
        [234] = {3072,"Ai có thể cản ta!","Lữ Bố",},
        [235] = {3073,"Ai có thể cản ta!","Lữ Bố",},
        [236] = {3074,"Ai có thể cản ta!","Lữ Bố",},
        [237] = {3075,"Ai có thể cản ta!","Lữ Bố",},
        [238] = {3076,"Ai có thể cản ta!","Lữ Bố",},
        [239] = {3077,"Ai có thể cản ta!","Lữ Bố",},
        [240] = {3078,"Ai có thể cản ta!","Lữ Bố",},
        [241] = {3079,"Ai có thể cản ta!","Lữ Bố",},
        [242] = {3080,"Ai có thể cản ta!","Lữ Bố",},
        [243] = {3081,"Ai có thể cản ta!","Lữ Bố",},
    },

    -- index
    __index_id = {
        [1001] = 1,
        [1002] = 2,
        [1003] = 3,
        [1004] = 4,
        [1005] = 5,
        [1006] = 6,
        [1007] = 7,
        [1008] = 8,
        [1009] = 9,
        [1010] = 10,
        [1011] = 11,
        [1012] = 12,
        [1013] = 13,
        [1014] = 14,
        [1015] = 15,
        [1016] = 16,
        [1017] = 17,
        [1018] = 18,
        [1019] = 19,
        [1020] = 20,
        [1021] = 21,
        [1022] = 22,
        [1023] = 23,
        [1024] = 24,
        [1025] = 25,
        [1026] = 26,
        [1027] = 27,
        [1028] = 28,
        [1029] = 29,
        [1030] = 30,
        [1031] = 31,
        [1032] = 32,
        [1033] = 33,
        [1034] = 34,
        [1035] = 35,
        [1036] = 36,
        [1037] = 37,
        [1038] = 38,
        [1039] = 39,
        [1040] = 40,
        [1041] = 41,
        [1042] = 42,
        [1043] = 43,
        [1044] = 44,
        [1045] = 45,
        [1046] = 46,
        [1047] = 47,
        [1048] = 48,
        [1049] = 49,
        [1050] = 50,
        [1051] = 51,
        [1052] = 52,
        [1053] = 53,
        [1054] = 54,
        [1055] = 55,
        [1056] = 56,
        [1057] = 57,
        [1058] = 58,
        [1059] = 59,
        [1060] = 60,
        [1061] = 61,
        [1062] = 62,
        [1063] = 63,
        [1064] = 64,
        [1065] = 65,
        [1066] = 66,
        [1067] = 67,
        [1068] = 68,
        [1069] = 69,
        [1070] = 70,
        [1071] = 71,
        [1072] = 72,
        [1073] = 73,
        [1074] = 74,
        [1075] = 75,
        [1076] = 76,
        [1077] = 77,
        [1078] = 78,
        [1079] = 79,
        [1080] = 80,
        [1081] = 81,
        [2001] = 82,
        [2002] = 83,
        [2003] = 84,
        [2004] = 85,
        [2005] = 86,
        [2006] = 87,
        [2007] = 88,
        [2008] = 89,
        [2009] = 90,
        [2010] = 91,
        [2011] = 92,
        [2012] = 93,
        [2013] = 94,
        [2014] = 95,
        [2015] = 96,
        [2016] = 97,
        [2017] = 98,
        [2018] = 99,
        [2019] = 100,
        [2020] = 101,
        [2021] = 102,
        [2022] = 103,
        [2023] = 104,
        [2024] = 105,
        [2025] = 106,
        [2026] = 107,
        [2027] = 108,
        [2028] = 109,
        [2029] = 110,
        [2030] = 111,
        [2031] = 112,
        [2032] = 113,
        [2033] = 114,
        [2034] = 115,
        [2035] = 116,
        [2036] = 117,
        [2037] = 118,
        [2038] = 119,
        [2039] = 120,
        [2040] = 121,
        [2041] = 122,
        [2042] = 123,
        [2043] = 124,
        [2044] = 125,
        [2045] = 126,
        [2046] = 127,
        [2047] = 128,
        [2048] = 129,
        [2049] = 130,
        [2050] = 131,
        [2051] = 132,
        [2052] = 133,
        [2053] = 134,
        [2054] = 135,
        [2055] = 136,
        [2056] = 137,
        [2057] = 138,
        [2058] = 139,
        [2059] = 140,
        [2060] = 141,
        [2061] = 142,
        [2062] = 143,
        [2063] = 144,
        [2064] = 145,
        [2065] = 146,
        [2066] = 147,
        [2067] = 148,
        [2068] = 149,
        [2069] = 150,
        [2070] = 151,
        [2071] = 152,
        [2072] = 153,
        [2073] = 154,
        [2074] = 155,
        [2075] = 156,
        [2076] = 157,
        [2077] = 158,
        [2078] = 159,
        [2079] = 160,
        [2080] = 161,
        [2081] = 162,
        [3001] = 163,
        [3002] = 164,
        [3003] = 165,
        [3004] = 166,
        [3005] = 167,
        [3006] = 168,
        [3007] = 169,
        [3008] = 170,
        [3009] = 171,
        [3010] = 172,
        [3011] = 173,
        [3012] = 174,
        [3013] = 175,
        [3014] = 176,
        [3015] = 177,
        [3016] = 178,
        [3017] = 179,
        [3018] = 180,
        [3019] = 181,
        [3020] = 182,
        [3021] = 183,
        [3022] = 184,
        [3023] = 185,
        [3024] = 186,
        [3025] = 187,
        [3026] = 188,
        [3027] = 189,
        [3028] = 190,
        [3029] = 191,
        [3030] = 192,
        [3031] = 193,
        [3032] = 194,
        [3033] = 195,
        [3034] = 196,
        [3035] = 197,
        [3036] = 198,
        [3037] = 199,
        [3038] = 200,
        [3039] = 201,
        [3040] = 202,
        [3041] = 203,
        [3042] = 204,
        [3043] = 205,
        [3044] = 206,
        [3045] = 207,
        [3046] = 208,
        [3047] = 209,
        [3048] = 210,
        [3049] = 211,
        [3050] = 212,
        [3051] = 213,
        [3052] = 214,
        [3053] = 215,
        [3054] = 216,
        [3055] = 217,
        [3056] = 218,
        [3057] = 219,
        [3058] = 220,
        [3059] = 221,
        [3060] = 222,
        [3061] = 223,
        [3062] = 224,
        [3063] = 225,
        [3064] = 226,
        [3065] = 227,
        [3066] = 228,
        [3067] = 229,
        [3068] = 230,
        [3069] = 231,
        [3070] = 232,
        [3071] = 233,
        [3072] = 234,
        [3073] = 235,
        [3074] = 236,
        [3075] = 237,
        [3076] = 238,
        [3077] = 239,
        [3078] = 240,
        [3079] = 241,
        [3080] = 242,
        [3081] = 243,
    }
}

return equip_boss