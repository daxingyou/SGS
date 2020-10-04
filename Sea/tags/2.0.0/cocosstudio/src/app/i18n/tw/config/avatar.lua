--avatar

local avatar = {
    -- key
    __key_map = {
      id = 1,    --变身卡id_key-int 
      list_name = 2,    --变身卡列表名称-繁体-string 
      name = 3,    --变身卡名称-繁体-string 
      description = 4,    --变身卡描述-繁体-string 
      talk = 5,    --变身卡气泡说话-繁体-string 
      batch = 6,    --期数-int 
      is_work = 7,    --是否生效-int 
    
    },
    -- data
    _data = {
        [1] = {0,"0","0","0","我要一統三國, 成為蓋世英雄!",0,1,},
        [2] = {1106,"    曹仁    變身卡","曹仁變身卡","主角曹仁變身卡, 穿戴之後可以擁有曹仁變身卡技能, 天賦, 神兵特性, 同時擁有張郃變身卡, 曹沖變身卡, 樂進變身卡, 可以啟動額外屬性.","敵軍圍困萬千重, 我自巋然不動!",1,1,},
        [3] = {1110,"    張郃    變身卡","張郃變身卡","主角張郃變身卡, 穿戴之後可以擁有張郃變身卡技能, 天賦, 神兵特性, 同時擁有曹仁變身卡, 樂進變身卡, 于禁變身卡, 可以啟動額外屬性.","用兵之道, 變化萬千.",1,1,},
        [4] = {1113,"    樂進    變身卡","樂進變身卡","主角樂進變身卡, 穿戴之後可以擁有樂進變身卡技能, 天賦, 神兵特性, 同時擁有張郃變身卡, 曹仁變身卡, 于禁變身卡, 可以啟動額外屬性.","看我先登城頭, 立下首功!",1,1,},
        [5] = {1115,"    曹沖    變身卡","曹沖變身卡","主角曹沖變身卡, 穿戴之後可以擁有曹沖變身卡技能, 天賦, 神兵特性, 同時擁有曹仁變身卡, 張遼變身卡, 于禁變身卡, 徐晃變身卡, 可以啟動額外屬性.","父親, 父親, 看沖兒的!",1,1,},
        [6] = {1119,"    于禁    變身卡","于禁變身卡","主角于禁變身卡, 穿戴之後可以擁有于禁變身卡技能, 天賦, 神兵特性, 同時擁有張郃變身卡, 曹沖變身卡, 樂進變身卡, 可以啟動額外屬性.","穩重行軍, 百戰不殆.",1,1,},
        [7] = {1109,"    張遼    變身卡","張遼變身卡","主角張遼變身卡, 穿戴之後可以擁有張遼變身卡技能, 天賦, 神兵特性, 同時擁有甄姬變身卡, 曹沖變身卡, 可以啟動額外屬性.","沒想到吧!",1,1,},
        [8] = {1112,"    甄姬    變身卡","甄姬變身卡","主角甄姬變身卡, 穿戴之後可以擁有甄姬變身卡技能, 天賦, 神兵特性, 同時擁有張遼變身卡, 徐晃變身卡, 可以啟動額外屬性.","淩波微步, 羅襪生塵.",1,1,},
        [9] = {1114,"    徐晃    變身卡","徐晃變身卡","主角徐晃變身卡, 穿戴之後可以擁有徐晃變身卡技能, 天賦, 神兵特性, 同時擁有甄姬變身卡, 許褚變身卡, 張春華變身卡, 曹沖變身卡, 可以啟動額外屬性.","截其援, 斷其糧, 賊可擒也!",2,1,},
        [10] = {1104,"    郭嘉    變身卡","郭嘉變身卡","主角郭嘉變身卡, 穿戴之後可以擁有郭嘉變身卡技能, 天賦, 神兵特性, 同時擁有夏侯惇變身卡, 曹植變身卡, 可以啟動額外屬性.","咳, 咳……",2,1,},
        [11] = {1105,"  夏侯惇  變身卡","夏侯惇變身卡","主角夏侯惇變身卡, 穿戴之後可以擁有夏侯惇變身卡技能, 天賦, 神兵特性, 同時擁有郭嘉變身卡, 夏侯淵變身卡, 可以啟動額外屬性.","以彼之道, 還施彼身!",2,1,},
        [12] = {1116,"    曹植    變身卡","曹植變身卡","主角曹植變身卡, 穿戴之後可以擁有曹植變身卡技能, 天賦, 神兵特性, 同時擁有郭嘉變身卡, 荀彧變身卡, 夏侯淵變身卡, 張春華變身卡, 可以啟動額外屬性.","本是同根生, 相煎何太急!",2,1,},
        [13] = {1117,"  夏侯淵  變身卡","夏侯淵變身卡","主角夏侯淵變身卡, 穿戴之後可以擁有夏侯淵變身卡技能, 天賦, 神兵特性, 同時擁有夏侯惇變身卡, 曹植變身卡, 可以啟動額外屬性.","孤善於千里襲人!",2,1,},
        [14] = {1107,"    典韋    變身卡","典韋變身卡","主角典韋變身卡, 穿戴之後可以擁有典韋變身卡技能, 天賦, 神兵特性, 同時擁有許褚變身卡, 張春華變身卡, 可以啟動額外屬性.","主公!快走……",2,1,},
        [15] = {1108,"    許褚    變身卡","許褚變身卡","主角許褚變身卡, 穿戴之後可以擁有許褚變身卡技能, 天賦, 神兵特性, 同時擁有典韋變身卡, 徐晃變身卡, 可以啟動額外屬性.","誰來和我大戰三百回合!",2,1,},
        [16] = {1118,"  張春華  變身卡","張春華變身卡","主角張春華變身卡, 穿戴之後可以擁有張春華變身卡技能, 天賦, 神兵特性, 同時擁有典韋變身卡, 曹丕變身卡, 曹植變身卡, 徐晃變身卡, 可以啟動額外屬性.","你的死活與我何干!",3,1,},
        [17] = {1102,"    荀彧    變身卡","荀彧變身卡","主角變荀彧身卡, 穿戴之後可以擁有荀彧變身卡技能, 天賦, 神兵特性, 同時擁有曹丕變身卡, 曹植變身卡, 可以啟動額外屬性.","秉忠貞之志, 守謙退之節.",3,1,},
        [18] = {1111,"    曹丕    變身卡","曹丕變身卡","主角曹丕變身卡, 穿戴之後可以擁有曹丕變身卡技能, 天賦, 神兵特性, 同時擁有荀彧變身卡, 張春華變身卡, 可以啟動額外屬性.","給我翻過來!",3,1,},
        [19] = {1205,"    關羽    變身卡","關羽變身卡","主角關羽變身卡, 穿戴之後可以擁有關羽變身卡技能, 天賦, 神兵特性, 同時擁有張飛變身卡, 祝融變身卡, 阿斗變身卡可以啟動額外屬性.","觀爾乃插標賣首.",1,1,},
        [20] = {1206,"    張飛    變身卡","張飛變身卡","主角張飛變身卡, 穿戴之後可以擁有張飛變身卡技能, 天賦, 神兵特性, 同時擁有關羽變身卡, 孟獲變身卡, 阿斗變身卡, 可以啟動額外屬性.","燕人張飛在此!",1,1,},
        [21] = {1213,"    孟獲    變身卡","孟獲變身卡","主角孟獲變身卡, 穿戴之後可以擁有孟獲變身卡技能, 天賦, 神兵特性, 同時擁有張飛變身卡, 祝融變身卡, 阿斗變身卡, 可以啟動額外屬性.","背黑鍋我來, 送死~你去!",1,1,},
        [22] = {1214,"    祝融    變身卡","祝融變身卡","主角祝融變身卡, 穿戴之後可以擁有祝融變身卡技能, 天賦, 神兵特性, 同時擁有關羽變身卡, 黃月英變身卡, 孟獲變身卡, 關銀屏變身卡, 可以啟動額外屬性.","亮兵器吧～",1,1,},
        [23] = {1215,"    阿斗    變身卡","阿斗變身卡","主角阿斗變身卡, 穿戴之後可以擁有阿斗變身卡技能, 天賦, 神兵特性, 同時擁有張飛變身卡, 關羽變身卡, 孟獲變身卡, 可以啟動額外屬性.","愛卿可放手一搏.",1,1,},
        [24] = {1204,"  黃月英  變身卡","黃月英變身卡","主角黃月英變身卡, 穿戴之後可以擁有黃月英變身卡技能, 天賦, 神兵特性, 同時擁有徐庶變身卡, 祝融變身卡, 可以啟動額外屬性.","馭巧器, 已取先機.",1,1,},
        [25] = {1212,"    徐庶    變身卡","徐庶變身卡","主角徐庶變身卡, 穿戴之後可以擁有徐庶變身卡技能, 天賦, 神兵特性, 同時擁有黃月英變身卡, 關銀屏變身卡, 可以啟動額外屬性.","一切盡在不言中.",1,1,},
        [26] = {1217,"  關銀屏  變身卡","關銀屏變身卡","主角關銀屏變身卡, 穿戴之後可以擁有關銀屏變身卡技能, 天賦, 神兵特性, 同時擁有徐庶變身卡, 龐統變身卡, 關平變身卡, 祝融變身卡, 可以啟動額外屬性.","虎父無犬女!",2,1,},
        [27] = {1207,"    馬超    變身卡","馬超變身卡","主角馬超變身卡, 穿戴之後可以擁有變身卡技能, 天賦, 神兵特性, 同時擁有黃忠變身卡, 張星彩變身卡, 可以啟動額外屬性.","全軍突擊!!!",2,1,},
        [28] = {1208,"    黃忠    變身卡","黃忠變身卡","主角黃忠變身卡, 穿戴之後可以擁有黃忠變身卡技能, 天賦, 神兵特性, 同時擁有馬超變身卡, 法正變身卡, 可以啟動額外屬性.","烈弓之下片甲不留!",2,1,},
        [29] = {1216,"  張星彩  變身卡","張星彩變身卡","主角張星彩變身卡, 穿戴之後可以擁有張星彩變身卡技能, 天賦, 神兵特性, 同時擁有馬超變身卡, 劉備變身卡, 關平變身卡, 法正變身卡, 可以啟動額外屬性.","體察民意, 感悟聖心.",2,1,},
        [30] = {1219,"    法正    變身卡","法正變身卡","主角法正變身卡, 穿戴之後可以擁有法正變身卡技能, 天賦, 神兵特性, 同時擁有黃忠變身卡, 張星彩變身卡, 可以啟動額外屬性.","滴水之恩, 湧泉以報!",2,1,},
        [31] = {1209,"    姜維    變身卡","姜維變身卡","主角姜維變身卡, 穿戴之後可以擁有姜維變身卡技能, 天賦, 神兵特性, 同時擁有龐統變身卡, 關平變身卡, 可以啟動額外屬性.","先帝之志, 丞相之托, 不可忘也!",2,1,},
        [32] = {1211,"    龐統    變身卡","龐統變身卡","主角龐統變身卡, 穿戴之後可以擁有龐統變身卡技能, 天賦, 神兵特性, 同時擁有姜維變身卡, 關銀屏變身卡可以啟動額外屬性.","浴火重生!",2,1,},
        [33] = {1218,"    關平    變身卡","關平變身卡","主角關平變身卡, 穿戴之後可以擁有關平變身卡技能, 天賦, 神兵特性, 同時擁有姜維變身卡, 魏延變身卡, 張星彩變身卡, 關銀屏變身卡, 可以啟動額外屬性.","龍嘯九天, 武聖顯靈!",3,1,},
        [34] = {1202,"    劉備    變身卡","劉備變身卡","主角劉備變身卡, 穿戴之後可以擁有劉備變身卡技能, 天賦, 神兵特性, 同時擁有魏延變身卡, 張星彩變身卡, 可以啟動額外屬性.","惟賢惟德, 仁服於人!",3,1,},
        [35] = {1210,"    魏延    變身卡","魏延變身卡","主角魏延變身卡, 穿戴之後可以擁有魏延變身卡技能, 天賦, 神兵特性, 同時擁有劉備變身卡, 關平變身卡, 可以啟動額外屬性.","哼, 也不看看我是何人.",3,1,},
        [36] = {1304,"    小喬    變身卡","小喬變身卡","主角小喬變身卡, 穿戴之後可以擁有小喬變身卡技能, 天賦, 神兵特性, 同時擁有甘寧變身卡, 黃蓋變身卡, 步練師變身卡, 可以啟動額外屬性.","替我擋著~",1,1,},
        [37] = {1308,"    甘寧    變身卡","甘寧變身卡","主角甘甯變身卡, 穿戴之後可以擁有甘寧變身卡技能, 天賦, 神兵特性, 同時擁有小喬變身卡, 黃蓋變身卡, 韓當變身卡, 可以啟動額外屬性.","接招吧!",1,1,},
        [38] = {1314,"    黃蓋    變身卡","黃蓋變身卡","主角黃蓋變身卡, 穿戴之後可以擁有黃蓋變身卡技能, 天賦, 神兵特性, 同時擁有甘寧變身卡, 小喬變身卡, 韓當變身卡, 可以啟動額外屬性.","請鞭撻我吧, 公瑾!",1,1,},
        [39] = {1317,"  步練師  變身卡","步練師變身卡","主角步練師變身卡, 穿戴之後可以擁有步練師變身卡技能, 天賦, 神兵特性, 同時擁有小喬變身卡, 太史慈變身卡, 韓當變身卡, 張昭變身卡, 可以啟動額外屬性.","且聽臣妾一曲~",1,1,},
        [40] = {1318,"    韓當    變身卡","韓當變身卡","主角韓當變身卡, 穿戴之後可以擁有韓當變身卡技能, 天賦, 神兵特性, 同時擁有甘寧變身卡, 黃蓋變身卡, 步練師變身卡, 可以啟動額外屬性.","吃我一箭!",1,1,},
        [41] = {1305,"  太史慈  變身卡","太史慈變身卡","主角太史慈變身卡, 穿戴之後可以擁有太史慈變身卡技能, 天賦, 神兵特性, 同時擁有陸遜變身卡, 步練師變身卡, 可以啟動額外屬性.","我當要替天行道!",1,1,},
        [42] = {1311,"    陸遜    變身卡","陸遜變身卡","主角陸遜變身卡, 穿戴之後可以擁有陸遜變身卡技能, 天賦, 神兵特性, 同時擁有太史慈變身卡, 張昭變身卡, 可以啟動額外屬性.","國之大計, 審勢為先.",1,1,},
        [43] = {1315,"    張昭    變身卡","張昭變身卡","主角張昭變身卡, 穿戴之後可以擁有張昭變身卡技能, 天賦, 神兵特性, 同時擁有陸遜變身卡, 魯肅變身卡, 凌統變身卡, 步練師變身卡, 可以啟動額外屬性.","請恕老臣直言!",2,1,},
        [44] = {1306,"    孫權    變身卡","孫權變身卡","主角孫權變身卡, 穿戴之後可以擁有孫權變身卡技能, 天賦, 神兵特性, 同時擁有呂蒙變身卡, 諸葛瑾變身卡, 可以啟動額外屬性.","且慢, 容我三思.",2,1,},
        [45] = {1307,"    呂蒙    變身卡","呂蒙變身卡","主角呂蒙變身卡, 穿戴之後可以擁有呂蒙變身卡技能, 天賦, 神兵特性, 同時擁有孫權變身卡, 周泰變身卡, 可以啟動額外屬性.","攻城為下, 攻心為上.",2,1,},
        [46] = {1316,"    周泰    變身卡","周泰變身卡","主角周泰變身卡, 穿戴之後可以擁有周泰變身卡技能, 天賦, 神兵特性, 同時擁有呂蒙變身卡, 諸葛瑾變身卡, 可以啟動額外屬性.","哼, 這點小傷算什麼!",2,1,},
        [47] = {1319,"  諸葛瑾  變身卡","諸葛瑾變身卡","主角諸葛瑾變身卡, 穿戴之後可以擁有諸葛瑾變身卡技能, 天賦, 神兵特性, 同時擁有孫權變身卡, 大喬變身卡, 周泰變身卡, 凌統變身卡, 可以啟動額外屬性.","明以洞察, 哲以保身.",2,1,},
        [48] = {1310,"  孫尚香  變身卡","孫尚香變身卡","主角孫尚香變身卡, 穿戴之後可以擁有孫尚香變身卡技能, 天賦, 神兵特性, 同時擁有魯肅變身卡, 凌統變身卡, 可以啟動額外屬性.","夫君, 身體要緊~",2,1,},
        [49] = {1312,"    魯肅    變身卡","魯肅變身卡","主角魯肅變身卡, 穿戴之後可以擁有魯肅變身卡技能, 天賦, 神兵特性, 同時擁有孫尚香變身卡, 張昭變身卡, 可以啟動額外屬性.","來來來, 見面分一半.",2,1,},
        [50] = {1313,"    凌統    變身卡","凌統變身卡","主角凌統變身卡, 穿戴之後可以擁有淩統變身卡技能, 天賦, 神兵特性, 同時擁有孫尚香變身卡, 孫堅變身卡, 諸葛瑾變身卡, 張昭變身卡, 可以啟動額外屬性.","索命於須臾之間.",3,1,},
        [51] = {1302,"    大喬    變身卡","大喬變身卡","主角大喬變身卡, 穿戴之後可以擁有大喬變身卡技能, 天賦, 神兵特性, 同時擁有孫堅變身卡, 諸葛瑾變身卡, 可以啟動額外屬性.","旅途勞頓, 請休息吧.",3,1,},
        [52] = {1309,"    孫堅    變身卡","孫堅變身卡","主角孫堅變身卡, 穿戴之後可以擁有孫堅變身卡技能, 天賦, 神兵特性, 同時擁有大喬變身卡, 凌統變身卡, 可以啟動額外屬性.","以吾魂魄, 保佑吾兒之基業英魂.",3,1,},
        [53] = {1408,"  公孫瓚  變身卡","公孫瓚變身卡","主角公孫瓚變身卡, 穿戴之後可以擁有公孫瓚變身卡技能, 天賦, 神兵特性, 同時擁有于吉變身卡, 陳宮變身卡, 呂靈雎變身卡, 可以啟動額外屬性.","眾將聽令, 排好陣勢, 禦敵!",1,1,},
        [54] = {1410,"    于吉    變身卡","于吉變身卡","主角于吉變身卡, 穿戴之後可以擁有于吉變身卡技能, 天賦, 神兵特性, 同時擁有公孫瓚變身卡, 陳宮變身卡, 呂靈雎變身卡, 可以啟動額外屬性.","如真似幻, 撲朔迷離.",1,1,},
        [55] = {1416,"    陳宮    變身卡","陳宮變身卡","主角陳宮變身卡, 穿戴之後可以擁有陳宮變身卡技能, 天賦, 神兵特性, 同時擁有公孫瓚變身卡, 于吉變身卡, 呂靈雎變身卡, 可以啟動額外屬性.","如此, 霸業可圖也~",1,1,},
        [56] = {1418,"  呂靈雎  變身卡","呂靈雎變身卡","主角呂靈雎變身卡, 穿戴之後可以擁有呂靈雎變身卡技能, 天賦, 神兵特性, 同時擁有公孫瓚變身卡, 陳宮變身卡, 張讓變身卡, 可以啟動額外屬性.","我是你惹不起的小公舉!",1,1,},
        [57] = {1419,"    張讓    變身卡","張讓變身卡","主角張讓變身卡, 穿戴之後可以擁有張讓變身卡技能, 天賦, 神兵特性, 同時擁有于吉變身卡, 張角變身卡, 呂靈雎變身卡, 孔融變身卡, 可以啟動額外屬性.","我的大剪刀早已饑渴難耐!",1,1,},
        [58] = {1409,"    張角    變身卡","張角變身卡","主角張角變身卡, 穿戴之後可以擁有張角變身卡技能, 天賦, 神兵特性, 同時擁有袁術變身卡, 張讓變身卡, 可以啟動額外屬性.","以我之真氣, 合天地之造化!",1,1,},
        [59] = {1412,"    袁術    變身卡","袁術變身卡","主角袁術變身卡, 穿戴之後可以擁有袁術變身卡技能, 天賦, 神兵特性, 同時擁有張角變身卡, 孔融變身卡, 可以啟動額外屬性.","玉璽在手, 天下我有!",1,1,},
        [60] = {1417,"    孔融    變身卡","孔融變身卡","主角孔融變身卡, 穿戴之後可以擁有孔融變身卡技能, 天賦, 神兵特性, 同時擁有張角變身卡, 袁紹變身卡, 顏良變身卡, 張讓變身卡, 可以啟動額外屬性.","謙者, 德之柄也, 讓者, 禮之主也.",2,1,},
        [61] = {1406,"    華雄    變身卡","華雄變身卡","主角華雄變身卡, 穿戴之後可以擁有華雄變身卡技能, 天賦, 神兵特性, 同時擁有賈詡變身卡, 蔡文姬變身卡, 可以啟動額外屬性.","好大一股酒氣啊.",2,1,},
        [62] = {1407,"    賈詡    變身卡","賈詡變身卡","主角賈詡變身卡, 穿戴之後可以擁有賈詡變身卡技能, 天賦, 神兵特性, 同時擁有華雄變身卡, 文醜變身卡, 可以啟動額外屬性.","我要你三更死, 誰敢留你到五更!",2,1,},
        [63] = {1414,"    文醜    變身卡","文醜變身卡","主角文醜變身卡, 穿戴之後可以擁有文醜變身卡技能, 天賦, 神兵特性, 同時擁有賈詡變身卡, 蔡文姬變身卡, 可以啟動額外屬性.","吾乃河北上將文醜是也!",2,1,},
        [64] = {1415,"  蔡文姬  變身卡","蔡文姬變身卡","主角蔡文姬變身卡, 穿戴之後可以擁有蔡文姬變身卡技能, 天賦, 神兵特性, 同時擁有華雄變身卡, 華佗變身卡, 文醜變身卡, 顏良變身卡, 可以啟動額外屬性.","流落異鄉愁斷腸.",2,1,},
        [65] = {1405,"    董卓    變身卡","董卓變身卡","主角董卓變身卡, 穿戴之後可以擁有董卓變身卡技能, 天賦, 神兵特性, 同時擁有袁紹變身卡, 顏良變身卡, 可以啟動額外屬性.","嘿嘿嘿, 美人兒, 來, 香一個~",2,1,},
        [66] = {1411,"    袁紹    變身卡","袁紹變身卡","主角袁紹變身卡, 穿戴之後可以擁有袁紹變身卡技能, 天賦, 神兵特性, 同時擁有董卓變身卡, 孔融變身卡, 可以啟動額外屬性.","四世三公, 名冠天下.",2,1,},
        [67] = {1413,"    顏良    變身卡","顏良變身卡","主角顏良變身卡, 穿戴之後可以擁有顏良變身卡技能, 天賦, 神兵特性, 同時擁有董卓變身卡, 貂蟬變身卡, 孔融變身卡, 蔡文姬變身卡, 可以啟動額外屬性.","快來與我等決一死戰!",3,1,},
        [68] = {1402,"    華佗    變身卡","華佗變身卡","主角華佗變身卡, 穿戴之後可以擁有華佗變身卡技能, 天賦, 神兵特性, 同時擁有貂蟬身卡, 蔡文姬變身卡, 可以啟動額外屬性.","早睡早起, 方能養生!",3,1,},
        [69] = {1404,"    貂蟬    變身卡","貂蟬變身卡","主角貂蟬變身卡, 穿戴之後可以擁有貂蟬變身卡技能, 天賦, 神兵特性, 同時擁有華佗變身卡, 顏良變身卡, 可以啟動額外屬性.","夫君, 你要替妾身做主啊~",3,1,},
        [70] = {191111,"    曹丕    變身卡","曹丕變身卡","主角曹丕變身卡, 穿戴之後可以擁有曹丕變身卡技能, 天賦, 神兵特性, 同時擁有甄姬, 夏侯惇(紅)變身卡, 可以啟動額外屬性.","給我翻過來!",3,1,},
        [71] = {191205,"    關羽    變身卡","關羽變身卡","主角關羽變身卡, 穿戴之後可以擁有關羽變身卡技能, 天賦, 神兵特性, 同時擁有張飛, 馬超(紅)變身卡可以啟動額外屬性.","觀爾乃插標賣首.",3,1,},
        [72] = {191308,"    甘寧    變身卡","甘寧變身卡","主角甘甯變身卡, 穿戴之後可以擁有甘寧變身卡技能, 天賦, 神兵特性, 同時擁有陸遜, 呂蒙(紅)變身卡, 可以啟動額外屬性.","接招吧!",3,1,},
        [73] = {191411,"    袁紹    變身卡","袁紹變身卡","主角袁紹變身卡, 穿戴之後可以擁有袁紹變身卡技能, 天賦, 神兵特性, 同時擁有貂蟬, 董卓(紅)變身卡, 可以啟動額外屬性.","四世三公, 名冠天下.",3,1,},
        [74] = {191105,"  夏侯惇  變身卡","夏侯惇變身卡","主角夏侯惇變身卡, 穿戴之後可以擁有夏侯惇變身卡技能, 天賦, 神兵特性, 同時擁有張郃, 曹丕(紅)變身卡, 可以啟動額外屬性.","以彼之道, 還施彼身!",3,1,},
        [75] = {191207,"    馬超    變身卡","馬超變身卡","主角馬超變身卡, 穿戴之後可以擁有變身卡技能, 天賦, 神兵特性, 同時擁有龐統, 關羽(紅)變身卡, 可以啟動額外屬性.","全軍突擊!!!",3,1,},
        [76] = {191307,"    呂蒙    變身卡","呂蒙變身卡","主角呂蒙變身卡, 穿戴之後可以擁有呂蒙變身卡技能, 天賦, 神兵特性, 同時擁有太史慈, 甘寧(紅)變身卡, 可以啟動額外屬性.","攻城為下, 攻心為上.",3,1,},
        [77] = {191405,"    董卓    變身卡","董卓變身卡","主角董卓變身卡, 穿戴之後可以擁有董卓變身卡技能, 天賦, 神兵特性, 同時擁有公孫瓚, 袁紹(紅)變身卡, 可以啟動額外屬性.","嘿嘿嘿, 美人兒, 來, 香一個~",3,1,},
        [78] = {191108,"    許褚    變身卡","許褚變身卡","主角許褚變身卡, 穿戴之後可以擁有許褚變身卡技能, 天賦, 神兵特性, 同時擁有典韋變身卡, 可以啟動額外屬性.","誰來和我大戰三百回合!",4,1,},
        [79] = {191208,"    黃忠    變身卡","黃忠變身卡","主角黃忠變身卡, 穿戴之後可以擁有黃忠變身卡技能, 天賦, 神兵特性, 同時擁有魏延變身卡, 可以啟動額外屬性.","烈弓之下片甲不留!",4,1,},
        [80] = {191310,"  孫尚香  變身卡","孫尚香變身卡","主角孫尚香變身卡, 穿戴之後可以擁有孫尚香變身卡技能, 天賦, 神兵特性, 同時擁有大喬變身卡, 可以啟動額外屬性.","夫君, 身體要緊~",4,1,},
        [81] = {191407,"    賈詡    變身卡","賈詡變身卡","主角賈詡變身卡, 穿戴之後可以擁有賈詡變身卡技能, 天賦, 神兵特性, 同時擁有于吉變身卡, 可以啟動額外屬性.","我要你三更死, 誰敢留你到五更!",4,1,},
        [82] = {191102,"    荀彧    變身卡","荀彧變身卡","主角變荀彧身卡, 穿戴之後可以擁有荀彧變身卡技能, 天賦, 神兵特性, 同時擁有郭嘉, 許褚(紅)變身卡, 可以激活額外屬性.","秉忠貞之志, 守謙退之節.",4,1,},
        [83] = {191202,"    劉備    變身卡","劉備變身卡","主角劉備變身卡, 穿戴之後可以擁有劉備變身卡技能, 天賦, 神兵特性, 同時擁有徐庶, 黃忠(紅)變身卡, 可以激活額外屬性.","惟賢惟德, 仁服於人!",4,1,},
        [84] = {191302,"    大喬    變身卡","大喬變身卡","主角大喬變身卡, 穿戴之後可以擁有大喬變身卡技能, 天賦, 神兵特性, 同時擁有魯肅, 孫尚香(紅)變身卡, 可以激活額外屬性.","旅途勞頓, 請休息吧.",4,1,},
        [85] = {191402,"    華佗    變身卡","華佗變身卡","主角華佗變身卡, 穿戴之後可以擁有華佗變身卡技能, 天賦, 神兵特性, 同時擁有華雄, 賈詡(紅), 可以激活額外屬性.","早睡早起, 方能養生!",4,1,},
        [86] = {191107,"    典韋    變身卡","典韋變身卡","主角典韋變身卡, 穿戴之後可以擁有典韋變身卡技能, 天賦, 神兵特性, 同時擁有曹仁, 張郃(紅)變身卡, 可以激活額外屬性.","主公!快走……",4,1,},
        [87] = {191209,"    姜維    變身卡","姜維變身卡","主角姜維變身卡, 穿戴之後可以擁有姜維變身卡技能, 天賦, 神兵特性, 同時擁有黃忠, 龐統(紅)變身卡, 可以激活額外屬性.","先帝之志, 丞相之托, 不可忘也!",4,1,},
        [88] = {191306,"    孫權    變身卡","孫權變身卡","主角孫權變身卡, 穿戴之後可以擁有孫權變身卡技能, 天賦, 神兵特性, 同時擁有呂蒙, 小喬(紅)變身卡可以激活額外屬性.","且慢, 容我三思.",4,1,},
        [89] = {191406,"    華雄    變身卡","華雄變身卡","主角華雄變身卡, 穿戴之後可以擁有華雄變身卡技能, 天賦, 神兵特性, 同時擁有賈詡, 袁術(紅)變身卡, 可以激活額外屬性.","好大一股酒氣啊.",4,1,},
        [90] = {191110,"    張郃    變身卡","張郃變身卡","主角張郃變身卡, 穿戴之後可以擁有張郃變身卡技能, 天賦, 神兵特性, 同時擁有曹丕, 典韋(紅)變身卡, 可以激活額外屬性.","用兵之道, 變化萬千.",4,1,},
        [91] = {191211,"    龐統    變身卡","龐統變身卡","主角龐統變身卡, 穿戴之後可以擁有龐統變身卡技能, 天賦, 神兵特性, 同時擁有黃月英, 姜維(紅)變身卡可以激活額外屬性.","浴火重生!",4,1,},
        [92] = {191304,"    小喬    變身卡","小喬變身卡","主角小喬變身卡, 穿戴之後可以擁有小喬變身卡技能, 天賦, 神兵特性, 同時擁有孫尚香, 孫權(紅)變身卡, 可以激活額外屬性.","替我擋著~",4,1,},
        [93] = {191412,"    袁術    變身卡","袁術變身卡","主角袁術變身卡, 穿戴之後可以擁有袁術變身卡技能, 天賦, 神兵特性, 同時擁有張角, 華雄(紅)變身卡, 可以激活額外屬性.","玉璽在手, 天下我有!",4,1,},
        [94] = {191104,"    郭嘉    變身卡","郭嘉變身卡","主角郭嘉變身卡, 穿戴之後可以擁有郭嘉變身卡技能, 天賦, 神兵特性, 同時擁有荀彧變身卡, 張遼(紅)變身卡可以激活額外屬性.","咳, 咳……",4,1,},
        [95] = {191212,"    徐庶    變身卡","徐庶變身卡","主角徐庶變身卡, 穿戴之後可以擁有徐庶變身卡技能, 天賦, 神兵特性, 同時擁有關羽變身卡, 黃月英(紅)變身卡可以激活額外屬性.","一切盡在不言中.",4,1,},
        [96] = {191312,"    魯肅    變身卡","魯肅變身卡","主角魯肅變身卡, 穿戴之後可以擁有魯肅變身卡技能, 天賦, 神兵特性, 同時擁有小喬變身卡, 太史慈(紅)變身卡可以激活額外屬性.","來來來, 見面分一半.",4,1,},
        [97] = {191409,"    張角    變身卡","張角變身卡","主角張角變身卡, 穿戴之後可以擁有張角變身卡技能, 天賦, 神兵特性, 同時擁有華佗變身卡, 貂蟬(紅)變身卡可以激活額外屬性.","以我之真氣, 合天地之造化!",4,1,},
        [98] = {191109,"    張遼    變身卡","張遼變身卡","主角張遼變身卡, 穿戴之後可以擁有張遼變身卡技能, 天賦, 神兵特性, 同時擁有夏侯惇變身卡, 郭嘉(紅)變身卡可以激活額外屬性.","沒想到吧!",4,1,},
        [99] = {191204,"  黃月英  變身卡","黃月英變身卡","主角黃月英變身卡, 穿戴之後可以擁有黃月英變身卡技能, 天賦, 神兵特性, 同時擁有劉備變身卡, 徐庶(紅)變身卡, 可以激活額外屬性.","馭巧器, 已取先機.",4,1,},
        [100] = {191305,"  太史慈  變身卡","太史慈變身卡","主角太史慈變身卡, 穿戴之後可以擁有太史慈變身卡技能, 天賦, 神兵特性, 同時擁有孫權變身卡, 魯肅(紅)變身卡, 可以激活額外屬性.","我當要替天行道!",4,1,},
        [101] = {191404,"    貂蟬    變身卡","貂蟬變身卡","主角貂蟬變身卡, 穿戴之後可以擁有貂蟬變身卡技能, 天賦, 神兵特性, 同時擁有董卓變身卡, 張角(紅)變身卡, 可以激活額外屬性.","夫君, 你要替妾身做主啊~",4,1,},
        [102] = {191106,"    曹仁    變身卡","曹仁變身卡","主角曹仁變身卡, 穿戴之後可以擁有曹仁變身卡技能, 天賦, 神兵特性, 同時擁有許褚變身卡, 甄姬(紅)變身卡可以激活額外屬性.","敵軍圍困萬千重, 我自巋然不動!",4,1,},
        [103] = {191206,"    張飛    變身卡","張飛變身卡","主角張飛變身卡, 穿戴之後可以擁有張飛變身卡技能, 天賦, 神兵特性, 同時擁有馬超變身卡, 魏延(紅)變身卡可以激活額外屬性.","燕人張飛在此!",4,1,},
        [104] = {191309,"    孫堅    變身卡","孫堅變身卡","主角孫堅變身卡, 穿戴之後可以擁有孫堅變身卡技能, 天賦, 神兵特性, 同時擁有甘寧變身卡, 陸遜(紅)變身卡可以激活額外屬性.","以吾魂魄, 保佑吾兒之基業英魂.",4,1,},
        [105] = {191408,"  公孫瓚  變身卡","公孫瓚變身卡","主角公孫瓚變身卡, 穿戴之後可以擁有公孫瓚變身卡技能, 天賦, 神兵特性, 同時擁有袁紹變身卡, 于吉(紅)變身卡可以激活額外屬性.","眾將聽令, 排好陣勢, 禦敵!",4,1,},
        [106] = {191112,"    甄姬    變身卡","甄姬變身卡","主角甄姬變身卡, 穿戴之後可以擁有甄姬變身卡技能, 天賦, 神兵特性, 同時擁有張遼變身卡, 曹仁(紅)變身卡, 可以激活額外屬性.","淩波微步, 羅襪生塵.",4,1,},
        [107] = {191210,"    魏延    變身卡","魏延變身卡","主角魏延變身卡, 穿戴之後可以擁有魏延變身卡技能, 天賦, 神兵特性, 同時擁有姜維變身卡, 張飛(紅)變身卡, 可以激活額外屬性.","哼, 也不看看我是何人.",4,1,},
        [108] = {191311,"    陸遜    變身卡","陸遜變身卡","主角陸遜變身卡, 穿戴之後可以擁有陸遜變身卡技能, 天賦, 神兵特性, 同時擁有孫堅變身卡, 孫堅(紅)變身卡, 可以激活額外屬性.","國之大計, 審勢為先.",4,1,},
        [109] = {191410,"    于吉    變身卡","于吉變身卡","主角于吉變身卡, 穿戴之後可以擁有于吉變身卡技能, 天賦, 神兵特性, 同時擁有袁術變身卡, 公孫瓚(紅)變身卡, 可以激活額外屬性.","如真似幻, 撲朔迷離.",4,1,},
    }
}

return avatar