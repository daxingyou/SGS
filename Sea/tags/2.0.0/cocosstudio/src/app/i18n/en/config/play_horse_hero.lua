--play_horse_hero

local play_horse_hero = {
    -- key
    __key_map = {
      id = 1,    --序号-int 
      text_1 = 2,    --文本1-英语-string 
      text_2 = 3,    --文本2-英语-string 
      text_3 = 4,    --文本3-英语-string 
      text_4 = 5,    --文本4-英语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"With strength, one can fight the beasts. With wisdom, one can conquer the lands. With long legs, one can win the race!","I gazed at the stars last night and predicted the result. I'll win the first place today.","I'm from the Sima family. There's no way I lose.","Whoever runs ahead of me, I'll cut off their heads!",},
        [2] = {2,"I may look fat, but I'm fast when I roll!","Never seen a fast fatty, huh? I'll show you one.","Believe it or not, I can run faster than you even with a hammer in my hand.","I can drag a bull with one hand to walk 100 steps. A running race is nothing difficult to me.",},
        [3] = {3,"I'll show you the most graceful movements of the most beautiful man.","I have an invincible shield. Don't you grab my clothes during the game.","I'm good at making use of terrains, and I've completely learned the terrains of the track.","I bought a new outfit for this game.",},
        [4] = {4,"A girl can't run as fast as men, so please go easy on me.","Take my whip if you run ahead of me.","My legs are so long, so there's no way I run slowly!","Let me run 2 miles first if you're a real man.",},
        [5] = {5,"I may be short, but I can run fast.","I'm the fastest one among the Five Elite Generals of Wei.","I used to run through the market at childhood, so I'm good at running.","Here's a secret: Yu Jin never beat me.",},
        [6] = {6,"Stand on the weighing machine and you'll know who's heavier. Run in the race and you'll know who's faster.","Running is good for our health.","Dad loves me so much. I can't humiliate him.","I practiced running with Brother Cao Pi yesterday. I can run as fast as he can.",},
        [7] = {7,"Tell Sima Yi to get out! I WILL win the first place today!","Win this game to impress Sima Yi!","Lady Bai is young, but she's not so charming as I am!","Those who don't regret have nothing to complain about.",},
        [8] = {8,"How does Windrunner sound? I'll use that title if I want the race.","Don't buy Yue Jin's words. I'm the fastest one among the Five Elite Generals of Wei.","My speed is as fast as the wind. I'll show you later.","If Yue Jin says I can't run as fast as he can again, I'll kick his ass.",},
        [9] = {9,"I'm an assassin, so of course I'm the fastest one!","I'll buy a new gear with the prize after I win the first place!","I haven't killed anyone in a long time. My sword is almost rusted!","I'll recommend myself for the assassination after the game!",},
        [10] = {10,"Will Mengde come see me?","I'm weak and not good at running.","You'll know the meaning of life after you learn the fun of sex.","This game is not fun at all. Why not hang out with me after the game?",},
        [11] = {11,"I once charged and withdrew 7 times on the battlefield! When it comes to speed, I'm the best!","Remember, I'm the man who people call the Ever-victorious General!","I can beat you even with a baby in my arms.","My courage can help me bring peace to this world, and my legs can help me win this game!",},
        [12] = {12,"I'm the leader of the Five Generals and Saint of War. It'd be a shame if I don't win the first place.","Years ago I managed to escape from prison and ran to Zhuo Commandery in Youzhou. They didn't get me because I ran really fast.","Kill Hua Xiong before the wine gets cool? That's nothing. I'll win the first place before the wine gets cool.","I'm the man who rides Red Hare. There's no way I'll be slow!",},
        [13] = {13,"I can knock you all down by yelling.","Let me have a drink before having the race.","Who says a butcher can't win the first place? I'll show you today.","I, Zhang Yide, will win the first place today. Get out of my way!",},
        [14] = {14,"I was born on the back of a running horse.","Huang Zhong, are you here? Use the Combo Skill to shoot me out!","To be honest, I'm best runner among the Five Generals.","My surname is Ma (horse), so you know, I can run as fast as one.",},
        [15] = {15,"I'm the fastest runner in my clan.","Who is it that called us barbarians? Fight me!","Don't tell Meng Huo's story to me. Tell Zhuge Liang to come here. We'll compete on the track.","Perhaps I may not be that good when it comes to strategies, but if we're talking about running, I'll let you know.",},
        [16] = {16,"Look at my tail. Sexy, huh?","I'm woman, but that doesn't mean I don't run so fast as you guys.","I have been hunting in the mountains since childhood. I've got agility.","Tell Zhuge Liang to come here. I'll revenge my husband on the track!",},
        [17] = {17,"Fighting is boring. The running race is more interesting.","What if I throw the panda over the finishing line? Does that count?","To govern the world, one needs kindness. Participation is the point.","Let's get started now. I gotta go hug the pandas after the game.",},
        [18] = {18,"So many audiences. I'm so embarrassed!","My Lord, Xingcai will win the first place for you!","Wow, so many participants. I'm a bit frightened.","There are so many people here. Don't get sunstroke!",},
        [19] = {19,"Like father, like daughter. Miss Guan won't let you down.","I look nice, I think wise and I can fight! I'll win the first place for dad.","I will do better than dad one day. Let me start with getting the first place!","I will win the first place for dad today.",},
        [20] = {20,"I have mastered riding and archery since childhood. Running is not a problem for me!","My Lord, I will win the champion for you!","Still counting down? Can we just start right away!?","I will win the first place to prove myself!",},
        [21] = {21,"I am Overlord of Jiangdong, Sun Bofu!","People from Jiangdong are brave enough to confront any enemies!","I, Sun Bofu, will win the first place today!","Fellas from Jiangdong, attention!",},
        [22] = {22,"It's hot. What if I get sunburned? Good thing I got the Lotus Umbrella!","Where's Bofu? He promised he would cheer for me.","You'll be a loser in life if you win the game. Are you willing to beat me now?","Look at me and see if I look nice when I run.",},
        [23] = {23,"Hum. Don't look down on girls!","Gongjin said the result is not the point. Whether you enjoy it is what matters!","Haha, my Star Fans will win the champion for me!","The result is not the point. Whether you enjoy it is what matters!",},
        [24] = {24,"This is Gan Ning's territory!","I will win the champion in my territory!","All of you are craps in the face of my fury!","I, Gan Xingba, will carve my name on the cup!",},
        [25] = {25,"Vigorous and valorous, I'm as good as a man!","I can run on the battlefield, not to mention on this track.","I won't go easy on anyone, not even my brother! I always give it my all in the game!","Will Xuande be able to catch up with me if I run too fast?",},
        [26] = {26,"Could you turn down the music? My ears are gonna explode!","Give me a piece of cloud and I can run 1000,000 miles!","Who thinks I'm too young to win the champion? I'll show them what I've got!","Haha, I will win the first place today!",},
        [27] = {27,"My love is as eternal as the moon.","I'll sing and you'll play the zither. Who doesn't cherish their own youth?","Best wishes to you all, protectors of our country.","I am like a thread and you are like a needle. Tangle together and we will never separate.",},
        [28] = {28,"Seriously? Let a blind guy attend a running race!?","Well, what if I happen to get into others' tracks?","Which jerk registered for me?","Check this out for me. Is this Paralympic?",},
        [29] = {29,"I'm running with a lantern in my hand. Cute, huh?","Zhongmou said my face is as long as a donkey's. What do you think?","The Zhuge family has talents in every generation!","Kongming said one should have big ambitions. Why would you attend the game if you don't want the first place?",},
        [30] = {30,"Where's my Diao Chan? And my Red Hare?","I am Lu Bu, the God of War. I can beat you even without a horse.","You can't beat me even on a horse!","The whole world belongs to me, not to mention this little track!",},
        [31] = {31,"Well... I will do my best, so I won't fail Lu Bu.","Who's going to wait for me at the finishing line?","I miss Fengxian a lot.","Despite the result, Fengxian will always love me!",},
        [32] = {32,"Haha, it's really wise of you to pick me!","I'll treat you guys with big meals and beauties if I win the first place!","Slay whoever runs ahead of me!","The people of Liangzhou never fear defeat!",},
        [33] = {33,"I'll poison whoever gets close to me!","You may be here for the game, but I'm here to walk my puppet!","The puppet is filled with poison. Stay away or be careful!","I can win the game easily with the magic of Taoism!",},
        [34] = {34,"Who dares take the jade seal from me? Who dares wins?","I am the first son of the Yuan family. I will win the first place today!","Whoever gets the first place will get a title and a fiefdom!","My divine legs run very fast!",},
        [35] = {35,"The fiddle is so heavy. Will I win the first place today?","I can play zither and write poems and books. Are you sure you want me to attend it?","That familiar music reminds me of my childhood.","Life is short. Let's have a fun game.",},
        [36] = {36,"As long as Fengxian is not here, I'll win the first place!","If I win this game, I will probably conquer the world!","I can beat Lu Bu. Do you believe that?","I will work for whoever win the champion today!",},
        [37] = {37,"I'll ride a hobby horse. Who can beat me now?","Hey, this pear's for you. Go easy on me, okay?","As a descendant of a notable family, I will win the first place!","Where's Adou? I'll hang out with his pandas after the game.",},
        [38] = {38,"My dad is Lu Bu the God of War! I can't fail him!","I just want to fight! This is a waste of my talent!","Dad promised I don't have to marry Yuan Shu's son as long as I win the game!","I'll give the cup to dad to drink with when I win the champion!",},
        [39] = {39,"Wanna try what it's like to be impotent?","Hum, I'll cut you into halves if you don't win the game!","He Jin is trying to kill me. I gotta run fast!","Dong Zhuo is about to arrive in the capital. Run, guys!",},
        [40] = {40,"My hammer won't let go of anyone ahead of me!","Ahem, guys, there's no way you beat me!","Look at my body. Champion's body, right?","The brave fears nothing. I will get the first place!",},
    }
}

return play_horse_hero