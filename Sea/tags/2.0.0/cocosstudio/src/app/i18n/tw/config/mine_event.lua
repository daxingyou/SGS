--mine_event

local mine_event = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      count_down_title = 2,    --倒计时标题-繁体-string 
      count_down_txt = 3,    --倒计时说明-繁体-string 
    
    },
    -- data
    _data = {
        [1] = {1,"距外圈礦區開啟: ","在普通礦區不能交戰",},
        [2] = {2,"距高級礦區開啟: ","在高級礦區可以剿滅敵軍, 佔據礦區",},
        [3] = {3,"距頂級礦區開啟: ","爭奪最頂級的礦坑, 獲得最大收益",},
    }
}

return mine_event