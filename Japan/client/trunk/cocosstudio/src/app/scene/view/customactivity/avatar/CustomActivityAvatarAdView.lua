
-- Author: nieming
-- Date:2018-04-13 16:38:51
-- Describle：

local ViewBase = require("app.ui.ViewBase")
local CustomActivityAvatarAdView = class("CustomActivityAvatarAdView", ViewBase)
local CustomActivityAvatarHelper = import(".CustomActivityAvatarHelper")
local DataConst = require("app.const.DataConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local CustomActivityUIHelper = require("app.scene.view.customactivity.CustomActivityUIHelper")
local UIHelper  = require("yoka.utils.UIHelper")

local IMAGE = {
	[1] = {
		["bgName"] = "img_activity_bg04",
		["timeBgName"] = "img_activity_changecard0",
		["dayName"] = "img_activity_changecard",
	},
	[2] = {
		["bgName"] = "img_activity_bg07",
		["timeBgName"] = "img_activity_hong0",
		["dayName"] = "img_activity_hong",
	},
}

function CustomActivityAvatarAdView:ctor(parentView)

	--csb bind var name
	self._buttonGoto = nil  --CommonButtonHighLight
	self._imageCostIcon = nil  --ImageView
	self._imageRemainDay = nil  --ImageView
	self._textResCost = nil  --Text
	self._parentView = parentView

	local resource = {
		size = G_ResolutionManager:getDesignSize(),
		file = Path.getCSB("CustomActivityAvatarAdView", "customactivity/avatar"),
		binding = {
			_buttonGoto = {
				events = {{event = "touch", method = "_onButtonGoto"}}
			},
		},
	}
	CustomActivityAvatarAdView.super.ctor(self, resource)
end

-- Describle：
function CustomActivityAvatarAdView:onCreate()
	-- i18n change lable
	self:_swapImageByI18n()

	self._buttonGoto:setString(Lang.get("common_btn_goto_activity"))
	local cosRes = CustomActivityAvatarHelper.getCosRes()
	local itemParams = TypeConvertHelper.convert(cosRes.type, cosRes.value, cosRes.size)
	if itemParams.res_mini then
		self._imageCostIcon:loadTexture(itemParams.res_mini)
	end
	self:enterModule()
end

function CustomActivityAvatarAdView:_updateDayNum()
	local actUnitdata = G_UserData:getCustomActivity():getAvatarActivity()
	if actUnitdata then
		local batch = actUnitdata:getBatch()
		local bgIndex = require("app.config.avatar_activity").get(batch).Background
		local endTime = actUnitdata:getEnd_time()
		local leftTime = endTime - G_ServerTime:getTime()
		local day,hour,min,second = G_ServerTime:convertSecondToDayHourMinSecond(leftTime)
		local imageInfo = IMAGE[bgIndex]
		if imageInfo then
			self._imageBg:loadTexture(Path.getCustomActivityUIBg(imageInfo.bgName))
		end

		if day >= 1 and day <= 3 then
			if imageInfo then
				if not Lang.checkLang(Lang.CN)  then
					-- i18n ja change
					if Lang.checkLang(Lang.JA) then  
						UIHelper.setLabelStyle(self._imageTime,{
							style = "activity_limit_3_ja", 
							text = Lang.getImgText(imageInfo.dayName..day) , 
						})
						
						self._imageTime:setAnchorPoint(cc.p(1,0.5)) 
						self._imageTime:setPosition(363+100, -267)
					else 
						UIHelper.setLabelStyle(self._imageTime,{
							style = "activity_limit_3_ja", 
							text = Lang.getImgText(imageInfo.dayName..day) ,
							position =  bgIndex == 1 and  cc.p(80,144) or cc.p(80,154) ,
						})	
					end  
				else
					self._imageTime:loadTexture(Path.getCustomActivityUI(imageInfo.dayName..day))
				end

			end
			self._textTime:setVisible(false)
		else
			if imageInfo then
				logWarn("CustomActivityAvatarAdView --------------dds  "..bgIndex)
				if not Lang.checkLang(Lang.CN)  then
					UIHelper.setLabelStyle(self._imageTime,{
						style = bgIndex == 1 and "activity_limit_3" or "activity_limit_4",
						text = Lang.getImgText(imageInfo.timeBgName) ,
					})
				else
					self._imageTime:loadTexture(Path.getCustomActivityUI(imageInfo.timeBgName))
				end
			end
			self._textTime:setVisible(true)
			self._textTime:stopAllActions()
 
			local timeStr = CustomActivityUIHelper.getLeftDHMSFormat(actUnitdata:getEnd_time())
			self._textTime:setString(timeStr)
			if not Lang.checkLang(Lang.CN)  then 
				
				if Lang.checkLang(Lang.JA) then -- i18n ja change
					UIHelper.setLabelStyle(self._imageTime,{
						style = "activity_limit_3_ja",
						text = Lang.getImgText(imageInfo.timeBgName) ,
					})
					self._textTime:setColor(Colors.OBVIOUS_GREEN) -- 修改倒计时颜色
					self._textTime:setAnchorPoint(cc.p(1,0.5))
					self._imageTime:setAnchorPoint(cc.p(1,0.5))

					self._textTime:setPosition(363+100, -267)
					self._imageTime:setPosition(self._textTime:getPositionX() - self._textTime:getContentSize().width - 2, -267)
				end  
			end

			local UIActionHelper = require("app.utils.UIActionHelper")
			local action = UIActionHelper.createUpdateAction(function()
				local timeStr1 = CustomActivityUIHelper.getLeftDHMSFormat(actUnitdata:getEnd_time())
				self._textTime:setString(timeStr1)
			end, 0.5)
			self._textTime:runAction(action)
		end

		if not Lang.checkLang(Lang.CN)  then
			local UIHelper  = require("yoka.utils.UIHelper")
			if Lang.checkLang(Lang.VN) then
				self.desLabel:setPositionX(bgIndex == 1 and 413 or 413)
				self.desLabel:setPositionY(bgIndex == 1 and 141 or 141)
			else
				self.desLabel:setPositionX(bgIndex == 1 and 410 or 434)
			end
			--self.desImg:setPositionX(bgIndex == 1 and 502 or 526)
			self._buttonGoto:setPositionX(bgIndex == 1 and 65 or (65+16) )

			local text10 = UIHelper.seekNodeByName(self,"Text_1_0")
			UIHelper.alignCenterToFixPos(bgIndex == 1 and 63 or 63,{text10,self._imageCostIcon,self._textResCost},{3,3,0})

		end
	end
end


function CustomActivityAvatarAdView:enterModule()
	self._textResCost:setString(string.format("x%s", G_UserData:getItems():getItemNum(DataConst.ITEM_AVATAR_ACTIVITY_TOKEN)))
	self:_updateDayNum()

end


-- Describle：
function CustomActivityAvatarAdView:onEnter()

end

-- Describle：
function CustomActivityAvatarAdView:onExit()

end
-- Describle：
function CustomActivityAvatarAdView:_onButtonGoto()
	-- body
	self._parentView:jumpToAvatarActivity()
end


-- i18n change lable
function CustomActivityAvatarAdView:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageTimeOldX =  self._imageTime:getPositionX()
		self._imageTime = UIHelper.swapWithLabel(self._imageTime,{
			style = "activity_limit_3",
			text = Lang.getImgText("txt_img_shenbing01") ,
		})

		-- i18n RichText
		local label = nil
		if Lang.checkLang(Lang.CN) then
			label = ccui.RichText:create()
		else
			label = ccui.RichText:createByI18n()         
		end

		label:setAnchorPoint(cc.p(0.5,0.5))
    	label:setRichTextWithJson( Lang.getImgText("avatar_ad_content"))
		label:setPosition(410,128)
		self.desLabel = label
		logWarn("CustomActivityAvatarAdView  "..Path.getResourceMiniIcon(85))
		self._imageBg:addChild(label)
		--去掉这个提示
		self.desLabel:setVisible(false)
		--self._imageBg:addChild(img)
		local text1 = UIHelper.seekNodeByName(self,"Text_1")
		text1:setAnchorPoint(cc.p(0,0.5))
		text1:setPosition(text1:getPositionX()-130, -267)


		self._buttonGoto:setPositionX(self._buttonGoto:getPositionX()+15)


				
		if Lang.checkUI("ui4") then
			self.desLabel:setPositionY(153)
			self._buttonGoto:setPositionY(self._buttonGoto:getPositionY()+25)
		end
	end
end




return CustomActivityAvatarAdView
