--achievement

local achievement = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --编号-int 
      theme = 2,    --主题-string 
      content = 3,    --成就内容-string 
    
    },
    -- data
    _data = {
        [1] = {102001,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [2] = {102002,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [3] = {102003,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [4] = {102004,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [5] = {102005,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [6] = {102006,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [7] = {102007,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [8] = {102008,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [9] = {102009,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [10] = {102010,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [11] = {102011,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [12] = {102012,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [13] = {102013,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [14] = {102014,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [15] = {102015,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [16] = {102016,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [17] = {102017,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [18] = {102018,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [19] = {102019,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [20] = {102020,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [21] = {102021,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [22] = {102022,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [23] = {102023,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [24] = {102024,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [25] = {102025,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [26] = {102026,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [27] = {102027,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [28] = {102028,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [29] = {102029,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [30] = {102030,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [31] = {102031,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [32] = {102032,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [33] = {102033,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [34] = {102034,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [35] = {102035,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [36] = {102036,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [37] = {102037,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [38] = {102038,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [39] = {102039,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [40] = {102040,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [41] = {102041,"星点灯","ストーリークエストで獲得した星が合計★%d個に到達する",},
        [42] = {104001,"成長おめでとう","Lv%dになりました",},
        [43] = {104002,"成長おめでとう","Lv%dになりました",},
        [44] = {104003,"成長おめでとう","Lv%dになりました",},
        [45] = {104004,"成長おめでとう","Lv%dになりました",},
        [46] = {104005,"成長おめでとう","Lv%dになりました",},
        [47] = {104006,"成長おめでとう","Lv%dになりました",},
        [48] = {104007,"成長おめでとう","Lv%dになりました",},
        [49] = {104008,"成長おめでとう","Lv%dになりました",},
        [50] = {104009,"成長おめでとう","Lv%dになりました",},
        [51] = {104010,"成長おめでとう","Lv%dになりました",},
        [52] = {104011,"成長おめでとう","Lv%dになりました",},
        [53] = {104012,"成長おめでとう","Lv%dになりました",},
        [54] = {104013,"成長おめでとう","Lv%dになりました",},
        [55] = {105001,"日々向上","戦闘力が%dに達する",},
        [56] = {105002,"日々向上","戦闘力が%dに達する",},
        [57] = {105003,"日々向上","戦闘力が%dに達する",},
        [58] = {105004,"日々向上","戦闘力が%dに達する",},
        [59] = {105005,"日々向上","戦闘力が%dに達する",},
        [60] = {105006,"日々向上","戦闘力が%dに達する",},
        [61] = {105007,"日々向上","戦闘力が%dに達する",},
        [62] = {105008,"日々向上","戦闘力が%dに達する",},
        [63] = {105009,"日々向上","戦闘力が%dに達する",},
        [64] = {105010,"日々向上","戦闘力が%dに達する",},
        [65] = {107001,"ファイト！","全出陣武将の突破がLv%d以上になる",},
        [66] = {107002,"ファイト！","全出陣武将の突破がLv%d以上になる",},
        [67] = {107003,"ファイト！","全出陣武将の突破がLv%d以上になる",},
        [68] = {107004,"ファイト！","全出陣武将の突破がLv%d以上になる",},
        [69] = {107005,"ファイト！","全出陣武将の突破がLv%d以上になる",},
        [70] = {107006,"ファイト！","全出陣武将の突破がLv%d以上になる",},
        [71] = {107007,"ファイト！","全出陣武将の突破がLv%d以上になる",},
        [72] = {107008,"ファイト！","全出陣武将の突破がLv%d以上になる",},
        [73] = {107009,"ファイト！","全出陣武将の突破がLv%d以上になる",},
        [74] = {107010,"ファイト！","全出陣武将の突破がLv%d以上になる",},
        [75] = {109001,"宝物レベルアップ","全宝物がLv%dになる",},
        [76] = {109002,"宝物レベルアップ","全宝物がLv%dになる",},
        [77] = {109003,"宝物レベルアップ","全宝物がLv%dになる",},
        [78] = {109004,"宝物レベルアップ","全宝物がLv%dになる",},
        [79] = {109005,"宝物レベルアップ","全宝物がLv%dになる",},
        [80] = {109006,"宝物レベルアップ","全宝物がLv%dになる",},
        [81] = {109007,"宝物レベルアップ","全宝物がLv%dになる",},
        [82] = {109008,"宝物レベルアップ","全宝物がLv%dになる",},
        [83] = {109009,"宝物レベルアップ","全宝物がLv%dになる",},
        [84] = {109010,"宝物レベルアップ","全宝物がLv%dになる",},
        [85] = {110001,"宝物精錬","全宝物をR%dまで精錬",},
        [86] = {110002,"宝物精錬","全宝物をR%dまで精錬",},
        [87] = {110003,"宝物精錬","全宝物をR%dまで精錬",},
        [88] = {110004,"宝物精錬","全宝物をR%dまで精錬",},
        [89] = {110005,"宝物精錬","全宝物をR%dまで精錬",},
        [90] = {110006,"宝物精錬","全宝物をR%dまで精錬",},
        [91] = {110007,"宝物精錬","全宝物をR%dまで精錬",},
        [92] = {110008,"宝物精錬","全宝物をR%dまで精錬",},
        [93] = {110009,"宝物精錬","全宝物をR%dまで精錬",},
        [94] = {110010,"宝物精錬","全宝物をR%dまで精錬",},
        [95] = {112001,"兵力増強","出陣武将が%d人に到達",},
        [96] = {112002,"兵力増強","出陣武将が%d人に到達",},
        [97] = {112003,"兵力増強","出陣武将が%d人に到達",},
        [98] = {113001,"昇進","官職が護軍に昇進する",},
        [99] = {113002,"昇進","司馬に昇進しました",},
        [100] = {113003,"昇進","官職昇進: 都尉",},
        [101] = {113004,"昇進","校尉に昇進しました",},
        [102] = {113005,"昇進","官職昇進: 太守",},
        [103] = {113006,"昇進","刺史に昇進しました",},
        [104] = {113007,"昇進","中郎将に昇進しました",},
        [105] = {113008,"昇進","京兆尹に昇進しました",},
        [106] = {113009,"昇進","尚書令に昇進しました",},
        [107] = {113010,"昇進","官職昇進: 衛将軍",},
        [108] = {113011,"昇進","官職昇進: 大都督",},
        [109] = {113012,"昇進","大将軍に昇進しました",},
        [110] = {114001,"装備(紫)の加護","出陣中の武将で装備(紫)を%d個以上着用する",},
        [111] = {114002,"装備(紫)の加護","出陣中の武将で装備(紫)を%d個以上着用する",},
        [112] = {114003,"装備(紫)の加護","出陣中の武将で装備(紫)を%d個以上着用する",},
        [113] = {114004,"装備(ｵﾚﾝｼﾞ)加護","出陣中の武将で装備(ｵﾚﾝｼﾞ)を%d個以上着用する",},
        [114] = {114005,"装備(ｵﾚﾝｼﾞ)加護","出陣中の武将で装備(ｵﾚﾝｼﾞ)を%d個以上着用する",},
        [115] = {114006,"装備(ｵﾚﾝｼﾞ)加護","出陣中の武将で装備(ｵﾚﾝｼﾞ)を%d個以上着用する",},
        [116] = {114007,"装備(ｵﾚﾝｼﾞ)加護","出陣中の武将で装備(ｵﾚﾝｼﾞ)を%d個以上着用する",},
        [117] = {114008,"装備(ｵﾚﾝｼﾞ)加護","出陣中の武将で装備(ｵﾚﾝｼﾞ)を%d個以上着用する",},
        [118] = {114009,"装備(ｵﾚﾝｼﾞ)加護","出陣中の武将で装備(ｵﾚﾝｼﾞ)を%d個以上着用する",},
        [119] = {115001,"装備精錬","全装備をLv%dまで精錬する",},
        [120] = {115002,"装備精錬","全装備をLv%dまで精錬する",},
        [121] = {115003,"装備精錬","全装備をLv%dまで精錬する",},
        [122] = {115004,"装備精錬","全装備をLv%dまで精錬する",},
        [123] = {115005,"装備精錬","全装備をLv%dまで精錬する",},
        [124] = {115006,"装備精錬","全装備をLv%dまで精錬する",},
        [125] = {115007,"装備精錬","全装備をLv%dまで精錬する",},
        [126] = {115008,"装備精錬","全装備をLv%dまで精錬する",},
        [127] = {115009,"装備精錬","全装備をLv%dまで精錬する",},
        [128] = {115010,"装備精錬","全装備をLv%dまで精錬する",},
        [129] = {115011,"装備精錬","全装備をLv%dまで精錬する",},
        [130] = {116001,"商店の達人","武将商店のラインナップを%d回更新",},
        [131] = {116002,"商店の達人","武将商店のラインナップを%d回更新",},
        [132] = {116003,"商店の達人","武将商店のラインナップを%d回更新",},
        [133] = {116004,"商店の達人","武将商店のラインナップを%d回更新",},
        [134] = {116005,"商店の達人","武将商店のラインナップを%d回更新",},
        [135] = {116006,"商店の達人","武将商店のラインナップを%d回更新",},
        [136] = {116007,"商店の達人","武将商店のラインナップを%d回更新",},
        [137] = {116008,"商店の達人","武将商店のラインナップを%d回更新",},
        [138] = {116009,"商店の達人","武将商店のラインナップを%d回更新",},
        [139] = {116010,"商店の達人","武将商店のラインナップを%d回更新",},
        [140] = {117001,"聚宝鉢","聚宝鉢を%d回使う",},
        [141] = {117002,"聚宝鉢","聚宝鉢を%d回使う",},
        [142] = {117003,"聚宝鉢","聚宝鉢を%d回使う",},
        [143] = {117004,"聚宝鉢","聚宝鉢を%d回使う",},
        [144] = {117005,"聚宝鉢","聚宝鉢を%d回使う",},
        [145] = {117006,"聚宝鉢","聚宝鉢を%d回使う",},
        [146] = {117007,"聚宝鉢","聚宝鉢を%d回使う",},
        [147] = {117008,"聚宝鉢","聚宝鉢を%d回使う",},
        [148] = {117009,"聚宝鉢","聚宝鉢を%d回使う",},
        [149] = {117010,"聚宝鉢","聚宝鉢を%d回使う",},
        [150] = {118001,"神器練磨","全神器をR%dまで練磨する",},
        [151] = {118002,"神器練磨","全神器をR%dまで練磨する",},
        [152] = {118003,"神器練磨","全神器をR%dまで練磨する",},
        [153] = {118004,"神器練磨","全神器をR%dまで練磨する",},
        [154] = {118005,"神器練磨","全神器をR%dまで練磨する",},
        [155] = {118006,"神器練磨","全神器をR%dまで練磨する",},
        [156] = {118007,"神器練磨","全神器をR%dまで練磨する",},
        [157] = {130001,"武将覚醒","武将は最大★%dまで覚醒",},
        [158] = {130002,"武将覚醒","武将は最大★%dまで覚醒",},
        [159] = {130003,"武将覚醒","武将は最大★%dまで覚醒",},
        [160] = {130004,"武将覚醒","武将は最大★%dまで覚醒",},
        [161] = {130005,"武将覚醒","武将は最大★%dまで覚醒",},
        [162] = {131001,"刻苦勉励","出陣武将6人全員を★%dまで覚醒させる",},
        [163] = {131002,"刻苦勉励","出陣武将6人全員を★%dまで覚醒させる",},
        [164] = {131003,"刻苦勉励","出陣武将6人全員を★%dまで覚醒させる",},
        [165] = {131004,"刻苦勉励","出陣武将6人全員を★%dまで覚醒させる",},
        [166] = {131005,"刻苦勉励","出陣武将6人全員を★%dまで覚醒させる",},
        [167] = {201001,"温酒斬華雄","味方の関羽が敵・華雄を撃破",},
        [168] = {202002,"生死をともに","曹丕が甄姫を撃破",},
        [169] = {203003,"火焼連営","陸遜、劉備を破る",},
        [170] = {204004,"赤壁の戦い","劉備と孫権の同時出陣で敵・曹操を倒す",},
        [171] = {205005,"泣き面に蜂","劉備と孫尚香の同時出陣で敵・周瑜を倒す",},
        [172] = {211001,"鳳儀亭","あと残っているのは呂布、董卓、貂蝉だけだ",},
        [173] = {212002,"三英戦呂布","味方は劉関張のみ、敵は呂布のみが残っています",},
        [174] = {221001,"美女の縁","甄姫、黄月英、孫尚香、大小喬、貂蝉が同時出陣",},
        [175] = {222002,"曹氏一族","曹丕、曹操、曹植、曹仁、曹沖が同時に出陣",},
        [176] = {223003,"孫氏一族","孫権、孫堅、孫策、孫尚香が同時に出陣",},
        [177] = {301001,"死んでも妥協しない","司馬懿は最初の3ターンの攻撃がすべて奥義攻撃",},
        [178] = {303001,"七進七出","趙雲は3ターンに4回連続攻撃",},
        [179] = {401001,"持久戦","10ターン以内に決着がつきませんでした",},
        [180] = {402002,"朝飯前","最初の攻撃で敵6人を全滅させる",},
        [181] = {501001,"幽冥誅仙刃","武将(金)・司馬昭の初回獲得時に、R25の専用金色神器がもらえます。",},
        [182] = {502001,"蒼松水韻琴","武将(金)・水鏡の初回獲得でR25限定神器(金)を入手できる",},
        [183] = {503001,"烈炎虹凰刀","武将(金)・周姫の初回獲得でR25限定神器(金)を入手できる",},
        [184] = {504001,"延陽追魂杖","武将(金)・南華の初回獲得で、R25限定神器(金)を入手できる",},
        [185] = {501002,"千葉流霜刀","武将(金)・王異の初回獲得でR25限定神器(金)を入手できる",},
        [186] = {502002,"神迅霊牛","武将(金)・諸葛果の初回獲得でR25限定神器(金)を入手できる",},
        [187] = {503002,"秘光幻玉剣","武将(金)・陸抗の初回獲得時に、R25の専用神器(金)がもらえます。",},
        [188] = {504002,"軽雲の煙管","武将(金)・盧植の初回獲得でR25限定神器(金)を入手できる",},
        [189] = {501003,"璇玑鎮魂灯","武将(金)管輅を初回獲得すると神器(金)R25を獲得できます",},
        [190] = {502003,"霊霄穿雲槍","武将(金)馬雲禄を初回獲得すると神器(金)R25を獲得できます",},
        [191] = {503003,"十方青玉刃","武将(金)朱桓を初回獲得すると神器(金)R25を獲得できます",},
        [192] = {504003,"霊巫破魔斧","武将(金)木鹿大王を初回獲得すると神器(金)R25を獲得できます",},
        [193] = {501004,"鬼霊奇韫筆","武将(金)周不疑を初回獲得すると神器(金)R25を獲得できます",},
        [194] = {502004,"百鳥朝鳳槍","武将(金)童淵を初回獲得すると神器(金)R25を獲得できます",},
        [195] = {503004,"仙蝶鳳箜篌","武将(金)孫姫を初回獲得すると神器(金)R25を獲得できます",},
        [196] = {504004,"寒冥破星槌","武将(金)董白を初回獲得すると神器(金)R25を獲得できます",},
    },

    -- index
    __index_id = {
        [102001] = 1,
        [102002] = 2,
        [102003] = 3,
        [102004] = 4,
        [102005] = 5,
        [102006] = 6,
        [102007] = 7,
        [102008] = 8,
        [102009] = 9,
        [102010] = 10,
        [102011] = 11,
        [102012] = 12,
        [102013] = 13,
        [102014] = 14,
        [102015] = 15,
        [102016] = 16,
        [102017] = 17,
        [102018] = 18,
        [102019] = 19,
        [102020] = 20,
        [102021] = 21,
        [102022] = 22,
        [102023] = 23,
        [102024] = 24,
        [102025] = 25,
        [102026] = 26,
        [102027] = 27,
        [102028] = 28,
        [102029] = 29,
        [102030] = 30,
        [102031] = 31,
        [102032] = 32,
        [102033] = 33,
        [102034] = 34,
        [102035] = 35,
        [102036] = 36,
        [102037] = 37,
        [102038] = 38,
        [102039] = 39,
        [102040] = 40,
        [102041] = 41,
        [104001] = 42,
        [104002] = 43,
        [104003] = 44,
        [104004] = 45,
        [104005] = 46,
        [104006] = 47,
        [104007] = 48,
        [104008] = 49,
        [104009] = 50,
        [104010] = 51,
        [104011] = 52,
        [104012] = 53,
        [104013] = 54,
        [105001] = 55,
        [105002] = 56,
        [105003] = 57,
        [105004] = 58,
        [105005] = 59,
        [105006] = 60,
        [105007] = 61,
        [105008] = 62,
        [105009] = 63,
        [105010] = 64,
        [107001] = 65,
        [107002] = 66,
        [107003] = 67,
        [107004] = 68,
        [107005] = 69,
        [107006] = 70,
        [107007] = 71,
        [107008] = 72,
        [107009] = 73,
        [107010] = 74,
        [109001] = 75,
        [109002] = 76,
        [109003] = 77,
        [109004] = 78,
        [109005] = 79,
        [109006] = 80,
        [109007] = 81,
        [109008] = 82,
        [109009] = 83,
        [109010] = 84,
        [110001] = 85,
        [110002] = 86,
        [110003] = 87,
        [110004] = 88,
        [110005] = 89,
        [110006] = 90,
        [110007] = 91,
        [110008] = 92,
        [110009] = 93,
        [110010] = 94,
        [112001] = 95,
        [112002] = 96,
        [112003] = 97,
        [113001] = 98,
        [113002] = 99,
        [113003] = 100,
        [113004] = 101,
        [113005] = 102,
        [113006] = 103,
        [113007] = 104,
        [113008] = 105,
        [113009] = 106,
        [113010] = 107,
        [113011] = 108,
        [113012] = 109,
        [114001] = 110,
        [114002] = 111,
        [114003] = 112,
        [114004] = 113,
        [114005] = 114,
        [114006] = 115,
        [114007] = 116,
        [114008] = 117,
        [114009] = 118,
        [115001] = 119,
        [115002] = 120,
        [115003] = 121,
        [115004] = 122,
        [115005] = 123,
        [115006] = 124,
        [115007] = 125,
        [115008] = 126,
        [115009] = 127,
        [115010] = 128,
        [115011] = 129,
        [116001] = 130,
        [116002] = 131,
        [116003] = 132,
        [116004] = 133,
        [116005] = 134,
        [116006] = 135,
        [116007] = 136,
        [116008] = 137,
        [116009] = 138,
        [116010] = 139,
        [117001] = 140,
        [117002] = 141,
        [117003] = 142,
        [117004] = 143,
        [117005] = 144,
        [117006] = 145,
        [117007] = 146,
        [117008] = 147,
        [117009] = 148,
        [117010] = 149,
        [118001] = 150,
        [118002] = 151,
        [118003] = 152,
        [118004] = 153,
        [118005] = 154,
        [118006] = 155,
        [118007] = 156,
        [130001] = 157,
        [130002] = 158,
        [130003] = 159,
        [130004] = 160,
        [130005] = 161,
        [131001] = 162,
        [131002] = 163,
        [131003] = 164,
        [131004] = 165,
        [131005] = 166,
        [201001] = 167,
        [202002] = 168,
        [203003] = 169,
        [204004] = 170,
        [205005] = 171,
        [211001] = 172,
        [212002] = 173,
        [221001] = 174,
        [222002] = 175,
        [223003] = 176,
        [301001] = 177,
        [303001] = 178,
        [401001] = 179,
        [402002] = 180,
        [501001] = 181,
        [501002] = 185,
        [501003] = 189,
        [501004] = 193,
        [502001] = 182,
        [502002] = 186,
        [502003] = 190,
        [502004] = 194,
        [503001] = 183,
        [503002] = 187,
        [503003] = 191,
        [503004] = 195,
        [504001] = 184,
        [504002] = 188,
        [504003] = 192,
        [504004] = 196,
    }
}

return achievement