local language = require("app.i18n.tw.LangTemplate")
language["sdk_platform_mantain"]            = "伺服器正在進行維護更新，維護時間請參見官方粉絲頁"
language["login_update_hint"]				= "親愛的主公，全新版本已準備就緒，本次更新约%.2fMB，建議您在WIFI環境下更新。如更新遇到問題，請聯繫客服。"

local Unit = require("app.fight.Unit")
--附加伤害展示
Unit.getAddHurt = function (self,value, hitInfo)
	self:updateHP(value)
	self:tipHit(value, hitInfo)
end

xpcall(function ()
    local festival_res = require("app.i18n.tw.config.festival_res")
    festival_res._data[12] = {12,"歡慶佳節",}
    festival_res._data[17] = {17,"合服慶典",}
end,function( ... )
end)