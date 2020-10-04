-- Author: liangxu
-- Date:2018-3-13 09:20:37
-- Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local PackageSilkbagCell = class("PackageSilkbagCell", ListViewCellBase)
local SilkbagDataHelper = require("app.utils.data.SilkbagDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local SilkbagConst = require("app.const.SilkbagConst")
local UIHelper  = require("yoka.utils.UIHelper")

function PackageSilkbagCell:ctor()
	local resource = {
		file = Path.getCSB("PackageSilkbagCell", "package"),
		binding = {
			_button1 = {
				events = {{event = "touch", method = "_onClickButton1"}}
			},
			_button2 = {
				events = {{event = "touch", method = "_onClickButton2"}}
			},
		},
	}
	PackageSilkbagCell.super.ctor(self, resource)
end

function PackageSilkbagCell:onCreate()
	-- i18n pos lable
	self:_dealPosI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	
end

function PackageSilkbagCell:updateUI(index, itemLine)
	for i=1, 2 do
		local item = self["_item"..i]
		item:setVisible(false)
	end
	local function updateCell(i, data)
		if data then
			self["_item"..i]:setVisible(true)
			local baseId = data:getBase_id()
			local info = SilkbagDataHelper.getSilkbagConfig(baseId)
			local nameStr = info.only == SilkbagConst.ONLY_TYPE_1 and Lang.get("silkbag_only_tip", {name = info.name}) or info.name
			self["_item"..i]:updateUI(TypeConvertHelper.TYPE_SILKBAG, baseId)
			self["_item"..i]:setName(nameStr)
			self["_textDes"..i]:setString(info.bag_description)
			self["_button"..i]:setString(info.button_txt)

			local heroBaseId = data:getHeroBaseIdOfWeared()
			if heroBaseId > 0 then
				local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)
				self["_textHeroName"..i]:setVisible(true)
				self["_textHeroName"..i]:setString(heroParam.name)
				self["_textHeroName"..i]:setColor(heroParam.icon_color)
				UIHelper.updateTextOutline(self["_textHeroName"..i], heroParam)
			else
				self["_textHeroName"..i]:setVisible(false)
			end
		end
	end
	
	for i , data in ipairs(itemLine) do
		updateCell(i, data)
	end
end

function PackageSilkbagCell:_onClickButton1()
	self:dispatchCustomCallback(1)
end

function PackageSilkbagCell:_onClickButton2()
	self:dispatchCustomCallback(2)
end


-- i18n pos lable
function PackageSilkbagCell:_dealPosI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
        self._textHeroName1:setFontSize(18)
		self._textHeroName2:setFontSize(18)
		
		self._textHeroName1:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER )
		self._textHeroName1:setTextVerticalAlignment( cc.VERTICAL_TEXT_ALIGNMENT_CENTER  )
		self._textHeroName1:getVirtualRenderer():setLineSpacing(0 )
		self._textHeroName1:getVirtualRenderer():setMaxLineWidth(100)


		self._textHeroName2:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER )
		self._textHeroName2:setTextVerticalAlignment( cc.VERTICAL_TEXT_ALIGNMENT_CENTER  )
		self._textHeroName2:getVirtualRenderer():setLineSpacing(0 )
		self._textHeroName2:getVirtualRenderer():setMaxLineWidth(100)

	end
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
		self._textHeroName1:setPositionY(self._textHeroName1:getPositionY()-25)
		self._textHeroName2:setPositionY(self._textHeroName2:getPositionY()-25)
		self._textHeroName1:getVirtualRenderer():setMaxLineWidth(0)
		self._textHeroName2:getVirtualRenderer():setMaxLineWidth(0)
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

return PackageSilkbagCell