--
-- Author: Liangxu
-- Date: 2017-05-05 14:24:05
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local TreasureListCell = class("TreasureListCell", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local TreasureConst = require("app.const.TreasureConst")

function TreasureListCell:ctor()
	local resource = {
		file = Path.getCSB("TreasureListCell", "treasure"),
		binding = {
			_buttonStrengthen1 = {
				events = {{event = "touch", method = "_onButtonStrengthenClicked1"}}
			},
			_buttonStrengthen2 = {
				events = {{event = "touch", method = "_onButtonStrengthenClicked2"}}
			},
		}
	}
	TreasureListCell.super.ctor(self, resource)
end

function TreasureListCell:onCreate()
	-- i18n pos lable
	self:_dealPosI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	self._buttonStrengthen1:setString(Lang.get("treasure_btn_strengthen"))
	self._buttonStrengthen2:setString(Lang.get("treasure_btn_strengthen"))
end

function TreasureListCell:update(treasureId1, treasureId2)
	self._treasureId1 = treasureId1
	self._treasureId2 = treasureId2

	local function updateCell(index, treasureId)

		if treasureId then
			if type(treasureId) ~= "number" then
				return
			end
			self["_item"..index]:setVisible(true)

			local data = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
			local baseId = data:getBase_id()
			local level = data:getLevel()
			local rank = data:getRefine_level()

			self["_item"..index]:updateUI(TypeConvertHelper.TYPE_TREASURE, baseId)
			self["_item"..index]:setTouchEnabled(true)
			self["_item"..index]:setCallBack(handler(self, self["_onClickIcon"..index]))
			local icon = self["_item"..index]:getCommonIcon()
			local params = icon:getItemParams()
			self["_imageLevel"..index]:loadTexture(Path.getUICommonFrame("img_iconsmithingbg_0"..params.color))
			self["_textLevel"..index]:setString(level)
			self["_textLevel"..index]:setColor(Colors.getNumberColor(params.color))
			self["_textLevel"..index]:enableOutline(Colors.getNumberColorOutline(params.color))
			self["_imageLevel"..index]:setVisible(level > 0)
			self["_textRank"..index]:setString("+"..rank)
			self["_textRank"..index]:setVisible(rank > 0)

			self:_showAttrDes(index, data)
			
			local heroBaseId = UserDataHelper.getHeroBaseIdWithTreasureId(data:getId())
			if heroBaseId then
				local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, heroBaseId)
				self["_textHeroName"..index]:setString(heroParam.name)
				self["_textHeroName"..index]:setColor(heroParam.icon_color)
				-- self["_textHeroName"..index]:enableOutline(heroParam.icon_color_outline, 2)
				require("yoka.utils.UIHelper").updateTextOutlineByGold(self["_textHeroName" .. index], heroParam)
				self["_textHeroName"..index]:setVisible(true)
			else
				self["_textHeroName"..index]:setVisible(false)
			end
			self["_buttonStrengthen"..index]:setVisible(data:isCanTrain())
		else
			self["_item"..index]:setVisible(false)
		end
	end

	updateCell(1, treasureId1)
	updateCell(2, treasureId2)
end

function TreasureListCell:_showAttrDes(index, data)
	local isCanTrain = data:isCanTrain()
	if not isCanTrain then
		for i = 1, 3 do
			self["_nodeAttr"..index.."_"..i]:setVisible(false)
		end
		return
	end

	local info = UserDataHelper.getTreasureAttrInfo(data)
	local desInfo = TextHelper.getAttrInfoBySort(info)

	for i = 1, 3 do
		local one = desInfo[i]
		if one then
			local attrName, attrValue = TextHelper.getAttrBasicText(one.id, one.value)
			attrName = TextHelper.expandTextByLen(attrName, 4)
			self["_nodeAttr"..index.."_"..i]:updateUI(attrName, "+"..attrValue)
			self["_nodeAttr"..index.."_"..i]:setValueColor(Colors.BRIGHT_BG_GREEN)
			self["_nodeAttr"..index.."_"..i]:setVisible(true)
		else
			self["_nodeAttr"..index.."_"..i]:setVisible(false)
		end
	end
end

function TreasureListCell:_onButtonStrengthenClicked1()
	self:dispatchCustomCallback(1)
end

function TreasureListCell:_onButtonStrengthenClicked2()
	self:dispatchCustomCallback(2)
end

function TreasureListCell:_onClickIcon1(sender, itemParams)
	if itemParams.cfg.treasure_type == 0 then
		local PopupItemGuider = require("app.ui.PopupItemGuider").new(Lang.get("way_type_get"))
		PopupItemGuider:updateUI(TypeConvertHelper.TYPE_TREASURE, itemParams.cfg.id)
		PopupItemGuider:openWithAction()
	else
		local treasureId = self._treasureId1
		G_SceneManager:showScene("treasureDetail", treasureId, TreasureConst.TREASURE_RANGE_TYPE_1)
	end
end

function TreasureListCell:_onClickIcon2(sender, itemParams)
	if itemParams.cfg.treasure_type == 0 then
		local PopupItemGuider = require("app.ui.PopupItemGuider").new(Lang.get("way_type_get"))
		PopupItemGuider:updateUI(TypeConvertHelper.TYPE_TREASURE, itemParams.cfg.id)
		PopupItemGuider:openWithAction()
	else
		local treasureId = self._treasureId2
		G_SceneManager:showScene("treasureDetail", treasureId, TreasureConst.TREASURE_RANGE_TYPE_1)
	end
end

-- i18n pos lable
function TreasureListCell:_dealPosI18n()
	if not Lang.checkLang(Lang.CN) then
		self._textHeroName1:setFontSize(
			self._textHeroName1:getFontSize()-2
		)
		self._textHeroName2:setFontSize(
			self._textHeroName2:getFontSize()-2
		)
	end
end



return TreasureListCell