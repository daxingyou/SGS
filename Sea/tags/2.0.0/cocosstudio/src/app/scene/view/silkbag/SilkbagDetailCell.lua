--
-- Author: Liangxu
-- Date: 2018-3-9 14:15:11
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local SilkbagDetailCell = class("SilkbagDetailCell", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local SilkbagConst = require("app.const.SilkbagConst")
local TextHelper = require("app.utils.TextHelper")
local ParameterIDConst = require("app.const.ParameterIDConst")

function SilkbagDetailCell:ctor()
	local resource = {
		file = Path.getCSB("SilkbagDetailCell", "silkbag"),
		binding = {
			
		}
	}
	SilkbagDetailCell.super.ctor(self, resource)
end

function SilkbagDetailCell:onCreate()
	-- i18n pos lable
	self:_dealPosByI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end

function SilkbagDetailCell:update(data)
	local silkbagId = data.silkbagId
	local isEffective = data.isEffective
	local unitData = G_UserData:getSilkbag():getUnitDataWithId(silkbagId)
	local info = unitData:getConfig()

	local nameTemp = Lang.get("silkbag_name_title", {name = info.name})
	local nameStr = info.only == SilkbagConst.ONLY_TYPE_1 and Lang.get("silkbag_only_tip", {name = nameTemp}) or nameTemp
	local baseId = unitData:getBase_id()
	local params = self._fileNodeIcon:updateUI(baseId)
	self._textName:setString(nameStr)
	self._textName:setColor(params.icon_color)
	--i18n 同步2.7 添加描边
	if Lang.checkLang(Lang.TH) then
		require("yoka.utils.UIHelper").updateTextOutline(self._textName, params)
	else
		require("yoka.utils.UIHelper").updateTextOutlineByGold(self._textName, params)
	end
	local markRes = isEffective and Path.getTextSignet("img_silkbag01") or Path.getTextSignet("img_silkbag02")
	self._imageMark:loadTexture(markRes)

	local desColor = isEffective and Colors.SYSTEM_TARGET or Colors.SYSTEM_TARGET_RED
	local description = info.description
	if info.type1 > 0 then --计算属性描述
		local tempLevel = tonumber(require("app.config.parameter").get(ParameterIDConst.SILKBAG_START_LV).content)
		description = ""
		local userLevel = G_UserData:getBase():getLevel()
		for i = 1, 2 do
			local attrId = info["type"..i]
			if attrId > 0 then
				local size = info["size"..i]
				local growth = info["growth"..i]
				local ratio = math.max(userLevel-tempLevel, 0)
				local attrValue = size + (growth * ratio)
				local name, value = TextHelper.getAttrBasicText(attrId, attrValue)
				description = description..name.."+"..value
			end
		end
	end
	
	self._textDes:setString(description)
	self._textDes:setColor(desColor)
end

function SilkbagDetailCell:update2(data)
	self._fileNodeIcon:updateUI(data.baseId)
	local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_SILKBAG, data.baseId)
	self._textName:setString(param.name)
	self._textName:setColor(param.icon_color)
	if Lang.checkLang(Lang.TH) then
		--i18n 同步2.7 添加描边
		require("yoka.utils.UIHelper").updateTextOutline(self._textName, param)
	end

	local markRes = data.isEffective and Path.getTextSignet("img_silkbag01") or Path.getTextSignet("img_silkbag02")
	local desColor = data.isEffective and Colors.SYSTEM_TARGET or Colors.SYSTEM_TARGET_RED
	self._textDes:setString(param.description)
	self._textDes:setColor(desColor)
	self._imageMark:setVisible(false)
end


-- i18n pos lable
function SilkbagDetailCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._textDes:setFontSize(self._textDes:getFontSize()-2)
	end
	if Lang.checkLang(Lang.TH) then
		self._textDes:getVirtualRenderer():setLineBreakWithoutSpace(true)
		self._textDes:getVirtualRenderer():setLineSpacing(6)
	end
end

return SilkbagDetailCell