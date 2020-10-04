--play_horse_hero

local play_horse_hero = {
    -- key
    __key_map = {
      id = 1,    --序号-int 
      text_3 = 2,    --文本3-string 
      text_4 = 3,    --文本4-string 
      text_1 = 4,    --文本1-string 
      text_2 = 5,    --文本2-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Kami keluarga Sima, tidak akan kalah dalam kompetisi ini.","Siapa yang berani lari di depanku, aku akan melayaninya dengan Tongkat Pemenggal.","Belajar beladiri dapat meningkatkan keberanian, dengan cerdas menguasai dunia, kaki panjang pasti bisa menang lari!","Kemarin malam aku mengamati situasi langit, kemudian meramal, Juara I hari ini pasti menjadi milikku.",},
        [2] = {2,"Percaya tidak, walau aku berlari membawa Palu besar, juga akan menang darimu!","Aku menarik mundur sapi dengan satu tangan melangkah beratus langkah, hanya kompetisi lari bukanlah apa-apa.","Jangan lihat aku gemuk, saat aku berguling sangatlah cepat!","Belum pernah lihat orang gendut yang berlari cepat, sebentar lagi biar kau lihat.",},
        [3] = {3,"Aku sudah jago menggunakan kondisi arena, topografi arena kompetisi sudah aku pahami sepenuhnya.","Demi kompetisi ini aku membuat pakaian baru.","Biar kalian lihat pria paling cantik, langkah yang paling Fleksibel.","Aku ada perisai kebal, jangan berharap bisa menarik bajuku pada saat lomba lari.",},
        [4] = {4,"Dibawah pinggangku semuanya adalah kaki, kalau berlari mana mungkin bisa lambat!","Kalau memang pria, biarkan aku lari dua kaki duluan.","Aku seorang wanita mengikuti kompetisi, semuanya mengalah yah.","Beraninya lari lebih cepat dariku, layani dengan cambuk.",},
        [5] = {5,"Dari kecil aku bolak balik ke pasar, kakiku sangatlah kuat.","Kubisikkan kepadamu, tiap kali Yu Jin selalu kalah lari dariku.","Jangan lihat aku pendek, kalau berlari tidak akan kalah darimu.","diantara 5 Jenderal Hebat aku yang larinya paling cepat.",},
        [6] = {6,"Ayah sangat memanjakanku, aku tidak akan membuat malu ayah.","Kemarin aku masih berlatih lari dengan kakak Cao Pi, aku tidaklah lebih lambat dari dia.","Berat atau ringan, akan tahu setelah ditimbang, siapa cepat siapa lambat, sekali bertanding pasti akan tahu.","Berlari dapat membantu kesehatan, tidak mudah sakit.",},
        [7] = {7,"Nyonya Bai walau muda, tapi tidak mempesona seperti aku!","Datang tanpa penyesalan","Suruh Sima Yi minggir! Hari ini aku akan mendapatkan Juara I!","Menangkan kompetisi ini, biar Sima Yi mengubah penilaiannya!",},
        [8] = {8,"Sebentar lagi biarkan kalian lihat kecepatanku yang seperti angin.","Yue Jin bilang aku lari tidak secepat dia, aku hajar dia.","Bagaimana dengan julukan Secepat Angin, jika dapat menang mulai sekarang aku akan menggunakan julukan ini.","Jangan dengarkan Yue Jin, diantara 5 Jenderal Hebat untuk lari, akulah yang paling cepat.",},
        [9] = {9,"Sudah lama tidak membunuh, pedangku hampir berkarat!","Selesai kompetisi, aku akan meminta perintah untuk membunuh!","Aku adalah pembunuh, adalah yang tercepat!","Lari mendapat Juara I, mendapatkan hadiah, aku akan pergi membeli Gear baru!",},
        [10] = {10,"Mengetahui hubungan percintaan, baru bisa mengetahui kenikmatan hidup.","Kompetisi sangat tidak menarik, bagaimana kalau selesai kompetisi bermain denganku.","Apa Meng De pulang melihatku bertanding?","Tubuhku lemah, tidak jago dalam hal arena ini.",},
        [11] = {11,"Aku menggendong anak juga bisa menang dari kalian.","Hati yang tulus menenangkan dunia, kaki berangin mendapatkan juara I!","Masuk dan keluar dengan leluasa, dilihat dari kecepatan akulah yang paling hebat!","Semuanya ingatlah, aku adalah orang yang dipanggil Jenderal Changsheng.",},
        [12] = {12,"Memenggal Hua Xiong sebelum arak dingin bukan lah apa-apa, tunggu aku mendapat Juara I sebelum arak dingin.","Aku adalah orang yang menunggangi kuda Chitu, bagaimana bisa lambat!","Sebagai pimpinan 5 Jenderal Pemberani, Dewa beladiri, akan memalukan kalau tidak mendapatkan Juara I.","Dulu karena melakukan kesalahan pergi sampai ke Youzhou wilayah Zhuojun, hanya karena lari dengan cepat.",},
        [13] = {13,"Siapa bilang Algojo tidak bisa mendapat juara I, hari ini biar kalian membuka lebar mata kalian.","Aku Zhang Fei hari ini menginginkan Juara I, siapapun jangan menghalangi!","Sekali aku berteriak akan menjatuhkanmu.","Tunggu aku minum dulu arak keras, baru berlomba lari denganmu.",},
        [14] = {14,"Dengarkan dengan serius, di antara 5 Jenderal Pemberani akulah yang paling bisa lari.","Kau lihat aku bermarga Ma, pasti akan tahu kalo aku lari secepat kuda.","Dari kecil adalah pria berkuda, kuda yang terbang.","Sudah datangkah Huang Zhong, cepat gunakan teknik kombinasi untuk menembak keluar aku!",},
        [15] = {15,"Jangan bicarakan tujuh kali penangkapan Meng Huo, panggil keluar Zhuge Liang, kita bersaing di arena.","Untuk strategi mungkin tidak sehebat penasihat, tapi untuk kompetisi lari belum pasti!","Diantara orang-orang satu suku, aku yang paling cepat larinya.","Siapa yang mengaku sebagai orang Barbarian Selatan? jika hebat keluar dan duel denganku!",},
        [16] = {16,"Dari kecil aku berburu kelinci dan babi di gunung, Kemampuanku sangat lincah.","Suruh Zhuge Liang keluar, aku mau membalaskan dendam tertangkap dan dilepas 7 kali suamiku di arena ini.","Lihat ekorku, seksikan!","Walau sebagai wanita, tapi aku tidak akan kalah cepat dari kalian.",},
        [17] = {17,"Kebajikan mengatur dunia, pentingnya kompetisi ada di ikut serta.","Cepat mulai kompetisi, setelah selesai aku mau pergi memeluk panda.","Saling bunuh benar-benar membosankan, lebih menarik berlomba lari.","Aku melempar panda melewati garis, dapat dihitung menangkah aku?",},
        [18] = {18,"Em, banyak orang yang bertanding, sedikit menakutkan ya.","Banyak sekali orang, hati-hati terkena pitam panas.","Orang yang menonton kompetisi banyak sekali, sangat malu!","Tuanku, Tuanku, Untukmu Xing Cai pasti bisa menjadi Juara I kompetisi lari!",},
        [19] = {19,"Pada suatu hari aku akan melampaui ayahku, mulai dari mendapatkan juara I pada hari ini!","Hari ini aku harus juara I lari, untuk membuat ayah bangga.","Ayah harimau tidak mungkin ada putri seperti anjing, aku nona ketiga Guan tidaklah lemah.","Aku Guan Yinping cantik dan pintar, jago ilmu beladiri, aku akan membawa Juara I untuk ayah.",},
        [20] = {20,"Masih hitungan mundur? bisa lebih cepat gak?","Aku akan membuktikan diriku dengan mendapat Juara I!","Aku jago berkuda dan memanah sejak kecil, berlari tidak akan menyulitkanku!","Tuanku, aku pasti akan mendapatkan juara I untukmu!",},
        [21] = {21,"Aku Sun Ce, hari ini akan merebut Juara I!","Anak-anak Jiangdong, lihatlah baik-baik!","Aku adalah Sun Ce Tirani Jiangdong!","Tidak ada yang ditakutkan oleh orang Jiangdong!",},
        [22] = {22,"Menang dari kompetisi tapi kalah di kehidupan, kalian memangnya rela menang dariku?","Nanti bantu aku lihat, apa aku kelihatan bagus saat berlari.","Matahari begitu terik, bagaimana kalau sampai jadi hitam? Untung ada Payung Teratai yang melindungiku!","Sun Ce di mana, padahal sudah berjanji untuk memberiku semangat.",},
        [23] = {23,"Hihi, kipas emasku pasti dapat membantuku mendapatkan Juara I!","Menang kalah tidak penting, yang penting senang!","Huh, jangan anggap remeh wanita!","Zhou Yu berkata menang atau kalah tidak penting, yang penting senang!",},
        [24] = {24,"Dibawah kemarahanku Jin Fan, kalian adalah sampah!","Aku Gan Ning akan menuliskan namaku sendiri di Tropi Juara I!","Disini adalah wilayahku Gan Ning!","Di wilayahku, aku pasti bisa mendapatkan juara I!",},
        [25] = {25,"Walau kakak di arena, aku tidak akan mengalah! Harus berusaha mati-matian di kompetisi.","Jika aku berlari terlalu cepat, apa Liu Bei dapat mengejarku.","gagah berani dan heroik, wanita tidak kalah dari Pria!","Maju Ke medan perang bukan apa-apa, apalagi anya kompetisi kecil.",},
        [26] = {26,"Siapa yang menganggap remeh aku karena muda, biar kau lihat aku berlari mendapat Juara I !","Haha, hari ini aku pasti Juara I!","Memainkan musik suaranya bisa dikecilkan, Telingaku sudah mau pecah!","Berikan aku awan, akanku tunjukkan bahwa aku dapat berlari ribuan mil!",},
        [27] = {27,"Para pejabat berbahagia, para penguasa melindungi negara.","Adik kecil bagai benang dan jarum, selalu bersama tidak terpisahkan.","Hatiku menginginkan perkembangan di masa depan.","Adik kecil menyanyi diiringi kecapi, siapa yang tidak merindukan masa muda.",},
        [28] = {28,"Siapa tipu saya, beritahukanlah namamu?","Kalian bantu aku lihat, apa ini adalah pekan olahraga orang cacat?","Nakal sekali? Bisa-bisanya membiarkan aku orang buta berlari!","ini, bagaimana kalau sampai memasuki jalur orang lain?",},
        [29] = {29,"Kami keluarga Zhuge, orang bertalenta setiap generasi!","Zhuge Liang mengatakan bahwa ambisinya harus tinggi, jika tidak ingin menjadi juara, buat apa mengikuti kompetisi.","Berlari sambil membawa Lampion, Tampan tidak?","Sun Quan berkata bahwa wajahku panjang seperti keledai, bagaimana menurut kalian?",},
        [30] = {30,"Kalian tidak akan bisa menang walau menunggang kuda!","Seluruh dunia adalah milikku Lu Bu, Apalagi hanya markas yang kecil ini!","Dimana Diao Chan ku? Dimana kuda Chitu ku?","Aku Dewa Perang Lu Bu walau tidak berkuda juga akan menang dari kalian.",},
        [31] = {31,"Aku sangat merindukan Lu Bu.","Kalah atau menang, Lu Bu akan tetap mencintaiku.","hiks hiks hiks… aku akan berusaha, tidak akan menyia-nyiakan cinta dari Lu Bu.","Siapa yang bisa menjemputku di garis finish?",},
        [32] = {32,"Siapa yang berani lari di depan guru agung, potong dia!","Kami Orang Liangzhou, tidak pernah takut kalah!","Haha, memilihku, penilaianmu sangat bagus!","Jika aku mendapat Juara I, Guru agung akan mentraktir kau minum arak makan daging dan memeluk wanita cantik!",},
        [33] = {33,"Boneka kecil penuh racun di perutnya, hati-hati keracunan di dekatnya!","Rahasia ilmu Taoisme, menang kompetisi dengan santai!","Nanti siapa yang berani mendekatiku, akan kuracuni dia sampai mati!","Kalian kemari untuk berkompetisi, tapi aku Yu Ji hanya untuk membawa jalan-jalan bonekaku!",},
        [34] = {34,"Siapa yang menjadi juara, akan dihadiahkan jabatan dan tanah!","Jurus tendangan mautku, saat berlari sangatlah cepat!","Siapa yang berani merebut Stempel Negaraku? siapa yang berani menang dariku?","Aku adalah putra sah keluarga Yuan, hari ini pasti mendapat juara I!",},
        [35] = {35,"Mendengar musik ini, aku teringat akan masa kecil.","Jika hidup singkat, lebih baik dengan senang hati mengikuti kompetisi.","Kecapi Kepala Kuda sangat berat, hari ini bisa mendapat juara I?","Aku bisa bermain kecapi, membuat puisi, menulis buku, apa kau yakin membiarkan aku maju?",},
        [36] = {36,"Percaya tidak, aku bisa menang lari dari Lu Bu?","Siapa yang menjadi juara hari ini, aku pasti mengabdi kepadanya!","Asalkan Lu Bu tidak ada, aku pasti bisa mendapatkan Juara I!","Jika hari ini bisa memenangkan kompetisi lari, Tujuan besar akan ada harapan!",},
        [37] = {37,"Penerus klan terkenal, pasti merebut Juara I!","Dimana A Dou, setelah kompetisi selesai aku akan bermain dengan panda ya.","Aku menunggangi kuda bambu (Kuda Bambu : suatu mainan anak-anak, bentuknya adalah sebuah bambu, diujungnya ada bentuk kepala kuda, kadang diujung lainnya dipasang roda, anak-anak berdiri mengangkang, berpura-pura menunggangi kuda), siapa yang bisa lari lebih cepat dariku!","Mari mari mari, kasi kau makan buah pir, mau tidak mengalah denganku!",},
        [38] = {38,"Berjanjilah ayah, jika aku menang, aku tidak perlu menikah dengan anak Yuan Shu!","Tunggu aku mendapat Juara I, aku akan menghadiahkan tropi untuk ayahku untuk dipakai minum arak!","Ayahku adalah Dewa Perang Lu Bu! Karena itu aku tidak boleh kalah!","Aku hanya ingin membunuh di medan perang! Mengikuti kompetisi sangatlah mubazir!",},
        [39] = {39,"He Jin ingin membunuhku, aku harus lari lebih cepat!","Dong Zhuo sudah mau masuk ke ibu, semuanya cepat lari!","Maukah mencoba rasanya tidak ada keturunan?","Huh, jika kalah lomba lari, akan kupotong kau!",},
        [40] = {40,"Dari bentuk tubuhku ini, dapat dilihat kalau adalah Juara I.","Pemberani tidak ada rasa takut, aku pasti mendapatkan juara I!","Nanti siapa yang lari di depanku, palu besarku tidak akan mengampuninya!","khe khe, aku bilang semua yang ada di sini, kalian pasti tidak akan bisa menang lari dariku!",},
    }
}

return play_horse_hero