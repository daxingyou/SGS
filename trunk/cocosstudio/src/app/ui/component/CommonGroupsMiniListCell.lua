--
-- Author: Liangxu
-- Date: 2018-11-14
-- 
local ListViewCellBase = require("app.ui.ListViewCellBase")
local CommonGroupsMiniListCell = class("CommonGroupsMiniListCell", ListViewCellBase)

local RES_NAME = {
	[1] = "txt_qintomb_jia01",
	[2] = "txt_qintomb_yi02",
	[3] = "txt_qintomb_bing03",
}

function CommonGroupsMiniListCell:ctor(callback)
	self._callback = callback

	local resource = {
		file = Path.getCSB("CommonGroupsMiniListCell", "groups"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onClick"}}
			},
		}
	}
	CommonGroupsMiniListCell.super.ctor(self, resource)
end

function CommonGroupsMiniListCell:onCreate()
	-- i18n change to lable
	if not Lang.checkLang(Lang.CN) then
		self:_swapImageByI18n()
		self:_dealPosByI18n()
	end
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end

function CommonGroupsMiniListCell:_initUI()
	self._buttonAdd:setVisible(false)
	self._icon:setVisible(false)
	self._textState:setVisible(false)
end

function CommonGroupsMiniListCell:update(userData, location)
	self._userData = userData
	self:_initUI()

	local locationRes = Path.getTextQinTomb(RES_NAME[location])
	-- i18n change to lable
	if Lang.checkLang(Lang.CN) then
		self._imageLocation:loadTexture(locationRes) 
	else
		self._imageLocation:setString(Lang.getImgText(RES_NAME[location]) )
	end

	if userData then
		self._icon:setVisible(true)

		self._icon:updateUI(userData:getCovertId(), nil, userData:getLimitLevel())
		-- self._icon:setLevel(userData:getLevel())
		
		self._commonHeadFrame:updateUI(userData:getHead_frame_id(),self._icon:getScale())
		self._commonHeadFrame:setLevel(userData:getLevel())
		self._imageLeader:setVisible(userData:isLeader())
		self._textName:setString(userData:getName())
		self._textName:setColor(Colors.getOfficialColor(userData:getOffice_level()))
	else
		self._buttonAdd:setVisible(true)
		self._textName:setString(Lang.get("groups_mini_list_add_user_tip"))
		self._textName:setColor(Colors.BRIGHT_BG_TWO)
	end
end

function CommonGroupsMiniListCell:_onClick()
	if self._callback then
		self._callback(self._userData)
	end
end

-- i18n change to lable
function CommonGroupsMiniListCell:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageLocation = UIHelper.swapWithLabel(self._imageLocation,{
			style = "qintomb_5",
			text = "",
		})

	end
end

-- i18n pos 
function CommonGroupsMiniListCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._textName:setFontSize(self._textName:getFontSize())
		self._textName:setScale(0.8)
		if Lang.checkLang(Lang.JA) then  -- i18n ja change scale
			self._textName:setScale(0.7)
		end
	end
	if Lang.checkUI("ui4") then
		self._imageLocation:setAnchorPoint(0,0.5)
		self._imageLocation:setPositionX(self._textName:getPositionX())
	end
end

-- i18n En th zh
function CommonGroupsMiniListCell:disableTextEffect()
end

return CommonGroupsMiniListCell