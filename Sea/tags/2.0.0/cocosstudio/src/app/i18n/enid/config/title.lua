--title

local title = {
    -- key
    __key_map = {
      id = 1,    --序号_key-int 
      name = 2,    --名称-string 
      des = 3,    --条件描述-string 
      description = 4,    --详情描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Penggemar Game","Akumulasi login mencapai 99 hari","Akumulasi login mencapai 99 hari",},
        [2] = {2,"Terakhir Kali","Di Jalan Huarong akumulasi menebak benar 99x pemenang","Di Jalan Huarong akumulasi menebak benar 99x pemenang",},
        [3] = {3,"Hepi Kan","Dari Peti Emas mendapatkan 1 Gear Merah apapun","Dari Peti Emas mendapatkan 1 Gear Merah apapun",},
        [4] = {4,"Terkejut Kan","Pada event Astronomi Wolong langsung mendapatkan 1 Pet Jingga","Pada event Astronomi Wolong langsung mendapatkan 1 Pet Jingga",},
        [5] = {5,"Ga Nyangka Kan","Di event Kekalahan Memalukan langsung mendapatkan 1 Gear Merah","Di event Kekalahan Memalukan langsung mendapatkan 1 Gear Merah",},
        [6] = {6,"Gokil Kan","Di event Inkarnasi Luar Tubuh langsung mendapatkan 1 Bulu Metamorfosis 3-Dewata","Di event Inkarnasi Luar Tubuh langsung mendapatkan 1 Bulu Metamorfosis 3-Dewata",},
        [7] = {7,"Siapa Lagi?","Peringkat 1 Arena saat kalkulasi Arena Harian","Peringkat 1 Arena saat kalkulasi Arena Harian",},
        [8] = {8,"Aku Mau Semuanya","Memiliki semua Hero (tidak termasuk Hero Jingga yang naik ke Merah)","Memiliki semua Hero (tidak termasuk Hero Jingga yang naik ke Merah)",},
        [9] = {9,"Top 10 Ksatria","Top 10 Klasemen CP Harian","Top 10 Klasemen CP Harian",},
        [10] = {10,"Sini, Ayo","Di Perang Tambang dibunuh 999x","Di Perang Tambang dibunuh 999x",},
        [11] = {11,"Penguasa Wei","Juara Wei Kompetisi Faksi","Juara Wei Kompetisi Faksi",},
        [12] = {12,"Penguasa Shu","Juara Shu Kompetisi Faksi","Juara Shu Kompetisi Faksi",},
        [13] = {13,"Penguasa Wu","Juara Wu Kompetisi Faksi","Juara Wu Kompetisi Faksi",},
        [14] = {14,"Penguasa Han","Juara Han Kompetisi Faksi","Juara Han Kompetisi Faksi",},
        [15] = {15,"Anjing","Di event Inkarnasi Luar Tubuh langsung mendapatkan 1 Bulu Metamorfosis Angsa","Di event Inkarnasi Luar Tubuh langsung mendapatkan 1 Bulu Metamorfosis Angsa",},
        [16] = {16,"Target Kecil Dulu","Memiliki semua Kartu Avatar Jingga","Memiliki semua Kartu Avatar Jingga",},
        [17] = {17,"Pusat Perhatian","Setiap Kamis Kompetisi Individual Antar Server Top 4","Setiap Kamis Kompetisi Individual Antar Server Top 4",},
        [18] = {18,"Unggulan","akumulasi membunuh 999 pemain di Perang Tambang","akumulasi membunuh 999 pemain di Perang Tambang",},
        [19] = {19,"Perdana Menteri","Saat kalkulasi musim Perang Raja berada di peringkat 2~10","Saat kalkulasi musim Perang Raja berada di peringkat 2~10",},
        [20] = {20,"Tiada Duanya","Setiap Kamis juara Kompetisi Individual Antar Server","Setiap Kamis juara Kompetisi Individual Antar Server",},
        [21] = {21,"Jagoan","Saat kalkulasi Perang Raja meraih peringkat 1","Saat kalkulasi Perang Raja meraih peringkat 1",},
        [22] = {22,"Bos Tambang","Memiliki semua Kartu Avatar Merah","Memiliki semua Kartu Avatar Merah",},
        [23] = {23,"Pemandu pemula","Pemandu pemula resmi game","Pemandu pemula resmi game",},
        [24] = {24,"Merantau","Gelar terbatas eksklusif peringatan 100 periode","Gelar terbatas eksklusif peringatan 100 periode",},
        [25] = {25,"Terbang Bersama Angin","Gelar terbatas eksklusif event Perayaan Ultah, masa berlaku 30 hari","Gelar terbatas eksklusif event Perayaan Ultah, masa berlaku 30 hari",},
        [26] = {26,"Penuh Keberanian","Gelar terbatas eksklusif event Perayaan Ultah, masa berlaku 30 hari","Gelar terbatas eksklusif event Perayaan Ultah, masa berlaku 30 hari",},
        [27] = {27,"Ke Langit Tertinggi","Gelar terbatas eksklusif event Perayaan Ultah, masa berlaku 30 hari","Gelar terbatas eksklusif event Perayaan Ultah, masa berlaku 30 hari",},
        [28] = {28,"Badai Angkasa","Gelar eksklusif event Kemunculan Naga","Gelar eksklusif event Kemunculan Naga",},
        [29] = {29,"Pencarian Jejak Naga","Gelar eksklusif event Kemunculan Naga","Gelar eksklusif event Kemunculan Naga",},
        [30] = {30,"Mencari ke Ujung Dunia","Gelar eksklusif event Kemunculan Naga","Gelar eksklusif event Kemunculan Naga",},
        [31] = {1001,"Tahun Baru 2020","Selama event Imlek 2020, login 1 hari","Selama event Imlek 2020, login 1 hari",},
        [32] = {1002,"Sesuai Harapan","Selama Event Tahun Baru 2020, mencapai Lv.20 ke atas","Selama Event Tahun Baru 2020, mencapai Lv.20 ke atas",},
        [33] = {1003,"Selamat Imlek","Selama Event Tahun Baru 2020, mencapai Lv.40 ke atas","Selama Event Tahun Baru 2020, mencapai Lv.40 ke atas",},
        [34] = {1004,"Hoki Tahun Baru","Selama event Tahun Baru 2020, top-up nominal berapapun","Selama event Tahun Baru 2020, top-up nominal berapapun",},
        [35] = {1005,"Bos Sultan","Selama event Tahun Baru 2020, selama event, akumulasi top-up 5000k","Selama event Tahun Baru 2020, selama event, akumulasi top-up 5000k",},
        [36] = {8023,"MVP Legiun","Perolehan event operasi","Perolehan event operasi",},
        [37] = {8024,"Aura Wei","Perolehan event operasi","Perolehan event operasi",},
        [38] = {8025,"Aura Shu","Perolehan event operasi","Perolehan event operasi",},
        [39] = {8026,"Aura Wu","Perolehan event operasi","Perolehan event operasi",},
        [40] = {8027,"Aura Han","Perolehan event operasi","Perolehan event operasi",},
        [41] = {8028,"Legenda Emas","Perolehan event operasi","Perolehan event operasi",},
        [42] = {8029,"Pelukis hebat","Perolehan event operasi","Perolehan event operasi",},
        [43] = {9013,"Penerjemah","Bantu dev untuk mengoptimalkan dan mengoreksi terjemahan game","Bantu dev untuk mengoptimalkan dan mengoreksi terjemahan game",},
    }
}

return title