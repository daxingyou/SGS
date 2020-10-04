--
-- 背包主界面
-- 管理其他子界面
--
local ViewBase = require("app.ui.ViewBase")
local PackageMainView = class("PackageMainView", ViewBase)
local PackageViewConst = require("app.const.PackageViewConst")
local PackageView = require("app.scene.view.package.PackageView")
local EquipmentListView = require("app.scene.view.equipment.EquipmentListView")
local TreasureListView = require("app.scene.view.treasure.TreasureListView")
local InstrumentListView = require("app.scene.view.instrument.InstrumentListView")
local PackageHelper = require("app.scene.view.package.PackageHelper")

PackageMainView.viewList = {
    [PackageViewConst.TAB_ITEM] = PackageView,
    [PackageViewConst.TAB_SILKBAG] = PackageView,
    [PackageViewConst.TAB_GEMSTONE] = PackageView,
    [PackageViewConst.TAB_EQUIPMENT] = EquipmentListView,
    [PackageViewConst.TAB_TREASURE] = TreasureListView,
    [PackageViewConst.TAB_INSTRUMENT] = InstrumentListView,
    [PackageViewConst.TAB_JADESTONE] = PackageView
}

function PackageMainView:ctor(tabIndex)
    self._nodeTabRoot = nil -- 左边tab
    self._panelRight = nil -- 右边面板

    self._textList, self._tabFuncList = PackageHelper.getPackageTabList()
    self._selectTabIndex = tabIndex or 1

    self._tabViewList = {}

    local resource = {
        file = Path.getCSB("PackageMainView", "package"),
        size = G_ResolutionManager:getDesignSize(),
        binding = {
            _buttonSale = {
                events = {{event = "touch", method = "_onButtonSaleClicked"}}
            }
        }
    }
    self:setName("PackageMainView")
    PackageMainView.super.ctor(self, resource)
end

function PackageMainView:onCreate()
    -- i18n change lable
    self:_swapImageByI18n()
    if not Lang.checkLang(Lang.CN) then
		self:_dealByI18n()
    end
    if Lang.checkLang(Lang.EN)  then
		local newTabNameList = {}
		local UIHelper  = require("yoka.utils.UIHelper")
		for i, value in ipairs(self._textList) do
			table.insert(newTabNameList, UIHelper.dealVText(value))		
		end
		self._textList = newTabNameList
    end
    
    local param = {
        callback = handler(self, self._onTabSelect),
        textList = self._textList
    }
    local UserDataHelper = require("app.utils.UserDataHelper")
    self._buttonSale:setVisible(not UserDataHelper.isEnoughBagMergeLevel())
    self._nodeTabRoot:recreateTabs(param,cc.size(168,425))
    self:_refreshRedPoint()
end

function PackageMainView:onEnter()
    -- dump(self._nodeTabRoot)
    self._signalRedPointUpdate =
        G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._onEventRedPointUpdate))
    self._signalSellObjects =
        G_SignalManager:add(SignalConst.EVENT_SELL_OBJECTS_SUCCESS, handler(self, self._onSellFragmentsSuccess))
    self._signalSellOnlyObjects =
        G_SignalManager:add(SignalConst.EVENT_SELL_ONLY_OBJECTS_SUCCESS, handler(self, self._onSellFragmentsSuccess))

    self:_showTabView(self._selectTabIndex)

    self._nodeTabRoot:setTabIndex(self._selectTabIndex)

    --抛出新手事件出新手事件
    G_SignalManager:dispatch(SignalConst.EVENT_TUTORIAL_STEP, "PackageView")
end

function PackageMainView:onExit()
    self._signalRedPointUpdate:remove()
    self._signalRedPointUpdate = nil
    self._signalSellObjects:remove()
    self._signalSellObjects = nil

    self._signalSellOnlyObjects:remove()
    self._signalSellOnlyObjects = nil
end

function PackageMainView:_refreshRedPoint()
    local redPointShow = G_UserData:getFragments():hasRedPoint({fragType = 8})
    self._nodeTabRoot:setRedPointByTabIndex(PackageHelper.getPackTabIndex(PackageViewConst.TAB_GEMSTONE), redPointShow) -- 原背包红点
    redPointShow = G_UserData:getFragments():hasRedPoint({fragType = 2})
    self._nodeTabRoot:setRedPointByTabIndex(PackageHelper.getPackTabIndex(PackageViewConst.TAB_EQUIPMENT), redPointShow) --装备红点
    redPointShow = G_UserData:getFragments():hasRedPoint({fragType = 3})
    self._nodeTabRoot:setRedPointByTabIndex(PackageHelper.getPackTabIndex(PackageViewConst.TAB_TREASURE), redPointShow) -- 宝物红点
    redPointShow = G_UserData:getFragments():hasRedPoint({fragType = 4})
    self._nodeTabRoot:setRedPointByTabIndex(
        PackageHelper.getPackTabIndex(PackageViewConst.TAB_INSTRUMENT), -- 神兵红点
        redPointShow
    )
end

function PackageMainView:_onEventRedPointUpdate(event, funcId, param)
    self:_refreshRedPoint()
end

function PackageMainView:_onSellFragmentsSuccess()
    self:_refreshRedPoint()
end

-- 切换子界面
function PackageMainView:_onTabSelect(index, sender)
    if self._selectTabIndex == index then
        return
    end

    for k, v in pairs(self._tabViewList) do
        v:setVisible(false)
    end
    self._selectTabIndex = index
    self:_showTabView(index)
    
end

function PackageMainView:_showTabView(index)
    local tabView = self:getTabView(index)
    tabView:setVisible(true)
    if tabView then
        if tabView.setFuncTabIndex then -- 原背包界面特殊处理
            tabView:setFuncTabIndex(self._tabFuncList[index])
        end
    end
end

function PackageMainView:getTabView(index)
    local tabView = self._tabViewList[index]
    if tabView == nil then
        tabView = PackageMainView.viewList[self._tabFuncList[index]].new()
        self._panelRight:addChild(tabView)
        self._tabViewList[index] = tabView
    end

    return tabView
end

function PackageMainView:_onButtonSaleClicked()
    local tabView = self:getTabView(self._selectTabIndex)
    if tabView.onButtonClicked then
        tabView:onButtonClicked()
    end
end

-- i18n change lable
function PackageMainView:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")

	    self._saleImage = UIHelper.swapWithLabel(self._saleImage,{
			 style = "icon_txt_3",
			 text = Lang.getImgText("txt_main_enter6_sell") ,
			 offsetY = -30,
		})
	end
end

-- i18n change lable
function PackageMainView:_dealByI18n()
	if Lang.checkLang(Lang.EN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local text_desc = UIHelper.seekNodeByName(self._nodeTabRoot,"Text_desc")
		text_desc:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	end
end

return PackageMainView
