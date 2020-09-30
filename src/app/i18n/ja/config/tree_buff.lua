--tree_buff

local tree_buff = {
    version =  1,
    -- key
    __key_map = {
      id = 1,    --编号-int 
      screen_comment = 2,    --屏幕生效提示-string 
      description = 3,    --祝福描述-string 
      name = 4,    --祝福名称-string 
      color_text = 5,    --品质名称-string 
    
    },
    -- data
    _data = {
        [1] = {1,"[神樹の祝福]#name#が発動。始皇帝陵イベント時間+#value#分","諦めるのはまだ早い。始皇帝陵イベント時間を#value#分延長。(70分上限を突破可能)","祈祷の灯","おみくじ-大吉",},
        [2] = {2,"","神機妙算、千里眼のごとく先を見る。軍団クイズで#value#個の不正解を除外する","神機妙算","おみくじ-末吉",},
        [3] = {3,"[神樹の祝福]#name#が発動。軍団Bonus#value#元宝を獲得","オール・フォー・ワン、ワン・フォー・オール。#value#元宝の軍団Bonusを獲得しました。早くみんなに配ろう！","博施済衆 ","おみくじ-中吉",},
        [4] = {4,"[神樹の祝福]#name#が発動。その回で答えを間違えても脱落しない","罪は償われるもの。今日の全サーバークイズで、間違えても失格にならないチャンスを#times#回付与","免罪符","おみくじ-中吉",},
        [5] = {5,"[神樹の祝福]#name#が発動。今回失敗しても挑戦回数を消費しない","失敗は成功の父！今日の軍団の試練では、#times#回までは戦闘で敗北しても回数を消費しません","名誉挽回","おみくじ-中吉",},
        [6] = {6,"[神樹の祝福]#name#が発動。その回の終点に到達すると、伯楽の相馬経を#value#冊獲得","千軍万馬を束ねる才能が花開く。「跳べ！的盧！」で終点に到達すると伯楽の相馬経#value#冊を獲得","名騎手","おみくじ-中吉",},
        [7] = {7,"[神樹の祝福]#name#が発動。今回は獲得する軍団貢献度+#value#%","勝って兜の緒を締めよ。今日の軍団の試練に勝利すると、獲得できる軍団貢献を+#value#%。","名采配","おみくじ-末吉",},
        [8] = {8,"[神樹の祝福]#name#が発動。その回は戦死してもその場で復活する","態勢を立て直し一発逆転！軍団戦で撃破されると、その場で#times#回まで復活できる","再起","おみくじ-中吉",},
        [9] = {9,"","戦況は押せ押せ。迅速な行動こそ最も尊い。軍団戦の攻撃クールダウン時間-#value#秒","韋駄天","おみくじ-末吉",},
        [10] = {10,"","兵は強く馬は頑丈、向かうところ敵なし。軍団戦でのHP+#value#%","手練れ揃い","おみくじ-末吉",},
        [11] = {11,"","城を攻め土地を奪い、鉄を泥のように削れ。軍団戦で建造物に与えるダメージを+#value#%","一意閃心","おみくじ-大吉",},
        [12] = {12,"","徒手空拳、無から有を生む。軍団ボスに挑戦すると、追加で#value#回略奪できる","無から有へ","おみくじ-中吉",},
        [13] = {13,"[神樹の祝福]#name#が発動。その回の奪取ポイント+#value#%","決まった収入だけでは金持ちになれない。軍団ボスに挑戦時、奪うポイント+#value#%","横から領る","おみくじ-中吉",},
        [14] = {14,"[神樹の祝福]#name#が発動、今回は失敗しても奪取回数を消費しない","金蝉の神技、身を守りつつ退く。軍団ボスに挑戦時、略奪に失敗しても回数を消費せず、クールダウンにも入らない","金蝉脱殻","おみくじ-中吉",},
        [15] = {15,"[神樹の祝福]#name#が発動、今回は与えるダメージ+#value#%","万矢を一斉に放ち全軍突撃。三国戦記でボスに与えるダメージを+#value#%","一斉掃射","おみくじ-中吉",},
        [16] = {16,"","海辺の一等地に別荘を建てよう。華容道で毎回選手1人に#value#元宝を投じることができる","大博打","おみくじ-大吉",},
        [17] = {17,"[神樹の祝福]#name#が発動。その回の移動費用が低下","何事も準備運動が大切。鉱山戦の移動時、#times#鉱山を通過するまで兵糧を消費しない","用意周到","おみくじ-末吉",},
        [18] = {18,"[神樹の祝福]#name#が発動、今回の購入がおトクになる","五穀豊穣を祈ろう。兵糧購入の最初の#times#回の価格-#value#%","五穀豊穣","おみくじ-中吉",},
        [19] = {19,"[神樹の祝福]#name#が発動、今回の購入がおトクになる","餅は餅屋。商いは門門。攻撃令購入の最初の#times#回の価格-#value#%","お値段以上","おみくじ-中吉",},
        [20] = {20,"[神樹の祝福]#name#が発動。その回の攻撃で消費させる兵力が増加","向かうところ敵無し。鉱山戦で敵を攻撃すると、追加で#value#ptの兵力損失を与える","殲滅白夜","おみくじ-大吉",},
        [21] = {21,"","鉱山戦の採掘による収益が+#value#%","","おみくじ-大吉",},
        [22] = {22,"","今日『跳べ！的盧！』で終点に到達すると、伯楽の相馬経#value#冊を#times#回獲得","","おみくじ-中吉",},
        [23] = {23,"","南蛮侵攻で孟獲(神)を発見する確率+#value#%","鷹の目","おみくじ-末吉",},
        [24] = {24,"[神樹の祝福]#name#が発動、今回は与えるダメージ+#value#%","力を溜めているクロスサーバーBOSSを攻撃時、ダメージボーナスとして#value#%を獲得","無常","おみくじ-大吉",},
    },

    -- index
    __index_id = {
        [1] = 1,
        [10] = 10,
        [11] = 11,
        [12] = 12,
        [13] = 13,
        [14] = 14,
        [15] = 15,
        [16] = 16,
        [17] = 17,
        [18] = 18,
        [19] = 19,
        [2] = 2,
        [20] = 20,
        [21] = 21,
        [22] = 22,
        [23] = 23,
        [24] = 24,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
    }
}

return tree_buff