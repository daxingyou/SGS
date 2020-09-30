
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
	self:_awardPosByI18n()
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
	end
end

function AwardNode:_awardPosByI18n()
	if Lang.checkUI("ui4") then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._awardText:setAnchorPoint(0.5,0)
		self._awardText:setFontSize(16)
		self._awardText:setColor(cc.c3b(0xff,0xb8,0x0c))
		local panel = UIHelper.seekNodeByName(self,"Image_31")
		panel:setAnchorPoint(0,0)
		panel:setPosition(11.6,1)
		local size = cc.size(330,80 + self._awardText:getContentSize().height)
		panel:setContentSize(size)
		local image145 = UIHelper.seekNodeByName(self,"Image_145")
		image145:loadTexture(Path.getWorldBossUI("img_worldboss_title022"))
		image145:ignoreContentAdaptWithSize(true)
		image145:setAnchorPoint(0.5,0.5)
		image145:setPosition(panel:getPositionX() + 17,panel:getPositionY() + 35)
		local image3 = UIHelper.seekNodeByName(self,"Image_144")
		image3:getVirtualRenderer():setWidth(20)
		image3:setFontSize(20)
		image3:setColor(cc.c3b(0xfe,0xe1,0x02))
		image3:setPosition(image145:getContentSize().width/2,image145:getContentSize().height/2)
		local posX = panel:getPositionX() + size.width/2
		local posY = panel:getPositionY() + 73
		self._awardText:setPosition(posX,posY)
		self._rankRewardListViewItem:setListViewSize(410-35,100)
		local posX = self._rankRewardListViewItem:getPositionX() + 25
		self._rankRewardListViewItem:setPositionX(posX)
		local image147 = UIHelper.seekNodeByName(self,"Image_147")
		image147:setVisible(false)
	end
end

return AwardNode
