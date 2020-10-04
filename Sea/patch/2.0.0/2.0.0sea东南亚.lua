xpcall(function ()
    local HeroUnitData = require("app.data.HeroUnitData")
    HeroUnitData.isDidUpgrade = function(self)
        if self:isPureGoldHero() then
            return false
        end
        return self:getLevel() > 1
    end
    local TreasureUnitData = require("app.data.TreasureUnitData")
    TreasureUnitData.isDidStrengthen = function(self)
        return self:getLevel() > 1
    end
end,function( ... )
end)

xpcall(function (  )
    local avatar_show = require("app.config.avatar_show")
    for i = 109, 116 do
        avatar_show.set(i,"batch",4)
    end
    for i = 117, 120 do
        avatar_show.set(i,"batch",3)
    end
end,function( ... )
end)

xpcall(function ()
    local language = require("app.i18n.th.LangTemplate")
    language[ "mine_not_50_army" ] = "[{\"type\":\"text\",\"msg\":\"นายท่าน พลังทหารถึง 50 จึงจะสามารถย้ายออกจากเมืองหลักได้ ใช้\",\"color\":\"0x70380d\",\"fontSize\":22},{\"type\":\"text\",\"msg\":\"#count1#\",\"color\":\"0x499f1a\",\"fontSize\":22},{\"type\":\"text\",\"msg\":\"เสบียงและ\",\"color\":\"0x70380d\",\"fontSize\":22},{\"type\":\"text\",\"msg\":\"#count2#\",\"color\":\"0x499f1a\",\"fontSize\":22},{\"type\":\"text\",\"msg\":\"ตำลึงทำให้พลังทหารเสริมถึง 100  มั้ย?\",\"color\":\"0x70380d\",\"fontSize\":22}]"
    local ChatData = require("app.data.ChatData")
    ChatData.getTranslateI18n = function(self,src,tranLang)
        if not self._tranCacheI18n then
            return nil
        end
        local md5 = require("md5")
        local key = md5.sum(src)
        if not self._tranCacheI18n[key] then
            return nil
        end
        if tranLang == Lang.ENID then
            tranLang = Lang.OS_LANGUAGE_IOS_ENID
        end
        return self._tranCacheI18n[key][tranLang]
    end
end,function( ... )
end)

xpcall(function ()
    local lang = require("app.i18n.enid.LangTemplate")
    lang["customactivity_equip_hit_num_tip"] = "[{\"type\":\"text\",\"msg\":\"Setiap top-up\",\"color\":\"0xfff7e8\",\"fontSize\":20},{\"type\":\"text\",\"msg\":\" #money#0 Ingot \",\"color\":\"0xa8ff00\",\"fontSize\":20},{\"type\":\"text\",\"msg\":\"mendapatkan #count#\",\"color\":\"0xfff7e8\",\"fontSize\":20},{\"type\":\"image\",\"filePath\":\"#urlIcon#\",\"color\":16777215}]"
    lang["customactivity_pet_num_tip"] = "[{\"type\":\"text\",\"msg\":\"Setiap top-up\",\"color\":\"0xfff7e8\",\"fontSize\":20},{\"type\":\"text\",\"msg\":\" #money#0 Ingot \",\"color\":\"0xa8ff00\",\"fontSize\":20},{\"type\":\"text\",\"msg\":\"mendapatkan #count#\",\"color\":\"0xfff7e8\",\"fontSize\":20},{\"type\":\"image\",\"filePath\":\"#urlIcon#\",\"color\":16777215}]"
    lang["customactivity_horse_judge_tip"] ="[{\"type\":\"text\",\"msg\":\"Selama event, setiap Top-up \",\"color\":\"0xfff7e8\",\"fontSize\":20,\"fontName\":\"#fontName#\"},{\"type\":\"text\",\"msg\":\"200\",\"color\":\"0xffc103\",\"fontSize\":20,\"fontName\":\"#fontName#\"},{\"type\":\"text\",\"msg\":\"Ingot, bisa mendapatkan \",\"color\":\"0xfff7e8\",\"fontSize\":20,\"fontName\":\"#fontName#\"},{\"type\":\"text\",\"msg\":\"#name#x1\",\"color\":\"0xfff7e8\",\"fontSize\":20,\"fontName\":\"#fontName#\"}]"
end,function( ... )
end)

xpcall(function ()
    local CustomActivityAvatarHelper = require("app.scene.view.customactivity.avatar.CustomActivityAvatarHelper")
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local CustomActivityAvatarAdView = require("app.scene.view.customactivity.avatar.CustomActivityAvatarAdView")
    CustomActivityAvatarAdView.onCreate = function(self)
        if Lang.checkLang(Lang.ENID) then
            local UIHelper  = require("yoka.utils.UIHelper")
            local text1 = UIHelper.seekNodeByName(self,"Text_1")
            text1:setString("Selama event, klaim Bagua Xuantian x1 setiap top-up 100 Ingot.")
        end
        self:_swapImageByI18n()
    
        self._buttonGoto:setString(Lang.get("common_btn_goto_activity"))
        local cosRes = CustomActivityAvatarHelper.getCosRes()
        local itemParams = TypeConvertHelper.convert(cosRes.type, cosRes.value, cosRes.size)
        if itemParams.res_mini then
            self._imageCostIcon:loadTexture(itemParams.res_mini)
        end
        self:enterModule()
    end
end,function( ... )
end)

xpcall(function ()
    local lang = require("app.i18n.enid.LangTemplate")
    lang["cake_activity_award_preview_tab_2"] = "Hadiah\x01Legiun Antar\x01Server"
end,function( ... )
end)