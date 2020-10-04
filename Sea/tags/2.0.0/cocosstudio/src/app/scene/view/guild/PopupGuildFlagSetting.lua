local PopupBase = require("app.ui.PopupBase")
local PopupGuildFlagSetting = class("PopupGuildFlagSetting", PopupBase)
local GuildFlagColorItemCell = require("app.scene.view.guild.GuildFlagColorItemCell")

PopupGuildFlagSetting.FLAG_NUM = 10

function PopupGuildFlagSetting:ctor()
    self._flagItems = {}
    self._selectIndex = nil
	local resource = {
		file = Path.getCSB("PopupGuildFlagSetting", "guild"),
		binding = {
		}
	}
	PopupGuildFlagSetting.super.ctor(self, resource, true)
end

function PopupGuildFlagSetting:onCreate()
     self._popBase:setTitle(Lang.get("guild_flag_setting_title"))

     for i = 1,PopupGuildFlagSetting.FLAG_NUM,1 do
        local nodeFlagColor =  self["_nodeFlagColor"..tostring(i)]
        local item = GuildFlagColorItemCell.new()
        item:setCustomCallback(handler(self,self._onItemTouch))
        item:setTag(i)
        item:updateUI(i)
        item:setTouchEnabled(true)
        local size = item:getContentSize()
        item:setPosition(size.width*0.5,size.height*0.5)
        nodeFlagColor:addChild(item)
        self._flagItems[i] = item
    end

      
    self._buttonOk:setString(Lang.get("common_btn_name_confirm"))
    self._buttonOk:addClickEventListenerEx(handler(self,self._onClickButtonOK))
    
    local myGuild = G_UserData:getGuild():getMyGuild()
	assert(myGuild, "G_UserData:getGuild():getMyGuild() = nil")
    local icon =  myGuild:getIcon()

    self._selectIndex = icon

    self:_selectColor(icon)
    self:_updateFlagColor(icon)
end

function PopupGuildFlagSetting:onEnter()
	self._signalGuildFlagChange = G_SignalManager:add(SignalConst.EVENT_GUILD_FLAG_CHANGE, handler(self, self._onEventGuildFlagChange))
    --EVENT_GUILD_BASE_INFO_UPDATE
end

function PopupGuildFlagSetting:onExit()
	self._signalGuildFlagChange:remove()
	self._signalGuildFlagChange = nil
end

function PopupGuildFlagSetting:_onEventGuildFlagChange(event,rewards)
    self:close()
    G_Prompt:showTip(Lang.get("guild_flag_setting_success_tip"))
end

function PopupGuildFlagSetting:_onClickClose()
	self:close()
end

function PopupGuildFlagSetting:_onClickButtonOK()
    local iconId = self._selectIndex
	G_UserData:getGuild():c2sChangeGuildIcon(iconId)
end

function PopupGuildFlagSetting:_updateList()
end

function PopupGuildFlagSetting:_onItemTouch(index)
    self._selectIndex = index
    self:_selectColor(index)
    self:_updateFlagColor(index)
end

function PopupGuildFlagSetting:_selectColor(index)
    for k,v in ipairs(self._flagItems) do
        if k == index  then
            v:setSelect(true)
        else
            v:setSelect(false)    
        end
    end
end

function PopupGuildFlagSetting:_updateFlagColor(index) 
    local myGuild = G_UserData:getGuild():getMyGuild()
	assert(myGuild, "G_UserData:getGuild():getMyGuild() = nil")
	local name = myGuild:getName()
    local icon = index
    self._commonGuildFlag:updateUI(icon,name)
  
end

return PopupGuildFlagSetting
