

[{"name":"1-Tào Tháo","status":4,"server":"30010001","opentime":"1521597600"},
{"name":"2-Lưu Bị","status":4,"server":"30010002","opentime":"1521597600"},
{"name":"Submit","status":2,"server":"4","opentime":"1521597600"},
{"name":"Time Test","status":2,"server":"997","opentime":"1521597600"}]



[{"name":"submit","status":2,"server":"4","opentime":"1521597600"},
{"name":"time","status":2,"server":"997","opentime":"1521597600"},
{"name":"S1-Tào Tháo","status":4,"server":"30010001","opentime":"1521597600"}]


[{"name":"S1-Tào Tháo","status":4,"server":"30010001","opentime":"1521597600"}]



[{"name":"S1-Tào Tháo","status":4,"server":"30010001","opentime":"1521597600"},
{"name":"Time Test","status":2,"server":"997","opentime":"1521597600"}]


[{"name":"submit","status":2,"server":"4","opentime":"1521597600"},
{"name":"time","status":2,"server":"997","opentime":"1521597600"}]




xpcall(function (  )

end,function( ... )
end)





local PopupNotice = require("app.ui.PopupNotice")
PopupNotice.onCreate = function(self)
	self._popupBG:setTitle("test code")
end
local PopupNotice = require("app.ui.PopupNotice")
PopupNotice.onCreate = function(self)
	if not Lang.checkLang(Lang.CN) then
		self._popupBG:setTitle(self._title or  Lang.getImgText("login_billboard") )
	else
		self._popupBG:setTitle(self._title or "公   告")
	end
	self._popupBG:addCloseEventListener(function ()
		self:closeWithAction()
	end)
	self._commonButton:setString(Lang.get("login_notice_know"))

    self._popupBG:setTitle("test code")
end	




{
"e5c4bc3cee46c69c8e4a4ffd7240a979c14d5dfd":"zhanglinsen",
"1696e019c1354de9e53654537a89c69deae283bf":"fanmiao",
"8cc83990e140810202aefe4b705f3b0bc40a116e":"meiwei",
"03f22138c3d8cea0219eab8d10b122dc336d97ac":"haochaliang",
"eba56fd5e5e9323afefff562c54d0d23d65cffd8":"likaiming",
"a3766110_sn":"yktest0",
"59eeced29804_sn":"vn0",
"3300a5468ea262d1_sn":"vn1",
"ffc199e31f0f9c3ea435103bc93f75e34be016ad":"vn2",
"54A885EF-81C6-4B23-BC9F-17F730134C9D":"vn3",
"00f267640f7d30d1_sn":"vn4",
"44c4da31854fc4dd_sn":"vn5",
"0037c34e_sn":"vn6"
}



-- for module display
CC_DESIGN_RESOLUTION = {
    width = 1136,
    height = 640,
    autoscale = "FIXED_WIDTH", --"FIXED_HEIGHT",
    callback = function(framesize)
        local ratio = framesize.width / framesize.height
        print(framesize.width, framesize.height, ratio)
        -- self._designSize = cc.size(math.min(CC_DESIGN_RESOLUTION.width, display.width),math.min(CC_DESIGN_RESOLUTION.height, display.height))
        -- if framesize.height >= 640 and ratio <= 1.8 then
        --     _width = math.min(framesize.width, 1136)
        --     if _width < 1136 then _width = 1136 end
        --     return {width = _width, height = 640,autoscale = "EXACT_FIT"}
        --     -- return {width = math.min(framesize.width, 1136), height = 640,autoscale = "EXACT_FIT"}
        -- end
        if ratio > 1.8 then
            return {width = 1400, height = 640,autoscale = "FIXED_HEIGHT"}
        end
    end
}





















-- iphoneX公告清除缓存
local NativeAgent = require("app.agent.NativeAgent")
local name = NativeAgent.callStaticFunction("getDeviceModel", nil, "string")
if name == "iPhone10,3" or name == "iPhone10,6" then
	local PopupNotice = require("app.ui.PopupNotice")
	PopupNotice.onShowFinish = function(self)
		local discSize = self._webLayer:getContentSize()
		if ccexp.WebView then
	        self._webView = ccexp.WebView:create()
	        self._webView:setPosition(cc.p(discSize.width/2,  discSize.height/2))
	        self._webView:setContentSize(discSize.width,  discSize.height)
	        self._webView:loadURL(self._url, true)
	        self._webView:setScalesPageToFit(false)
	        self._webView:setBounces(false)

	        self._webLayer:addChild(self._webView)
	    end
	end
end

xpcall(function (  )
	local StateDamage = require("app.fight.states.StateDamage")
	local BuffManager = require("app.fight.BuffManager")

	StateDamage.onFinish = function(self)
		if self._isLastBuff then 
			local buffManager = BuffManager.getBuffManager()
			buffManager:checkDelBefore()
			buffManager:clearBuffEffect(self._entity.stageID)
		end
		self._entity.is_alive = self._entity.to_alive
		if not self._entity.is_alive then
			self._entity:dispatchDie()
		end
		StateDamage.super.onFinish(self)
	end
	
	local LoopAttackBase = require("app.fight.loop.LoopAttackBase")
	LoopAttackBase._processBuffEffect = function(self)
		for _, buffData in pairs(self._data.buffEffects) do
			local data = self:_processBuff(buffData)
			self._buffManager:addBuffEffect(data, self._unit.stageID)
		end		
	end

	LoopAttackBase.execute = function(self)
		for i, v in pairs(self._targets.cell) do
			v.unit.attackIndex = self._index
	   end
	   -- 计算伤害
	   for i,v in ipairs(self._targets.list) do
		   local target = v.unit
		   local info = v.info
		   if info.type == 1 then
			   target.hp = target.hp - info.value
			   if target.hp < 0 then
				   target.hp = 0
			   end
		   else
		   
		   end
	   end
	   self._finish = false
	   self:_startSkill()
	end

	BuffManager.addBuffEffect = function(self, data, stageID)
		if not self._buffEffect[stageID] then 
			self._buffEffect[stageID] = {}
		end
		table.insert(self._buffEffect[stageID], data)	
	end

	BuffManager._checkBuffEffect = function(self, stageId)
		if not self._buffEffect[stageId] or #self._buffEffect[stageId] == 0 then 
			return 
		end
		local unit = self._engine:getUnitById(stageId)
		assert(unit, "stage id is nil = "..stageId)    
		unit:damage(self._buffEffect[stageId])
	end

	BuffManager.clearBuffEffect = function(self, stageId)
		self._buffEffect[stageId] = {}
	end


end,function( ... )
end)

local HeroSkillEffect = require("app.config.hero_skill_effect")
HeroSkillEffect.set(2376, "buff_pos", 12)

