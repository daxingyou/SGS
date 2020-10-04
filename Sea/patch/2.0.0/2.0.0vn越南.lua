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

local NativeAgent = require("app.agent.NativeAgent")
NativeAgent.eventCustom = function(self, k, v)
end



xpcall(function (  )

    local hero_rank = require("app.config.hero_rank")
    hero_rank.setLang = function(id,rank,limit, key, value)
        local record = hero_rank.get(id,rank,limit)
        if record then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
            end
        end
    end

    hero_rank.setLang(309,5,0,"talent_description", "Khi bị kẻ địch ở trạng thái Thiêu Đốt Công, ST phải chịu giảm 40%" )
  


end,function( ... )
end)

 

xpcall(function (  )
    local shop_crystal = require("app.i18n.vn.config.shop_crystal")
    shop_crystal._data[11][5] = 1
    local data = G_UserData:getCrystalShop()
    data._datas = data:_initData()
end,function( ... )
end)

xpcall(function (  )
    local Unit = require("app.fight.Unit")
    Unit.buffPlay = function(self, buffId, damage, isAngerBuff, dieIndex, sound)
        if not self.is_alive then
            return
        end
        local Engine = require("app.fight.Engine")
        if damage and damage.showValue and damage.value then
            local type = "buff_damage"
            if isAngerBuff then
                type = "anger_buff"
            end
            local damageType = 0
            if damage.type == 1 then
                damageType = -1
            elseif damage.type == 2 then
                damageType = 1
            end
            local value = damageType * damage.value
            local showValue = damageType * damage.showValue
            self._hitTipView:popup(showValue, buffId, type, cc.p(self._positionFrame[1], self._positionFrame[2]))
            if type == "buff_damage" then
                self:updateHP(value)
                self:updateHpShadow(true)
            end
            local attackIndex = Engine.getEngine():getAttackIndex()
            if not self.to_alive and dieIndex and dieIndex <= attackIndex then
                self:setDieState()
                self.is_alive = false
            end
        else
            if self._hitTipView then
                self._hitTipView:popup(nil, buffId, "buff", cc.p(self._positionFrame[1], self._positionFrame[2]))
            end
        end
        if sound then
            local speed = Engine.getEngine():getBattleSpeed()
            G_AudioManager:playSound(Path.getFightSound(sound), speed)
        end
    end
    local StateHit = require("app.fight.states.StateHit")
    StateHit.onFinish = function(self)
        self._entity:updateHpShadow(true)
        self._entity:checkSpcialBuff()
        StateHit.super.onFinish(self)
        if not self._entity.is_alive then
            local BuffManager = require("app.fight.BuffManager")
            BuffManager.getBuffManager():checkPoint(BuffManager.BUFF_DIE, self._entity.stageID)
            self._entity:dispatchDie()
        end
        if self._testData then
            local FightHelper = require("app.scene.view.fight.FightHelper")
            FightHelper.pushDamageData(self._testData)
        end
    end
end,function( ... )
end)

xpcall(function (  )
    local function_level = require("app.config.function_level")
    function_level.setLang = function(id, key, value)
        local record = function_level.get(id)
        if record then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
            end
        end
    end
    function_level.setLang(723,"day",60)
    function_level.setLang(724,"day",60)
    function_level.setLang(725,"day",60)
    function_level.setLang(726,"day",60)
    function_level.setLang(727,"day",60)
    function_level.setLang(728,"day",60)
end,function( ... )
end)

local AchievementView = require("app.scene.view.achievement.AchievementView")
AchievementView.FIRST_MEET_OPEN_DAYS = 60 --开服后60天显示初见标签页