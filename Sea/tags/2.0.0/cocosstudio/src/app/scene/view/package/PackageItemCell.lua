--
-- Author: hedl
-- Date: 2017-3-21 13:50:59
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PackageItemCell = class("PackageItemCell", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
function PackageItemCell:ctor()
	self._item1 = nil
	self._item2 = nil
	self._buttonReplace1 = nil
	self._buttonReplace2 = nil
	self._textDes1 = nil
	self._textDes2 = nil

	local resource = {
		file = Path.getCSB("PackageItemCell", "package"),

	}
	PackageItemCell.super.ctor(self, resource)
end

function PackageItemCell:onCreate()
	if not Lang.checkLang(Lang.CN) then
		self:_dealPosByI18n()
	end
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	for i=1, 2 do
		local item = self["_item"..i]
		local button = self["_buttonReplace"..i]
		if item and button then
			item:setVisible(false)
			button:addClickEventListenerEx(handler(self, self._onBtnClick))
		end
	end


end

function PackageItemCell:updateUI(index, itemLine)
	for i=1, 2 do
		local item = self["_item"..i]
		item:setVisible(false)
	end

	local function updateItemCell(i, item)
		local itemInfo = self["_item"..i]
		if itemInfo then
			itemInfo:updateUI(TypeConvertHelper.TYPE_ITEM, item:getId(), item:getNum())
			itemInfo:setVisible(true)
			itemInfo:setTag(i + index*2)
		end
		local itemConfig = item:getConfig()
		local textDesc = self["_textDes"..i]
		if textDesc and itemConfig then
			textDesc:setString(itemConfig.bag_description)
			textDesc:getVirtualRenderer():setLineSpacing(6) 
			if Lang.checkLang(Lang.VN) then
				textDesc:getVirtualRenderer():setLineSpacing(-2)
			elseif Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
				textDesc:getVirtualRenderer():setLineSpacing(0)
			end
		end

		local button = self["_buttonReplace"..i]
		if button then
			if itemConfig.button_type == 0 then
				button:setVisible(false)
			else
				local showRedPoint = G_UserData:getItems():hasRedPointByItemID(item:getId())
				button:setVisible(true)
				button:setString(itemConfig.button_txt)
				button:setButtonTag(i + index*2)
				button:showRedPoint(showRedPoint)
			end

		end

	end

	for i , item in ipairs(itemLine) do
		updateItemCell(i, item)
	end

end


function PackageItemCell:_onBtnClick(sender)
	local curSelectedPos = sender:getTag()
	logWarn(" PackageItemCell:_onBtnClick  "..curSelectedPos)

	self:dispatchCustomCallback(curSelectedPos)
end


function PackageItemCell:updateItemNum(id, num)

	for i=1 , 2  do
		local itemInfo = self["_item"..i]
		if itemInfo and itemInfo:getIconId() == id then
			itemInfo:setIconCount(num)
			return true
		end
	end
	return false
end

-- i18n change lable
function PackageItemCell:_dealPosByI18n()
	if Lang.checkLang(Lang.VN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		for i = 1, 2 do
		       
            self["_textDes" .. i]:setPositionX(self["_textDes" .. i]:getPositionX()-3)
            self["_textDes" .. i]:setPositionY(self["_textDes" .. i]:getPositionY()+6)
            local size1 = self["_textDes" .. i]:getContentSize()
            self["_textDes" .. i]:setContentSize(cc.size(size1.width + 6,size1.height + 12))

            self["_textDes" .. i]:getVirtualRenderer():setLineSpacing(-2)
		end


	end
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
		for i = 1, 2 do
			local line = self["_item"..i]:getSubNodeByName("ImageLine")
			line:setVisible(false)
			local img = self["_item"..i]:getSubNodeByName("Image_1")
			img:setAnchorPoint(0,1)
			img:setPosition(115,80)
			img:setContentSize(cc.size(204,70))
			self["_textDes" .. i]:setContentSize(cc.size(194,70))
			self["_textDes" .. i]:setPosition(120,77)
		end
	end
end

return PackageItemCell
