--instrument

local instrument = {
    -- key
    __key_map = {
      id = 1,    --id_key-int 
      name = 2,    --名称-韩语-string 
      instrument_description = 3,    --神兵描述-韩语-string 
      hero = 4,    --相关武将-韩语-string 
      description = 5,    --神兵+25特性描述-韩语-string 
      description_1 = 6,    --神兵+50特性描述-韩语-string 
      description_2 = 7,    --神兵+75特性描述-韩语-string 
    
    },
    -- data
    _data = {
        [1] = {1,"열천용담창","용담보석이 장착 된 현철장창, 견고하여 부러지지 않으며, 열천의 힘이 있다","남주인공","스킬로 인한 피해 25% 증가","초기분노+1","초기분노+1",},
        [2] = {2,"오세명홍도","헌원황제를 위해 만들어 졌다는 보도, 더없이 화려하고, 칼날은 가을 서리와 같아 철도 진흙처럼 벨 수 있다.","여주인공","스킬로 인한 피해 25% 증가","초기분노+1","초기분노+1",},
        [3] = {101,"효수장","날카로운 칼날은 서리와 같고 차가운 빛을 내며 효수의 날개깃이 끝에 새겨져 있다. 음기가 강하고, 신기가 흐른다.","사마의","스킬시전 시 40% 확률로 스킬 1회를 추가, 적 전체에게 41% 마법피해 (추가스킬특성없음)","초기분노+1","초기분노+1",},
        [4] = {102,"벽옥소","순욱이 몸에 지니고 다니는 벽옥피리. 따듯한 온기가 흐르고 무한한 생기를 품고 있다.","순욱","스킬로 인한 치료량 25% 증가","초기분노+1","초기분노+1",},
        [5] = {103,"맹덕검","팔척길이의 넓은 검. 조조와 함께 반평생을 보내며 무수한 공로를 세웠다. 위무제 조조의 무기인데 어떻게 나쁠 수 있겠는가.","조조","전체출전장수 치명확률 30% 증가","초기분노+1","초기분노+1",},
        [6] = {104,"천군선","높은 곳에 올라 천군만마를 한눈에 보고 있는 듯하다. 곽봉효는 지략이 뛰어나  조조가 국토의 절반을 차지하는 데 일조를 하였다.","곽가","스킬시전 시 분노 회복 +1","초기분노+1","초기분노+1",},
        [7] = {105,"강열수라도","칼날은 가시처럼 날카롭고 검붉은 색을 띤다. 수라도는 전투를 할수록 더욱 강력해진다.","하후돈","일반공격 피해를 받을 시 자신의 분노 회복 +1 ","초기분노+1","초기분노+1",},
        [8] = {106,"사수현철순","철벽같이 견고하여 쉽게 부서지지 않는다.","조인","사망 시 자신의 적 장수를 100% 기절 시켜 처치","초기분노+1","초기분노+1",},
        [9] = {107,"악새쌍수극","팔십 근에 달하는 쌍극, 태산처럼 굳건하고, 산에서 호랑이를 쫓아낼 만큼 용맹한 기운을 가졌다.","전위","스킬로 인한 피해 25% 증가","초기분노+1","초기분노+1",},
        [10] = {108,"낭아유성추","가시가 박혀있고 매우 견고하며 소리가 우렁차다. ","허저","적 처치 후 분노 회복 +1","초기분노+1","초기분노+1",},
        [11] = {109,"파천구렴도","긴 갈고리 낫으로 찌르기, 베기, 걸기가 가능하여 전장에서 유연하게 사용할 수 있다.","장료","매 턴마다 분노 회복 +1","초기분노+1","초기분노+1",},
        [12] = {110,"절급투골조","두 개 발톱 여섯 개 가시, 냉혹하고 잔인하며 뼛속까지 파고든다. 순식간에 접근해 생명을 앗아간다.","장합","전체출전장수 치명확률 20% 증가","초기분노+1","초기분노+1",},
        [13] = {111,"유황멸혼조","무한한 어둠의 기운을 흡수하여 불규칙하고 무질서한 혼을 깨끗이 제거한다.","조비","스킬목표 1명 감소 시 마다 스킬피해 10% 증가","초기분노+1","초기분노+1",},
        [14] = {112,"낙신쇄운편","풀면 줄이 되고, 감으면 가시가 된다. 움직임이 보는 이로 하여금 눈을 어지럽게 만든다.","견희","스킬피해의 50% 생명전환, 생명 가장낮은 아군치료","초기분노+1","초기분노+1",},
        [15] = {113,"전륜수리검","악진이 어릴 적 서역을 유람할 때 금륜법왕에게 무예를 배우고 이 무기를 선물받았다.","악진","일반공격 피해 50% 치료전환, 자신치료","0","0",},
        [16] = {114,"이인장병부","아끼는 투구에 맞추기 위해 거금을 들여 이 도끼를 찾아냈다. 투구와 매우 잘 어울리며 하얗게 반짝인다.","서황","첫 번째 턴의 피해는 100% 치명타","0","0",},
        [17] = {115,"연가상","조충이 코끼리의 무게를 다는 저울, 왜인지는 조충에게 물어보세요.","조충","스킬시전 시 추가된 침묵효과 확률 70%까지 증가","0","0",},
        [18] = {116,"운문호","본디 같은 뿌리에서 태어났건만 어찌하여.... 조식 그대는 왜 형의 아내를 마음에 두고 있는가?","조식","스킬시전 시 추가된 기절효과 확률 80%까지 증가","0","0",},
        [19] = {117,"엽표궁","활을 얕봐서는 안 된다. 정확성과 속도까지 더해져 발사한 화살은 번개처럼 매우 빠르게 날아간다.","하후연","스킬 피해의 40% 생명전환, 생명 가장낮은 아군치료","0","0",},
        [20] = {118,"절정검","장춘화가 일생을 함께 한 사마의, 무정한 듯하나 정이 있으며, 가장 고통스러운 것은 그리움이다. 변화무쌍한 검으로 막기가 힘들다.","장춘화","아군 피해감소 45%까지 증가","0","0",},
        [21] = {119,"질풍지인","질풍검호의 검, 질풍검호의 망토, 질풍검호의 상전벽해~","우금","받는 피해 20% 생명전환, 자신치료","0","0",},
        [22] = {201,"신위용담창","창을 던지면 공중에서 은룡으로 변신한 후 급강하해 적을 산산조각낸다.","조운","적 처치 시 일반공격 추가 +1 (추가된 일반공격은 분노회복불가)","초기분노+1","초기분노+1",},
        [23] = {202,"자웅쌍고검","청룡과 자룡이 변해 만들어진 검, 이검을 가진자는 귀한자리에 오를 수 있다고 한다. ","유비","받은 피해의 18%를 생명전환, 아군전체치료","초기분노+1","초기분노+1",},
        [24] = {203,"칠성우선","백옥으로 만들어진 부챗살, 독수리 깃털에 북두칠성을 더하고 팔괘를 끼어넣었다. 부채질을 하면 바람과 비를 소환할 수 있고 시비를 가릴 수 있다.","제갈량","스킬시전 시 목표 분노 감소 -1","초기분노+1","초기분노+1",},
        [25] = {204,"목우유마","다리 하나에 발이 네 개이고, 머리는 목 안에 들어가 있으며, 혀가 배에 붙어 있다. 많이 실으면 느리게 걷고, 혼자면 수십 리를 갈 수 있다. ","황월영","스킬시전 시 전체아군 분노 회복 +1","초기분노+1","초기분노+1",},
        [26] = {205,"청룡언월도","관공이 아끼는 패도, 손잡이는 청룡이 변한 것이라는 전설이 있다. 반달 같고 매우 날카롭다. ","관우","적 처치 시 분노 회복 +1","초기분노+1","초기분노+1",},
        [27] = {206,"장팔사모","강철 일천 근으로 만들어진 장팔점강모. 양 칼이 얽혀 있는 모습이 뱀 같다 하여 장팔사모라고도 불린다.","장비","자기생명 10% 감소, 공격 5% 증가","초기분노+1","초기분노+1",},
        [28] = {207,"호두침금창","마초의 어머니는 강족 사람으로 강족의 비법을 이용하여 이 창을 만들었다. 무게는 팔십 근이며, 급소를 바로 공격하여 순식간에 적의 갈비뼈와 오장육부를 파괴할 수 있다.","마초","받는 치료량 50% 증가","초기분노+1","초기분노+1",},
        [29] = {208,"은인열화궁","칼로도 쓸 수 있고 활로도 쓸 수 있어, 가까이에서 적을 죽일 수 있고, 먼 거리에서 사격할 수도 있다. 위나라 명장 하후연이 이 활로 인해 죽임을 맞이했다.","황충","적 처치 후, 일반공격 1회 추가 (추가된 일반공격은 분노회복없음)","초기분노+1","초기분노+1",},
        [30] = {209,"금룡연노","제갈량이 발명하여 강유에게 준 무기. 활 안에는 화살 여러 발이 숨겨져 있어 순식간에 여러 발을 쏴 막강한 위력을 뽐낼 수 있다.","강유","매 턴마다 자신의 공격 8% 증가","초기분노+1","초기분노+1",},
        [31] = {210,"기혈염도","손잡이를 금으로 만들고 피로 칼을 담금질하였다. 기혈염도를 빼는 순간 적군의 피가 사방에 흩뿌려진다.","위연","스킬시전 시 기절효과 추가확률 65%까지 증가","초기분노+1","초기분노+1",},
        [32] = {211,"봉황법장","수경선생이 하사한 무기. 후에 방통은 이 법장을 사용하여 유비가 왕위에 오르는 데 일조하였다.","방통","모든출전장수 치명확률 20% 증가","초기분노+1","초기분노+1",},
        [33] = {212,"무영산검","소년시절에는 강호협객으로 지냈으나, 무를 버리고 문을 택하여 시와 책을 많이 읽었다. 지적 받는 것을 원치않아 검을 항상 우산 안에 숨겨다녔다.","서서","스킬시전 후 자신의 분노 회복 +1 ","초기분노+1","초기분노+1",},
        [34] = {213,"감지장","서남대산의 백 년 고목 중간 몸통으로 만들었다.  보통사람은 쉽게 멜 수 없으며, 맹획만이 태생적으로 타고난 신력으로 다룰 수 있다.","맹획","1명의 적 처치 시 마다, 자신의 공격 8% 증가","0","0",},
        [35] = {214,"영운모","축융은 어릴 적부터 산에서 자라 나무로 창을 잘 만들었다. 이 창은 예리하고 정확하여 사냥감과 적군이 도망갈 곳이 없다.","축융","사망 시 스킬을 1회 시전","0","0",},
        [36] = {215,"촉도취죽","판다는 뒹굴뒹굴하며 대나무 먹는 것을 좋아해 아두는 대나무로 소검을 만들었다. 그러나 이것 때문에 아버지 현덕에게 한대 얻어맞았다.","아두","자신의 피해감소 45%까지 증가 ","0","0",},
        [37] = {216,"청하","화타를 스승으로 모시고, 좌자에게 또한 가르침을 받았다. 작은 연잎은 치료에 좋다.","장성채","사망 시 스킬을 1회 시전","0","0",},
        [38] = {217,"언월장도","관우가 은병을 위해 직접 만든 언월장도로 반짝임이 있다.","관은병","적 처치 시 자신의 생명 20% 회복","0","0",},
        [39] = {218,"용린도","은병의 무기를 만들고 남은 재료로 만들었다. 무성이라도 딸이 더 예쁜건 어쩔수 없나보다.","관평","스킬로 인한 피해 15% 증가","0","0",},
        [40] = {219,"등사법장","세 마리 금사를 빙빙 감아 제작한 지팡이, 한 번만 쳐다 봐도 현혹되어 움직일 수 없다.","법정","스킬시전 시 추가된 마비효과 확률 70%까지 증가","0","0",},
        [41] = {301,"금룡신간","고대 신병을 단조하여 만든 것으로, 내부에 어떤장치가 되어있다. 장갑 형태로 변형 가능하고, 끝을 매우 교묘하게 만들어 놓아 소패왕의 무기가 될만 하다.","손책","공격 시, 화염 목표에 대한 치명타 확률 추가 80% 증가","초기분노+1","초기분노+1",},
        [42] = {302,"연화유산","청죽으로 만들어진 우산살, 구화분연이 그려져 있고, 손잡이는 태산 거목으로 만들었다. 영험한 기가 서려져 있다.","대교","스킬시전 후 아군에게 추가된 지속치료 효과 대교 공격 32%까지 증가","초기분노+1","초기분노+1",},
        [43] = {303,"도독광인","푸른 옥빛을 띠며 길이가 팔 척 정도되고 주인과 마음이 통한다. 날카로운 검을 칼집에서 꺼내고 천만군마를 지휘하는 대도독의 용맹한 모습을 드러낸다.","주유","일반공격 받을 시, 80%의 확률로 공격자가 화염효과를 받으며 2턴 지속","초기분노+1","초기분노+1",},
        [44] = {304,"선화쌍선","금으로 만든 부챗살, 비단으로 덮혀 화려하고 우아하다. 주인처럼 자태가 아름다우며 적을 빠르게 공격할 수 있다.","소교","스킬시전 후 생명이 가장 낮은아군 2명에게 무적흡혈보호 추가되며 1턴 지속","초기분노+1","초기분노+1",},
        [45] = {305,"광가낙일궁","한무제가 하사한 것으로 후에 태사자의 부친이 우연히 손에 넣게 되었다. 이 활은 화염의 힘을 가지며 발사 명중 시 사람을 발화시켰다. 태사자는 용맹한 모습으로 백발백중의 실력을 뽐내는 동오의 대장군이 되었다.","태사자","일반공격 받을 시 50%의 확률로 공격자가 화염되며 2턴 지속","초기분노+1","초기분노+1",},
        [46] = {306,"청명검","손권이 황제라 칭한 후 만든 6개 검으로 일일 백홍, 이일 자전, 삼일 벽사, 사일 유성, 오일 청명, 육일 백리가 있다. 손권은 청명검을 특히나 좋아했다.","손권","화염목표 처치 후, 자신의 생명 50%회복","초기분노+1","초기분노+1",},
        [47] = {307,"멸천묘","여몽이 백의도강 시 이 닻을 이용해 상인으로 위장해서, 형주의 수위가 허술한 틈을 노려 그들을 기절시킨 후 대군을 이끌고 형주성을 쳐들어갔다.","여몽","스킬시전 시 적이 화염상태 시 추가로 기절효과 확률 80%까지 증가","초기분노+1","초기분노+1",},
        [48] = {308,"금령도","비단범선을 타고 유랑하던 감녕이 지니고 다녔던 대도, 화려한 금색 무늬가 조각되어 있어 눈길을 사로잡는다. 봉황 깃털, 금색방울과 함께 감녕을 상징하는 물건이다.","감녕","화염목표에게 일반공격 가할 시 추가로 피해 80% 증가","초기분노+1","초기분노+1",},
        [49] = {309,"열염순","옛사람이 이르기를 형천은 간척을 휘둘렀으니 맹렬한 뜻은 굳건히 변치 않고 있도다. 여기서 간은 방패를 의미하며 손견이 방패로 공격할 때의 모습을 나타낸다.  매우 무거우며, 호랑이처럼 달려들면 활활 타는 불이 끊이지 않아 적군을 발화시킨다.","손견","화염상태의 적에게 공격 받을 시, 피해 65% 감소","초기분노+1","초기분노+1",},
        [50] = {310,"나찰윤","어릴 때부터 칼과 창을 가지고 노는 것을 좋아하자 손견이 딸을 위해 이 쌍도환을 구해왔다. 회전할 때면 하늘에 걸려 있는 보름달처럼 아름다우면서도 예리하여 쉽게 적을 산산조각낼 수 있다.","손상향","스킬시전 후 일반공격 1회 추가 (추가된 일반공격은 분노회복없음)","초기분노+1","초기분노+1",},
        [51] = {311,"작월인","겸손하고 온화한 소도독, 빛이 나는 날카로운 검을 휘두르면 열염분천의 빛 속에서 담담하게 웃고 있는 의미심장한 얼굴을 볼 수 있다. 물처럼 온화한 모습으로 응시하지만 자칫 잘못했다간 발화될 수 있다.","육손","스킬시전 시 추가된 화염 확률 96%까지 증가","초기분노+1","초기분노+1",},
        [52] = {312,"화수분","선행을 미덕으로 아는 노숙, 삼국 최고의 재벌 2세로 평생 가난을 모르고 살았다. 그는 하늘의 재물신이 인간 세상에 떨어뜨린 화수분을 가지고 있어 재물이 끊이지 않았다.","노숙","일반공격 시전 후,  적의 분노감소 -1 ","초기분노+1","초기분노+1",},
        [53] = {313,"무근곤","영생불멸의 여의봉이 잠시 속세로 내려왔다. 여의봉이 무극곤으로 변신하여 쉬지않고 전투에 임하니, 몸속의 피가 활활 타올라 호방한 기운을 뿜어낸다.","능통","일반공격 받을 시 40%확률로 공격자가 연소되며 2턴 지속","0","0",},
        [54] = {314,"단해편","주유가 황개를 공격할 때 황개의 단해편을 사용했다고 전해진다. 황개의 둔부를 내려쳐 침상에서 내려올 수가 없게 만들었고, 이때야 비로소 조조는 고육책을 믿게 되었다.","황개","받은 치료량 40% 증가","0","0",},
        [55] = {315,"금옥홀","내 손 안에 있는 금옥홀이 두려운가? ","장소","자신의 공격피해 흡수 100%까지 증가","0","0",},
        [56] = {316,"불굴인","칼날은 달빛과 같고 겨울의 별처럼 예리하며, 백 마리의 용 무늬가 새겨져 있다. 칼을 휘둘러 은화수를 베고자 하나 불굴의 칼날이 절대 쓰러지지 않으며, 충심으로 충심을 구한다.","주태","적 처치 후, 자신의 분노 회복 +1 ","0","0",},
        [57] = {317,"소요금","높은 산과 흐르는 물에 십면매복이 변화무쌍하네. 악기 소리가 끊이지 않으며 가볍게 튕기면 귀가 즐겁고 무겁게 튕기면 적이 다치네.","보연사","스킬시전 시 적이 화염상태 시 추가로 기절효과 확률 80%까지 증가","0","0",},
        [58] = {318,"경천궁","상아에 보석을 박아 만들었다. 경천궁을 꺼내면 적군의 머리쯤은 식은 죽 먹기가 된다.","한당","화염 목표에 대한 피해 80% 증가","0","0",},
        [59] = {319,"비서운등","금으로 만든 전통 궁등, 우아하면서도 화려하며 맹렬한 화염의 힘을 가지고 있다.","제갈근","스킬공격 받을 시 30% 확률로 공격자가 화염되며 2턴 지속","0","0",},
        [60] = {401,"청허불","고대부터 전해 내려져 오는 먼지털이, 평범해 보이지만 실제로는 범상치 않다. 가만히 있으면 바다의 심연과 같고, 움직이면 바다의 격렬한 파도처럼 일렁인다. 선검을 제어하는 것이 교룡과 같고, 서리를 일으켜 매우 춥다.","좌자","스킬시전 시 추가된 기절효과 확률 70%까지 증가","초기분노+1","초기분노+1",},
        [61] = {402,"천추장","화타의 친구 좌자가 복숭아나무에서 꺾은 가지로 만든 법장, 산에 올라 약초를 캘 때는 길을 안내해주며 약재로 만들어 먹으면 피를 보할 수 있다.","화타","치료목표 생명 10% 감소 시 마다 치료량 5% 증가","초기분노+1","초기분노+1",},
        [62] = {403,"방천화극","무게는 백근에 달하며, 원법을 사용하여 치기, 내려치기, 옆으로 찌르기, 베기가 가능한다. 내법을 사용하여 뒤집기, 걸기, 박기, 찌르기가 가능하다.  당법을 사용하여 찌르기, 쑤시기, 베기가 가능하다. 여포는 방천화극과 함께 전장을 누비며 눈부신 업적을 세웠다.","여포","적 처치 후, 자신의 분노 회복 +2 ","초기분노+1","초기분노+1",},
        [63] = {404,"선주미화","천지의 기운이 담겨져 있는 연꽃, 그 아름다움을 무엇으로도 표현하기 어렵다.","초선","스킬 피해의 50% 생명전환, 생명이 가장 낮은 아군치료","초기분노+1","초기분노+1",},
        [64] = {405,"마왕구","낙양을 한번에 불태우고, 기개가 있는 자의 두개골을 철성보도로 갈아 만든 갈고리, 꺼냈다 하면 목숨을 앗아갈 수 있다.","동탁","피해감소 보호로 모든 피해 50%까지 감소","초기분노+1","초기분노+1",},
        [65] = {406,"패천부","서량 고목의 뿌리로 만든 도끼 손잡이, 양주 주석을 제련하여 만든 도끼날, 어두운 자색을 띠며 청옥보석이 박혀 있다. 몸에 지닌 자는 대장의 기개가 넘쳐나나 청룡을 만나면 재앙을 입게 된다.","화웅","적 처치 후, 자신의 분노회복 +1 ","초기분노+1","초기분노+1",},
        [66] = {407,"염왕필","가후가 들고 있는 붓은 안에 독을 가득 머금고 있어 쉽게 사람을 독살시킬 수 있다.","가후","스킬시전 시 추가된 중독효과 확률 96%까지 증가","초기분노+1","초기분노+1",},
        [67] = {408,"비운창","공손찬은 3천 기병을 이끌고 요서 오환을 쳐들어갔다. 오환의 수령 탐지왕은 부하들을 이끌고 공손찬에게 투항하며 이 창을 건냈고 이름은 비운창이라고 한다.","공손찬","스킬시전 후 자신의 분노 추가회복 +1 ","초기분노+1","초기분노+1",},
        [68] = {409,"뇌정양각장","금으로 만든 양머리 법장, 강력한 벼락의 기운이 담겨있어 꺼내들면 천지가 울리고 파도가 세차게 일렁인다.","장각","스킬시전 후 적의 분노감소 -1","초기분노+1","초기분노+1",},
        [69] = {410,"천환독괴뢰","우길이 나무로 만든 꼭두각시, 복부 안쪽 빈 공간에는 독액이 있어 조금만 묻혀도 생명을 빼앗을 수 있다.","우길","스킬시전 후 적의 분노감소 -1 ","초기분노+1","초기분노+1",},
        [70] = {411,"진패도검","여남 원씨가문은 집안에 엄청난 보물을 가지고 있다. 보물 중에는 예리함이 그 무엇과도 비할 수 없는 보검이 있는데 천하를 품에 안은 영웅에게 어울려 원소에게 전해졌다.","원소","스킬시전 시 추가된 마비효과 확률 50%까지 증가","초기분노+1","초기분노+1",},
        [71] = {412,"전국옥새","진나라 승상 이사가 황제의 명을 받고 화씨벽을 조각하여 만들었다. 길이는 네 치이고 위에는 5마리 용이 교차되어 있다. 천자가 이것을 얻으면 천하를 얻을 수 있고, 천자가 아니면 비명횡사하게 된다.","원술","스킬시전 후 자신의 분노 +1 추가회복","초기분노+1","초기분노+1",},
        [72] = {413,"열공도","열공도는 매우 길다. 길이가 어느 정도이냐 하면 짧은 무기 중에서 최고이다.","안량","첫 턴의 적에게 가하는 피해 100%  치명 ","0","0",},
        [73] = {414,"쇄악추","두려울것이 없는 망치, 필부의 용맹을 가진 문추에게 맞는 무기이다.","문추","1명의 적 처치 시 마다, 자신의 공격 8%까지 증가","0","0",},
        [74] = {415,"천애비가","우여곡절이 많았던 채문희의 일생처럼 연주를 들으면 눈물이 맺힌다.","채문희","스킬시전 시 추가된 기절효과 확률 80%까지 증가","0","0",},
        [75] = {416,"용천검","고대 보검, 수많은 세월을 겪으며 군주 충신 아니면 간신 영웅호걸이든 상관없이 능력이 되면 죽이고, 능력이 안 되면 만다. 나는 나의 길을 갈 뿐.","진궁","스킬로 인한 피해 15% 증가","0","0",},
        [76] = {417,"죽마","작은 죽마가 공융의 무기가 되었다. 공자의 후손인지 아니면 한말의 제후인지 그것은 중요하지 않다.","공융","일반공격 시전 후, 자신의 분노 +1 추가","0","0",},
        [77] = {418,"소방천화극","무기의 이름만 봐도 주인의 신분을 알 수 있다.","여영저","일반공격 피해의 50%가 생명으로 전환 자신치료","0","0",},
        [78] = {419,"단자절손전","공중에서 날카로운 소리를 내며 떨어진다. 비틀 때 힘은 그 누구도 감당하기 어렵다. ","장양","스킬시전 시 추가된 침묵효과 확률 80%까지 증가","0","0",},
        [79] = {150,"유명주선인","저세상의 힘으로 주조한 검으로 악령의 혼이 깃들어 있다고 한다.","자상","스킬공격 목표가 여장수일 경우 자신의 분노회복+2, 스킬공격 목표가 남장수일 경우 일반공격 1회 추가 최대생명의 36% 피해(해당 공격에는 장수 특성이 발동 하지 않음)","초기분노+1","초기분노+1",},
        [80] = {250,"창송수은금","푸른 소나무의 혼을 모아, 파도를 가라 앉히고 자연과 하나가 된다. ","수경","적군과 아군 사망 시 마다, 수경의 피해 10% 증가","초기분노+1","초기분노+1",},
        [81] = {350,"열염예황도","봉황의 영혼을 담아 붉은 연꽃을 피우고 더욱더 새롭게 태어난다.","주희","스킬시전으로 남장수 공격 시 최대생명의 10% 피해 추가, 스킬시전으로 여장수 공격 시 생명이 가장 낮은 아군 2명의 제어효과 제거","초기분노+1","초기분노+1",},
        [82] = {450,"연양추혼장","무한한 힘을 가진 금명아주 지팡이, 이를 가진자는 최고의 신공을 얻고 수련하면 젊음을 얻는다.","남화","스킬 피해 추가 +36%, 일반공격 피해 추가 +72% ","초기분노+1","초기분노+1",},
    }
}

return instrument