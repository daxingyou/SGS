-- iphoneX公告清除缓存
local NativeAgent = require("app.agent.NativeAgent")
local name = NativeAgent.callStaticFunction("getDeviceModel", nil, "string")
if name == "iPhone10,3" or name == "iPhone10,6" then
    local PopupNotice = require("app.ui.PopupNotice")
    PopupNotice.onShowFinish = function(self)
        local discSize = self._webLayer:getContentSize()
        if ccexp.WebView then
            self._webView = ccexp.WebView:create()
            self._webView:setPosition(cc.p(discSize.width / 2, discSize.height / 2))
            self._webView:setContentSize(discSize.width, discSize.height)
            self._webView:loadURL(self._url, true)
            self._webView:setScalesPageToFit(false)
            self._webView:setBounces(false)

            self._webLayer:addChild(self._webView)
        end
    end
end


xpcall(function ()
    local language = require("app.i18n.vn.LangTemplate")
    language["HELP_GUILD_WAGE"] = {{["list"]={"Mỗi thành viên khi tham gia các hoạt động Quân Đoàn sẽ nhận được Năng Động Quân Đoàn.","Nếu có ít hơn 27 thành viên, đồng thời liên tục 3 ngày Năng Động Quân Đoàn bằng 0, Quân Đoàn sẽ tự động giải tán."},["title"]="Năng Động Quân Đoàn: "},{["list"]={"Quỹ Quân Đoàn sẽ được tích lũy theo mức năng động mỗi ngày.  ","Quỹ được tích lũy theo số ngày năng động của mỗi thành viên Quân Đoàn.","4:00 sáng T2 hàng tuần sẽ phát thưởng quỹ quân đoàn tuần trước."},["title"]="Quỹ Quân Đoàn: "}}
 end,function( ... )
 end)

xpcall(function ()
    local function_level_1 = require("app.i18n.vn.config.function_level_1")
    function_level_1._data[246] = {639,"Hè Mát\nMẻ","2","30,0","","",}
    local function_level = require("app.config.function_level")
    function_level.set(639,"icon","btn_main_enter_summer")
end,function( ... )
end)

xpcall(function ()
    local shop_active = require("app.config.shop_active")
    shop_active.set(5075,"value",573)
    shop_active.set(5075,"and_price1_value",576)
    shop_active.set(5075,"is_work",1)

    shop_active.set(5077,"value",574)
    shop_active.set(5077,"and_price1_value",577)
    shop_active.set(5077,"is_work",1)

    shop_active.set(5079,"value",575)
    shop_active.set(5079,"and_price1_value",578)
    shop_active.set(5079,"is_work",1)

    shop_active.set(5575,"value",573)
    shop_active.set(5575,"and_price1_value",576)
    shop_active.set(5575,"is_work",1)

    shop_active.set(5577,"value",574)
    shop_active.set(5577,"and_price1_value",577)
    shop_active.set(5577,"is_work",1)
        
    shop_active.set(5579,"value",575)
    shop_active.set(5579,"and_price1_value",578)
    shop_active.set(5579,"is_work",1)
        
    local shopActiveData = G_UserData:getShopActive()
	shopActiveData._goodIdsInShop = {} --某个商店对应的所有货物
	shopActiveData._shopList = {}
    shopActiveData:_formatGoods()
    print("ggg")

end,function( ... )
end)