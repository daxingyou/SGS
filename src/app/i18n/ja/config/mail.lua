--mail

local mail = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --ID-int 
      mail_name = 2,    --发件人-string 
      mail_title = 3,    --邮件标题-string 
      mail_text = 4,    --邮件文本-string 
    
    },
    -- data
    _data = {
        [1] = {1,"小喬","#title#","#content#",},
        [2] = {2,"小喬","競技場毎日報酬","主君は今回の競技場ランキングで第#rank#位の好成績を収め、以下の報酬を獲得しました。",},
        [3] = {3,"小喬","南蛮侵攻-軍団ダメージランキング","所属軍団が南蛮侵攻の累計ダメージランキングで#rank#位になり、以下の報酬を獲得されました",},
        [4] = {4,"小喬","南蛮侵攻-個人ダメージランキング","あなたは今日の南蛮侵攻で累計ダメージランキングの#rank#位となり、以下の報酬を獲得しました。",},
        [5] = {10,"小喬","ログイン報酬","親密度が上がったため、今日のログインで2倍の報酬を獲得されました。再配布いたします",},
        [6] = {11,"小喬","#city#暴動制圧報酬","プレイヤー#name#が#riot_name#の解決を助けてくれたおかげで、以上の報酬を獲得しました！",},
        [7] = {12,"小喬","軍団ボス個人ポイント報酬","今回の軍団ボスで、主君は個人の獲得ポイント#integral#、ランキング#rank#位でしたので、以上の報酬を支給します。",},
        [8] = {13,"小喬","軍団ボス軍団ポイント報酬","今回の軍団ボスで、主君の所属する軍団が獲得したポイントは#integral#で、ランキング#rank#でした。以上の報酬をお送りします。",},
        [9] = {14,"小喬","オークション会場","主君、オークション場で落札した商品は速やかに受け取ってくださいね！",},
        [10] = {15,"小喬","オークション(入札金返還)","主君、#name#の落札が失敗しました、入札金を返還します。",},
        [11] = {16,"小喬","オークション配当","主君、#name#にどんどん参加してくださいね。小喬からイベントオークション配当を贈ります。どうぞお受け取りくださいませ。",},
        [12] = {17,"小喬","軍団支援報酬","未受領の軍団支援報酬がありましたので、小喬がお送りしておきました！",},
        [13] = {18,"小喬","軍団求援報酬"," ",},
        [14] = {19,"小喬","ギフトコード報酬","「三国志名将伝」をプレイいただき、ありがとうございます。以下の報酬をお受け取りください。",},
        [15] = {20,"小喬","毎週の軍団俸禄","先週の軍団俸禄が確定しました。あなたの役職と活躍により、以下の報酬を獲得できます。",},
        [16] = {21,"小喬","[神]孟獲参加賞","軍団の[神]孟獲の撃破イベントに参加されましたので、以下の報酬が受け取れます。",},
        [17] = {22,"小喬","#title#","#content#",},
        [18] = {23,"小喬","#title#","#content#",},
        [19] = {24,"小喬","軍団クイズポイント報酬","今回の軍団クイズイベントで主君が獲得したポイントに応じて、以下の報酬を支給いたします。",},
        [20] = {25,"小喬","軍団クイズ軍団ポイント報酬","今回の軍団クイズイベントで、主君の軍団はポイント#integral#を獲得し、ランキング第#rank#位となりました。以下の報酬をお送りします。",},
        [21] = {26,"軍団管理人","軍団俸禄","主君の役職と軍団での活躍により|現在 #gold# $resmini_1$ 、 #contribution# $resmini_13$が累積されています。|月曜04時に一斉配布されます。",},
        [22] = {27,"#name#","軍団メール","#content#",},
        [23] = {28,"小喬","#title#","#content#",},
        [24] = {29,"#name#","軍団メール","親愛なる団員の皆さま、毎日の軍団クイズ時間を#time#回に変更します。時間どおりにご参加ください。",},
        [25] = {30,"軍団管理人","職務の任命","おめでとうございます！主君は#position#に任命されました。今後も軍団のために頑張ってくださいね！",},
        [26] = {31,"軍団管理人","職務解除","主君、残念ながら先ほど#position#の役職を解かれました。",},
        [27] = {32,"小喬","百大軍団","所属軍団#legion#は今回の百大軍団イベントでランキング第#rank#位になりました。あなたは#position#として、十分な貢献をされましたので、小喬から以下の報酬をお届けします。",},
        [28] = {33,"小喬","名将七変化チャージ累計ボーナス","名将七変化期間中に#money#元をチャージすると、小喬から#goods##num#個をお贈りします。さあ、イベントに参加して運試しをしましょう～",},
        [29] = {34,"小喬","公式アカウント交換報酬","主君、以下が『三国志名将伝』wechat公式アカウント経由でポイント交換した報酬です。どうぞお受け取り下さい。賞品に関してご質問がある場合はカスタマーサービスまでご連絡くださいね。主君のご支援に感謝いたします。",},
        [30] = {35,"小喬","仇敵改名","主君、仇である「#name1#」が「#name2#」に改名しました。ご承知おきを。",},
        [31] = {36,"小喬","曹操追撃イベントチャージ累計ボーナス","曹操追撃イベント期間中に#money#元をチャージすると、小喬から#goods##num#個をお贈りします。さあ、イベントに参加して運試しをしましょう～",},
        [32] = {37,"小喬","陣営競技参加賞","残念ながら今回の陣営競技では決勝には進出できませんでした。小喬から参加賞をお届けします。またの挑戦をお待ちしています！",},
        [33] = {38,"小喬","陣営競技8強報酬","おめでとうございます！主君は今回の陣営競技でベスト8入りを果たし、以下の報酬を獲得しました。",},
        [34] = {39,"小喬","陣営競技四強報酬","おめでとうございます、主君は今期の陣営競技で4強に進み、以下の報酬を獲得しました: ",},
        [35] = {40,"小喬","陣営競技2位報酬","おめでとうございます！主君は今回の陣営競技で準優勝を果たし、以下の報酬を獲得しました。",},
        [36] = {41,"小喬","陣営競技全サーバー配当","積極的に陣営競技に参加されました。小喬から陣営競技全サーバー共通オークションの配当をお送りします。お受け取りください。",},
        [37] = {42,"小喬","陣営競技応援賞","今回の陣営競技で支持された#name#が昇格しました。獲得された元宝を小喬がお届けします！",},
        [38] = {43,"小喬","八星占いイベントチャージ累計ボーナス","八星占いイベント期間中に#money#元チャージすると、小喬から#num#個#goods#をお贈りします。今すぐ八星占いイベントで運試しをしてみましょう",},
        [39] = {44,"小喬","陣営競技優勝報酬","今回の陣営競技で優勝され、以下の報酬を獲得されました: ",},
        [40] = {45,"小喬","大感謝祭","主君、新春を祝うこの時に軍団ボスにご参加いただきありがとうございます。そのお礼に小喬から以下の報酬をお贈りします。主君に幸運がたくさん訪れますように！",},
        [41] = {46,"小喬","大感謝祭","このおめでたい日に軍団クイズに参加してくださったお礼に、小喬から特別に以下の報酬をお贈りします。ご武運を！",},
        [42] = {47,"小喬","大感謝祭","佳節を迎えるにあたり、軍団の試練への積極的なご参加に感謝し、小喬から特別に以下の報酬をお届けます。幸運をお祈りしております！",},
        [43] = {48,"小喬","大感謝祭","佳節を迎えるにあたり、三国戦記への積極的なご参加に感謝し、小喬から特別に以下の報酬をお届けます。幸運をお祈りしております！",},
        [44] = {49,"小喬","華容道戦報","第#number#回華容道が終了しました。今期の優勝者は、あなたから祝福を賜った英雄#hero#です。あなたの慧眼に感謝し、オッズ#odds#の賞金をお贈りします。",},
        [45] = {50,"小喬","華容道戦報","主君、第#number#回の華容道が終了し、残念ながら応援した選手の#hero#は敗退しました。ご参加に感謝すると共に、またのご参加をお待ちしております。",},
        [46] = {51,"小喬","YOKAボーナス報酬","「YOKA特典」アプレットのログイン報酬をお受け取りください。いつもご支援いただき、ありがとうございます。引き続きゲームをお楽しみください！",},
        [47] = {52,"軍団管理人","軍団戦軍功","今回の軍団戦で活躍しておられましたので、軍団貢献#num#を配布します。お受け取りください。",},
        [48] = {53,"小喬","伯楽戦馬選定イベント、チャージ累計ボーナス","伯楽戦馬選定イベント期間中に#money#元をチャージすると、小喬から#goods##num#個をお贈りします。さあ、戦馬選定で運試しをしましょう～",},
        [49] = {54,"軍団管理人","軍団戦軍功","所属軍団が#city#を占領し、今日は#num#の軍団貢献を獲得しました。お受け取りください。",},
        [50] = {55,"小喬","始皇帝陵ドロップ報酬","オフライン中に獲得した始皇帝陵の報酬です。お受け取りください。",},
        [51] = {56,"小喬","親密度認証ご挨拶ギフト","「三国志名将伝」親密度グリーンチャンネルが開放されました。認証ギフトをお受け取りください。今後の新バージョン内容、新イベント情報をすぐにお知らせいたします。「三国志名将伝」へのご支援、ご愛顧、ありがとうございます。引き続きゲームをお楽しみください！",},
        [52] = {57,"小喬","IDバインド報酬","アカウントがIDとバインドされました。以下の報酬を獲得: ",},
        [53] = {58,"軍団管理人","軍功宝箱","今回の軍団戦で主君は大活躍されたので、特別に以下の報酬を支給します。どうぞお受け取り下さい！",},
        [54] = {59,"小喬","連動小ボーナス","「三国志名将伝」へようこそ。小喬がご用意したちょっとしたプレゼントを受け取って、ゲームをお楽しみください。連動任務を完了すると、「三国殺」報酬が貰えますよ。詳細は連動イベント説明をご覧ください。もちろん「三国志名将伝」では、追加ボーナスも貰えます。引き続き小喬と一緒に楽しく遊びましょう^_^",},
        [55] = {60,"小喬","連動小ボーナス","「三国志名将伝」へようこそ。小喬がご用意したちょっとしたプレゼントを受け取って、ゲームをお楽しみください。連動任務を完了すると、「三国殺」報酬が貰えますよ。詳細は連動イベント説明をご覧ください。もちろん「三国志名将伝」では、追加ボーナスも貰えます。引き続き小喬と一緒に楽しく遊びましょう^_^",},
        [56] = {61,"小喬","連動小ボーナス","「三国志名将伝」へようこそ。小喬がご用意したちょっとしたプレゼントを受け取って、ゲームをお楽しみください。連動任務を完了すると、「三国殺」報酬が貰えますよ。詳細は連動イベント説明をご覧ください。もちろん「三国志名将伝」では、追加ボーナスも貰えます。引き続き小喬と一緒に楽しく遊びましょう^_^",},
        [57] = {62,"小喬","コラボ報酬再支給","ネットワークが不安定なため、連動イベントで獲得された任務報酬はメールでお届けします^_^",},
        [58] = {63,"小喬","オークション予告","神秘の商人が#hour#時#minute#分にやって来ます。このオークションで即決価格によって商品を競り落とすと、全サーバーがビッグBonusを獲得できます。",},
        [59] = {64,"小喬","称号獲得","#des#は称号#title#を獲得されました。有効期間は#day#です。ホーム画面左上のご自分のアイコンをタップし、称号画面でご確認ください",},
        [60] = {65,"小喬","利き馬学堂イベントチャージ累計ボーナス","利き馬学堂期間中に#money#元をチャージすると、小喬から#goods##num#個をお贈りします。さあ、イベントに参加して運試しをしましょう～",},
        [61] = {66,"小喬","クロスサーバー決闘大会の全サーバー配当","小喬から主君に贈り物です。クロスサーバー決闘大会の全サーバー共通オークションの配当を受け取ってくださいね。",},
        [62] = {67,"小喬","クロスサーバー決闘大会支持賞","今回のクロスサーバー決闘大会で支持した#name#が昇格しました。獲得なさった玉魂をお届けします。",},
        [63] = {68,"小喬","クロスサーバー決闘大会参加賞","残念ながら今回のクロスサーバー決闘大会では32強に入れませんでした。小喬から参加賞をお届けします。またの挑戦をお待ちしています！",},
        [64] = {69,"小喬","クロスサーバー決闘大会参加賞","今回のクロスサーバー決闘大会で#rank#位になり、以下の報酬を獲得されました: ",},
        [65] = {70,"軍団管理人","クロスサーバー軍団戦","所属軍団は今回のクロスサーバー軍団戦で#point#ptを獲得し、ランキング第#rank#位になりました。あなたは素晴らしい活躍をして、勇敢に敵を倒されましたので、以下の報酬をお送りします。",},
        [66] = {75,"小喬","ギフトコード報酬","親愛なる主君、いつもご支持ありがとうございます。専属の報酬をお受け取りください。",},
        [67] = {76,"小喬","優勝予想的中報酬","今回のクロスサーバー決闘大会で応援した#Server##name#が優勝し、以下の報酬を獲得されました: ",},
        [68] = {77,"小喬","知識王大会の勝利報酬","今回のクロスサーバー決闘大会で支持した#Server#サーバーがランキング1位となり、以下の報酬を獲得されました: ",},
        [69] = {78,"小喬","最下位サーバー予想の的中報酬","今期のクロスサーバー決闘大会で支持した#Server#サーバーはランキング最下位でした。以下の報酬を獲得しました: ",},
        [70] = {79,"小喬","優勝予想残念賞","今回のクロスサーバー決闘大会勝者予想にご参加いただき、ありがとうございました。残念ながら応援なさったプレイヤーは優勝できませんでした。小喬から参加賞をお届けします。またの挑戦をお待ちしています！",},
        [71] = {80,"小喬","最強サーバー予想残念賞","今回のクロスサーバー決闘大会最強サーバー予想にご参加いただき、ありがとうございました。残念ながら応援なさったサーバーは優勝できませんでした。小喬から参加賞をお届けします。またの挑戦をお待ちしています！",},
        [72] = {81,"小喬","最下位サーバー予想残念賞","今回のクロスサーバー決闘大会の最弱サーバー予想にご参加いただき、ありがとうございました。残念ながら応援されたサーバーは最下位ではありませんでした。小喬から参加賞をお届けします。またの挑戦をお待ちしています！",},
        [73] = {82,"小喬","全サーバークイズポイント報酬","今回の全サーバークイズイベントでは#point#ptを獲得し、ランキング第#rank#位でした。以下の報酬をお送りします。",},
        [74] = {83,"小喬","Bonus Rain、まもなく開放","#time#より、Bonus Rainイベントが開放されます。主君各位はどうぞご来駕ください！",},
        [75] = {84,"小喬","お楽しみガチャ報酬","今回のお楽しみガチャで幸運児になられたあなたに、小喬から以下の賞品をお送りします: ",},
        [76] = {85,"小喬","お楽しみガチャポイントランキング報酬","今回のお楽しみガチャも一段落。お楽しみガチャポイントランキングは第#rank#位でした。小喬から以下の第#part#位報酬をお届けします: ",},
        [77] = {86,"小喬","真龍降臨ポイントランキング報酬","今回の武将(金)登用イベントは終了しました。ポイントランキングは第#rank#位でした。小喬から第#part#位報酬をお届けします: ",},
        [78] = {87,"小喬","真龍降臨イベントチャージ累計ボーナス","真龍降臨イベント期間中に#money#元をチャージすると、小喬から#goods##num#個をお贈りします。さあ、武将(金)を登用して、運試しをしましょう~",},
        [79] = {88,"小喬","お楽しみガチャ参加報酬","今回のお楽しみガチャは終了しました。ご参加いただき、ありがとうございました。小喬から以下の参加報酬をお届けします: ",},
        [80] = {89,"小喬","真龍降臨参加報酬","今回の真龍降臨イベントは終了しました。ご参加いただき、ありがとうございました。小喬から参加報酬をお届けします: ",},
        [81] = {98,"小喬","新武将(金)、R50神器を贈呈","主君、おめでとうございます！初めて#hero#を獲得しましたので、小喬から#hero#専用のR50神器をお贈りします。",},
        [82] = {90,"小喬","軍団ケーキレベルアップ報酬","主君は#name1#軍団を離脱しました。添付は未受領のケーキのレベルアップ報酬です。どうぞお受け取り下さい。",},
        [83] = {91,"小喬","クロスサーバーの饗宴の宴に軍団で参加","所属している#name1#軍団が所属サーバーの饕餮の宴で#rank#位となり、所属サーバーを代表してクロスサーバーの饗宴に参加します。引き続き頑張って、軍団のために栄光を勝ち取ってください！",},
        [84] = {92,"小喬","本サーバー饕餮の宴の個人報酬","所属サーバー饕餮の宴で個人ランキング#rank#位になりました！添付はランキング報酬です。お受け取りください。",},
        [85] = {93,"小喬","所属サーバー饕餮の宴軍団報酬","おめでとうございます！主君が所属する#name1#軍団が今回のクロスサーバーの饗宴の宴で#rank#位を獲得しました！添付は軍団のランキング報酬です。どうぞお受け取り下さい！",},
        [86] = {94,"小喬","クロスサーバーの饗宴の宴個人報酬","クロスサーバーの饗宴の宴で個人ランキング第#rank#位でした。添付はランキング報酬です。お受け取りください。",},
        [87] = {95,"小喬","クロスサーバーの饗宴の宴軍団報酬","所属している#name1#軍団がクロスサーバーの饗宴の宴で#rank#位となりました！軍団ランキング報酬を添付しましたので、お受け取りください。",},
        [88] = {96,"小喬","本サーバー「饕餮の宴」のケーキ報酬","本サーバーの饗宴の宴が終了しました。添付は未受領の饗宴の宴レベルアップ報酬です。ご査収ください。",},
        [89] = {97,"小喬","クロスサーバーの饗宴ケーキ報酬","クロスサーバーの饗宴の宴が終了しました。添付は未受領の饗宴の宴レベルアップ報酬です。ご査収ください。",},
        [90] = {100,"小喬","クロスサーバー軍団戦 支援成功報酬","今回のクロスサーバー軍団戦で応援した#Server##Guild#が、見事トップ8に入り、以下の報酬を獲得されました: ",},
        [91] = {101,"小喬","クロスサーバー軍団戦支援失敗残念賞","今回のクロスサーバー軍団戦で応援なさった#Server##Guild#はトップ8に入れませんでした。小喬から参加賞をお届けします。またの挑戦をお待ちしています！",},
        [92] = {102,"小喬","クロスサーバーBOSS個人ポイント報酬","今回のクロスサーバーBOSSで#integral#ptを獲得し、#rank#位にランクインされました。ここに報酬をお届けします。",},
        [93] = {103,"小喬","クロスサーバーBOSS軍団ポイント報酬","今回のクロスサーバーBOSSで、主君の所属する軍団の獲得ポイントは#integral#、ランキングは#rank#となりましたので、以上の報酬を支給します。",},
        [94] = {104,"軍団管理人","暗渡陳倉報酬","わが軍団#graincar#は終点に達しました。耐久度は#num#です。皆の活躍を讃え、以下の報酬を送ります。お受け取りください。",},
        [95] = {105,"軍団管理人","暗渡陳倉報酬","残念ながら所属軍団の兵糧輸送車が破壊されました。与ダメージの高かった軍団は#name1# #name2# #name3#です。成績に応じ、以下の報酬を配布いたします。お受け取りください。",},
        [96] = {106,"軍団管理人","軍団自動解散","主君、所属の軍団が三日間活躍してないため、自動的に解散しました。",},
        [97] = {107,"小喬","ゲストログインオフ","国家の規定により、ゲストログインは2019年12月25日で終了します。この後はゲストでログインできなくなります、早めに携帯番号と連携してください。",},
        [98] = {108,"小喬","真武戦神参加ランキング報酬","主君、今回の真武戦神でランキング#rank#到達おめでとうございます。小喬からランキング報酬をお届けします。",},
        [99] = {109,"小喬","真武戦神予想報酬","主君、真武戦神#round#の試合が終了しました。予想で応援した選手#name1#が優勝を納めました。あなたの予想は全部当たり、小喬から予想報酬をお届けします。",},
        [100] = {110,"軍団管理人","暗渡陳倉未発車ヒント","主君、今回のイベント期間内本軍団の軍団長と副団長が発車しなかったため、兵糧報酬を獲得できませんでした。",},
        [101] = {111,"小喬","クロスサーバー決闘大会の全サーバー配当","主君、小喬から陣営競技本陣営#rank#名のクロスサーバー決闘大会全サーバーオークションの配分をお届けします、納めください。",},
        [102] = {112,"小喬","クロスサーバー決闘大会の全サーバー配当","主君、小喬から陣営競技本陣営#rank#名以下のクロスサーバー決闘大会全サーバーオークションの配分をお届けします、納めください。",},
        [103] = {113,"小喬","真武戦神複数予想報酬","主君、今回の真武戦神の試合が終了しました。複数予想で応援した選手#name1#が優勝を納めました。あなたの予想は全部当たり、小喬から予想報酬をお届けします。",},
        [104] = {114,"小喬","真武戦神奨金プール山分け","主君、今回の真武戦神の試合が終了しました。予想ランキング#rank#到達おめでとうございます。小喬から奨金プール山分け報酬をお届けします。",},
        [105] = {8401,"小喬","チャージ注意","あなたは#time#でオフィシャルサイトで#name#を購入しました。一部の報酬はすでにアカウントに配布済みです。残りの報酬はゲーム内で受け取り、当日の累計チャージイベントを開放してください。ご支持ありがとうございます。",},
        [106] = {8402,"小喬","チャージ注意","あなたは#time#でオフィシャルサイトで#name#を購入しました。一部の報酬はすでにアカウントに配布済みです。残りの報酬はゲーム内で受け取り、当日の累計チャージイベントを開放してください。ご支持ありがとうございます。",},
        [107] = {8403,"小喬","親密度認証ご挨拶ギフト","「三国志名将伝」親密度グリーンチャンネルが開放されました。認証ギフトをお受け取りください。今後の新バージョン内容、新イベント情報をすぐにお知らせいたします。「三国志名将伝」へのご支援、ご愛顧、ありがとうございます。引き続きゲームをお楽しみください！",},
        [108] = {8404,"小喬","ストアコメント報酬","親愛なる主君、いつもご支持ありがとうございます。小喬からの報酬をお受け取りください。",},
        [109] = {8405,"小喬","事前登録#sub_num#万報酬","主君たちの熱い応援ありがとうございます！事前登録#sub_num#万人突破！事前登録報酬をお受け取り下さい。",},
        [110] = {8501,"小喬","アカウント連携報酬","主君、アカウントを連携しました、以下の報酬を獲得できます",},
        [111] = {8601,"小喬","規約違反処分","不適切な用語を使用したとの通報があるため、しばらくの間発言禁止状態になります。解除まで: #num#分 ",},
        [112] = {8602,"小喬","通報処理結果","主君、あなたのご報告は受理されました。プレイヤー#name#は発言禁止になりました。",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [10] = 5,
        [100] = 90,
        [101] = 91,
        [102] = 92,
        [103] = 93,
        [104] = 94,
        [105] = 95,
        [106] = 96,
        [107] = 97,
        [108] = 98,
        [109] = 99,
        [11] = 6,
        [110] = 100,
        [111] = 101,
        [112] = 102,
        [113] = 103,
        [114] = 104,
        [12] = 7,
        [13] = 8,
        [14] = 9,
        [15] = 10,
        [16] = 11,
        [17] = 12,
        [18] = 13,
        [19] = 14,
        [2] = 2,
        [20] = 15,
        [21] = 16,
        [22] = 17,
        [23] = 18,
        [24] = 19,
        [25] = 20,
        [26] = 21,
        [27] = 22,
        [28] = 23,
        [29] = 24,
        [3] = 3,
        [30] = 25,
        [31] = 26,
        [32] = 27,
        [33] = 28,
        [34] = 29,
        [35] = 30,
        [36] = 31,
        [37] = 32,
        [38] = 33,
        [39] = 34,
        [4] = 4,
        [40] = 35,
        [41] = 36,
        [42] = 37,
        [43] = 38,
        [44] = 39,
        [45] = 40,
        [46] = 41,
        [47] = 42,
        [48] = 43,
        [49] = 44,
        [50] = 45,
        [51] = 46,
        [52] = 47,
        [53] = 48,
        [54] = 49,
        [55] = 50,
        [56] = 51,
        [57] = 52,
        [58] = 53,
        [59] = 54,
        [60] = 55,
        [61] = 56,
        [62] = 57,
        [63] = 58,
        [64] = 59,
        [65] = 60,
        [66] = 61,
        [67] = 62,
        [68] = 63,
        [69] = 64,
        [70] = 65,
        [75] = 66,
        [76] = 67,
        [77] = 68,
        [78] = 69,
        [79] = 70,
        [80] = 71,
        [81] = 72,
        [82] = 73,
        [83] = 74,
        [84] = 75,
        [8401] = 105,
        [8402] = 106,
        [8403] = 107,
        [8404] = 108,
        [8405] = 109,
        [85] = 76,
        [8501] = 110,
        [86] = 77,
        [8601] = 111,
        [8602] = 112,
        [87] = 78,
        [88] = 79,
        [89] = 80,
        [90] = 82,
        [91] = 83,
        [92] = 84,
        [93] = 85,
        [94] = 86,
        [95] = 87,
        [96] = 88,
        [97] = 89,
        [98] = 81,
    }
}

return mail