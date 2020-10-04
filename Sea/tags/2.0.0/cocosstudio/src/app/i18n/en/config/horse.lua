--horse

local horse = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      name = 2,    --装备名称-string 
      description = 3,    --装备描述-string 
      type = 4,    --泛用性-string 
      show_day = 5,    --图鉴显示天数-int 
      hero = 6,    --适用武将_math-string 
    
    },
    -- data
    _data = {
        [1] = {1,"White Horse","White Horse, beautiful horse with fancy shade. It was fearless in the battle field and dared to rush directly to the enemies.","All",0,"999",},
        [2] = {2,"Bluish Horse","Bluish Horse, one of the eight great horses of Emperor Mu of Zhou. It was blue and yellow and was indefatigable after traveling thousand miles. ","All",0,"999",},
        [3] = {3,"Yellow Horse","Yellow Horse, just as its name indicated, it was light yellow and one of the eight great horses of Emperor Mu of Zhou. When it ran, you could see ten shadows behind as it had lightning speed.","All",0,"999",},
        [4] = {4,"Sturdy Horse","Sturdy Horse whose body was brown. Its muscles were strong like steel. It's so powerful that it could move fast even after carrying hundred kilograms of stuff.","All",0,"999",},
        [5] = {5,"Snowy Horse","Snowy Horse whose body was pure white and hooves were black. It's like running on the flat ground when it ran in the snow. Gentleman among the horses.","All",0,"999",},
        [6] = {6,"Valiant Horse","Valiant Horse, like a purple swallow. Unyielding and lofty.","All",0,"999",},
        [7] = {7,"Ruby Horse","Ruby Horse whose body was like a red jade. Lucky horse of the emperor.","All",0,"999",},
        [8] = {8,"Flash Horse","Flash Horse whose body was bluish white and muscular was fast and beautiful. When it flew, it's like the dragon was flying across the sky.","All",0,"999",},
        [9] = {9,"Flying Frost","Flying Frost whose body was white like frost. Lithe and mysterious, it was indefatigable after traveling thousand miles. The place that it passed was like being covered by frost. Extreme chill let no one dare to approach.","Support Type",40,"103|110|112|117|118|204|211|304|315|404|412|417",},
        [10] = {10,"Cloudy Snow","Cloudy Snow whose body was like black satin, glossy and shiny. Only its four hooves were white like snow. With long body and flat and short waist, its tendons of the joints were well-developed. It was extremely loyal.","DPS Type",40,"1|2|3|4|5|11|12|13|14|15|101|107|108|109|111|113|114|201|205|206|208|209|213|217|218|301|306|308|310|316|318|3|403|406|407|410|413|414|416",},
        [11] = {11,"Fire Dragon","Fire Dragon whose body was in pure red like fire. Its neigh gave you a sense that it would soar into the sky and dive into the sea. Its manes were thick like forest and soft like girl's hair. It could run fast and it was like running on the flat ground when crossing the rivers and mountains.","Healing Type",40,"102|202|302|402|216",},
        [12] = {12,"Jade Lion","Jade Lion whose body was in pure white and only its neck and tail were covered by golden manes. Its hooves were big. It was fierce like lion. It could run a thousand miles in a day and crossed extremely rugged landscapes. No one could stop it in the battle field.","Support, Control Type",40,"103|106|110|112|115|116|117|118|203|204|210|211|212|214|219|304|307|312|315|317|401|404|408|409|411|412|415|419|417",},
        [13] = {15,"Thunderous Horse","Unparalleled running thunder. It was like a thunder when it ran accompanied by lightning on head and dark light under hooves. It could understand human and had good endurance. It helped heroes make numerous exploits.","MT Type",999,"105|119|207|215|309|314|405|418",},
        [14] = {13,"Divine - Flying Lightning","Divine - Flying Lightning whose body was white and hooves were yellow. Elegant and unique, it was lofty and arrogant. It was the horse of the great emperor.","All",9999,"999",},
        [15] = {14,"Divine - Moon Chaser","Divine - Moon Chaser, fierce and violent. It could run extremely fast. It could even run in the water and jumped to the sky. It's a piece of cake for it to jump across rivers and lakes.","All",9999,"999",},
    }
}

return horse