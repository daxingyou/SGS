-- @Author: Panhoa
-- @Date:2019-1-22
-- @Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local ListCellTabIcon = class("ListCellTabIcon", ListViewCellBase)
local LogicCheckHelper = require("app.utils.LogicCheckHelper")

function ListCellTabIcon:ctor(clickCallBack)
	self._imageTop = nil
	self._imageBottom = nil
	self._resourcePanel = nil
	self._clickCallBack = clickCallBack
	self._txtListPrex = "recovery_tab_title_"
	self._funcConstPre = "FUNC_RECOVERY_TYPE"

	local resource = {
		file = Path.getCSB("RecoveryTableItem", "recovery")
	}
	ListCellTabIcon.super.ctor(self, resource)
end

function ListCellTabIcon:onCreate()
	local size = self._resourcePanel:getContentSize()
	self:setContentSize(size.width, size.height)
	self._resourcePanel:setVisible(false)
end

-- 设置tab文本key前缀
function ListCellTabIcon:setTxtListPrex(txtPrex)
	self._txtListPrex = txtPrex
end

-- 设置tab的function id前缀
function ListCellTabIcon:setFuncionConstPrex(funcPrex)
	self._funcConstPre = funcPrex
end

function ListCellTabIcon:onEnter()
end

function ListCellTabIcon:onExit()
end

function ListCellTabIcon:_updateState(bLast)
	self._resourcePanel:setVisible(true)
	self._nodeTabIcon:setVisible(not bLast)
	self._imageTop:setVisible(not bLast)
	self._imageBottom:setVisible(not bLast)
	self._imageLink:setVisible(not bLast)
end

function ListCellTabIcon:showRedPoint(bShow)
	self["_nodeTabIcon"]:showRedPoint(bShow)
end

function ListCellTabIcon:setSelected(bSelect)
	self["_nodeTabIcon"]:setSelected(bSelect)
end

function ListCellTabIcon:updateUI(bLast, index, value,lastIndex)
	self:_updateState(bLast)
	self:setTag(value)
	lastIndex = lastIndex -1
	

	if bLast then
		self:setContentSize(0,0)
		return
	end


	self._imageTop:setVisible(index == 1)
	self._imageBottom:setVisible(index == lastIndex)
	self._imageLink:setVisible(not (index == lastIndex) )

	if Lang.checkHorizontal() then
		self._imageTop:setVisible(false)
		self._imageBottom:setVisible(false)
		self._imageLink:setVisible(false)

		local size = self._resourcePanel:getContentSize()
		self._resourcePanel:setAnchorPoint(cc.p(0.5,0.5))
		self._resourcePanel:setPosition(size.height*0.5,60*0.5)
		self:setContentSize(size.height  , 60 + 35)
	else


		local size = self._resourcePanel:getContentSize()
		if index == 1 then
			size.height = self._imageTop:getPositionY()
		end

		if index == lastIndex  then
			self._resourcePanel:setPositionY(math.abs(self._imageBottom:getPositionY()))
			self:setContentSize(size.width, size.height + math.abs(self._imageBottom:getPositionY()))
		else
			self._resourcePanel:setPositionY(math.abs(self._imageLink:getPositionY())-6)
			self:setContentSize(size.width, size.height + math.abs(self._imageLink:getPositionY()) -6)
		end
	end

	



	local function clickItem(value)
		if self._clickCallBack then
			self._clickCallBack(value)
		end
	end

	local txt = Lang.get(self._txtListPrex .. value)
	local isOpen = LogicCheckHelper.funcIsOpened(FunctionConst[self._funcConstPre .. value])
	self["_nodeTabIcon"]:updateUI(txt, isOpen, value)
	self["_nodeTabIcon"]:setCallback(clickItem)
end

return ListCellTabIcon
