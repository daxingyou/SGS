--jade

local jade = {
    -- key
    __key_map = {
      id = 1,    --玉石id-int 
      equipment = 2,    --适用装备_math-string 
      name = 3,    --玉石名称-string 
      profile = 4,    --玉石短描述-string 
      description = 5,    --玉石详情-string 
      bag_description = 6,    --背包玉石描述-string 
      button_txt = 7,    --按钮文字-string 
    
    },
    -- data
    _data = {
        [1] = {1101,"601|501|409","Dragon ATK Jade","ATK+5000","ATK+5000 (Player's each level +100)","ATK+5000","Embed",},
        [2] = {1102,"601|501|409","Dragon Heal Jade","Healing Bonus+8% ","Healing Bonus+8% (Valid only for the Healing Warrior's Healing)","Healing Bonus+8% ","Embed",},
        [3] = {1103,"601|501|409","Dragon Crit Jade","CRIT Rate+12% ","CRIT Rate+12% ","CRIT Rate+12% ","Embed",},
        [4] = {1104,"602|502|410","Tortoise Physical Jade","Physical DEF+2500","Physical DEF+2500 (Player's each level +50)","Physical DEF+2500","Embed",},
        [5] = {1105,"602|502|410","Tortoise Restore Jade","Healing Received+8% ","Healing Received+8% (Valid only for the Healing Warrior's Healing)","Healing Received+8% ","Embed",},
        [6] = {1106,"602|502|410","Tortoise Resist Jade","CRIT RES Rate+12% ","CRIT RES Rate+12% ","CRIT RES Rate+12% ","Embed",},
        [7] = {1107,"603|503|411","Tiger Magic Jade","Magical DEF+2500","Magical DEF+2500 (Player's each level +50 Magical DEF)","Magical DEF+2500","Embed",},
        [8] = {1108,"603|503|411","Tiger Restore Jade","Healing Received+8% ","Healing Received+8% (Valid only for the Healing Warrior's Healing)","Healing Received+8% ","Embed",},
        [9] = {1109,"603|503|411","Tiger Flash Jade","Dodge Rate+12% ","Dodge Rate+12% ","Dodge Rate+12% ","Embed",},
        [10] = {1110,"604|504|412","Phoenix Blood Jade","HP+37500","HP+37500 (Player's each level +750)","HP+37500","Embed",},
        [11] = {1111,"604|504|412","Phoenix Heal Jade","Healing Bonus+8% ","Healing Bonus+8% (Valid only for the Healing Warrior's Healing)","Healing Bonus+8% ","Embed",},
        [12] = {1112,"604|504|412","Phoenix Life Jade","Hit Rate+12% ","Hit Rate+12% ","Hit Rate+12% ","Embed",},
        [13] = {1201,"601|501|409","Dragon ATK Jade","ATK Bonus+12% ","ATK Bonus+12% ","ATK Bonus+12% ","Embed",},
        [14] = {1202,"601|501|409","Dragon Heal Jade","Healing Bonus+12% ","Healing Bonus+12% (Valid only for the Healing Warrior's Healing)","Healing Bonus+12% ","Embed",},
        [15] = {1203,"601|501|409","Dragon Crit Jade ","CRIT Rate+22% ","CRIT Rate+22% ","CRIT Rate+22% ","Embed",},
        [16] = {1204,"602|502|410","Tortoise Physical Jade","Physical DEF Bonus+12% ","Physical DEF Bonus+12% ","Physical DEF Bonus+12% ","Embed",},
        [17] = {1205,"602|502|410","Tortoise Restore Jade","Healing Received Rate+12% ","Healing Received+12% (Valid only for the Healing Warrior's Healing)","Healing Received Rate+12% ","Embed",},
        [18] = {1206,"602|502|410","Tortoise Resist Jade","CRIT RES Rate+22% ","CRIT RES Rate+22% ","CRIT RES Rate+22% ","Embed",},
        [19] = {1207,"603|503|411","Tiger Magic Jade","Magical DEF Bonus+12% ","Magical DEF Bonus+12% ","Magical DEF Bonus+12% ","Embed",},
        [20] = {1208,"603|503|411","Tiger Restore Jade","Healing Received Rate+12% ","Healing Received+12% (Valid only for the Healing Warrior's Healing)","Healing Received Rate+12% ","Embed",},
        [21] = {1209,"603|503|411","Tiger Flash Jade","Dodge Rate+22% ","Dodge Rate+22% ","Dodge Rate+22% ","Embed",},
        [22] = {1210,"604|504|412","Phoenix Blood Jade","HP Bonus+12% ","HP Bonus+12% ","HP Bonus+12% ","Embed",},
        [23] = {1211,"604|504|412","Phoenix Heal Jade","Healing Bonus+12% ","Healing Bonus+12% (Valid only for the Healing Warrior's Healing)","Healing Bonus+12% ","Embed",},
        [24] = {1212,"604|504|412","Phoenix Life Jade","Hit Rate+22% ","Hit Rate+22% ","Hit Rate+22% ","Embed",},
        [25] = {1301,"601|501|409","Dragon DMG Jade","DMG Bonus+18% ","DMG Bonus+18% ","DMG Bonus+18% ","Embed",},
        [26] = {1302,"601|501|409","Dragon Heal Jade","Healing Bonus+18% ","Healing Bonus+18% (Valid only for the Healing Warrior's Healing)","Healing Bonus+18% ","Embed",},
        [27] = {1303,"601|501|409","Dragon Crit Jade","CRIT Rate+32% ","CRIT Rate+32% ","CRIT Rate+32% ","Embed",},
        [28] = {1304,"601|501|409","Dragon Counter Jade","PVP DMG Boost+18% ","PVP DMG Boost+18% ","PVP DMG Boost+18% ","Embed",},
        [29] = {1305,"602|502|410","Tortoise Protect Jade","DMG Reduction+18% ","DMG Reduction+18% ","DMG Reduction+18% ","Embed",},
        [30] = {1306,"602|502|410","Tortoise Restore Jade","Healing Received Rate+18% ","Healing Received+18% (Valid only for the Healing Warrior's Healing)","Healing Received Rate+18% ","Embed",},
        [31] = {1307,"602|502|410","Tortoise Resist Jade","CRIT RES Rate+32% ","CRIT RES Rate+32% ","CRIT RES Rate+32% ","Embed",},
        [32] = {1308,"602|502|410","Tortoise Tough Jade","PVP DMG Reduction+18% ","PVP DMG Reduction+18% ","PVP DMG Reduction+18% ","Embed",},
        [33] = {1309,"603|503|411","Tiger Protect Jade","DMG Reduction+18% ","DMG Reduction+18% ","DMG Reduction+18% ","Embed",},
        [34] = {1310,"603|503|411","Tiger Restore Jade","Healing Received Rate+18% ","Healing Received+18% (Valid only for the Healing Warrior's Healing)","Healing Received Rate+18% ","Embed",},
        [35] = {1311,"603|503|411","Tiger Flash Jade","Dodge Rate+32% ","Dodge Rate+32% ","Dodge Rate+32% ","Embed",},
        [36] = {1312,"603|503|411","Tiger Tough Jade","PVP DMG Reduction+18% ","PVP DMG Reduction+18% ","PVP DMG Reduction+18% ","Embed",},
        [37] = {1313,"604|504|412","Phoenix DMG Jade","DMG Bonus+18% ","DMG Bonus+18% ","DMG Bonus+18% ","Embed",},
        [38] = {1314,"604|504|412","Phoenix Heal Jade","Healing Bonus+18% ","Healing Bonus+18% (Valid only for the Healing Warrior's Healing)","Healing Bonus+18% ","Embed",},
        [39] = {1315,"604|504|412","Phoenix Life Jade","Hit Rate+32% ","Hit Rate+32% ","Hit Rate+32% ","Embed",},
        [40] = {1316,"604|504|412","Phoenix Counter Jade","PVP DMG Boost+18% ","PVP DMG Boost+18% ","PVP DMG Boost+18% ","Embed",},
        [41] = {2101,"601|501","Dragon Jade-Killing","Damage increases when attacks Controlled Target","When attack the target that is under Control (Stun, Silence, Paralysis), Damage increases by 15%.","Damage increases when attacks Controlled Target","Embed",},
        [42] = {2102,"601|501","Dragon Jade-Bloodthirsty","Skill Attack deals additional Damage","When the number of targets is 1/2/3/4/6, deals an extra Damage of 15%/7.5%/5%/3.75%/2.5% of targets' max HP","Skill Attack deals additional Damage","Embed",},
        [43] = {2103,"601|501","Dragon Jade-Joint Heart","Damage dealt or Healing increases","when release skill or basic attack, Damage dealt or Healing increases (for each ally Warrior from the same Faction, Damage or Healing +3.75%)","Damage dealt or Healing increases","Embed",},
        [44] = {2104,"601|501","Dragon Jade-Satisfy","Remove abnormal states by killing the target","After killing the target, remove ally Warriors' all abnormal states inflicted by that target before his/her death (Burning, Poisoned, Stun, Silence, Paralysis)","Remove abnormal states by killing the target","Embed",},
        [45] = {2105,"602|502","Tortoise Jade-Star Absorb","Get Damage Absorb Shield before the round","Before the battle, inflict one self Absorb Damage Shield, absorbing direct Damage of 30% of self max HP, lasting one round","Get Damage Absorb Shield before the round","Embed",},
        [46] = {2106,"602|502","Tortoise Jade-Silver Frost","Get Damage Absorb Shield after action","After self action, inflict one self Absorb Damage Shield, absorbing direct Damage of 15% of self max HP, lasting one round (triggered only once in self round)","Get Damage Absorb Shield after action","Embed",},
        [47] = {2107,"602|502","Tortoise Jade-Companion","Ally gets Invincible Shield after you die","When dead, inflict one Invincible Shield on the ally with the lowest HP, lasting 1 round (which equals to the Shield Zhang He inflicts after Breakthrough 5)","Ally gets Invincible Shield after you die","Embed",},
        [48] = {2108,"602|502","Tortoise Jade-DMG Heal","Get DMG Reduction when receive great Damage","When attacked directly by Warrior, if the Damage is over 50% of self max HP, Damage taken reduces by 30%","Get DMG Reduction when receive great Damage","Embed",},
        [49] = {2109,"603|503","Tiger Jade-Light","Restore Anger at the end of the round","After self action, restore self Anger by 1 (triggered only once in self round)","Restore Anger at the end of the round","Embed",},
        [50] = {2110,"603|503","Tiger Jade-Soul","There's a chance to restore Anger when ally releases Skill","After ally releases Skill, there's a 20% chance to restore self Anger by 1","There's a chance to restore Anger when ally releases Skill","Embed",},
        [51] = {2111,"603|503","Tiger Jade-Ultra ","Restore Anger at the end of the total rounds","After the whole round, if self Anger is lower than 4, there's a 35% chance to restore the Anger to 4","Restore Anger at the end of the total rounds","Embed",},
        [52] = {2112,"603|503","Tiger Jade-Regain","There's a chance to restore Consumed Anger by releasing Skill","After releasing Skill, there's a 25% chance to get 50% of the Skill's cost Anger, at most 4","There's a chance to restore Consumed Anger by releasing Skill","Embed",},
        [53] = {2113,"604|504","Phoenix Jade-Spirit","There's a chance to increase ally's Control RES by releasing Skill","After releasing Skill, there's a 50% chance to reduce the Control (Stun, Silence, Paralysis) rate of the neighboring allies by 35%, lasting one round","There's a chance to increase ally's Control RES by releasing Skill","Embed",},
        [54] = {2114,"604|504","Phoenix Jade-Reinforce","Restore HP when restore Anger","In self round, restore Anger and 15% of self max HP at the same time","Restore HP when restore Anger","Embed",},
        [55] = {2115,"604|504","Phoenix Jade-Concentrate","Get Control Immune Shield when not act ","After self round, if haven't acted positively, get one Immune Control (Stun, Silence, Paralysis) Shield, lasting one round","Get Control Immune Shield when not act ","Embed",},
        [56] = {2116,"604|504","Phoenix Jade-Purify","There's a chance to remove abnormal states before the round","Before self round, there's a 25% chance to remove all self abnormal states (Burning, Poisoned, Stun, Silence, Paralysis)","There's a chance to remove abnormal states before the round","Embed",},
    }
}

return jade