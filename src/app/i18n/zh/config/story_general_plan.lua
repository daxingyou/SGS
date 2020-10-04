--story_general_plan

local story_general_plan = {
    -- key
    __key_map = {
      id = 1,    --挑战关卡id_key-int 
      name = 2,    --挑战名称-简中-string 
      des = 3,    --帐篷事件描述-简中-string 
    
    },
    -- data
    _data = {
        [1] = {1,"名将挑战","董卓, 字仲颖, 东汉末年凉州军阀, 后入洛阳成为权臣, 官至太师, 权倾朝野.其人体魄健壮, 臂力过人, 善骑射, 爱喝酒, 爱吃肉, 更爱美人儿, 后因残暴不仁滥杀无辜, 死于貂蝉的美人计之下, 被吕布斩杀.",},
        [2] = {2,"名将挑战","孙策, 字伯符, 被称江东小霸王, 东吴的奠基者之一.年少时容貌俊美, 性格阔达, 声名远播, 后与周瑜结拜.为继承孙坚遗业而屈事袁术, 袁术僭越称帝后, 孙策与袁术决裂, 统一江东.",},
        [3] = {3,"名将挑战","赵云, 字子龙, 蜀汉五虎上将之一.身长八尺, 姿颜雄伟, 曾在长坂坡七进七出百万曹军, 救出刘备的儿子阿斗, 先主云: 子龙一身都是胆也.",},
        [4] = {4,"名将挑战","张飞, 字益德, 蜀汉五虎上将之一, 与刘备, 关羽是桃园结义的兄弟, 以勇猛非凡, 性如烈火, 嫉恶如仇而著称, 曾在长坂坡当阳桥一声怒吼, 吓退十万曹军.",},
        [5] = {5,"名将挑战","周瑜, 字公瑾, 东吴名将, 大都督.因其容貌英俊而有周郎之称, 精通音律, 故有[曲有误, 周郎顾]之语.与孙策交好, 助孙策平定江东, 后孙策遇刺身亡, 又助孙权统领江东.208年, 周瑜率军与刘备联合, 于赤壁之战中大败曹军, 由此奠定了三分天下的基础.被后世誉为[世间豪杰英雄士, 江左风流美丈夫].",},
        [6] = {6,"名将挑战","诸葛亮, 字孔明, 号卧龙, 蜀汉丞相.早年在隆中耕种, 后刘备三顾茅庐请出, 辅佐刘备建立蜀汉.曾舌战群儒促成吴蜀联盟, 空城计吓退司马懿, 一生为蜀汉事业鞠躬尽瘁, 死而后已, 是忠臣与智者的代表人物.其代表作有出师表诫子书等, 曾发明木牛流马, 孔明灯, 诸葛连弩等.",},
        [7] = {7,"名将挑战","曹操, 字孟德, 小名阿瞒, 汉末军阀, 一代奸雄, 是魏国实际的奠基人, 不仅长于军略, 也通音律, 善词赋, 爵至魏王, 其子曹丕建魏后, 追谥武帝, 即魏武帝.",},
        [8] = {8,"名将挑战","左慈, 字元放, 东汉末年知名道士, 精通五经, 占星, 奇门遁甲, 传说能役使鬼神, 以方术名闻当世, 一手建立丹鼎派.左慈曾戏耍曹操与孙策, 后进山炼丹, 得道乘鹤而去.",},
        [9] = {9,"名将挑战","吕布, 字奉先, 三国第一猛将.手持方天画戟, 骑赤兔马, 头戴金冠, 器宇轩昂, 威风凛凛.关羽, 张飞, 刘备三人围攻他, 也未能将其战倒, 战神之名当之无愧!",},
        [10] = {10,"名将挑战","貂蝉, 中国古代四大美女之一, 王允义女, 吕布之妻.有绝世之颜, 闭月之貌, 倾国倾城.为了报答义父王允的养育之恩, 而甘愿献身完成刺杀董卓的连环计.",},
        [11] = {11,"名将挑战","张辽, 字文远, 吕布武将, 后仕曹操, 曹魏五子良将之一, 曾阵斩蹋顿, 击破乌桓.建安二十一年, 东吴大军进围合肥, 张辽领数千精兵大破十万吴军, 几乎活捉孙权, 小儿止啼的著名典故即由此而来.",},
        [12] = {12,"名将挑战","孙坚, 字文台, 东吴霸业的奠基人, 被誉为江东烈虎.其人容貌不凡, 豪爽阔达, 擅使大刀, 喜戴红头巾, 曾参与讨伐黄巾军的战役以及讨伐董卓的战役.",},
        [13] = {13,"名将挑战","大乔, 孙策之妻, 三国知名美人, 与其妹小乔并称江东二乔.通音律, 晓诗文, 肌肤胜雪, 眉目如画, 浅笑盈盈, 十分动人.",},
        [14] = {14,"名将挑战","典韦, 曹操武将, 身材魁梧, 力大无穷, 能驱赶猛虎.擅使大双戟, 张绣叛变时, 为保护曹操力战而死.",},
        [15] = {15,"名将挑战","小乔, 周瑜之妻, 三国知名美人, 与其姐大乔并称江东二乔.神采飞扬, 灵气逼人, 天真烂漫, 银铃般的声音, 娇俏活泼, 听着不自禁的让人喜欢.",},
        [16] = {16,"名将挑战","乐进, 字文谦, 曹魏五子良将之一.以胆识英烈而从曹操, 随军多年, 南征北讨, 战功无数.建安二十三年逝世, 谥曰威侯.",},
        [17] = {17,"名将挑战","吕灵雎, 相传为吕布与貂蝉之女, 美貌不亚于貂蝉, 武艺不亚于父亲, 威风凛凛而寂寥, 勇敢而身先士卒.虽然有着能够直面困难的坚强意志, 却由于过去的经历而有着非常害怕孤独的一面. ",},
        [18] = {18,"名将挑战","甘宁, 字兴霸, 东吴猛将.少年时好游侠, 头插鸟羽, 身佩铃铛, 披服锦绣, 四处游荡抢夺船只财物, 人称锦帆贼.青年时停止抢劫, 熟读诸子, 历仕于刘表和黄祖, 后率部投奔孙权, 开始建功立业.曾率百余人夜袭曹营, 战功赫赫.孙权曾说: 孟德有张辽, 孤有甘兴霸, 足相敌也.",},
        [19] = {19,"名将挑战","曹仁, 字子孝, 三国时期曹魏名将, 曹魏八虎骑之一, 治军严谨, 擅长防守.跟随曹操征战多年, 功勋卓著, 官至大司马.",},
        [20] = {20,"名将挑战","周泰, 字幼平, 东吴重要武将.多次于战乱当中保护孙权的安危, 身上受的伤多达几十处, 就像在皮肤上雕画一样.孙权为了表彰周泰出生入死的功绩, 赐给他青罗伞盖.",},
        [21] = {21,"名将挑战","甄姬, 三国知名美女, 别称甄洛或甄宓[fú] , 文昭甄皇后.倾国倾城, 风华绝代, 本是魏文帝曹丕的正室妻子, 但传说与曹植相爱, 相传洛神赋即曹植为她所作, 成就洛神的千古佳话.",},
        [22] = {22,"名将挑战","黄月英, 诸葛亮之妻, 荆州名士黄承彦之女.相传其美丽无双, 却腼腆害羞, 因此用斗笠轻纱蒙面.她家学渊源, 才智无双, 与诸葛一起发明了木牛流马, 为世人津津乐道.",},
        [23] = {23,"名将挑战","关平, 蜀汉将领, 关羽之子, 随关羽东征西讨, 武勇过人, 不逊乃父, 曾跟随刘备出征西川, 立下战功, 后来又与曹魏猛将庞德大战三十回合, 彼此不分胜负.",},
        [24] = {24,"名将挑战","韩当, 字义公, 东吴将领.长于弓箭, 骑术并且膂力过人, 历仕孙坚, 孙策, 孙权三代, 功勋卓著, 对江东基业的逐渐稳固和吴国的建立有着重要影响.",},
        [25] = {25,"名将挑战","吕蒙, 字子明, 东吴名将, 曾任大都督.十五岁时就从军打仗, 能征惯战, 但读书甚少, 后来孙权劝他学习, 才开始发愤勤学, 鲁肃来到寻阳与吕蒙研讨议事, 十分惊奇他的进步.后以士别三日刮目相看, 吴下阿蒙等称誉别人进步很大.吕蒙最出名的功绩是袭取荆州, 击败蜀汉名将关羽, 留下白衣渡江典故.",},
        [26] = {26,"名将挑战","陆逊, 字伯言, 东吴大将, 历任吴国大都督, 上大将军, 丞相, 在夷陵击败刘备所率蜀汉军, 一战成名.陆逊深得孙权器重, 深谋远虑, 忠诚耿直, 一生出将入相, 被赞为社稷之臣.玩家喜称周瑜为大都督, 陆逊为小都督.",},
        [27] = {27,"名将挑战","司马懿, 字仲达, 少有奇节, 聪明多大略, 博学洽闻, 伏膺儒教.魏国政治家, 军事谋略家, 魏国权臣, 西晋王朝的奠基人.",},
        [28] = {28,"名将挑战","关羽, 字云长, 五虎上将之首.义薄云天, 忠贞不移, 英勇骁战, 留有温酒斩华雄, 刮骨疗伤等佳话.",},
        [29] = {29,"名将挑战","夏侯惇, 字元让, 曹魏名将, 性如烈火的独目将军.为曹家征战一生, 为人清俭, 所得赏赐全部分给将士, 一生不置产业, 至死家无余财.",},
        [30] = {30,"名将挑战","孙坚, 字文台, 军事家孙武的后裔, 东汉末年将领, 军阀, 三国中吴国的奠基人.勇挚刚毅, 容貌不凡, 性阔达, 好奇节, 乃江东猛虎.",},
        [31] = {31,"名将挑战","曹丕, 字子桓, 曹操次子, 著名的政治家, 文学家, 曹魏开国皇帝.自幼文武双全, 博览经传, 通晓诸子百家学说.",},
        [32] = {32,"名将挑战","徐庶, 字元直, 原刘备帐下谋士, 促成卧龙出山, 后归曹操, 并仕于曹魏, 但一生并无大建树.留有身在曹营心在汉的典故.",},
        [33] = {33,"名将挑战","孙权, 字仲谋, 孙坚之子, 孙吴的建立者.于赤壁之战中击败曹操, 奠定三国鼎立的基础.形貌奇伟, 骨体不恒, 有大贵之表, 古有生子当如孙仲谋之言.",},
        [34] = {34,"名将挑战","贾诩, 字文和, 凉州人, 三国著名谋士.原为董卓部将, 董卓死后, 因献计导致李傕郭汜反攻长安, 被称为毒士.之后, 贾诩辗转成为张绣的谋士, 后降曹操, 成为曹魏重要谋臣.",},
        [35] = {35,"名将挑战","郭嘉, 字奉孝, 魏国早期最杰出的谋士, 曹魏五谋臣之一.官至军师祭酒.才智过人, 奇计百出, 曹操称他为[奇佐], 但英年早逝, 曹操深为痛惜.",},
        [36] = {36,"名将挑战","庞统, 字士元, 号凤雏, 刘备重要谋士, 才智与诸葛亮齐名, 赤壁之战, 他避乱江东, 为鲁肃荐于周瑜, 并入曹营献连环计, 助瑜火攻大败曹操.",},
        [37] = {37,"名将挑战","孙尚香, 孙权之妹, 赤壁之战嫁给刘备为妻.她容貌秀丽, 才智敏捷, 桀骜不驯, 巾帼不让须眉.",},
        [38] = {38,"名将挑战","张角, 东汉末年黄巾军的领袖, 太平道的创始人, 教徒多达几十万.184年, 张角以苍天已死, 黄天当立, 岁在甲子, 天下大吉为口号, 自称天公将军, 率领群众发动起义, 史称黄巾起义.",},
        [39] = {39,"名将挑战","张郃[hé], 字儁乂[jùn yì], 曹魏五子良将之一.曾仕袁绍, 官渡之战中投效曹操, 张郃戎马一生, 以用兵巧变, 善列营阵, 长于利用地形著称, 跟随曹操后屡建战功.",},
        [40] = {40,"名将挑战","孟获, 南蛮王, 三国时期南中地区少数民族首领, 被诸葛亮率领大军七擒七纵后降服, 此后不再叛乱.他不但作战勇敢, 意志坚强, 而且待人忠厚, 在当地极得人心.",},
    }
}

return story_general_plan