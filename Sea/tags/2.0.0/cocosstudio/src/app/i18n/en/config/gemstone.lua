--gemstone

local gemstone = {
    -- key
    __key_map = {
      id = 1,    --id-int 
      name = 2,    --名称-string 
      bag_description = 3,    --背包描述-string 
      description = 4,    --装备描述-string 
    
    },
    -- data
    _data = {
        [1] = {101,"Green ATK Gem","Glittering gem glows green, cool to the touch.","Glittering gem glows green, cool to the touch.",},
        [2] = {102,"Green DEF Gem","Glittering gem glows green, cool to the touch.","Glittering gem glows green, cool to the touch.",},
        [3] = {103,"Green HP Gem","Glittering gem glows green, cool to the touch.","Glittering gem glows green, cool to the touch.",},
        [4] = {104,"Green Awaken Scroll","The original scroll that produces the green gem. It has miraculous power.","The original scroll that produces the green gem. It has great and miraculous power.",},
        [5] = {201,"Blue ATK Gem","Glittering gem glows sky-blue, cool to the touch.","Glittering gem glows sky-blue, cool to the touch.",},
        [6] = {202,"Blue DEF Gem","Glittering gem glows sky-blue, cool to the touch.","Glittering gem glows sky-blue, cool to the touch.",},
        [7] = {203,"Blue HP Gem","Glittering gem glows sky-blue, cool to the touch.","Glittering gem glows sky-blue, cool to the touch.",},
        [8] = {204,"Blue Awaken Scroll","The original scroll that produces the blue gem. It has miraculous power.","The original scroll that produces the blue gem. It has great and miraculous power.",},
        [9] = {301,"Marine ATK Gem","Glittering gem glows sky-blue, cool to the touch.","Glittering gem glows sky-blue, cool to the touch.",},
        [10] = {302,"Marine DEF Gem","Glittering gem glows sky-blue, cool to the touch.","Glittering gem glows sky-blue, cool to the touch.",},
        [11] = {303,"Marine HP Gem","Glittering gem glows sky-blue, cool to the touch.","Glittering gem glows sky-blue, cool to the touch.",},
        [12] = {304,"Marine Awaken Scroll","The original scroll that produces the blue gem. It has miraculous power.","The original scroll that produces the blue gem. It has great and miraculous power.",},
        [13] = {401,"Purple ATK Gem","Advanced purple gem, cool to the touch.","Advanced purple gem, cool to the touch.",},
        [14] = {402,"Purple DEF Gem","Advanced purple gem, cool to the touch.","Advanced purple gem, cool to the touch.",},
        [15] = {403,"Purple HP Gem","Advanced purple gem, cool to the touch.","Advanced purple gem, cool to the touch.",},
        [16] = {404,"Purple Awaken Scroll","The original scroll that produces the purple gem. It has miraculous power.","The original scroll that produces the purple gem. It has great and miraculous power.",},
        [17] = {501,"Violet ATK Gem","Advanced purple gem, cool to the touch.","Advanced purple gem, cool to the touch.",},
        [18] = {502,"Violet DEF Gem","Advanced purple gem, cool to the touch.","Advanced purple gem, cool to the touch.",},
        [19] = {503,"Violet HP Gem","Advanced purple gem, cool to the touch.","Advanced purple gem, cool to the touch.",},
        [20] = {504,"Violet Awaken Scroll","The original scroll that produces the purple gem. It has miraculous power.","The original scroll that produces the purple gem. It has great and miraculous power.",},
        [21] = {601,"Starry ATK Gem","Advanced purple gem, cool to the touch.","Advanced purple gem, cool to the touch.",},
        [22] = {602,"Starry DEF Gem","Advanced purple gem, cool to the touch.","Advanced purple gem, cool to the touch.",},
        [23] = {603,"Starry HP Gem","Advanced purple gem, cool to the touch.","Advanced purple gem, cool to the touch.",},
        [24] = {604,"Starry Awaken Scroll","The original scroll that produces the purple gem. It has miraculous power.","The original scroll that produces the purple gem. It has great and miraculous power.",},
        [25] = {701,"Yellow ATK Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [26] = {702,"Yellow DEF Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [27] = {703,"Yellow HP Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [28] = {704,"Yellow Awaken Scroll","The original scroll that produces the orange gem. It has miraculous power.","The original scroll that produces the orange gem. It has great and miraculous power.",},
        [29] = {801,"Dragonglass ATK Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [30] = {802,"Dragonglass DEF Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [31] = {803,"Dragonglass HP Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [32] = {804,"Dragonglass Awaken Scroll","The original scroll that produces the orange gem. It has miraculous power.","The original scroll that produces the orange gem. It has great and miraculous power.",},
        [33] = {901,"Sun ATK Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [34] = {902,"Sun DEF Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [35] = {903,"Sun HP Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [36] = {904,"Sun Awaken Scroll","The original scroll that produces the orange gem. It has miraculous power.","The original scroll that produces the orange gem. It has great and miraculous power.",},
        [37] = {1001,"Shiny ATK Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [38] = {1002,"Shiny DEF Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [39] = {1003,"Shiny HP Gem","Top-type gem glows orange, cool to the touch.","Top-type gem glows orange, cool to the touch.",},
        [40] = {1004,"Shiny Awaken Scroll","The original scroll that produces the orange gem. It has miraculous power.","The original scroll that produces the orange gem. It has great and miraculous power.",},
        [41] = {1101,"Red ATK Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [42] = {1102,"Red DEF Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [43] = {1103,"Red HP Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [44] = {1104,"Red Awaken Scroll","The original scroll that produces the red gem is said to have great and miraculous power.","The original scroll that produces the red gem is said to have great and miraculous power.",},
        [45] = {1201,"Scarlet ATK Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [46] = {1202,"Scarlet DEF Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [47] = {1203,"Scarlet HP Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [48] = {1204,"Scarlet Awaken Scroll","The original scroll that produces the red gem is said to have great and miraculous power.","The original scroll that produces the red gem is said to have great and miraculous power.",},
        [49] = {1301,"Bloody-moon ATK Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [50] = {1302,"Bloody-moon DEF Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [51] = {1303,"Bloody-moon HP Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [52] = {1304,"Bloody-moon Awaken Scroll","The original scroll that produces the red gem is said to have great and miraculous power.","The original scroll that produces the red gem is said to have great and miraculous power.",},
        [53] = {1401,"Splendid ATK Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [54] = {1402,"Splendid DEF Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [55] = {1403,"Splendid HP Gem","Top-type gem glows red, cool to the touch.","Top-type gem glows red, cool to the touch.",},
        [56] = {1404,"Splendid Awaken Scroll","The original scroll that produces the red gem is said to have great and miraculous power.","The original scroll that produces the red gem is said to have great and miraculous power.",},
    }
}

return gemstone