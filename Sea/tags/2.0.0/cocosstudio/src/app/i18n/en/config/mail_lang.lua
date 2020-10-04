--mail_lang

local mail_lang = {
    -- key
    __key_map = {
      id = 1,    --ID_key-int 
      mail_name = 2,    --发件人-英语-string 
      mail_title = 3,    --邮件标题-string 
      mail_text = 4,    --邮件文本-简中-string 
    
    },
    -- data
    _data = {
        [1] = {8401,"Xiao Qiao","Top up Notice","You purchased #name# on the official website at xx:xx:xx on x, x, xxxx. The corresponding reward has been issued to your designated account, and the corresponding accumulating top-up event on the same day has been activated. Thank you for your support!",},
        [2] = {8402,"Xiao Qiao","Top up Notice","You purchased #name# on the official website at xx:xx:xx on x, x, xxxx. Part of the rewards has been issued to your designated account. Please claim the rest in the corresponding interface in the game. Also, the accumulating top-up event on the same day has been activated. Thank you for your support!",},
    }
}

return mail_lang