--boss_content

local boss_content = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      text = 2,    --相关文本-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Chúa công, lần này khiêu chiến BOSS Quân Đoàn, quân đoàn của ngài tham gia #number# người, hạng điểm quân đoàn xếp thứ #rank#, nhận #prestige# danh vọng, thưởng đã gửi đến đấu giá và thư.",},
        [2] = {2,"Chúa công, lần này khiêu chiến BOSS Quân Đoàn, hạng điểm cá nhân xếp thứ #rank#, thưởng đã gửi đến thư (Gia nhập quân đoàn nhiều thưởng hơn!)",},
        [3] = {3,"#name1# đoạt được #name2# #integral# điểm",},
        [4] = {4,"#name1# bị #name2# đoạt #integral# điểm",},
        [5] = {5,"#name1# khiêu chiến BOSS Thế Giới nhận được #integral# điểm",},
        [6] = {6,"Bị #name# giành mất #integral# điểm",},
        [7] = {7,"Khiêu chiến BOSS Thế Giới nhận #integral# điểm",},
        [8] = {8,"Đã giành được của #name# #integral# điểm",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
    }
}

return boss_content