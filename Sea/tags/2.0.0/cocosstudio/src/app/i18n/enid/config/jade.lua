--jade

local jade = {
    -- key
    __key_map = {
      id = 1,    --玉石id-int 
      equipment = 2,    --适用装备_math-string 
      name = 3,    --玉石名称-string 
      profile = 4,    --玉石短描述-string 
      description = 5,    --玉石详情-string 
      bag_description = 6,    --背包玉石描述-string 
      button_txt = 7,    --按钮文字-string 
    
    },
    -- data
    _data = {
        [1] = {1101,"601|501|409","Giok Bintang Naga - Serangan","ATK +5000","ATK +5000 (Protagonis setiap naik 1 level ATK ekstra +100)","ATK +5000","Inlay",},
        [2] = {1102,"601|501|409","Giok Bintang Naga - Heal","Bonus Heal +8%","Bonus heal +8% (berlaku bagi Hero tipe heal)","Bonus Heal +8%","Inlay",},
        [3] = {1103,"601|501|409","Giok Bintang Naga - KRIT","KRIT Rate +12%","KRIT Rate +12%","KRIT Rate +12%","Inlay",},
        [4] = {1104,"602|502|410","Giok Bintang Kura Hitam - PDEF","PDEF +2500","PDEF +2500 (Protagonis setiap meningkat 1 level PDEF ekstra +50)","PDEF +2500","Inlay",},
        [5] = {1105,"602|502|410","Giok Bintang Kura Hitam - Regen","Menerima Heal Rate +8%","Menerima Heal Rate +8% (berlaku bagi Hero tipe heal)","Menerima Heal Rate +8%","Inlay",},
        [6] = {1106,"602|502|410","Giok Bintang Kura Hitam - Resist","RES KRIT Rate +12%","RES KRIT Rate +12%","RES KRIT Rate +12%","Inlay",},
        [7] = {1107,"603|503|411","Giok Bintang Macan Putih - Sihir","MDEF +2500","MDEF +2500 (protagonis setiap naik 1 level MDEF ekstra +50)","MDEF +2500","Inlay",},
        [8] = {1108,"603|503|411","Giok Bintang Macan Putih - Regen","Menerima Heal Rate +8%","Menerima Heal Rate +8% (berlaku bagi Hero tipe heal)","Menerima Heal Rate +8%","Inlay",},
        [9] = {1109,"603|503|411","Giok Bintang Macan Putih - Hindar","Hindar Rate +12%","Hindar Rate +12%","Hindar Rate +12%","Inlay",},
        [10] = {1110,"604|504|412","Giok Bintang Suzaku - Darah","HP +37500","HP +37500 (Protagonis setiap naik 1 level bonus HP +750)","HP +37500","Inlay",},
        [11] = {1111,"604|504|412","Giok Bintang Suzaku - Heal","Bonus Heal +8%","Bonus heal +8% (berlaku bagi Hero tipe heal)","Bonus Heal +8%","Inlay",},
        [12] = {1112,"604|504|412","Giok Bintang Suzaku - HIT","HIT Rate +12%","HIT Rate +12%","HIT Rate +12%","Inlay",},
        [13] = {1201,"601|501|409","Giok Bulan Naga - Serangan","Bonus ATK +12%","Bonus ATK +12%","Bonus ATK +12%","Inlay",},
        [14] = {1202,"601|501|409","Giok Bulan Naga - Heal","Bonus Heal +12%","Bonus heal +12% (berlaku bagi Hero tipe heal)","Bonus Heal +12%","Inlay",},
        [15] = {1203,"601|501|409","Giok Bulan Naga - KRIT","KRIT Rate +22%","KRIT Rate +22%","KRIT Rate +22%","Inlay",},
        [16] = {1204,"602|502|410","Giok Bulan Kura Hitam - PDEF","Bonus PDEF +12%","Bonus PDEF +12%","Bonus PDEF +12%","Inlay",},
        [17] = {1205,"602|502|410","Giok Bulan Kura Hitam - Regen","Menerima Heal Rate +12%","Menerima Heal Rate +12% (berlaku bagi Hero tipe heal)","Menerima Heal Rate +12%","Inlay",},
        [18] = {1206,"602|502|410","Giok Bulan Kura Hitam - Resist","RES KRIT Rate +22%","RES KRIT Rate +22%","RES KRIT Rate +22%","Inlay",},
        [19] = {1207,"603|503|411","Giok Bulan Macan Putih -Sihir","Bonus MDEF +12%","Bonus MDEF +12%","Bonus MDEF +12%","Inlay",},
        [20] = {1208,"603|503|411","Giok Bulan Macan Putih -Regen","Menerima Heal Rate +12%","Menerima Heal Rate +12% (berlaku bagi Hero tipe heal)","Menerima Heal Rate +12%","Inlay",},
        [21] = {1209,"603|503|411","Giok Bulan Macan Putih -Hindar","Hindar Rate +22%","Hindar Rate +22%","Hindar Rate +22%","Inlay",},
        [22] = {1210,"604|504|412","Giok Bulan Suzaku - Darah","Bonus HP +12%","Bonus HP +12%","Bonus HP +12%","Inlay",},
        [23] = {1211,"604|504|412","Giok Bulan Suzaku - Heal","Bonus Heal +12%","Bonus heal +12% (berlaku bagi Hero tipe heal)","Bonus Heal +12%","Inlay",},
        [24] = {1212,"604|504|412","Giok Bulan Suzaku - HIT","HIT Rate +22%","HIT Rate +22%","HIT Rate +22%","Inlay",},
        [25] = {1301,"601|501|409","Giok Matahari Naga - DMG","Bonus DMG +18%","Bonus DMG +18%","Bonus DMG +18%","Inlay",},
        [26] = {1302,"601|501|409","Giok Matahari Naga - Heal","Bonus Heal +18%","Bonus heal +18% (berlaku bagi Hero tipe heal)","Bonus Heal +18%","Inlay",},
        [27] = {1303,"601|501|409","Giok Matahari Naga - KRIT","KRIT Rate +32%","KRIT Rate +32%","KRIT Rate +32%","Inlay",},
        [28] = {1304,"601|501|409","Giok Matahari Naga - Anti","PVP Bonus DMG +18%","PVP Bonus DMG +18%","PVP Bonus DMG +18%","Inlay",},
        [29] = {1305,"602|502|410","Giok Matahari Kura Hitam - Proteksi","Reduksi DMG +18%","Reduksi DMG +18%","Reduksi DMG +18%","Inlay",},
        [30] = {1306,"602|502|410","Giok Matahari Kura Hitam - Regen","Menerima Heal Rate +18%","Menerima Heal Rate +18% (berlaku bagi Hero tipe heal)","Menerima Heal Rate +18%","Inlay",},
        [31] = {1307,"602|502|410","Giok Matahari Kura Hitam - Resist","RES KRIT Rate +32%","RES KRIT Rate +32%","RES KRIT Rate +32%","Inlay",},
        [32] = {1308,"602|502|410","Giok Matahari Kura Hitam - Kokoh","PVP Reduksi DMG +18%","PVP Reduksi DMG +18%","PVP Reduksi DMG +18%","Inlay",},
        [33] = {1309,"603|503|411","Giok Matahari Macan Putih - Proteksi","Reduksi DMG +18%","Reduksi DMG +18%","Reduksi DMG +18%","Inlay",},
        [34] = {1310,"603|503|411","Giok Matahari Macan Putih - Regen","Menerima Heal Rate +18%","Menerima Heal Rate +18% (berlaku bagi Hero tipe heal)","Menerima Heal Rate +18%","Inlay",},
        [35] = {1311,"603|503|411","Giok Matahari Macan Putih - Hindar","Hindar Rate +32%","Hindar Rate +32%","Hindar Rate +32%","Inlay",},
        [36] = {1312,"603|503|411","Giok Matahari Macan Putih - Kokoh","PVP Reduksi DMG +18%","PVP Reduksi DMG +18%","PVP Reduksi DMG +18%","Inlay",},
        [37] = {1313,"604|504|412","Giok Matahari Suzaku - Luka","Bonus DMG +18%","Bonus DMG +18%","Bonus DMG +18%","Inlay",},
        [38] = {1314,"604|504|412","Giok Matahari Suzaku - Heal","Bonus Heal +18%","Bonus heal +18% (berlaku bagi Hero tipe heal)","Bonus Heal +18%","Inlay",},
        [39] = {1315,"604|504|412","Giok Matahari Suzaku - HIT","HIT Rate +32%","HIT Rate +32%","HIT Rate +32%","Inlay",},
        [40] = {1316,"604|504|412","Giok Matahari Suzaku - Anti","PVP Bonus DMG +18%","PVP Bonus DMG +18%","PVP Bonus DMG +18%","Inlay",},
        [41] = {2101,"601|501","Giok Lethal Naga - Kejahatan","Menyerang target yang terkena kontrol akan menambah DMG","Saat menyerang musuh yang terkena kontrol (Stun, Diam, Paralisis), menambah 15% DMG.","Menyerang target yang terkena kontrol akan menambah DMG","Inlay",},
        [42] = {2102,"601|501","Giok Lethal Naga - Haus Darah","Serangan skill bisa mengakibatkan ekstra DMG","Saat target serangan adalah 1/2/3/4/6, ekstra menambahkan DMG sebesar 15%/7.5%/5%/3.75%/2.5% HP maks target","Serangan skill bisa mengakibatkan ekstra DMG","Inlay",},
        [43] = {2103,"601|501","Giok Lethal Naga - Sehati","DMG atau Heal meningkat","Saat mengeluarkan skill atau serangan normal, DMG atau heal yang dihasilkan diri sendiri meningkat (setiap Hero sekutu dari faksi yang sama, DMG atau Heal +3.75%)","DMG atau Heal meningkat","Inlay",},
        [44] = {2104,"601|501","Giok Lethal Naga - Permohonan","Membunuh target bsia menghapus debuff","Setelah membunuh target, menghapus semua debuff yang diakibatkan target pada Hero sekutu (Terbakar, Racun, Stun, Diam, Paralisis)","Membunuh target bsia menghapus debuff","Inlay",},
        [45] = {2105,"602|502","Giok Vajra Kura Hitam - Bintang Hisap","Sebelum ronde dimulai mendapatkan Perisai Hisap DMG","Sebelum duel dimulai, memunculkan bagi diri sendiri Perisai Hisap DMG, menghisap DMG langsung sebesar 30% HP maks diri sendiri, durasi 1 ronde","Sebelum ronde dimulai mendapatkan Perisai Hisap DMG","Inlay",},
        [46] = {2106,"602|502","Giok Vajra Kura Hitam - Frost Perak","Setelah bergerak akan mendapatkan Perisai Hisap DMG","Setelah diri sendiri beraksi, memberikan perisai hisap DMG ke diri sendiri, menghisap DMG langsung sebesar 15% HP maks diri sendiri, durasi 1 ronde (setiap giliran akan muncul 1x)","Setelah bergerak akan mendapatkan Perisai Hisap DMG","Inlay",},
        [47] = {2107,"602|502","Giok Vraja Kura Hitam - Rekan","Saat mati maka sekutu mendapatkan perisai kebal","Saat mati, memberikan perisai kebal ke sekutu HP terendah, durasi 1 ronde (kekuatan perisai sama dengan perisai Zhang He terobosan +5)","Saat mati maka sekutu mendapatkan perisai kebal","Inlay",},
        [48] = {2108,"602|502","Giok Vraja Kura Hitam - Trauma","Saat menerima banyak DMG mendapatkan reduksi DMG","Saat menerima DMG langsung dari Hero, jika DMG melebihi 50% HP maks, maka reduksi 30% DMG tersebut","Saat menerima banyak DMG mendapatkan reduksi DMG","Inlay",},
        [49] = {2109,"603|503","Giok Azab Macan Putih - Refleksi","Saat ronde berakhir regen Amarah","Setelah giliran diri sendiri, regen 1 Amarah (hanya 1x)","Saat ronde berakhir regen Amarah","Inlay",},
        [50] = {2110,"603|503","Giok Azab Macan Putih - Frost Arwah","Sekutu mengeluarkan skill berpeluang regen Amarah","Setelah sekutu mengeluarkan skill, berpeluang 20% regen 1 Amarah diri sendiri","Sekutu mengeluarkan skill berpeluang regen Amarah","Inlay",},
        [51] = {2111,"603|503","Giok Azab Macan Putih - Depolarisasi","Setelah giliran berakhir berpeluang regen Amarah","Saat ronde berakhir, jika Amarah diri sendiri kurang dari 4, berpeluang 35% regen Amarah hingga 4","Setelah giliran berakhir berpeluang regen Amarah","Inlay",},
        [52] = {2112,"603|503","Giok Azab Macan Putih - Respek","Mengeluarkan skill berpeluang regen Amarah yang dikonsumsi","Setelah mengeluarkan skill, berpeluang 25% mendapatkan 50% Amarah yang dikonsumsi skill kali ini, maks tidak melebihi 4","Mengeluarkan skill berpeluang regen Amarah yang dikonsumsi","Inlay",},
        [53] = {2113,"604|504","Giok Aura Suzaku - Origin","Skill berpeluang menambah resist terhadap Kontrol","Skill berpeluang 50% untuk menurunkan peluang terkena efek kontrol (Stun, Diam, Paralisis) terhadap sekutu di sekitar sebesar 35%, durasi 1 ronde","Skill berpeluang menambah resist terhadap Kontrol","Inlay",},
        [54] = {2114,"604|504","Giok Aura Suzaku - Fondasi","Saat diri sendiri regen Amarah akan regen HP","Saat regen Amarah, juga regen HP sebesar 15% HP","Saat diri sendiri regen Amarah akan regen HP","Inlay",},
        [55] = {2115,"604|504","Giok Aura Suzaku - Konsentrasi","Saat diri sendiri belum beraksi bisa mendapatkan Perisai Anti Kontrol","Saat ronde berakhir, jika ronde ini tidak beraksi, maka mendapatkan 1 perisai Imun Kontrol (Stun, Diam, Paralisis), durasi 1 ronde","Saat diri sendiri belum beraksi bisa mendapatkan Perisai Anti Kontrol","Inlay",},
        [56] = {2116,"604|504","Giok Aura Suzaku - Hati Murni","Sebelum ronde dimulai berpeluang menghapus debuff diri sendiri","Sebelum giliran diri sendiri dimulai, berpeluang 25% menghapus semua debuff diri sendiri (Terbakar, Racun, Stun, Diam, Paralisis)","Sebelum ronde dimulai berpeluang menghapus debuff diri sendiri","Inlay",},
    }
}

return jade