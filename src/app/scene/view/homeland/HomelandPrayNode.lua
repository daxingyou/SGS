
local ViewBase = require("app.ui.ViewBase")
local HomelandPrayNode = class("HomelandPrayNode", ViewBase)
local HomelandConst = require("app.const.HomelandConst")
local HomelandHelp = require("app.scene.view.homeland.HomelandHelp")
local AudioConst = require("app.const.AudioConst")

function HomelandPrayNode:ctor(homelandType, callback)
	self._homelandType = homelandType
	self._callback = callback
	local resource = {
		file = Path.getCSB("HomelandPrayNode", "homeland"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClick"}}
			},
		},
	}
	HomelandPrayNode.super.ctor(self, resource)
end

function HomelandPrayNode:onCreate()
	if not Lang.checkLang(Lang.CN) then	
		self:_swapImageByI18n()
	end
	self:setPosition(cc.p(0, -220))
	G_EffectGfxMgr:createPlayMovingGfx(self._nodeMoving, "moving_shenshu_lianhuadeng")
	if Lang.checkUI("ui4") then
		self:_dealPrayNodeFormatByI18n()
	end
end

function HomelandPrayNode:_onClick()
    if self:isFriendTree() then
        return
    end
    local curLevel = G_UserData:getHomeland():getMainTreeLevel()
    local unlockLevel = HomelandConst.getUnlockPrayLevel()
    if curLevel < unlockLevel then
        G_Prompt:showTip(Lang.get("homeland_pray_level_not_reach_tip", {level = unlockLevel}))
        return
	end
	if self._callback then
		G_AudioManager:playSoundWithId(AudioConst.SOUND_QiFU)
		self._callback()
	end
end

function HomelandPrayNode:isFriendTree( ... )
	if self._homelandType == HomelandConst.FRIEND_TREE then
		return true
	end 

	return false
end

function HomelandPrayNode:updateRedPoint()
	if self:isFriendTree() == false then
		local show = G_UserData:getHomeland():getPrayRestCount() > 0
		self._redPoint:setVisible(show)
	else
		self._redPoint:setVisible(false)
	end
end
-- i18n change lable
function HomelandPrayNode:_swapImageByI18n()

	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self,"Image_42")

		local label = UIHelper.swapWithLabel(image1,{
			style = "homeland_1",
			fontSize = 22,
			text = Lang.getImgText("txt_homeland_decorate07") ,
		})
		label:setAnchorPoint(cc.p(0.5,0.5))
		--label:setPositionY(-57)
		label:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	end

end

-- i18n
function HomelandPrayNode:_dealPrayNodeFormatByI18n()
    if  Lang.checkUI("ui4") then  
		local UIHelper  = require("yoka.utils.UIHelper")

		local image_bk = UIHelper.seekNodeByName(self,"Image_bk")
		local image42 = UIHelper.seekNodeByName(self,"Image_42")
		image42:setAnchorPoint(cc.p(0.5, 1))  
		image42:getVirtualRenderer():setMaxLineWidth( image42:getFontSize()) 
		image_bk:setScale(1)
		image_bk:setScale9Enabled(false)
        UIHelper.setLabelStyle(image42,{
            style = "challenge_2_ui4" ,
            text =Lang.getImgText("txt_homeland_decorate07"),
        })  
        UIHelper.loadCommonBgImageByI18n( image_bk,Lang.getImgText("txt_homeland_decorate07") )
        image_bk:ignoreContentAdaptWithSize(true)
        local imageNameBgSize = image_bk:getContentSize()
        local imageNameBgVirtualSize = image_bk:getVirtualRendererSize()
        image42:setPositionY(imageNameBgVirtualSize.height-36)
		image42:setPositionX(imageNameBgVirtualSize.width/2)

		self._redPoint:setPositionY(imageNameBgVirtualSize.height-18)
		self._redPoint:setPositionX(self._redPoint:getPositionX()+2)

	end
end

return HomelandPrayNode