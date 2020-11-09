
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

    self._textName:getVirtualRenderer():setMaxLineWidth(28)
    self._text:setString(Lang.get("vip_skin_button_equiped"))
end

function VipViewSkinViewItemCell:updateUI(config,selectIndex)
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local itemParams = TypeConvertHelper.convert(TypeConvertHelper.TYPE_POSTER_GIRL_SKIN,config.id )

    self._image:loadTexture(itemParams.staticImg)
    local has = UserDataHelper.isHasPosterGirl(config.id)
    local isEquip = UserDataHelper.isEquipPosterGirl(config.id)
    self._imageLock:setVisible(not has)
    self._textName:setString(config.name)
    self._imageShade:setVisible(not has)
    self._imageEquip:setVisible(isEquip)
   
    local index = self:getTag()
    self._imageSelect:setVisible(selectIndex == index + 1)
end

function VipViewSkinViewItemCell:setSelect(isSelect)
    self._imageSelect:setVisible(isSelect)
end

return VipViewSkinViewItemCell
