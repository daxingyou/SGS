
local ViewBase = require("app.ui.ViewBase")
local GuildDungeonRankNode = class("GuildDungeonRankNode", ViewBase)
local UserDataHelper = require("app.utils.UserDataHelper")

function GuildDungeonRankNode:ctor()
    self._myGuildRankNode = nil--我的排名
    self._myGuildRankItem = nil
    self._imageArrow = nil
    self._imageArrowBg = nil
    self._isFold = false--
	local resource = {
		file = Path.getCSB("GuildDungeonRankLayer", "guildDungeon"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
            _imageArrowBg = {
				events = {{event = "touch", method = "_onButtonArrow"}}
			},
		}
	}
	GuildDungeonRankNode.super.ctor(self, resource)
end

function GuildDungeonRankNode:onCreate()
	-- i18n change lable
	self:_swapImageByI18n()

	self:_dealPosByI18n()
    local GuildDungeonRankItem = require("app.scene.view.guilddungeon.GuildDungeonRankItem")
	self._listItemSource:setTemplate(GuildDungeonRankItem)
	self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))

    self._myGuildRankItem = GuildDungeonRankItem.new()
    self._myGuildRankNode:addChild(self._myGuildRankItem)
end

function GuildDungeonRankNode:onEnter()
    self._signalGuildDungeonRecordSyn = G_SignalManager:add(SignalConst.EVENT_GUILD_DUNGEON_RECORD_SYN, handler(self, self._onEventGuildDungeonRecordSyn))
	self._signalGuildDungeonMonsterGet = G_SignalManager:add(SignalConst.EVENT_GUILD_DUNGEON_MONSTER_GET, handler(self, self._onEventGuildDungeonMonsterGet))

    self:_updateList()
    self:_refreshMyGuildRank()
end

function GuildDungeonRankNode:onExit()
	self._signalGuildDungeonRecordSyn:remove()
	self._signalGuildDungeonRecordSyn = nil

	self._signalGuildDungeonMonsterGet:remove()
	self._signalGuildDungeonMonsterGet = nil
end

function GuildDungeonRankNode:_onEventGuildDungeonRecordSyn(event)
	self:_updateView()
end

function GuildDungeonRankNode:_onEventGuildDungeonMonsterGet(event)
	self:_updateView()
end


function GuildDungeonRankNode:_updateList()
	self._listData = UserDataHelper.getGuildDungeonSortedRankList()
	self._listItemSource:clearAll()
	self._listItemSource:resize(#self._listData)
end

function GuildDungeonRankNode:_onItemUpdate(item, index)
	if self._listData[index + 1] then
		item:updateUI(self._listData[index + 1],index + 1)
	end
end

function GuildDungeonRankNode:_onItemSelected(item, index)
end

function GuildDungeonRankNode:_onItemTouch(index)

end

function GuildDungeonRankNode:_refreshMyGuildRank()
    local rankData = UserDataHelper.getMyGuildDungeonRankData()
    self._myGuildRankItem:updateUI(rankData,1)
end

function GuildDungeonRankNode:_closeWindow(fold)
    self:stopAllActions()
    local posX = self._imageArrowBg:getPositionX()
    local callAction = cc.CallFunc:create(function()
        self._imageArrow:setScale(fold and -1 or 1)
	end)
	local action = cc.MoveTo:create(0.3,cc.p(fold and -posX or 0,self._node_LeftTop:getPositionY()))
	local runningAction = cc.Sequence:create(action,callAction)
	self._node_LeftTop:runAction(runningAction)
end

function GuildDungeonRankNode:_onButtonArrow(sender)
    self._isFold = not self._isFold
    self:_closeWindow(self._isFold)
end


function GuildDungeonRankNode:_updateView()
	self:_updateList()
    self:_refreshMyGuildRank()
end


-- i18n change lable
function GuildDungeonRankNode:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local image1 = UIHelper.seekNodeByName(self._node_LeftTop, "Image_1","Image_8")

		UIHelper.swapWithLabel(image1,{
			 style = "countryboss_2",
			 text = Lang.getImgText("txt_boss_jifen01"),
		})
		

	end
end


function GuildDungeonRankNode:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then

		local UIHelper  = require("yoka.utils.UIHelper")
		local imageBg = UIHelper.seekNodeByName(self._node_LeftTop, "Image_1")
		local size = imageBg:getContentSize()
		imageBg:setAnchorPoint(cc.p(0,0.5))
		imageBg:setPositionX(0)
		imageBg:setContentSize(cc.size(size.width,size.height))

		local size2 = self._listItemSource:getContentSize()
		self._listItemSource:setContentSize(cc.size(size2.width,size2.height))

		local image22 = UIHelper.seekNodeByName(self._node_LeftTop, "Image_1","Image_2")
		image22:setPositionX((size.width) * 0.5)
	
		self._imageArrowBg:setPositionX(self._imageArrowBg:getPositionX())


		local text1 = UIHelper.seekNodeByName(self._node_LeftTop, "Image_1","Text_6")
		local text2 = UIHelper.seekNodeByName(self._node_LeftTop, "Image_1","Text_6_0")
		local text3 = UIHelper.seekNodeByName(self._node_LeftTop, "Image_1","Text_6_1")
		local text4 = UIHelper.seekNodeByName(self._node_LeftTop, "Image_1","Text_6_2")
		text2:setPositionY(text1:getPositionY())
		text3:setPositionY(text1:getPositionY())
		text4:setPositionY(text1:getPositionY())

		if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
			text2:setVisible(false)
			text1:setPositionX(text1:getPositionX()+15)
			text3:setPositionX(text3:getPositionX()-15)
		end
	end
end




return GuildDungeonRankNode 