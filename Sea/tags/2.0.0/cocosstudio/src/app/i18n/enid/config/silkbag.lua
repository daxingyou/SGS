--silkbag

local silkbag = {
    -- key
    __key_map = {
      id = 1,    --锦囊id-int 
      show_day = 2,    --图鉴显示天数-int 
      hero = 3,    --适用武将_math-string 
      is_fight = 4,    --无差别竞技里可用赛区_math-int 
      name = 5,    --锦囊名称-string 
      profile = 6,    --锦囊短描述-string 
      description = 7,    --锦囊详情-string 
      bag_description = 8,    --背包锦囊描述-string 
      button_txt = 9,    --按钮文字-string 
    
    },
    -- data
    _data = {
        [1] = {1101,0,"999",0,"Insignia Guan Yinping","ATK +1000","ATK +1000 (Protagonis setiap naik 1 level ATK ekstra +40)","ATK +1000 (setiap level +40)","Pergi Pakai",},
        [2] = {1102,0,"999",0,"Insignia Zhang Xingcai","HP +7500","HP +7500 (Protagonis setiap naik 1 level bonus HP +300)","HP +7500 (tiap level +300)","Pergi Pakai",},
        [3] = {1103,0,"999",0,"Insignia Zhou Tai","DEF +500","DEF +500 (Protagonis setiap naik 1 level DEF ekstra +20)","DEF +500 (setiap level +20)","Pergi Pakai",},
        [4] = {1104,0,"999",0,"Insignia Lu Lingju","KRIT Rate +8%","KRIT Rate +8%","KRIT Rate +8%","Pergi Pakai",},
        [5] = {1105,0,"999",0,"Insignia Huang Gai","RES KRIT Rate +8%","RES KRIT Rate +8%","RES KRIT Rate +8%","Pergi Pakai",},
        [6] = {1106,0,"999",0,"Insignia Zhang Rang","DMG +5%","DMG +5%","DMG +5%","Pergi Pakai",},
        [7] = {1107,0,"999",0,"Insignia Cai Wenji","Reduksi DMG +5%","Reduksi DMG +5%","Reduksi DMG +5%","Pergi Pakai",},
        [8] = {1108,0,"999",0,"Insignia Yu Jin","KRIT DMG +5%","KRIT DMG +5%","KRIT DMG +5%","Pergi Pakai",},
        [9] = {1202,0,"102|202|302|402|216",1,"Insignia Liu Bei","Heal skill meningkat","Hero tipe Heal saat mengeluarkan skill, heal yang dihasilkan terhadap Hero sekutu HP terendah meningkat 55%.","Heal skill bertambah","Pergi Pakai",},
        [10] = {1203,0,"303|305|311|319|313",1,"Insignia Lu Xun","Peluang Terbakar meningkat","Target serangan semakin sedikit, peluang terbakar semakin tinggi, maks terhadap 1 target peluang terbakar meningkat 60%.","Peluang Terbakar bertambah","Pergi Pakai",},
        [11] = {1204,0,"212|312|404|408|409|412|413|414|415|416|417|419",1,"Insignia Gongsun Zan","Menyerang unit target unit menurunkan 1 Amarah","Saat menyerang target unit ekstra menurunkan 1 Amarah.","Menyerang unit musuh menurunkan 1 Amarah","Pergi Pakai",},
        [12] = {1205,0,"999",1,"Insignia Guan Yu","Meningkatkan 1 Amarah awal","Amarah awal bertambah 1","Menambah 1 Amarah awal","Pergi Pakai",},
        [13] = {1207,0,"118|207|215|405",1,"Insignia Ma Chao","Meningkatkan reduksi DMG perisai","Semakin sedikit target proteksi, efek reduksi DMG semakin tinggi, maks bisa reduksi 36% DMG. (hanya berlaku bagi Hero dengan efek perisai reduksi DMG)","Meningkatkan reduksi DMG perisai","Pergi Pakai",},
        [14] = {1208,0,"410|407",1,"Insignia Jia Xu","Peluang racun meningkat","Semakin sedikit target serangan, peluang racun semakin tinggi, maksimal meningkat 60%.","Peluang Racun bertambah","Pergi Pakai",},
        [15] = {1209,0,"106|116|203|210|212|214|307|312|317|401|408|415",1,"Insignia Xu Shu","Peluang stun meningkat","Semakin sedikit target, semakin tinggi peluang Stun, maks meningkatkan 48% peluang Stun. (Hanya berlaku bagi Hero dengan efek Stun)","Peluang stun bertambah","Pergi Pakai",},
        [16] = {1211,0,"410|407",1,"Insignia Yu Ji","DMG racun meningkat","Semakin sedikit target, DMG Racun dari skill meningkat semakin tinggi, maks terhadap 1 target meningkat 60% DMG Racun","DMG racun meningkat","Pergi Pakai",},
        [17] = {1212,0,"219|304|411",1,"Insignia Xiao Qiao","Peluang paralisis meningkat","Semakin sedikit musuh, peluang paralisis meningkat, maks terhadap 1 target 72% peluang paralisis. (hanya berlaku bagi Hero dengan efek paralisis)","Peluang paralisis meningkat","Pergi Pakai",},
        [18] = {1213,0,"104|115|409|419",1,"Insignia Guo Jia","Peluang Diam meningkat","Semakin sedikit target, peluang Diam semakin tinggi, maksimal terhadap 1 target meningkat 72%. (hanya berlaku bagi Hero dengan efek Diam)","Peluang Diam meningkat","Pergi Pakai",},
        [19] = {1214,0,"105",1,"Insignia Xiahou Dun","Rasio refleksi DMG meningkat","Refleksi DMG bertambah 30%. (Hanya efektif bagi Hero dengan efek refleksi)","Rasio refleksi DMG meningkat","Pergi Pakai",},
        [20] = {1215,0,"999",1,"Insignia Zhang Fei","ATK +3000","ATK +3000 (Protagonis setiap naik 1 level ATK ekstra +120)","ATK +3000 (setiap level +120)","Pergi Pakai",},
        [21] = {1216,0,"999",1,"Insignia Pang Tong","HP +22500","HP +22500 (Protagonis setiap naik 1 level bonus HP +900)","HP +22500 (tiap level +900)","Pergi Pakai",},
        [22] = {1217,0,"999",1,"Insignia Sun Jian","DEF +1500","DEF +1500 (Protagonis setiap naik 1 level DEF ekstra +60)","DEF +1500 (setiap level +60)","Pergi Pakai",},
        [23] = {1218,0,"999",1,"Insignia Yuan Shu","KRIT Rate +20%","KRIT Rate +20%","KRIT Rate +20%","Pergi Pakai",},
        [24] = {1219,0,"999",1,"Insignia Huang Yueying","RES KRIT Rate +20%","RES KRIT Rate +20%","RES KRIT Rate +20%","Pergi Pakai",},
        [25] = {1220,0,"999",1,"Insignia Dian Wei","DMG +12%","DMG +12%","DMG +12%","Pergi Pakai",},
        [26] = {1221,0,"999",1,"Insignia Dong Zhuo","Reduksi DMG +12%","Reduksi DMG +12%","Reduksi DMG +12%","Pergi Pakai",},
        [27] = {1222,0,"999",1,"Insignia Sun Shangxiang","KRIT DMG +12%","KRIT DMG +12%","KRIT DMG +12%","Pergi Pakai",},
        [28] = {1223,0,"1|2|3|4|5|11|12|13|14|15|101|103|104|105|106|107|108|109|110|111|112|113|114|115|116|117|118|119|201|203|204|205|206|207|208|209|210|211|212|213|214|215|217|218|219|301|303|304|305|306|307|308|309|310|311|312|313|314|315|316|317|318|319|401|403|404|405|406|407|408|409|410|411|412|413|414|415|416|417|418|419",1,"Insignia Xu Chu","Membunuh target regen 1 Amarah diri sendiri","Membunuh target akan regen 1 Amarah.","Membunuh target regen 1 Amarah diri sendiri","Pergi Pakai",},
        [29] = {1224,7,"103|112|117|204|211|404|412",1,"Insignia Nyonya Zhen","Rasio heal konversi DMG skill meningkat","Rasio konversi DMG Skill menjadi HP untuk heal Hero dengan HP terendah meningkat 18%. (Hanya efektif pada Hero Support dengan skill konversi heal)","Rasio heal konversi DMG skill meningkat","Pergi Pakai",},
        [30] = {1225,7,"407|410",1,"Insignia Hua Tuo","DMG Racun regen HP diri sendiri","Konversi 10% DMG untuk heal diri sendiri","DMG Racun regen HP diri sendiri","Pergi Pakai",},
        [31] = {1226,7,"102|202|302|402|216",1,"Insignia Da Qiao","Efek heal meningkat dan ekstra Perisai Reduksi DMG","Efek Heal skill meningkat 25%, juga menambahkan 1 Perisai DMG ke target, semua DMG yang diterima menurun 12%, durasi 1 ronde","Efek Heal meningkat dan ekstra perisai","Pergi Pakai",},
        [32] = {1227,7,"999",1,"Insignia Diao Chan","Menurunkan peluang diri sendiri dikontrol","Peluang efek kontrol yang diterima (Paralisis, Diam, Stun) menurun 35%","Menurunkan peluang diri sendiri dikontrol","Pergi Pakai",},
        [33] = {1301,7,"999",1,"Insignia Zhao Yun","Serangan normal pasti kritikal","Serangan normal pasti kritikal. (termasuk Hero tipe heal)","Serangan normal pasti kritikal","Pergi Pakai",},
        [34] = {1303,7,"303|305|311|319|313",1,"Insignia Zhou Yu","Durasi Terbakar bertambah","Secara manual mengakibatkan Terbakar ekstra 1 ronde.","Status Terbakar ekstra bertambah 1 ronde","Pergi Pakai",},
        [35] = {1304,7,"410|407",1,"Insignia Zuo Ci","Racun ekstra blok heal","Racun ekstra blok heal, Hero yang terkena Racun tidak bisa menerima Heal.","Racun ekstra blok heal","Pergi Pakai",},
        [36] = {1308,7,"1|2|3|4|5|11|12|13|14|15|101|103|104|105|106|107|108|109|110|111|112|113|114|115|116|117|118|119|201|203|204|205|206|207|208|209|210|211|212|213|214|215|217|218|219|301|303|304|305|306|307|308|309|310|311|312|313|314|315|316|317|318|319|401|403|404|405|406|407|408|409|410|411|412|413|414|415|416|417|418|419",1,"Insignia Cao Cao","Menghapus efek Kebal Hero musuh","Semakin sedikit target, semakin tinggi peluang menghapus Kebal musuh, maksimal meningkat 100% terhadap 1 target.","Menghapus efek Kebal Hero musuh","Pergi Pakai",},
        [37] = {1302,7,"106|210|406",1,"Insignia God-Cao ren","Menyerang musuh horizontal menurunkan 1 Amarah","Saat menyerang musuh horizontal, ekstramenurunkan 1 Amarah target. (hanya berlaku bagi Hero dengan reduksi DMG horizontal)","Menyerang target horizontal menurunkan 1 Amarah","Pergi Pakai",},
        [38] = {1309,7,"303|305|311|319|313",1,"God-Insignia Lu Xun","Hero yang Terbakar tidak bisa Kebal","Hero yang terbakar tidak bisa mendapatkan efek Perisai Kebal dan Hisap HP","Hero yang terbakar tidak bisa mendapatkan efek kebal","Pergi Pakai",},
        [39] = {1310,7,"999",1,"God-Insignia Huang Yueying","Ronde awal imun kontrol","Ronde awal imun efek Stun, Diam, Paralisis","Ronde awal imun efek Stun, Diam, Paralisis","Pergi Pakai",},
        [40] = {1311,7,"1|2|3|4|5|11|12|13|14|15|101|103|104|105|106|107|108|109|110|111|112|113|114|115|116|117|118|119|201|203|204|205|206|207|208|209|210|211|212|213|214|215|217|218|219|301|303|304|305|306|307|308|309|310|311|312|313|314|315|316|317|318|319|401|403|404|405|406|407|408|409|410|411|412|413|414|415|416|417|418|419",1,"God-Insignia Hua Tuo","Konversi DMG skill menjadi heal.","Konversi 18% DMG skill menjadi HP, heal diri sendiri","Konversi DMG skill untuk heal diri sendiri","Pergi Pakai",},
        [41] = {1312,7,"999",1,"Insignia Sima Yi","Mengonsumsi semua Amarah menambah DMG skill","Saat Amarah Hero kurang dari 7, tidak akan mengeluarkan skill; Mengeluarkan skill mengonsumsi semua Amarah saat ini, saat lebih Amarah dari 4, setiap surplus 1 Amarah akan menambah 15% DMG skill","Mengonsumsi semua Amarah menambah DMG skill","Pergi Pakai",},
        [42] = {1305,7,"410|407",1,"God-Insignia Jia Xu","Durasi Racun bertambah","Racun skill bertambah 1 ronde.","Racun ekstra 1 ronde","Pergi Pakai",},
        [43] = {1313,7,"102|202|302|402|216",1,"God-Insignia Xun Yu","Heal skill meningkat","Saat Hero tipe heal mengeluarkan skill, heal terhadap 3 sekutu HP terendah meningkat sebesar 32% ATK.","Heal skill meningkat","Pergi Pakai",},
        [44] = {1314,7,"999",1,"Insignia Sumpah Saudara","Berbagi DMG yang diterima","DMG yang diterima menurun 12%, juga membagikan rata DMG non fatal yang diterima kepada 2 Hero sekutu HP tertinggi. (Hero yang dibagikan DMG sekalipun sedang Kebal juga akan menerima DMG)","Berbagi DMG yang diterima","Pergi Pakai",},
        [45] = {1315,7,"303|305|311|319|313",1,"God-Insignia Taishi Ci","Peluang Terbakar meningkat drastis","Target serangan semakin sedikit, peluang terbakar semakin tinggi, maks terhadap 1 target peluang terbakar meningkat 96%.","Peluang Terbakar meningkat drastis","Pergi Pakai",},
        [46] = {1316,21,"998",0,"Insignia Yang","Saat ronde berakhir akan regen 1 Amarah Insignia Yin","Setiap selesai giliran pada setiap ronde, Hero yang memakai Yin akan ekstra mendapatkan 1 Amarah. (Setiap formasi terbatas 1 Hero pria yang memakainya)","Saat ronde berakhir akan regen 1 Amarah Insignia Yin","Pergi Pakai",},
        [47] = {1317,21,"997",0,"Insignia Yin","Saat ronde berakhir regen 1 Amarah Insignia Yang","Setiap selesai giliran pada setiap ronde, Hero yang memakai Yang akan ekstra mendapatkan 1 Amarah. (Setiap formasi terbatas 1 Hero wanita yang memakainya)","Saat ronde berakhir regen 1 Amarah Insignia Yang","Pergi Pakai",},
        [48] = {1318,21,"205|213|308|310|316|413",1,"Insignia Solo Ribuan Mil","Menyerang Hero musuh HP terendah","Semua serangan Hero target tunggal akan prioritas menerang Hero musuh HP terendah.","Menyerang Hero musuh HP terendah","Pergi Pakai",},
        [49] = {1319,21,"205|213|308|310|316|413",1,"Insignia Kuat Luar Biasa","Membunuh target ekstra 1x serangan Skill","Hero DPS tunggal setelah membunuh target akan ekstra 1x skill, terhadap unit musuh mengakibatkan 175% P-DMG. (skill ekstra tidak mengonsumsi Amarah, tidak memicu karakteristik apapun)","Membunuh target ekstra 1x serangan Skill","Pergi Pakai",},
        [50] = {1401,21,"107|108|109|113|114|201|206|208|209|217|218|301|306|318|406|407|414|416",2,"Insignia Nova","Rasio DMG yang dibagikan menurun","Hero DPS horizontal, baris depan, baris belakang, DMG yang dihasilkan terhadap musuh jika dibagi rata, maka rasio pembagian menurun 50%","Hero DPS horizontal, baris depan, baris belakang, DMG yang dihasilkan terhadap musuh jika dibagi rata, maka rasio pembagian menurun 50%","Pergi Pakai",},
        [51] = {1402,21,"101|107|108|109|111|113|114|201|205|206|208|209|217|218|301|306|308|310|316|318|403|406|407|410|413|414|416",2,"Insignia Serigala","Membunuh target mendapatkan Amarah","Saat skill langsung membunuh musuh, mendapatkan semua Amarah yang tersisa (digunakan Hero DPS)","Saat membunuh target, mendapatkan sisa Amarah target (khusus Hero DPS)","Pergi Pakai",},
        [52] = {1403,21,"999",2,"Insignia Legenda - Guan Yu","Amarah awal bertambah 2","Amarah awal bertambah 2","Amarah awal bertambah 2","Pergi Pakai",},
        [53] = {1404,999,"105|119|207|215|309|314|405|418",0,"Insignia Pantang Mundur","DMG yang diterima tiap ronde memiliki limit","Setiap ronde maksimal menerima DMG sebesar 50% HP maks (DMG berasal dari DMG langsung Hero)","DMG yang diterima tiap ronde memiliki limit","Pergi Pakai",},
        [54] = {1405,999,"105|119|207|215|309|314|405|418",0,"Insignia Berlayar Bersama","Menghisap DMG Hero sekutu faksi yang sama","Hero faksi yang sama saat menerima DMG langsung dari Hero musuh, akan transfer 50% DMG ke Hero yang memakai Insignia tersebut (tidak memicu karakteristik, kebal terpengaruh kebal)","Menghisap DMG Hero sekutu faksi yang sama","Pergi Pakai",},
    }
}

return silkbag