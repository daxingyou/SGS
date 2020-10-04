xpcall(function ()
	-- 发送登陆协议
	local Version = require("yoka.utils.Version")
	local GameAgent  = require("app.agent.GameAgent")
	GameAgent._sendLoginGame = function(self,token, sid, channel_id, device_id)
		--release_print("GameAgent:_sendLoginGame: Lang.channel = " .. Lang.channel)
		--release_print("GameAgent:_sendLoginGame: Lang.lang = " .. Lang.lang)
		local language = Lang.channel .. "_" .. Lang.lang
		--release_print("GameAgent:_sendLoginGame: language = " .. language)
		G_NetworkManager:send(MessageIDConst.ID_C2S_Login, {
			token       = token,
			sid         = sid,
			channel_id  = channel_id,
			device_id   = device_id,
			version     = Version.toNumber(VERSION_RES),
			language    = language
		})
	end
end,function( ... )
end)


xpcall(function ()
	local Version = require("yoka.utils.Version")
	local r = Version.compare("0.0.1", VERSION_RES)
	if r == Version.CURRENT then
		local RedPacketRainRankCell = require("app.scene.view.redPacketRain.RedPacketRainRankCell")
		local RedPacketRainRankNode = require("app.scene.view.redPacketRain.RedPacketRainRankNode")
		RedPacketRainRankNode.onCreate = function(self)
			if Lang.checkLang(Lang.KR) then
				local UIHelper  = require("yoka.utils.UIHelper")
				local titleCount = UIHelper.seekNodeByName(self,"titleCount")
				titleCount:setString(Lang.get("mission_star_rank_count"))
				local titleName = UIHelper.seekNodeByName(self,"titleName")
				titleName:setString(Lang.get("mission_star_rank_name"))
				local TextPacketCount = UIHelper.seekNodeByName(self,"TextPacketCount")
				TextPacketCount:setString("보너스")
				local TextMoneyCount = UIHelper.seekNodeByName(self,"TextMoneyCount")
				TextMoneyCount:setString("금화")
			end
			self._listInfo = {}
			self._nodeBg:addCloseEventListener(handler(self, self._onCloseClick))
			self._nodeBg:setTitle(Lang.get("red_packet_rain_rank_title"))
			self._listView:setTemplate(RedPacketRainRankCell)
			self._listView:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
			self._listView:setCustomCallback(handler(self, self._onItemTouch))
			self._myCell = RedPacketRainRankCell.new()
			self._nodeMyInfo:addChild(self._myCell)
			self._nodeBg:setVisible(false)
		end
	end
end,function( ... )
end)

xpcall(function ()
	local function_level_1 = require("app.config.function_level_1")
	function_level_1.set(639,"name","특별\n이벤트")  
end,function( ... )
end)