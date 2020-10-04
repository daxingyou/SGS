--
-- Author: Liangxu
-- Date: 2017-06-22 15:14:04
-- 军团大厅成员列表
local ViewBase = require("app.ui.ViewBase")
local GuildMemberListNode = class("GuildMemberListNode", ViewBase)
local GuildMemberListCell = require("app.scene.view.guild.GuildMemberListCell")
local PopupGuildMemberInfo = require("app.scene.view.guild.PopupGuildMemberInfo")
local PopupGuildCheckApplication = require("app.scene.view.guild.PopupGuildCheckApplication")
local GuildConst = require("app.const.GuildConst")
local GuildUIHelper = require("app.scene.view.guild.GuildUIHelper")
local UserDataHelper = require("app.utils.UserDataHelper")

function GuildMemberListNode:ctor()
	self._categorySortFlag = {}
	self._lastestSortCategory = nil--按照默认排序
	local resource = {
		file = Path.getCSB("GuildMemberListNode", "guild"),
		binding = {
			_btnQuit = {
				events = {{event = "touch", method = "_onButtonQuit"}}
			},
			_btnDeclaration = {
				events = {{event = "touch", method = "_onButtonDeclaration"}}
			},
			_btnApplyList = {
				events = {{event = "touch", method = "_onButtonApplyList"}}
			},
			_btnSendMail = {
				events = {{event = "touch", method = "_onButtonSendMail"}}
			},
		}
	}
	GuildMemberListNode.super.ctor(self, resource)
end

function GuildMemberListNode:onCreate()
	-- i18n pos lable
	self:_dealPosByI18n()
	self._listItemSource:setTemplate(GuildMemberListCell)
	self._listItemSource:setCallback(handler(self, self._onItemUpdate), handler(self, self._onItemSelected))
	self._listItemSource:setCustomCallback(handler(self, self._onItemTouch))

	self._btnQuit:setString(Lang.get("guild_btn_quit_guild"))
	self._btnDeclaration:setString(Lang.get("guild_title_declaration"))
	self._btnApplyList:setString(Lang.get("guild_btn_check_application"))
	self._btnSendMail:setString(Lang.get("guild_btn_mail"))
	
	for i = 1,7,1 do--7个分类
		local titlePanel = self["_titlePanel"..i]
		if titlePanel then
			self._categorySortFlag[i] = nil --标记成降序排序
			if i == 4 then--职位类
				self._categorySortFlag[i] = false
				titlePanel:updateImageView("Image", {visible = true} )
			else
				titlePanel:updateImageView("Image", {visible = false} )
			end
		
			titlePanel:setTag(i)
			titlePanel:addClickEventListenerEx(handler(self,self._onButtonTitle))
		end
	end
	
end

function GuildMemberListNode:onEnter()
	self._signalGuildQueryMall = G_SignalManager:add(SignalConst.EVENT_GUILD_QUERY_MALL, handler(self, self._onEventGuildQueryMall))
	self._signalKickSuccess = G_SignalManager:add(SignalConst.EVENT_GUILD_KICK_NOTICE, handler(self, self._onEventGuildKickNotice))
	self._signalRedPointUpdate = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self,self._onEventRedPointUpdate))
	self._signalGuildUserPositionChange = G_SignalManager:add(SignalConst.EVENT_GUILD_USER_POSITION_CHANGE, handler(self, self._onEventGuildUserPositionChange))
	self._signalPromoteSuccess = G_SignalManager:add(SignalConst.EVENT_GUILD_PROMOTE_SUCCESS, handler(self, self._onEventGuildPromoteSuccess))
	self._signalMailOnSendMail = G_SignalManager:add(SignalConst.EVENT_MAIL_ON_SEND_MAIL, handler(self, self._onEventMailOnSendMail))
	
	self:_refreshRedPoint()
	self:_refreshBtnState()
end

function GuildMemberListNode:onExit()
	self._signalGuildUserPositionChange:remove()
	self._signalGuildUserPositionChange = nil


	self._signalGuildQueryMall:remove()
	self._signalGuildQueryMall = nil


	self._signalPromoteSuccess:remove()
	self._signalPromoteSuccess = nil

	self._signalKickSuccess:remove()
	self._signalKickSuccess = nil

	self._signalRedPointUpdate:remove()
	self._signalRedPointUpdate = nil

	self._signalMailOnSendMail:remove()
	self._signalMailOnSendMail = nil
end


function GuildMemberListNode:_onEventGuildUserPositionChange(event)
	if not G_UserData:getGuild():isInGuild() then
		return
	end
	self:_refreshBtnState()
end

--提升职位
function GuildMemberListNode:_onEventGuildPromoteSuccess(eventName, uid, op)
	if not G_UserData:getGuild():isInGuild() then
		return
	end
	self:updateView()
end

--踢出
function GuildMemberListNode:_onEventGuildKickNotice(eventName, uid)
	if not G_UserData:getGuild():isInGuild() then
		return
	end
	if uid ~= G_UserData:getBase():getId() then
		self:updateView()
	end
end

function GuildMemberListNode:_onEventRedPointUpdate(event,funcId,param)
	if not G_UserData:getGuild():isInGuild() then
		return
	end
	if funcId and funcId ~= FunctionConst.FUNC_ARMY_GROUP then
		return
	end
	self:_refreshRedPoint()
end

function GuildMemberListNode:_onEventGuildQueryMall()
	if not G_UserData:getGuild():isInGuild() then
		return
	end
	self:_updateList()
end

function GuildMemberListNode:_onEventMailOnSendMail()
	 G_Prompt:showTip(Lang.get("mail_send_success_tips"))
end

function GuildMemberListNode:updateView()
	G_UserData:getGuild():c2sQueryGuildMall()
end

function GuildMemberListNode:_updateList()
	self._guildMemberList = UserDataHelper.getGuildMemberListBySort(
		self._lastestSortCategory,
		 self._categorySortFlag[self._lastestSortCategory] )
	self._listItemSource:clearAll()
	self._listItemSource:resize(#self._guildMemberList)

	self:_refreshRedPoint()
end

function GuildMemberListNode:_onItemUpdate(item, index)
	if self._guildMemberList[index + 1] then
		item:update(self._guildMemberList[index + 1],index + 1)
	end
end

function GuildMemberListNode:_onItemSelected(item, index)
	--取出玩家阵容
	local data = self._guildMemberList[index + 1]
	if data then
		local isSelf = data:isSelf()
		if isSelf then
			return
		end

		local popup = PopupGuildMemberInfo.new(data)
		popup:openWithAction()
	end
end

function GuildMemberListNode:_onItemTouch(index)
end


function GuildMemberListNode:_onButtonQuit(sender)
	GuildUIHelper.quitGuild()
end

--修改宣言
function GuildMemberListNode:_onButtonDeclaration(sender)
	local lv = UserDataHelper.getParameter(G_ParameterIDConst.GUILD_DECLARATION_LV) 
	if G_UserData:getGuild():getMyGuildLevel() < lv then
		G_Prompt:showTip(Lang.get("guild_publish_declare_tips",{value = lv}))
		return
	end

	
	local PopupGuildAnnouncement = require("app.scene.view.guild.PopupGuildAnnouncement")
	local popup = nil
	if Lang.checkLang(Lang.CN) then
		popup = PopupGuildAnnouncement.new(handler(self, self._onSaveDeclaration))
	else
		local UIHelper  = require("yoka.utils.UIHelper")
		popup = PopupGuildAnnouncement.new(handler(self, self._onSaveDeclaration),
			UIHelper.getInputLimitedConfig().legion_declaration_length)
	end
	popup:setTitle(Lang.get("guild_title_declaration"))
	local content = UserDataHelper.getGuildDeclaration(self._myGuild)  
	popup:setContent(content)
	popup:openWithAction()
end

--保存宣言
function GuildMemberListNode:_onSaveDeclaration(content)
	G_UserData:getGuild():c2sSetGuildMessage(content, GuildConst.GUILD_MESSAGE_TYPE_2)
end

--军团申请
function GuildMemberListNode:_onButtonApplyList(sender)
	local popup = PopupGuildCheckApplication.new()
	popup:openWithAction()
end

--军团邮件
function GuildMemberListNode:_onButtonSendMail(sender)
	local PopupGuildSendMail = require("app.scene.view.guild.PopupGuildSendMail")
	local popup = PopupGuildSendMail.new()
	popup:openWithAction()
end

function GuildMemberListNode:_onButtonTitle(sender)
	local tag = sender:getTag() 
	logWarn("GuildMemberListNode  "..tag.."  "..tostring(self._categorySortFlag[tag]) )

	if  self._categorySortFlag[tag] == nil then
		self._categorySortFlag[tag]  = false
	else
		self._categorySortFlag[tag] = not self._categorySortFlag[tag]
	end

	self._lastestSortCategory = tag

	self:_refreshOrderArrow()
	
	self:_updateList()
	
	
end

function GuildMemberListNode:_refreshOrderArrow()

	for i = 1,7,1 do--7个分类
		local titlePanel = self["_titlePanel"..i]
		if titlePanel then
			local image = ccui.Helper:seekNodeByName(titlePanel, "Image") 
			if self._lastestSortCategory == i then
				image:setVisible(true)
				image:setScaleY(self._categorySortFlag[i] and -1 or 1)
			else
				image:setVisible(false)
			end
			
		end
	end

end

function GuildMemberListNode:_refreshRedPoint()
	 local RedPointHelper = require("app.data.RedPointHelper")
	 local redPointShow = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_ARMY_GROUP,"checkApplicationRP")
	 self._btnApplyList:showRedPoint(redPointShow)
end

function GuildMemberListNode:_refreshBtnState()
	local haveCheckApplyPermission = UserDataHelper.isHaveGuildPermission(GuildConst.GUILD_JURISDICTION_6)
	local canSendMail = UserDataHelper.isHaveGuildPermission(GuildConst.GUILD_JURISDICTION_11)
	local canSetAnnouncement = UserDataHelper.isHaveGuildPermission(GuildConst.GUILD_JURISDICTION_7) --是否能修改公告
	local canSetDeclaration = UserDataHelper.isHaveGuildPermission( GuildConst.GUILD_JURISDICTION_8) --是否能修改宣言
	local canModifyGuildName = UserDataHelper.isHaveGuildPermission(GuildConst.GUILD_JURISDICTION_10) --是否能修改军团名

	self._btnApplyList:setVisible(haveCheckApplyPermission)
	self._btnDeclaration:setVisible(canSetDeclaration)
	self._btnSendMail:setVisible(canSendMail)
end


-- i18n pos lable
function GuildMemberListNode:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image1 = UIHelper.seekNodeByName(self._imageRoot,"Image_13_3_0")
		local image2 = UIHelper.seekNodeByName(self._imageRoot,"Image_13_3_0_0")

		local text60 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_0")
		local text61 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_1")
		local text62 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_2")
		local text623 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_2_3")
	
		text60:setFontSize(text60:getFontSize()-2)
		text61:setFontSize(text61:getFontSize()-2)
		text62:setFontSize(text62:getFontSize()-2)
		text623:setFontSize(text623:getFontSize()-2)

		local text1 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_2")
		text1:setFontSize(text1:getFontSize()-2)
		text1:setPositionX(text1:getPositionX()+14)

		local text2 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_2_0")
		text2:setFontSize(text2:getFontSize()-2)
		text2:setPositionX(text2:getPositionX()+49-16)

		local text3 = UIHelper.seekNodeByName(self._imageRoot,"Text_6_2_0_0")
		text3:setFontSize(text3:getFontSize()-2)
		text3:setPositionX(text3:getPositionX()+15)
		
		local size3 = self._titlePanel3:getContentSize()
		self._titlePanel3:setContentSize(cc.size(size3.width+20,size3.height))

		local panelImage0 = UIHelper.seekNodeByName(self._titlePanel1,"Image")
		panelImage0:setPositionX(panelImage0:getPositionX()+90)

		local panelImage = UIHelper.seekNodeByName(self._titlePanel3,"Image")
		panelImage:setPositionX(panelImage:getPositionX()+22)

		local size4 = self._titlePanel4:getContentSize()
		self._titlePanel4:setPositionX(self._titlePanel4:getPositionX()+20)
		self._titlePanel4:setContentSize(cc.size(size4.width+30,size4.height))
		
		local panelImage2 = UIHelper.seekNodeByName(self._titlePanel4,"Image")
		panelImage2:setPositionX(panelImage2:getPositionX()+60-30)

		local size5 = self._titlePanel5:getContentSize()
		self._titlePanel5:setContentSize(cc.size(size5.width-78+30,size5.height))

		local panelImage3 = UIHelper.seekNodeByName(self._titlePanel5,"Image")
		panelImage3:setPositionX(panelImage3:getPositionX()-35)

		self._titlePanel5:setPositionX(self._titlePanel5:getPositionX()+78-30)

		image1:setPositionX(image1:getPositionX()+20)
		image2:setPositionX(image2:getPositionX()+77-30)

		local imageLine5 = UIHelper.seekNodeByName(self._imageRoot,"Image_13_3_0_0_0_0")
		imageLine5:setPositionX(imageLine5:getPositionX()-18)
		text623:setPositionX(text623:getPositionX()-18)
	end
end

return GuildMemberListNode 