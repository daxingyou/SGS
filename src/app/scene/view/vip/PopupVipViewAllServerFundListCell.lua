-- Author: conley
local OpenServerFundItemCell = require("app.scene.view.activity.openserverfund.OpenServerFundItemCell")
local PopupVipViewAllServerFundListCell = class("PopupVipViewAllServerFundListCell", OpenServerFundItemCell)

function PopupVipViewAllServerFundListCell:ctor()
    local resource = {
		file = Path.getCSB("OpenServerFundItemCell", "activity/openserverfund"),
		binding = {
			_commonButtonMediumNormal = {
				events = {{event = "touch", method = "_onItemClick"}}
			}
		},
    }
    PopupVipViewAllServerFundListCell.super.ctor(self, resource)
end

return PopupVipViewAllServerFundListCell