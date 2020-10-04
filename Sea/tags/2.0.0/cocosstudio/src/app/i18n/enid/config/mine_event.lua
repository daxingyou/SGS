--mine_event

local mine_event = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      count_down_title = 2,    --倒计时标题-string 
      count_down_txt = 3,    --倒计时说明-string 
    
    },
    -- data
    _data = {
        [1] = {1,"距外圈矿区开启: ","Di Tambang normal tidak bisa berperang",},
        [2] = {2,"Tambang Kualitas Tinggi dimulai dalam:","Di Tambang Kualitas Tinggi bisa membasmi pasukan musuh, menduduki tambang",},
        [3] = {3,"Tambang Top dimulai dalam:","Rebut tambang terbaik, dapatkan banyak pemasukan",},
    }
}

return mine_event