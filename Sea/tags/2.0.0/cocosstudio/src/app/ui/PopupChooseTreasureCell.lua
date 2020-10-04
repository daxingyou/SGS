--
-- Author: Liangxu
-- Date: 2017-07-07 16:18:57
-- 选择宝物Cell
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupChooseTreasureCell = class("PopupChooseTreasureCell", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UIHelper  = require("yoka.utils.UIHelper")

function PopupChooseTreasureCell:ctor()
	local resource = {
		file = Path.getCSB("PopupChooseTreasureCell", "common"),
		binding = {
			_buttonChoose1 = {
				events = {{event = "touch", method = "_onButtonClicked1"}}
			},
			_buttonChoose2  = {
				events = {{event = "touch", method = "_onButtonClicked2"}}
			},
		}
	}
	PopupChooseTreasureCell.super.ctor(self, resource)
end

function PopupChooseTreasureCell:onCreate()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	if not Lang.checkLang(Lang.CN) then
		for index = 1, 2 do
			self["_textYoke"..index]:setPositionY(self["_textYoke"..index]:getPositionY()+12)
			self["_textHeroName"..index]:setPositionY(self["_textHeroName"..index]:getPositionY()+12)
		end
	end
end

function PopupChooseTreasureCell:update(data1, data2)
	local function updateCell(index, data)
		if data then
			self["_item"..index]:setVisible(true)

			local baseId = data:getBase_id()
			local level = data:getLevel()
			local rank = data:getRefine_level()

			self["_item"..index]:updateUI(TypeConvertHelper.TYPE_TREASURE, baseId)
			self["_item"..index]:setTouchEnabled(true)
			local icon = self["_item"..index]:getCommonIcon()
			local params = icon:getItemParams()
			self["_imageLevel"..index]:loadTexture(Path.getUICommonFrame("img_iconsmithingbg_0"..params.color))
			self["_textLevel"..index]:setString(level)
			self["_imageLevel"..index]:setVisible(level > 0)
			self["_textRank"..index]:setString("+"..rank)
			self["_textRank"..index]:setVisible(rank > 0)

			self:_showAttrDes(index, data)
			
			local heroBaseId = data.heroBaseId
			if heroBaseId then
				local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)
				self["_textHeroName"..index]:setString(heroParam.name)
				self["_textHeroName"..index]:setColor(heroParam.icon_color)
				self["_textHeroName"..index]:setVisible(true)
                UIHelper.updateTextOutline(self["_textHeroName"..index], heroParam)
			else
				self["_textHeroName"..index]:setVisible(false)
			end

			self["_buttonChoose"..index]:setString(data.btnDesc)
			if data.btnIsHightLight == false then
				self["_buttonChoose"..index]:switchToNormal()
			else
				self["_buttonChoose"..index]:switchToHightLight()
			end

			if data.showRP == true then
				self["_buttonChoose"..index]:showRedPoint(true)
			else
				self["_buttonChoose"..index]:showRedPoint(false)
			end

			if data.isYoke then
				local width = self["_item"..index]:getNameSizeWidth()
				self["_textYoke"..index]:setPositionX(120 + width)
				self["_textYoke"..index]:setVisible(true)
			else
				self["_textYoke"..index]:setVisible(false)
			end
		else
			self["_item"..index]:setVisible(false)
		end
	end

	updateCell(1, data1)
	updateCell(2, data2)
end

function PopupChooseTreasureCell:_showAttrDes(index, data)
	local info = UserDataHelper.getTreasureAttrInfo(data)
	local desInfo = TextHelper.getAttrInfoBySort(info)

	for i = 1, 3 do
		local one = desInfo[i]
		if one then
			local attrName, attrValue = TextHelper.getAttrBasicText(one.id, one.value)
			attrName = TextHelper.expandTextByLen(attrName, 4)
			self["_nodeAttr"..index.."_"..i]:updateUI(attrName, "+"..attrValue, nil, 5)
			self["_nodeAttr"..index.."_"..i]:setValueColor(Colors.BRIGHT_BG_GREEN)
			self["_nodeAttr"..index.."_"..i]:setVisible(true)
		else
			self["_nodeAttr"..index.."_"..i]:setVisible(false)
		end
	end
end

function PopupChooseTreasureCell:_onButtonClicked1()
	self:dispatchCustomCallback(1)
end

function PopupChooseTreasureCell:_onButtonClicked2()
	self:dispatchCustomCallback(2)
end

return PopupChooseTreasureCell