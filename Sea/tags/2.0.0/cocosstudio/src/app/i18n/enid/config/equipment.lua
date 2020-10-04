--equipment

local equipment = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      is_work = 2,    --是否生效-int 
      name = 3,    --装备名称-string 
      description = 4,    --装备描述-string 
    
    },
    -- data
    _data = {
        [1] = {101,1,"Pedang Kuno","Dibuat dari besi halus dengan cara kuno, berat 38 pon, biasa digunakan pasukan elit.",},
        [2] = {102,1,"Zirah Besi Hitam","Menggunakan besi hitam, ditempa 49 hari, tidak bisa ditembus senjata biasa.",},
        [3] = {103,1,"Syal Kebebasan","Terbuat dari kain berkualitas, direndam di dalam air obat, melindungi hati dan pikiran, membuat orang tetap tersadar.",},
        [4] = {104,1,"Boots Moire","Menggunakan kulit binatang, dan dibuat dengan cara rahasia, lega dan menyerap keringat, bisa dipakai dalam waktu lama.",},
        [5] = {201,1,"Pedang Es","Dibuat dari besi dingin, permukaannya dingin, bisa menahan musuh di tengah dingin",},
        [6] = {202,1,"Zirah Rantai","Dibuat dari besi halus, satu armor terbuat dari 108 lembar besi halus, ringan tapi kuat.",},
        [7] = {203,1,"Helm Perak","Dibuat dari baja murni dilapisi perak, efektif melindungi kepala, menahan serangan.",},
        [8] = {204,1,"Boots Mink","Jahitan bulu cerpelai, satu ekor untuk satu boots, hangat di winter sejuk di summer.",},
        [9] = {301,1,"Tombak Petir","Besi yang dihaluskan, dimurnikan dengan petir, saat diayunkan muncul kilat dan suara guntur.",},
        [10] = {302,1,"Zirah Matahari","Baja yang dimurnikan, melambangkan matahari, mampu membuat musuh berhalusinasi, meleset saat menyerang.",},
        [11] = {303,1,"Mahkota Bulan","Terbentuk dari bulan purnama, mengandung kekuatan bulan.",},
        [12] = {304,1,"Boots Bayangan","Terbuat dari kelelawar, ringan dan fleksibel, pemakainya bisa berjalan ratusan mil tanpa henti.",},
        [13] = {305,1,"Kapak Lethal","Konon kapak ini sudah memotong ribuan musuh, arwah terkondensasi di sana. Sebelum kapak tiba, arwah sudah terputus lebih dulu.",},
        [14] = {306,1,"Zirah Kilat","Menggunakan perak berkualitas, memancing petir langit, sering ada kilat di atasnya.",},
        [15] = {307,1,"Helm Api","Terbuat dari besi vulkanik, ditempa dengan api bumi, terkadang ada api bersinar di dalamnya.",},
        [16] = {308,1,"Boots Topan","Menggunakan bulu rajawali, mengandung kekuatan badai, bergerak layaknya sejalan dengan angin.",},
        [17] = {401,1,"Busur Kirin","Panah yang mengandung kekuatan Kirin, tidak bisa ditarik dengan kekuatan biasa.",},
        [18] = {402,1,"Zirah Naga","Revolusi naga, mengadung kekuatan bagua langit bumi..",},
        [19] = {403,1,"Helm Phoenix","Helm bulu phoenix, mengandung kekuatan phoenix.",},
        [20] = {404,1,"Boots Vajra","Dibuat oleh vajra, kokoh tanpa tandingan, mengandung kekuatan kekacauan.",},
        [21] = {405,1,"Pedang Es Frost","Ditempa bertahun-tahun di suhu rendah, konon adalah pedang favorit Zhou Yu.",},
        [22] = {406,1,"Zirah Bulu Merah","Konon Zuo Ci membuat zirah untuk orang pilihan, menggunakan pemurnian giok, bulu merah mengandung sihir Zuo Ci.",},
        [23] = {407,1,"Mahkota Gelap","Digunakan oleh keluarga aristokrat, dihiasi dengan giok hitam, dijahit dengan sutra pilihan, elegan dan indah.",},
        [24] = {408,1,"Boots Sutra","Terbuat dari brokat dan jasper, indah dan elegan, memiliki proteksi yang bagus.",},
        [25] = {409,1,"Tombak Nova","Salah satu Gear Nova, pernah dipakai oleh jenderal hebat, tidak terkalahkan di ribuan pertempuran.",},
        [26] = {410,1,"Zirah Nova","Salah satu Gear Nova, kedua sisi bahu berbentuk serigala, seluruh zirah memiliki kekuatan serigala.",},
        [27] = {411,1,"Helm Nova","Salah satu Gear Nova, dibuat dari Perak Misterius Xiliang, terlihat seperti singa, kekuatannya tak tertandingi.",},
        [28] = {412,1,"Boots Nova","Salah satu Gear Nova, luarnya berlapis meteorit, dalamnya kulit binatang langka, memiliki kemampuan mendaki langit..",},
        [29] = {501,1,"Tombak 4-Dewa","Salah satu Gear 4-Dewa, mengandung aura naga, saat diayunkan sering terdengar raungan naga.",},
        [30] = {502,1,"Zirah 4-Dewa","Salah satu Gear 4-Dewa, mengandung aura kura hitam, memiliki efek pertahanan sempurna.",},
        [31] = {503,1,"Helm 4-Dewa","Salah satu Gear 4-Dewa, mengandung aura macan putih, bisa mengakibatkan kekuatan luar biasa.",},
        [32] = {504,1,"Boots 4-Dewa","Salah satu Gear 4-Dewa, mengandung aura Suzaku, kekuatan Suzaku bisa membuat tubuh manusia melampaui normal.",},
        [33] = {601,1,"Halberd Keramat","Salah satu Gear Keramat, mengandung kekuatan roh beast kuno Tao Tie, saat bertarung jika ada bantuan dewa, kekuatannya luar biasa.",},
        [34] = {602,1,"Zirah Keramat","Salah satu Gear Keramat, mengandung kekuatan roh beast kuno Qiong Qi, pertahanan kokoh, tidak bisa ditembus.",},
        [35] = {603,1,"Mahkota Keramat","Salah satu Gear Keramat, mengandung kekuatan roh beast kuno Tao Wu, tekad yang kokoh, pikiran yang tenang.",},
        [36] = {604,1,"Boots Keramat","Salah satu Gear Keramat, mengandung kekuatan roh beast kuno Hun Dun, bisa memberikan vitalitas tanpa batas.",},
    }
}

return equipment