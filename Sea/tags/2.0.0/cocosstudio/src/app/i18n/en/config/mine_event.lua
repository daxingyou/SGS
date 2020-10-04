--mine_event

local mine_event = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      count_down_title = 2,    --倒计时标题-英语-string 
      count_down_txt = 3,    --倒计时说明-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Till Outer Mine Open:","Battles are banned in the normal Mine",},
        [2] = {2,"Till Advanced Mine Open:","In Advanced Mine can destroy the Enemies and occupy the Mine",},
        [3] = {3,"Till Top-level Mine Open:","Fight for the most Top-level Mine and obtain the biggest profits",},
    }
}

return mine_event