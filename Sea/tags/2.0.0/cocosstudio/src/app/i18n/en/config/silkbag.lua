--silkbag

local silkbag = {
    -- key
    __key_map = {
      id = 1,    --锦囊id-int 
      name = 2,    --锦囊名称-string 
      profile = 3,    --锦囊短描述-string 
      description = 4,    --锦囊详情-string 
      bag_description = 5,    --背包锦囊描述-string 
      button_txt = 6,    --按钮文字-string 
      show_day = 7,    --图鉴显示天数-int 
      hero = 8,    --适用武将_math-string 
      is_fight = 9,    --无差别竞技里可用赛区_math-int 
    
    },
    -- data
    _data = {
        [1] = {1101,"Guan Yinping Insignia","ATK+1000","ATK +1000 (Player's each level +40)","ATK +1000 (Each level +40)","Equip",0,"999",0,},
        [2] = {1102,"Zhang Xingcai Insignia","HP7500","HP +7500 (Player's each level +300)","HP +7500 (Each level +300)","Equip",0,"999",0,},
        [3] = {1103,"Zhou Tai Insignia","DEF +500","DEF +500 (Player's each level +20)","DEF +500 (Each level +20)","Equip",0,"999",0,},
        [4] = {1104,"Lu Lingju Insignia","CRIT Rate +8%","CRIT Rate +8%","CRIT Rate +8%","Equip",0,"999",0,},
        [5] = {1105,"Huang Gai Insignia","CRIT RES Rate +8%","CRIT RES Rate +8%","CRIT RES Rate +8%","Equip",0,"999",0,},
        [6] = {1106,"Zhang Rang Insignia","DMG +5%","DMG +5%","DMG +5%","Equip",0,"999",0,},
        [7] = {1107,"Cai Wenji Insignia","DMG Reduction +5%","DMG Reduction +5%","DMG Reduction +5%","Equip",0,"999",0,},
        [8] = {1108,"Yu Jin Insignia","CRIT DMG +5%","CRIT DMG +5%","CRIT DMG +5%","Equip",0,"999",0,},
        [9] = {1202,"Liu Bei Insignia","Increases skill's healing","When a healer uses skill, additionally increases the healing effect to the ally Warrior with the lowest HP by 55%.","Increases skill's healing","Equip",0,"102|202|302|402|216",1,},
        [10] = {1203,"Lu Xun Insignia","Burning Probability increases","The less the targets, the higher the Burning Rate, up to 60% towards 1 target.","Increases Burning Rate","Equip",0,"303|305|311|319|313",1,},
        [11] = {1204,"Gongsun Zan Insignia","Attacks one single target and additionally reduces its Anger by 1","Attacks one single target and additionally reduces its Anger by 1","Attacks one single target and additionally reduces its Anger by 1","Equip",0,"212|312|404|408|409|412|413|414|415|416|417|419",1,},
        [12] = {1205,"Guan Yu Insignia","Initial Anger increases by 1","Increases Anger by 1 at the beginning.","Increases Anger by 1 at the beginning","Equip",0,"999",1,},
        [13] = {1207,"Ma Chao Insignia","Increases the DMG Reduction of shield","The less the targets, the higher the DMG Reduction, up to 36%. (Only effective to Warriors with a shield)","Increases the DMG Reduction of shield","Equip",0,"118|207|215|405",1,},
        [14] = {1208,"Jia Xu Insignia","Poisoned Probability increases","The less the targets, the higher the Poison Rate, up to 60%.","Increases Poison Rate","Equip",0,"410|407",1,},
        [15] = {1209,"Xu Shu Insignia","Stun Probability increases","The less the targets, the higher the Stun Rate, up to 48%. (Only effective to Warriors who can inflict Stun)","Increases Stun Rate","Equip",0,"106|116|203|210|212|214|307|312|317|401|408|415",1,},
        [16] = {1211,"Yu Ji Insignia","Increases Poison Damage","The less the targets, the higher the Poison Damage. Can increase Poison Damage to 1 target by up to 60%.","Increases Poison Damage","Equip",0,"410|407",1,},
        [17] = {1212,"Xiao Qiao Insignia","Increases Paralysis Rate","The less the targets, the higher the Paralysis Rate, up to 72% towards 1 target. (Only effective to Warriors who can inflict Paralysis)","Increases Paralysis Rate","Equip",0,"219|304|411",1,},
        [18] = {1213,"Guo Jia Insignia","Increases Silence Rate","The less the targets, the higher the Silence Rate, up to 72% towards 1 target. (Only effective to Warriors who can inflict Silence)","Increases Silence Rate","Equip",0,"104|115|409|419",1,},
        [19] = {1214,"Xiahou Dun Insignia","Increases Reflection Rate","Increases Reflection by 30%. (Only effective to Warriors who can use Reflection)","Increases Reflection Rate","Equip",0,"105",1,},
        [20] = {1215,"Zhang Fei Insignia","ATK +3000","ATK +3000 (Player's each level +120)","ATK +3000 (Each level +120)","Equip",0,"999",1,},
        [21] = {1216,"Pang Tong Insignia","HP+22500","HP +22500 (Player's each level +900)","HP +22500 (Each level +900)","Equip",0,"999",1,},
        [22] = {1217,"Sun Jian Insignia","DEF +1500","DEF +1500 (Player's each level +60)","DEF +1500 (Each level +60)","Equip",0,"999",1,},
        [23] = {1218,"Yuan Shu Insignia","CRIT Rate +20%","CRIT Rate +20%","CRIT Rate +20%","Equip",0,"999",1,},
        [24] = {1219,"Huang Yueying Insignia","CRIT RES Rate +20%","CRIT RES Rate +20%","CRIT RES Rate +20%","Equip",0,"999",1,},
        [25] = {1220,"Dian Wei Insignia","DMG +12%","DMG +12%","DMG +12%","Equip",0,"999",1,},
        [26] = {1221,"Dong Zhuo Insignia","DMG Reduction+12% ","DMG Reduction+12% ","DMG Reduction+12% ","Equip",0,"999",1,},
        [27] = {1222,"Sun Shangxiang Insignia","CRIT DMG +12%","CRIT DMG +12%","CRIT DMG +12%","Equip",0,"999",1,},
        [28] = {1223,"Xu Chu Insignia","Killing the target restores self Anger by 1.","Killing the target restores self Anger by 1.","Killing the target restores self Anger by 1.","Equip",0,"1|2|3|4|5|11|12|13|14|15|101|103|104|105|106|107|108|109|110|111|112|113|114|115|116|117|118|119|201|203|204|205|206|207|208|209|210|211|212|213|214|215|217|218|219|301|303|304|305|306|307|308|309|310|311|312|313|314|315|316|317|318|319|401|403|404|405|406|407|408|409|410|411|412|413|414|415|416|417|418|419",1,},
        [29] = {1224,"Lady Zhen Insignia","Increases the ratio of skill damage converted into healing","Increases the ratio of skill damage converted into healing for the Warrior with the lowest HP by 18%. (Only effective to Support Warriors whose skill can convert damage into healing)","Increases the ratio of skill damage converted into healing","Equip",7,"103|112|117|204|211|404|412",1,},
        [30] = {1225,"Hua Tuo Insignia","Converts Poisoned Damage dealt into self healing","Converts 10% of Poison Damage dealt into self healing.","Converts Poison Damage dealt into self healing","Equip",7,"407|410",1,},
        [31] = {1226,"Da Qiao Insignia","Increases healing effect and inflicts a damage-reducing shield","Increases skill's healing effect by 25% and inflicts 1 shield on the skill target, reducing all the damage taken by 12%, lasting 1 round.","Increases healing effect and inflicts a shield","Equip",7,"102|202|302|402|216",1,},
        [32] = {1227,"Diao Chan Insignia","Reduces the chance of being controlled","Reduces the chance of being controlled (Paralysis, Silence, Stun) by 35%.","Reduces the chance of being controlled","Equip",7,"999",1,},
        [33] = {1301,"Zhao Yun Insignia","Basic Attack definitely launches critical hit","Basic Attack definitely launches critical hit. (Including healer Warriors)","Basic Attack definitely launches critical hit","Equip",7,"999",1,},
        [34] = {1303,"Zhou Yu Insignia","The lasting round of Burning increases","Increases the duration of Burning by 1 round","Increases the duration of Burning by 1 round","Equip",7,"303|305|311|319|313",1,},
        [35] = {1304,"Zuo Ci Insignia","Poisoned comes with No Healing","Poison comes with No Healing. Warriors with Poison cannot be healed.","Poisoned comes with No Healing","Equip",7,"410|407",1,},
        [36] = {1308,"Cao Cao Insignia","Removes enemy Warriors' Invincibility","The less the targets, the higher the chance of removing enemy Warrior's Invincibility. Can increase the chance of removing Invincibility by up to 100% towards 1 target.","Removes enemy Warriors' Invincibility","Equip",7,"1|2|3|4|5|11|12|13|14|15|101|103|104|105|106|107|108|109|110|111|112|113|114|115|116|117|118|119|201|203|204|205|206|207|208|209|210|211|212|213|214|215|217|218|219|301|303|304|305|306|307|308|309|310|311|312|313|314|315|316|317|318|319|401|403|404|405|406|407|408|409|410|411|412|413|414|415|416|417|418|419",1,},
        [37] = {1302,"Divine - Cao Ren Insignia","Reduces the Anger of targets in the middle row by 1","When attacking targets lengthwise, additionally reduces the target's Anger by 1. (Only effective to Warriors who can inflict Decrease Anger on enemies lengthwise)","Reduces the Anger of targets lengthwise by 1","Equip",7,"106|210|406",1,},
        [38] = {1309,"Divine - Lu Xun Insignia","Invincibility Banned for Burned Warrior","Warriors with Burning cannot obtain Invincibility and Lifesteal Shield.","Warriors with Burning cannot obtain Invincibility","Equip",7,"303|305|311|319|313",1,},
        [39] = {1310,"Divine - Huang Yueying Insignia","Immune to Control in the 1st round","Gains immunity to Paralysis, Stun, Silence on the first round.","Gains immunity to Paralysis, Stun, Silence on the first round","Equip",7,"999",1,},
        [40] = {1311,"Divine - Hua Tuo Insignia","Transfers Skill Damage into Healing","Converts 18% of the skill's damage into self healing.","Converts skill damage into self healing","Equip",7,"1|2|3|4|5|11|12|13|14|15|101|103|104|105|106|107|108|109|110|111|112|113|114|115|116|117|118|119|201|203|204|205|206|207|208|209|210|211|212|213|214|215|217|218|219|301|303|304|305|306|307|308|309|310|311|312|313|314|315|316|317|318|319|401|403|404|405|406|407|408|409|410|411|412|413|414|415|416|417|418|419",1,},
        [41] = {1312,"Sima Yi Insignia","Consumes all Anger to increase skill damage","When Warrior's Anger is less than 7, the skill will not be used; The skill consumes all the remaining Anger. Starting from 5th point of Anger, every point of Anger consumed increases the skill's damage by 15%.","Consumes all Anger to increase skill damage","Equip",7,"999",1,},
        [42] = {1305,"Divine - Jia Xu Insignia","The lasting round of Poisoned increases","Increases the duration of Poisoned inflicted by skills by 1 round.","Increases the duration of Poisoned by 1 round","Equip",7,"410|407",1,},
        [43] = {1313,"Divine - Xun Yu Insignia","Increases skill's healing","When a healer uses skill, additionally increases the healing effect to 3 ally Warriors with the lowest HP by 32% of the healer's ATK.","Increases skill's healing","Equip",7,"102|202|302|402|216",1,},
        [44] = {1314,"Sworn Brothers Insignia","Shares damage taken","Reduces damage taken by 12% and shares non-fatal damage with 2 Warriors who currently have the most HP. (Targets will take damage even if they have Invincibility)","Shares damage taken","Equip",7,"999",1,},
        [45] = {1315,"Divine - Taishi Ci Insignia","Increases Burning Rate significantly","The less the targets, the higher the Burning Rate, up to 96% towards 1 target.","Increases Burning Rate significantly","Equip",7,"303|305|311|319|313",1,},
        [46] = {1316,"Yang Insignia","Restores the anger of warrior with Yin Insignia by 1 at the end of the round","After this Warrior has acted for the first time in each round, the Warrior equipped with Yin Insignia can gain 1 point of Anger additionally. (Only 1 male Warrior in every lineup can equip it)","Restores the anger of warrior with Yin Insignia by 1 at the end of the round","Equip",21,"998",0,},
        [47] = {1317,"Yin Insignia","Restores the anger of warrior with Yang Insignia by 1 at the end of the round","After this Warrior has acted for the first time in each round, the Warrior equipped with Yang Insignia can gain 1 point of Anger additionally. (Only 1 female Warrior in every lineup can equip it)","Restores the anger of warrior with Yang Insignia by 1 at the end of the round","Equip",21,"997",0,},
        [48] = {1318,"Riding Alone Insignia","Attacks the enemy Warrior with the lowest HP","All attacks of single-targeting DPS Warriors target the enemy Warrior with the lowest HP.","Attacks the enemy Warrior with the lowest HP","Equip",21,"205|213|308|310|316|413",1,},
        [49] = {1319,"One is Thousand Insignia","Killing the target triggers the skill 1 more time","After a single-targeting DPS Warrior kills the target, triggers the skill 1 more time, dealing 175% physical damage to a single enemy. (The extra skill doesn't consume Anger or trigger any Ability)","Killing the target triggers the skill 1 more time","Equip",21,"205|213|308|310|316|413",1,},
        [50] = {1401,"Hepta Kill Insignia","Damage dealt reduces for being shared by proportion","When the damage dealt to enemies in the front, back row or lengthsise is shared, reduces the sharing ration by 50%","When DMG to enemy from front, back row or lengthwise is shared, reduce share by 50% ","Equip",21,"107|108|109|113|114|201|206|208|209|217|218|301|306|318|406|407|414|416",2,},
        [51] = {1402,"Dubhe Insignia","Kill the target to obtain Anger","Gains the target's remaining Anger upon killing it with the skill (Equipped by DPS Warrior)","Gains the target's remaining Anger upon killing it (Equipped by DPS Warrior)","Equip",21,"101|107|108|109|111|113|114|201|205|206|208|209|217|218|301|306|308|310|316|318|403|406|407|410|413|414|416",2,},
        [52] = {1403,"Legendary - Guan Yu Insignia","Increases Anger by 2 at the beginning","Increases Anger by 2 at the beginning","Increases Anger by 2 at the beginning","Equip",21,"999",2,},
        [53] = {1404,"Drastic Struggle Insignia","There is a limit to damage taken each round","Damage taken every round cannot exceed 50% of self max HP (The damage is direct damage taken from Warriors)","There is a limit to damage taken each round","Equip",999,"105|119|207|215|309|314|405|418",0,},
        [54] = {1405,"Fight Together Insignia","Absorbs the damage taken by ally Warriors of the same faction","When allies of the same faction take direct damage from enemy Warriors, 50% of the damage will be shared with the Warrior equipped with this Insignia. (Cannot trigger any Ability and cannot be disabled by Invincibility)","Absorbs the damage taken by ally Warriors of the same faction","Equip",999,"105|119|207|215|309|314|405|418",0,},
    }
}

return silkbag