--
-- Author: liushiyin
-- 装备详情 精炼模块
local ListViewCellBase = require("app.ui.ListViewCellBase")
local EquipDetailJadeNode = class("EquipDetailJadeNode", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local EquipTrainHelper = require("app.scene.view.equipTrain.EquipTrainHelper")
local EquipConst = require("app.const.EquipConst")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")

function EquipDetailJadeNode:ctor(equipData, rangeType)
	self._equipData = equipData
	self._rangeType = rangeType or EquipConst.EQUIP_RANGE_TYPE_1

	local resource = {
		file = Path.getCSB("EquipDetailDynamicModule2", "equipment"),
		binding = {}
	}
	EquipDetailJadeNode.super.ctor(self, resource)
end

function EquipDetailJadeNode:onCreate()
	local title = self:_createTitle()
	self._listView:pushBackCustomItem(title)

	self:_addAttrDes()

	self._listView:doLayout()
	local contentSize = self._listView:getInnerContainerSize()
	contentSize.height = contentSize.height 
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)
end

function EquipDetailJadeNode:_createTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg2", "common"))
	title:setFontSize(22)
	title:setTitle(Lang.get("equipment_detail_title_jade"))
	local widget = ccui.Widget:create()
	local titleSize = cc.size(self._listView:getContentSize().width, 50)
	widget:setContentSize(titleSize)
	title:setPosition(titleSize.width / 2, 30)
	widget:addChild(title)

	return widget
end

function EquipDetailJadeNode:_addAttrDes()
	local attrInfo = EquipTrainHelper.getEquipJadeAttr(self._equipData)
	if #attrInfo > 0 then
		local flag = 0
		local index = 1
		for i, data in pairs(attrInfo) do
			if data.isSuitable then
				self:_appendAttr(index, data)
				index = index + 1
				flag = 1
			end
		end
		if flag == 0 then
			self:_noAttrTip(Lang.get("jade_inject_not_effective"))
		end
	else
		self:_noAttrTip(Lang.get("jade_no_inject_jade"))
	end
end

function EquipDetailJadeNode:_appendAttr(index, data)
	local widget = ccui.Widget:create()
	local k, value = data.type, data.value
	local name = nil
	if data.property == 1 then
		name, value = Lang.get("jade_texing"), data.description
	else
		name, value = TextHelper.getAttrBasicText(k, value)
	end
	name = TextHelper.expandTextByLen(name, 4)
	local node = CSHelper.loadResourceNode(Path.getCSB("CommonDesValue", "common"))
	node:setFontSize(18)	
	local textDes = ccui.Helper:seekNodeByName(node, "TextDes")
	local textValue = ccui.Helper:seekNodeByName(node, "TextValue")
	textValue:setFontSize(16)
 
	-- 无法调用 原组件  或者重定义组件
	if not Lang.checkLang(Lang.CN) then
		node:updateUI(name .. ": ", value)
	else
		node:updateUI(name .. "：", value)
	end	
	local height = 30
	if data.property == 1 then
		local h = node:setValueToRichText(value, 326-60)
		height = h > height and h or height
		node:setPosition(10, height - 30)
		if node:getRichText() then
			local rich = node:getRichText()
			rich:setPositionY(rich:getPositionY() - 1)  
			rich:setScale(0.8)
			height = height - 25
		end
	else
		node:setPosition(10, 20)
	end
	widget:addChild(node)
	widget:setContentSize(cc.size(self._listView:getContentSize().width, height))
	self._listView:pushBackCustomItem(widget)
end

-- 没有任何属性时的提示
function EquipDetailJadeNode:_noAttrTip(text)
	local UIHelper = require("yoka.utils.UIHelper")
	local widget = ccui.Widget:create()
	local label = cc.Label:createWithTTF(text, Path.getCommonFont(), 18)
	label:setAnchorPoint(cc.p(0, 1))
	label:setLineHeight(22)
	label:setPosition(10, 26)
	label:setColor(Colors.BRIGHT_BG_TWO)
	label:setWidth(self._listView:getContentSize().width-20)
	widget:addChild(label)
	widget:setContentSize(cc.size(self._listView:getContentSize().width, 26))
	self._listView:pushBackCustomItem(widget)
end


return EquipDetailJadeNode
