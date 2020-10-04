--horse

local horse = {
    -- key
    __key_map = {
      id = 1,    --编号-int 
      show_day = 2,    --图鉴显示天数-int 
      hero = 3,    --适用武将_math-string 
      name = 4,    --装备名称-string 
      description = 5,    --装备描述-string 
      type = 6,    --泛用性-string 
    
    },
    -- data
    _data = {
        [1] = {1,0,"999","Belang","Belang, kuda berwarna putih pucat berpola, tidak ada yang takutnya di medan perang, maju cepat seperti roket.","Semua",},
        [2] = {2,0,"999","Lu Er","Lu Er, kuda berwarna biru kuning, salah satu dari 8 kuda kaisar Mu, sehari menempuh jarak ribuan mil, tidak tahu lelah.","Semua",},
        [3] = {3,0,"999","Qu Huang","Qu Huang, seperti namanya seluruh tubuhnya berwarna kuning, Salah satu dari 8 kuda Kaisar Mu, sepuluh bayangan, kecepatannya sangat cepat.","Semua",},
        [4] = {4,0,"999","Jujube","Jujube Merah, Seluruh tubuhnya berwarna coklat, otot bagai baja, tenaganya kuat, memiliki berat ratusan gram, tapi masih bisa melangkah bagai terbang.","Semua",},
        [5] = {5,0,"999","Salju Putih","Salju Putih, tubuhnya berwarna putih, menginjak salju seperti dipermukaan datar, kuda sebagai penguasa.","Semua",},
        [6] = {6,0,"999","Madu Autumn","Madu Autumn, seperti walet ungu, fisiknya kuat, nafasnya hebat, mengagumkan.","Semua",},
        [7] = {7,0,"999","Giok Merah","Giok Merah, bertubuh bagai giok merah, Membawa keberuntungan, tunggangan kaisar.","Semua",},
        [8] = {8,0,"999","Kuda Biru","Kuda Bicong, bertubuh biru, bentuk tubuhnya kekar, saat berlari bagai naga terbang ke langit, sangat cepat dan kelihatan indah.","Semua",},
        [9] = {9,40,"103|110|112|117|118|204|211|304|315|404|412|417","Embun","Embun terbang, tubuh putih seperti embun beku, misterius, tidak lelah berjalan jauh, semua tempat yang dilewati meninggalkan jejak embun, hawanya sangat dingin, membuat orang tidak bisa mendekati.","Support",},
        [10] = {10,40,"1|2|3|4|5|11|12|13|14|15|101|107|108|109|111|113|114|201|205|206|208|209|213|217|218|301|306|308|310|316|318|3|403|406|407|410|413|414|416","Awan Hitam","Awan hitam, secara keseluruhan seperti satin hitam, mengkilap, hanya empat tapal kuda seputih salju, punggung panjang dan pinggang pendek membuatnya lurus, anggota badan dan sendi berkembang dengan baik, seluruh tubuh ditutupi baju zirah.","DPS",},
        [11] = {11,40,"102|202|302|402|216","Naga Api","Naga Api, seluruh tubuh berwarna merah seperti bara panas, tanpa ada sedikitpun bulu, menjerit dan meraung, terbang kelangit dan masuk ke laut, kumisnya bergulung seperti ombak, sangat elastis seperi wanita muda, kecepatan bagai terbang, melewati gunung seperti melewati permukaan datar.","Heal",},
        [12] = {12,40,"103|106|110|112|115|116|117|118|203|204|210|211|212|214|219|304|307|312|315|317|401|404|408|409|411|412|415|419|417","Singa Giok","Singa Giok, berwarna putih salju, berbulu emas dileher dan diekor, berkaki besar, ganas, brutal, bisa berjalan ribuan Li, bisa melangkahi tempat berbahaya, masuk dan keluar medan perang seperti tidak ada orang.","Support & Kontrol",},
        [13] = {15,999,"105|119|207|215|309|314|405|418","Petir Hitam","Menempuh jarak ribuan mil dalam waktu singkat, di kepalanya membawa petir, saat berlari kakinya bersuara bagaikan suara peluit, mengerti keinginan orang, daya tahannya hebat, bisa membantu pahlawan mendapatkan prestasi.","Tank",},
        [14] = {13,9999,"999","God-Kilat","God-Kilat, bertubuh putih, keempat kaki kuning, sangat anggun, berwibawa tiada tara, sangat unik, Tunggangan para pahlawan dan kaisar.","Semua",},
        [15] = {14,9999,"999","God-Dilu Bulan","God-Dilu Bulan, ganas dan cepat, kecepatannya seperti matahari dan bulan, dapat menembus air, sekali melangkah sangat jauh, melompati gunung melangkahi sungai sangatlah mudah.","Semua",},
    }
}

return horse