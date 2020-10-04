--horse_star

local horse_star = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --装备名称-string 
      skill = 3,    --技能描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Belang","[Belang]Hero yang berkuda Bonus ATK +1%",},
        [2] = {1,"Wind-Belang","[Wind-Belang ]Hero yang berkuda Bonus ATK +2%",},
        [3] = {1,"Sun-Belang","[Sun-Belang]Hero yang berkuda Bonus ATK +3%",},
        [4] = {2,"Lu Er","[Lu Er]Hero yang berkuda Bonus DEF+1%",},
        [5] = {2,"Wind-Lu Er","[Wind-Lu Er]Hero yang berkuda Bonus DEF+2%",},
        [6] = {2,"Sun-Lu Er","[Sun-Lu Er]Hero yang megendarai Bonus DEF +3%",},
        [7] = {3,"Qu Huang","[Qu Huang]Hero yang berkuda Bonus HP +1%",},
        [8] = {3,"Wind-Qu Huang","[Wind-Qu Huang]Hero yang berkuda Bonus HP +2%",},
        [9] = {3,"Sun-Qu Huang","[Sun-Qu Huang]Hero yang berkuda Bonus HP +3%",},
        [10] = {4,"Jujube","[Jujube]Hero yang berkuda Bonus KRIT DMG +1%",},
        [11] = {4,"Wind-Jujube","[Wind-Jujube]Hero yang berkuda Bonus KRIT DMG +2%",},
        [12] = {4,"Sun-Jujube","[Sun-Jujube]Hero yang berkuda Bonus KRIT DMG +3%",},
        [13] = {5,"Salju Putih","[Salju Putih]Hero yang berkuda DMG+3%",},
        [14] = {5,"Wind-Salju Putih","[Wind-Salju Putih]Hero yang berkuda DMG+6%",},
        [15] = {5,"Sun-Salju Putih","[Sun-Salju Putih]Hero yang berkuda DMG+9%",},
        [16] = {6,"Madu Autumn","[Madu Autumn]Hero yang berkuda Reduksi DMG+3%",},
        [17] = {6,"Wind-Madu Autumn","[Wind-Madu Autumn]Hero yang berkuda Reduksi DMG+6%",},
        [18] = {6,"Sun-Madu Autumn","[Sun-Madu Autumn]Hero yang berkuda Reduksi DMG+9%",},
        [19] = {7,"Giok Merah","[Giok Merah] Hero yang berkuda Bonus HP +3%",},
        [20] = {7,"Wind-Giok Merah","[Wind-Giok Merah]Hero yang berkuda Bonus HP +6%",},
        [21] = {7,"Sun-Giok Merah","[Sun-Giok Merah]Hero yang berkuda Bonus HP +9%",},
        [22] = {8,"Kuda Biru","[Kuda Biru]Hero yang berkuda Bonus KRIT Rate+3%",},
        [23] = {8,"Wind-Kuda Biru","[Wind-Kuda Biru]Hero yang berkuda Bonus KRIT Rate+6%",},
        [24] = {8,"Sun-Kuda Biru","[Sun-Kuda Biru]Hero yang berkuda Bonus KRIT Rate+9%",},
        [25] = {9,"Embun","[Embun Terbang]Konversi 20% DMG serangan terhadap musuh menjadi heal, heal sekutu HP terendah.",},
        [26] = {9,"Wind-Embun","[Wind-Embun]Konversi 30% DMG serangan terhadap musuh menjadi heal, heal sekutu HP terendah, dan ekstra regen 10% HP maks.",},
        [27] = {9,"Sun-Embun","[Sun-Embun]Konversi 30% DMG serangan terhadap musuh menjadi heal, heal sekutu HP terendah, dan ekstra regen 30% HP maks.",},
        [28] = {10,"Awan Hitam","[Awan Hitam]Bonus DMG serangan 16%.",},
        [29] = {10,"Wind-Awan Hitam","[Wind-Awan Hitam]Bonus 25% DMG serangan, saat membunuh target berpeluang 50% regen 1 Amarah.",},
        [30] = {10,"Sun-Awan Hitam","[Sun-Awan Hitam]Bonus DMG 25%, saat membunuh target regen 1 Amarah, dan saat regen Amarah berikutnya ekstra regen 1 Amarah",},
        [31] = {11,"Naga Api","[Naga Api]Efek heal meningkat 10%, heal target yang terkena Blok Heal akan menambahkan Perisai Hisap DMG durasi 1 ronde, menghisap 40% DMG",},
        [32] = {11,"Wind-Naga Api","[Wind-Naga Api]Efek heal meningkat 18%, heal target yang terkena Blok Heal akan menambahkan Perisai Hisap DMG durasi 1 ronde, menghisap 70% DMG",},
        [33] = {11,"Sun-Naga Api","[Sun-Naga Api]Efek heal meningkat 25%, heal target yang terkena Blok Heal akan menambahkan Perisai Hisap DMG durasi 1 ronde, menghisap 100% DMG",},
        [34] = {12,"Singa Giok","[Singa Giok]Dalam duel setiap ronde maksimal menerima 2 Reduksi Amarah",},
        [35] = {12,"Wind-Singa Giok","[Wind-Singa Giok]Sebelum duel maksimal menerima 1 Reduksi Amarah, dalam duel setiap ronde maksimal menerima 2 Reduksi Amarah",},
        [36] = {12,"Sun-Singa Giok","[Sun-Singa Giok]Sebelum duel maksimal menerima 1 Reduksi Amarah, dalam duel setiap ronde maksimal menerima 1 Reduksi Amarah",},
        [37] = {15,"Petir Hitam","[Petir Hitam]HP maks meningkat 15%. Saat pertama kali menerima DMG fatal dalam duel, tidak akan mati dan akan regen 20% HP maks",},
        [38] = {15,"Wind-Petir Hitam","[Wind-Petir Hitam]HP maks meningkat 30%. Saat pertama kali menerima DMG fatal dalam duel, tidak akan mati dan akan regen 40% HP maks, juga regen 2 Amarah",},
        [39] = {15,"Sun-Petir Hitam","[Sun-Petir Hitam]HP maks meningkat 45%. Saat pertama kali menerima DMG fatal dalam duel, tidak akan mati dan akan regen 60% HP maks, serta regen 4 Amarah",},
        [40] = {13,"Kilat","[Kilat] Silahkan menunggu",},
        [41] = {13,"Moon-Kilat","[Moon-Kilat] Silahkan menunggu",},
        [42] = {13,"Sky-Kilat","[Sky-Kilat]Silahkan menunggu",},
        [43] = {14,"Dilu Guntur","[Dilu Guntur]Silahkan menunggu",},
        [44] = {14,"Moon-Dilu Guntur","[Moon-Dilu Guntur]Silahkan menunggu",},
        [45] = {14,"Sky-Dilu Guntur","[Sky-Dilu Guntur]Silahkan menunggu",},
    }
}

return horse_star