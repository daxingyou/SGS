--play_horse_bubble

local play_horse_bubble = {
    -- key
    __key_map = {
      rank = 1,    --名次_key-int 
      text_1 = 2,    --文本1-越南语-string 
      text_2 = 3,    --文本2-越南语-string 
      text_3 = 4,    --文本3-越南语-string 
      text_4 = 5,    --文本4-越南语-string 
      text_5 = 6,    --文本5-越南语-string 
      text_6 = 7,    --文本6-越南语-string 
      text_7 = 8,    --文本7-越南语-string 
      text_8 = 9,    --文本8-越南语-string 
      text_9 = 10,    --文本9-越南语-string 
      text_10 = 11,    --文本10-越南语-string 
      text_11 = 12,    --文本11-越南语-string 
      text_12 = 13,    --文本12-越南语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"Mở đầu hạng 1, giữ vững hạng 1.","Các ngươi hãy nghỉ ngơi, ta sẽ giành hạng 1.","Các ngươi chạy quá chậm, hoàn toàn không phải đối thủ của ta!","Thức ăn hôm nay không tệ, chắc chắn giành hạng 1!","Đây chính là chạy nhanh như gió, chưa thấy qua sao?","Đến lúc thể hiện thực lực rồi.","Chân các ngươi bị gắn chì sao mà chạy chậm thế!","Hãy cố gắng xông lên!","Phía trước là điểm cuối, hạng 1 chắc chắn là của ta.","Ta tuổi mèo, còn các ngươi chỉ là rùa, haha!","Hạng 1 chắc chắn thuộc về ta.","Xông lên, sắp thắng rồi!",},
        [2] = {2,"Mới bắt đầu chạy nhanh thế, hãy để giành sức cho một lát nữa xông lên!","Nhường ngươi một chút, đợi ta vận công sẽ đuổi kịp ngươi.","Đừng đắc ý, ta sẽ nhanh chóng đuổi kịp.","Chạy xong chúng ta đi uống tí rượu và hát vài bài có được không?","Ta còn chưa dốc hết toàn lực.","Hôm nay không phải ngươi hạng 1 sẽ là ta hạng 2...","Chỉ một chút nữa thôi, phải cố lên!","Xem vóc dáng của ta là biết sẽ giành thứ hạng cao!","Ngoài hạng 1 ra, hạng 2 và hạng 5 đâu có khác biệt gì.","Ta không muốn đứng thứ 2!","Cố gắng lên nào.","Chút xíu nữa thôi!",},
        [3] = {3,"Coi như ta nhường các ngươi, đừng vội đắc ý.","Cái này gọi là bảo lưu thể lực, các ngươi có hiểu không.","Các ngươi đừng nhìn ta, ta sẽ giành hạng 1.","Chạy thì chạy, đừng nói nhiều!","Thi đấu mới được nửa chặng đường, vẫn chưa phân thắng bại.","Đừng xem thường Lăng Ba Vi Bộ của ta, sẽ nhanh chóng đuổi kịp các ngươi.","Hai người phía trước hãy đợi ta!","Một số người, bản thân chạy không nổi, còn trách người khác.","Ta sẽ nhanh chóng đuổi kịp những người phía trước.","Hạng 3 cũng được!","Ta không lấy hạng 3 đâu!","Thua lần này cũng không sao, lần sau cố gắng lên!",},
        [4] = {4,"Không được, sao ta lại hạng 2 từ dưới đếm lên!","Trang bị trên người nặng, đợi ta tháo bớt sẽ đuổi kịp.","Mở đầu hơi chậm, đợi ta vận công.","Đừng chê ta chậm, ta đã cố gắng.","Đừng xem thường ta, ai chẳng có lúc bị trượt ngã.","Phía trước chạy chậm lại, các ngươi rớt vàng rồi.","Có câu nói là người sau sẽ vượt người trước, hãy tin ta.","Mục tiêu còn quá xa, mệt quá!","Chắc khó mà lọt vào top 3, đáng ghét.","Không thể hạng 1 từ dưới lên được.","Sắp đến rồi, chắc không về cuối đâu.","Không được nản, lần sau tham gia tiếp!",},
        [5] = {5,"Mở đầu chậm, không có nghĩa là sẽ chậm mãi.","Đừng xem thường giờ ta hạng 5, có thể cuối cùng ta sẽ giành hạng 1!","Ta đã từng luyện tập, đừng xem thường ta.","Thức ăn hôm nay rất ngon, ăn quá nhiều chạy không nổi!","Phù, mệt quá, chạy không nổi rồi.","Đợi ta với!","Biết vậy không thức khuya, mệt quá!","Ta cũng mệt, tối nay phải tẩm bổ!","Hôm qua ai đã bỏ thuốc xổ cho ta! Ta chạy không nổi nữa rồi.","Chậm thôi, ta sắp rớt khỏi màn hình rồi.","Các ngươi tăng động hay sao mà chạy nhanh thế!","Nhìn cái gì? Không thấy người ta chạy hay sao!",},
    }
}

return play_horse_bubble