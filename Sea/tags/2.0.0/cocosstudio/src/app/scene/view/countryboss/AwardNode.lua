
-- Author: nieming
-- Date:2018-05-09 10:39:25
-- Describle：

local ViewBase = require("app.ui.ViewBase")
local AwardNode = class("AwardNode", ViewBase)
local CountryBossHelper = require("app.scene.view.countryboss.CountryBossHelper")

function AwardNode:ctor(bossId)

	--csb bind var name
	self._rankRewardListViewItem = nil  --CommonListViewLineItem
	self._bossId = bossId
	local resource = {
		file = Path.getCSB("AwardNode", "countryboss"),

	}
	AwardNode.super.ctor(self, resource)
end

-- Describle：
function AwardNode:onCreate()
	local awards = CountryBossHelper.getPreviewRankRewards(self._bossId)
	self._rankRewardListViewItem:updateUI(awards)
	self._rankRewardListViewItem:setMaxItemSize(5)
	self._rankRewardListViewItem:setListViewSize(400,100)
	self._rankRewardListViewItem:setItemsMargin(2)
	local cfg = CountryBossHelper.getBossConfigById(self._bossId)
	if cfg.type == 1 then
		self._awardText:setString(Lang.get("country_boss_award_lable1"))
	else
		self._awardText:setString(Lang.get("country_boss_award_lable2"))
	end

	-- i18n change lable
	self:_swapImageByI18n()
end

-- Describle：
function AwardNode:onEnter()

end

-- Describle：
function AwardNode:onExit()

end

-- i18n change lable
function AwardNode:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")

		local image1 = UIHelper.seekNodeByName(self,"Image_144")
		local label = UIHelper.swapWithLabel(image1,{ 
			 style = "text_challenge_1", 
			 text = Lang.getImgText("txt_boss_jiangli01") ,
		})

		if Lang.checkLang(Lang.EN) then
			label:setFontSize(label:getFontSize()-2)
		end


	end
end

return AwardNode
