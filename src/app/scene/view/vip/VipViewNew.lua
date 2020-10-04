local TextHelper = require("app.utils.TextHelper")
local VipViewRechargeView = require("app.scene.view.vip.VipViewRechargeView")
local VipViewSkinView = require("app.scene.view.vip.VipViewSkinView")
local CSHelper = require("yoka.utils.CSHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local VipConst = require("app.const.VipConst")
local ViewBase = require("app.ui.ViewBase")
local VipViewNew = class("VipViewNew", ViewBase)
local KeyValueUrlRequest = require("app.manager.KeyValueUrlRequest")-- i18n ja


VipViewNew.AGE_VERIFICATE = 50001 -- i18n ja 年龄确认开关id
VipViewNew.POSY_START = -40
VipViewNew.POSY_END = 30

VipViewNew.EFFECT_POS = {{225,111},{220,338},{113,220}}

VipViewNew.ANIMATION = {"bixin","haixiu"}


--[[
--等服务器回包后，创建对话框并弹出UI
function VipViewNew:waitEnterMsg(callBack)
    local function onMsgCallBack(e,param)
        if e == "success" then
            callBack()
        end
	end
	return G_PosterGirlManager:doRequestGetKeyValue(onMsgCallBack)
end
]]
function VipViewNew:ctor(paramIndex,subTabType,threeTabType)
	self._paramIndex = paramIndex
	self._paramSubTabType = subTabType
	self._paramThreeTabType = threeTabType
	self._nodeLeftRecharge = nil
	self._nodeSkin = nil
	self._currSelectIndex = 0
	self._stayHandler = {}
	self._effectList = {}
	self._newXinXinIndexs = {}
	self._tipTask = {}
    local resource = {
		file = Path.getCSB("VipViewNew", "vip"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
            _buttonChange = {
				events = {{event = "touch", method = "_onButtonChange"}}
			},
			_panel =  {
				events = {{event = "touch", method = "_onButtonAddVipExp"}}
			},
			_imageHeart = {
				events = {{event = "touch", method = "_onButtonClickHeart"}}
			},
			_imageLawBg = {
				events = {{event = "touch", method = "_onButtonLawHelp"}}
			},
			_imageProgressBg = {
				events = {{event = "touch", method = "_onClickProgress"}}
			}
		}
    }
    VipViewNew.super.ctor(self,resource,9999)
end

function VipViewNew:onCreate()
	self._topbarBase:setImageTitle("txt_sys_com_chongzhi")
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_VIP)
	self._topbarBase:setCallBackOnBack(handler(self,self.onButttonBack))

	local story = CSHelper.loadResourceNode(Path.getCSB("CommonPosterGirlAvatar", "common"))
	story:updateChatUI(1)
	story:setAvatarScale(0.54)
	self._posterGirlAvatar = story 
	self._nodeAvatar:addChild(story)

	self:_initStencil()
	self:_initLawView()
	self:_initBoxView()
	self:_initBoxData()
	--[[
	if self._paramIndex == 1 then
		local rechargeView = VipViewRechargeView.new(self._paramSubTabType)
		self._nodeLeftRecharge:addChild(rechargeView)
	else
		local rechargeView = VipViewRechargeView.new()
		self._nodeLeftRecharge:addChild(rechargeView)
	end
]]
	local rechargeView = VipViewRechargeView.new()
	self._nodeLeftRecharge:addChild(rechargeView)

	local view = VipViewSkinView.new()
	self._nodeSkin:addChild(view)

	self:_setTabIndex(1)

	self._KeyValueUrlRequest = KeyValueUrlRequest.new()-- i18n ja
end


function VipViewNew:onEnterTransitionFinish()
	print("VipViewExchange onEnterTransitionFinish")
	if self._paramIndex then
		G_SignalManager:dispatch(SignalConst.EVENT_VIP_GO_TO_TAB,self._paramIndex ,self._paramSubTabType ,	self._paramThreeTabType)
	end
	local PosterGirlVoiceConst = require("app.const.PosterGirlVoiceConst")
	G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_VOICE_UPDATE,PosterGirlVoiceConst.TRIGGER_POS_OPEN_RECHARGE_UI)
end


function VipViewNew:onEnter()
	self._signalPosterGirlPlayVoice = G_SignalManager:add(SignalConst.EVENT_POSTER_GIRL_PLAY_VOICE, handler(self, self._onEventPosterGirlPlayVoice))
	self._signalVipGotoTab = G_SignalManager:add(SignalConst.EVENT_VIP_GO_TO_TAB, handler(self, self._onEventVipGotoTab))
	self._signalDailyCountSuccess = G_SignalManager:add(SignalConst.EVENT_GET_DAILY_COUNT_SUCCESS, 
		handler(self, self._onEventDailyCountSuccess))
	self._signalVipExpChange = G_SignalManager:add(SignalConst.EVENT_VIP_EXP_CHANGE, handler(self,self._onEventVipExpChange))
	self._signalPosterGirlBoxInfoUpdate = G_SignalManager:add(SignalConst.EVENT_POSTER_GIRL_BOX_INFO_UPDATE, 
		handler(self,self._onEventPosterGirlBoxInfoUpdate))

	self._signalPosterGirlBoxReceiveSuccess = G_SignalManager:add(SignalConst.EVENT_POSTER_GIRL_BOX_RECEIVE_SUCCESS, 
		handler(self,self._onEventPosterGirlBoxReceiveSuccess))
	self._signalVipAddExpBall = G_SignalManager:add(SignalConst.EVENT_VIP_ADD_EXP_BALL, 
		handler(self,self._onEventVipAddExpBal))
	self._signalBuyShopGoods = G_SignalManager:add(SignalConst.EVENT_BUY_ITEM, handler(self, self._onEventBuyItem))
	self._signalGetRechargeNotice = G_SignalManager:add(SignalConst.EVENT_RECHARGE_NOTICE, handler(self, self._onEventGetRechargeNotice))



	self:_updateLevelView()

	self._stayHandler = {}
	local stayTimes = G_PosterGirlManager:getStayTime()
	for k,v in ipairs(stayTimes) do
		local scheduler = require("cocos.framework.scheduler")
		local handler = scheduler.performWithDelayGlobal(function()
			print("dddddddddddd____________ ".. v)
			local PosterGirlVoiceConst = require("app.const.PosterGirlVoiceConst")
			G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_VOICE_UPDATE,PosterGirlVoiceConst.TRIGGER_POS_RECHARGE_STAY,{time = v})
		end, v)
		table.insert(self._stayHandler,handler)
	end

	self:showAgeVerificateBox() -- i18n ja show 
	self._selectAge = self._KeyValueUrlRequest.signal:registerListener( handler(self, self._onEventShowAgeVerificate)) -- i18n ja

	self:scheduleUpdateWithPriorityLua(handler(self, self._update),0)

	self:_refreshXinXinData()
	self:_refreshBoxView()
	self:_refreshEffectView()
	self:_refreshProgressEffectView()
	self:_refreshProgressView()

	local runningScene = G_SceneManager:getRunningScene()
	runningScene:setVipUpgradeEffectDisable(true)
	runningScene:setVipChangeTipDisable(true)
	runningScene:setRechargeNoticeDisable(true)
end

function VipViewNew:onExit()
	self._signalVipGotoTab:remove()
	self._signalVipGotoTab  = nil
	self._signalDailyCountSuccess:remove()
	self._signalDailyCountSuccess = nil
	self._signalVipExpChange:remove()
	self._signalVipExpChange = nil
	self._selectAge:remove()
	self._selectAge = nil
	self._signalPosterGirlBoxInfoUpdate:remove()
	self._signalPosterGirlBoxInfoUpdate = nil
	self._signalPosterGirlBoxReceiveSuccess:remove()
	self._signalPosterGirlBoxReceiveSuccess = nil
	self._signalVipAddExpBall:remove()
	self._signalVipAddExpBall  = nil
    if self._signalBuyShopGoods then
        self._signalBuyShopGoods:remove()
        self._signalBuyShopGoods = nil
	end
	self._signalGetRechargeNotice:remove()
	self._signalGetRechargeNotice = nil
	self._signalPosterGirlPlayVoice:remove()
	self._signalPosterGirlPlayVoice = nil

	for k,v in ipairs(self._stayHandler) do
		local scheduler = require("cocos.framework.scheduler")
		scheduler.unscheduleGlobal(v)
	end
	self:unscheduleUpdate()
	G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_VOICE_CLEAR)

	local runningScene = G_SceneManager:getRunningScene()
	runningScene:setVipUpgradeEffectDisable(false)
	runningScene:setVipChangeTipDisable(false)
end



function VipViewNew:_onEventVipGotoTab(event,index,subTabType,threeTabType)
	if index ~= self._currSelectIndex then
		self:_setTabIndex(index)
	end
end

function VipViewNew:_onEventDailyCountSuccess(event)
end

function VipViewNew:_updateLevelView()
	local VipLevelInfo = require("app.config.vip_level")
	local maxVipLv = G_UserData:getVip():getShowMaxLevel()
	local currentVipLv = G_UserData:getVip():getLevel()
	local currentVipExp = G_UserData:getVip():getExp()
	local nextVipLv = currentVipLv == maxVipLv and maxVipLv or currentVipLv + 1
	local curVipLvInfo = G_UserData:getVip():getVipDataByLevel(currentVipLv):getInfo()
	local vipExp = self._nodeVip:getChildByName("Text_1")
	vipExp:setString(currentVipLv)


	local getRipplePos = function(percent)
		local height = (VipViewNew.POSY_END - VipViewNew.POSY_START) * percent / 100
		local targetPosY = VipViewNew.POSY_START + height
		return {x = 0, y = targetPosY}
	end
	local percent = 100
	if maxVipLv ~= currentVipLv then
		percent = currentVipExp * 100 / curVipLvInfo.vip_exp
	end
	local pos = getRipplePos(percent)
	self._nodeExpEffect:setPosition(pos)
end

-- 为节点添加圆形裁减
function VipViewNew:_initStencil()
	local stencil = cc.Sprite:create(Path.getVip2("3"))
	stencil:setScale(0.98)
--	local texParams = { gl.LINEAR_MIPMAP_LINEAR,gl.LINEAR, gl.CLAMP_TO_EDGE, gl._3DC_X_AMDCLAMP_TO_EDGE }
	--stencil:getTexture():setAntiAliasTexParameters()


    local clippingNode = cc.ClippingNode:create()
    clippingNode:setStencil(stencil)
    clippingNode:setInverted(false)
    clippingNode:setAlphaThreshold(0.001)
    clippingNode:setName("clippingNode")
	self._nodeExpEffect:addChild(clippingNode)


	local node =  require("yoka.node.SpineNode").new(1, cc.size(500, 640))
	local spinePath = Path.getEffectSpine("haogandu")
	node:setAsset(spinePath)
	node:setAnimation("effect",true)
	clippingNode:addChild(node)
	node:setPositionY(30)---40
	self._nodeExpEffect = node
end

function VipViewNew:_onEventVipAddExpBal(event,addExp,oldLevel,newLevel)
	self:_playSingleBallEffect(oldLevel ~= newLevel)
end 

function VipViewNew:_playSingleBallEffect(isLevelUp)
	--[[
	local sp = display.newSprite(Path.getBackgroundEffect("img_photosphere6"))
	local path = Path.getParticle("feishenglizi")
	logWarn("path : "..path)
	local emitter = cc.ParticleSystemQuad:create(Path.getParticle("feishenglizi"))
	if emitter then
		emitter:setPosition(cc.p(sp:getContentSize().width / 2, sp:getContentSize().height / 2))
        sp:addChild(emitter)
        emitter:resetSystem()
	end
	]]

	local playLevelUpEffect = function()
		
		local runningScene = G_SceneManager:getRunningScene()
		local topLayer = runningScene:getTopLayer()
		local effect = G_EffectGfxMgr:createPlayGfx(topLayer, "effect_qinmidu_taohuaup", callback, true , nil)
		local size = G_ResolutionManager:getDesignCCSize()
		local imageBg = ccui.ImageView:create()
		imageBg:loadTexture(Path.getVip2("effect_bg"))
		imageBg:setScale9Enabled(true)
		imageBg:setCapInsets(cc.rect(94 , 52, 12,9))
		imageBg:setContentSize(size)
		effect:addChild(imageBg)
	end 
   
	
	local sp = cc.ParticleSystemQuad:create(Path.getParticle("feishenglizi"))
    sp:setPositionType(1)
	sp:resetSystem()

    local startPos = G_ResolutionManager:getDesignCCPoint()--UIHelper.convertSpaceFromNodeToNode(, self)
    sp:setPosition(startPos)
    self:addChild(sp)
	local dstNode = self._nodeVip
	local UIHelper = require("yoka.utils.UIHelper")
    local endPos = UIHelper.convertSpaceFromNodeToNode(dstNode, self, cc.p(0, 0)) --飞到中心点
    local pointPos1 = cc.p(startPos.x, startPos.y)
    local pointPos2 = cc.p((startPos.x + endPos.x) / 2-20, startPos.y)
    local bezier = {
	    pointPos1,
	    pointPos2,
	    endPos,
	}
	local action1 = cc.BezierTo:create(1.7, bezier)
	--local action2 = cc.EaseSineIn:create(action1)
	sp:runAction(cc.Sequence:create(
			action1,
            cc.CallFunc:create(function()
				self:_updateLevelView()
				sp:setEmissionRate(0)
				if isLevelUp then
					G_EffectGfxMgr:createPlayGfx(self._nodeVip, "effect_aixinchi_attack",nil,true)
					playLevelUpEffect()
				else
					G_EffectGfxMgr:createPlayGfx(self._nodeVip, "effect_aixinchi_idle1",nil,true)
				end
			end),
			cc.DelayTime:create(1),
            cc.RemoveSelf:create()
        )
	)

end

function VipViewNew:_setTabIndex(index)
	if self._currSelectIndex == index then
		return
	end
	self._currSelectIndex = index
	if index == 1 then
		self._nodeLeftRecharge:setVisible(true)
		self._nodeSkin:setVisible(false)
		self._buttonChange:getParent():setVisible(true)

		local imageTitle = ccui.Helper:seekNodeByName(self._topbarBase, "ImageTitle")
		if imageTitle then imageTitle:setVisible(true)  end
	else
		self._nodeLeftRecharge:setVisible(false)
		self._nodeSkin:setVisible(true)
		self._buttonChange:getParent():setVisible(false)

		local imageTitle = ccui.Helper:seekNodeByName(self._topbarBase, "ImageTitle")
		if imageTitle then imageTitle:setVisible(false)  end
	end
end

function VipViewNew:_onButtonChange(sender)
	self:_setTabIndex(2)

	local PosterGirlVoiceConst = require("app.const.PosterGirlVoiceConst")
	G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_VOICE_UPDATE,PosterGirlVoiceConst.TRIGGER_POS_CLICK_WARDROBE)
end

function VipViewNew:onButttonBack(sender)
	if self._currSelectIndex == 2 then
		self:_setTabIndex(1)
	else
		G_SceneManager:popScene()
	end
end

function VipViewNew:_onButtonAddVipExp(sender)
	if UserDataHelper.getPosterGirlReceiveBoxNum(VipConst.VIP_ADD_EXP_TYPE_CLICK_POSTER_GIRL) < 
		#self._boxInfoList2 then
		local boxId = UserDataHelper.getPGCanReceiveBoxId(VipConst.VIP_ADD_EXP_TYPE_CLICK_POSTER_GIRL)
		if boxId then
			G_UserData:getPosterGirl():c2sPlayWithPosterGirl(boxId)
		end
	end

	local animIndex = math.random(1,#VipViewNew.ANIMATION)
	self._posterGirlAvatar:playAnimationOnce(VipViewNew.ANIMATION[animIndex])

	local PosterGirlVoiceConst = require("app.const.PosterGirlVoiceConst")
	G_SignalManager:dispatch(SignalConst.EVENT_POSTER_GIRL_VOICE_UPDATE,
		PosterGirlVoiceConst.TRIGGER_POS_CLICK_AVATAR)
end

function VipViewNew:_onEventPosterGirlPlayVoice(event,voice)
	self._posterGirlAvatar:startTalk(voice,false) 
end

function VipViewNew:_onClickProgress()
	local canShowEffectNum = UserDataHelper.getPGCanReceiveNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
	local receiveNum = UserDataHelper.getPosterGirlReceiveBoxNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
	if receiveNum < canShowEffectNum then
		logWarn(canShowEffectNum.."xxxfffx"..receiveNum)
		local PopupVipSelectAward = require("app.scene.view.vip.PopupVipSelectAward")
		local rewardIds = UserDataHelper.getPGReceiveRewardIds(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
		local pop = PopupVipSelectAward.new(function(ids)
			--检查数量
			local canGetNum = UserDataHelper.getPGCanReceiveNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
			local hasNum = UserDataHelper.getPosterGirlReceiveBoxNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
			local remainNum = canGetNum - hasNum 
			if #ids > remainNum then
				G_Prompt:showTip(Lang.get("vip_new_tip_wrong_get_num",{num = remainNum }))
				return
			end
			--检查开服时间
			local checkServerDayNum = function(ids)
				local openDay = G_UserData:getBase():getOpenServerDayNum()
				local VipContent = require("app.config.vip_content")
				for k,v in ipairs(ids) do
					local config = VipContent.get(v) 
					if openDay < config.day_min or openDay > config.day_max then
						return false
					end
				end
				return true
			end
			if not checkServerDayNum(ids) then
				G_Prompt:showTip(Lang.get("vip_new_tip_wrong_open_day"))
				return
			end

			local checkIsHasGet = function(ids)
				for k,v in ipairs(ids) do
					if UserDataHelper.hasReceivePosterGirlBox(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD,v)  then
						return false
					end
				end
				return true
			end
			if not checkIsHasGet(ids) then
				G_Prompt:showTip(Lang.get("vip_new_tip_reward_has_get"))
				return
			end
			
			G_UserData:getPosterGirl():c2sPlayWithPosterGirl(self._boxInfoList[1].config.id,ids)
			end,rewardIds,canShowEffectNum-receiveNum,#self._boxInfoList)
		pop:open()
	end
end


--[[
function VipViewNew:gotoView(paramIndex,subTabType,threeTabType)
	if paramIndex ~= self._currSelectIndex then
		self:_setTabIndex(paramIndex)
	end
	if paramIndex == 1 and subTabType then
		self._nodeLeftRecharge:getChildren()[1]:gotoView(subTabType,threeTabType)
	end
end
]]


function VipViewNew:_onButtonClickHeart(sender)
	local popup = require("app.scene.view.vip.PopupVipViewLevelTips").new(self._imageHeart)
	popup:open()
end


-- i18n ja 年龄弹框开关
function VipViewNew:getParameterCfg()
	local ParameterIDConst = require("app.const.ParameterIDConst")
	local Parameter = require("app.config.parameter")
	
    local info = Parameter.get(VipViewNew.AGE_VERIFICATE)    
    assert(info, string.format("graincar parameter config can not find id = %d", info.content))
	if info.content == "1" then  -- 开关打开
		return true
	else
		return false            
	end
end

-- i18n ja 年龄弹框
function VipViewNew:showAgeVerificateBox()
	
	if not self:getParameterCfg() then
		return
	end

	self:sendSelectAge()
end

-- i18n ja 年龄弹框
function VipViewNew:_onEventShowAgeVerificate(e, data) 
	if e == "fail" then
		return 
	end

	if data and data.field and data.field == "" then
		local rule = require("app.scene.view.vip.PopupAgeVerificate").new()
		rule:openWithAction()
	end	
end
  -- i18n ja 
function VipViewNew:sendSelectAge( )
	local uuid =  string.urlencode(G_GameAgent:getTopUserId())
	local server_id = G_GameAgent:getLoginServer():getServer() 
	if server_id == nil or uuid == nil then
		return
	end

	self._KeyValueUrlRequest:doRequestGetKeyValue("age")
end

function VipViewNew:_onButtonLawHelp()
	local PopupHelpRule = require("app.ui.PopupHelpRule") 
	local rule = PopupHelpRule.new("vip_btn_des1", "vip_rule_user_agree")
	rule:openWithAction()
end

function VipViewNew:_update(dt)
	 self:_refreshBoxView()
	 self:_refreshEffectView()
	 self:_refreshProgressEffectView()
	 self:_doTask()
end


function VipViewNew:_initLawView()
	
	self._textLaw:setString(Lang.get("vip_new_law"))
	local lineWidth =  self._textLaw:getContentSize().width
	local x1 = self._textLaw:getPositionX()-lineWidth*0.5
	local drawNode = cc.DrawNode:create()
	local y1 =self._textLaw:getPositionY()-11
	drawNode:drawSegment(cc.p( x1, y1),cc.p(x1 + lineWidth,y1),0.5, cc.c4f(0xff/255, 0xf4/255, 0x74 /255,1))
	self._imageLawBg:addChild(drawNode)
end

function VipViewNew:_initBoxView()
	local nodeList = {}
	local nodeNum = 3 
	for k =1,nodeNum,1 do
		if self["_nodeHeart"..k] then
			table.insert(nodeList, self["_nodeHeart"..k])
		end
	end
	self._boxNodeList = nodeList
end

function VipViewNew:_initBoxData()
	self._boxInfoList = UserDataHelper.getPosterGirlBoxInfoList(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
	self._boxInfoList2 = UserDataHelper.getPosterGirlBoxInfoList(VipConst.VIP_ADD_EXP_TYPE_CLICK_POSTER_GIRL)
end

function VipViewNew:_refreshXinXinData()
	local onlineTime = G_UserData:getBase():getOnlineTime()
	for k,v in ipairs(self._boxInfoList) do
		if onlineTime > v.config.require_value * 60 then
			self._newXinXinIndexs[k] = true
		end
	end
end

--所有宝箱都领取完成后，隐藏进度条
function VipViewNew:_refreshProgressView()
	local isShowProgress = function()
		local boxNum = #self._boxInfoList2
		local receiveNum = UserDataHelper.getPosterGirlReceiveBoxNum(VipConst.VIP_ADD_EXP_TYPE_CLICK_POSTER_GIRL)
		if receiveNum < boxNum then
			return true
		end
		boxNum = #self._boxInfoList
		receiveNum = UserDataHelper.getPosterGirlReceiveBoxNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
		if receiveNum < boxNum then
			return true
		end
		return false
	end
	local show = isShowProgress()
	self._nodeHeart:setVisible(show)
end


function VipViewNew:_refreshBoxView()
	local onlineTime = G_UserData:getBase():getOnlineTime()
	local hour = (onlineTime-onlineTime%3600)/3600
    local minute = (onlineTime-hour*3600 -onlineTime%60)/60
	local second = onlineTime%60
	local timeStr = string.format("%02d:%02d:%02d",hour,minute,second)

	self._textHeartBoxTime:setString(Lang.get("vip_new_online_time",{time=timeStr}))
	local maxTime = 0
	if #self._boxInfoList > 0 then
		maxTime = self._boxInfoList[#self._boxInfoList].config.require_value
	end
	local playEffect = {}
	local progressInfoList  = {}
	for k,v in ipairs(self._boxInfoList) do
		local node = self._boxNodeList[k]
		table.insert(progressInfoList, {
			startPos = node:getPositionX() + 10,
			endPos = node:getPositionX() + 10,
			point = v.config.require_value * 60
		})
		if onlineTime > v.config.require_value * 60 then
			if not self._newXinXinIndexs[k] then
				table.insert(playEffect,k)
			end
			self._newXinXinIndexs[k] = true
		end
	end
	local myPoint = onlineTime
	local loadBarStartX = self._panelProgress:getPositionX() + 4
	local dstX = loadBarStartX
	for k = #progressInfoList,1,-1 do
		local v = progressInfoList[k]
		if v.point < myPoint then
			local nextBoxInfo = progressInfoList[k+1]
			if nextBoxInfo then
				dstX = v.endPos + (nextBoxInfo.startPos-v.endPos) * (myPoint-v.point)/(nextBoxInfo.point-v.point)
			else
				dstX = v.endPos 
			end
			break
		elseif k == 1 then
			dstX = loadBarStartX + (v.startPos-loadBarStartX) * myPoint /v.point
		end 
	end
	local width = dstX-self._panelProgress:getPositionX()
	local size = self._panelProgress:getContentSize()
	self._panelProgress:setContentSize(cc.size(width,size.height))

	for k,v in ipairs(playEffect) do
		local node = self._boxNodeList[v]
		self:_playNewXinXin(node)
	end
end

function VipViewNew:_playNewXinXin(node)
	--G_EffectGfxMgr:createPlayGfx(node, "effect_aixinchi_attack")
end


function VipViewNew:_refreshProgressEffectView()
	local canShowEffectNum = UserDataHelper.getPGCanReceiveNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
	local receiveNum = UserDataHelper.getPosterGirlReceiveBoxNum(VipConst.VIP_ADD_EXP_TYPE_SELECT_REWARD)
	for k,v in ipairs(self._boxNodeList) do
		local nodeEffect = v:getChildByName("effect")
		if k <= receiveNum then
			if nodeEffect then
				nodeEffect:setVisible(false)
			end
		elseif k <= canShowEffectNum then
			if nodeEffect then
				nodeEffect:setVisible(true)
			else
				local effect = G_EffectGfxMgr:createPlayGfx(v, "effect_jingdu_aixin" )
				effect:setName("effect")
			end
		elseif k > canShowEffectNum then
			if nodeEffect then
				nodeEffect:setVisible(false)
			end
		end
	end
end


function VipViewNew:_refreshEffectView()
	local effectPos = VipViewNew.EFFECT_POS 
	local currEffectNum = #self._effectList
	local canShowEffectNum = UserDataHelper.getPGCanReceiveNum(VipConst.VIP_ADD_EXP_TYPE_CLICK_POSTER_GIRL)
	local receiveNum = UserDataHelper.getPosterGirlReceiveBoxNum(VipConst.VIP_ADD_EXP_TYPE_CLICK_POSTER_GIRL)
	--logWarn(canShowEffectNum.."xxxfffx"..receiveNum)
	local needEffectNum = math.max(0,canShowEffectNum-receiveNum)
	if needEffectNum > currEffectNum then
		--新增特效
		for k = needEffectNum - currEffectNum,1,-1 do
			local usePos = {} 
			for k,v in ipairs(self._effectList) do
				usePos[v:getTag()] = true
			end
			local remainPos = {}
			for k,v in ipairs(effectPos) do
				if not usePos[k] then
					table.insert(remainPos,k)
				end
			end
			if #remainPos <= 0 then
				break
			end
			local posIndex = remainPos[math.random(1,#remainPos)]

			local node = cc.Node:create()
			G_EffectGfxMgr:createPlayGfx(node, "effect_chuping_aixin" )
			table.insert(self._effectList, node)
			local posInfo = effectPos[posIndex]
			node:setPosition(posInfo[1],posInfo[2])
			node:setTag(posIndex)
			self._panel:addChild(node)
		end
	elseif needEffectNum < currEffectNum then
		--logWarn(currEffectNum.."sssxxxssss"..needEffectNum)
		--删特效
		for k = currEffectNum - needEffectNum,1,-1 do
			local node = table.remove(self._effectList,1)
			node:removeFromParent()
		end
		
	end
end

function VipViewNew:_onEventPosterGirlBoxInfoUpdate(event)
	self:_refreshXinXinData()
	self:_refreshEffectView()
	self:_refreshProgressEffectView()
	self:_refreshProgressView()
end

function VipViewNew:_onEventPosterGirlBoxReceiveSuccess(event,rewards)
	if rewards then
		local callback = function()
			G_Prompt:showAwards(rewards)
		end
		table.insert(self._tipTask ,{
			callback = callback,
			time = 1*#rewards,
			type = 1,
			isHead = 2,
			id = #self._tipTask,
		})
	end
end

function VipViewNew:_onEventVipExpChange(event,addExp ,oldLevel,newLevel)
	--self:_updateLevelView()
	local callback = function()
		local runningScene = G_SceneManager:getRunningScene()
		runningScene:playAddVipTips(addExp ,oldLevel,newLevel)
	end
	table.insert(self._tipTask ,{
		callback = callback,
		time = 2,
		type = 2,
		id = #self._tipTask,
	})
end

function VipViewNew:_onEventBuyItem(eventName, message)
    local awards = rawget(message, "awards")
    if awards then
		local shopId = rawget(message, "shop_id")
		local ShopConst = require("app.const.ShopConst")
        if shopId == ShopConst.VIP_EXCHANGE_SHOP  then
			local callback = function()
				G_Prompt:showAwards(awards)
			end
			table.insert(self._tipTask ,{
				callback = callback,
				time = 1*#awards,
				type = 1,
				isHead = 2,
				id = #self._tipTask,
			})
        end
	end
	
end

function VipViewNew:_onEventGetRechargeNotice(event,id,message)
	local callback = function()
		G_Prompt:showTip(Lang.getImgText("txt_pay_succeed"))
	end
	table.insert(self._tipTask ,{
		callback = callback,
		time = 1,
		type = 0,
		isHead = 3,
		id = #self._tipTask,
	})
	
	local callback2 = function()
		local runningScene = G_SceneManager:getRunningScene()
		runningScene:showNoticeReward(message)
	end
	table.insert(self._tipTask ,{
		callback = callback2,
		time = 1,
		type = 1,
		id = #self._tipTask,
	})
end


function VipViewNew:_doTask()
	local nextIndex = nil
	local time = G_ServerTime:getTime()
	--[[
	table.sort(self._tipTask, function(left,right) 
		if left.isFinish ~= right.isFinish then
			return left.isFinish == true
		end
		if left.isStart ~= right.isStart then
			return left.isStart == true
		end
		if left.type ~= right.type then
			return left.type < right.type
		end
		return left.id < right.id
	end)
	]]
	for k,v in ipairs(self._tipTask) do
		if not v.isFinish  then
			v.isFinish = true
			v.callback()
		end
		
	end

	--[[
	for k,v in ipairs(self._tipTask) do
		if v.isFinish then
		elseif v.isStart then
			if time >=  v.startTime + v.time  then
				v.isFinish = true
			else	
				break
			end
		else
			nextIndex = k
			break
		end
	end
	if nextIndex  then
		self._tipTask[nextIndex].isStart = true
		self._tipTask[nextIndex].startTime = time
		self._tipTask[nextIndex].callback()
	end		
]]
end


return VipViewNew