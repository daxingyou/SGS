-- @Author  panhoa
-- @Date  3.20.2019
-- @Role 
local CommonEnemyCell = class("CommonEnemyCell")

local EXPORTED_METHODS = {
    "updateUI",
}

function CommonEnemyCell:ctor()
	self._target = nil
end

function CommonEnemyCell:_init()
	self._imageBg   = ccui.Helper:seekNodeByName(self._target, "ImageBg")
	self._commonHeroIcon = ccui.Helper:seekNodeByName(self._target, "CommonHeroIcon")
	self._textGuildName = ccui.Helper:seekNodeByName(self._target, "TextGuildName")
    self._textUserName  = ccui.Helper:seekNodeByName(self._target, "TextUserName")
    self._textPower     = ccui.Helper:seekNodeByName(self._target, "TextPower")
    self._imageBlood    = ccui.Helper:seekNodeByName(self._target, "ImageBlood")
    self._textBlood     = ccui.Helper:seekNodeByName(self._target, "TextBlood")
    self._nodeSword     = ccui.Helper:seekNodeByName(self._target, "NodeSword")
    self._panelTouch    = ccui.Helper:seekNodeByName(self._target, "PanelTouch")
    
    self._commonHeroIcon:setVisible(false)
    --cc.bind(self._commonHeroIcon, "CommonHeroIcon")
end

function CommonEnemyCell:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonEnemyCell:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonEnemyCell:updateUI(userUnit)
    if userUnit == nil then
        return
    end

    --local GuildCrossWarHelper = require("app.scene.view.guildCrossWar.GuildCrossWarHelper")
    --GuildCrossWarHelper.updateHeroIcon(self._commonHeroIcon, userUnit)
    self:_showSword(true)
    self:_updateName(userUnit:getGuild_name(), userUnit:getName(), userUnit:getTitle(), userUnit:getUid())
    self:_updatePower(userUnit:getPower())
    self:_updateHP(userUnit:getHp())
    self._panelTouch:addClickEventListenerEx(function()
        -- body
        --dump(userUnit:getUid())
        G_UserData:getGuildCrossWar():c2sBrawlGuildsFight(userUnit:getUid())
    end)
end

-- @Role    Update Power
function CommonEnemyCell:_updatePower(power)
    -- body
    local TextHelper = require("app.utils.TextHelper")
	local powerStr = TextHelper.getAmountText(power)
    self._textPower:setString(powerStr)
end

-- @Role    Update Name/GuildName
function CommonEnemyCell:_updateName(guildName, userName, offcielTitle, uId)
    -- body
    local GuildCrossWarHelper = require("app.scene.view.guildCrossWar.GuildCrossWarHelper")
    local guildColor = GuildCrossWarHelper.getPlayerColor(uId)
    self._textGuildName:setString(guildName)
    --self._textGuildName:setColor(guildColor)

    self._textUserName:setString(userName)
    --self._textUserName:setColor(guildColor)
    --self._textUserName:setColor(Colors.getOfficialColor(offcielTitle))
end

-- @Role    Update Hp
function CommonEnemyCell:_updateHP(curHp)
    --dump(curHp)
    local index = math.ceil(curHp/2)
    if index <= 0 then
        self._imageBlood:setVisible(false)
        self._textBlood:setString("")
        return
    end

    index = index > 5 and 5 or index
    local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
    self._imageBlood:loadTexture(Path.getGuildCrossImage(GuildCrossWarConst.USER_HP[index]))
    self._imageBlood:ignoreContentAdaptWithSize(true)
    self._textBlood:setString(tostring(curHp))
end

-- @Role    Update effect
function CommonEnemyCell:_createSwordEft()
	local EffectGfxNode = require("app.effect.EffectGfxNode")
	local function effectFunction(effect)
        if effect == "effect_shuangjian"then
            local subEffect = EffectGfxNode.new("effect_shuangjian")
            subEffect:play()
            return subEffect 
        end
    end
    self._swordEffect = G_EffectGfxMgr:createPlayMovingGfx(self._nodeSword, "moving_shuangjian", effectFunction, nil, false )
	self._swordEffect:setPosition(0,0)
	self._swordEffect:setAnchorPoint(cc.p(0.5,0.5))
end

-- @Role    Show Sword
function CommonEnemyCell:_showSword(bVisible)
	if not self._swordEffect then 
		self:_createSwordEft()
	end
	self._swordEffect:setVisible(bVisible)
end


return CommonEnemyCell