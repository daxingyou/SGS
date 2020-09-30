--
-- Author: Liangxu
-- Date: 2017-03-01 19:46:33
-- 武将详情 神兵模块
-- i18n ja add Lua
local ListViewCellBase = require("app.ui.ListViewCellBase")
local HeroDetailWeaponModule = class("HeroDetailWeaponModule", ListViewCellBase)
local AttributeConst = require("app.const.AttributeConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local InstrumentConst = require("app.const.InstrumentConst")
local UserDataHelper = require("app.utils.UserDataHelper")
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")

local NORMAL_WIDTH = 92

function HeroDetailWeaponModule:ctor(heroUnitData)
	self._heroUnitData = heroUnitData
	local resource = {
		file = Path.getCSB("HeroDetailWeaponModule2", "hero"),
		binding = {
			_buttonAdvance = {
				events = {{event = "touch", method = "_onButtonAdvanceClicked"}}
			}
		}
	}

	HeroDetailWeaponModule.super.ctor(self, resource)
end

function HeroDetailWeaponModule:onCreate()
	if not Lang.checkLang(Lang.CN) then
		self:_dealByI18n()
	end
	self:_dealPosByI18n()
	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)

	self._nodeTitle:setFontSize(22)
	self._nodeTitle:setTitle(Lang.get("hero_detail_title_weapon"))
	self._buttonAdvance:setString(Lang.get("hero_detail_btn_advance"))

	local baseId = self._heroUnitData:getConfig().instrument_id
	local level = 0
	local limitLevel = 0
	local attrInfo = {
		[AttributeConst.ATK] = 0,
		[AttributeConst.HP] = 0,
		[AttributeConst.PD] = 0,
		[AttributeConst.MD] = 0
	}
	local instrumentId = nil
	local heroUnitData = self._heroUnitData
	local pos = heroUnitData:getPos()
	if pos then
		instrumentId = G_UserData:getBattleResource():getResourceId(pos, 3, 1)
	end

	if instrumentId then
		local unitData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
		level = unitData:getLevel()
		limitLevel = unitData:getLimit_level()
		attrInfo = UserDataHelper.getInstrumentAttrInfo(unitData)
		self._buttonAdvance:setEnabled(true)
	else
		self._buttonAdvance:setEnabled(false)
	end

	self._instrumentId = instrumentId

	self._fileNodeIcon:updateUI(baseId, nil, limitLevel) 
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_INSTRUMENT, baseId, nil, nil, limitLevel)
	self._textName:setString(param.name)
	self._textName:setColor(param.icon_color)
	local UIHelper  = require("yoka.utils.UIHelper")
	UIHelper.updateTextOutline(self._textName, param)
	-- if param.color == 7 then
	-- 	self._textName:enableOutline(cc.c4b(param.icon_color_outline.r,
	-- 										param.icon_color_outline.g,
	-- 										param.icon_color_outline.b,
	-- 										param.icon_color_outline.a))
	-- end

	local label = nil
	local showId = AvatarDataHelper.getShowHeroBaseIdByCheck(self._heroUnitData)
	local description = AvatarDataHelper.getAvatarMappingConfig(showId).description
	if level >= param.unlock then
		local content =
			Lang.get(
			"instrument_detail_advance",
			{
				des = description,
				color = Colors.colorToNumber(Colors.BRIGHT_BG_GREEN)
			}
		)
		content = content.gsub(content, "\"fontSize\":20", "\"fontSize\":18")
		label = ccui.RichText:createWithContent(content)
	else
		local content =
			Lang.get(
			"instrument_detail_advance_unlock",
			{
				des = description,
				color = Colors.colorToNumber(Colors.BRIGHT_BG_TWO),
				level = param.unlock
			}
		)

		content = content.gsub(content, "\"fontSize\":20", "\"fontSize\":18")
		label = ccui.RichText:createWithContent(content)
	end

	label:setAnchorPoint(cc.p(0, 1))
	label:ignoreContentAdaptWithSize(false)
	if not Lang.checkLang(Lang.CN) then
		label:setContentSize(cc.size(200,0))  -- offset 15
	else
		label:setContentSize(cc.size(185,0))
	end
	label:formatText()
--	label:setFontSize(18)  				-- 修改子号 设置无效 创建前设置
	self._nodeDesc:addChild(label)
	local virtualContentSize = label:getVirtualRendererSize()
	if virtualContentSize.height > NORMAL_WIDTH then
		local size = self._panelBg:getContentSize()
		local offsetY = (virtualContentSize.height - NORMAL_WIDTH) + 10
		size.height = size.height + offsetY
		self._panelBg:setContentSize(size)
		local posY = self._node:getPositionY()
		self._node:setPositionY(posY + offsetY)
		local btPosY = self._nodeBottom:getPositionY()
		self._nodeBottom:setPositionY(btPosY - offsetY)
	end
	self._nodeBottom:setPositionY(self._nodeBottom:getPositionY() - 3)

	-- 调整背景图尺寸
	if (virtualContentSize.height +24) > NORMAL_WIDTH then
		self._node:getChildByName("Image_5"):setContentSize(cc.size(330, virtualContentSize.height + 36))
	else
		self._node:getChildByName("Image_5"):setContentSize(cc.size(330, NORMAL_WIDTH))
	end

	if self._fileNodeIcon:getChildByName("ImageBg"):getContentSize().height + 3 > self._node:getChildByName("Image_5"):getContentSize().height then
		self._node:getChildByName("Image_5"):setContentSize(cc.size(330, self._fileNodeIcon:getChildByName("ImageBg"):getContentSize().height))
	end

	self._textLevel:setString(Lang.get("hero_detail_instrument_advance_level", {level = level}))
	self._nodeAttr1:updateView(AttributeConst.ATK, attrInfo[AttributeConst.ATK], nil, 4)
	self._nodeAttr2:updateView(AttributeConst.HP, attrInfo[AttributeConst.HP], nil, 4)
	self._nodeAttr3:updateView(AttributeConst.PD, attrInfo[AttributeConst.PD], nil, 4)
	self._nodeAttr4:updateView(AttributeConst.MD, attrInfo[AttributeConst.MD], nil, 4)
	--调整字号大小
	self._nodeAttr1:getChildByName("TextName"):setFontSize(18)
	self._nodeAttr1:getChildByName("TextValue"):setFontSize(18)
	self._nodeAttr2:getChildByName("TextName"):setFontSize(18)
	self._nodeAttr2:getChildByName("TextValue"):setFontSize(18)

	self._nodeAttr3:getChildByName("TextName"):setFontSize(18)
	self._nodeAttr3:getChildByName("TextValue"):setFontSize(18)
	self._nodeAttr4:getChildByName("TextName"):setFontSize(18)
	self._nodeAttr4:getChildByName("TextValue"):setFontSize(18)

	-- if not heroUnitData:isUserHero() then
	-- 	local size = self._panelBg:getContentSize()
	-- 	size.height = size.height - 54
	-- 	self._panelBg:setContentSize(size)
	-- 	local posY = self._node:getPositionY()
	-- 	self._node:setPositionY(posY - 54)
	-- end

	-- local contentSize = self._panelBg:getContentSize()
	-- self:setContentSize(contentSize)
	-- self._buttonAdvance:setVisible(heroUnitData:isUserHero())
	-- 新需求
	if true then
		local size = self._panelBg:getContentSize()
		size.height = size.height - 54
		self._panelBg:setContentSize(size)
		local posY = self._node:getPositionY()
		self._node:setPositionY(posY - 54)
	end

	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)
	self._buttonAdvance:setVisible(false)
end

function HeroDetailWeaponModule:_onClickIcon1()
	local itemParam1 = self._fileNodeIcon:getItemParams()
	local PopupItemGuider = require("app.ui.PopupItemGuider").new(Lang.get("way_type_get"))
	PopupItemGuider:updateUI(TypeConvertHelper.TYPE_EQUIPMENT, itemParam1.cfg.id)
	PopupItemGuider:openWithAction()
end

function HeroDetailWeaponModule:_onButtonAdvanceClicked()
	G_SceneManager:showScene(
		"instrumentTrain",
		self._instrumentId,
		InstrumentConst.INSTRUMENT_TRAIN_ADVANCE,
		InstrumentConst.INSTRUMENT_RANGE_TYPE_2
	)
end

-- i18n pos lable
function HeroDetailWeaponModule:_dealPosByI18n()
	 
	-- if not Lang.checkLang(Lang.CN) then
	-- 	local UIHelper  = require("yoka.utils.UIHelper")
	-- 	self._node:setPositionX(
	-- 		self._node:getPositionX()-10
	-- 	)
	-- 	self._nodeTitle:setPositionX(
	-- 		self._nodeTitle:getPositionX()+10
	-- 	)

	-- 	self._nodeDesc:setPositionY(
	-- 		self._nodeDesc:getPositionY()+8
	-- 	)
	-- end
end

-- i18n pos lable
function HeroDetailWeaponModule:_dealByI18n()
	  
	-- if not Lang.checkLang(Lang.CN) then
	-- 	local UIHelper  = require("yoka.utils.UIHelper")
	-- 	local image1 = UIHelper.seekNodeByName(self._node,"Image_5")
	-- 	image1:setVisible(false)
	-- end
end

return HeroDetailWeaponModule
