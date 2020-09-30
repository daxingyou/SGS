--mail_lang

local mail_lang = {
    -- key
    __key_map = {
      id = 1,    --ID-int 
      mail_text = 2,    --邮件文本-string 
      mail_name = 3,    --发件人-string 
      mail_title = 4,    --邮件标题-string 
    
    },
    -- data
    _data = {
        [1] = {8401,"Vào #time1# ngày #time2#, mua item #name# tại webpay; item đã được gửi vào tài khoản của bạn đồng thời kích hoạt event tích lũy nạp trong ngày","Tiểu Kiều","Thông báo webpay",},
        [2] = {8402,"Vào #time1# ngày #time2#, mua item #name# tại webpay; item đã được gửi vào tài khoản của bạn, còn lại cần vào giao diện để nhận đồng thời kích hoạt event tích lũy nạp trong ngày","Tiểu Kiều","Thông báo webpay",},
    },

    -- index
    __index_id = {
        [8401] = 1,
        [8402] = 2,
    }
}

return mail_lang