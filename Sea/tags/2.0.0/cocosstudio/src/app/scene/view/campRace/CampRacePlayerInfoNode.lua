local CampRacePlayerInfoNode = class("CampRacePlayerInfoNode")
local TextHelper = require("app.utils.TextHelper")

--pos，1左2右
function CampRacePlayerInfoNode:ctor(target, pos)
    self._target = target

    self._imageBg = ccui.Helper:seekNodeByName(self._target, "ImageBg")
    local resBg = Path.getCampImg("img_camp_player0"..pos.."b")
    self._imageBg:loadTexture(resBg)

    self._imageFirst = ccui.Helper:seekNodeByName(self._target, "ImageFirst")
    self._textPower = ccui.Helper:seekNodeByName(self._target, "TextPower")
    self._textPlayerName = ccui.Helper:seekNodeByName(self._target, "TextPlayerName")
    self._textCount = ccui.Helper:seekNodeByName(self._target, "TextCount")
    self._textTip = ccui.Helper:seekNodeByName(self._target, "TextTip")
    self._imagePower = ccui.Helper:seekNodeByName(self._target, "ImagePower")

	-- i18n pos lable
	self:_dealPosByI18n()
	-- i18n change lable
	self:_swapImageByI18n()
end

function CampRacePlayerInfoNode:updateUI(playerData)
	if playerData then
		self._imageFirst:setVisible(playerData:isFirst_hand())
		local strPower = TextHelper.getAmountText2(playerData:getPower())
		self._textPower:setString(strPower)
		self._textPlayerName:setString(playerData:getName())
		self._textPlayerName:setColor(Colors.getOfficialColor(playerData:getOfficer_level()))
	
		if not Lang.checkLang(Lang.CN) then
			local UIHelper  = require("yoka.utils.UIHelper")
			UIHelper.dealVTextWidget(self._textCount,Lang.get("camp_play_off_win_count", {count = playerData:getWin_num()}))
		else
			self._textCount:setString(Lang.get("camp_play_off_win_count", {count = playerData:getWin_num()}))
		end
		self._textCount:setVisible(true)
		self._textTip:setVisible(false)
		self._imagePower:setVisible(true)
	else
		self._imageFirst:setVisible(false)
		self._textPower:setString("")
		self._textPlayerName:setString("")
    	self._textPlayerName:setColor(Colors.getCampGray())
    	self._textCount:setVisible(false)
    	self._textTip:setVisible(true)
    	self._imagePower:setVisible(false)
	end
end


-- i18n change lable
function CampRacePlayerInfoNode:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imagePower = UIHelper.swapWithLabel(self._imagePower,{style = "camp_race_4"
		})
		self._imagePower:setString( Lang.getImgText("img_camp_com02"))
	end
end

function CampRacePlayerInfoNode:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		self._textCount:setTextHorizontalAlignment( 1 )
		self._textCount:getVirtualRenderer():setLineSpacing(-6)
		self._textCount:setFontSize(self._textCount:getFontSize()- 2)
		if Lang.checkLang(Lang.KR) then
			self._textCount:setPositionX(self._textCount:getPositionX() + 4)
		end
	end
	
end

return CampRacePlayerInfoNode