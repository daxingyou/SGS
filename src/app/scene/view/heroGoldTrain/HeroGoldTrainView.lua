--
-- Author: Liangxu
-- Date: 2017-03-08 15:32:58
-- 武将培养界面
local ViewBase = require("app.ui.ViewBase")
local HeroGoldTrainView = class("HeroGoldTrainView", ViewBase)
local HeroGoldTrainLayer = require("app.scene.view.heroGoldTrain.HeroGoldTrainLayer")

local HERO_GOLD_LAYER = 1

function HeroGoldTrainView:ctor(heroId)
	G_UserData:getHero():setCurHeroId(heroId)
	self._subLayers = {}

	local resource = {
		file = Path.getCSB("HeroGoldTrainView", "hero"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {}
	}
	HeroGoldTrainView.super.ctor(self, resource)
end

function HeroGoldTrainView:onCreate()
	--i18n
    self:_dealByI18n()
	self:_initTab()
	self:_initUI()
end

function HeroGoldTrainView:onEnter()
end

function HeroGoldTrainView:onExit()
end

function HeroGoldTrainView:_initUI()
	self._subLayers[HERO_GOLD_LAYER] = HeroGoldTrainLayer.new(self)
	self._panelContent:addChild(self._subLayers[HERO_GOLD_LAYER])
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)
end

function HeroGoldTrainView:_initTab()
	local txt = Lang.get("goldenhero_train_button_text")
	self._nodeTabIcon1:updateUI(txt, true, 1)
	self._nodeTabIcon1:setSelected(true)
	self._nodeTabIcon1:setCallback(handler(self, self._onClickTabIcon))
end

function HeroGoldTrainView:_onClickTabIcon(index)
end

--i18n
function HeroGoldTrainView:_dealByI18n()
    if Lang.checkHorizontal() then
        self._imageRope1:setVisible(false)
		self._imageRopeTail:setVisible(false)
		local UIHelper  = require("yoka.utils.UIHelper")
		local panelLeft = UIHelper.seekNodeByName(self,"PanelLeft")
		local size = panelLeft:getContentSize()
		panelLeft:setContentSize(cc.size(146,size.height))
		self._nodeTabIcon1:setPositionX(self._nodeTabIcon1:getPositionX()+20)
    end
end

return HeroGoldTrainView
