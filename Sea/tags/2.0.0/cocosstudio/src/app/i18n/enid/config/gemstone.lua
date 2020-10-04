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
        [1] = {101,"Permata ATK Hijau","Permata yang menyilaukan, berwarna hijau, dingin saat dipegang.","Permata hijau yang menyilaukan, berwarna hijau, dingin saat dipegang.",},
        [2] = {102,"Permata DEF Hijau","Permata yang menyilaukan, berwarna hijau, dingin saat dipegang.","Permata hijau yang menyilaukan, berwarna hijau, dingin saat dipegang.",},
        [3] = {103,"Permata HP Hijau","Permata yang menyilaukan, berwarna hijau, dingin saat dipegang.","Permata hijau yang menyilaukan, berwarna hijau, dingin saat dipegang.",},
        [4] = {104,"Gul. Awaken Hijau","Gulungan origin yang mengandung permata hijau, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata hijau, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [5] = {201,"Permata ATK Biru","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.",},
        [6] = {202,"Permata DEF Biru","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.",},
        [7] = {203,"Permata HP Biru","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.",},
        [8] = {204,"Gul. Awaken Biru","Gulungan origin yang mengandung permata biru, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata biru, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [9] = {301,"Permata ATK Laut","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.",},
        [10] = {302,"Permata DEF Laut","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.",},
        [11] = {303,"Permata HP Laut","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.","Permata yang menyilaukan, berwarna biru langit, dingin saat dipegang.",},
        [12] = {304,"Gul. Awaken Laut","Gulungan origin yang mengandung permata biru, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata biru, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [13] = {401,"Permata ATK Ungu","Permata Ungu tingkat lanjut, dingin saat dipegang.","Permata Ungu tingkat lanjut, dingin saat dipegang.",},
        [14] = {402,"Permata DEF Ungu","Permata Ungu tingkat lanjut, dingin saat dipegang.","Permata Ungu tingkat lanjut, dingin saat dipegang.",},
        [15] = {403,"Permata HP Ungu","Permata Ungu tingkat lanjut, dingin saat dipegang.","Permata Ungu tingkat lanjut, dingin saat dipegang.",},
        [16] = {404,"Gul. Awaken Ungu","Gulungan origin yang mengandung permata ungu, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata ungu, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [17] = {501,"Permata ATK Vio","Permata Ungu tingkat lanjut, dingin saat dipegang.","Permata Ungu tingkat lanjut, dingin saat dipegang.",},
        [18] = {502,"Permata DEF Vio","Permata Ungu tingkat lanjut, dingin saat dipegang.","Permata Ungu tingkat lanjut, dingin saat dipegang.",},
        [19] = {503,"Permata HP Vio","Permata Ungu tingkat lanjut, dingin saat dipegang.","Permata Ungu tingkat lanjut, dingin saat dipegang.",},
        [20] = {504,"Gul. Awaken Vio","Gulungan origin yang mengandung permata ungu, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata ungu, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [21] = {601,"Permata ATK Star","Permata Ungu tingkat lanjut, dingin saat dipegang.","Permata Ungu tingkat lanjut, dingin saat dipegang.",},
        [22] = {602,"Permata DEF Star","Permata Ungu tingkat lanjut, dingin saat dipegang.","Permata Ungu tingkat lanjut, dingin saat dipegang.",},
        [23] = {603,"Permata HP Star","Permata Ungu tingkat lanjut, dingin saat dipegang.","Permata Ungu tingkat lanjut, dingin saat dipegang.",},
        [24] = {604,"Gul. Awaken Star","Gulungan origin yang mengandung permata ungu, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata ungu, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [25] = {701,"Permata ATK Kristal","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [26] = {702,"Permata DEF Kristal","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [27] = {703,"Permata HP Kristal","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [28] = {704,"Gul. Awaken Kuning","Gulungan origin yang mengandung permata jingga, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata jingga, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [29] = {801,"Permata ATK Naga","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [30] = {802,"Permata DEF Naga","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [31] = {803,"Permata HP Naga","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [32] = {804,"Gul. Awaken Naga","Gulungan origin yang mengandung permata jingga, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata jingga, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [33] = {901,"Permata ATK Surya","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [34] = {902,"Permata DEF Surya","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [35] = {903,"Permata HP Surya","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [36] = {904,"Gul. Awaken Surya","Gulungan origin yang mengandung permata jingga, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata jingga, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [37] = {1001,"Permata ATK Kilau","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [38] = {1002,"Permata DEF Kilau","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [39] = {1003,"Permata HP Kilau","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya jingga, dingin saat dipegang.",},
        [40] = {1004,"Gul. Awaken Kilau","Gulungan origin yang mengandung permata jingga, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata jingga, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [41] = {1101,"Permata ATK Merah","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [42] = {1102,"Permata DEF Merah","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [43] = {1103,"Permata HP Merah","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [44] = {1104,"Gul. Awaken Merah","Gulungan origin yang mengandung permata merah, konon kekuatannya besar, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata merah, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [45] = {1201,"Permata ATK Api","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [46] = {1202,"Permata DEF Api","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [47] = {1203,"Permata HP Api","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [48] = {1204,"Gul. Awaken Api","Gulungan origin yang mengandung permata merah, konon kekuatannya besar, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata merah, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [49] = {1301,"Permata ATK Bulan","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [50] = {1302,"Permata DEF Bulan","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [51] = {1303,"Permata HP Bulan","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [52] = {1304,"Gul. Awaken Bulan","Gulungan origin yang mengandung permata merah, konon kekuatannya besar, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata merah, konon kekuatannya besar, berisi energi yang luar biasa.",},
        [53] = {1401,"Permata ATK Mewah","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [54] = {1402,"Permata DEF Mewah","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [55] = {1403,"Permata HP Mewah","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.","Permata kualitas top, memancarkan cahaya merah, dingin saat dipegang.",},
        [56] = {1404,"Gul. Awaken Mewah","Gulungan origin yang mengandung permata merah, konon kekuatannya besar, berisi energi yang luar biasa.","Gulungan origin yang mengandung permata merah, konon kekuatannya besar, berisi energi yang luar biasa.",},
    }
}

return gemstone