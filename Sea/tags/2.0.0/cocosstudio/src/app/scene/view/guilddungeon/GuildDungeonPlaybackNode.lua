
local ViewBase = require("app.ui.ViewBase")
local GuildDungeonPlaybackNode = class("GuildDungeonPlaybackNode", ViewBase)
local UserDataHelper = require("app.utils.UserDataHelper")

function GuildDungeonPlaybackNode:ctor()
	local resource = {
		file = Path.getCSB("GuildDungeonPlaybackNode", "guildDungeon"),
		binding = {
		}
	}
	GuildDungeonPlaybackNode.super.ctor(self, resource)
end

function GuildDungeonPlaybackNode:onCreate()

	self:_dealPosByI18n()

    local GuildDungeonPlaybackItemNode = require("app.scene.view.guilddungeon.GuildDungeonPlaybackItemNode")
	self._listItemSource:setTemplate(GuildDungeonPlaybackItemNode)
	self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))
end

function GuildDungeonPlaybackNode:onEnter()
    self._signalGetArenaBattleReport = G_SignalManager:add(SignalConst.EVENT_GET_ARENA_BATTLE_REPORT, handler(self, self._onEventGetArenaBattleReport))

	self._signalGuildDungeonRecordSyn = G_SignalManager:add(SignalConst.EVENT_GUILD_DUNGEON_RECORD_SYN, handler(self, self._onEventGuildDungeonRecordSyn))
	self._signalGuildDungeonMonsterGet = G_SignalManager:add(SignalConst.EVENT_GUILD_DUNGEON_MONSTER_GET, handler(self, self._onEventGuildDungeonMonsterGet))

	self:_updateList()
end

function GuildDungeonPlaybackNode:onExit()
    self._signalGetArenaBattleReport:remove()
	self._signalGetArenaBattleReport = nil

	self._signalGuildDungeonRecordSyn:remove()
	self._signalGuildDungeonRecordSyn = nil

	self._signalGuildDungeonMonsterGet:remove()
	self._signalGuildDungeonMonsterGet = nil
end

function GuildDungeonPlaybackNode:_onEventGetArenaBattleReport(id, message)
	local reportId = message.battle_report

	local function enterFightView(message)
		local ReportParser = require("app.fight.report.ReportParser")
		local battleReport = G_UserData:getFightReport():getReport()
		local fightReportData = G_UserData:getFightReport()
		local reportData = ReportParser.parse(battleReport)
		print("1112233 name officer = ",fightReportData:getRightName(), fightReportData:getRightOfficerLevel(),fightReportData:getLeftName(), fightReportData:getLeftOfficerLevel())
		local battleData = require("app.utils.BattleDataHelper").parseGuildDungeonBattleReportData(message.battle_report, 
			fightReportData:getLeftName(), fightReportData:getLeftOfficerLevel(),
			fightReportData:getRightName(), fightReportData:getRightOfficerLevel())
		G_SceneManager:showScene("fight", reportData, battleData)
	end
	G_SceneManager:registerGetReport(reportId, function() enterFightView(message) end)
	
	-- --获得Cell的数据
	-- local arenaBattleMsg = nil--getReportMsg(reportId)
	-- local battleReport = rawget(message,"battle_report") or {}

	-- local ReportParser = require("app.fight.report.ReportParser")
    -- local reportData = ReportParser.parse(battleReport)

    -- local battleData = require("app.utils.BattleDataHelper").parseGuildDungeonBattleReportData(battleReport)

    -- G_SceneManager:showScene("fight", reportData, battleData)
end

function GuildDungeonPlaybackNode:_onEventGuildDungeonRecordSyn(event)
	self:_updateList()
end

function GuildDungeonPlaybackNode:_onEventGuildDungeonMonsterGet(event)
	self:_updateList()
end


function GuildDungeonPlaybackNode:updateView()

end

function GuildDungeonPlaybackNode:_updateList()
	self._listData = UserDataHelper.getGuildDungeonSortedRecordList()
	self._listItemSource:clearAll()
	self._listItemSource:resize(#self._listData)
end

function GuildDungeonPlaybackNode:_onItemUpdate(item, index)
	if self._listData[index + 1] then
		item:update(self._listData[index + 1],index + 1)
	end
end

function GuildDungeonPlaybackNode:_onItemSelected(item, index)
end

function GuildDungeonPlaybackNode:_onItemTouch(index,reportId)
    local data = self._listData[index + 1]
    if data then
         G_NetworkManager:send(MessageIDConst.ID_C2S_GetBattleReport, {id = reportId})
	end
end


function GuildDungeonPlaybackNode:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self._imageRoot,"Image_1")
		local image2 = UIHelper.seekNodeByName(self._imageRoot,"Image_2")
		local image3 = UIHelper.seekNodeByName(self._imageRoot,"Image_3")
		
		local text61 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_1")
		local text63 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_3")
 
 
        image1:setPositionX(image1:getPositionX() + 35)
		image2:setPositionX(image2:getPositionX() + 35)
		image3:setPositionX(image3:getPositionX() + 20)
		image1:setContentSize(cc.size(3,image1:getContentSize().height))
		image2:setContentSize(cc.size(2,image2:getContentSize().height))
		image3:setContentSize(cc.size(2,image3:getContentSize().height))
		
 		text61:setPositionX(text61:getPositionX() + 35)
 		text63:setPositionX(text63:getPositionX() + 35)
		
	end
end


return GuildDungeonPlaybackNode 