--mail_lang

local mail_lang = {
    -- key
    __key_map = {
      id = 1,    --ID_key-int 
      mail_name = 2,    --发件人-简中-string 
      mail_title = 3,    --邮件标题-越南语-string 
      mail_text = 4,    --邮件文本-简中-string 
    
    },
    -- data
    _data = {
        [1] = {8401,"小乔","充值提醒","您于xxxx年x月x日, xx: xx: xx点, 在官网上购买了#name#, 对应奖励已发放到您指定账户, 同时激活当天对应累充活动, 感谢您的支持!",},
        [2] = {8402,"小乔","充值提醒","您于xxxx年x月x日, xx: xx: xx点, 在官网上购买了#name#, 部分奖励已直接发放到您账户, 剩余奖励请到游戏内对应界面领取, 同时激活当天对应累充活动, 感谢您的支持!",},
    }
}

return mail_lang