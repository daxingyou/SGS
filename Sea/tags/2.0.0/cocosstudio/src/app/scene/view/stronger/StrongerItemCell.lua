
-- Author: hedili
-- Date:2018-01-09 16:11:05
-- Describle：

local ListViewCellBase = require("app.ui.ListViewCellBase")
local StrongerItemCell = class("StrongerItemCell", ListViewCellBase)

local IMAGE_STATE = {
	[1] = { min = 0, max = 40, path = Path.getText("txt_zhuangtai01"),txt = "txt_zhuangtai01"},-- i18n change lable
	[2] = { min = 40, max = 60, path = Path.getText("txt_zhuangtai02"),txt = "txt_zhuangtai02"},-- i18n change lable
	[3] = { min = 60, max = 80, path =Path.getText("txt_zhuangtai03"),txt = "txt_zhuangtai03"},-- i18n change lable
	[4] = { min = 80, max = 100, path =Path.getText("txt_zhuangtai04"),txt = "txt_zhuangtai04"},-- i18n change lable
	[5] = { min = 100, max = 1000, path =Path.getText("txt_zhuangtai05"),txt = "txt_zhuangtai05"}-- i18n change lable
}


function StrongerItemCell:ctor()

	--csb bind var name
	self._commonButton = nil  --CommonButtonSwitchLevel1
	self._imageReceive = nil  --ImageView
	self._loadingBarProgress = nil  --LoadingBar
	self._textItemName = nil  --Text
	self._textProgress = nil  --Text
	self._label  = nil-- i18n change lable
	local resource = {
		file = Path.getCSB("StrongerItemCell", "stronger"),
	}
	StrongerItemCell.super.ctor(self, resource)
end

function StrongerItemCell:onCreate()
	-- i18n change lable
	self:_swapImageByI18n()
	-- i18n change lable
	self:_createLabelByI18n()
	-- i18n pos lable
	self:_dealPosByI18n()
	-- body
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	self._commonButton:setString(Lang.get("lang_stronger_btn_go"))
	self._commonButton:switchToNormal()
	self._commonButton:addClickEventListenerEx(handler(self,self._onCommonButton))
end

function StrongerItemCell:updateUI( index, data, tabIndex)
	-- body
	self._itemData = data

	self:getSubNodeByName("Node_progress"):setVisible(false)
	self:getSubNodeByName("Node_opening"):setVisible(false)
	if tabIndex == 1 then
		self:updateTab1()
	else 
		self:updateTab2()
	end
end

function StrongerItemCell:updateTab1( ... )
	-- body
	self:getSubNodeByName("Node_progress"):setVisible(true)
	self:updateCommonImage()
	self._textItemName:setString(self._itemData.funcData.name)
	self._imageReceive:setVisible(false)
	self._commonButton:setVisible(true)
	self._loadingBarProgress:setPercent(self._itemData.percent)
	self._textProgress:setString(self._itemData.percent.."%")

	local function mathCurrStateImg( percent )
		-- body
		for i, value in ipairs(IMAGE_STATE) do
			if percent >= value.min and percent < value.max then
				-- i18n change lable
				return value.path,i,value.txt
				
			end
		end
	end

	self:updateImageView("Image_sign", {texture = mathCurrStateImg(self._itemData.percent) })

	-- i18n change lable
	if not Lang.checkLang(Lang.CN) then
		local path ,i ,txt= mathCurrStateImg(self._itemData.percent)
		local UIHelper  = require("yoka.utils.UIHelper")
		UIHelper.setLabelStyle(self._label,{
			 style = "stronger_guide_"..tostring(i),
			 text = Lang.getImgText(txt),
			 fontSize = 18,
		})
	end

end
function StrongerItemCell:updateTab2( ... )
	-- body
	logWarn("StrongerItemCell:updateTab2")
	self:getSubNodeByName("Node_opening"):setVisible(true)
	self:updateCommonImage()
	self._textItemName:setString(self._itemData.funcData.name)
	self._textOpenDesc:setString(self._itemData.funcData.description)
	self._imageOpen:setVisible(false)
	self._textOpenLevel:setVisible(false)
	
	local isOpen = self._itemData.isOpen

	if isOpen == false then
		self._textOpenLevel:setVisible(true)
		self._textOpenLevel:setString(Lang.get("lang_stronger_level", {level = self._itemData.funcData.level}))
	else
		self._imageOpen:setVisible(true)
	end

end

function StrongerItemCell:updateCommonImage( )
	-- body
	self:updateImageView("Image_icon", {texture =Path.getCommonIcon("main",self._itemData.funcData.icon) })
end

-- Describle：
function StrongerItemCell:_onCommonButton()

	local cfgData = self._itemData.cfgData

	if cfgData.function_jump > 0 then
		dump(cfgData.function_jump)
		local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
		WayFuncDataHelper.gotoModuleByFuncId(cfgData.function_jump)
	end
		
	
end


function StrongerItemCell:_updateBtnState(itemData)

	self._imageReceive:setVisible(false)
	self._commonButton:setEnabled(false)

end




-- i18n change lable
function StrongerItemCell:_createLabelByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image = ccui.Helper:seekNodeByName(self._resourceNode, "Image_sign")
		image:setPositionX(image:getPositionX()+7)
        local x,y = image:getPosition()
        local anchorPoint = image:getAnchorPoint()
		self._label = UIHelper.createLabel({
			 style = "stronger_guide_1",
             position =cc.p(x,y) ,
             anchorPoint = anchorPoint,
			 fontSize = 18,
		})
		image:getParent():addChild(self._label)
		
	end
end


-- i18n change lable
function StrongerItemCell:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then

        local UIHelper  = require("yoka.utils.UIHelper")	
        self._imageOpen = UIHelper.swapSignImage(self._imageOpen,
		{ 
			 style = "signet_5", 
			 text = Lang.getImgText("img_yikaiqi01") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))


		local UIHelper  = require("yoka.utils.UIHelper")	
        self._imageReceive = UIHelper.swapSignImage(self._imageReceive,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("w_img_signet01") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))

	end
end

-- i18n pos lable
function StrongerItemCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local renderLabel = self._textOpenDesc:getVirtualRenderer()	
		renderLabel:setMaxLineWidth(340)
		self._textOpenDesc:setPositionY(self._textOpenDesc:getPositionY()+10)
		renderLabel:setLineSpacing(0)
	end
	if Lang.checkLang(Lang.EN) then
		self._textItemName:getVirtualRenderer():setMaxLineWidth(200)
	end
end




return StrongerItemCell