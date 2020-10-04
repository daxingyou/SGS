local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupServerListCell = class("PopupServerListCell", ListViewCellBase)
local ServerConst = require("app.const.ServerConst")



--
function PopupServerListCell:ctor()
	local resource = {
		file = Path.getCSB("PopupServerListCell", "login"),
		binding = {
			_button1 = {
				events = {{event = "touch", method = "onButton1"}}
			},
			_button2 = {
				events = {{event = "touch", method = "onButton2"}}
			}
		}
	}
	PopupServerListCell.super.ctor(self, resource)
end

--
function PopupServerListCell:onCreate()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end

--
function PopupServerListCell:update(data1, data2)
	--
	if data1 then
		self._item1:setVisible(true)
		local s1 = data1.server:getStatus()
		self._textName1:setString(data1.server:getName())
		local statusIcon,showStatusIcon = Path.getServerStatusIcon(s1)
		self._ImageStatus1:setVisible(showStatusIcon)
		self._imageType1:setVisible(showStatusIcon and ServerConst.SHOW_BIG_STATUS_ICON[s1] )
		if showStatusIcon   then
			self._ImageStatus1:loadTexture(statusIcon)
		end
		if showStatusIcon and ServerConst.SHOW_BIG_STATUS_ICON[s1]   then
			self._imageType1:loadTexture(Path.getServerStatusBigIcon(s1))
		end

		if data1.role then
			self._textPlayer1:setString(Lang.get("login_select_server_player_info",{value = data1.role:getRole_lv()}))
		else
			self._textPlayer1:setString("")
		end
		
	else
		self._item1:setVisible(false)
	end

	--
	if data2 then
		self._item2:setVisible(true)
		local s2 = data2.server:getStatus()
		self._textName2:setString(data2.server:getName())
		local statusIcon,showStatusIcon = Path.getServerStatusIcon(s2)
		self._ImageStatus2:setVisible(showStatusIcon)
		self._imageType2:setVisible(showStatusIcon and ServerConst.SHOW_BIG_STATUS_ICON[s2] )
		if showStatusIcon then
			self._ImageStatus2:loadTexture(statusIcon)
		end
		if showStatusIcon and ServerConst.SHOW_BIG_STATUS_ICON[s2]  then
			self._imageType2:loadTexture(Path.getServerStatusBigIcon(s2))
		end
		if data2.role then
			self._textPlayer2:setString(Lang.get("login_select_server_player_info",{value = data2.role:getRole_lv()}))
		else
			self._textPlayer2:setString("")
		end
		
	else
		self._item2:setVisible(false)
	end
end

--
function PopupServerListCell:onButton1()
	self:dispatchCustomCallback(1)
end

--
function PopupServerListCell:onButton2()
	self:dispatchCustomCallback(2)
end

--
function PopupServerListCell:onEnter()

end

--
function PopupServerListCell:onExit()

end



return PopupServerListCell
