--guild_stage_talk

local guild_stage_talk = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      talk1 = 2,    --说话1-string 
      talk2 = 3,    --说话2-string 
      talk3 = 4,    --说话3-string 
      talk4 = 5,    --说话4-string 
      talk5 = 6,    --说话5-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Đừng... Đừng hiểu lầm, không phải ta cố tình chống đối ngươi.","Ta nói các vị ở đây đều là vô dụng","Một nắm đấm của ta thì ngươi có thể mất mạng!","Kẻ yếu tại sao phải chiến đấu?","Chỉ cần một ngón tay ta cũng có thể diệt ngươi!",},
        [2] = {2,"Hãy theo dòng chảy, tấn công kẻ địch!","Ngươi là đối thủ đáng khâm phục!","Quả là đối thủ xứng tầm, bổn tướng quân rất thích!","Hôm nay sẽ là ngày tận thế của các ngươi!","Đừng đi! Hôm nay ta phải quyết chiến 300 hiệp với ngươi!",},
        [3] = {3,"Ta chưa từng gặp ai vô liêm sỉ như ngươi!","Tướng quân tha mạng, tại hạ còn có mẹ già và con thơ!","Sao không kiếm đối thủ tương xứng mà đánh?","Đánh ta không có lợi gì cho ngươi!","Ta nghĩ ngươi nên tìm cấp trên của ta!",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
    }
}

return guild_stage_talk