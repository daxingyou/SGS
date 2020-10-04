
-- Author: nieming
-- Date:2017-12-21 11:45:22
-- Describle：

local ActivitySubView = require("app.scene.view.activity.ActivitySubView")
local LevelGiftView = class("LevelGiftView", ActivitySubView)


function LevelGiftView:ctor()

	--csb bind var name
	self._actTitle = nil  --CommonFullScreen
	self._listView = nil  --ListView

	local resource = {
		file = Path.getCSB("LevelGiftView", "activity/levelGift"),
	}
	LevelGiftView.super.ctor(self, resource)
end

-- Describle：
function LevelGiftView:onCreate()
	if not Lang.checkLang(Lang.CN) then
		self:_swapImageByI18n()
	end
	 G_UserData:getActivityLevelGiftPkg():pullData()
	self:_initListView()
end

-- Describle：
function LevelGiftView:onEnter()
	self._signalLevelGift = G_SignalManager:add(SignalConst.EVENT_WELFARE_LEVEL_GIFT_INFO, handler(self, self._refreshView))
	self._signalLevelGiftAward = G_SignalManager:add(SignalConst.EVENT_WELFARE_LEVEL_GIFT_AWARD, handler(self, self._getAwards))

end

-- Describle：
function LevelGiftView:onExit()
	self._signalLevelGift:remove()
	self._signalLevelGift = nil
	self._signalLevelGiftAward:remove()
	self._signalLevelGiftAward = nil
end

function LevelGiftView:_initListView()
	-- body
	local LevelGiftItemCell = require("app.scene.view.activity.levelGift.LevelGiftItemCell")
	self._listViewData = G_UserData:getActivityLevelGiftPkg():getListViewData()
	self._items = {}
	local width = 0
	local height = 0
	for k, v in pairs(self._listViewData) do
		local item = LevelGiftItemCell.new()
		item:updateUI(v)
		self._listView:pushBackCustomItem(item)
		self._items[k] = item
	end
end

function LevelGiftView:_refreshView()
	for k, v in pairs(self._listViewData) do
		local item = self._items[k]
		item:updateUI(v)
	end
end

function LevelGiftView:_getAwards(message, awards)
	if awards then
		G_Prompt:showAwards(awards)
	end
	--买完东西之后 清理到今天已经点过的的状态
	if not G_UserData:getActivityLevelGiftPkg():canBuy() then
		local ActivityConst = require("app.const.ActivityConst")
		G_UserData:getRedPoint():clearRedPointShowFlag(FunctionConst.FUNC_WELFARE,{actId = ActivityConst.ACT_ID_LEVEL_GIFT_PKG})
	end

end



-- i18n change lable
function LevelGiftView:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self._resourceNode,"Image_3")
	    image1 = UIHelper.swapWithLabel(image1,{
			 style = "text_1",
			 text = Lang.getImgText("txt_com_shop_tips01") ,
		})
		if Lang.checkLang(Lang.KR) then
			image1:setPosition(690,523)
		end
		if Lang.checkChannel(Lang.CHANNEL_SEA) then
			image1:setColor(cc.c3b(0x91,0xa4,0xe4))
			image1:disableEffect(cc.LabelEffect.OUTLINE)
		end
    end
end





return LevelGiftView
