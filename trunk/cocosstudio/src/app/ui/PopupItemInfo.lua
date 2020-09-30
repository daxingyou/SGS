--弹出界面
--物品信息弹框
--点击物品时，弹出
local PopupBase = require("app.ui.PopupBase")
local PopupItemInfo = class("PopupItemInfo", PopupBase)
local Path = require("app.utils.Path")

local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")

local ICON_NORMAL_X = 78.21 -- 正常位置
local ICON_TITLE_X = 55 -- 称号位置

local DESC_NORMAL_X = 143
local DESC_TITLE_X = 163

function PopupItemInfo:ctor(title, callback)
	--
	self._title = title or Lang.get("common_title_item_info")
	self._callback = callback
	self._itemId = nil
	self._useNum = 1
	--control init
	self._btnOk = nil --
	self._itemName = nil -- 物品名称
	self._itemDesc = nil -- 物品描述
	self._itemIcon = nil -- CommonItemIcon
	self._itemOwnerDesc = nil --拥有物品
	self._itemOwnerCount = nil --数量
	--
	local filePath =  Path.getCSB("PopupItemInfo", "common")
    --ui4 特殊处理
    if  Lang.checkUI("ui4") then  
        filePath =  Path.getCSB("PopupItemInfo1", "common")
    end
	local resource = {
		file = filePath,
		binding = {
			_btnOk = {
				events = {{event = "touch", method = "onBtnOk"}}
			}
		}
	}
	PopupItemInfo.super.ctor(self, resource, true)
end

--
function PopupItemInfo:onCreate()
	-- i18n pos 
	self:_dealPosByI18n()
	--i18n
	self:_createInfoByI18n()
	-- button
	self._btnOk:setString(Lang.get("common_btn_sure"))

	self._commonNodeBk:addCloseEventListener(handler(self, self.onBtnCancel))
	self._commonNodeBk:setTitle(self._title)
	self._commonNodeBk:hideCloseBtn()
end

function PopupItemInfo:updateUI(itemType, itemId)
	assert(itemId, "PopupItemInfo's itemId can't be empty!!!")
	self._itemIcon:unInitUI()
	self._itemIcon:initUI(itemType, itemId)
	self._itemIcon:setTouchEnabled(false)
	self._itemIcon:setImageTemplateVisible(true)
	local itemParams = self._itemIcon:getItemParams()
	--dump(itemParams)
	if Lang.checkLang(Lang.JA) and itemType == TypeConvertHelper.TYPE_TITLE then
		self._itemName:getVirtualRenderer():setMaxLineWidth(350)
	end
	self._itemName:setString(itemParams.name)
	self._itemName:setColor(itemParams.icon_color)
	
	if itemParams.cfg.color == 7 then    -- 金色物品加描边
		self._itemName:enableOutline(itemParams.icon_color_outline, 2)
	end
    
	if itemType == TypeConvertHelper.TYPE_TITLE or itemType == TypeConvertHelper.TYPE_MAIN_SCENE then
		self._itemIcon:setImageTemplateVisible(false)
		self._itemIcon:setPositionX(ICON_TITLE_X)
		self._itemName:setPositionX(DESC_TITLE_X)
		self._scrollView:setPositionX(DESC_TITLE_X)
		self._itemOwnerDesc:setVisible(false)
		self._itemOwnerCount:setVisible(false)
	elseif itemType == TypeConvertHelper.TYPE_FLAG then
		self._itemIcon:setImageTemplateVisible(false)
	else
		self._itemIcon:setImageTemplateVisible(true)
		if not Lang.checkUI("ui4") then
			self._itemIcon:setPositionX(ICON_NORMAL_X)
			self._itemName:setPositionX(DESC_NORMAL_X)
			self._scrollView:setPositionX(DESC_NORMAL_X)
		end
		self._itemOwnerDesc:setVisible(true)
		self._itemOwnerCount:setVisible(true)
	end
	self._itemDesc:setString(itemParams.cfg.description)
	if Lang.checkUI("ui4") then
		if itemType == TypeConvertHelper.TYPE_MAIN_SCENE then
			local text = itemParams.cfg.description..string.gsub(itemParams.cfg.description_1,"#num#",itemParams.cfg.size_0)
			self._itemDesc:setString(text)
		end
	end
	local desRender = self._itemDesc:getVirtualRenderer()
	desRender:setWidth(272)
	if Lang.checkUI("ui4") then
		if  itemType == TypeConvertHelper.TYPE_TITLE or itemType == TypeConvertHelper.TYPE_MAIN_SCENE then
			desRender:setWidth(350)
		else
			desRender:setWidth(402)
		end
	end
	local scrollViewSize = self._scrollView:getContentSize()
	local desSize = desRender:getContentSize()
	if desSize.height < scrollViewSize.height then
		desSize.height = scrollViewSize.height
		self._scrollView:setTouchEnabled(false)
	else
		self._scrollView:setTouchEnabled(true)
	end
	self._itemDesc:setContentSize(desSize)
	self._scrollView:getInnerContainer():setContentSize(desSize)
	self._scrollView:jumpToTop()

	self._itemId = itemId

	local itemOwnerNum = UserDataHelper.getNumByTypeAndValue(itemType, itemId)
	self:setOwnerCount(itemOwnerNum)
	--i18n
	self:_updateInfoByI18n(itemType)
end

function PopupItemInfo:setOwnerCount(count)
	self._itemOwnerCount:setString("" .. count)
	if Lang.checkUI("ui4") then
		local posDescX = self._itemOwnerCount:getPositionX() - self._itemOwnerCount:getContentSize().width - 10
		self._itemOwnerDesc:setPositionX(posDescX)
	end
end

function PopupItemInfo:_onInit()
end

function PopupItemInfo:onEnter()
end

function PopupItemInfo:onExit()
end

--
function PopupItemInfo:onBtnOk()
	-- i18n ja
	if self._itemType == TypeConvertHelper.TYPE_MAIN_SCENE then
		G_SceneManager:popToRootAndReplaceScene("main",self._itemId)
	end

	local isBreak = nil
	if self._callback then
		isBreak = self._callback(self._itemId)
	end
	if not isBreak then
		self:close()
	end
end

function PopupItemInfo:onBtnCancel()
	self:close()
end

-- 特例 处理神秘奖励
function PopupItemInfo:setSecretUI()
	self._itemIcon:loadIcon(Path.getActivityRes("secretIcon"))
	self._itemOwnerDesc:setVisible(false)
	self._itemOwnerCount:setVisible(false)
	self._itemName:setString(Lang.get("lang_activity_beta_appointment_secret"))
	self._itemDesc:setString(Lang.get("lang_activity_beta_appointment_secret_info"))
end



-- i18n pos lable
function PopupItemInfo:_dealPosByI18n()

	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local size = self._itemDesc:getContentSize()
		self._itemDesc:setTextAreaSize(cc.size(size.width + 70, size.height))
	
		self._itemOwnerDesc:setPositionX(self._itemOwnerDesc:getPositionX()+70)
		self._itemOwnerCount:setPositionX(
			self._itemOwnerDesc:getPositionX()+self._itemOwnerDesc:getContentSize().width
		)
	end

	if Lang.checkUI("ui4") then
		self._itemOwnerDesc:setAnchorPoint(cc.p(1,0.5))
		self._itemOwnerCount:setAnchorPoint(cc.p(1,0.5))
		self._itemOwnerCount:setPositionX(460)
	end
	
end

--i18n
function PopupItemInfo:_createInfoByI18n()
end

--i18n
function PopupItemInfo:_updateInfoByI18n(itemType)
	if Lang.checkUI("ui4") then
		if itemType == TypeConvertHelper.TYPE_MAIN_SCENE then
			self._btnOk:setString(Lang.get("item_info_preview"))
			self._itemType = itemType
		end
	end
end


return PopupItemInfo
