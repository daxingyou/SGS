
-- Author: hedili
-- Date:2018-05-02 15:59:47
-- Describle：主树cell

local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupHomelandUpMainCell = class("PopupHomelandUpMainCell", ListViewCellBase)
local HomelandHelp = require("app.scene.view.homeland.HomelandHelp")

local OFFSET_X = 50
local OFFSET_Y = 60
local OFFSET_MID = 120

function PopupHomelandUpMainCell:ctor()

	--csb bind var name


	local resource = {
		file = Path.getCSB("PopupHomelandUpMainCell", "homeland"),

	}
	PopupHomelandUpMainCell.super.ctor(self, resource)
	self._moveTimes = 0
end

function PopupHomelandUpMainCell:onCreate()
	-- body
-- i18n change lable
	self:_dealI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	local nodeRoot = self:getSubNodeByName("Node_break_attr")
	nodeRoot:setVisible(false)

	for i =1 , 6 do 
		local panelAttr = self:getSubNodeByName("FileNode_attr"..i)
		panelAttr:setVisible(false)
	end
end

function PopupHomelandUpMainCell:updateUI()
	-- body
end


function PopupHomelandUpMainCell:updateUI(cfgData,cfgDataNext)
	self._cfgData = cfgData

	--dump(cfgData)

	self:updateImageView("Image_tree", {texture = Path.getHomelandUI(cfgData.up_resource)})


	--更新树名称
	local treeData = {
		treeLevel = cfgData.id,
		treeId = 0
	}
	self:_dealFormatByI18n(treeData)

	local valueList = self:getValueList(cfgData)
	for index, value in ipairs(valueList) do
		self:_updateAttr(index, value.name, value.value )
	end
	
	if cfgDataNext then
		local nextValueList = HomelandHelp.getMainLevelAttrList(cfgDataNext.id)
		for index, value in ipairs(nextValueList) do
			self:_updateNodeNext(index, "+"..value.value )
		end
	else

	end

end



function PopupHomelandUpMainCell:getValueList( cfgData )
	-- body

	local retList = {}
	for i= 1, cfgData.id do
		local valueList = HomelandHelp.getMainLevelAttrList(i)
		for i, value in ipairs(valueList) do
			local data = retList[i] or {name = "", value = 0}
			data.value = data.value + value.value
			data.name = value.name
			retList[i] = data
		end
	end

	return retList
end

function PopupHomelandUpMainCell:_updateAttr(index, name, value)
	local panelAttr = self:getSubNodeByName("FileNode_attr"..index)
	if panelAttr == nil then
		return
	end
	panelAttr:setVisible(true)
	panelAttr:updateLabel("Text_name",   {text =  name})
	panelAttr:updateLabel("Text_value",  {text =  value, color = Colors.NUMBER_WHITE})

	local Node_next = panelAttr:getSubNodeByName("Node_next")
	Node_next:setVisible(false)
end


function PopupHomelandUpMainCell:_updateNodeNext(index, diff )
	-- body
	local panelAttr = self:getSubNodeByName("FileNode_attr"..index)
	if panelAttr == nil then
		return
	end
	panelAttr:setVisible(true)
	local Text_value = panelAttr:getSubNodeByName("Text_value")
	local Node_next = panelAttr:getSubNodeByName("Node_next")
	Node_next:setVisible(true)
	local TextAddValue = Node_next:getSubNodeByName("TextAddValue")
	TextAddValue:setString(diff)
	TextAddValue:setColor(Colors.NUMBER_GREEN)
end



function PopupHomelandUpMainCell:_updateBreakAttr(index, name, value)
	local panelAttrOld = self:getSubNodeByName("FileNode_attr"..index)
	panelAttrOld:setVisible(false)
	local panelAttr = self:getSubNodeByName("FileNode_break_attr"..index)

	panelAttr:updateLabel("Text_name",   {text =  name })
	panelAttr:updateLabel("Text_value",  {text =  value, color = Colors.NUMBER_WHITE})

	panelAttr:getSubNodeByName("Node_up"):setVisible(false)
end


function PopupHomelandUpMainCell:_updateNextBreakAttr(index, nextValue, addValue)

	local panelAttrOld = self:getSubNodeByName("FileNode_attr"..index)
	panelAttrOld:setVisible(false)

	local panelAttr = self:getSubNodeByName("FileNode_break_attr"..index)

	panelAttr:updateLabel("Text_name",   { visible = false })
	panelAttr:updateLabel("Text_value",  { visible = false })

	panelAttr:getSubNodeByName("Node_up"):setVisible(true)
	panelAttr:updateLabel("Text_next_value",   { text = nextValue })
	panelAttr:updateLabel("Text_add_value",  { text =  addValue  })

end


function PopupHomelandUpMainCell:moveAttrToMid( ... )
	-- body
	if self._moveTimes == 0 then
		for i =1 , 6 do 
			local panelAttr = self:getSubNodeByName("FileNode_attr"..i)
			panelAttr:setPositionX(panelAttr:getPositionX() + OFFSET_MID )
		end
		self._moveTimes = self._moveTimes  + 1 
	end
	
end

--给突破界面用，不会有刷新情况  i18n
function PopupHomelandUpMainCell:updateBreakUIByI18N(cfgData)
	local nodeRoot = self:getSubNodeByName("Node_break_attr")
	nodeRoot:setVisible(false)
	local imageBk = self:getSubNodeByName("Image_bk")
	imageBk:setScale(0.6)
	self:updateImageView("Image_tree", {texture = Path.getHomelandUI(cfgData.up_resource)})
	--更新树名称
	local treeData = {
		treeLevel = cfgData.id,
		treeId = 0
	}
	self:_dealFormatByI18n(treeData)
	local nodeTree = self:getSubNodeByName("Node_treeTitle")
	imageBk:setPositionY(150)
	nodeTree:setPositionY(200)
	nodeTree:setPositionX(nodeTree:getPositionX()+50)

end

--给突破界面用，不会有刷新情况
function PopupHomelandUpMainCell:updateBreakUI(cfgData)
	local nodeRoot = self:getSubNodeByName("Node_break_attr")
	nodeRoot:setVisible(true)

	local nodeTree = self:getSubNodeByName("Node_treeTitle")

	if Lang.checkHorizontal() then
		nodeTree:setPositionY(nodeTree:getPositionY()-215)
	else
		nodeTree:setPositionX(nodeTree:getPositionX() + OFFSET_X )
		nodeTree:setPositionY(nodeTree:getPositionY() - OFFSET_Y )
	end
	

	local imageBk = self:getSubNodeByName("Image_bk")
	imageBk:setScale(0.6)
	


	self:updateImageView("Image_tree", {texture = Path.getHomelandUI(cfgData.up_resource)})
	--更新树名称
	local treeData = {
		treeLevel = cfgData.id,
		treeId = 0
	}
	self:_dealFormatByI18n(treeData)


	local valueList = self:getValueList(cfgData)
	for index, value in ipairs(valueList) do
		self:_updateBreakAttr(index, value.name, value.value )
	end
end


--给突破界面用，不会有刷新情况
function PopupHomelandUpMainCell:updateNextBreakUI( cfgData , nextCfgData)
	local nodeRoot = self:getSubNodeByName("Node_break_attr")
	nodeRoot:setVisible(true)
	local nodeTree = self:getSubNodeByName("Node_treeTitle")
	if Lang.checkHorizontal() then
		nodeTree:setPositionY(nodeTree:getPositionY()-215)
	else
		nodeTree:setPositionX(nodeTree:getPositionX() + OFFSET_X )
		nodeTree:setPositionY(nodeTree:getPositionY() - OFFSET_Y )
	end
	local imageBk = self:getSubNodeByName("Image_bk")
	imageBk:setScale(0.6)

	--dump(cfgData)

	local nextValueList = self:getValueList(nextCfgData)
	local valueList = self:getValueList(cfgData)
	for index, value in ipairs(nextValueList) do
		local diff = value.value- valueList[index].value
		self:_updateNextBreakAttr(index, value.value,diff)
	end


	self:updateImageView("Image_tree", {texture = Path.getHomelandUI(nextCfgData.up_resource)})
	--更新树名称
	local treeData = {
		treeLevel = nextCfgData.id,
		treeId = 0
	}
	self:_dealFormatByI18n(treeData)
end

-- i18n change lable
function PopupHomelandUpMainCell:_dealI18n()
	if Lang.checkHorizontal() then
		local nodeTree = self:getSubNodeByName("Node_treeTitle")
		nodeTree:setPosition(190,360)
	end
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		for i =1 , 6 do
			local panelAttr = self:getSubNodeByName("FileNode_attr"..i)
			local label = panelAttr:getSubNodeByName("Text_value")
			local Text_name = panelAttr:getSubNodeByName("Text_name")
			if not Lang.checkLang(Lang.JA) then
				label:setPositionX(156)
			end
		
			local Text_value = panelAttr:getSubNodeByName("Text_value")
			
			local TextAddValue = panelAttr:getSubNodeByName("TextAddValue")
			Text_value:setFontSize( Text_value:getFontSize()-2 )
			Text_name:setFontSize( Text_name:getFontSize()-2 )
			TextAddValue:setFontSize( TextAddValue:getFontSize()-2 )
		end

		for i = 1 , 6 do
			local panelAttr = self:getSubNodeByName("FileNode_break_attr"..i)
			local label = panelAttr:getSubNodeByName("Text_value")
			if not Lang.checkLang(Lang.JA) then
				label:setPositionX(156)
			end
		end
		
	end
end
function PopupHomelandUpMainCell:_dealFormatByI18n(data)
	local Node_treeTitle = self:getSubNodeByName("Node_treeTitle")

	if  Lang.checkUI("ui4") then  
		local  nodeTreeParent = Node_treeTitle:getParent()
		local posx,posy = Node_treeTitle:getPosition()
		Node_treeTitle:removeFromParent(true)
		local UIHelper  = require("yoka.utils.UIHelper")
		local node = require("app.scene.view.homeland.HomelandNodeTreeTitle").new(data,null)
		Node_treeTitle = UIHelper.seekNodeByName(node,"Node_treeTitle")
		Node_treeTitle:retain()
		Node_treeTitle:removeFromParent(true)
		self._redPoint = UIHelper.seekNodeByName(Node_treeTitle,"_redPoint")
		nodeTreeParent:addChild(Node_treeTitle)
		Node_treeTitle:setPosition(cc.p(posx,posy))
		Node_treeTitle:setName("Node_treeTitle")
		Node_treeTitle:release()
	else
		HomelandHelp.updateNodeTreeTitle(self, data)
	end
end

return PopupHomelandUpMainCell