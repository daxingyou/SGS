--mine_event

local mine_event = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      count_down_title = 2,    --倒计时标题-简中-string 
      count_down_txt = 3,    --倒计时说明-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"距外圈矿区开启: ","在普通矿区不能交战",},
        [2] = {2,"距高级矿区开启: ","在高级矿区可以剿灭敌军, 占据矿区",},
        [3] = {3,"距顶级矿区开启: ","争夺最顶级的矿坑, 获得最大收益",},
    }
}

return mine_event