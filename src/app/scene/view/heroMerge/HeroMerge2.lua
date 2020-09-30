local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local ViewBase = require("app.ui.ViewBase")
local HeroMerge = class("HeroMerge", ViewBase)

-- function HeroMerge.create(heroId, count)
-- 	local HeroMerge = HeroMerge.new(heroId, count)
--     HeroMerge:open()
-- end

local Hero = require("app.config.hero")
local EffectGfxNode = require("app.effect.EffectGfxNode")
local CSHelper  = require("yoka.utils.CSHelper")

function HeroMerge:ctor(heroId, count)
    self._count = count or 1        --数量
    self._heroData = Hero.get(heroId)       --英雄表格数据
    self._rewards = { {type = TypeConvertHelper.TYPE_HERO ,value =  heroId,size = count }}
    assert(self._heroData, "wrong hero id = "..heroId)


    HeroMerge.super.ctor(self,nil,nil)
end

function HeroMerge:onCreate()
    cc.bind(self,"CommonSceneEffect")
    self:setScene(G_SceneIdConst.SCENE_ID_DRAW_CARD,G_SceneIdConst.SCENE_ID_DRAW_CARD_NIGHT)
end

function HeroMerge:onEnter()
    self:_playHeroOpen()
end

function HeroMerge:onExit()
end

function HeroMerge:_playJieSuan()
    local popupResultView = require("app.scene.view.drawCard.PopupResultView").new(self._rewards,function() 
        G_SceneManager:popScene()
    end)
    popupResultView:setContinueVisible(false)
    popupResultView:setGetDetail(true,
        Lang.get("recruit_get_detail", {name = self._heroData.name, count = self._count})
    )
    popupResultView:open()
end

function HeroMerge:_playHeroOpen()
    if self._heroData.color >= 5 then
        local HeroShow = require("app.scene.view.heroShow.HeroShow")
        local pop = HeroShow.create(self._heroData.id,handler(self,self._playJieSuan))
        pop:setSkipCallback(handler(self,self._playJieSuan))
        pop:setSkipVisible(false)
    else
        self:_playJieSuan()
    end
end


return HeroMerge