
-- Author: nieming
-- Date:2018-02-06 21:08:35
-- Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local CrystalChargeCell = class("CrystalChargeCell", ListViewCellBase)
local ComponentIconHelper = require("app.ui.component.ComponentIconHelper")

CrystalChargeCell.PAGE_RECHARGE = 2	-- 充值水晶标签页
function CrystalChargeCell:ctor()

	--csb bind var name
	self._btnGetAward = nil  --CommonButtonHighLight
	self._imageReceive = nil  --ImageView
	self._title = nil  --Text

	local resource = {
		file = Path.getCSB("CrystalChargeCell", "crystalShop"),
		binding = {
			_btnGetAward = {
				events = {{event = "touch", method = "_onBtnGetAward"}}
			},
		},
	}
	CrystalChargeCell.super.ctor(self, resource)
end

function CrystalChargeCell:onCreate()
	self:_dealByI18n()
	-- body
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
	self._btnGetAward:setString(Lang.get("common_btn_name_confirm"))
	--
	if Lang.checkLang(Lang.ENID) then
		self._nodeRichText:setPositionX(self._nodeRichText:getPositionX()-30)
	end
end

function CrystalChargeCell:updateUI(data)
	-- body
	if not data then
		return
	end
	self._data = data
	self._title:setString(data:getDescription())
	if data:isAlreadGet(data:getPage()) then
		self._imageReceive:setVisible(true)
		self._btnGetAward:setVisible(false)
	else
		self._btnGetAward:setVisible(true)
		self._imageReceive:setVisible(false)
		if data:canGet(data:getPage()) then
			self._btnGetAward:switchToNormal()
			self._btnGetAward:setString(Lang.get("customactivity_btn_name_receive"))
		else
			self._btnGetAward:switchToHightLight()
			if data:getIs_function() == 0 then
				self._btnGetAward:setString(Lang.get("customactivity_btn_name_recharge"))
			else
				self._btnGetAward:setString(Lang.get("lang_crystal_shop_go_to"))
			end
		end
	end

	local awards = data:getAwards()
	local mainAward = awards[1]
	if mainAward then
		self._mainIcon:unInitUI()
		self._mainIcon:initUI(mainAward.type, mainAward.value, mainAward.size)
		self._mainIcon:setImageTemplateVisible(true)
	end
	self:_showOtherAwards(data)
	self:_showProgress(data)
end

function CrystalChargeCell:_showProgress(data)
	self._nodeRichText:removeAllChildren()
	if data:getPay_amount() > 0 and not data:isAlreadGet(data:getPage()) then
		if data:canGet(data:getPage()) then
			if data:getPage() == CrystalChargeCell.PAGE_RECHARGE then
				local richText = ccui.RichText:createRichTextByFormatString(
				Lang.get("common_remaining_finish_richtext", {num1 = (data:getValue() - data:getBuy_count()), num2 = data:getBuy_size()}),
				{defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={
					[1] = {fontSize = 20}
				}})
				if Lang.checkChannel(Lang.CHANNEL_SEA) then
					richText = ccui.RichText:createRichTextByFormatString(
						Lang.get("common_remaining_finish_richtext", {num1 = (data:getValue() - data:getBuy_count()), num2 = data:getBuy_size()}),
						{defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 18, other ={
							[1] = {fontSize = 18}
						}})
				end
				self._nodeRichText:addChild(richText)	
			else
				local richText = ccui.RichText:createRichTextByFormatString(
				Lang.get("common_progress_finish_richtext", {num1 =  data:getValue(), num2 = data:getPay_amount()}),
				{defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={
					[1] = {fontSize = 20}
				}})
				if Lang.checkChannel(Lang.CHANNEL_SEA) then
					richText = ccui.RichText:createRichTextByFormatString(
						Lang.get("common_remaining_finish_richtext", {num1 = (data:getValue() - data:getBuy_count()), num2 = data:getBuy_size()}),
						{defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 18, other ={
							[1] = {fontSize = 18}
						}})
				end
				self._nodeRichText:addChild(richText)
			end
		else
			if data:getPage() == CrystalChargeCell.PAGE_RECHARGE then
				if data:getValue() == data:getBuy_count() then
					local richText = ccui.RichText:createRichTextByFormatString(
					Lang.get("common_remaining_notfinish_richtext", {num1 = (data:getBuy_size() - data:getValue()) , num2 = data:getBuy_size()}),
					{defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={
						[1] = {fontSize = 20},
						[2] = {fontSize = 20}
					}})
					if Lang.checkChannel(Lang.CHANNEL_SEA) then
						richText = ccui.RichText:createRichTextByFormatString(
							Lang.get("common_remaining_notfinish_richtext", {num1 = (data:getBuy_size() - data:getValue()) , num2 = data:getBuy_size()}),
							{defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 18, other ={
							[1] = {fontSize = 18},
							[2] = {fontSize = 18}
						}})
					end
					self._nodeRichText:addChild(richText)
				else
					local richText = ccui.RichText:createRichTextByFormatString(
					Lang.get("common_remaining_notfinish_richtext", {num1 = (data:getValue() - data:getBuy_count()), num2 = data:getBuy_size()}),
					{defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={
						[1] = {fontSize = 20},
						[2] = {fontSize = 20}
					}})
					if Lang.checkChannel(Lang.CHANNEL_SEA) then
						richText = ccui.RichText:createRichTextByFormatString(
							Lang.get("common_remaining_notfinish_richtext", {num1 = (data:getValue() - data:getBuy_count()), num2 = data:getBuy_size()}),
							{defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 18, other ={
								[1] = {fontSize = 18},
								[2] = {fontSize = 18}
							}})
					end
					self._nodeRichText:addChild(richText)
				end
			else
				local richText = ccui.RichText:createRichTextByFormatString(
				Lang.get("common_progress_notfinish_richtext", {num1 = data:getValue(), num2 = data:getPay_amount()}),
				{defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={
					[1] = {fontSize = 20},
					[2] = {fontSize = 20}
				}})
				if Lang.checkChannel(Lang.CHANNEL_SEA) then
					richText = ccui.RichText:createRichTextByFormatString(
						Lang.get("common_progress_notfinish_richtext", {num1 = data:getValue(), num2 = data:getPay_amount()}),
						{defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 18, other ={
							[1] = {fontSize = 18},
							[2] = {fontSize = 18}
						}})
				end
				self._nodeRichText:addChild(richText)
			end
		end
	end
end

function CrystalChargeCell:_showOtherAwards(data)
	local awards = data:getAwards()
	self._otherAward:setVisible(#awards >= 2)
	for i= 2, 3 do
		local t = awards[i]
		local nodeName = "_resInfoVaule"..(i-1)
		if t then
			self[nodeName]:setVisible(true)
			self[nodeName]:updateUI(t.type, t.value, t.size)
		else
			self[nodeName]:setVisible(false)
		end

	end
end

-- Describle：
function CrystalChargeCell:_onBtnGetAward()
	-- body
	self:dispatchCustomCallback()
end


-- i18n change lable
function CrystalChargeCell:_dealByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		self._imageReceive = UIHelper.swapSignImage(self._imageReceive,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("img_seal_yilingqu03") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))
	end
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		-- (568,120)变为（562，138）
		self:setContentSize(562, 138)
		self._resourceNode:setContentSize(562, 138)
		local UIHelper  = require("yoka.utils.UIHelper")
		local image2 = UIHelper.seekNodeByName(self,"Image_2")
		local mainIcon = UIHelper.seekNodeByName(self,"_mainIcon")
		local nodeRichText = UIHelper.seekNodeByName(self,"_nodeRichText")
		local _title = UIHelper.seekNodeByName(self,"_title")
		local _imageReceive = UIHelper.seekNodeByName(self,"_imageReceive")
		local cellbg = UIHelper.seekNodeByName(self,"CellBg")
		cellbg:setContentSize(562, 138)
		_imageReceive:setPositionY(_imageReceive:getPositionY()+10)
		--往上多移动几个像素
		_title:setPositionY(_title:getPositionY()+10)
		image2:setPositionY(image2:getPositionY()+15)
		--
		mainIcon:setPositionY(mainIcon:getPositionY()+10)
		nodeRichText:setPositionY(nodeRichText:getPositionY()-16)
	
	end
	if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
	
		local UIHelper  = require("yoka.utils.UIHelper")
		local image_51 = UIHelper.seekNodeByName(self._otherAward,"Image_51")
		local text = UIHelper.seekNodeByName(self._otherAward,"Text")
		local size = image_51:getContentSize()
		image_51:setContentSize(size.width+70,size.height)
		
		self._resInfoVaule1:setPositionX(text:getPositionX()+text:getContentSize().width+4)
		self._resInfoVaule2:setPositionX(self._resInfoVaule2:getPositionX()+10)
	end


end


return CrystalChargeCell
