--return_privilege

local return_privilege = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      privilege_txt = 2,    --特权说明-string 
      button_txt = 3,    --按钮文字-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Reset Instance Harian","Reset | Pergi duel",},
        [2] = {2,"Reset Jalan Kejayaan","Reset | Pergi duel",},
        [3] = {3,"Menyerang instance skenario mendapatkan hadiah 2x lipat","Pergi duel",},
        [4] = {4,"Tantang instance Elit untuk mendapatkan hadiah 2x lipat","Pergi duel",},
        [5] = {5,"Menantang Instance Hero bisa mendapatkan hadiah 2x lipat","Pergi duel",},
        [6] = {6,"Travel menghasilkan EXP Harta & Perak 2x lipat","Pergi Travel",},
        [7] = {7,"Altar Legiun dan Reputasi Legiun hari ini 2x lipat","Pergi ke Legiun",},
        [8] = {8,"Hadiah yang didapatkan dari Check-in Harian 2x lipat","Pergi Klaim",},
        [9] = {9,"Hadiah Panen Raya berlipat 2x","Pergi Klaim",},
        [10] = {10,"Hadiah Misi harian 2x Lipat","Pergi Klaim",},
        [11] = {11,"Reset Instance Harian","Reset | Pergi duel",},
        [12] = {12,"Reset Jalan Kejayaan","Reset | Pergi duel",},
        [13] = {13,"Menyerang instance skenario mendapatkan hadiah 2x lipat","Pergi duel",},
        [14] = {14,"Tantang instance Elit untuk mendapatkan hadiah 2x lipat","Pergi duel",},
        [15] = {15,"Menantang Instance Hero bisa mendapatkan hadiah 2x lipat","Pergi duel",},
        [16] = {16,"Travel menghasilkan EXP Harta & Perak 2x lipat","Pergi Travel",},
        [17] = {17,"Altar Legiun dan Reputasi Legiun hari ini 2x lipat","Pergi ke Legiun",},
        [18] = {18,"Hadiah yang didapatkan dari Check-in Harian 2x lipat","Pergi Klaim",},
        [19] = {19,"Hadiah Panen Raya berlipat 2x","Pergi Klaim",},
        [20] = {20,"Hadiah Misi harian 2x Lipat","Pergi Klaim",},
        [21] = {21,"Reset Instance Harian","Reset | Pergi duel",},
        [22] = {22,"Reset Jalan Kejayaan","Reset | Pergi duel",},
        [23] = {23,"Menyerang instance skenario mendapatkan hadiah 2x lipat","Pergi duel",},
        [24] = {24,"Tantang instance Elit untuk mendapatkan hadiah 2x lipat","Pergi duel",},
        [25] = {25,"Menantang Instance Hero bisa mendapatkan hadiah 2x lipat","Pergi duel",},
        [26] = {26,"Travel menghasilkan EXP Harta & Perak 2x lipat","Pergi Travel",},
        [27] = {27,"Altar Legiun dan Reputasi Legiun hari ini 2x lipat","Pergi ke Legiun",},
        [28] = {28,"Hadiah yang didapatkan dari Check-in Harian 2x lipat","Pergi Klaim",},
        [29] = {29,"Hadiah Panen Raya berlipat 2x","Pergi Klaim",},
        [30] = {30,"Hadiah Misi harian 2x Lipat","Pergi Klaim",},
        [31] = {31,"Reset Instance Harian","Reset | Pergi duel",},
        [32] = {32,"Reset Jalan Kejayaan","Reset | Pergi duel",},
        [33] = {33,"Menyerang instance skenario mendapatkan hadiah 2x lipat","Pergi duel",},
        [34] = {34,"Tantang instance Elit untuk mendapatkan hadiah 2x lipat","Pergi duel",},
        [35] = {35,"Menantang Instance Hero bisa mendapatkan hadiah 2x lipat","Pergi duel",},
        [36] = {36,"Travel menghasilkan EXP Harta & Perak 2x lipat","Pergi Travel",},
        [37] = {37,"Altar Legiun dan Reputasi Legiun hari ini 2x lipat","Pergi ke Legiun",},
        [38] = {38,"Hadiah yang didapatkan dari Check-in Harian 2x lipat","Pergi Klaim",},
        [39] = {39,"Hadiah Panen Raya berlipat 2x","Pergi Klaim",},
        [40] = {40,"Hadiah Misi harian 2x Lipat","Pergi Klaim",},
        [41] = {41,"Reset Instance Harian","Reset | Pergi duel",},
        [42] = {42,"Reset Jalan Kejayaan","Reset | Pergi duel",},
        [43] = {43,"Menyerang instance skenario mendapatkan hadiah 2x lipat","Pergi duel",},
        [44] = {44,"Tantang instance Elit untuk mendapatkan hadiah 2x lipat","Pergi duel",},
        [45] = {45,"Menantang Instance Hero bisa mendapatkan hadiah 2x lipat","Pergi duel",},
        [46] = {46,"Travel menghasilkan EXP Harta & Perak 2x lipat","Pergi Travel",},
        [47] = {47,"Altar Legiun dan Reputasi Legiun hari ini 2x lipat","Pergi ke Legiun",},
        [48] = {48,"Hadiah yang didapatkan dari Check-in Harian 2x lipat","Pergi Klaim",},
        [49] = {49,"Hadiah Panen Raya berlipat 2x","Pergi Klaim",},
        [50] = {50,"Hadiah Misi harian 2x Lipat","Pergi Klaim",},
        [51] = {51,"Reset Instance Harian","Reset | Pergi duel",},
        [52] = {52,"Reset Jalan Kejayaan","Reset | Pergi duel",},
        [53] = {53,"Menyerang instance skenario mendapatkan hadiah 2x lipat","Pergi duel",},
        [54] = {54,"Tantang instance Elit untuk mendapatkan hadiah 2x lipat","Pergi duel",},
        [55] = {55,"Menantang Instance Hero bisa mendapatkan hadiah 2x lipat","Pergi duel",},
        [56] = {56,"Travel menghasilkan EXP Harta & Perak 2x lipat","Pergi Travel",},
        [57] = {57,"Altar Legiun dan Reputasi Legiun hari ini 2x lipat","Pergi ke Legiun",},
        [58] = {58,"Hadiah yang didapatkan dari Check-in Harian 2x lipat","Pergi Klaim",},
        [59] = {59,"Hadiah Panen Raya berlipat 2x","Pergi Klaim",},
        [60] = {60,"Hadiah Misi harian 2x Lipat","Pergi Klaim",},
    }
}

return return_privilege