--equipment_active

local equipment_active = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name1 = 2,    --抽奖名称1-string 
      name2 = 3,    --抽奖名称2-string 
      time_name = 4,    --倒计时描述-string 
      hit_chat_1 = 5,    --被击喊话1-string 
      hit_chat_2 = 6,    --被击喊话2-string 
      hit_chat_3 = 7,    --被击喊话3-string 
      hit_chat_4 = 8,    --被击喊话4-string 
      hit_chat_5 = 9,    --被击喊话5-string 
      chat_1 = 10,    --常规喊话1-string 
      chat_2 = 11,    --常规喊话2-string 
      chat_3 = 12,    --常规喊话3-string 
      chat_4 = 13,    --常规喊话4-string 
      chat_5 = 14,    --常规喊话5-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Truy Kích x1","Truy Kích x10","","Anh hùng đừng đánh ta!","Anh hùng thủ hạ lưu tình, ta sẽ cho người đồ tốt!","Đau quá!","Hãy đuổi theo ta!","Đừng đánh ta! Trang bị đều cho ngươi!","Ai nói chiến bào của ta có thể đổi thành đồ đỏ đó chắc chắn là âm mưu của Tôn Lưu!","Hừ! Nếu đuổi kịp ta, ta sẽ tặng đồ đỏ.","Ngươi là một vị danh tướng, đừng vì vài món đồ đỏ mà làm phản triều đình!","Chỉ có đồ đỏ mới là điều quan trọng!","Trong thiên hạ hiếm ai có được đồ đỏ",},
        [2] = {2,"Truy Kích x1","Truy Kích x10","","Anh hùng đừng đánh ta!","Anh hùng thủ hạ lưu tình, ta sẽ cho người đồ tốt!","Đau quá!","Hãy đuổi theo ta!","Đừng đánh ta! Trang bị đều cho ngươi!","Ai nói chiến bào của ta có thể đổi thành đồ đỏ đó chắc chắn là âm mưu của Tôn Lưu!","Hừ! Nếu đuổi kịp ta, ta sẽ tặng đồ đỏ.","Ngươi là một vị danh tướng, đừng vì vài món đồ đỏ mà làm phản triều đình!","Chỉ có đồ đỏ mới là điều quan trọng!","Trong thiên hạ hiếm ai có được đồ đỏ",},
        [3] = {1001,"Chiêm Tinh x1","Chiêm Tinh x10","Thanh Long rời đi: ","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa",},
        [4] = {1002,"Chiêm Tinh x1","Chiêm Tinh x10","Huyền Vũ rời đi: |Thanh Long rời đi: ","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa",},
        [5] = {1003,"Chiêm Tinh x1","Chiêm Tinh x10","Huyền Vũ rời đi: |Bạch Hổ rời đi: |Thánh Côn rời đi: |Thanh Long rời đi: ","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa",},
        [6] = {1004,"Chiêm Tinh x1","Chiêm Tinh x10","Huyền Vũ rời đi: |Niên Thú rời đi: |Bạch Hổ rời đi: |Kỳ Lân rời đi: |Bạch Trạch rời đi: |Thánh Côn rời đi: |Thanh Long rời đi: |Chu Tước rời đi: ","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa",},
        [7] = {1005,"Chiêm Tinh x1","Chiêm Tinh x10","Huyền Vũ rời đi: |Niên Thú rời đi: |Bạch Hổ rời đi: |Kỳ Lân rời đi: |Bạch Trạch rời đi: |Thánh Côn rời đi: |Thanh Long rời đi: |Chu Tước rời đi: |Thánh Nguyên rời đi: ","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa","Đừng đánh nữa",},
        [8] = {1401,"Thuần ngựa 1 lần","Thuần ngựa 10 lần","","","","","","","","","","","",},
        [9] = {1501,"Thuần ngựa 1 lần","Thuần ngựa 10 lần","Ô Vân rời đi: |Chiếu Dạ rời đi: |Bôn Lôi rời đi: |Huyết Tông rời đi: |Hỏa Long rời đi: |Phi Sương rời đi: |Tử Tinh rời đi: ","","","","","","Rượu ngon ở đâu, ta sẽ đến đó","Các ngươi không muốn sống nữa sao","Ngọc có thể nát chứ không thể đổi màu, trúc có thể đốt chứ không thể hủy khí tiết","Phi ngựa như bay, vượt ải trảm tướng chấn động đất trời","Chuyện nhỏ nhặt không đáng để ta lo!",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [1001] = 3,
        [1002] = 4,
        [1003] = 5,
        [1004] = 6,
        [1005] = 7,
        [1401] = 8,
        [1501] = 9,
        [2] = 2,
    }
}

return equipment_active