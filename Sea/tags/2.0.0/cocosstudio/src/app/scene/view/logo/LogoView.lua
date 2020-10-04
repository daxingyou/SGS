local ViewBase = require("app.ui.ViewBase")
local LogoView = class("LogoView", ViewBase)

local scheduler = require("cocos.framework.scheduler")
--
function LogoView:onCreate()
end

--
function LogoView:isRootScene()
	return true
end

--
function LogoView:onEnter()
	--self:showTips()
	-- if Lang.checkLang(Lang.KR) then
    -- 	local VideoHelper = require("app.i18n.utils.VideoHelper")
    -- 	local videoList = {
    -- 		"GAMEPUB logo_width.mp4",
    -- 	}
    -- 	VideoHelper.showLogoVideos(self,videoList,handler(self, self.showLogo))
	-- else
    	self:showLogo()
    
	-- end
-- self:onNextStep()
end

--
function LogoView:showTips()
    self:_show("other/tip.jpg", handler(self, self.showLogo))
end

--
function LogoView:showLogo()
    self:_show("other/logo.png", handler(self, self.onNextStep))
    local layerColor =
        cc.LayerColor:create(
        cc.c4b(255, 255, 255, 255),
        G_ResolutionManager:getDesignWidth(),
        G_ResolutionManager:getDesignHeight()
    )
    self:addChild(layerColor)
end

--
function LogoView:_show(img, fun)
    --self:removeAllChildren()

    local s = cc.Sprite:create(img)
    self:addChild(s, 100)
    s:setPosition(G_ResolutionManager:getDesignCCPoint())
    s:setOpacity(0)

    s:runAction(
        cc.Sequence:create(
            cc.FadeIn:create(0.4),
            cc.DelayTime:create(1),
            cc.FadeOut:create(0.4),
            cc.CallFunc:create(
                function()
                    fun()
                end
            )
        )
    )
end

function LogoView:onNextStep()
	local CGHelper = require("app.scene.view.cg.CGHelper")
	if CGHelper.checkCG() then
			self:startCG()
	else
			self:onStartLogin()
	end
	-- self:onStartLogin()
end

function LogoView:startCG()
	G_SceneManager:showScene("cg", "start.mp4")
end

--
function LogoView:onStartLogin()
	G_SceneManager:showScene("login")
end

return LogoView