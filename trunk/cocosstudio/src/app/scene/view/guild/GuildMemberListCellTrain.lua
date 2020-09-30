
local ListViewCellBase = require("app.ui.ListViewCellBase")
local GuildMemberListCellTrain = class("GuildMemberListCellTrain", ListViewCellBase)
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
-- local ShaderHalper = require("app.utils.ShaderHelper")

function GuildMemberListCellTrain:ctor()

	self._trainData = nil
	local resource = {
		file = Path.getCSB("GuildMemberListCellTrain", "guild"),
		binding = {
			_buttonLook = {
				events = {{event = "touch", method = "_onButtonLook"}}
			},
			_train = {
				events = {{event = "touch", method = "_onButtonTrain"}}
			},
		}
	}
	GuildMemberListCellTrain.super.ctor(self, resource)
end


function GuildMemberListCellTrain:onCreate()
	self:_dealPosByI18n()
	-- i18n change lable
	self:_swapImageByI18n()

	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

	self._buttonLook:setString(Lang.get("guild_btn_check"))
	-- self._train:setSwallowTouches(false)
end

-- 邀请发送成功，更新ui
function GuildMemberListCellTrain:onInviteSucess(userId)
	if self._trainData and userId==self._trainData:getUid() then
		self._invite:setVisible(true)
		self._train:setVisible(false)
		self:_setTrainIcon()
	end
end

function GuildMemberListCellTrain:update(data,index)
	self._trainData = data
	local heroBaseId = data:getBase_id()
	local heroName = data:getName()
	local official = data:getOfficer_level()
	local officialName, officialColor,officialInfo = UserDataHelper.getOfficialInfo(official)
	local level = data:getLevel()
	local power = TextHelper.getAmountText1(data:getPower())
	local position = data:getPosition()
	local duties = UserDataHelper.getGuildDutiesName(position)
	local contribution = TextHelper.getAmountText1(data:getContribution())
	local contributionWeek = TextHelper.getAmountText1(data:getWeek_contribution())
	local onlineText, color = UserDataHelper.getOnlineText(data:getOffline())
	local activityNum =  G_UserData:getLimitTimeActivity():hasActivityNum()
	local activeRate = math.floor(data:getActive_cnt() * 100 / activityNum) 
	self._fileNodeIcon:updateUI(heroBaseId)
	--self._official:setString(officialName)
	--self._official:setColor(officialColor)
	self._official:loadTexture(Path.getTextHero(officialInfo.picture))
	self._official:ignoreContentAdaptWithSize(true)

	self._name:setString(heroName)
	self._name:setColor(officialColor)
	require("yoka.utils.UIHelper").updateTextOfficialOutline(self._name, official)
	self._level:setString(level)
	self._power:setString(power)
	self._duties:setString(duties)
	self._contributionWeek:setString(contributionWeek)
	self._contributionTotal:setString(contribution)
	self._textActiveRate:setString(Lang.get("guild_member_active_rate",{value = activeRate}))
	self._online:setString(onlineText)
	self._online:setColor(color)


	self:_setTrainIcon(data)
	if index % 2 == 0 then
		self._panel:loadTexture(Path.getComplexRankUI("img_com_ranking04"))
	else
		self._panel:loadTexture(Path.getComplexRankUI("img_com_ranking05"))
	end
end

function GuildMemberListCellTrain:_setTrainIcon(  )

	local trainType = self._trainData:getTrainType()

	local active = trainType > 3
	local srcPath = trainType > 3 and (trainType - 3) or trainType

	
	-- self._train:setSwallowTouches(true)
	-- self._train:setTouchEnabled(trainType <=3)
	-- if trainType >3 then 
	-- 	ShaderHalper.filterNode(self._train, "gray")
	-- else
	-- 	ShaderHalper.filterNode(self._train, "", true)
	-- end
	self._train:setVisible(trainType<=3)
	self._train:loadTexture(Path.getTrainIcon("btn_training"..srcPath))
	if G_UserData:getGuild():getInviteTrainListById(self._trainData:getUid()) ~= nil then 
		self._invite:setVisible(true)
		if trainType <= 3 then 
			self._train:setVisible(false)
		end
	else
		self._invite:setVisible(false)
		if trainType <= 3 then 
			self._train:setVisible(true)
		end
	end
end


function GuildMemberListCellTrain:_onButtonTrain( sender,state )
	if state == ccui.TouchEventType.ended or not state then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then			
			local userId = self._trainData:getUid()
			if userId == G_UserData:getBase():getId() then

				local content = Lang.get("guild_self_train")
				local function okCallback( ... )
					G_UserData:getGuild():c2sQueryGuildTrain(userId)
				end

				local popup = require("app.ui.PopupAlert").new(Lang.get("guild_self_train_alert"), content, okCallback, nil,nil)
				popup:setBtnStr(Lang.get("guild_self_tanin_ok"),Lang.get("guild_self_tanin_concel"))
				popup:openWithAction()

			else
				G_UserData:getGuild():c2sQueryGuildTrain(userId)
			end
		end
	end

end




function GuildMemberListCellTrain:_onButtonLook()
	self:dispatchCustomCallback()
end

-- i18n change pos
function GuildMemberListCellTrain:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		self._official:setPositionX(self._official:getPositionX()-15)
		self._name:setPositionX(self._name:getPositionX()-5)
	end
end


-- i18n change lable
function GuildMemberListCellTrain:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		self._invite = UIHelper.swapSignImage(self._invite,
		{ 
			 style = "signet_4", 
			 text = Lang.getImgText("img_qintombo_yaoqing") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))

	end
end
return GuildMemberListCellTrain