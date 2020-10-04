local ViewBase = require("app.ui.ViewBase")
local PackageView = class("PackageView", ViewBase)
local PackageItemCell = require("app.scene.view.package.PackageItemCell")
-- local PackageGemstoneCell = require("app.scene.view.package.PackageGemstoneCell")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local UIPopupHelper = require("app.utils.UIPopupHelper")
local FunctionCheck = require("app.utils.logic.FunctionCheck")
local FunctionConst = require("app.const.FunctionConst")
local TextHelper = require("app.utils.TextHelper")
local PackageSilkbagCell = require("app.scene.view.package.PackageSilkbagCell")
local PackageViewConst = require("app.const.PackageViewConst")
local PackageHelper = require("app.scene.view.package.PackageHelper")

function PackageView:ctor()
    --
    self._nodeTabRoot = nil --nodeTab根节点
    self._listViewTab1 = nil

    self._tabGroup2 = nil -- 顶部tab

    --数据
    self._curSelectData = {}

    self._textList = PackageHelper.getPackageTabList()

    self._tabFuncIndex = 1 --选中标签页

    --到80级加载领一个csb
    local resName = "PackageView1"
    if UserDataHelper.isEnoughBagMergeLevel() then
        resName = "PackageView2"
    end
    local resource = {
        file = Path.getCSB(resName, "package"),
        size = G_ResolutionManager:getDesignSize(),
        binding = {
            _buttonSale = {
                events = {{event = "touch", method = "_onButtonSaleClicked"}}
            }
        }
    }
    self:setName("PackageView")
    PackageView.super.ctor(self, resource)
end

function PackageView:onCreate()
    self._topbarBase:setImageTitle("txt_sys_com_beibao")
    --Lang.get("package_title")
    
    self:_dealPosByI18n()
	self:_swapImageByI18n()

    local TopBarStyleConst = require("app.const.TopBarStyleConst")
    self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)
end

-- 外部选中了哪个界面
function PackageView:setFuncTabIndex(tabFuncIndex)
    self._tabFuncIndex = tabFuncIndex
    local index = PackageHelper.getPackTabIndex(tabFuncIndex)
    self._commonFullScreen:setTitle(TextHelper.expandTextByLen(self._textList[index], 3))
    if self._tabGroup2 then
        local param2 = {
            callback = handler(self, self._onTabSelect2),
            isVertical = 2,
            offset = -2,
            textList = PackageHelper.getTabGroup2TextList(self._tabFuncIndex)
        }
        self._tabGroup2:recreateTabs(param2)
        self._tabGroup2:setTabIndex(1)
    end
    local TabScrollView = require("app.utils.TabScrollView")
    local scrollViewParam = {
        template = PackageItemCell,
        updateFunc = handler(self, self._onItemUpdate),
        selectFunc = handler(self, self._onItemSelected),
        touchFunc = handler(self, self._onItemTouch)
    }
    if tabFuncIndex == PackageViewConst.TAB_GEMSTONE then
        local PackageGemstoneCell = require("app.scene.view.package.PackageGemstoneCell")
        scrollViewParam.template = PackageGemstoneCell
    elseif tabFuncIndex == PackageViewConst.TAB_SILKBAG then
        scrollViewParam.template = PackageSilkbagCell
    elseif tabFuncIndex == PackageViewConst.TAB_JADESTONE then
        local PackageJadeCell = require("app.scene.view.package.PackageJadeCell")
        scrollViewParam.template = PackageJadeCell
        self._topbarBase:updateUIByResList(PackageViewConst.JADE_STONE_TOPBAR_RES)
    end
    self._tabListView = TabScrollView.new(self._listViewTab1, scrollViewParam)
    self:_onTabSelect(index)
end

function PackageView:_onTabSelect2()
end

function PackageView:_onTabSelect(index)
    self._commonFullScreen:setTitle(TextHelper.expandTextByLen(self._textList[index], 3))
    self:_updateListView()
end

function PackageView:_onItemSelected(item, index)
end

function PackageView:_onItemTouchItem(index, itemPos)
    local lineIndex = index
    local itemData = self._curSelectData[itemPos]
    if itemData then
        PackageHelper.popupUseItem(itemData:getId())
    end
end

function PackageView:_onItemTouchGemstone(index, itemPos)
    local itemData = self._curSelectData[index * 2 + itemPos]
    if itemData then
        local UIPopupHelper = require("app.utils.UIPopupHelper")
        UIPopupHelper.popupFragmentDlg(itemData:getId())
    else
        assert(false, string.format("itemData == nil index = %s itemPos = %s", index, itemPos))
    end
end

function PackageView:_onItemTouchSilkbag(index, itemPos)
    local isOpen, comment = FunctionCheck.funcIsOpened(FunctionConst.FUNC_SILKBAG)
    if not isOpen then
        G_Prompt:showTip(comment)
        return
    end

    local itemData = self._curSelectData[index * 2 + itemPos]
    if itemData then
        local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
        local functionId = itemData:getConfig().function_id
        WayFuncDataHelper.gotoModuleByFuncId(functionId)
    end
end

function PackageView:_onItemTouchJadeStone(index, itemPos)
    local isOpen, comment = FunctionCheck.funcIsOpened(FunctionConst.FUNC_EQUIP_TRAIN_TYPE3)
    if not isOpen then
        G_Prompt:showTip(comment)
        return
    end

    local itemData = self._curSelectData[index * 2 + itemPos]
    if itemData then
        local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
        local functionId = itemData:getConfig().function_id
        WayFuncDataHelper.gotoModuleByFuncId(functionId)
    end
end

function PackageView:_onItemTouch(index, itemPos)
    local funcTabIndex = self._tabFuncIndex
    if funcTabIndex == PackageViewConst.TAB_GEMSTONE then
        self:_onItemTouchGemstone(index, itemPos)
    elseif funcTabIndex == PackageViewConst.TAB_ITEM then
        self:_onItemTouchItem(index, itemPos)
    elseif funcTabIndex == PackageViewConst.TAB_SILKBAG then
        self:_onItemTouchSilkbag(index, itemPos)
    elseif funcTabIndex == PackageViewConst.TAB_JADESTONE then
        self:_onItemTouchJadeStone(index, itemPos)
    end
end

function PackageView:_onItemUpdate(item, index)
    local startIndex = index * 2 + 1
    -- logWarn("PackageView:_onItemUpdate  " .. startIndex)
    local endIndex = startIndex + 1
    local itemLine = {}

    local itemList = self._curSelectData
    if #itemList > 0 then
        for i = startIndex, endIndex do
            local itemData = itemList[i]
            if itemData then
                table.insert(itemLine, itemData)
            end
        end
        item:updateUI(index, itemLine)
    end
end

--
function PackageView:isRootScene()
    return true
end

--
function PackageView:onEnter()
    self._merageItemMsg =
        G_SignalManager:add(SignalConst.EVENT_EQUIPMENT_COMPOSE_OK, handler(self, self._onSyntheticFragments))
    self._updateItemMsg = G_SignalManager:add(SignalConst.EVENT_ITEM_OP_UPDATE, handler(self, self._onEventUpdateItem)) --道具更新事件监听
    self._deleteItemMsg = G_SignalManager:add(SignalConst.EVENT_ITEM_OP_DELETE, handler(self, self._onEventDeleteItem)) --道具删除事件
    self._intertItemMsg = G_SignalManager:add(SignalConst.EVENT_ITEM_OP_INSERT, handler(self, self._onEventInsertItem)) --添加道具事件

    self._signalSellObjects =
        G_SignalManager:add(SignalConst.EVENT_SELL_OBJECTS_SUCCESS, handler(self, self._onSellFragmentsSuccess))
    self._signalSellOnlyObjects =
        G_SignalManager:add(SignalConst.EVENT_SELL_ONLY_OBJECTS_SUCCESS, handler(self, self._onSellFragmentsSuccess))
    -- self._nodeTabRoot:setTabIndex(self.self._tabFuncIndex)
    -- self:_updateListView()
end

function PackageView:onExit()
    self._merageItemMsg:remove()
    self._merageItemMsg = nil
    self._updateItemMsg:remove()
    self._updateItemMsg = nil
    self._deleteItemMsg:remove()
    self._deleteItemMsg = nil
    self._intertItemMsg:remove()
    self._intertItemMsg = nil

    -- self._signalRedPointUpdate:remove()
    -- self._signalRedPointUpdate = nil
    self._signalSellObjects:remove()
    self._signalSellObjects = nil

    self._signalSellOnlyObjects:remove()
    self._signalSellOnlyObjects = nil
end
-- 觉醒 道具包含 道具和碎片
function PackageView:_getGemStoneData()
    local data = {}
    local isInsertGemstone = false
    local gemstoneData = G_UserData:getGemstone():getGemstonesData()
    local gemstoneFragmentData =
        G_UserData:getFragments():getFragListByType(
        TypeConvertHelper.TYPE_GEMSTONE,
        G_UserData:getFragments().SORT_FUNC_COMMON
    )

    for k, gemstoneFragment in ipairs(gemstoneFragmentData) do
        if not isInsertGemstone then
            local canMerge = gemstoneFragment:getNum() >= gemstoneFragment:getConfig().fragment_num
            if not canMerge then
                isInsertGemstone = true
                for _, gemstone in ipairs(gemstoneData) do
                    table.insert(data, gemstone)
                end
            end
        end
        table.insert(data, gemstoneFragment)
    end

    if not isInsertGemstone then
        isInsertGemstone = true
        for _, gemstone in ipairs(gemstoneData) do
            table.insert(data, gemstone)
        end
    end

    return data
end

function PackageView:_resetData()
    local funcTabIndex = self._tabFuncIndex
    if funcTabIndex == PackageViewConst.TAB_GEMSTONE then
        logWarn("TAB_GEMSTONE this")
        self._curSelectData = self:_getGemStoneData()
    elseif funcTabIndex == PackageViewConst.TAB_ITEM then
        logWarn("TAB_ITEM this")
        self._curSelectData = G_UserData:getItems():getItemsData()
        logWarn(#self._curSelectData)
    elseif funcTabIndex == PackageViewConst.TAB_SILKBAG then
        logWarn("TAB_SILKBAG this")
        self._curSelectData = G_UserData:getSilkbag():getListDataOfPackage()
    elseif funcTabIndex == PackageViewConst.TAB_JADESTONE then
        self._curSelectData = G_UserData:getJade():getJadeListByPackage()
    end
end
function PackageView:_updateListView()
    self:_resetData()
    local lineCount = math.ceil(#self._curSelectData / 2)
    self._tabListView:updateListView(1, lineCount)

    -- self._buttonSale:setVisible(funcTabIndex == PackageViewConst.TAB_GEMSTONE)
    self:_updateSaleBtn()
    self._nodeEmpty:setVisible(#self._curSelectData <= 0)
end

function PackageView:_updateSaleBtn()
    local funcTabIndex = self._tabFuncIndex
    local UserDataHelper = require("app.utils.UserDataHelper")
    self._buttonSale:setVisible(UserDataHelper.isEnoughBagMergeLevel() == true)
    -- _saleImage
end

--收到道具更新时回调
function PackageView:_onEventUpdateItem(eventName, updateItems)
    local funcTabIndex = self._tabFuncIndex
    if funcTabIndex == PackageViewConst.TAB_ITEM then
        self:_updateListView()
    end
end

----需要删除道具
function PackageView:_onEventDeleteItem(eventName, deleteIds)
    self:_updateListView()
end

--需要添加道具
function PackageView:_onEventInsertItem()
    self:_updateListView()
end

function PackageView:_onSyntheticFragments(id, message)
    if not self:isVisible() then
        return
    end

    local fragId = rawget(message, "id")
    local itemSize = rawget(message, "num")
    if fragId and fragId > 0 then
        local itemParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_FRAGMENT, fragId)
        local PopupGetRewards = require("app.ui.PopupGetRewards").new()
        local awards = {
            [1] = {
                type = itemParam.cfg.comp_type,
                value = itemParam.cfg.comp_value,
                size = itemSize
            }
        }
        PopupGetRewards:showRewards(awards)

        self:_updateListView()
    end
end

function PackageView:onButtonClicked()
    self:_onButtonSaleClicked()
end

function PackageView:_onButtonSaleClicked()
    local PopupSellFragment = require("app.scene.view.sell.PopupSellFragment")
    local funcTabIndex = self._tabFuncIndex
    if funcTabIndex == PackageViewConst.TAB_GEMSTONE then
        if self._curSelectData and #self._curSelectData == 0 then
            G_Prompt:showTip(Lang.get("lang_sellfragment_gemstone_empty"))
            return
        end
        local popupSellFragment = PopupSellFragment.new(PopupSellFragment.GEMSTONE_SELL)
        popupSellFragment:openWithAction()
    elseif funcTabIndex == PackageViewConst.TAB_ITEM then
        local officeSealData = G_UserData:getItems():getItemSellData()
        if officeSealData and #officeSealData == 0 then
            G_Prompt:showTip(Lang.get("lang_sellfragment_office_seal_empty"))
            return
        end
        local popupSellFragment = PopupSellFragment.new(PopupSellFragment.ITEM_SEAL_SELL)
        popupSellFragment:openWithAction()
    elseif funcTabIndex == PackageViewConst.TAB_SILKBAG then
        local sellData = G_UserData:getSilkbag():getListDataOfSell()
        if sellData and #sellData == 0 then
            G_Prompt:showTip(Lang.get("lang_sellfragment_silkbag_empty"))
            return
        end
        local popupSellFragment = PopupSellFragment.new(PopupSellFragment.SILKBAG_SELL)
        popupSellFragment:openWithAction()
    elseif funcTabIndex == PackageViewConst.TAB_JADESTONE then
        if self._curSelectData and #self._curSelectData == 0 then
            G_Prompt:showTip(Lang.get("lang_sellfragment_jadestone_empty"))
            return
        end
        local popupSellFragment = PopupSellFragment.new(PopupSellFragment.JADESTONE_SELL)
        popupSellFragment:openWithAction()
    end
end

function PackageView:_onSellFragmentsSuccess()
    self:_updateListView()
end



-- i18n change pos
function PackageView:_dealPosByI18n()
    if not Lang.checkLang(Lang.CN) then
        self._nodeEmpty:setPositionY(self._nodeEmpty:getPositionY()-45)
    end
end

-- i18n change lable
function PackageView:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")

	    self._saleImage = UIHelper.swapWithLabel(self._saleImage,{
			 style = "icon_txt_3",
			 text = Lang.getImgText("txt_main_enter6_sell") ,
			 offsetY = -30,
		})
	end
end



return PackageView
