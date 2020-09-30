local UserDataHelper = require("app.utils.UserDataHelper")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local VipViewNormalShopItemRow = require("app.scene.view.vip.VipViewNormalShopItemRow")
local VipViewLimitShopItemRow = class("VipViewLimitShopItemRow",VipViewNormalShopItemRow)


function VipViewLimitShopItemRow:ctor()
    local resource = {
        file = Path.getCSB("VipViewLimitShopItemRow", "vip")
    }
    VipViewLimitShopItemRow.super.ctor(self, resource)
end




function VipViewLimitShopItemRow:_refreshListView(listViewItem,dropList)
	listViewItem:setItemSpacing(2)
	listViewItem:setListViewSize(200,70)
    listViewItem:updateUI(dropList, 0.6)
    listViewItem:setTextItemCountFontSize(26)
	listViewItem:alignCenter()
end


return VipViewLimitShopItemRow