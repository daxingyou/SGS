--hero_fate

local hero_fate = {
    -- key
    __key_map = {
      fate_id = 1,    --羁绊id_key-int 
      fate_name = 2,    --羁绊名称-繁体-string 
    
    },
    -- data
    _data = {
        [1] = {90151,"驚雷長槍",},
        [2] = {90152,"幻日戰甲",},
        [3] = {90153,"落月髮冠",},
        [4] = {90154,"幻影皮靴",},
        [5] = {90155,"真武麒麟弓",},
        [6] = {90156,"乾坤蛟鱗甲",},
        [7] = {90157,"無雙鳳翎盔",},
        [8] = {90158,"混元金剛靴",},
        [9] = {90163,"破軍·七殺槍",},
        [10] = {90164,"破軍·貪狼甲",},
        [11] = {90165,"破軍·銀獅盔",},
        [12] = {90166,"破軍·踏天靴",},
        [13] = {90167,"四神·青龍槍",},
        [14] = {90168,"四神·玄武甲",},
        [15] = {90169,"四神·白虎盔",},
        [16] = {90170,"四神·朱雀靴",},
        [17] = {90171,"八荒·饕餮戟",},
        [18] = {90172,"八荒·窮奇鎧",},
        [19] = {90173,"八荒·檮杌冠",},
        [20] = {90174,"八荒·混沌靴",},
        [21] = {10151,"奇策善謀",},
        [22] = {10152,"抗蜀北伐",},
        [23] = {10153,"九品中正制",},
        [24] = {10154,"當敵制決",},
        [25] = {10155,"深謀遠慮",},
        [26] = {10251,"唯才是舉",},
        [27] = {10252,"拔矢啖睛",},
        [28] = {10253,"救濟鄉里",},
        [29] = {10254,"天賦異稟",},
        [30] = {10255,"深謀遠慮",},
        [31] = {10351,"慧眼識主",},
        [32] = {10352,"奇策善謀",},
        [33] = {10353,"折衝左右",},
        [34] = {10354,"顧影自憐",},
        [35] = {10355,"曹魏氏族",},
        [36] = {10451,"慧眼識主",},
        [37] = {10452,"唯才是舉",},
        [38] = {10453,"出謀劃策",},
        [39] = {10454,"妄自菲薄",},
        [40] = {10455,"深謀遠慮",},
        [41] = {10551,"拔矢啖睛",},
        [42] = {10552,"勇冠三軍",},
        [43] = {10553,"後患無窮",},
        [44] = {10554,"兄弟齊心",},
        [45] = {10555,"鐵骨錚錚",},
        [46] = {10651,"拒超平叛",},
        [47] = {10652,"江陵戰瑜",},
        [48] = {10653,"官渡鏖戰",},
        [49] = {10654,"據守樊城",},
        [50] = {10655,"曹魏氏族",},
        [51] = {10751,"輔政平亂",},
        [52] = {10752,"折衝左右",},
        [53] = {10753,"無懈可擊",},
        [54] = {10754,"隕身殉節",},
        [55] = {10755,"鐵骨錚錚",},
        [56] = {10851,"威震淮汝",},
        [57] = {10852,"江陵戰瑜",},
        [58] = {10853,"勇猛直前",},
        [59] = {10854,"壯士解腕",},
        [60] = {10855,"鐵骨錚錚",},
        [61] = {10951,"驍勇善戰",},
        [62] = {10952,"銳不可當",},
        [63] = {10953,"守衛合肥",},
        [64] = {10954,"猛將如雲",},
        [65] = {10955,"鐵骨錚錚",},
        [66] = {11051,"官渡投曹",},
        [67] = {11052,"驍勇善戰",},
        [68] = {11053,"鹹有效勞",},
        [69] = {11054,"兵貴神速",},
        [70] = {11055,"深謀遠慮",},
        [71] = {11151,"九品中正制",},
        [72] = {11152,"病逝江都",},
        [73] = {11153,"格外禮遇",},
        [74] = {11154,"煮豆燃萁",},
        [75] = {11155,"曹魏氏族",},
        [76] = {11251,"盡算天下",},
        [77] = {11252,"墨守成規",},
        [78] = {11253,"兩宮之爭",},
        [79] = {11254,"洛神賦",},
        [80] = {11255,"曹魏氏族",},
        [81] = {15051,"上陣父子兵",},
        [82] = {15052,"改朝換代",},
        [83] = {15053,"素昧平生",},
        [84] = {15054,"母子連心",},
        [85] = {15055,"狼子野心",},
        [86] = {20151,"一身是膽",},
        [87] = {20152,"克定禍亂",},
        [88] = {20153,"無人可擋",},
        [89] = {20154,"單騎救主",},
        [90] = {20155,"無堅不摧",},
        [91] = {20251,"千里走單騎",},
        [92] = {20252,"七進七出",},
        [93] = {20253,"手到擒來",},
        [94] = {20254,"以德服人",},
        [95] = {20255,"桃園結義",},
        [96] = {20351,"臥龍鳳雛",},
        [97] = {20352,"三顧茅廬",},
        [98] = {20353,"羽扇關情",},
        [99] = {20354,"七擒七縱",},
        [100] = {20355,"龍駒鳳歟",},
        [101] = {20451,"羽扇關情",},
        [102] = {20452,"荊州名門",},
        [103] = {20453,"錦囊妙計",},
        [104] = {20454,"巾幗豪傑",},
        [105] = {20455,"龍駒鳳歟",},
        [106] = {20551,"華容道",},
        [107] = {20552,"心系漢室",},
        [108] = {20553,"千里走單騎",},
        [109] = {20554,"將門虎子",},
        [110] = {20555,"桃園結義",},
        [111] = {20651,"所向無敵",},
        [112] = {20652,"克定禍亂",},
        [113] = {20653,"折節學問",},
        [114] = {20654,"三國無雙",},
        [115] = {20655,"桃園結義",},
        [116] = {20751,"一身是膽",},
        [117] = {20752,"鎮守漢中",},
        [118] = {20753,"舉世無雙",},
        [119] = {20754,"衝鋒陷陣",},
        [120] = {20755,"無堅不摧",},
        [121] = {20851,"手下留情",},
        [122] = {20852,"百步穿楊",},
        [123] = {20853,"青出於藍",},
        [124] = {20854,"計斬妙才",},
        [125] = {20855,"無堅不摧",},
        [126] = {20951,"鞠躬盡瘁",},
        [127] = {20952,"龍戰於野",},
        [128] = {20953,"智勇雙全",},
        [129] = {20954,"勇冠三軍",},
        [130] = {20955,"無堅不摧",},
        [131] = {21051,"鎮守漢中",},
        [132] = {21052,"子午穀奇謀",},
        [133] = {21053,"長江後浪",},
        [134] = {21054,"橫掃千軍",},
        [135] = {21055,"無堅不摧",},
        [136] = {21151,"荊州名門",},
        [137] = {21152,"獻計征蜀",},
        [138] = {21153,"千慮一失",},
        [139] = {21154,"智者千慮",},
        [140] = {21155,"龍駒鳳歟",},
        [141] = {21251,"心系漢室",},
        [142] = {21252,"方寸大亂",},
        [143] = {21253,"兵不厭詐",},
        [144] = {21254,"拉攏士族",},
        [145] = {21255,"龍駒鳳歟",},
        [146] = {25051,"得意弟子",},
        [147] = {25052,"馬躍檀溪",},
        [148] = {25053,"忠心不二",},
        [149] = {25054,"文武雙全",},
        [150] = {25055,"荊州賢才",},
        [151] = {30151,"結拜兄弟",},
        [152] = {30152,"鶼鰈情深",},
        [153] = {30153,"酣鬥小霸王",},
        [154] = {30154,"英勇救主",},
        [155] = {30155,"東吳孫氏",},
        [156] = {30251,"江東二喬",},
        [157] = {30252,"鶼鰈情深",},
        [158] = {30253,"大家風範",},
        [159] = {30254,"琴歌酒賦",},
        [160] = {30255,"郎才女貌",},
        [161] = {30351,"顧曲周郎",},
        [162] = {30352,"賠了夫人又折兵",},
        [163] = {30353,"勇者無敵",},
        [164] = {30354,"苦肉計",},
        [165] = {30355,"四大都督",},
        [166] = {30451,"江東二喬",},
        [167] = {30452,"顧曲周郎",},
        [168] = {30453,"慧眼識才",},
        [169] = {30454,"沉魚落雁",},
        [170] = {30455,"郎才女貌",},
        [171] = {30551,"英雄出世",},
        [172] = {30552,"東吳大將",},
        [173] = {30553,"無人可擋",},
        [174] = {30554,"功勳卓著",},
        [175] = {30555,"氣吞山河",},
        [176] = {30651,"忍辱負重",},
        [177] = {30652,"虎父無犬子",},
        [178] = {30653,"火燒其門",},
        [179] = {30654,"青羅傘蓋",},
        [180] = {30655,"東吳孫氏",},
        [181] = {30751,"呂甘之交",},
        [182] = {30752,"白衣渡江",},
        [183] = {30753,"吳下阿蒙",},
        [184] = {30754,"侍奉孫氏",},
        [185] = {30755,"四大都督",},
        [186] = {30851,"臣死君憂",},
        [187] = {30852,"合縱抗曹",},
        [188] = {30853,"東吳大將",},
        [189] = {30854,"旋略勇進",},
        [190] = {30855,"氣吞山河",},
        [191] = {30951,"承歡膝下",},
        [192] = {30952,"英雄出世",},
        [193] = {30953,"虎父無犬子",},
        [194] = {30954,"英烈壯節",},
        [195] = {30955,"東吳孫氏",},
        [196] = {31051,"賠了夫人又折兵",},
        [197] = {31052,"美人如畫",},
        [198] = {31053,"閉月羞花",},
        [199] = {31054,"誨人不倦",},
        [200] = {31055,"東吳孫氏",},
        [201] = {31151,"琴棋書畫",},
        [202] = {31152,"勇冠三軍",},
        [203] = {31153,"足智多謀",},
        [204] = {31154,"火燒連營",},
        [205] = {31155,"四大都督",},
        [206] = {31251,"繼任都督",},
        [207] = {31252,"飽讀詩書",},
        [208] = {31253,"合縱抗曹",},
        [209] = {31254,"溫文爾雅",},
        [210] = {31255,"四大都督",},
        [211] = {35051,"赤壁鏖兵",},
        [212] = {35052,"視如己出",},
        [213] = {35053,"軟玉溫香",},
        [214] = {35054,"宣太子妃",},
        [215] = {35055,"英姿颯爽",},
        [216] = {40151,"異士奇人",},
        [217] = {40152,"亂世天下",},
        [218] = {40153,"厚德載物",},
        [219] = {40154,"文姬歸漢",},
        [220] = {40155,"仙風道骨",},
        [221] = {40251,"懸壺濟世",},
        [222] = {40252,"厚德載物",},
        [223] = {40253,"妙手仁心",},
        [224] = {40254,"剛直不阿",},
        [225] = {40255,"仙風道骨",},
        [226] = {40351,"轅門射戟",},
        [227] = {40352,"虎步下邳",},
        [228] = {40353,"比翼連枝",},
        [229] = {40354,"潰不成軍",},
        [230] = {40355,"鳳儀亭",},
        [231] = {40451,"比翼連枝",},
        [232] = {40452,"籌謀劃策",},
        [233] = {40453,"鶴髮童顏",},
        [234] = {40454,"傾國傾城",},
        [235] = {40455,"鳳儀亭",},
        [236] = {40551,"一方諸侯",},
        [237] = {40552,"效力涼州",},
        [238] = {40553,"左膀右臂",},
        [239] = {40554,"洛陽之亂",},
        [240] = {40555,"鳳儀亭",},
        [241] = {40651,"驕兵悍將",},
        [242] = {40652,"威武豪壯",},
        [243] = {40653,"威武不屈",},
        [244] = {40654,"刀下亡魂",},
        [245] = {40655,"鳳儀亭",},
        [246] = {40751,"效力涼州",},
        [247] = {40752,"餐松啖柏",},
        [248] = {40753,"頂天立地",},
        [249] = {40754,"北海為相",},
        [250] = {40755,"亂世梟雄",},
        [251] = {40851,"虎步下邳",},
        [252] = {40852,"籌謀劃策",},
        [253] = {40853,"舉棋不定",},
        [254] = {40854,"刀下亡魂",},
        [255] = {40855,"亂世梟雄",},
        [256] = {40951,"妖言惑眾",},
        [257] = {40952,"亂世天下",},
        [258] = {40953,"懸壺濟世",},
        [259] = {40954,"禍亂朝綱",},
        [260] = {40955,"仙風道骨",},
        [261] = {41051,"異士奇人",},
        [262] = {41052,"妖言惑眾",},
        [263] = {41053,"偏師副將",},
        [264] = {41054,"默寫古籍",},
        [265] = {41055,"仙風道骨",},
        [266] = {41151,"一方諸侯",},
        [267] = {41152,"汝南袁氏",},
        [268] = {41153,"驕兵悍將",},
        [269] = {41154,"一方諸侯",},
        [270] = {41155,"亂世梟雄",},
        [271] = {41251,"轅門射戟",},
        [272] = {41252,"勸張歸曹",},
        [273] = {41253,"精神矍鑠",},
        [274] = {41254,"袁術求親",},
        [275] = {41255,"亂世梟雄",},
        [276] = {45051,"仙人變換",},
        [277] = {45052,"妙手仁心",},
        [278] = {45053,"武可通神",},
        [279] = {45054,"隻手遮天",},
        [280] = {45055,"魑魅魍魎",},
        [281] = {11351,"驍果顯名",},
        [282] = {11352,"肱骨之臣",},
        [283] = {11353,"兵刃奇特",},
        [284] = {11354,"五子良將",},
        [285] = {11451,"討寇有功",},
        [286] = {11452,"解圍樊城",},
        [287] = {11453,"文帝昌盛",},
        [288] = {11454,"東征西討",},
        [289] = {11551,"長兄如父",},
        [290] = {11552,"年少成名",},
        [291] = {11553,"聰慧過人",},
        [292] = {11554,"曹沖稱象",},
        [293] = {11651,"才高八斗",},
        [294] = {11652,"後起之秀",},
        [295] = {11653,"放蕩不羈",},
        [296] = {11654,"曹操親眷",},
        [297] = {11751,"戰死定軍",},
        [298] = {11752,"人才濟濟",},
        [299] = {11753,"虎步關右",},
        [300] = {11754,"官渡鏖戰",},
        [301] = {11851,"義妹傳說",},
        [302] = {11852,"風華絕代",},
        [303] = {11853,"冰雪聰明",},
        [304] = {11854,"魏屬親眷",},
        [305] = {11951,"久經善戰",},
        [306] = {11952,"當敵制決",},
        [307] = {11953,"殊途同命",},
        [308] = {11954,"持軍嚴整",},
        [309] = {21351,"南蠻猛將",},
        [310] = {21352,"效命諸葛",},
        [311] = {21353,"同生共死",},
        [312] = {21354,"蜀國棟樑",},
        [313] = {21451,"蜀將之妻",},
        [314] = {21452,"同屬南蠻",},
        [315] = {21453,"同甘共苦",},
        [316] = {21454,"姿容秀麗",},
        [317] = {21551,"血溶于水",},
        [318] = {21552,"養育之恩",},
        [319] = {21553,"敬哀皇后",},
        [320] = {21554,"文臣武將",},
        [321] = {21651,"同胞兄妹",},
        [322] = {21652,"母女情深",},
        [323] = {21653,"風格迥異",},
        [324] = {21654,"兒時玩伴",},
        [325] = {21751,"姑嫂之親",},
        [326] = {21752,"不輸鬚眉",},
        [327] = {21753,"各有千秋",},
        [328] = {21754,"桃園之後",},
        [329] = {21851,"武聖牽連",},
        [330] = {21852,"荊州干戈",},
        [331] = {21853,"武聖子女",},
        [332] = {21854,"西蜀良臣",},
        [333] = {21951,"漢中之戰",},
        [334] = {21952,"良師益友",},
        [335] = {21953,"文韜武略",},
        [336] = {21954,"君臣之禮",},
        [337] = {31351,"征討黃祖",},
        [338] = {31352,"浴血鏖戰",},
        [339] = {31353,"聲名遠播",},
        [340] = {31354,"東吳悍將",},
        [341] = {31451,"追隨孫堅",},
        [342] = {31452,"老當益壯",},
        [343] = {31453,"苦肉連環",},
        [344] = {31454,"猛將如雲",},
        [345] = {31551,"太后在上",},
        [346] = {31552,"丞相之才",},
        [347] = {31553,"朝臣後妃",},
        [348] = {31554,"東吳重臣",},
        [349] = {31651,"襲取荊州",},
        [350] = {31652,"追隨孫權",},
        [351] = {31653,"仲謀之恩",},
        [352] = {31654,"英勇救主",},
        [353] = {31751,"吳國女眷",},
        [354] = {31752,"皇后公主",},
        [355] = {31753,"愛惜主公",},
        [356] = {31754,"朝堂和睦",},
        [357] = {31851,"大智大勇",},
        [358] = {31852,"當世大儒",},
        [359] = {31853,"安邦定國",},
        [360] = {31854,"江東虎臣",},
        [361] = {31951,"諸葛一家",},
        [362] = {31952,"東吳州牧",},
        [363] = {31953,"赤壁淵源",},
        [364] = {31954,"士族之後",},
        [365] = {41351,"名副其實",},
        [366] = {41352,"袁紹親故",},
        [367] = {41353,"同仇敵愾",},
        [368] = {41354,"群雄逐鹿",},
        [369] = {41451,"主公之子",},
        [370] = {41452,"玩世不恭",},
        [371] = {41453,"兄弟同心",},
        [372] = {41454,"大相徑庭",},
        [373] = {41551,"德藝雙馨",},
        [374] = {41552,"董卓部舊",},
        [375] = {41553,"天生麗質",},
        [376] = {41554,"紅花綠葉",},
        [377] = {41651,"斬殺黃巾",},
        [378] = {41652,"與布有故",},
        [379] = {41653,"呂布親從",},
        [380] = {41654,"同食漢祿",},
        [381] = {41751,"學富五車",},
        [382] = {41752,"南北諸侯",},
        [383] = {41753,"世家大族",},
        [384] = {41754,"十八諸侯",},
        [385] = {41851,"與父有舊",},
        [386] = {41852,"年輕貌美",},
        [387] = {41853,"徐州重臣",},
        [388] = {41854,"才華橫溢",},
        [389] = {41951,"輔佐幼帝",},
        [390] = {41952,"生死攸關",},
        [391] = {41953,"洛陽之亂",},
        [392] = {41954,"同為漢臣",},
        [393] = {10161,"梟首杖",},
        [394] = {10261,"碧玉簫",},
        [395] = {10361,"孟德劍",},
        [396] = {10461,"留香扇",},
        [397] = {10561,"修羅刀",},
        [398] = {10661,"玄鐵盾",},
        [399] = {10761,"惡來戟",},
        [400] = {10861,"流星錘",},
        [401] = {10961,"鉤鐮刀",},
        [402] = {11061,"神龍爪",},
        [403] = {11161,"幽皇滅魂爪",},
        [404] = {11261,"洛神碎雲鞭",},
        [405] = {11361,"手裡劍",},
        [406] = {11461,"長柄斧",},
        [407] = {11561,"連枷象",},
        [408] = {11661,"雲紋毫",},
        [409] = {11761,"獵豹弓",},
        [410] = {11861,"絕情劍",},
        [411] = {11961,"疾風之刃",},
        [412] = {15061,"幽冥誅仙刃",},
        [413] = {20161,"神威龍膽槍",},
        [414] = {20261,"雌雄雙股劍",},
        [415] = {20361,"七星羽扇",},
        [416] = {20461,"木牛流馬",},
        [417] = {20561,"青龍偃月刀",},
        [418] = {20661,"丈八蛇矛",},
        [419] = {20761,"虎頭湛金槍",},
        [420] = {20861,"銀刃烈火弓",},
        [421] = {20961,"金龍連弩",},
        [422] = {21061,"嗜血鐮刀",},
        [423] = {21161,"鳳凰法杖",},
        [424] = {21261,"無影傘劍",},
        [425] = {21361,"南蠻樁",},
        [426] = {21461,"嶺雲矛",},
        [427] = {21561,"蜀道翠竹",},
        [428] = {21661,"青荷",},
        [429] = {21761,"偃月長刀",},
        [430] = {21861,"龍鱗刀",},
        [431] = {21961,"騰蛇法杖",},
        [432] = {25061,"蒼松水韻琴",},
        [433] = {30161,"金龍神鐧",},
        [434] = {30261,"蓮華幽傘",},
        [435] = {30361,"都督狂刃",},
        [436] = {30461,"星華雙扇",},
        [437] = {30561,"狂歌弓",},
        [438] = {30661,"青冥劍",},
        [439] = {30761,"滅天錨",},
        [440] = {30861,"金翎刀",},
        [441] = {30961,"烈焰盾",},
        [442] = {31061,"羅刹輪",},
        [443] = {31161,"灼月刃",},
        [444] = {31261,"聚寶盆",},
        [445] = {31361,"無極棍",},
        [446] = {31461,"斷海鞭",},
        [447] = {31561,"金玉笏",},
        [448] = {31661,"不屈刃",},
        [449] = {31761,"逍遙琴",},
        [450] = {31861,"驚天弓",},
        [451] = {31961,"緋瑞雲燈",},
        [452] = {35061,"烈焰霓凰刀",},
        [453] = {40161,"清虛拂",},
        [454] = {40261,"天樞仗",},
        [455] = {40361,"方天畫戟",},
        [456] = {40461,"仙姝美華",},
        [457] = {40561,"魔王勾",},
        [458] = {40661,"霸天斧",},
        [459] = {40761,"閻王筆",},
        [460] = {40861,"飛雲槍",},
        [461] = {40961,"雷霆羊角杖",},
        [462] = {41061,"千幻毒傀儡",},
        [463] = {41161,"真霸道劍",},
        [464] = {41261,"傳國玉璽",},
        [465] = {41361,"裂空刀",},
        [466] = {41461,"碎嶽錘",},
        [467] = {41561,"天涯悲琴",},
        [468] = {41661,"龍泉劍",},
        [469] = {41761,"竹馬",},
        [470] = {41861,"小方天畫戟",},
        [471] = {41961,"斷子絕孫剪",},
        [472] = {45061,"延陽追魂杖",},
        [473] = {90161,"裂天龍膽槍",},
        [474] = {90162,"傲世鳴鴻刀",},
        [475] = {5301,"孫子兵法",},
        [476] = {5302,"武侯新書",},
        [477] = {5303,"孟德新書",},
        [478] = {5304,"太平要術",},
        [479] = {5311,"青龍符",},
        [480] = {5312,"白虎符",},
        [481] = {5313,"朱雀符",},
        [482] = {5314,"玄武符",},
        [483] = {5321,"孫子兵法",},
        [484] = {5322,"武侯新書",},
        [485] = {5323,"孟德新書",},
        [486] = {5324,"太平要術",},
        [487] = {5331,"青龍符",},
        [488] = {5332,"白虎符",},
        [489] = {5333,"朱雀符",},
        [490] = {5334,"玄武符",},
        [491] = {5201,"鬼谷子",},
        [492] = {5202,"遁甲術",},
        [493] = {5203,"司馬法",},
        [494] = {5211,"戰狼符",},
        [495] = {5212,"疾豹符",},
        [496] = {5213,"騰蛇符",},
        [497] = {5401,"界·孫子兵法",},
        [498] = {5402,"界·武侯新書",},
        [499] = {5403,"界·孟德新書",},
        [500] = {5404,"界·太平要術",},
        [501] = {5411,"界·青龍符",},
        [502] = {5412,"界·白虎符",},
        [503] = {5413,"界·朱雀符",},
        [504] = {5414,"界·玄武符",},
        [505] = {5421,"界·孫子兵法",},
        [506] = {5422,"界·武侯新書",},
        [507] = {5423,"界·孟德新書",},
        [508] = {5424,"界·太平要術",},
        [509] = {5431,"界·青龍符",},
        [510] = {5432,"界·白虎符",},
        [511] = {5433,"界·朱雀符",},
        [512] = {5434,"界·玄武符",},
    }
}

return hero_fate