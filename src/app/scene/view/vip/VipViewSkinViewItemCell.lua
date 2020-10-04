
local UserDataHelper = require("app.utils.UserDataHelper")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local VipViewSkinViewItemCell = class("VipViewSkinViewItemCell", ListViewCellBase)

function VipViewSkinViewItemCell:ctor()
	self._resourceNode = nil --根节点
	local resource = {
		file = Path.getCSB("VipViewSkinViewItemCell", "vip"),
		binding = {
		},
    }
	VipViewSkinViewItemCell.super.ctor(self, resource)
end

function VipViewSkinViewItemCell:onCreate()
	local size = self._resourceNode:getContentSize()
    self:setContentSize(size.width, size.height)
    
    self._text:setString(Lang.get("vip_skin_button_equiped"))
end

function VipViewSkinViewItemCell:updateUI(config,selectIndex)
    self._image:loadTexture( Path.getMonthlyCardRes2("img_huan"..config.id))
    local has = UserDataHelper.isHasPosterGirl(config.id)
    local isEquip = UserDataHelper.isEquipPosterGirl(config.id)
    self._imageLock:setVisible(not has)
    self._imageEquip:setVisible(isEquip)
   
    local index = self:getTag()
    self._imageSelect:setVisible(selectIndex == index + 1)
end

function VipViewSkinViewItemCell:setSelect(isSelect)
    self._imageSelect:setVisible(isSelect)
end

return VipViewSkinViewItemCell
