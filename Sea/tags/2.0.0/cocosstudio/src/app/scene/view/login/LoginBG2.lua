local ViewBase = require("app.ui.ViewBase")
local LoginBG = class("LoginBG", ViewBase)

--
function LoginBG:ctor()
	LoginBG.super.ctor(self, nil)
end

--
function LoginBG:onCreate()
	local s = cc.Sprite:create("channel_login.jpg")
	if s then
		self:addChild(s)
	end
end

--
function LoginBG:onEnter()
    
end

--
function LoginBG:onExit()

end


return LoginBG