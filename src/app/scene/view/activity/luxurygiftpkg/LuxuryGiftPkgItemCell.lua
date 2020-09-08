-- Author: conley
local ListViewCellBase = require("app.ui.ListViewCellBase")
local LuxuryGiftPkgItemCell = class("LuxuryGiftPkgItemCell", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local ActivityConst = require("app.const.ActivityConst")
local GIFT_PKG_TITLE_IMG = {"img_onechaozhilibao", "img_sanchaozhilibao", "img_liuchaozhilibao"}

LuxuryGiftPkgItemCell.REWARD_RMB_SCALE = 10 --奖励缩放

function LuxuryGiftPkgItemCell:ctor()
	self._resourceNode = nil --根节点
	self._commonIconTemplate1 = nil --道具Item
	self._commonIconTemplate2 = nil --道具Item
	self._commonButtonMediumNormal = nil --购买按钮
	self._textItemName = nil --礼包名称
	self._nodeCondition1 = nil
	--富文本的父节点
	self._nodeCondition2 = nil
	--富文本的父节点
	self._imageReceive = nil
	--已领取图片
	self._conditionRichTextArr = {}
	--富文本
	self._nodeIcon = nil
	local resource = {
		file = Path.getCSB("LuxuryGiftPkgItemCell", "activity/luxurygiftpkg"),
		binding = {
			_commonButtonMediumNormal = {
				events = {{event = "touch", method = "_onClickBuyBtn"}}
			}
		}
	}
	-- i18n ja change CSB
	if Lang.checkUI("ui4") then
		resource.file = Path.getCSB("VipViewLuxuryGiftPkgItemCell", "vip")
	end
	LuxuryGiftPkgItemCell.super.ctor(self, resource)
end

function LuxuryGiftPkgItemCell:onCreate()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	--i18n change lable
	self:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		self:_dealPosByI18n()
	end

	self._imageReceive:setVisible(false)

	-- self._commonButtonMediumNormal:setString(Lang.get("lang_activity_luxurygiftpkg_buy"))
end

function LuxuryGiftPkgItemCell:_onClickBuyBtn()
	local curSelectedPos = self:getTag()
	logWarn("LuxuryGiftPkgItemCell:_onIconClicked  " .. curSelectedPos)
	self:dispatchCustomCallback(curSelectedPos)
end

--创建领取条件富文本
function LuxuryGiftPkgItemCell:_createConditionRichText(richText, index)
	if self._conditionRichTextArr[index] then
		self._conditionRichTextArr[index]:removeFromParent()
	end
	local widget = ccui.RichText:createWithContent(richText)
	widget:setAnchorPoint(cc.p(0.5, 0.5))
	self["_nodeCondition" .. index]:addChild(widget)
	self._conditionRichTextArr[index] = widget
end

function LuxuryGiftPkgItemCell:updateUI(vipPayCfg, index)
	logWarn(" HHH---------  " .. index)
	local unitDataList = G_UserData:getActivityLuxuryGiftPkg():getUnitDatasByPayType(index)
	local actLuxuryGiftPkgUnitData = unitDataList[1]
	local cfg = actLuxuryGiftPkgUnitData:getConfig()
	local vipConfig = actLuxuryGiftPkgUnitData:getVipConfig()
	local remainBuyTime = actLuxuryGiftPkgUnitData:getRemainBuyTime()
	local enabled = remainBuyTime > 0
	local rewards = UserDataHelper.makeRewards(cfg, 3)
	--最多3个奖励
	local showRewards = UserDataHelper.makeRewards(cfg, 3, "show_")
	--最多2个奖励
	local canReceive = G_UserData:getActivityLuxuryGiftPkg():isCanReceiveGiftPkg()

	if Lang.checkUI("ui4") then
		showRewards = UserDataHelper.makeRewards(cfg, 5, "show_")
	end

	if Lang.checkUI("ui4") then
		self._commonListViewItem2:setMaxItemSize(3)
		self._commonListViewItem2:setItemSpacing(2)
		self._commonListViewItem2:setListViewSize(194,70)
		self._commonListViewItem2:updateUI(rewards, 0.6, false)
		self._commonListViewItem2:alignCenter()
		self._commonListViewItem2:setTextItemCountFontSize(26)

	else
		local commonIconTemplateList = self._nodeIcon:getChildren()
		for k, v in ipairs(commonIconTemplateList) do
			if rewards[k] then
				--v:showCount(false)
				v:setVisible(true)
				v:unInitUI()
				v:initUI(rewards[k].type, rewards[k].value, rewards[k].size)
				v:setTouchEnabled(true)
			else
				v:setVisible(false)
			end
		end
	end
	
	
	if Lang.checkUI("ui4") then
		self._commonListViewItem:setMaxItemSize(3)
		self._commonListViewItem:setItemSpacing(2)
		self._commonListViewItem:setListViewSize(194,70)
		self._commonListViewItem:updateUI(showRewards, 0.6, false)
		self._commonListViewItem:setTextItemCountFontSize(26)
	else
		self._commonListViewItem:setItemSpacing(4)
		self._commonListViewItem:updateUI(showRewards, nil, true)
	end
	self._commonListViewItem:alignCenter()

	self._textItemName:setString(vipConfig.name)
	
	-- i18n change lable
	if not Lang.checkUI("ui4") then
		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local _,currencyStr1 = UIHelper.convertCurrency(vipConfig.rmb)
			currencyStr1 = UIHelper.convertDollar(currencyStr1)
	
			self._imageItemName:setString(Lang.getImgText("luxury_gift_rmb_"..tostring(index),{value = currencyStr1}))
		else
			self._imageItemName:loadTexture(Path.getActivityTextRes(GIFT_PKG_TITLE_IMG[index]))
		end
		
	end
	
	self._commonButtonMediumNormal:setVisible(true)

	local richText =
		Lang.get(
		"lang_activity_luxurygiftpkg_intro_01",
		{
			value = vipConfig.gold
		}
	)
	local LogicCheckHelper = require("app.utils.LogicCheckHelper")
	if LogicCheckHelper.enoughOpenDay(ActivityConst.ACT_DAILY_LIMIT_OPEN_DAY) == false then -- 是否开服天数大于24
		self:_createConditionRichText(richText, 1)
		
		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local _,currencyStr1 = UIHelper.convertCurrency(vipConfig.rmb * LuxuryGiftPkgItemCell.REWARD_RMB_SCALE)
			currencyStr1 = UIHelper.convertDollar(currencyStr1)
			local richText2 = Lang.get("lang_activity_luxurygiftpkg_intro_02",
			{
				value = currencyStr1,
			})
			self:_createConditionRichText(richText2,2)
		else
			local richText2 =
				Lang.get(
				"lang_activity_luxurygiftpkg_intro_02",
				{
					value = vipConfig.rmb * LuxuryGiftPkgItemCell.REWARD_RMB_SCALE
				}
			)
			self:_createConditionRichText(richText2, 2)	
		end

	else
		self:_createRichItems(index)
		-- logWarn("open day more 24")
	end
	
	if not enabled  then
		self._commonButtonMediumNormal:setString(Lang.get("common_already_buy") )
		self._commonButtonMediumNormal:switchToHightLight()
	elseif canReceive then
		self._commonButtonMediumNormal:setString(Lang.get("common_receive"))
		self._commonButtonMediumNormal:switchToHightLight()
	else
		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			local _,currencyStr1 = UIHelper.convertCurrency(  vipConfig.rmb)
			currencyStr1 = UIHelper.convertDollar(currencyStr1)
			self._commonButtonMediumNormal:setString(Lang.get("lang_activity_luxurygiftpkg_buy",{value = currencyStr1}) )	
		else
			self._commonButtonMediumNormal:setString(Lang.get("lang_activity_luxurygiftpkg_buy",{value = vipConfig.rmb}) )	
		end
		if Lang.checkUI("ui4") then
			self._commonButtonMediumNormal:switchToHightLight()
		else
			self._commonButtonMediumNormal:switchToNormal()
		end
	end
	self._commonButtonMediumNormal:setEnabled(enabled)
end

function LuxuryGiftPkgItemCell:_createRichItems(index)
	local unitDataList = G_UserData:getActivityLuxuryGiftPkg():getUnitDatasByPayType(index)
	local actLuxuryGiftPkgUnitData = unitDataList[1]
	local cfg = actLuxuryGiftPkgUnitData:getConfig()
	local paramList = {
		[1] = {
			type = "label",
			text = Lang.get("lang_activity_luxurygiftpkg_intro_02_1"),
			fontSize = 18,
			color = Colors.NORMAL_BG_ONE,
			anchorPoint = cc.p(0, 0.5)
		},
		[2] = {
			type = "image",
			name = "gold",
			texture = Path.getResourceMiniIcon(cfg.value_4)
		},
		[3] = {
			type = "label",
			name = "value",
			text = cfg.size_4,
			fontSize = 18,
			color = Colors.BRIGHT_BG_GREEN
		}
	}
	if self._conditionRichTextArr[index] then
		self._conditionRichTextArr[index]:removeFromParent()
	end
	local UIHelper = require("yoka.utils.UIHelper")
	local node = nil
	if not Lang.checkLang(Lang.CN) then
		node = UIHelper.createRichItems(paramList)
		node:setPosition(cc.p(0,0))
	else
		node = UIHelper.createRichItems(paramList, false)
		node:setPosition(cc.p(-60, -2))
	end
	local gold = node:getChildByName("gold")
	gold:ignoreContentAdaptWithSize(false)
	gold:setContentSize(cc.size(25, 25))
	gold:setPositionY(gold:getPositionY() - 3)
	local value = node:getChildByName("value")
	if  Lang.checkLang(Lang.CN) then
		value:setPositionX(value:getPositionX() - 8)
	end
	self._nodeCondition2:addChild(node)
	self._conditionRichTextArr[index] = node
end

-- i18n change lable
function LuxuryGiftPkgItemCell:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		if not Lang.checkUI("ui4") then
			self._imageItemName = UIHelper.swapWithLabel(self._imageItemName,{style = "luxury_gift_1"})
		end

		local UIHelper  = require("yoka.utils.UIHelper")	
		self._imageReceive = UIHelper.swapSignImage(self._imageReceive,
		{ 
			 style = "sign_1", 
			 text = Lang.getImgText("img_seal_yilingqu01") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))

	end
end

-- i18n change lable
function LuxuryGiftPkgItemCell:_dealPosByI18n()
	if Lang.checkUI("ui4") then
		return
	end
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local text1 = UIHelper.seekNodeByName(self._resourceNode,"Text_3")
		local text2 = UIHelper.seekNodeByName(self._resourceNode,"Text_3_0")

		text1:setAnchorPoint(cc.p(0,0.5))
		text2:setAnchorPoint(cc.p(0,0.5))

		text1:setPositionX(text1:getPositionX()-40)
		text2:setPositionX(text1:getPositionX())

		self._nodeCondition2:setPositionY(self._nodeCondition2:getPositionY()+16)

		if Lang.checkLang(Lang.VN) then
			UIHelper.alignCenter(self._commonButtonMediumNormal,{text1})
			UIHelper.alignCenter(self._commonButtonMediumNormal,{text2})	
		end
	

	end
end

return LuxuryGiftPkgItemCell
