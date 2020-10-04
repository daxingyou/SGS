local language = require("app.i18n.tw.LangTemplate")
language["sdk_platform_mantain"] 			= "伺服器將於10月15日早上10:00開啟,敬請期待!"
language["login_update_hint"]				= "親愛的主公，全新版本已準備就緒，本次更新约%.2fMB，建議您在WIFI環境下更新。如更新遇到問題，請聯繫客服。"
language["sdk_platform_mantain"]            = "伺服器正在進行維護更新，維護時間請參見官方粉絲頁"

xpcall(function (  )

    local festival_res = require("app.config.festival_res")
    festival_res.setLang = function(id, key, value)
        local record = festival_res.get(id)
        if record then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
            end
        end
    end

    festival_res.setLang(12,"res_name", "歡慶佳節" )

end,function( ... )
end)

[{"name":"submit","status":2,"server":"4","opentime":"1521597600"},
{"name":"time","status":2,"server":"997","opentime":"1521597600"}]


local Unit = require("app.fight.Unit")
--附加伤害展示
Unit.getAddHurt = function (self,value, hitInfo)
	self:updateHP(value)
	self:tipHit(value, hitInfo)
end