
-- Author: hedili
-- Date:2018-05-08 14:00:07
-- Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupHomelandMaterialCellLine = class("PopupHomelandMaterialCellLine", ListViewCellBase)
local PopupHomelandMaterialIcon = import(".PopupHomelandMaterialIcon")

local HomelandHelp = require("app.scene.view.homeland.HomelandHelp")

function PopupHomelandMaterialCellLine:ctor(data)

	--csb bind var name
	self._itemList = nil
	self._textTreeName = nil
	self._data = data

	local resource = {
		file = Path.getCSB("PopupHomelandMaterialCellLine", "homeland"),
		binding = {

		},
	}
	PopupHomelandMaterialCellLine.super.ctor(self, resource)
end

function PopupHomelandMaterialCellLine:onCreate()
	self:_dealPosByI18n()
	-- body
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	
	self:_updateData()

	if Lang.checkHorizontal() then
		local UIHelper  = require("yoka.utils.UIHelper")
		local Image_level = UIHelper.seekNodeByName(self._nodeTree,"Image_level")
		Image_level:setPosition(132,90)
	end
end


--[[
	item.name = cfgData.name
	item.lv = Lang.get("homeland_level_desc",{num1 =i, num2=i+1})
	item.itemList = {}
]]

function PopupHomelandMaterialCellLine:_updateNodeTitle( ... )
	-- body
	local cfgData = self._data.cfg

	local nodeTree = self._nodeTree
	nodeTree:updateImageView("Image_tree", {texture = Path.getHomelandUI(cfgData.detail_draw)})

	--更新树名称
	local treeData = {
		treeLevel = cfgData.level,
		treeId = cfgData.type
	}
	local Node_treeTitle = self:getSubNodeByName("Node_treeTitle")
	if  Lang.checkUI("ui4") then  
		local  nodeTreeParent = Node_treeTitle:getParent()
		local posx,posy = Node_treeTitle:getPosition()
		Node_treeTitle:removeFromParent(true)
		local UIHelper  = require("yoka.utils.UIHelper")
		local node = require("app.scene.view.homeland.HomelandNodeTreeTitle").new(treeData,"materialcell")
		Node_treeTitle = UIHelper.seekNodeByName(node,"Node_treeTitle")
		Node_treeTitle:retain()
		Node_treeTitle:removeFromParent(true)
		nodeTreeParent:addChild(Node_treeTitle)
		Node_treeTitle:setPosition(cc.p(posx,posy))
		Node_treeTitle:release()
	else
		HomelandHelp.updateNodeTreeTitle(self, treeData)
	end

end


function PopupHomelandMaterialCellLine:_updateData( ... )
	-- body
	if  self._data == nil then
		return
	end

	self:_updateNodeTitle()

	local iconSize = 150
	for i, value in ipairs(self._data.list) do
		local itemIcon = PopupHomelandMaterialIcon.new(value,i)
		iconSize = itemIcon:getContentSize().width + 2
		self._itemList:pushBackCustomItem(itemIcon)
	end
	local totalSize = iconSize * #self._data.list
	self._itemList:doLayout()

	if totalSize  > 764 then
		self._itemList:setContentSize(cc.size(764,113))
		self._itemList:setTouchEnabled(true)
	else
		self._itemList:setContentSize(cc.size(totalSize,113))
		self._itemList:setTouchEnabled(false)
	end
	
end

function PopupHomelandMaterialCellLine:_dealPosByI18n()
	if Lang.checkHorizontal() then
		local UIHelper  = require("yoka.utils.UIHelper")
		local nodeTreeTitle = UIHelper.seekNodeByName(self._nodeTree,"Node_treeTitle")
		nodeTreeTitle:setPosition(70,35)
	elseif not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local nodeTreeTitle = UIHelper.seekNodeByName(self._nodeTree,"Node_treeTitle")
		nodeTreeTitle:setPositionX(	nodeTreeTitle:getPositionX() + 10 )
	end
end






return PopupHomelandMaterialCellLine