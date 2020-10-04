--equipment_active

local equipment_active = {
    -- key
    __key_map = {
      id = 1,    --编号_key-int 
      money = 2,    --充值额度_math-int 
      name1 = 3,    --抽奖名称1-string 
      name2 = 4,    --抽奖名称2-string 
      time_name = 5,    --倒计时描述-string 
      hit_chat_1 = 6,    --被击喊话1-string 
      hit_chat_2 = 7,    --被击喊话2-string 
      hit_chat_3 = 8,    --被击喊话3-string 
      hit_chat_4 = 9,    --被击喊话4-string 
      hit_chat_5 = 10,    --被击喊话5-string 
      chat_1 = 11,    --常规喊话1-string 
      chat_2 = 12,    --常规喊话2-string 
      chat_3 = 13,    --常规喊话3-string 
      chat_4 = 14,    --常规喊话4-string 
      chat_5 = 15,    --常规喊话5-string 
    
    },
    -- data
    _data = {
        [1] = {1,50000,"Truy Kích x1","Truy Kích x10","","Anh hùng đừng đánh ta!","Anh hùng thủ hạ lưu tình, ta sẽ cho người đồ tốt!","Đau quá!","Hãy đuổi theo ta!","Đừng đánh ta! Trang bị đều cho ngươi!","Ai nói chiến bào của ta có thể đổi thành đồ đỏ đó chắc chắn là âm mưu của Tôn Lưu!","Hừ! Nếu đuổi kịp ta, ta sẽ tặng đồ đỏ.","Ngươi là một vị danh tướng, đừng vì vài món đồ đỏ mà làm phản triều đình!","Chỉ có đồ đỏ mới là điều quan trọng!","Trong thiên hạ hiếm ai có được đồ đỏ",},
        [2] = {2,50000,"Truy Kích x1","Truy Kích x10","","Anh hùng đừng đánh ta!","Anh hùng thủ hạ lưu tình, ta sẽ cho người đồ tốt!","Đau quá!","Hãy đuổi theo ta!","Đừng đánh ta! Trang bị đều cho ngươi!","Ai nói chiến bào của ta có thể đổi thành đồ đỏ đó chắc chắn là âm mưu của Tôn Lưu!","Hừ! Nếu đuổi kịp ta, ta sẽ tặng đồ đỏ.","Ngươi là một vị danh tướng, đừng vì vài món đồ đỏ mà làm phản triều đình!","Chỉ có đồ đỏ mới là điều quan trọng!","Trong thiên hạ hiếm ai có được đồ đỏ",},
        [3] = {1001,50000,"Chiêm Tinh x1","Chiêm Tinh x10","Thanh Long mất sau","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa",},
        [4] = {1002,50000,"Chiêm Tinh x1","Chiêm Tinh x10","Huyền Vũ mất sau|Thanh Long mất sau","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa",},
        [5] = {1003,50000,"Chiêm Tinh x1","Chiêm Tinh x10","Huyền Vũ mất sau|Bạch Hổ mất sau|Thánh Côn mất sau|Thanh Long mất sau","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa",},
        [6] = {1004,50000,"Chiêm Tinh x1","Chiêm Tinh x10","Huyền Vũ mất sau|Niên Thú mất sau|Bạch Hổ mất sau|Kỳ Lân mất sau|Thánh Côn mất sau|Thanh Long mất sau|Chu Tước mất sau","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa",},
        [7] = {1401,50000,"Thuần ngựa 1 lần","Thuần ngựa 10 lần","","","","","","","","","","","",},
        [8] = {1501,50000,"Thuần ngựa 1 lần","Thuần ngựa 10 lần","Rời Ô Vân còn|Rời Chiếu Dạ còn|Rời Hỏa Long còn|Rời Phi Sương còn","","","","","","Rượu ngon ở đâu, ta sẽ đến đó","Các ngươi không muốn sống nữa sao","Ngọc có thể nát chứ không thể đổi màu, trúc có thể đốt chứ không thể hủy khí tiết","Phi ngựa như bay, vượt ải trảm tướng chấn động đất trời","Chuyện nhỏ nhặt không đáng để ta lo!",},
    }
}

return equipment_active