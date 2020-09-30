--
-- Author: Liangxu
-- Date: 2017-04-12 17:24:17
-- 武将详情 套装模块
local ListViewCellBase = require("app.ui.ListViewCellBase")
local EquipDetailSuitNode = class("EquipDetailSuitNode", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local EquipDetailSuitIcon = require("app.scene.view.equipmentDetail.EquipDetailSuitIcon")
local TextHelper = require("app.utils.TextHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local FunctionConst = require("app.const.FunctionConst")

function EquipDetailSuitNode:ctor(unitData, isNeedLimit, fromLimit)
	self._suitId = 0
	self._unitData = unitData
	self._isNeedLimit = isNeedLimit or false
	self._fromLimit = fromLimit or false

	self._textName = nil --套装名称
	self._fileNodeIcon1 = nil --Icon1
	self._fileNodeIcon2 = nil --Icon2
	self._fileNodeIcon3 = nil --Icon3
	self._fileNodeIcon4 = nil --Icon4
	self._textTitle1 = nil --装备2件
	self._textTitle2 = nil --装备3件
	self._textTitle3 = nil --装备4件
	self._textValue1_1 = nil --装备2件属性1
	self._textValue1_2 = nil --装备2件属性2
	self._textValue2_1 = nil --装备3件属性1
	self._textValue2_2 = nil --装备3件属性2
	self._textValue3_1 = nil --装备4件属性1
	self._textValue3_2 = nil --装备4件属性2

	local resource = {
		file = Path.getCSB("EquipDetailSuitNode2", "equipment"),
		binding = {
 
		}
	}

 
	EquipDetailSuitNode.super.ctor(self, resource)
end

function EquipDetailSuitNode:onCreate()
	local size = self._panelBg:getContentSize()
	self:setContentSize(size.width, size.height)

	self._nodeTitle:setTitle(Lang.get("equipment_detail_title_suit"))
	self._nodeTitle:setFontSize(22)
	self._equipIcons = {}
	for i = 1, 4 do
		local icon = EquipDetailSuitIcon.new(self["_fileNodeIcon" .. i])
		table.insert(self._equipIcons, icon)
	end

	self:_updateView()
 
 
	--i18n
	self:_dealByI18n()
end

function EquipDetailSuitNode:_updateView()
	local suitId = self._unitData:getConfig().suit_id
	for i = 1, 3 do
		for j = 1, 2 do
			if self["_textValue" .. i .. "_" .. j] then
				self["_textValue" .. i .. "_" .. j]:setVisible(false)
			end
		end
	end

	local colorParam = nil

	local componentCount = 0
	local componentIds = UserDataHelper.getSuitComponentIds(suitId)
	for i, id in ipairs(componentIds) do
		local icon = self._equipIcons[i]
		local pos = self._unitData:getPos() --G_UserData:getTeam():getCurPos()
		local isHave = UserDataHelper.isHaveEquipInPos(id, pos)
		local needMask = not isHave
		icon:updateView(id, needMask)
		if not needMask and not self._fromLimit then
			componentCount = componentCount + 1
		end

		if colorParam == nil then
			colorParam = {}
			local equipParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_EQUIPMENT, id)
			colorParam.icon_color = equipParam.icon_color
			colorParam.icon_color_outline = equipParam.icon_color_outline
		end
	end

	--名字
	local name = UserDataHelper.getSuitName(suitId)
	self._textName:setString(name)
	self._textName:setColor(colorParam.icon_color)
	self._textName:enableOutline(colorParam.icon_color_outline) 

	--属性
	local attrInfo = UserDataHelper.getSuitAttrShowInfo(suitId)
	for i, one in ipairs(attrInfo) do
		local count = one.count
		local colorName = componentCount >= count and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_TWO
		local colorAttr = componentCount >= count and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_TWO
		self["_textTitle" .. i]:setString(Lang.get("equipment_detail_suit_count", {count = count}))
		self["_textTitle" .. i]:setColor(colorName) 
 
		local info = one.info
		for j, data in ipairs(info) do
			local name, value = TextHelper.getAttrBasicText(data.type, data.value)
			local text = self["_textValue" .. i .. "_" .. j]
			if text then
				text:setString(Lang.get("equipment_detail_suit_attr", {name = name, value = value}))
				text:setColor(colorAttr)
				text:setVisible(true)
			end
		end
	end


	if not Lang.checkLang(Lang.CN) then
		self:_updateAttrPosByI18n()
	end
end

function EquipDetailSuitNode:setIconMask(needMask)
	for i, icon in ipairs(self._equipIcons) do
		icon:setIconMask(needMask)
	end
end

--i18n
function EquipDetailSuitNode:_dealByI18n()
	if Lang.checkChannel(Lang.JA) then 
		self._textName:setPositionY(self._textName:getPositionY()+10)
		for i = 1, 4 do
			self["_fileNodeIcon"..i]:setPositionY(self["_fileNodeIcon"..i]:getPositionY()+15)
		end

		if self._buttonLimit then  
			self._buttonLimit:setPositionY(self._buttonLimit:getPositionY()+20)
		end
		
		for i = 1, 3 do
			self["_textTitle"..i]:setPositionY(self["_textTitle"..i]:getPositionY()+20)
			for j = 1, 2 do
				self["_textValue" .. i .. "_" .. j]:setPositionY(self["_textValue" .. i .. "_" .. j]:getPositionY()+20)
			end
		end
		self["_textValue3_2"]:setPosition(self["_textValue3_1"]:getPositionX(),self["_textValue3_2"]:getPositionY()-30)
	end
end

--i18n
function EquipDetailSuitNode:_updateAttrPosByI18n()
	if Lang.checkChannel(Lang.JA) then 
		for i = 1, 3 do
			local preNode = self["_textTitle"..i]
			for j = 1, 2 do
				self["_textValue" .. i .. "_" .. j]:setPositionX(preNode:getPositionX()+preNode:getContentSize().width + 3 )
				preNode = self["_textValue" .. i .. "_" .. j]
			end
		end
	end
end

return EquipDetailSuitNode
