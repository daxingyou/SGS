-- 阵容锦囊ICON
-- Author: Liangxu
-- Date: 2018-3-2 14:21:36
--
local ViewBase = require("app.ui.ViewBase")
local SilkbagIcon = class("SilkbagIcon", ViewBase)
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local SilkbagDataHelper = require("app.utils.data.SilkbagDataHelper")
local EffectGfxNode = require("app.effect.EffectGfxNode")

function SilkbagIcon:ctor(index, onClick)
	self._index = index
	self._onClick = onClick

	local resource = {
		file = Path.getCSB("SilkbagIcon", "silkbag"),
		binding = {
			_panelTouch = {
				events = {{event = "touch", method = "_onPanelTouch"}}
			},
			_btnClose = {
				events = {{event = "touch", method = "_onClickClose"}}
			},
		}
	}

	SilkbagIcon.super.ctor(self, resource)
end

function SilkbagIcon:onCreate()
	--i18n
	self:_dealByI18n()
	self:_initData()
	self:_initView()
	self:_hideAllWidget()
end

function SilkbagIcon:onEnter()

end

function SilkbagIcon:onExit()
	
end

function SilkbagIcon:_initData()
	self._pos = 0
	self._isOpen = false
	self._effect1 = nil
	self._effect2 = nil
end

function SilkbagIcon:_initView()
	self._panelTouch:setSwallowTouches(true)
end

function SilkbagIcon:_hideAllWidget()
	self._imageLock:setVisible(false)
	self._imageMidBg:setVisible(false)
	self._imageSelected:setVisible(false)
	self._imageDark:setVisible(false)
	self._imageText:setVisible(false)
	self._btnClose:setVisible(false)
	self._imageRP:setVisible(false)
	self:removeLightEffect()
end

function SilkbagIcon:updateIcon(pos)
	self:_hideAllWidget()
	self._pos = pos
	local isOpen, comment, info = LogicCheckHelper.funcIsOpened(FunctionConst["FUNC_SILKBAG_SLOT"..self._index])
	self._isOpen = isOpen
	if isOpen then
		local silkbagId = G_UserData:getSilkbagOnTeam():getIdWithPosAndIndex(pos, self._index)
		if silkbagId > 0 then
			local unitData = G_UserData:getSilkbag():getUnitDataWithId(silkbagId)
			local baseId = unitData:getBase_id()

			self._imageMidBg:setVisible(true)
			self._btnClose:setVisible(true)

			local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_SILKBAG, baseId)
			self._imageMidBg:loadTexture(param.icon_mid_bg2)
			self._imageIcon:loadTexture(param.icon)
			self._textName:setString(param.name)
			self._textName:setColor(param.icon_color)
			self._textName:enableOutline(param.icon_color_outline, 2)
			local heroId = G_UserData:getTeam():getHeroIdWithPos(pos)
			local heroUnitData = G_UserData:getHero():getUnitDataWithId(heroId)
			local heroBaseId = heroUnitData:getAvatarToHeroBaseId()
			local heroRank = heroUnitData:getRank_lv()
			local isInstrumentMaxLevel = G_UserData:getInstrument():isInstrumentLevelMaxWithPos(pos)
			local heroLimit = heroUnitData:getLeaderLimitLevel()
			local isEffective, limitRank, isEffectiveForInstrument, limitLevel = SilkbagDataHelper.isEffectiveSilkBagToHero(baseId, heroBaseId, heroRank, isInstrumentMaxLevel, heroLimit)

			if not isEffective then
				local tips = ""
				if limitRank == false then
					tips = Lang.get("silkbag_not_effective")
				elseif limitRank and limitRank > 0 then
					tips = Lang.get("silkbag_not_effective_limit_rank", {rank = limitRank})
				elseif isEffectiveForInstrument then
					tips = Lang.get("silkbag_not_effective_instrument")
				elseif limitLevel > 0 then
					tips = Lang.get("silkbag_not_effective_limit_level", {level = limitLevel})
				end
				self._textName:setString(tips)
				self._textName:setColor(Colors.OBVIOUS_YELLOW)
				self._textName:enableOutline(Colors.OBVIOUS_YELLOW_OUTLINE, 2)
				self._imageDark:setVisible(true)
			end
			self:showIconEffect(baseId)
		else
			self._textName:setString(Lang.get("silkbag_no_wear"))
			self._textName:setColor(Colors.BRIGHT_BG_TWO)
			self._textName:enableOutline(Colors.BRIGHT_BG_OUT_LINE_TWO)
		end
	else
		self._imageLock:setVisible(true)
		self._textName:setString(Lang.get("silkbag_unlock_level_tip", {level = info.level}))
		self._textName:setColor(Colors.BRIGHT_BG_TWO)
		self._textName:enableOutline(Colors.BRIGHT_BG_OUT_LINE_TWO)
	end
	--i18n
	self:_updateByI18n()
end

function SilkbagIcon:_onPanelTouch()
	if not self._isOpen then
		return
	end
	if self._onClick then
		self._onClick(self._index)
	end
end

function SilkbagIcon:_onClickClose()
	G_UserData:getSilkbag():c2sEquipSilkbag(self._pos, self._index, 0) --卸下
	if self._onClick then
		self._onClick(self._index)
	end
end

function SilkbagIcon:setSelected(selected)
	self._imageSelected:setVisible(selected)
end

function SilkbagIcon:showRedPoint(visible)
	self._imageRP:setVisible(visible)
end

function SilkbagIcon:playEffect(effectName)
	local subEffect = EffectGfxNode.new(effectName)
	self._nodeEffect:addChild(subEffect)
    subEffect:play()
end

function SilkbagIcon:onlyShow(pos, detailData)
	self:_hideAllWidget()

	local silkbagId = detailData:getSilkbagIdWithPosAndIndex(pos, self._index)
	if silkbagId > 0 then
		local unitData = detailData:getSilkbagUnitDataWithId(silkbagId)
		local baseId = unitData:getBase_id()

		self._imageMidBg:setVisible(true)

		local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_SILKBAG, baseId)
		self._imageMidBg:loadTexture(param.icon_mid_bg2)
		self._imageIcon:loadTexture(param.icon)
		self._textName:setString(param.name)
		self._textName:setColor(param.icon_color)
		self._textName:enableOutline(param.icon_color_outline, 2)
		local heroUnitData = detailData:getHeroDataWithPos(pos)
		local heroBaseId = detailData:getAvatarToHeroBaseId(heroUnitData)
		local heroRank = heroUnitData:getRank_lv()
		local isInstrumentMaxLevel = detailData:isInstrumentLevelMaxWithPos(pos)
		local heroLimit = detailData:getUserLeaderLimitLevel(heroUnitData)
		local isEffective, limitRank, isEffectiveForInstrument, limitLevel = SilkbagDataHelper.isEffectiveSilkBagToHero(baseId, heroBaseId, heroRank, isInstrumentMaxLevel, heroLimit)

		local profile = ""
		if isEffective then
			profile = param.profile
		else
			local tips = ""
			if limitRank == false then
				tips = Lang.get("silkbag_not_effective")
			elseif limitRank and limitRank > 0 then
				tips = Lang.get("silkbag_not_effective_limit_rank", {rank = limitRank})
			elseif isEffectiveForInstrument then
				tips = Lang.get("silkbag_not_effective_instrument")
			elseif limitLevel > 0 then
				tips = Lang.get("silkbag_not_effective_limit_level", {level = limitLevel})
			end
			self._imageDark:setVisible(true)
		end
		-- local desColor = isEffective and Colors.BRIGHT_BG_GREEN or Colors.BRIGHT_BG_RED
		-- self._textDes:setString(profile)
		-- self._textDes:setColor(desColor)
		self:showIconEffect(baseId)
	else
		self._textName:setString(Lang.get("silkbag_no_wear"))
		self._textName:setColor(Colors.BRIGHT_BG_TWO)
		self._textName:enableOutline(Colors.BRIGHT_BG_OUT_LINE_TWO)
	end
	--i18n
	self:_updateByI18n()
end

function SilkbagIcon:removeLightEffect()
    if self._effect1 then
		self._effect1:runAction(cc.RemoveSelf:create())
		self._effect1 = nil
	end
	if self._effect2 then
		self._effect2:runAction(cc.RemoveSelf:create())
		self._effect2 = nil
	end
end

function SilkbagIcon:showIconEffect(baseId)
	self:removeLightEffect()

	local effects = SilkbagDataHelper.getEffectWithBaseId(baseId)
	if effects == nil then
		return
	end

	if #effects == 1 then
		local effectName = effects[1]
		self._effect1 = EffectGfxNode.new(effectName)
		self._nodeEffectUp:addChild(self._effect1)
        self._effect1:play()
	end

	if #effects == 2 then
		local effectName1 = effects[1]
		self._effect1 = EffectGfxNode.new(effectName1)
		self._nodeEffectDown:addChild(self._effect1)
		self._effect1:play()
    	local effectName2 = effects[2]
		self._effect2 = EffectGfxNode.new(effectName2)
		self._nodeEffectUp:addChild(self._effect2)
		self._effect2:play()
	end
end

--i18n
function SilkbagIcon:_dealByI18n()
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		self._imageText_0:setAnchorPoint(0.5,1)
		self._imageText_0:setPositionY(-29)
		self._imageText_0:setContentSize(cc.size(200,24))
		self._textName:setAnchorPoint(0.5,1)
		self._textName:setPositionY(22)
		self._textName:getVirtualRenderer():setMaxLineWidth(170)
		self._textName:setTextHorizontalAlignment( cc.TEXT_ALIGNMENT_CENTER )
	end

end


--i18n
function SilkbagIcon:_updateByI18n()
	if Lang.checkChannel(Lang.CHANNEL_SEA) then
		local width = self._imageText_0:getContentSize().width
		local height = self._textName:getContentSize().height
		self._imageText_0:setContentSize(cc.size(width,height))
		self._textName:setPosition(width/2,height-2)
	end
end

return SilkbagIcon