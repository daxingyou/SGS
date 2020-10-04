--
-- Author: Liangxu
-- Date: 2017-05-12 13:40:36
-- 通用材料

local CommonCostNode = class("CommonCostNode")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")

local EXPORTED_METHODS = {
    "updateView",
    "isReachCondition",
	"getNeedCount",
	"getMyCount",
}

function CommonCostNode:ctor()
	self._target = nil
	self._fileNodeIcon = nil
	self._textName = nil
	self._nodeNumPos = nil
	self._addSprite = nil
end

function CommonCostNode:_init()

	self._fileNodeIcon = ccui.Helper:seekNodeByName(self._target, "FileNodeIcon")
	cc.bind(self._fileNodeIcon, "CommonIconTemplate")
	self._textName = ccui.Helper:seekNodeByName(self._target, "TextName")
	self._nodeNumPos = ccui.Helper:seekNodeByName(self._target, "NodeNumPos")

	-- i18n pos lable
	self:_dealPosI18n()
end

function CommonCostNode:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonCostNode:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonCostNode:updateView(data, filterId)
	self._fileNodeIcon:initUI(data.type, data.value, data.size)
	self._fileNodeIcon:showCount(false)
	self._fileNodeIcon:setTouchEnabled(true)
	self._fileNodeIcon:setCallBack(handler(self, self._onClickIcon))

	local param = TypeConvertHelper.convert(data.type, data.value)
	self._textName:setString(param.name)
	self._textName:setColor(param.icon_color)
	require("yoka.utils.UIHelper").updateTextOutlineByGold(self._textName, param)

	self._myCount = UserDataHelper.getSameCardCount(data.type, data.value, filterId) --我拥有的同名卡数量
	dump(self._myCount)
	self._needCount = data.size --同名卡数量
	
	local color = self._myCount < self._needCount and Colors.colorToNumber(Colors.uiColors.RED) or Colors.colorToNumber(Colors.uiColors.GREEN)
	self._isReachCondition = self._myCount >= self._needCount
	self._fileNodeIcon:setIconMask(not self._isReachCondition)
	if not self._isReachCondition then
		if self._addSprite == nil then
			self._addSprite = cc.Sprite:create(Path.getUICommon("img_com_btn_add01"))
			self._fileNodeIcon:addChild(self._addSprite)
			local UIActionHelper = require("app.utils.UIActionHelper")
	   		UIActionHelper.playBlinkEffect(self._addSprite)
		end
	else
		if self._addSprite then
			self._addSprite:removeFromParent()
			self._addSprite = nil
		end
	end
	local content = Lang.get("treasure_refine_cost_count", {
		value1 = self._myCount,
		color = color,
		value2 = self._needCount,
	})
	local richText = nil
	-- i18n pos lable
	if not Lang.checkLang(Lang.CN) then
		-- i18n richtext 
		if Lang.checkLang(Lang.CN) then
			richText = ccui.RichText:create()
		else
			richText = ccui.RichText:createByI18n()
		end
		
		local jsonContent = json.decode(content)
    	assert(jsonContent, "Invalid json string: "..tostring(content))
		for k,v in ipairs(jsonContent) do
			v.fontSize = v.fontSize-3
		end
		richText:setRichText(jsonContent)
	else
		richText = ccui.RichText:createWithContent(content)
	end
	richText:setAnchorPoint(cc.p(0.0, 1.0))
	self._nodeNumPos:removeAllChildren()
	self._nodeNumPos:addChild(richText)
end

--是否满足条件
function CommonCostNode:isReachCondition()
	return self._isReachCondition
end

function CommonCostNode:getNeedCount()
	return self._needCount
end

function CommonCostNode:getMyCount()
	return self._myCount
end

--宝物加入物品获取途径 by hedili
function CommonCostNode:_onClickIcon()
	local itemParam = self._fileNodeIcon:getItemParams()
	local PopupItemGuider = require("app.ui.PopupItemGuider").new()
	PopupItemGuider:updateUI(itemParam.item_type, itemParam.cfg.id)
	PopupItemGuider:openWithAction()
end

-- i18n pos lable
function CommonCostNode:_dealPosI18n()
	if not Lang.checkLang(Lang.CN) then
		local textName = ccui.Helper:seekNodeByName(self._target, "TextName")
		textName:setFontSize( textName:getFontSize()-3)
		textName:setAnchorPoint(cc.p(0,1))
		textName:setPositionY(34)
		textName:getVirtualRenderer():setMaxLineWidth(108)

	end
    if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
		local textName = ccui.Helper:seekNodeByName(self._target, "TextName")
		textName:setPositionY(40)
		textName:setFontSize(20)
		if Lang.checkLang(Lang.EN) then
			textName:setFontSize(16)
		end
	end
end
	
return CommonCostNode