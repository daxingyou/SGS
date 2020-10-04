local HitTipParticle = require("app.fight.views.HitTip.HitTipParticle")
local HitTipFeature = class("HitTipFeature", HitTipParticle)

local BuffManager = require("app.fight.BuffManager")

-- i18n change skill
function HitTipFeature:ctor(skillPath, callBack,skillInfo)
    HitTipFeature.super.ctor(self, "feature")
    self._picPath = Path.getTalent(skillPath)
    self._callBack = callBack

    -- i18n change skill
    if not Lang.checkLang(Lang.CN) then
        self._skillInfo = skillInfo
    end	
end

function HitTipFeature:popup()
	local function effectFunc(effect)
		if effect == "tianfu_id_r" or effect == "tianfu_id_l" then
            -- i18n change skill
            if not Lang.checkLang(Lang.CN) then
                local UIHelper = require("yoka.utils.UIHelper")
                local TypeConst = require("app.i18n.utils.TypeConst")
                local name = self._skillInfo.name or ""
                local subLabel = UIHelper.createLabel({text=name,style="talent",styleType=TypeConst.TEXT})
                return subLabel
            else    
                return display.newSprite(self._picPath)
            end	
		end
    end
    local function eventFunc(event)
        if event == "boom" then
           if self._callBack then
                self._callBack()
           end
        end
    end
    local effect = G_EffectGfxMgr:createPlayMovingGfx( self._node, "moving_tianfu_id", effectFunc, eventFunc, true )
end



return HitTipFeature