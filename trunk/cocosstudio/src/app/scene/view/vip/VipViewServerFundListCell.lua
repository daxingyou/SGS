-- Author: conley
local OpenServerFundItemCell = require("app.scene.view.activity.openserverfund.OpenServerFundItemCell")
local VipViewServerFundListCell = class("VipViewServerFundListCell", OpenServerFundItemCell)

function VipViewServerFundListCell:ctor()
    local resource = {
		file = Path.getCSB("VipViewServerFundListCell", "vip"),
		binding = {
			_commonButtonMediumNormal = {
				events = {{event = "touch", method = "_onItemClick"}}
			}
		},
    }
    VipViewServerFundListCell.super.ctor(self, resource)
end

return VipViewServerFundListCell