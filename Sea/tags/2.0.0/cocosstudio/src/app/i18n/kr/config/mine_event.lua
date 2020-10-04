--mine_event

local mine_event = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      count_down_title = 2,    --倒计时标题-韩语-string 
      count_down_txt = 3,    --倒计时说明-韩语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"외부광산:","일반광산 교전불가",},
        [2] = {2,"상급광산:","상급광산은 적군처치 후 광산점령가능",},
        [3] = {3,"최상급광산:","최상급광산 점령 시 최대수익획득",},
    }
}

return mine_event