local ListViewCellBase = require("app.ui.ListViewCellBase")
local UpdateViewBulletinCell = class("UpdateViewBulletinCell", ListViewCellBase)


function UpdateViewBulletinCell:ctor()
	local resource = {
		file = Path.getCSB("UpdateViewBulletinCell", "login"),
		binding = {
			_image = {
				events = {{event = "touch", method = "_onClickImage"}}
			},
		}
		
	}
	UpdateViewBulletinCell.super.ctor(self, resource)
end

function UpdateViewBulletinCell:onCreate()
	local size = self._image:getContentSize()
	self._image:ignoreContentAdaptWithSize(true)
	self:setContentSize(size.width, size.height)
end

function UpdateViewBulletinCell:update(imgPath)
    self._image:loadTexture(imgPath)
end

function UpdateViewBulletinCell:onEnter()
end

function UpdateViewBulletinCell:onExit()
end

function UpdateViewBulletinCell:_onClickImage(sender)
	self:dispatchCustomCallback(self:getIdx())
end

return UpdateViewBulletinCell
