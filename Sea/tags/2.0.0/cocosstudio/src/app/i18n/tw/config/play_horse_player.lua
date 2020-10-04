--play_horse_player

local play_horse_player = {
    -- key
    __key_map = {
      rank = 1,    --名次_key-int 
      text_1 = 2,    --文本1-繁体-string 
      text_2 = 3,    --文本2-繁体-string 
      text_3 = 4,    --文本3-繁体-string 
      text_4 = 5,    --文本4-繁体-string 
    
    },
    -- data
    _data = {
        [1] = {1,"戰力代表我的實力!我將永遠守護我的愛情, 信仰和家人!","我第一那是我會玩!你們跟我沖一樣的錢未必能打贏我!","誰贏?你們去看看戰力榜誰第一!","不好意思, 你們所有人, 我都沒放在眼裡!",},
        [2] = {2,"來來來, 今天跑步比賽我肯定第一!","十大戰力我第二!哈哈哈哈!","我不像某些人, 我第二向來很低調!","並不是我想當主角, 我就是主角!",},
        [3] = {3,"好幾次沒選對了吧!今天選我肯定沒錯!","第二有什麼好得意的, 我第三馬上就超過你!","兵家勝敗真常事, 卷甲重來未可知.","雖然認輸不會死, 但我死也不認輸!",},
        [4] = {4,"選我, 你絕對不會後悔!","前三都這麼霸氣, 我第四就低調一點.","說礦戰一點都不好玩的, 你還挖了這麼久!","新玩法什麼時候出, 期待!",},
        [5] = {5,"這麼熱鬧, 我講幾個笑話給大家助助興怎麼樣.","每天都要提高戰力, 是我玩遊戲的態度!","良禽擇木而棲, 賢臣擇主而事.","當你蹲下再站起, 聽到膝蓋發出聲響, 那你要注意了, 這說明你的聽力正常.",},
        [6] = {6,"你說的沒錯!我不想默默無聞!","戰力第六的我, 覺得自己吉祥如意, 萌萌噠~","水能載舟, 亦可煮粥.","上盈其志, 下務其功；悠悠黃河, 吾其濟乎!",},
        [7] = {7,"某位大佬, 你不是人造革, 你是真的皮!","我這個人, 脾氣不好性子傲, 吊兒郎當又愛笑.","我可能是鹽吃多了, 閑的總是想你.","一場比賽的時間, 我沒看比賽, 一直在看你.",},
        [8] = {8,"有些人講的笑話太冷了.","我不想輸給其他傢伙!","會玩的, 玩哪個陣營都很強；不會玩的, 玩哪個陣營都在罵.","馬上會開界限突破, 到時候大家戰力又能漲一波!",},
        [9] = {9,"你們覺得大喬好看還是貂蟬好看?","為了排行榜第九, 我每天都在努力提高戰力!","他們都說我喜歡聊天, 其實我只想和你聊天.","一呂二趙三典韋, 四關五馬六張飛.",},
        [10] = {10,"能上十大戰力, 我已經很開心了!","一二三四五, 金木水火土, 戰力第十最靠譜!","智者務其實, 愚者爭虛名.","你們怎麼玩的, 戰力都那麼高?",},
        [11] = {11,"難道你說我會輸, 我就不跑了嗎?不試試我怎麼會甘心!","所以, 我要來...狠狠地…贏得這場比賽!","2018俄羅斯世界盃: 阿根廷輸給了冠亞軍.","紛紛世事無窮盡, 天數茫茫不可逃.",},
        [12] = {12,"為比賽而熱血, 就算輸了也無所謂!","魏延的暈眩減怒可好用了!","誰能告訴我, 到底哪個陣營更厲害?","拼將一死酬知己, 致令千秋仰義名.",},
        [13] = {13,"如果我改了名字, 你們還認識我是誰嗎?","三國的時候有跑步比賽嗎?","草堂春睡足, 窗外日遲遲.","萬事不由人做主, 一心難與命爭衡.",},
        [14] = {14,"我想贏!","龐統突十很厲害, 你們不知道嗎?","小霸王孫策, 打後排太厲害了!","一壺濁酒喜相逢, 古今多少事, 都付笑談中.",},
        [15] = {15,"真希望能夠快點贏得這場比賽!","養個徐庶用來過主線, 真是太爽了!","想贏嗎?秘訣就是, 選我吧!","強中自有強中手, 用詐還逢識詐人.",},
        [16] = {16,"等這麼久才開賽, 不如講幾個段子讓大家樂一樂.","我要當歐皇!紅將, 紅裝碗裡來!","罵托, 可是遊戲的一大樂趣.","獨善其身盡日安, 何須千古名不朽!",},
        [17] = {17,"有沒有豪來發個雙倍紅包呢!","多弄幾個紅色錦囊, 我肯定能打敗那傢伙!","攢了好久水晶, 終於可以換紅色錦囊了!","黃口孺子, 怎聞霹靂之聲；病體樵夫, 難聽虎豹之吼.",},
        [18] = {18,"能原諒女人謊言的才是真正的男人.","就你們話多, 讓我安安靜靜跑個比賽不行嗎.","噓!讓我安安靜靜的想她一會.","你在幹嘛? 唯一的正確回答是 : 在和你聊天.",},
        [19] = {19,"既不回頭, 何必不忘；既然無緣, 何必誓言.","正經比賽, 禁止逗比說話!","我愛你們所有人, 前提是你們讓我贏!","汝不識賢愚, 是眼濁也；不讀詩書, 是口濁也；不納忠言, 是耳濁也.",},
        [20] = {20,"除了我自己, 我不允許任何人輕視我!","我是人, 你不是我, 所以你不是人.","琵琶精又來參加比賽?入場費賺了不少吧!","不通古今, 是身濁也；不容諸侯, 是腹濁也；常懷篡逆, 是心濁也!",},
        [21] = {21,"怎樣才能華麗的贏比賽呢!","大丈夫生居天地間, 豈能鬱鬱久居人下!","打敗我的不是天真, 而是天真熱!","還不開始, 有點無聊, 要不一起罵罵策劃!",},
        [22] = {22,"即使需要耐心和等待……我也想拿十大戰力!","家事國事天下事, 開心玩遊戲是大事!","豹子頭也可以很開心!","自古驕兵多致敗, 從來輕敵少成功.",},
        [23] = {23,"我只想依照我的信念做事, 絕不後悔, 不管現在將來都一樣!","山重水複疑無路, 柳暗花明又一坑.","總說我嘴硬, 其實我的內心很柔軟善良.","腐草之螢光, 怎及天心之皓月?",},
        [24] = {24,"無論你玩的是什麼陣容, 好好玩, 不會差!","蜀道難, 難就難在背誦全文.","血染征袍透甲紅, 當陽誰敢與爭鋒!","馬逢伯樂而嘶, 人遇知己而死.",},
        [25] = {25,"我要變得更快更高更強!","教訓一個人, 只需熟練掌握這兩句:  1, 下次做事之前多想想. 2, 你想多了.","事事如意料之外, 年年有餘額不足!","我從未見過如此厚顏無恥之人.",},
        [26] = {26,"天助自助者, 你要你就能!","我攢著元寶準備弄紅色錦囊呢!","天下大勢, 分久必合, 合久必分.","前無去路, 諸軍何不死戰?",},
        [27] = {27,"想減肥的人每天都再吃, 怎麼可能成功呢?","遇到抬杠繞道走, 離開杠精一聲吼, 心情若仍難平復, 從一數到九十九.","被門夾過的核桃, 還能補腦嗎?","臥龍, 鳳雛二人得一, 可安天下.",},
        [28] = {28,"我決心拿第一!","天臺擠不下了, 往我心裡擠擠.","每次開寶箱上電視, 都感覺有人在偷窺我.","馬騎赤兔行千里, 刀偃青龍出五關.",},
        [29] = {29,"暗自悲哀, 不如立即行動.","遍尋不著, 猶歎當年小蠻腰.空餘恨, 一身五花膘.","男人哭吧哭吧哭吧不是罪, 再強的人也有權利去疲憊.","大丈夫處世, 當努力建功立業, 著鞭在先.",},
        [30] = {30,"司馬懿的風火輪再快, 也比不上我!","說好的千年等一回, 結果一小時到了胃.","你們知道嗎, 大喬, 步練師, 貂蟬都會唱歌!","欲除禽獸必先獻身於禽獸.",},
        [31] = {31,"荀彧有驅虎吞狼之計, 我有腳下生風之能!","貓是種神奇的動物, 無論你貧窮還是富貴, 它都瞧不起你.","大都督太帥了, 可惜很少來參加比賽!","生死無二志, 丈夫何壯哉!",},
        [32] = {32,"對酒當歌的人, 跑步必輸!","信不信我跳起來能打碎你的膝蓋骨!","滿地都是小喬變身卡, 為什麼呢?","大夢誰先覺, 平生我自知!",},
        [33] = {33,"郭嘉有只翱翔萬里的鷹, 但在這賽場上肯定沒我跑得快!","你們都講笑話, 我來講幾個土味情話!","我發現一個小秘密, 太史慈放技能用腳在拉弓!","運籌又遇強中手, 鬥智還逢意外人.",},
        [34] = {34,"聽說夏侯惇的剛烈反傷很厲害?但論跑步還是我第一!","通常情況下對自己髮型不滿意的人, 永遠不承認是臉的問題.","孫權孫策兩兄弟, 一個打後排一個打前排!","豫州當日歎孤窮, 何幸南陽有臥龍!",},
        [35] = {35,"曹仁是個門板怪, 跑起步來我最帥!","說好的一日方休, 沒想到是夜以繼日!","呂蒙運氣好的時候能暈六個!","我和一程式師朋友借錢, 他打給了我1024元, 留言: 湊個整.",},
        [36] = {36,"主公快走, 這樣我就能拿第一了!","既然喝水都胖, 那我幹嘛不喝可樂?","甘寧扛著刀跑步的樣子太逗了!","大丈夫處世, 不能立功建業, 幾與草木同腐乎?",},
        [37] = {37,"許褚的流星錘重八十斤, 他肯定跑不快!","我的錢包鼓鼓的, 裡面裝滿了欠條.","孫堅是首回合自帶無敵盾的男人!","青山不老, 綠水長存.",},
        [38] = {38,"張遼善於千里奔襲, 我擅長跑步拿第一!","天殘腿和讓梨融, 誰跑步最逗比呢?","孫尚香最美, 輸出也很爆炸!","能戰當戰, 不能戰當守, 不能守當走, 不能走當降, 不能降當死耳!",},
        [39] = {39,"三國四大美女中, 我最喜歡甄姬!","多照照鏡子, 很多事情你就明白原因了.","陸遜配合孫策, 很厲害哦!","謀事在人, 成事在天.不可強也!",},
        [40] = {40,"曹丕合擊摟甄姬的腰, 他肯定跑不快!","曾夢想仗劍走天涯, 後來工作忙沒去, 因為一直玩遊戲.","魯肅也能暈眩減怒!","弦歌知雅意, 杯酒謝良朋.",},
        [41] = {41,"樂進的小短腿, 沒我跑得快!","只要是石頭, 到哪裡都不會發光的.","左慈和諸葛, 都是強控!","多言獲利, 不如默而無言.",},
        [42] = {42,"人是鐵, 飯是鋼!不吃飯怎麼跑得快!","都是九年義務教育, 你怎麼就那麼優秀呢.","貂蟬給呂布回四怒, 曹操看了很受傷!","蒼天如圓蓋, 陸地似棋局.",},
        [43] = {43,"趙雲抱著阿斗都能七進七出, 速度肯定快!","我想變成阿斗, 誰讓他有國寶呢!","你們試試去打主線的董卓, 痛不欲生!","兵在夜而不驚, 將聞變而不亂",},
        [44] = {44,"劉備以德服人, 但沒我跑得快啊!","發明狗眼看人低這句話的人, 一定沒有遇過貓.","有追擊的武將都加強了, 華雄也是!","自古以來, 有興必有廢, 有盛必有衰.",},
        [45] = {45,"臥龍觀星知天下事, 今天比賽我第一!","宇宙不爆炸, 床都懶得下；地球不重啟, 別想我早起.","賈詡的毒傷真炸天!","夫為將者, 能去能就, 能柔能剛；能進能退, 能弱能強.",},
        [46] = {46,"月英曾誇我是穎悟之人, 還告訴我比賽贏第一的方法!","沒有人知道誰是韭菜, 都覺得自己跑得比鐮刀快.","公孫瓚又暈又減怒, 過圖很好用!","萬事俱備, 只欠東風.",},
        [47] = {47,"關二爺再厲害, 也沒我跑得快!","每每要放棄, 又鬼使神差覺得自己還有戲, 這把比賽請選我!","張角既能沉默別人, 還不怕被別人沉默!","大丈夫只患功名不立, 何患無妻?",},
        [48] = {48,"百步穿楊, 老當益壯, 黃忠這麼厲害卻沒人用, 他會傷心的!","如果事與願違, 請記住, 命運另有安排.","你去打于吉, 有可能會中毒!","卿不負孤, 孤亦必不負卿也.",},
        [49] = {49,"馬超不騎馬, 肯定沒我快!","你永遠不會發現, 如果你永遠地忘記了一件事.","突十的袁紹配合呂布, 太厲害了!","識大體, 棄細務, 此乃君道.",},
        [50] = {50,"你看姜維手持金龍連弩, 像不像比賽的發令官!","自古深情留不住, 總是套路得人心.","袁術回怒又減怒, 可媲美小喬!","幸運的我擠進了戰力前五十!希望今天能拿第一!",},
    }
}

return play_horse_player