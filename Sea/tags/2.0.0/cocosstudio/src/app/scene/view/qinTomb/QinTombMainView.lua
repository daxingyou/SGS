local ViewBase = require("app.ui.ViewBase")
local QinTombMainView = class("QinTombMainView", ViewBase)
local Path = require("app.utils.Path")
local AudioConst = require("app.const.AudioConst")

function QinTombMainView:waitEnterMsg(callBack)
	local function onMsgCallBack()
		callBack()
	end
	onMsgCallBack()
	
	--[[
	local currState = RunningManHelp.getRunningState()
	--赌注信息
	G_UserData:getRunningMan():c2sPlayHorseInfo()
	local signal = G_SignalManager:add(SignalConst.EVENT_PLAY_HORSE_INFO_SUCCESS, onMsgCallBack)
	return signal
	]]

end


function QinTombMainView:ctor()
	self._scrollMap = nil	--底图
	self._topBar = nil		--顶部条

	local resource = {
		file = Path.getCSB("QinTombMainView", "qinTomb"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
		}
	}

	
	self:setName("QinTombMainView")
	QinTombMainView.super.ctor(self, resource)
end

function QinTombMainView:onCreate()
    self._topBar:setImageTitle("txt_sys_com_youli")
 	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topBar:updateUI(TopBarStyleConst.STYLE_EXPLORE)


	
end





function QinTombMainView:onEnter()
	

	G_AudioManager:playMusicWithId(AudioConst.MUSIC_EXPLORE)

end

function QinTombMainView:onExit()
	
end

return QinTombMainView
