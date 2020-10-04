--mail_lang

local mail_lang = {
    -- key
    __key_map = {
      id = 1,    --ID_key-int 
      mail_name = 2,    --发件人-繁体-string 
      mail_title = 3,    --邮件标题-繁体-string 
      mail_text = 4,    --邮件文本-繁体-string 
    
    },
    -- data
    _data = {
        [1] = {8401,"小喬","儲值提醒","您於xxxx年x月x日, xx: xx: xx點, 在官網上購買了#name#, 對應獎勵已發放到您指定帳戶, 同時激活當天對應累儲活動, 感謝您的支持!",},
        [2] = {8402,"小喬","儲值提醒","您於xxxx年x月x日, xx: xx: xx點, 在官網上購買了#name#, 部分獎勵已直接發放到您帳戶, 剩餘獎勵請到遊戲內對應介面領取, 同時激活當天對應累儲活動, 感謝您的支持!",},
    }
}

return mail_lang