--time_limit_activity

local time_limit_activity = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      is_work = 2,    --是否显示-int 
      name = 3,    --限时活动名称-string 
      start_des = 4,    --开启描述-string 
      description = 5,    --活动描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,1,"BOSS Legiun","Setiap hari","BOSS Legiun dimulai setiap hari pk 12:00 & 19:00; Semakin banyak partisipan, semakin banyak hadiah lelang; Mengikuti event bisa mendapatkan pembagian lelang legiun.",},
        [2] = {2,1,"Kuis Legiun","Setiap hari","Kuis Legiun terbuka setiap hari pk 18:00; Semakin banyak partisipan legiun, semakin banyak hadiah lelang; Pemain yang mengikuti event bisa mendapatkan pembagian lelang legiun.",},
        [3] = {3,1,"Percobaan Legiun","Setiap hari","Percobaan Legiun dimulai setiap hari pk 18:10 - 18:40; Semakin banyak poin Percobaan Legiun, semakin banyak Hadiah Lelang; Menngikuti event akan mendapatkan pembagian lelang legiun",},
        [4] = {4,1,"Perang Samkok","Rabu, Jumat, Minggu","Hero Samkok, ayo berperang! Perang! Perang! Setiap Rabu, Jumat, Minggu pk 21:00 dimulai, menunggu kalian datang menantang!",},
        [5] = {5,1,"Kompetisi Faksi","Setiap Senin & Kamis","Pendaftaran Kompetisi Faksi setiap Senin dan Kamis pk 4:00 dimulai, pk 21:00 mulai perang; Semakin banyak partisipan, hadiah lelang semakin banyak; semua patisipan bisa mendapatkan pembagian lelang Kompetisi Faksi.",},
        [6] = {6,1,"Jalan Huarong","Setiap hari","Jalan Huarong melangsungkan 2 ronde setiap hari pk 10:00, 14:00, 16:00, 22:00, sehari total 8 ronde, bisa mendukung Hero yang mengikuti ronde, jika yang didukung juara 1 maka akan mendapatkan hadiah!",},
        [7] = {7,1,"Perang Legiun","Setiap Selasa & Sabtu","\n Setiap Seasa, Sabtu pk 21:00 dimulai Perang Legiun. Ayo, nikmati keseruannya!",},
        [8] = {8,1,"Perang Raja","Setiap hari","Kompetisi Sengit yang adil, mengabaikan CP, hanya bertanding taktik!\nSetiap hari pk 11:00-14:00 & 19:00-22:00, ayo bertempur bersama!",},
        [9] = {9,1,"Makam Qin","Setiap hari","Setiap hari pk 10:00-22:00, membentuk Tim ke Makam Kaisar, berpeluang mendapatkan Negara Damai & Negara Perang!",},
        [10] = {10,1,"Kompetisi Faksi","Setiap Senin","Pendaftaran Kompetisi Faksi setiap Senin pk 4:00 dimulai, pk 21:00 mulai perang; Semakin banyak partisipan, hadiah lelang semakin banyak; semua patisipan bisa mendapatkan pembagian lelang Kompetisi Faksi dan Kompetisi Individual Antar Server Kamis.",},
        [11] = {11,0,"Perang Legiun Antar Server","Setiap Sabtu","Selasa pk 21:00 dimulai Perang Legiun, Sabtu pk 21:00 dimulai Perang Legiun Antar Server\n Legiun yang menguasai Gerbang Hulao, Gerbang Hangu, Jiange, Xiaoyaojin akan mengikuti Perang Legiun antar server\n Legiun lainnya tetap mengikuti Perang Legiun Server.",},
        [12] = {12,1,"Arena Individual","Setiap Kamis","Di grup yang sama 8 server memiliki rata-rata 30 hari pembukaan server. Setiap Kamis dilakukan Kompetisi Individual Antar Server; Semakin banyak pendaftar Kompetisi Faksi, hadiah lelang semakin banyak. Pemain yang mendaftar bisa mendapatkan pembagian lelang Kompetisi Individual Antar Server",},
        [13] = {13,1,"Kuis Legiun","Setiap Selasa, Kamis, Sabtu","Kuis Legiun dimulai setiap Selasa, Kamis, Sabtu pk 18:00; Semakin banyak partisipan legiun, semakin banyak Hadiah Lelang; Pemain partisipan bisa mendapatkan pembagian Lelang Legiun.",},
        [14] = {14,0,"Kuis Server","Senin, Rabu, Jumat, Minggu","Kuis Server dimulai setiap Senin, Rabu, Jumat, Minggu pk 18:00; Semakin banyak partisipan legiun, semakin banyak hadiah lelang; Pemain yang mengikuti event bisa mendapatkan pembagian lelang legiun.",},
    }
}

return time_limit_activity