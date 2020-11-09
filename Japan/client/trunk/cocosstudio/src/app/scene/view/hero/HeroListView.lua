--
-- Author: Liangxu
-- Date: 2017-02-21 13:32:07
--
local ViewBase = require("app.ui.ViewBase")
local HeroListView = class("HeroListView", ViewBase)
local HeroListCell = require("app.scene.view.hero.HeroListCell")
local HeroFragListCell = require("app.scene.view.hero.HeroFragListCell")
local HeroConst = require("app.const.HeroConst")
local UIPopupHelper = require("app.utils.UIPopupHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TabScrollView = require("app.utils.TabScrollView")

function HeroListView:ctor(index)
	self._fileNodeEmpty = nil --空置控件

	self._selectTabIndex = index or HeroConst.HERO_LIST_TYPE1

	local resource = {
		file = Path.getCSB("HeroListView", "hero"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			_buttonSale = {
				events = {{event = "touch", method = "_onButtonSaleClicked"}}
			},
		},
	}
	HeroListView.super.ctor(self, resource)
end

function HeroListView:onCreate()
	self._topbarBase:setImageTitle("txt_sys_com_wujiang")
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)

	-- i18n change lable
	self:_swapImageByI18n()
	-- i18n ja 回收
	self:_showRecycleBtnI18n()

	self:_initTabGroup()
end

function HeroListView:onEnter()
	self._signalMerageItemMsg = G_SignalManager:add(SignalConst.EVENT_EQUIPMENT_COMPOSE_OK, handler(self, self._onSyntheticFragments))
	self._signalRedPointUpdate = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self,self._onEventRedPointUpdate))
	self._signalSellObjects = G_SignalManager:add(SignalConst.EVENT_SELL_OBJECTS_SUCCESS, handler(self, self._onSellFragmentsSuccess))
	
	self._nodeTabRoot:setTabIndex(self._selectTabIndex)
	self:_updateView()
	self:_refreshRedPoint()
end

function HeroListView:onExit()
	self._signalMerageItemMsg:remove()
	self._signalMerageItemMsg = nil

	self._signalRedPointUpdate:remove()
	self._signalRedPointUpdate = nil

	if self._signalSellObjects then
		self._signalSellObjects:remove()
		self._signalSellObjects = nil
	end

	G_UserData:getItems():setCurSelectItemId(0)  -- i18n ja 道具背包点击杜康酒进行跳转至武将背包，需要屏蔽男/女主角
end

function HeroListView:_onEventRedPointUpdate(event,funcId,param)
	if funcId == FunctionConst.FUNC_HERO_LIST then
		self:_refreshRedPoint()
    end
end


function HeroListView:_refreshRedPoint()
	local redPointShow = G_UserData:getFragments():hasRedPoint({fragType = 1})
	self._nodeTabRoot:setRedPointByTabIndex(HeroConst.HERO_LIST_TYPE2,redPointShow)
end

function HeroListView:_initTabGroup()
	local scrollViewParam = {
		template = HeroListCell,
		updateFunc = handler(self, self._onItemUpdate),
		selectFunc = handler(self, self._onItemSelected),
		touchFunc = handler(self, self._onItemTouch),
	}
	if self._selectTabIndex == HeroConst.HERO_LIST_TYPE2 then
		scrollViewParam.template = HeroFragListCell
	end
	self._tabListView = TabScrollView.new(self._listView, scrollViewParam, self._selectTabIndex)

	local tabNameList = {}
	table.insert(tabNameList, Lang.get("hero_list_tab_1"))
	table.insert(tabNameList, Lang.get("hero_list_tab_2"))

	local param = {
		callback = handler(self, self._onTabSelect),
		textList = tabNameList,
	}

	self._nodeTabRoot:recreateTabs(param)
end

function HeroListView:_onTabSelect(index, sender)
	if index == self._selectTabIndex then
		return
	end

	self._selectTabIndex = index
	self:_updateView()
	self:_refreshRedPoint()
end

function HeroListView:_updateView()
	self._fileNodeBg:setTitle(Lang.get("hero_list_title_"..self._selectTabIndex))
	local count1 = G_UserData:getHero():getHeroTotalCount()
	local count2 = UserDataHelper.getHeroListLimitCount()
	self._fileNodeBg:setCount(Lang.get("common_list_count", {count1 = count1, count2 = count2}))
	self._fileNodeBg:showCount(self._selectTabIndex == HeroConst.HERO_LIST_TYPE1)
	self._buttonSale:setVisible(self._selectTabIndex == HeroConst.HERO_LIST_TYPE2)
	self:_initData()
	
	if self._count == 0 then
		self._tabListView:hideAllView()
		local emptyType = self:_getEmptyType()
		self._fileNodeEmpty:updateView(emptyType)
		self._fileNodeEmpty:setVisible(true)
	else
		local scrollViewParam = {
			template = HeroListCell,
			updateFunc = handler(self, self._onItemUpdate),
			selectFunc = handler(self, self._onItemSelected),
			touchFunc = handler(self, self._onItemTouch),
		}
		if self._selectTabIndex == HeroConst.HERO_LIST_TYPE2 then
			scrollViewParam.template = HeroFragListCell
		end
		
		self._tabListView:updateListView(self._selectTabIndex, self._count, scrollViewParam)
		self._fileNodeEmpty:setVisible(false)
	end
	-- i18n ja 回收
	if Lang.checkUI("ui4") then
		local FunctionCheck = require("app.utils.logic.FunctionCheck")
		local isOpen = FunctionCheck.funcIsOpened(FunctionConst.FUNC_RECYCLE)
		if isOpen then
			self._buttonRecycle:setVisible(self._selectTabIndex == HeroConst.HERO_LIST_TYPE1)
		else
			self._buttonRecycle:setVisible(false)
		end
	end
end

function HeroListView:_getEmptyType()
	local emptyType = nil
	if self._selectTabIndex == HeroConst.HERO_LIST_TYPE1 then
		emptyType = 1 --类型定义在CommonEmptyTipNode.lua
	elseif self._selectTabIndex == HeroConst.HERO_LIST_TYPE2 then
		emptyType = 2
	end
	assert(emptyType, string.format("HeroListView _selectTabIndex is wrong = %d", self._selectTabIndex))
	return emptyType
end

function HeroListView:_initData()
	self._datas = {}
	if self._selectTabIndex == HeroConst.HERO_LIST_TYPE1 then
		self._datas = G_UserData:getHero():getListDataBySort()
		self:_deletLeaderDataByItem()	-- i18n ja 道具背包点击杜康酒进行跳转至武将背包，需要屏蔽男/女主角
	elseif self._selectTabIndex == HeroConst.HERO_LIST_TYPE2 then
		self._datas = G_UserData:getFragments():getFragListByType(1, G_UserData:getFragments().SORT_FUNC_HEROLIST)
	end

	self._count = math.ceil(#self._datas / 2)
end

-- i18n ja 道具背包点击杜康酒进行跳转至武将背包，需要屏蔽男/女主角
function HeroListView:_deletLeaderDataByItem()
	if not Lang.checkUI("ui4") then
		return
	end

	local isHave = false
	local itemId = G_UserData:getItems():getCurSelectItemId() 
	if itemId == 61 or itemId == 62 or itemId == 63 or itemId == 64 then
		local data = clone(self._datas)  -- 要clone 因为是._data是全局的
		table.remove(data, 1)
		self._datas = data
		isHave = true
	end

	self._count = math.ceil(#self._datas / 2)
end

function HeroListView:_onItemUpdate(item, index)
	logWarn("HeroListView:_onItemUpdate "..(index+1))
	local index = index * 2

	item:update(self._datas[index + 1], self._datas[index + 2])
end

function HeroListView:_onItemSelected(item, index)

end

function HeroListView:_onItemTouch(index, t)
	local index = index * 2 + t
	local data = self._datas[index]
	if self._selectTabIndex == HeroConst.HERO_LIST_TYPE1 then
		G_SceneManager:showScene("heroDetail", data, HeroConst.HERO_RANGE_TYPE_1)
	elseif self._selectTabIndex == HeroConst.HERO_LIST_TYPE2 then
		local itemId = data:getId()
		UIPopupHelper.popupFragmentDlg(itemId)
	end
end

function HeroListView:_onSyntheticFragments(id, message)
	local fragId = rawget(message,"id")
	local itemSize = rawget(message,"num")
	if fragId and fragId > 0 then
		local itemParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_FRAGMENT, fragId)
		-- local PopupGetRewards = require("app.ui.PopupGetRewards").new()
		-- local awards = {
		-- 	[1] = {
		-- 		type = itemParam.cfg.comp_type,
		-- 		value =  itemParam.cfg.comp_value,
		-- 		size = itemSize
		-- 	}
		-- }
		-- PopupGetRewards:showRewards(awards)
		local heroId = itemParam.cfg.comp_value
		local count = itemSize
		-- require("app.scene.view.heroMerge.HeroMerge").create(heroId, count)
		G_SceneManager:showScene("heroMerge", heroId, count)

		self:_updateView()
	end
end

function HeroListView:_onButtonSaleClicked()
	if self._datas and #self._datas == 0 then
		G_Prompt:showTip(Lang.get("lang_sellfragment_fragment_empty"))
		return
	end
	local PopupSellFragment = require("app.scene.view.sell.PopupSellFragment")
	local popupSellFragment = PopupSellFragment.new(PopupSellFragment.HERO_FRAGMENT_SELL)
	popupSellFragment:openWithAction()
end

function HeroListView:_onSellFragmentsSuccess()
	self:_updateView()
	self:_refreshRedPoint()
end

-- i18n change lable
function HeroListView:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		
		local image = UIHelper.seekNodeByName(self._buttonSale,"Image_21")
	    UIHelper.swapWithLabel(image,{
			 style = "icon_txt_3",
			 text = Lang.getImgText("txt_main_enter6_sell") ,
			   offsetY = -30,
		})
	end
end

-- i18n ja 回收
function HeroListView:_showRecycleBtnI18n()
	if Lang.checkUI("ui4") then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._buttonRecycle = self._buttonSale:clone()
		local parent = self._buttonSale:getParent()
		parent:addChild(self._buttonRecycle)
		self._buttonRecycle:setVisible(true)
		local label = UIHelper.seekNodeByName(self._buttonRecycle,"Image_21")
		local funcInfo = require("app.config.function_level").get(FunctionConst.FUNC_RECYCLE)
		label:setString(funcInfo.name)
		self._buttonRecycle:loadTextureNormal(Path.getCommonIcon("main", funcInfo.icon))
		self._buttonRecycle:addClickEventListenerEx(function ()
			local RecoveryConst = require("app.const.RecoveryConst")
			G_SceneManager:showScene("recovery", RecoveryConst.RECOVERY_TYPE_1)
		end)
	end
end

return HeroListView
