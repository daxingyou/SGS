-- @Author panhoa
-- @Date 5.7.2019
-- @Role 

local ViewBase = require("app.ui.ViewBase")
local GoldHeroAvatar = class("GoldHeroAvatar", ViewBase)
local GachaGoldenHeroConst = require("app.const.GachaGoldenHeroConst")

function GoldHeroAvatar:ctor(callback)
    self._avatar  = nil   -- avatar
    self._heroName= nil
    self._heroId  = nil   -- heroId
    self._callback= callback

    local resource = {
		file = Path.getCSB("GoldHeroAvatar", "gachaGoldHero"),

	}
	GoldHeroAvatar.super.ctor(self, resource)
end

function GoldHeroAvatar:onCreate()
    self:_init()
end

function GoldHeroAvatar:onEnter()
end

function GoldHeroAvatar:onExit()
end

function GoldHeroAvatar:_init( ... )
    self._nodeEffect:setVisible(false)
    self._panelTouch:addClickEventListenerEx(handler(self, self._clickAvatar))
end

function GoldHeroAvatar:_clickAvatar()
    if self._callback then
        self._callback(self._heroId)
    end
end

-- @Role Update avatar Info
function GoldHeroAvatar:updateUI(heroId, limitLevel, isAni)
    self._avatar:updateUI(heroId, "", false, limitLevel, nil, isAni)
    self._heroId = heroId
    self:_updateCountry()
end

function GoldHeroAvatar:_updateCountry()
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    local heroData = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, self._heroId)
    self._heroName:setName(heroData.name)
    self._heroName:setCountryFlag(heroData.country_text)
end

-- @Role Show effect
function GoldHeroAvatar:showAvatarEffect(bShow)
    self._avatar:showAvatarEffect(true)
end

-- @Role Scale
function GoldHeroAvatar:setScale(scale)
    self._avatar:setScale(scale)
end

-- @Role Get HeroId
function GoldHeroAvatar:getHeroId()
    return self._heroId
end

function GoldHeroAvatar:playAnimationLoopIdle(callBack, posIndex)
    self._avatar:setAniTimeScale(1)
    self._avatar:playAnimationLoopIdle(callBack, posIndex)
end

function GoldHeroAvatar:playAnimationOnce(name)
	self._avatar:setAniTimeScale(1)
	self._avatar:playAnimationOnce(name)
end

function GoldHeroAvatar:playAnimationEfcOnce(name)
	self._avatar:setAniTimeScale(1)
    self._avatar:playAnimationEfcOnce(name)
end

-- @Role Play idle
function GoldHeroAvatar:playAnimationNormal()
	self._avatar:setAniTimeScale(1)
	self._avatar:setAction("idle", true)
end

-- @Role Set opacity
function GoldHeroAvatar:setOpacity(opacity)
    return self._avatar:setOpacity(opacity)
end

function GoldHeroAvatar:getSpine()
    return self._avatar
end

function GoldHeroAvatar:turnBack(bTrue)
    self._avatar:turnBack(bTrue)
end

function GoldHeroAvatar:setAligement(iType)
    if Lang.checkHorizontal() then
        self._heroName:setPositionX(150)
        return
    end
    if GachaGoldenHeroConst.FLAG_ALIGNMENT_LEFT == iType then
        self._heroName:setPositionX(45)
    elseif GachaGoldenHeroConst.FLAG_ALIGNMENT_RIGHT == iType then
        self._heroName:setPositionX(205)
    end
end

function GoldHeroAvatar:setNameVisible(isVisible)
    self._heroName:setVisible(isVisible)
end

function GoldHeroAvatar:setNamePositionY(alignType)
    if Lang.checkHorizontal() then
        if alignType == 2 then
            self._heroName:setPositionY(185)
        else
            self._heroName:setPositionY(230)
        end
        return
    end
    if alignType == 2 then
        self._heroName:setPositionY(130)
    elseif alignType == 1 then
        self._heroName:setPositionY(50)        
    end
end


return GoldHeroAvatar
