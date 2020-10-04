--pet

local pet = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      is_fight = 2,    --无差别竞技里是否可用_math-int 
      name = 3,    --名称-string 
      description = 4,    --宠物描述-string 
      description1 = 5,    --show宠物描述1-string 
      description2 = 6,    --show宠物描述2-string 
      skill_name = 7,    --show宠物技能名称-string 
      skill_description = 8,    --show宠物技能描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,0,"Panda","Panda, juga dinamakan Pet Pemakan Besi, bapak panda ganas dan kuat, anak panda pintar dan imut, ayah dan anak bergabung, selalu menang.","Bapak panda ganas dan kuat, anak panda pintar dan imut.","Ayah dan anak bergabung, tak terkalahkan.","[Raungan Teror]","Terhadap unit musuh mengakibatkan DMG",},
        [2] = {2,0,"Rusa Roh","Rusa Roh, roh Ajaib yang lahir dan tumbuh di dunia, Tanduk Rusa terbentuk dari aura langit dan bumi. ketika aura mekar, dapat menghidupkan orang yang sudah mati.","Roh Ajaib yang lahir dan tumbuh di dunia.","Tanduk Rusa terbentuk dari aura langit dan bumi.","[Bunga Bermekaran]","Heal sekutu HP terendah",},
        [3] = {3,0,"Rubah Api","Rubah Api, menurut legenda memiliki 3 ekor, 4 cakar berapi, ganas dan angkuh, tapi dapat membedakan dendam dan budi, ada dendam pasti dibalas, ada budi pasti dibalas.","Tiga ekor, empat cakar berapi.","Membedakan dendam dan kebaikan, ada dendam balas dendam, ada kebaikan balas kebaikan.","[Ekor Rubah Api]","Terhadap musuh baris belakang mengakibatkan DMG",},
        [4] = {4,0,"Phoenix Sakti","Phoenix Sakti, Warna bulunya mewah Dalam ungu terdapat hijau. Orang dulu melihat merah sebagai Phoenix, Hijau sebagai burung Luan. Menurut legenda Luan Hijau adalah simbol cinta, saat menyanyi dapat membawa jodoh kepada orang yang berniat.","Warna bulunya mewah, dalam Ungu ada hijau.","Menurut legenda adalah simbol cinta.","[Angin Meniup Awan]","Terhadap musuh baris depan mengakibatkan DMG",},
        [5] = {5,1,"Harimau Petir","Harimau Petir, salah satu dari 4 Pet, seluruh tubuhnya putih, dipenuhi cahaya ungu, memiliki kekuatan menggunakan petir.","Seluruh badan putih, dipenuhi cahaya ungu.","Bisa resist kekuatan petir","[Kilat Menyambar]","Sebelum duel reduksi Amarah, saat duel reduksi Amarah lagi",},
        [6] = {6,1,"Naga Tsunami","Naga Tsunami, pemimpin dari 4 Pet, sejak dulu adalah simbol keberuntungan. Naga Tsunami berposisi di timur, tanduknya indah, mengeluarkan awan yang misterius, memakan petir untuk suara, terbang berputar dengan tinggi, mengelilingi dunia, berkelok kiri dan kanan.","Pemimpin Beast","Sejak dulu adalah simbol keberuntungan.","[Amarah Naga]","Regen Amarah sekutu",},
        [7] = {7,1,"Suzaku Api","Suzaku Api, raja burung, diantara 4 Pet penampilannya paling gagah. menguasai api, indah tapi brutal, bernyanyi dan menari, meramalkan perdamaian yang menguntungkan, penuh kebanggaan.","Barang yang dapat terbakar terus menerus.","Dapat menuntun jiwa untuk naik ke langit","[Membakar Langit]","Terhadap semua musuh yang Terbakar mengakibatkan DMG",},
        [8] = {8,1,"Kura Penghancur","Kura penghancur, salah satu dari 4 Beast, terbentuk dari komposisi roh kura dan ular, merupakan simbol keabadian. Kura hitam dapat sapit dan keras, bukan timbal maupun timah merupakan jenis batu yang unik, adalah dewa di timur sungai, lahir sebelum langit dan bumi, dapat memelihara semua hal semesta.","Roh Ajaib hasil kombinasi Kura dan Ular.","Simbol keabadian.","[Proteksi Kura Hitam]","Menambahkan perisai ke sekutu",},
        [9] = {9,1,"Kun Suci","Kun berasal dari Berkelana dengan bebas. karya Zhuang zi:Didalam laut utara ada ikan Alam Baka yang dinamakan Kun, besarnya Kun mencapai ribuan mil. De Qing masa dinasti Ming catatan Zhuang zi Mengatakan : Didalam Laut Utara , adalah tempat yang jauh dari pan dan gan dunia, bagaikan kegelapan. Kun di laut, bagai Jalur besar tubuh memelihara Embrio yang besar, bagai Kun Besar, jika tidak seluas Laut utara tidak akan bisa dipelihara.","Didalam laut utara ada ikan Alam Baka yang dinamakan Kun","Besarnya Kun mencapai ribuan mil","[Awan Kebebasan]","Menghapus efek stun sekutu",},
        [10] = {10,1,"Kirin Halilintar","Kirin Halilintar, bersama dengan Phoenix, Kura, dan Naga sebagai 4 roh suci, saat melangkah pasti meninggalkan jejak, pembawa keberuntungan, tidak sembarangan membunuh, kaisar keluar, membedakan kebaikan dan kejahatan tahu prinsip langit.","Dewa Keberuntungan beribu-ribu tahun.","Mengetahui aturan langit, membedakan yang baik dan buruk.","[Pilihan Takdir]","Terhadap musuh acak mengakibatkan DMG sebesar 50% HP Maks",},
        [11] = {11,1,"Monster Nian","Menurut legenda setiap akhir tahun di dunia akan muncul monster muda, mata seperti lonceng tembaga, sangat lincah, bertubuh emas seperti pelangi, sangat mengagumkan; Sifatnya aktif dan lincah seperti anak kecil, sangat suka keramaian.","Tubuh emas bersinar, sangat megah.","Sifatnya seperti anak kecil lompat sana-sini.","[Petasan Langit]","Target dengan HP kurang dari jumlah tertentu akan dibunuh",},
        [12] = {12,0,"Bai Ze Keramat","Bai Ze menyimbolkan keberuntungan, mengerti bahasa manusia, mengetahui kondisi dunia, mengetahui semua bentuk di dunia, adalah pet keberuntungan yang dapat mengubah buruk menjadi baik.","Mengetahui segala hal di dunia.","Bencana berubah menjadi keberuntungan.","[Cahaya Hujan]","Sebelum ronde dimulai menghalau target",},
        [13] = {106,0,"God-Naga","Naga Tsunami, pemimpin dari 4 Pet, sejak dulu adalah simbol keberuntungan. Naga Tsunami berposisi di timur, tanduknya indah, mengeluarkan awan yang misterius, memakan petir untuk suara, terbang berputar dengan tinggi, mengelilingi dunia, berkelok kiri dan kanan.","Pemimpin Beast","Sejak dulu adalah simbol keberuntungan.","[Amarah Naga]","Regen Amarah sekutu",},
    }
}

return pet