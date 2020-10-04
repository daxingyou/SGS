--horse_star

local horse_star = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --装备名称-string 
      skill = 3,    --技能描述-string 
    
    },
    -- data
    _data = {
        [1] = {1,"White Horse","[White Horse] ATK Bonus of Warrior that rides horse+1%",},
        [2] = {1,"Pursuing Wind - White Horse","[Pursuing Wind - White Horse] ATK Bonus of Warrior that rides horse+2%",},
        [3] = {1,"Chasing Sun - White Horse","[Chasing Sun - White Horse] ATK Bonus of Warrior that rides horse+3%",},
        [4] = {2,"Bluish Horse","[Bluish Horse] DEF Bonus of Warrior that rides horse+1%",},
        [5] = {2,"Pursuing Wind - Bluish Horse","[Pursuing Wind - Bluish Horse] DEF Bonus of Warrior that rides horse+2%",},
        [6] = {2,"Chasing Sun - Bluish Horse","[Chasing Sun - Bluish Horse] DEF Bonus of Warrior that rides horse+3%",},
        [7] = {3,"Yellow Horse","[Yellow Horse] HP Bonus of Warrior that rides horse+1%",},
        [8] = {3,"Pursuing Wind - Yellow Horse","[Pursuing Wind - Yellow Horse] HP Bonus of Warrior that rides horse+2%",},
        [9] = {3,"Chasing Sun - Yellow Horse","[Chasing Sun - Yellow Horse] HP Bonus of Warrior that rides horse+3%",},
        [10] = {4,"Sturdy Horse","[Sturdy Horse] CRIT DMG of Warrior that rides horse+1%",},
        [11] = {4,"Pursuing Wind - Sturdy Horse","[Pursuing Wind - Sturdy Horse] CRIT DMG of Warrior that rides horse+2%",},
        [12] = {4,"Chasing Sun - Sturdy Horse","[Chasing Sun - Sturdy Horse] CRIT DMG of Warrior that rides horse+3%",},
        [13] = {5,"Snowy Horse","[Snowy Horse] DMG Bonus of Warrior that rides horse+3%",},
        [14] = {5,"Pursuing Wind - Snowy Horse","[Pursuing Wind - Snowy Horse] DMG Bonus of Warrior that rides horse+6%",},
        [15] = {5,"Chasing Sun - Snowy Horse","[Chasing Sun - Snowy Horse] DMG Bonus of Warrior that rides horse+9%",},
        [16] = {6,"Valiant Horse","[Valiant Horse] DMG Reduction of Warrior that rides horse+3%",},
        [17] = {6,"Pursuing Wind - Valiant Horse","[Pursuing Wind - Valiant Horse] DMG Reduction of Warrior that rides horse+6%",},
        [18] = {6,"Chasing Sun - Valiant Horse","[Chasing Sun - Valiant Horse] DMG Reduction of Warrior that rides horse+9%",},
        [19] = {7,"Ruby Horse","[Ruby Horse] HP Bonus of Warrior that rides horse+3%",},
        [20] = {7,"Pursuing Wind - Ruby Horse","[Pursuing Wind - Ruby Horse] HP Bonus of Warrior that rides horse+6%",},
        [21] = {7,"Chasing Sun - Ruby Horse","[Chasing Sun - Ruby Horse] HP Bonus of Warrior that rides horse+9%",},
        [22] = {8,"Flash Horse","[Flash Horse] CRIT Rate Bonus of Warrior that rides horse+3%",},
        [23] = {8,"Pursuing Wind - Flash Horse","[Pursuing Wind - Flash Horse] CRIT Rate Bonus of Warrior that rides horse+6%",},
        [24] = {8,"Chasing Sun - Flash Horse","[Chasing Sun - Flash Horse] CRIT Rate Bonus of Warrior that rides horse+9%",},
        [25] = {9,"Flying Frost","[Flying Frost] 20% of Damage dealt turns into HP, healing the ally with the lowest HP.",},
        [26] = {9,"Pursuing Wind - Flying Frost","[Pursuing Wind - Flying Frost] 30% of Damage dealt turns into HP, healing the ally with the lowest HP and restoring this target's HP by 10% of his/her max HP additionally.",},
        [27] = {9,"Chasing Sun - Flying Frost","[Chasing Sun - Flying Frost] 30% of Damage dealt turns into HP, healing the ally with the lowest HP and restoring this target's HP by 30% of his/her max HP additionally.",},
        [28] = {10,"Cloudy Snow","[Cloudy Snow] Damage dealt increases by 16% additionally.",},
        [29] = {10,"Pursuing Wind - Cloudy Snow","[Pursuing Wind - Cloudy Snow] Damage dealt increases by 25% additionally. There's a 50% chance to restore self Anger by 1 after killing the target.",},
        [30] = {10,"Chasing Sun - Cloudy Snow","[Chasing Sun - Cloudy Snow] Damage dealt increases by 25% additionally. Restores self Anger by 1 after killing the target. The next time restores Anger, restores self Anger by 1 additionally",},
        [31] = {11,"Fire Dragon","[Fire Dragon] Healing increases by 10%. If heal the target that is in No Healing, inflict a Damage Absorption Shield on the target, lasting 1 round, absorbing Damage of 40% of healing",},
        [32] = {11,"Pursuing Wind - Fire Dragon","[Pursuing Wind - Fire Dragon] Healing increases by 18%. If heal the target that is in No Healing, inflict a Damage Absorption Shield on the target, lasting 1 round, absorbing Damage of 70% of healing",},
        [33] = {11,"Chasing Sun - Fire Dragon","[Chasing Sun - Fire Dragon] Healing increases by 25%. If heal the target that is in No Healing, inflict a Damage Absorption Shield on the target, lasting 1 round, absorbing Damage of 100% of healing",},
        [34] = {12,"Jade Lion","[Jade Lion] When attacked by Decreasing Anger effect, Anger reduces by 2 at most per round",},
        [35] = {12,"Pursuing Wind - Jade Lion","[Pursuing Wind - Jade Lion] Before the battle, when attacked by Decreasing Anger effect, Anger reduces by 1 at most; During the battle, when attacked by Decreasing Anger effect, Anger reduces by 2 at most per round",},
        [36] = {12,"Chasing Sun - Jade Lion","[Chasing Sun - Jade Lion] Before the battle, when attacked by Decreasing Anger effect, Anger reduces by 1 at most; During the battle, when attacked by Decreasing Anger effect, Anger reduces by 1 at most per round",},
        [37] = {15,"Thunderous Horse","[Thunderous Horse] Max HP increases by 15%. When first receives fatal Damage, remains alive and restores self HP by 20% of the max HP",},
        [38] = {15,"Pursuing Wind - Thunderous Horse","[Pursuing Wind - Thunderous Horse] Max HP increases by 30%. When first receives fatal Damage, remains alive, restores self HP by 40% of the max HP and self Anger by 2.",},
        [39] = {15,"Chasing Sun - Thunderous Horse","[Chasing Sun - Thunderous Horse] Max HP increases by 45%. When first receives fatal Damage, remains alive, restores self HP by 60% of the max HP and self Anger by 4.",},
        [40] = {13,"Flying Lightning","[Flying Lightning] Coming soon",},
        [41] = {13,"Admiring Moon - Flying Lightning","[Admiring Moon - Flying Lightning] Coming soon",},
        [42] = {13,"Stepping Sky - Flying Lightning","[Stepping Sky - Flying Lightning] Coming soon",},
        [43] = {14,"Thunderclap Speed","[Thunderclap Speed] Coming soon",},
        [44] = {14,"Admiring Moon - Thunderclap Speed","[Admiring Moon - Thunderclap Speed] Coming soon",},
        [45] = {14,"Stepping Sky - Thunderclap Speed","[Stepping Sky - Thunderclap Speed] Coming soon",},
    }
}

return horse_star