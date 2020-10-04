--mail_lang

local mail_lang = {
    -- key
    __key_map = {
      id = 1,    --ID_key-int 
      mail_name = 2,    --发件人-越南语-string 
      mail_title = 3,    --邮件标题-越南语-string 
      mail_text = 4,    --邮件文本-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {8401,"Tiểu Kiều","Thông báo webpay","Vào #time1# ngày #time2#, mua item #name# tại webpay; item đã được gửi vào tài khoản của bạn đồng thời kích hoạt event tích lũy nạp trong ngày",},
        [2] = {8402,"Tiểu Kiều","Thông báo webpay","Vào #time1# ngày #time2#, mua item #name# tại webpay; item đã được gửi vào tài khoản của bạn, còn lại cần vào giao diện để nhận đồng thời kích hoạt event tích lũy nạp trong ngày",},
    }
}

return mail_lang