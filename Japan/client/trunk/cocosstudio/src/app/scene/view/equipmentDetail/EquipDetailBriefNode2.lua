--
-- Author: Liangxu
-- Date: 2017-04-13 13:33:01
-- 武将详情 描述
local ListViewCellBase = require("app.ui.ListViewCellBase")
local EquipDetailBriefNode = class("EquipDetailBriefNode", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")

function EquipDetailBriefNode:ctor(equipData)
	self._equipData = equipData

	local resource = {
		file = Path.getCSB("EquipDetailDynamicModule2", "equipment"),
		binding = {

		}
	}
	EquipDetailBriefNode.super.ctor(self, resource)
end

function EquipDetailBriefNode:onCreate()
	local title = self:_createTitle()
	self._listView:pushBackCustomItem(title)

	local des = self:_createDes()
	self._listView:pushBackCustomItem(des)

	self._listView:doLayout()
	local contentSize = self._listView:getInnerContainerSize()
	self._listView:setContentSize(contentSize)
	self:setContentSize(contentSize)
end

function EquipDetailBriefNode:_createTitle()
	local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg2", "common"))
	title:setFontSize(24)
	title:setTitle(Lang.get("equipment_detail_title_brief"))
	local widget = ccui.Widget:create()
	local titleSize = cc.size(self._listView:getContentSize().width, 50) 
	widget:setContentSize(titleSize)
	title:setPosition(titleSize.width / 2, 30)
	widget:addChild(title)

	title:setFontSize(22)
	return widget
end

 

function EquipDetailBriefNode:_createDes()
	local briefDes = self._equipData:getConfig().description
	local color = Colors.BRIGHT_BG_TWO

	local widget = ccui.Widget:create()  
	local labelDes = cc.Label:createWithTTF(briefDes, Path.getCommonFont(), 18)
	labelDes:setAnchorPoint(cc.p(0, 1))
	labelDes:setLineHeight(26)
	labelDes:setWidth(354)
	labelDes:setWidth(self._listView:getContentSize().width-20)
	labelDes:setColor(color)

	local height = labelDes:getContentSize().height
	labelDes:setPosition(cc.p(10, height + 15))
	widget:addChild(labelDes)

	local size = cc.size(self._listView:getContentSize().width, height + 20)
	widget:setContentSize(size)

	return widget
end

return EquipDetailBriefNode
