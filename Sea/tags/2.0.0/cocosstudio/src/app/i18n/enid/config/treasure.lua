--treasure

local treasure = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      is_work = 2,    --生效-int 
      name = 3,    --宝物名称-string 
      description = 4,    --宝物描述-string 
    
    },
    -- data
    _data = {
        [1] = {101,1,"Wuzi","Hero terkenal pada masa perang. Wu Qi adalah murid perguruan Kong Hu Cu, mengetahui seni perang, hukum, agama, bersama Sun Zi bernama Sun Wu.",},
        [2] = {102,1,"Tiga Strategi","Nama asli Tiga Strategi Huang Shigong, setelah digabungkan dengan pemikiran banyak orang, Buku perang untuk strategi memerintah negara dan menggunakan pasukan.",},
        [3] = {201,1,"Guiguzi","Guiguzi diberi gelar orang bertalenta yang abadi, kemampuannya sangat hebat, tiada yang bisa melampaui, karya Guiguzi Empat belas bab Seni Perang",},
        [4] = {202,1,"Seni Melarikan Diri","Ilmu Kebal adalah ilmu rahasia Taoisme yang tidak diajarkan kepada orang luar, adalah ilmu mendapatkan segalanya dari alam semesta, Menurut legenda Zuo Ci pernah mempelajari ilmu ini.",},
        [5] = {203,1,"Metode Sima","Menurut legenda adalah hasil karya Jiang Taigong disaat negara damai, dan itu adalah buku perang tertua yang masih ada di Tiongkok.",},
        [6] = {301,1,"Seni Perang","Buku Perang yang paling terkenal, dibuat di Negara Sun Wu pada saat negara damai, luas dan mendalam, itu dikenal sebagai Kitab Suci Seni Perang.",},
        [7] = {302,1,"Buku Marquis","Dinamakan juga Taman Jenderal, Zhuge Liang sangat hebat menggunakan pasukan, buku ini mencatat pemikiran Zhuge Liang tentang seni perang, mendiskusikan jalan sebagai Jenderal.",},
        [8] = {303,1,"Buku Mengde","Cao Cao jatuh bangun separuh hidupnya, berkesimpulan dan berkarya berdasarkan pengalaman orang terdahulu, menghasilkan buku Mengde ini.",},
        [9] = {304,1,"Seni Kedamaian","Menurut legenda Zhang Jiao naik gunung mencari obat, bertemu Dewa Tua Nan Hua, menerima Seni kedamaian, kemudian mendirikan Ajaran kedamaian.",},
        [10] = {401,1,"Dunia - Seni Perang","Buku Perang yang paling terkenal, dibuat di Negara Sun Wu pada saat negara damai, luas dan mendalam, itu dikenal sebagai Kitab Suci Seni Perang.",},
        [11] = {402,1,"Dunia - Buku Marquis","Dinamakan juga Taman Jenderal, Zhuge Liang sangat hebat menggunakan pasukan, buku ini mencatat pemikiran Zhuge Liang tentang seni perang, mendiskusikan jalan sebagai Jenderal.",},
        [12] = {403,1,"Dunia - Buku Mengde","Cao Cao jatuh bangun separuh hidupnya, berkesimpulan dan berkarya berdasarkan pengalaman orang terdahulu, menghasilkan buku Mengde ini.",},
        [13] = {404,1,"Dunia - Seni Kedamaian","Menurut legenda Zhang Jiao naik gunung mencari obat, bertemu Dewa Tua Nan Hua, menerima Seni kedamaian, kemudian mendirikan Ajaran kedamaian.",},
        [14] = {111,1,"Simbol Sapi","Xu Chu memiliki keberanian menarik balik ekor sapi, Untuknya Cao Cao khusus membuat Simbol Pasukan ini.",},
        [15] = {112,1,"Simbol Mustang","Simbol pasukan Gongsun Zan Jenderal Baima, tidak tahu keberadaannya setelah perang Yijing.",},
        [16] = {211,1,"Simbol Serigala","Karena Sima Yi sangat waspada, oleh karena itu khusus dibuat jimat ini, jimat ini terus menemati Sima Yi, berprestasi saat beberapa kali penyerangan.",},
        [17] = {212,1,"Simbol Leopard","Kecepatan super, Hero Xiahou Yuan memegang Simbol Leopard, dipanggil dengan sebutan Leopard kilat.",},
        [18] = {213,1,"Simbol Ular","Fa Zheng jago strategi, memegang stempel Ular Terbang, membantu Liu Bei merebut Hanzhong, sangat dihargai dan dipercayai Liu Bei.",},
        [19] = {311,1,"Simbol Naga","Orang Huainan tercatat dalam 3 gulungan : Dewa yang berharga, tidak lebih berharga dari naga Hijau. Stempel Naga Hijau adalah simbol pasukan Jenderal Guan Yu.",},
        [20] = {312,1,"Simbol Macan Putih","Macan Putih adalah simbol keadilan, keberanian dan kewibawaan, menurut info Ma Chao dari Xiliang pernah membawa Simbol Pasukan itu.",},
        [21] = {313,1,"Simbol Suzaku","Suzaku adalah salah satu dari 4 Hewan Surga, mewakili mitologi dan astronomi. Simbol Pasukan yang pernah dimiliki Zhou Yu, terakhir tidak tahu berada dimana.",},
        [22] = {314,1,"Simbol Kura Hitam","Kura penghancur, adalah gabungan kura dan ular, hidup abadi, dipanggil Xuan Tian Shang Di. Menurut legenda adalah simbol pasukan untuk memimpin pasukan dewa milik Jenderal terkenal Zuo Ci.",},
        [23] = {411,1,"Dunia - Simbol Naga","Orang Huainan tercatat dalam 3 gulungan : Dewa yang berharga, tidak lebih berharga dari naga Hijau. Stempel Naga Hijau adalah simbol pasukan Jenderal Guan Yu.",},
        [24] = {412,1,"Dunia - Simbol Macan Putih","Macan Putih adalah simbol keadilan, keberanian dan kewibawaan, menurut info Ma Chao dari Xiliang pernah membawa Simbol Pasukan itu.",},
        [25] = {413,1,"Dunia - Simbol Suzaku","Suzaku adalah salah satu dari 4 Hewan Surga, mewakili mitologi dan astronomi. Simbol Pasukan yang pernah dimiliki Zhou Yu, terakhir tidak tahu berada dimana.",},
        [26] = {414,1,"Dunia - Simbol Kura Hitam","Kura penghancur, adalah gabungan kura dan ular, hidup abadi, dipanggil Xuan Tian Shang Di. Menurut legenda adalah simbol pasukan untuk memimpin pasukan dewa milik Jenderal terkenal Zuo Ci.",},
    }
}

return treasure