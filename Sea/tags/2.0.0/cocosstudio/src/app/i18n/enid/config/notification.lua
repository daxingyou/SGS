--notification

local notification = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      chat_before = 2,    --文本-string 
      time_txt = 3,    --标题-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Tuan, lunch sudah siap, cepat ikuti lunch untuk menambahkan Stamina!","Lunch dimulai",},
        [2] = {2,"Tuan, dinner sudah dimulai, cepatlah ikut dinner untuk menambah banyak stamina!","Supper dimulai",},
        [3] = {3,"Tuan, Supper sudah diulai, cepat ikuti untuk menambahkan Stamina!","Supper dimulai",},
        [4] = {4,"BOSS Legiun akan muncul dalam 5 menit, Tuan silahkan bersiap menantang. Mengalahkan BOSS akan bisa mengikuti lelang & pembagian!","BOSS Legiun telah tiba",},
        [5] = {5,"BOSS Legiun akan muncul dalam 5 menit, Tuan silahkan bersiap menantang. Mengalahkan BOSS akan bisa mengikuti lelang & pembagian!","BOSS Legiun telah tiba",},
        [6] = {6,"Tuan, cepatlah login dan klaim hadiah pagi milik Anda~~~","Paket setiap pagi",},
        [7] = {7,"Perang Samkok akan dimulai dalam 5 menit, tantang BOSS dan hancurkan, ikuti pembagian lelang!","Perang Samkok dimulai",},
        [8] = {8,"Kompetisi Faksi akan dimulai dalam 5 menit, siapakah yang menjadi Raja Faksi, ayo sini bertanding!","Kompetisi Faksi dimulai",},
        [9] = {9,"Perang Legiun akan dimulai dalam 5 menit, rebut wilayah, menjadi legiun terhebat, inilah saatnya!","Perang Legiun segera dimulai",},
    }
}

return notification