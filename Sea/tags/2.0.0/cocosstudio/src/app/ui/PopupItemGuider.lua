--弹出界面
--购买一次确认框
--可以更新ICON，以及消耗的物品
local PopupBase = require("app.ui.PopupBase")
local PopupItemGuider = class("PopupItemGuider", PopupBase)
local Path = require("app.utils.Path")

local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper	= require("app.utils.UserDataHelper")

local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
local PopupItemGuiderCell = require("app.ui.PopupItemGuiderCell")

function PopupItemGuider:ctor(title, callback )
	--
	self._title = title or Lang.get("way_type_get") 
	self._callback = callback
	self._buyItemId = nil

	--control init
	self._listItemSource = nil
	self._itemDesc 		 = nil
	self._iconTemplate   = nil
	self._commonNodeBk   = nil
	self._textOwnNum     = nil --拥有数量
	self._textTitleOwn = nil
	self._fileNodeEmpty = nil
	--

	self._itemType = nil
	self._itemValue = nil
	local resource = {
		file = Path.getCSB("PopupItemGuider", "common"),
		binding = {
		
		}
	}
	self:setName("PopupItemGuider")
	PopupItemGuider.super.ctor(self, resource, true)
end

--
function PopupItemGuider:onCreate()
	self:_dealByI18n()
	self:_dealPosByI18n()
	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._commonNodeBk:setTitle(self._title)
	self._nodeOwnNum:setFontSize(20)

	self._scrollViewSize = self._scrollView:getContentSize()
end

--

function PopupItemGuider:_refreshView()
	local itemType = self._itemType 
	local itemValue = self._itemValue 
	assert(itemValue, "PopupItemGuider's itemId can't be empty!!!")
	self._iconTemplate:unInitUI()
	self._iconTemplate:initUI(itemType, itemValue)
	self._iconTemplate:setTouchEnabled(false)

	local itemParams = self._iconTemplate:getItemParams()
	self._itemName:setString(itemParams.name)
	self._itemName:setColor(itemParams.icon_color)
	require("yoka.utils.UIHelper").updateTextOutline(self._itemName, itemParams)
	if itemParams.description then
		self._itemDesc:setString(itemParams.description)
	else
		self._itemDesc:setString(" ")
	end
	local desRender = self._itemDesc:getVirtualRenderer()
	if Lang.checkLang(Lang.TH) then
		desRender:setLineSpacing(6)
		desRender:setLineBreakWithoutSpace(true)
	end
	desRender:setWidth(415)
	local desSize = desRender:getContentSize()
	if desSize.height < self._scrollViewSize.height then
		desSize.height = self._scrollViewSize.height
	end
	self._itemDesc:setContentSize(desSize)
	self._scrollView:getInnerContainer():setContentSize(desSize)
	self._scrollView:jumpToTop()

	local guiderList = WayFuncDataHelper.getGuiderList(itemType, itemValue)

	local WayTypeInfo = require("app.config.way_type")
	local info = WayTypeInfo.get(itemType,itemValue)
	assert(info,string.format("way_type can't find type = %d and value = %d",itemType,itemValue))
	if info.num_type == 1 then--显示数量
		local itemNum = UserDataHelper.getNumByTypeAndValue(itemType, itemValue)
		self._textOwnNum:setString(""..itemNum)
		--self._textTitleOwn:setVisible(true)
		self._nodeOwnNum:setVisible(true)
		--判断是否碎片 type=1，2，3，4，8 也显示碎片
		if itemParams.fragment_id then--itemType == TypeConvertHelper.TYPE_FRAGMENT
			local fragmentNum = UserDataHelper.getNumByTypeAndValue(TypeConvertHelper.TYPE_FRAGMENT,  itemParams.fragment_id)
			local fragmentParams = TypeConvertHelper.convert( TypeConvertHelper.TYPE_FRAGMENT, itemParams.fragment_id)
			local maxCount = fragmentParams.cfg.fragment_num
			local isEnough = fragmentNum >= maxCount
			self._nodeOwnNum:updateUI(Lang.get("common_curr_have_fragment"), fragmentNum, maxCount,0)
			self._nodeOwnNum:setValueColor(isEnough and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_RED)
			self._nodeOwnNum:setMaxColor(Colors.BRIGHT_BG_ONE)
			self._nodeOwnNum:setDesColor(Colors.BRIGHT_BG_TWO)
		else
			self._nodeOwnNum:updateUI(Lang.get("common_curr_have"), itemNum,nil,0)
			self._nodeOwnNum:setValueColor(Colors.BRIGHT_BG_GREEN)	
			self._nodeOwnNum:setDesColor(Colors.BRIGHT_BG_TWO)
		end
	else
		--self._textTitleOwn:setVisible(false)
		self._nodeOwnNum:setVisible(false)
	end

	if not Lang.checkLang(Lang.CN) then
		self._nodeOwnNum:setPositionX(self._itemName:getPositionX()+self._itemName:getContentSize().width + 10)
	end

	self._guiderList = guiderList

	local listView = self._listItemSource
	listView:setTemplate(PopupItemGuiderCell)
	listView:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	listView:setCustomCallback(handler(self, self._onItemTouch))
	listView:resize(#guiderList)


	self._fileNodeEmpty:setVisible(#guiderList <= 0)

end

function PopupItemGuider:updateUI(itemType, itemValue)
	self._itemType = itemType
	self._itemValue = itemValue
end



function PopupItemGuider:_onItemTouch(index)

end



function PopupItemGuider:_onItemUpdate(item, index)
	local itemGuider = self._guiderList[ index + 1 ] 
	if itemGuider then
		item:updateUI(index, itemGuider )
	end
end

function PopupItemGuider:_onItemSelected(item, index)

end


function PopupItemGuider:_onInit()

end


function PopupItemGuider:onEnter()
    if self._itemType and self._itemValue then
		self:_refreshView()
	end
end

function PopupItemGuider:onExit()
    
end

--
function PopupItemGuider:onBtnOk()
	local isBreak
	if self._callback then
		isBreak = self._callback(self._buyItemId)
	end
	if not isBreak then
		self:close()
	end
end


function PopupItemGuider:onBtnCancel()
	if not isBreak then
		self:close()
	end
end

-- i18n change lable
function PopupItemGuider:_dealByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		local textNoItems = UIHelper.seekNodeByName(self._fileNodeEmpty,"Text_no_items")
		textNoItems:setString( Lang.getImgText("item_guider_empty") )
	end
end
-- i18n change lable
function PopupItemGuider:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
        self._nodeOwnNum:setPositionX(self._nodeOwnNum:getPositionX()+8)
		self._textTitleOwn:setPositionX(self._textTitleOwn:getPositionX()+8)
	end
end


return PopupItemGuider