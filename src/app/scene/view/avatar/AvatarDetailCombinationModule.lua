--
-- Author: Liangxu
-- Date: 2018-1-4 14:12:15
-- 变身卡详情 天赋模块
local ListViewCellBase = require("app.ui.ListViewCellBase")
local AvatarDetailCombinationModule = class("AvatarDetailCombinationModule", ListViewCellBase)
local AvatarDataHelper = require("app.utils.data.AvatarDataHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function AvatarDetailCombinationModule:ctor()
	local resource = {
		file = Path.getCSB("AvatarDetailCombinationModule", "avatar"),
		binding = {
			
		},
	}
	
	AvatarDetailCombinationModule.super.ctor(self, resource)
end

function AvatarDetailCombinationModule:onCreate()
	--i18n
	self:_dealByI18n()
	local contentSize = self._panelBg:getContentSize()
	self:setContentSize(contentSize)
	self._nodeTitle:setFontSize(24)
	if Lang.checkUI("ui4") then -- i18n ja change
        ccui.Helper:seekNodeByName(self._nodeTitle, "ImageBase"):loadTexture(Path.getTextTeam("img_zr_di03"))
        ccui.Helper:seekNodeByName(self._nodeTitle, "ImageBase"):setContentSize(cc.size(406, 37))  
	end
end

--isOnlyShow，只显示，不做是否激活的判断
function AvatarDetailCombinationModule:updateUI(showId, isOnlyShow)
	local is = AvatarDataHelper.isHaveAvatarShow(showId)
	if isOnlyShow == true then
		is = false
	end
	local nameColor = is and Colors.BRIGHT_BG_GREEN or Colors.SYSTEM_TARGET_RED
	local attrColor = is and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_ONE
	local showConfig = AvatarDataHelper.getAvatarShowConfig(showId)
	self._textName:setString(showConfig.name)
	self._textName:setColor(nameColor)
	for i = 1, 2 do
		local avatarId = showConfig["avatar_id"..i]
		self["_fileNodeIcon"..i]:updateUI(avatarId)
		if isOnlyShow ~= true then
			local isHave = G_UserData:getAvatar():isHaveWithBaseId(avatarId)
			self["_fileNodeIcon"..i]:setIconMask(not isHave)
		end
	end
	
	local attrInfo = AvatarDataHelper.getShowAttr(showId)
	for i = 1, 4 do
		local info = attrInfo[i]
		if info then
			local attrId = info.attrId
			local attrValue = info.attrValue
			self["_nodeAttr"..i]:updateView(attrId, attrValue)
			self["_nodeAttr"..i]:setValueColor(attrColor)
			self["_nodeAttr"..i]:alignmentCenter()
			self["_nodeAttr"..i]:setVisible(true)
		else
			self["_nodeAttr"..i]:setVisible(false)
		end
	end
	if #attrInfo == 1 then
		self["_nodeAttr1"]:setPosition(cc.p(201, 36))
	end
end

function AvatarDetailCombinationModule:setTitle(index)
	local index2Text = {
		[1] = "一",
		[2] = "二",
		[3] = "三",
		[4] = "四",
		[5] = "五",
		[6] = "六",
		[7] = "七",
		[8] = "八",
		[9] = "九",
		[10] = "十",
	}
	if not Lang.checkLang(Lang.CN) then
		index2Text = {
			[1] = "1",
			[2] = "2",
			[3] = "3",
			[4] = "4",
			[5] = "5",
			[6] = "6",
			[7] = "7",
			[8] = "8",
			[9] = "9",
			[10] = "10",
		}
	end

	local text = index2Text[index]
	self._nodeTitle:setTitle(Lang.get("avatar_detail_combination_title", {index = text}))
end

--i18n
function AvatarDetailCombinationModule:_dealByI18n()
	if Lang.checkLang(Lang.JA) then
		local posX2,posY2 = self._nodeAttr2:getPosition()
		local posX3,posY3 = self._nodeAttr3:getPosition()
		self._nodeAttr2:setPosition(posX3,posY3)
		self._nodeAttr3:setPosition(posX2,posY2)
		self._nodeAttr1:setPositionX(self._nodeAttr1:getPositionX()-45)
		self._nodeAttr2:setPositionX(self._nodeAttr2:getPositionX()-45)
		self._nodeAttr3:setPositionX(self._nodeAttr3:getPositionX()+25)
		self._nodeAttr4:setPositionX(self._nodeAttr4:getPositionX()+25)
	end
end

return AvatarDetailCombinationModule