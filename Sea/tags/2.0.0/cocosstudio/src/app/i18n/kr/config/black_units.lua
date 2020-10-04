local black_unit={}
local _unit_data={
["병"] = {"병신같은놈","병신년","병신","병삼","병신조진다","병쉰","병신년아","병신씹세","병신들아","병신쉑기","병싄","병신씹쌔","병신놈아","병엉신","병시년아","병딱","병신같은년","병신씹쎄","병시나","병신놈","병신쉑히","병시놈아","병신개자식","병닥","병신씹새","병닭",},
["최"] = {"최저가","최저수수료",},
["쇄"] = {"쇄뤼","쇄리","쇄끼",},
["쇅"] = {"쇅끼",},
["변"] = {"변태새뀌","변땅크","변태색히","변태","변테","변섹","변녀","변태새끼",},
["보"] = {"보g구녁","보즤구멍","보지구녕","보g구멍","보z물","보즤","보지구녁","보ji구멍","보g구녕","보z","보지빨아","보지같은년","보즤구녕","보장","보G","보쥐구멍","보쥐물","보즤털","보z빨아","보z털","보지시궁창","보ji구녁","보쥐털","보즤구녁","보ji털","보쥣물","보지찌렁내","보g물","보ji","보지구멍","보쥣털","보짓물","보즷물","보ji구녕","보쥐","보z구녕","보쥐구녁","보ji물","보지갑은놈","보지털","보쥐구녕","보z구멍","보즤물","보g빨아","보z구녁","보ji빨아","보짓","보g털",},
["N"] = {"None",},
["쇠"] = {"쇠끼",},
["본"] = {"본사",},
["노"] = {"노무노무","노옹",},
["환"] = {"환8불","환불119","환불.대.행","환불상담","환불","환불하는법","환4불","환9불","환l불","환.뷸","환불승인","환6불","환1불","환/불","환불공략","환,뷸","환5불","환3불","환2불","환불장인","환 불","환대불행","환환.불불","환불대행후기","환불문의","환:불","환,불","환불거부","환.불.대.행","환.불","환불신청","환불대행","환불사유","환..불","환불대리","환뷸","환~불","환`불","환불전문","환7불",},
["고"] = {"고추털","고뇬","고년",},
["짬"] = {"짬지",},
["화"] = {"화냥뇬","화상색","화안불","화냥질","화상섹","화냥냔","화 안 불","화양년","화냥년","화양냔","화양뇬","화안불대행",},
["홍"] = {"홍어족","홍팍",},
["과"] = {"과부촌",},
["계"] = {"계쎄","계자즤","계섹기","계새기","계세리","계눔","계쉽세","계씨발","계색햐","계좌지","계십새","계섹끼","계새뤼","계시키","계보ji","계보g","계자쥐","계세기","계좌쉭","계삽년","계보z","계지럴","계늠","계좇","계좆","계보즤","계섹꺄","계새꺄","계섹야","계섹이","계새야","계세뤼","계색끼","계세꺄","계지뢀","계쐑","계좌식","계냔","계자ji","계자지","계쐭","계쉬키","계색꺄","계보쥐","계좃","계같은","계세야","계세끼","계넘","계새리","계새히","계가턴","계쉐","계쉐리","계지룰","계자g","계년","계쒜","계섹히","계자z","계씹쎄","계색히","계보지","계섹햐","계뇬","계시끼","계지랄","계색야","계놈","계자식","계색기","계쌕","계섹","계가튼","계쉽새","계꼬치","계씹새","계샠","계십세","계씹쌔","계새끼","계쉐이","계지롤","계씹세","계자슥","계색이","계새","계색",},
["모"] = {"모두받아드림",},
["f"] = {"fuck",},
["황"] = {"황부울","황불",},
["p"] = {"porno","porn","pussy","pennis","prno","ponsec","penis","ponsek",},
["짜"] = {"짜쥐","짜즤","짜지","짜저","짜져",},
["앰"] = {"앰병",},
["등"] = {"등신","등신세끼","등신시끼","등신새끼","등쉰","등시",},
["야"] = {"야동","야동녀",},
["똘"] = {"똘봉년","똘마뉘","똘마니",},
["또"] = {"또라이","또라이새리",},
["앙"] = {"앙망문","앙망",},
["육"] = {"육씨롤","육시랄","육봉","육시룰","육봉대가리","육실할","육시뢀","육씨럴","육씨뢀","육시럴","육시롤","육씨룰","육구자세","육씨랄","육갑",},
["유"] = {"유듀","유일","유두",},
["똥"] = {"똥쳐먹어","똥걸레","똥대가리",},
["윤"] = {"윤락","윤간",},
["꼴"] = {"꼴통","꼴리는","꼴리다","꼴려",},
["아"] = {"아가리","아구창","아구리","아색이가","아씨뽀랄","아새끼가","아색기가","아색히가","아굴창","아갈통",},
["알"] = {"알보칠",},
["쮜"] = {"쮜롤","쮜랄","쮜럴","쮜룰","쮜뢀",},
["븡"] = {"븡신","븡알",},
["늬"] = {"늬미","늬믜창",},
["쎅"] = {"쎅히","쎅쓰","쎅이","쎅기","쎅스",},
["쎄"] = {"쎄꺄","쎄액쓰","쎄엑스","쎄리","쎄뤼","쎄엑쓰","쎄액스",},
["븅"] = {"븅신색히","븅신색야","븅신개자식","븅쉰","븅싄","븅삼","븅신새끼","븅신","븅신새꺄","븅신색햐","븅딱","븅시나","븅신색이","븅신쉑히","븅신쌕끼",},
["느"] = {"느그애비","느그애미",},
["뉘"] = {"뉘미럴","뉘기미","뉘귀미","뉘김","뉘미","뉘잉기미","뉘미룰",},
["뉜"] = {"뉜기미",},
["생"] = {"생뤼",},
["샛"] = {"샛귀","샛기","샛뀌",},
["뷰"] = {"뷰신","뷰쉰","뷰웅신","뷰웅삼",},
["상"] = {"상냔","상늠쉑","상년","상놈","상늠","상뇬","상노무","상놈쉑","상눔","상담","상넘",},
["채"] = {"채모","채위",},
["새"] = {"새까","새엑스","새끼","새키","새뤼","새캬","새액스","새엑쓰","새액쓰","새끈","새뀌","새퀴","새끠","새리","새꺄",},
["색"] = {"색마","색보지","색쉬","색쒸","색히","색남","색스","색폰","색갸","색햐","색s","색기","색티쉬","색뀌","색꼴","색소리","색무비","색쓰","색쑤","색뜨","색끼","색야","색파트너","색걸","색귀","색쓔","색슈","색녀","색광","색티즌","색골","색쇼","색수",},
["샹"] = {"샹팔개년",},
["뉭"] = {"뉭기미",},
["6"] = {"60일","6시럴","6969","696969","65일","6실할","6시랄","69",},
["죶"] = {"죶댓까면서",},
["죷"] = {"죷같","죷가튼","죷밥","죷꺽즤","죷지룰","죷이","죷지롤","죷만이","죷마나","죷꼭지","죷마난","죷맹구","죷만","죷물","죷꼭쥐","죷만하","죷꼭즤","죷만안","죷만아","죷더","죷빱","죷지랄","죷가은","죷마니","죷도","죷까치","죷만한","죷가치","죷꺽지","죷만히","죷지뢀","죷꺽쥐","죷지럴","죷까",},
["섀"] = {"섀끼","섀키",},
["죳"] = {"죳지럴","죳이","죳가튼","죳또","죳떠","죳도","죳더","죳만히","죳꼭지","죳지롤","죳꺽즤","죳물","죳까치","죳꼭쥐","죳꺽지","죳마난","죳마나","죳가치","죳빱","죳지룰","죳가티","죳같은","죳가은","죳지뢀","죳마니","죳같","죳까튼","죳만이","죳꺽쥐","죳만한","죳만","죳만하","죳지랄","죳밥","죳만아","죳까","죳만안","죳같이",},
["뮈"] = {"뮈친",},
["주"] = {"주둥이","주둥아리","주글년","주길년","주댕이",},
["죽"] = {"죽일년","죽일놈",},
["죧"] = {"죧까치","죧까","죧꼭지","죧밥","죧만","죧만히","죧꺽쥐","죧가은","죧지뢀","죧같","죧꺽지","죧이","죧도","죧물","죧지랄","죧지럴","죧꼭쥐","죧마나","죧가치","죧마난","죧꺽즤","죧더","죧빱","죧지롤","죧만이","죧가튼","죧마니","죧만하","죧만한","죧꼭즤","죧만안","죧만아","죧지룰",},
["죤"] = {"죤만년","죤만놈","죤내","죤네",},
["죠"] = {"죠낸","죠넨","죠밥","죠까티","죠빱","죠또",},
["꼬"] = {"꼬추털",},
["멜"] = {"멜섹",},
["메"] = {"메친년","메춘",},
["성"] = {"성색스","성고민상담","성인방송","성인용품","성방","성폭력","성상담","성폭행","성체위","성인영화","성경험","성추행","성관게","성교","성테크닉","성인만화","성감대","성인소설","성인야동","성섹스","성생활","성태크닉","성인잡지","성행위",},
["쪼"] = {"쪼가리","쪼까","쪼다","쪼오다",},
["멍"] = {"멍청도",},
["섹"] = {"섹쓔","섹파트너","섹녀","섹하장","섹귀","섹하자","섹해","섹걸","섹이","섹쑤","섹수","섹끼","섹보지","섹골","섹스","섹기","섹뀌","섹소리","섹하고","섹쓰","섹남","섹히","섹마","섹무비",},
["세"] = {"세끼","세엑스","세뀌","세꺄","세액스","세뤼","세디스트","세퀴",},
["옘"] = {"옘병","옘뱅",},
["뜅"] = {"뜅신",},
["쑤"] = {"쑤발","쑤셔불라","쑤팔","쑤벌",},
["뜽"] = {"뜽신","뜽쉰",},
["1"] = {"10팍","10알년","10알냔","10팔","10팔색","18색히","10섹","18색이","10알뇬","18놈","10팔쉑","18넘","15분","15분환불","18늠","18뇬","10알놈","10쉑","18눔","10알늠","1:1상담","10알넘","18세끼","120일","18냔","18새끼","10팔섹","18년","10알눔",},
["오"] = {"오르가즘","오유충","오랄","오르갓음","오르가슴","오르갖음","오럴",},
["허"] = {"허접","허졉","허위","허벌","허벌창",},
["A"] = {"ASKY",},
["슨"] = {"슨상님",},
["펔"] = {"펔규","펔큐",},
["스"] = {"스버럴","스발","스와핑","스피드환불","스시국","스펄","스왑","스팔","스벌",},
["펀"] = {"펀색","펀섹",},
["a"] = {"ac발",},
["슆"] = {"슆파",},
["덩"] = {"덩신","덩쉰",},
["데"] = {"데가뤼","데갈텅","데졌어","데져","데질레","데저라","데가리","데졋어","데갈통","데질라고","데져라","데질래",},
["클"] = {"클리톨리스","클로톨리스","클리토리스","클로토리스",},
["덜"] = {"덜은새끼",},
["뻑"] = {"뻑유","뻑큐",},
["뻐"] = {"뻐큐","뻐르노","뻐킹",},
["벙"] = {"벙개색스","벙딱","벙개색쓰","벙개섹스","벙쎅","벙게색스","벙게색쓰","벙게쎅쓰","벙섹","벙게쌕스","벙쌕","벙개쎅스","벙신","벙게쌕쓰","벙게섹쓰","벙개섹쓰","벙색","벙개쌕스","벙게섹스","벙개쌕쓰","벙게쎅스","벙알","벙개쎅쓰",},
["번"] = {"번쌕","번개쌕스","번개섹스","번개쎅스","번개쌕쓰","번개색쓰","번개쎅쓰","번개색스","번섹","번색","번개섹쓰","번쎅",},
["벌"] = {"벌창","벌려",},
["버"] = {"버지구멍","버지","버지구녕","버지물마셔","버짓물","버지쑤셔","버지빨아","버쥣물","버지따먹기","버즤물","버지벌려","버지구뇽","버지벌료","버지썰어","버쥐물","버지냄새","버지뚫어","버즷물","버즤","버쥐","버지핧아","버지물","버엉신","버지털","버지뜨더",},
["벅"] = {"벅큐","벅규",},
["올"] = {"올가즘",},
["벼"] = {"벼엉신",},
["네"] = {"네삿깟시",},
["벵"] = {"벵신",},
["넹"] = {"넹기미",},
["넴"] = {"넴병",},
["지"] = {"지미랄","지랄삽차기","지랄하는","지랄","지랄한다","지럴발광","지랄발광","지랄육갑","지랄하네","지뢀","지랄쌈치","지랄하고","지미룰","지뤌","지미롤","지미럴","지롤","지룰","지미뢀","지롤발광","지럴",},
["페"] = {"페니스",},
["싶"] = {"싶발","싶쁠","싶불","싶박","싶까","싶블","싶새","싶활","싶벌","싶뻘","싶쥘","싶쉐","싶8","싶뽈","싶질","싶할","싶뿔","싶팍","싶빡","싶쌔","싶세","싶쎄","싶빨","싶펄","싶볼","싶창","싶팔","싶헐",},
["레"] = {"레이디가카","레즈비언",},
["미"] = {"미찬놈","미친썅늠","미친색이","미췬년","미친싸앙놈","미췬넘","미친쉑히","미친색기","미친쓉쒜리","미췬놈","미륀놈","미친늠","미친쌍","미친년들아","미친개색기","미틴년","미친눔","미친쌍농","미친씹쎄끼","미국","미친쉑","미씨촌","미친씹쎄","미친놈아","미친놈","미칀년","미친농","미친넘","미친개늠","미친씹빠빠","미친뇽","미시촌","미친개섹히","미친씹쌔끼","미친색히","미친쉐끼","미친싸앙년","미칀냔","미친뇬","미친쌍뇽","미췬냔","미췬늠","미칀늠","미친","미틴넘","미췬","미친년","미칀뇬","미친씹쌔","미췬개쉑","미칀넘","미췬눔","미친새뀌","미친섹기","미칀눔","미췬뇬","미친쌍녕","미친냔","미친년아","미칀놈",},
["뒹"] = {"뒹쉰","뒹신",},
["음"] = {"음부","음낭","음경",},
["G"] = {"GM",},
["얨"] = {"얨병",},
["뒤"] = {"뒤질레","뒤져","뒤진다","뒤죠","뒤질라고","뒤질래","뒤저라","뒤져라","뒤졋어",},
["양"] = {"양년",},
["g"] = {"gangbang","g뢀","google환불","g랄","g미랄","g미룰","g롤","g미롤","g미뢀","g룰","g미럴","g럴",},
["뒈"] = {"뒈질","뒈질레","뒈질라고","뒈져","뒈질래","뒈지고","뒈진다","뒈졋어","뒈져라",},
["w"] = {"warez","whore",},
["이"] = {"이기","이뇬","이쇅꺄","이세꺄","이쉑꺄","이쉐꺄","이새꺄",},
["카"] = {"카쎅","카쎅쓰","카쌕스","카섹쓰","카쌕쓰","카색","카색스","카색쓰","카쌕","카쎅스","카섹","카섹스",},
["싯"] = {"싯뽈","싯볼","싯뻘","싯블","싯빨","싯벌","싯불","싯발",},
["심"] = {"심년아",},
["십"] = {"십빨","십빡","십쒜","십새","십8색","십때끼","십헐","십쎄키","십박","십쌕히","십쉐꺄","십발","십쌔","십알놈","십쎄꺄","십쒜야","십쌕키","십펄","십쎅키","십쉐야","십8섹","십세","십쎅이","십쌕이","십탱구리","십알년","십쇡기","십쒝이","십8쉑","십알냔","십알늠","십뿔","십쁠","십쉐","십셰리","십쎅이야","십쌔꺄","십쎄리","십활","십색야","십쒜끼","십부럴","십쒝햐","십섹햐","십알눔","십쉑히","십색이","십섹히","십창","십쉑햐","십새키","십새꺄","십쒝히","십쌔끼","십탱아","십쌕이야","십쌔리","십쉑야","십쉑이","십세리","십지랄","십뽈","십탱","십8","십세키","십세야","십쌔야","십새리","십자슥","십색키","십새야","십쒜리","십쌔키","십질","십쎄야","십다발이","십팅구리","십쒜꺄","십물","십쎄끼","십쉐리","십쌕햐","십녀","십버지","십년","십할","십색히","십텡","십섹이","십좌지","십새끼","십볼","십색햐","십뻘","십섹야","십텡구리","십알","십알넘","십창녀","십세이","십벌","십쒜키","십쒝키","십쎄","십섹키","십까","십쉑키","십쉐키","십팍","십파","십세끼","십쥘","십팔","십쉐끼","십떼끼","십쎅햐","십알뇬","십쎅히",},
["먹"] = {"먹먹문",},
["신"] = {"신뢰","신속",},
["떨"] = {"떨마니","떨마뉘",},
["싸"] = {"싸까치","싸댕","싸까쉬","싸깟이","싸까시","싸이코","싸까싀","싸가쥐","싸카시","싸가지","싸뎅",},
["싹"] = {"싹바가지","싹수","싹박아지",},
["뿡"] = {"뿡얼","뿡알",},
["쒜"] = {"쒜끼","쒜리","쒜뤼",},
["싰"] = {"싰발","싰빨","싰볼","싰뻘","싰뽈","싰블","싰벌",},
["퍽"] = {"퍽큐",},
["떡"] = {"떡치기","떡촌",},
["친"] = {"친절상담",},
["뿔"] = {"뿔알",},
["싀"] = {"싀버럴","싀밸","싀팔","싀발","싀방세","싀벌","싀벨","싀방새","싀벙세","싀펄","싀팍","싀바랄","싀8","싀벙새","싀봉",},
["시"] = {"시펄늠","시팡","시발냔","시팰","시블냔","시불냔","시밸놈","시댕이","시뎅아","시파","시팍","시팔","시브뢀","시팟","시발늠","시방새","시불","시팔눔","시벨년","시퍌","시블늠","시브럴","시블년","시팔넘","시밸넘","시부랄","시볼","시팔년아","시불년","시벨넘","시봘","시펄눔","시발놈아","시브룰","시벨냔","시밸뇬","시블눔","시팔냔","시팔늠","시봉","시벨새키","시펄냔","시불넘","시발넘","시발눔","시불눔","시끼","시뱅","시뺠","시불뇬","시팔놈","시밸늠","시뱔","시발뇬","시바랄","시벨놈","시펄뇬","시블놈","시부리","시벌","시발놈","시펄놈","시밸년","시뗑이","시팔년","시브롤","시벨","시펄년아","시방쎄","시뻘","시부럴","시블앙","시불놈","시펄놈아","시벵","시브랄","시펄년","시키","시발년","시벨눔","시뿔","시팍새끼","시팔놈아","시블","시부렁","시펄","시밸눔","시불늠","시발시끼","시벨뇬","시방세","시밸냔","시블넘","시발","시블뇬","시펄넘","시발년아","시바","시박","시빨","시방","시퐐","시8","시팔뇬","시밸","시버럴","시방쌔",},
["2"] = {"2c팔","24시간",},
["뿌"] = {"뿌랄","뿌럴",},
["쒸"] = {"쒸뎅","쒸이발","쒸이팔","쒸불","쒸앙","쒸발","쒸방쌔","쒸양","쒸방세","쒸이불","쒸붕","쒸팔","쒸이펄","쒸방쎄","쒸방새","쒸댕","쒸벌","쒸펄","쒸이벌",},
["쌕"] = {"쌕쓰","쌕스","쌕수","쌕히","쌕쑤","쌕폰",},
["쌔"] = {"쌔기","쌔뤼","쌔끈","쌔리","쌔깐","쌔꺄","쌔끼",},
["쌉"] = {"쌉쌕뀌",},
["쌈"] = {"쌈치기",},
["체"] = {"체위","체모",},
["쌍"] = {"쌍놈","쌍놈아","쌍넌","쌍늠","쌍년","쌍부랄","쌍눔","쌍냔","쌍넘","쌍부날","쌍뇬","쌍보지",},
["붱"] = {"붱신",},
["떵"] = {"떵신","떵쉰","떵구녁","떵구녕",},
["애"] = {"애널","애플60일","애무","애므","애플환불대행",},
["b"] = {"bo지물","bunse","bo지","bozy","bogy","bozi","bojy","binya","bitch","bunsek","bbagury","bo지털","bbagoori","boji",},
["눼"] = {"눼미",},
["부"] = {"부럴","부랄","부엉이 바위",},
["쌰"] = {"쌰앙","쌰뎅",},
["불"] = {"불알","불할",},
["쌩"] = {"쌩아다",},
["붕"] = {"붕신세끼","붕신새끼","붕알","붕신색히","붕신색이","붕삼","붕신색끼","붕신세이","붕신",},
["처"] = {"처죽일뇬","처죽일넘","처죽일년","처죽일눔","처죽일냔","처먹어","처죽일놈","처녀막","처죽일늠",},
["천"] = {"천조국",},
["젠"] = {"젠똥",},
["젼"] = {"젼나",},
["져"] = {"져또","져까","져빱","져떠",},
["갱"] = {"갱방",},
["갈"] = {"갈보",},
["호"] = {"호로개잡늠","호양년","호봉세씨","호로쉐키","호모쎄끼","호로씨발새끼","호모섹기","호어","호빠","호테스빠","호로개쉐리","호봉쎄끼","호로개잡놈","호로색끼","호로새리","호로쉐끼","호테스바","호로씨발늠","호스티스","호로시끼","호냥년","호봉쒜리","호로씨발놈","호스테스바","호로개자식","호구쉐끼","호스트빠","호로섹히","호로자식","호스트바","호로새끼",},
["절"] = {"절라",},
["가"] = {"가카",},
["뭬"] = {"뭬친놈",},
["간"] = {"간편하게","간철수","간편환불","간단환불",},
["적"] = {"적까",},
["저"] = {"저가티","저샤키","저빱","저까고","저깐","저가치","저까치","저까","저뇬","저떠","저냔","저년","저녀언","저까는",},
["개"] = {"개넘","개색히","개보즤","개쌍년","개세기","개가턴","개쒜리","개쉽세","개에뇬","개늠쉑","개애뇬","개보ji","개젖","개좌쉭","개썅년","개늠","개또라이","개색끼","개노무","개샠","개쉬리","개색이","개씹창","개씁년","개섹끼","개염창","개십새","개도라이","개넘쉬끼","개새","개같은늠","개잡년","개쇅","개쇄","개쌕","개좌지","개노므","개걸레","개쉐리","개놈","개자슥","개애년","개쇡","개쇠","개섹햐","개새꺄","개새야","개쒜","개씹세","개색","개새이","개씁블","개쇄끼","개쉬키","개씹새","개넘새뀌","개같은눔","개씨","개세끼","개쉽새","개좆","개좃","개후랄","개세이","개자지","개색햐","개자식","개보쥐","개십세","개세","개섹","개삽년","개후라","개시키","개지랄","개시발","개넘쉐뤼","개년","개찌질이","개자즤","개자z","개자g","개새기","개샛킹","개부랄","개같은뇬","개쉐이","개쎄","개느므","개섹이","개후레","개같은놈","개느무","개섹히","개너미","개자ji","개쌍놈","개지룰","개부럴","개붕알","개자쉭","개지롤","개뇽","개너므","개지럴","개씹쌔","개새리","개조또","개뇬","개보g","개새뀌","개너무","개에년","개불알","개같은냔","개보z","개같은","개섹기","개색기","개쒹기","개지뢀","개같은넘","개졋","개쓰래기","개걸래","개쌔","개젓","개쐭","개쉨","개쉽","개쌕끼","개씨발","개너므새뀌","개후장","개같은년","개잡지랄","개좌식","개눔","개씹쎄","개같은새뀌","개새끼","개보지","개쐑","개가튼","개시끼","개쉑","개쉐",},
["젗"] = {"젗도","젗꺽지","젗빱","젗텡","젗더","젗물","젗꺽쥐","젗꼭쥐","젗만아","젗까치","젗만안","젗탱","젗만이","젗만한","젗가치","젗만하","젗꼭지","젗같","젗만히","젗마니","젗밥","젗꼭즤","젗었어","젗가튼","젗마난","젗꺽즤","젗마나","젗만","젗까",},
["감"] = {"감자국",},
["정"] = {"정식사업자","정액",},
["젔"] = {"젔까고","젔같이","젔가치","젔가티","젔같은","젔까는","젔까치",},
["강"] = {"강간",},
["접"] = {"접으면손해",},
["점"] = {"점닭쳐","점물",},
["왕"] = {"왕털보지","왕털버지","왕털잠지","왕털자지",},
["깔"] = {"깔끔",},
["깝"] = {"깝친다","깝쳐","깝칠래","깝치네",},
["김"] = {"김치녀",},
["까"] = {"까보전",},
["※"] = {"※",},
["러"] = {"러브젤",},
["드"] = {"드러운새리",},
["깨"] = {"깨쌔끼",},
["엿"] = {"엿같은","엿가튼","엿먹어","엿같이",},
["염"] = {"염뵹","염병","염뱅",},
["연"] = {"연중무휴",},
["여"] = {"여시충","여자채위","여성채위","여성상위","여자체위","여성체위",},
["엠"] = {"엠병",},
["자"] = {"자쥐","자z","자짓털","자위기구","자즤","자털","자ji털","자궁","자쥐털","자위","자g","자ji","자지털","자지",},
["에"] = {"에플",},
["엑"] = {"엑윽엑엑",},
["잡"] = {"잡냔","잡년","잡눔","잡늠","잡것","잡놈","잡뇬","잡넘",},
["잠"] = {"잠g","잠짓","잠ji","잠지털","잠쥐","잠z","잠짓털","잠지","잠즤",},
["엄"] = {"엄창",},
["업"] = {"업계최초",},
["대"] = {"대준다","대l행","대갈텅","대주까","대질레","대가리","대.행","대갈빡","대질라고","대져라","대갈통","대가뤼","대졋어","대1행","대줄년","대굴빡","대졌어","대줄께","대질래","대저라","대행",},
["x"] = {"x위","x지","x섹스","x털",},
["수"] = {"수수료후불","수수료","수수료우대",},
["머"] = {"머중",},
["쫏"] = {"쫏만한것","쫏까",},
["쫍"] = {"쫍밥",},
["셋"] = {"셋뀌","셋기","셋귀",},
["뱅"] = {"뱅신","뱅신시키",},
["쬬"] = {"쬬빱",},
["쫒"] = {"쫒만한것","쫒깥내","쫒까",},
["C"] = {"C봘",},
["구"] = {"구우글","구글·애플","구글120일","구글환불",},
["국"] = {"국내최초",},
["후"] = {"후러덜넘","후좡","후불제","후릴년","후라덜넘","후레자식","후래자식","후장",},
["룸"] = {"룸쎅쓰","룸섹쓰","룸쌕스","룸섹스","룸색쓰","룸쌕쓰","룸쎅스","룸색스",},
["c"] = {"comsek","c블냔","c발냔","c펄","c불년","c팍","c블뇬","c팔","ce팍","ce발","comesek","ce빨","c블눔","ce벌","ce불","c부뢀","c불늠","c벌넘","c발년","ce팔","c불","c벌뇬","c블","carsek","c발섹","c부랄","c불눔","c블년","c박","ce부뢀","c발뇬","ce부룰","c발","c불넘","c불놈","ccibal","c불뇬","c벌놈","c발늠","c발눔","c발색","c발놈","c빨","c벌","c8","ce부랄","ce부롤","c벌눔","c부럴","c블늠","c풀","ce뻘","c블놈","c부룰","ccival","c벌냔","c블넘","c뻘","c불냔","ccipal","c부롤","c벌늠","c발쉑","ce부럴","c발넘","condom","cibal","ce펄","c벌년",},
["쥐"] = {"쥐룰","쥐럴","쥐랄","쥐뢀","쥐롤",},
["교"] = {"교제알선",},
["요"] = {"요년","요씨댕","요ㅕ시",},
["합"] = {"합법적",},
["우"] = {"우라질","우롸질",},
["운"] = {"운지","운영자",},
["용"] = {"용주골",},
["궤"] = {"궤자지",},
["씻"] = {"씻블","씻퐁","씻뽈","씻펑","씻벨","씻벌","씻뿔","씻발","씻뻘","씻탱구리","씻밸","씻불","씻팔","씻쁠","씻빨","씻펄","씻볼","씻팡",},
["씹"] = {"씹자지년","씹할","씹탱이","씹념이","씹질","씹뽈","씹보지","씹놈","씹보지년","씹샛길","씹볼뇬","씹을년","씹알","씹세","씹쥘","씹뻘","씹8","씹블","씹활","씹셋나루","씹올","씹탱굴이","씹발","씹뿔","씹불","씹쁠","씹때끼","씹창","씹펄","씹","씹물","씹선비","씹텡","씹즬","씹탱","씹빨","씹풀","씹팔","씹퍼년","씹새리야","씹새리","씹얼","씹딱꿍","씹갓길","씹년","씹닥","씹딱","씹새","씹세리","씹쉐이","씹세리야",},
["쓋"] = {"쓋파라",},
["쓉"] = {"쓉쎄끼",},
["씨"] = {"씨불알","씨벨년","씨블년","씨텡","씨펄놈","씨밸뇬","씨볼년아","씨뺄뇬","씨불년","씨발늠","씨8","씨볼뇬","씨가랭넘","씨발냔","씨바라","씨봘","씨부뢀","씨뺄뇬아","씨팡","씨볼놈","씨벨놈","씨방새","씨브룰","씨벌년","씨이펄","씨팍","씨파","씨뱅놈","씨펄년아","씨밸넘","씨불놈","씨탱구리","씨팔","씨댕","씨비룰","씨밸눔","씨발쉑","씨팔호로쌔끼","씨벨냔","씨블늠","씨봉쉐","씨뽀랄","씨비뢀","씨뺠","씨불냔","씨가랭놈","씨퐝","씨퐐","씨댕이","씨블뇬","씨퐈","씨볼","씨퐁","씨방세","씨블넘","씨이불","씨발람넘","씨박새끼","씨발쉐끼","씨발놈아","씨이팔","씨부롤","씨이붕","씨벌","씨벨넘","씨볼눔","씨펄","씨벵","씨븡새끼","씨밸놈","씨발노무시키","씨비럴","씨브뢀","씨불넘","씨부럴","씨벨","씨볼냔","씨끼","씨뱅","씨부리","씨브랄","씨뱔","씨블","씨밸냔","씨발색","씨불년아","씨이발","씨볼놈아","씨꽈랄","씨발년아","씨비랄","씨밸늠","씨발년","씨발뇬","씨뱅이","씨불늠","씨가랭년","씨뱅아","씨밟","씨발뇽","씨버럴","씨블놈","씨박","씨바","씨볼늠","씨부렁","씨방","씨불놈아","씨뻘","씨브럴","씨방쌔","씨팔허접","씨부랄","씨앙","씨밸","씨벨늠","씨발아","씨불뇬","씨블냔","씨발쉬끼","씨발눔","씨봉알","씨볼년","씨블눔","씨뽈","씨벨뇬","씨밸년","씨이벌","씨불눔","씨브롤","씨벨눔","씨섹","씨볼넘","씨발섹","씨붕","씨펄년","씨불","씨빠","씨빡","씨방쉐","씨발호로새끼","씨발","씨벵이","씨탱","씨뎅","씨빌","씨펄놈아","씨방쎄",},
["되"] = {"되질레","되질래",},
["씝"] = {"씝새","씝창","씝알놈",},
["n"] = {"nude","nigimi","nomo",},
["씁"] = {"씁새뀌","씁쌔","씁쒜","씁새","씁새끼",},
["쓰"] = {"쓰방","쓰뱅","쓰벌놈","쓰뷀","쓰벌놈아","쓰불년","쓰불넘","쓰블뇬","쓰블냔","쓰불놈","쓰파","쓰벌넘","쓰브랄","쓰벌냔","쓰버럴","쓰붕","쓰불","쓰팔","쓰봉","쓰벌섹","쓰블","쓰벌","쓰벌쉑","쓰븡","쓰벌년","쓰벌늠","쓰빨","쓰불냔","쓰바","쓰박","쓰불늠","쓰퐈","쓰벌년아","쓰발","쓰블늠","쓰벌뇬","쓰벨","쓰벌색","쓰블놈","쓰뻘","쓰불뇬","쓰벌눔","쓰블넘","쓰블년","쓰벵","쓰펄",},
["크"] = {"크리토리스",},
["씌"] = {"씌빨","씌벨","씌블","씌벌","씌방","씌퐝","씌팔","씌뻘","씌팡","씌불","씌벙","씌박","씌바","씌펄","씌밸","씌퐈","씌발","씌팍","씌파",},
["뵝"] = {"뵝신",},
["뵹"] = {"뵹신","뵹싄","뵹쉰","뵹딱",},
["s"] = {"si벌","ssibbal","sex","sival","si부럴","ssibal","si불","si발","sek","shit","si팔","si부룰","si펄","si부롤","ssiva","swaping","ssival","sucker","sibal","ssipal","si부뢀","suck","si부랄","si빨","si풀","sucka",},
["뵤"] = {"뵤지","뵤옹신",},
["ㅅ"] = {"ㅅㅌㅊ",},
["ㅎ"] = {"ㅎㅌㅊ",},
["ㅍ"] = {"ㅍㅌㅊ",},
["졸"] = {"졸라시뎅이야","졸라시벵",},
["매"] = {"매춘","매친뇬",},
["걸"] = {"걸래","걸레",},
["존"] = {"존니","존라","존마니","존만아","존마난","존만안","존만한","존마나","존먹어","존만이","존만","존만하","존나시펄년","존나리","존마","존내","존만히","존나","존네","존나게","존물",},
["졷"] = {"졷만","졷만아","졷마니","졷지롤","졷빱","졷만이","졷만하","졷지뢀","졷밥","졷만안","졷만한","졷지룰","졷만히","졷물","졷까","졷마난","졷지럴","졷마나","졷지랄",},
["조"] = {"조옷까","조옷","조밥","조까튼","조옺","조까","조빱","조깥은","조개따조","조까치","조빠","조또","조까지마","조오까","조개넓은년","조넨","조낸","조개마셔줘","조개벌려줘","조개쑤셔줘","조루","조개속물","조개핧아줘","조까라",},
["족"] = {"족갗","족같내","족까","족같네",},
["거"] = {"거지새끼","거지쉐뀌","거지쒜리","거지쎄끼",},
["졌"] = {"졌같은","졌같이","졌까치","졌가치","졌가티",},
["졎"] = {"졎꺽지","졎도","졎마나","졎꺽쥐","졎마난","졎빱","졎만한","졎지럴","졎만하","졎같","졎물","졎지룰","졎까","졎만히","졎꼭즤","졎가튼","졎지롤","졎꼭쥐","졎마니","졎탱","졎가치","졎가은","졎지뢀","졎밥","졎만이","졎꺽즤","졎이","졎꼭지","졎지랄","졎더","졎만아","졎만","졎만안","졎까치","졎텡",},
["졏"] = {"졏텡","졏도","졏가튼","졏까치","졏더","졏만","졏이","졏지뢀","졏꺽지","졏가치","졏꼭즤","졏만히","졏꺽쥐","졏만이","졏만하","졏만한","졏꼭지","졏밥","졏마난","졏같","졏마나","졏탱","졏꺽즤","졏물","졏꼭쥐","졏지룰","졏지럴","졏만안","졏만아","졏지랄","졏마니","졏가은","졏빱","졏지롤","졏까",},
["졋"] = {"졋지룰","졋마니","졋까","졋만이","졋꼭지","졋꼭쥐","졋만아","졋만안","졋까치","졋지롤","졋만","졋만한","졋마나","졋꺽지","졋만하","졋마난","졋가은","졋가튼","졋빱","졋지럴","졋텡","졋탱","졋같","졋꺽쥐","졋꺽즤","졋같은","졋밥","졋지랄","졋도","졋물","졋더","졋만히","졋이","졋꼭즤","졋지뢀","졋같이","졋가치","졋가티",},
["i"] = {"ios환불",},
["맛"] = {"맛없는년","맛업는년","맛이간년",},
["무"] = {"무료누드","무조건가능",},
["막"] = {"막간년",},
["걔"] = {"걔잡년","걔잡지랄",},
["문"] = {"문디","문섹",},
["겧"] = {"겧샣낗",},
["즤"] = {"즤랄떠냐",},
["전"] = {"전문","전땅크","전액환불","전액승인","전라디언","전화상담","전액",},
["게"] = {"게쌔","게쌕","게지롤","게세","게섹","게색끼","게세기","게십새","게보ji","게부럴","게좌쉭","게놈","게씨발","게쉬키","게보지","게새리","게쉽새","게시키","게씹쌔","게같은","게에년","게자쥐","게십세","게씹세","게자g","게자쉭","게지랄","게쒜","게세꺄","게보z","게좌식","게자z","게넘","게씹새","게임마스터","게쉽세","게임펍","게뇬","게쉐리","게색이","게샠","게보즤","게자지","게셐","게삽년","게색","게새","게지럴","게가턴","게새기","게좌지","게쐑","게섹놈아","게쐭","게시끼","게자식","게지룰","게늠","게쉑","게쉐","게좆","게좃","게쉽","게쉨","게년","게눔","게쎄","게보쥐","게새꺄","게쌔기","게지뢀","게섹이","게지랄놈","게씹쎄","게세끼","게에뇬","게시퀴","게자슥","게임환불","게쇡","게쇠","게보g","게새끼","게가튼","게세이","게쉐이","게쇅","게쇄","게색기","게자ji",},
["4"] = {"4까씨","4kkasi","4까시",},
["딸"] = {"딸치","딸딸이","딸따뤼","딸치는","딸따리",},
["D"] = {"DJ슨상",},
["포"] = {"포르노","포르너","포르느","포로노","포로너",},
["핸"] = {"핸타이",},
["딩"] = {"딩신","딩쉰",},
["젖"] = {"젖도","젖꼭지","젖텡","젖탱이","젖꼭즤","젖마난","젖만하","젖더","젖까","젖고픈","젖만히","젖탱","젖가치","젖만","젖마나","젖꺽즤","젖통","젖만아","젖까치","젖꼭쥐","젖만한","젖만안","젖꺽지","젖만이","젖같은","젖밥","젖같","젖가은","젖마니","젖가","젖물","젖었어","젖꺽쥐","젖가튼","젖빱",},
["d"] = {"dduk","dick","damn","dildo",},
["띱"] = {"띱새","띱때",},
["디"] = {"디질래","디질레","디져","디질","디저","디졋어","디저라","디진다","디질라고","디져라",},
["젓"] = {"젓빠라라","젓만아","젓꼭쥐","젓빱","젓가튼쉐이","젓까치","젓만안","젓마나","젓만하","젓꼭지","젓같네","젓도","젓가티","젓가치","젓마니","젓만한","젓까고","젓만히","젓꺽쥐","젓같은","젓까","젓같","젓꺽지","젓만이","젓까는","젓물냄새","젓꼭즤","젓가","젓떠","젓탱이","젓만","젓탱","젓물","젓밥","젓마무리","젓텡","젓대가리","젓가튼",},
["쐐"] = {"쐐끼",},
["쐉"] = {"쐉놈","쐉늠","쐉년","쐉눔","쐉냔","쐉넘","쐉뇬",},
["띠"] = {"띠방쎄","띠벌놈","띠발년","띠붕세","띠벵이","띠이불","띠이펄","띠불놈","띠방쌔","띠방","띠발냔","띠이풀","띠벌눔","띠병할","띠방세","띠벙","띠풀","띠비랄","띠이팔","띠벌냔","띠발","띠발뇬","띠이붕","띠벌년","띠불","띠부댕","띠봉알","띠발놈","띠발아","띠불넘","띠블","띠이발","띠이벌","띠불년","띠봉세","띠발늠","띠팔","띠벌","띠방쉐","띠발놈아","띠펄","띠발넘","띠방새","띠불늠","띠불냔","띠발자식","띠뱅이","띠벌뇬","띠껍냐","띠불뇬","띠벌넘","띠이방","띠발세끼","띠벙세","띠벵","띠발눔","띠부렐","띠부랄놈","띠불눔","띠뱅",},
["닝"] = {"닝기미","닝기리",},
["쳤"] = {"쳤같다",},
["빨"] = {"빨아져","빨자좃","빨아줘","빨통","빨께","빨아저",},
["빡"] = {"빡울","빡우리","빡우뤼","빡촌","빡우릐","빡큐",},
["빠"] = {"빠돌이","빠도리","빠구리","빠라조","빠구릐","빠큐","빠꾸릐","빠구뤼","빠꾸리","빠라줘","빠가","빠도뤼","빠굴이","빠꾸뤼","빠굴","빠도릐",},
["닌"] = {"닌기미",},
["썌"] = {"썌꺄",},
["니"] = {"니애미","니미씨펄넘","니미","니기미씹","니조개","니미쒸파","니애비","니미랄","니죶데","니조게","니미럴놈","니미럴","니주가리","니미럴시뀌","니미씹빠빠","니아범","니뮈럴","니미씹탱이","니미쒸발","니기미","니미씹탱","니기애미","니뮈쒸발","니죠때","니미럴너므시끼","니미씨","니미럴쉑","니부랄","니에비","니미씨뎅이","니할애비","니미럴새꺄","니미씨불넘","니기애비","니씨브랄","니에미","니미씨팔넘","니미좃구리","니미씨부럴","니뮈","니미씨벌년","니좆","니미씨불","니미좃",},
["빽"] = {"빽보ji","빽자지","빽보g","빽자ji","빽자g","빽자z","빽보z","빽보지",},
["닁"] = {"닁기미",},
["썅"] = {"썅년","썅냔","썅눔","썅팔년","썅넘쉬끼","썅늠","썅놈쉑","썅넘쉑","썅놈","썅늠쉑","썅뇬","썅넘","썅",},
["당"] = {"당일처리","당일환불",},
["비"] = {"비엉신","비용","비잉삼","비잉신",},
["써"] = {"써글놈","써글년","써글","써글뇬","써글눔","써글늠","써글넘","써글것",},
["썩"] = {"썩을넘","썩을것","썩을눔","썩을늠","썩을놈","썩을냔","썩을","썩을뇬","썩을년",},
["빙"] = {"빙싄","빙싄아","빙딱","빙신","빙쉰아","빙삼","빙쉰","빙신아","빙시","빙띤",},
["단"] = {"단풍국",},
["쳐"] = {"쳐죽인다","쳐죽일늠","쳐쑤셔박어","쳐죽일눔","쳐죽일것","쳐죽일년","쳐죽일뇬","쳐죽일냔","쳐죽을넘","쳐죽일놈",},
["다"] = {"다받아가세요",},
["밑"] = {"밑구녕빨기",},
["바"] = {"바주카자지",},
["받"] = {"받고접으세요","받았어요",},
["발"] = {"발기",},
["낙"] = {"낙태충",},
["손"] = {"손해",},
["촌"] = {"촌나시펄",},
["백"] = {"백자지","백보즤","백보z","백자쥐","백자z","백자ji","백자g","백보지","백보쥐","백보ji","백보g","백자즤",},
["남"] = {"남자대물","남성채위","남자물건","남자채위","남성상위","남성체위","남자체위",},
["o"] = {"oral",},
["한"] = {"한불",},
["방"] = {"방사능국",},
["내"] = {"내조지","내미랄","내버지","내꺼빨아","내꺼쑤셔","내꺼핧아",},
["식"] = {"식펄년이",},
["리"] = {"리미룰","리미랄","리미썅","리미뢀","리미럴","리미롤","리미",},
["좝"] = {"좝것",},
["좁"] = {"좁만히","좁마니","좁밥","좁물","좁마나","좁만이","좁만","좁만한","좁빠라라","좁빱","좁만하","좁만아",},
["좀"] = {"좀만이","좀물","좀마니","좀만하","좀쓰레기","좀만한","좀마나","좀마난","좀만아","좀만히",},
["좃"] = {"좃이나","좃가튼","좃만하","좃이","좃나씹냐","좃꺽지","좃지랄","좃만히","좃니재수야","좃나리","좃꼭즤","좃지뢀","좃지럴","좃","좃먹어","좃물","좃도","좃빠라","좃마나","좃꺽쥐","좃더","좃마난","좃까라","좃빱","좃가은","좃지롤","좃같","좃꼭쥐","좃마니","좃꼭지","좃지룰","좃나","좃만아","좃만","좃만한","좃까튼","좃밥","좃까치","좃만이","좃가치","좃꺽즤","좃만안","좃같네","좃까",},
["종"] = {"종범",},
["민"] = {"민주화",},
["좇"] = {"좇만하","좇만한","좇가튼","좇지뢀","좇빱","좇같","좇꺽즤","좇꼭쥐","좇꺽쥐","좇가치","좇꼭지","좇마니","좇밥","좇물","좇만히","좇","좇까","좇지랄","좇만아","좇만안","좇지럴","좇마난","좇마나","좇만이","좇까치","좇더","좇도","좇지롤","좇지룰","좇꺽지","좇만","좇가은","좇이","좇꼭즤",},
["좆"] = {"좆대가리","좆빨이","좆니","좆헛물","좆만안","좆만","좆까라","좆꺽즤","좆나리","좆이","좆마니","좆대에","좆꼭즤","좆만이","좆나게","좆꼴리","좆나","좆지럴","좆만한","좆지룰","좆만하","좆","좆만아","좆가튼","좆깢내","좆구녕","좆같이","좆까치","좆물","좆탱이","좆깥네","좆지롤","좆마나","좆빱","좆만히","좆쑤시","좆마난","좆까","좆밥","좆빠라","좆먹어","좆꼭쥐","좆가치","좆같","좆더","좆가은","좆꺽쥐","좆빠","좆꺽지","좆비비","좆지뢀","좆지랄","좆도","좆꼭지",},
["좉"] = {"좉도","좉꺽지","좉지뢀","좉빱","좉더","좉물","좉꺽쥐","좉꼭쥐","좉만아","좉까치","좉만안","좉이","좉만이","좉만한","좉가치","좉만하","좉꼭지","좉같","좉가은","좉지랄","좉만히","좉마니","좉지럴","좉밥","좉꼭즤","좉가튼","좉마난","좉꺽즤","좉마나","좉지룰","좉만","좉까","좉지롤",},
["좋"] = {"좋만한것",},
["좌"] = {"좌식","좌쉭","좌슥",},
["원"] = {"원조교재","원조 가카","원조교제",},
["귀"] = {"귀두",},
["그"] = {"그룹쎅","그냥접지마세요","그룹쌕스","그룹색쓰","그냥접으면","그룹쎅스","그지좃빱","그뇬","그년","그지새끼","그룹쌕","그지좃밥","그룹쌕쓰","그지좆밥","그룹섹스","그룹섹쓰","그룹색스","그룹섹","그룹색","그지새키","그룹쎅쓰",},
["근"] = {"근친상간",},
["j"] = {"jamji","ji미럴","jgirls","jaji","ji룰","jawi","jawe","jaji털","ja위","ji미롤","ji미뢀","ji랄","ji미룰","jot","jazy","ji럴","jazi","ja지","ji롤","jiral","jasal","ji미랄","ji뢀",},
["z"] = {"zazy","zazi털","zawi","zazi","za지","zawe","zasal","zamji","zot","zaji","za위",},
["프"] = {"프리섹스",},
["로"] = {"로린이","로류",},
["쉬"] = {"쉬벅","쉬벌","쉬발","쉬바","쉬박","쉬빨","쉬방","쉬벙","쉬풀","쉬댕","쉬뿔","쉬벨","쉬뻘","쉬뎅","쉬밸","쉬벵","쉬팡","쉬방쎄","쉬방세","쉬방쌔","쉬뱅","쉬8","쉬방새","쉬블","쉬팔","쉬봉","쉬파","쉬팍","쉬불","쉬펄",},
["쉭"] = {"쉭히","쉭키","쉭셰리",},
["폐"] = {"폐니스",},
["죵"] = {"죵나",},
["쉽"] = {"쉽탱구리","쉽텡구리","쉽발","쉽활","쉽박","쉽바","쉽할","쉽알","쉽세","쉽생구리","쉽벌","쉽뻘","쉽팍","쉽파","쉽헐","쉽펄","쉽창","쉽할이","쉽팔","쉽팅구리","쉽쎄","쉽새","쉽빨","쉽8",},
["쉿"] = {"쉿뻘","쉿발","쉿팍","쉿팔","쉿펄",},
["돈"] = {"돈년",},
["뽕"] = {"뽕알",},
["돌"] = {"돌대가리","돌은년","돌은놈","돌은넘","돌림빵","돌으년",},
["폰"] = {"폰색스","폰쌕스","폰섹스","폰쌕쓰","폰쌕","폰쎅스","폰색쓰","폰색","폰섹쓰","폰쎅","폰섹","폰쎅쓰",},
["도"] = {"도요타 다이쥬",},
["동"] = {"동거클럽",},
["쉐"] = {"쉐뤼","쉐끼","쉐키","쉐리",},
["쉑"] = {"쉑스","쉑히","쉑끼","쉑기","쉑햐",},
["뽁"] = {"뽁큐",},
["뽀"] = {"뽀쥐","뽀짓털","뽀ji","뽀쥐물","뽀지물","뽀즤털","뽀쥣털","뽀즤물","뽀르너","뽀지","뽀쥣물","뽀쥐털","뽀즤","뽀큐","뽀즷물","뽀로노","뽀짓물","뽀르노","뽀z","뽀즷털","뽀지털","뽀g",},
["패"] = {"패니스",},
["찐"] = {"찐따",},
["찌"] = {"찌랄",},
["봉"] = {"봉알",},
["산"] = {"산업화",},
["창"] = {"창녀자지","창냔","창녀촌","창녀보지","창녀","창년","창뇬",},
["살"] = {"살인마",},
["삽"] = {"삽대가리",},
["삿"] = {"삿깟시","삿가시","삿까시",},
["찢"] = {"찢어죽일냔","찢어죽일놈","찢어죽일뇬","찢어죽일년","찢어죽일눔","찢어죽일늠","찢어죽일넘",},
["삭"] = {"삭바가지","삭박아지",},
["사"] = {"사카시","사까시","사용했어도","사까쉬","사이코","사까치","사창가",},
}
              
function black_unit: get(key)
    if _unit_data[key] then
        return _unit_data[key]
    end
        return {}
end
              
return black_unit
