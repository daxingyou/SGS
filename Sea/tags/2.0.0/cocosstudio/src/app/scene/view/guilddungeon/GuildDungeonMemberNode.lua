
local ViewBase = require("app.ui.ViewBase")
local GuildDungeonMemberNode = class("GuildDungeonMemberNode", ViewBase)
local UserDataHelper = require("app.utils.UserDataHelper")

function GuildDungeonMemberNode:ctor()
	local resource = {
		file = Path.getCSB("GuildDungeonMemberNode", "guildDungeon"),
		binding = {
		}
	}
	GuildDungeonMemberNode.super.ctor(self, resource)
end

function GuildDungeonMemberNode:onCreate()
	if not Lang.checkLang(Lang.CN) then
		self:_dealPosByI18n()
	end
    local GuildDungeonMemberItemNode = require("app.scene.view.guilddungeon.GuildDungeonMemberItemNode")
	self._listItemSource:setTemplate(GuildDungeonMemberItemNode)
	self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))
end

function GuildDungeonMemberNode:onEnter()
	self._signalGuildDungeonRecordSyn = G_SignalManager:add(SignalConst.EVENT_GUILD_DUNGEON_RECORD_SYN, handler(self, self._onEventGuildDungeonRecordSyn))
	self._signalGuildDungeonMonsterGet = G_SignalManager:add(SignalConst.EVENT_GUILD_DUNGEON_MONSTER_GET, handler(self, self._onEventGuildDungeonMonsterGet))

	self:_updateList()
end

function GuildDungeonMemberNode:onExit()
	self._signalGuildDungeonRecordSyn:remove()
	self._signalGuildDungeonRecordSyn = nil

	self._signalGuildDungeonMonsterGet:remove()
	self._signalGuildDungeonMonsterGet = nil
end

function GuildDungeonMemberNode:_onEventGuildDungeonRecordSyn(event)
	self:_updateList()
end

function GuildDungeonMemberNode:_onEventGuildDungeonMonsterGet(event)
	self:_updateList()
end

function GuildDungeonMemberNode:updateView()
end

function GuildDungeonMemberNode:_updateList()
	self._listData = UserDataHelper.getGuildDungeonMemberList()
	self._listItemSource:clearAll()
	self._listItemSource:resize(#self._listData)
end

function GuildDungeonMemberNode:_onItemUpdate(item, index)
	if self._listData[index + 1] then
		item:update(self._listData[index + 1],index + 1)
	end
end

function GuildDungeonMemberNode:_onItemSelected(item, index)
end

function GuildDungeonMemberNode:_onItemTouch(index)
end

function GuildDungeonMemberNode:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self._imageRoot,"Image_1")
		local image2 = UIHelper.seekNodeByName(self._imageRoot,"Image_2")
		local image3 = UIHelper.seekNodeByName(self._imageRoot,"Image_3")
		local image4 = UIHelper.seekNodeByName(self._imageRoot,"Image_4")
        image1:setContentSize(cc.size(2,image1:getContentSize().height))
		image2:setContentSize(cc.size(2,image2:getContentSize().height))
		image3:setContentSize(cc.size(2,image3:getContentSize().height))
		image4:setContentSize(cc.size(2,image4:getContentSize().height))
	end
end


return GuildDungeonMemberNode 