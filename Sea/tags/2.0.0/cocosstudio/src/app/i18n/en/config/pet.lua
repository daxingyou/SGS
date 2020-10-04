--pet

local pet = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --名称-英语-string 
      description = 3,    --宠物描述-英语-string 
      description1 = 4,    --show宠物描述1-英语-string 
      description2 = 5,    --show宠物描述2-英语-string 
      skill_name = 6,    --show宠物技能名称-英语-string 
      skill_description = 7,    --show宠物技能描述-英语-string 
      is_fight = 8,    --无差别竞技里是否可用_math-int 
    
    },
    -- data
    _data = {
        [1] = {1,"Panda","Panda is also called Iron-eating Beast. The father is strong and the son is smart. Combined together, they are invincible."," The father is strong and the son is smart","Combined together, they are invincible","[Frightening Roar]","Deals damage to a single enemy",0,},
        [2] = {2,"Spirit Deer","Spirit Deer is a magical creature whose antlers are formed by the spirit of the world. It can resurrect the dead by releasing the spirit.","A magical creature","Its antlers are formed by the spirit of the world","[Flourishing Flowers]","Heals the ally with the lowest HP",0,},
        [3] = {3,"Fire Fox","Legend has it that Fire Fox has three tails and its claws are always burning. This arrogant and aggressive creature always returns what people give it, no matter it's favors or hatred.","It has three tails and its claws are always burning","It returns what people give it, no matter it's favors or hatred","[Flame Tail]","Deals damage to enemies in the back row",0,},
        [4] = {4,"Sacred Phoenix","Sacred Phoenix has purple and azure feathers. Legend has it that this symbol of love can bring good luck to those who wish for love sincerely.","It has purple and azure feathers","The symbol of love","[Sweeping Hurricane]","Deals damage to enemies in the front row",0,},
        [5] = {5,"White Tiger","White Tiger is one of the four mythical beasts. With purple light glowing over its white body, it can control the power of thunder.","Purple light glows over its white body","It can control the power of thunder","[Solar Thunder]","Reduces Anger before and during the battle",1,},
        [6] = {6,"Azure Dragon","Azure Dragon is the leader of the four mythical beasts and has been the symbol of good luck since ancient times. It can breathe clouds and thunder and fly in the sky.","Leader of the four mythical beasts","It has been the symbol of good luck since ancient times","[Azure Dragon's Rage]","Restores all allies' Anger",1,},
        [7] = {7,"Vermilion Bird","Vermilion Bird is the king of all birds and the most beautiful one among the four mythical beasts. Although its fire is violent, it is a symbol of peace of prosperity.","It can burn everything","It can guide souls to heaven","[Karma Flame]","Deals damage to all the burning targets",1,},
        [8] = {8,"Black Tortoise","Black Tortoise is one of the four mythical beasts and the symbol of immortality. Formed by a tortoise and a snake, it controls the divine water of Hedong, which can breed all the living things.","The combination of a tortoise and a snake","The symbol of immortality","[Tortoise's Blessing]","Inflicts a shield on allies",1,},
        [9] = {9,"Sacred Kun","The existence of Leviathan (Kun) is recorded by Zhuangzi's Xiao Yao You. There has been a fish in Beiming, and its name is Kun. It is so large that its length may be over thousands of miles. According to Notes on Zhuangzi: Inner Chapters, Beiming stands for the northern sea. It is so remote that normal people can never reach it, so Zhuangzi compared it to the truth of the world. In this case, Kun stands for the holy embryo which could only be bred by the truth.","There has been a fish in Beiming, and its name is Kun","It is so large that its length may be over thousands of miles","[Dream of Freedom]","Dispels allies' Stun",1,},
        [10] = {10,"Thunderfire Kylin","Thunderfire Kylin is one of the four spirits. It can fertilize the lands, bring good luck to the people and tell good from bad.","An auspicious god that has existed over 1000 years","It can tell good from bad","[Destiny's Choice]","Deals damage equal to 50% of max HP to a random enemy",1,},
        [11] = {11,"Monster Nian","Legend has it that this cub often appears at the end of a year. Its eyes are like two bells and it moves as fast as the wind. Its golden body shows its incredible might. As active as a child, it likes busy places.","Its golden body shows its incredible might","As active as a child","[Firecracker]","Targets whose HP is below a certain value will be slayed",1,},
        [12] = {12,"Auspicious Bai Ze","Bai Ze is an auspicious symbol which can bring good luck to people in danger. It can speak human languages and knows the appearance of every living thing.","Knows the appearance of every living thing","Brings good luck to people in danger","[Dark Glow]","Exiles the target before the round starts",0,},
        [13] = {106,"Divine - Azure Dragon","Azure Dragon is the leader of the four mythical beasts and has been the symbol of good luck since ancient times. It can breathe clouds and thunder and fly in the sky.","Leader of the four mythical beasts","It has been the symbol of good luck since ancient times","[Azure Dragon's Rage]","Restores all allies' Anger",0,},
    }
}

return pet