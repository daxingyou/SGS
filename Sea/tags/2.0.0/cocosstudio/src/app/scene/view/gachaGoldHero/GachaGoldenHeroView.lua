-- @Author panhoa
-- @Date 5.5.2019
-- @Role 

local ViewBase = require("app.ui.ViewBase")
local GachaGoldenHeroView = class("GachaGoldenHeroView", ViewBase)
local GoldHeroAvatar = import(".GoldHeroAvatar")
local BullectScreenConst = require("app.const.BullectScreenConst")
local PointRankView = import(".PointRankView")
local AudioConst = require("app.const.AudioConst")
local GachaGoldenHeroHelper = import(".GachaGoldenHeroHelper")
local scheduler = require("cocos.framework.scheduler")
local GachaGoldenHeroConst = require("app.const.GachaGoldenHeroConst")


function GachaGoldenHeroView:waitEnterMsg(callBack)
	local function onMsgCallBack(id, message)
		callBack()
	end

	G_UserData:getGachaGoldenHero():c2sGachaEntry()
	local signal = G_SignalManager:add(SignalConst.EVENT_GACHA_GOLDENHERO_ENTRY, onMsgCallBack)
	return signal
end

function GachaGoldenHeroView:ctor()
    self._topBar       = nil
    self._commonChat   = nil
    self._nodeRank     = nil
    self._pointRankView= nil
    self._isBulletOpen = true

    local resource = {
        file = Path.getCSB("GachaGoldenHeroView", "gachaGoldHero"),
        size = G_ResolutionManager:getDesignSize(),
        binding = {
			_panelTouchJoy = {
				events = {{event = "touch", method = "_onButtonClickJoy"}}
			},
        }
    }
    GachaGoldenHeroView.super.ctor(self, resource)--, 2101)
end

function GachaGoldenHeroView:onCreate()
    if not Lang.checkLang(Lang.CN) then
        self:_swapImageByI18n()
    end
    self:_initFuncIcon()
    self:_initEffectAvatar()
    self:_initEffectFont()
    self:_initRankView()
    self:_updateJoyDraw()
    self:_updateJoyCountDown()
    self:_initDanmu()
end

function GachaGoldenHeroView:onEnter()
    if self._isBulletOpen then
        G_BulletScreenManager:setBulletScreenOpen(BullectScreenConst.GACHA_GOLDENHERO_TYPE,true)
    end
    G_AudioManager:playMusicWithId(AudioConst.SOUND_GACHA_GOLDEN_HERO)
    self._countDownScheduler = scheduler.scheduleGlobal(handler(self, self._update), 0.1)
end

function GachaGoldenHeroView:onExit()
    local runningScene = G_SceneManager:getTopScene()
	if runningScene and runningScene:getName() ~= "fight" then
        G_BulletScreenManager:clearBulletLayer()
    end
    if self._countDownScheduler then
		scheduler.unscheduleGlobal(self._countDownScheduler)
		self._countDownScheduler = nil
	end
end

function GachaGoldenHeroView:_initEffectAvatar( ... )
    local function createAvatar(index)
        local groupIds = G_UserData:getGachaGoldenHero():getGoldHeroGroupId() or {}
        local avatar = GoldHeroAvatar.new(handler(self, self._touchAvatar))
        avatar:updateUI(groupIds[index], nil, true)
        avatar:setScale(0.9)
        avatar:setAligement(math.ceil(index/2))
        avatar:turnBack(index > 2)
        local type = 2 
        if index > 1 and index < 4 then
            type = 0
        end
        avatar:setNamePositionY(type)
        return avatar
    end
    local function effectFunction(effect)
        if effect == "juese_1" then
            return createAvatar(1)
        elseif effect == "juese_2" then
            return createAvatar(2)
        elseif effect == "juese_3" then
            return createAvatar(3)
        elseif effect == "juese_4" then
            return createAvatar(4)
		end
	end
	
    local function eventFunction(event)
       if event == "finish" then
        end
    end
    
    self._nodeEffectMain:removeAllChildren()
    G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffectMain, "moving_jinjiangzhaomu_dianjiang", effectFunction, eventFunction , false)
end

function GachaGoldenHeroView:_initEffectFont( ... )
    local function effectFunction(effect)
	end
	
    local function eventFunction(event)
       if event == "finish" then
        end
    end
    
    self._nodeEffectFront:removeAllChildren()
    G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffectFront, "moving_jinjiangzhaomu_dianjiang_front", effectFunction, eventFunction , false)
end

function GachaGoldenHeroView:_updateJoyDraw( ... )
    self._poolData = GachaGoldenHeroHelper.getGachaState()
    local id = G_UserData:getGachaGoldenHero():getDrop_id()
    local data = GachaGoldenHeroHelper.getGoldenHeroDraw(id)

    self._commonJoyIcon:unInitUI()
    self._commonJoyIcon:initUI(data.type, data.value, 1)
    self._commonJoyIcon:setTouchEnabled(false)

    local index = 0
    if self._poolData.isOver then
        index = 1
    else
        index = self._poolData.isLottery and 2 or 1
    end
    if Lang.checkLang(Lang.CN) then
        self._imageIconTxt:loadTexture(Path.getGoldHeroTxt(GachaGoldenHeroConst.DRAW_JOY_ICONTXT[index]))
        self._imageIconTxt:ignoreContentAdaptWithSize(true)
    else
        local UIHelper  = require("yoka.utils.UIHelper")
		UIHelper.setLabelStyle(self._imageIconTxt,{
			 style = "text_gold_hero_1",
			 text = Lang.getImgText(GachaGoldenHeroConst.DRAW_JOY_ICONTXT[index]),
		})
    end  
end

function GachaGoldenHeroView:_updateJoyCountDown()
    if self._poolData and self._poolData.stage <= 0 then
        self._panelJoy:setVisible(false)
        return
    end

    local leftTime = G_ServerTime:getLeftSeconds(self._poolData.countDowm)
    if leftTime <= 0 then
        if self._poolData.isLottery then
            G_UserData:getGachaGoldenHero():setLuck_draw_num(0)
        end
        self:_updateJoyDraw()
    end
    
    local times = G_ServerTime:getLeftDHMSFormatEx(self._poolData.countDowm)
    self._textJoyTime:setString(tostring(times))
end

function GachaGoldenHeroView:_updateActivityEnd()
    self._activityCountDown:removeAllChildren()
    local entTime = G_UserData:getGachaGoldenHero():getEnd_time()
    local showTime = G_UserData:getGachaGoldenHero():getShow_time()
    local leftTime = G_ServerTime:getLeftSeconds(entTime)
    local desc = (leftTime > 0 and Lang.get("gacha_goldenhero_activityendtime", {time = G_ServerTime:getLeftDHMSFormatEx(entTime)})
                                or Lang.get("gacha_goldenhero_activityshowTime", {time = G_ServerTime:getLeftDHMSFormatEx(showTime)}))
    local fontSize = (leftTime > 0 and 20 or 18)
    local richText = ccui.RichText:createRichTextByFormatString(
        desc,
        {defaultColor = Colors.CLASS_WHITE, defaultSize = fontSize, other ={[1] = {color = Colors.GOLDENHERO_ACTIVITY_END_NORMAL}}})
        
    richText:setAnchorPoint(cc.p(0.5, 0.5))
    self._activityCountDown:addChild(richText)
end

function GachaGoldenHeroView:_initFuncIcon()
    self._topBar:setImageTitle("txt_sys_jianlongzaitian")
    local TopBarStyleConst = require("app.const.TopBarStyleConst")
    self._topBar:updateUI(TopBarStyleConst.STYLE_GOLD_GACHA, true)
    self._topBar:setCallBackOnBack(handler(self, self._onReturnBack))
    if not Lang.checkLang(Lang.CN) then
        local UserDataHelper = require("app.utils.UserDataHelper")
        local money = UserDataHelper.getParameterValue("goldenhero_money")
        self._commonRecharge:updateUI(6, 166, money, 1)
    else
        self._commonRecharge:updateUI(6, 166, 300, 1)
    end
    
    self._commonHelp:updateUI(FunctionConst.FUNC_GACHA_GOLDENHERO)
    if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
        local width = self._topBar:getTitleWidth()
        local posX = self._commonHelp:getPositionX() -150 + width
        self._commonHelp:setPositionX(posX)
    end

    local FunctionConst	= require("app.const.FunctionConst")
    self["_gachaAwards"]:updateUI(FunctionConst.FUNC_GACHA_GOLDENHERO_POINT)
    self["_gachaAwards"]:addClickEventListenerEx(handler(self, self._onButtonClickAwards))
    self["_gachaShop"]:updateUI(FunctionConst.FUNC_GACHA_GOLDENHERO_SHOP)
    self["_gachaShop"]:addClickEventListenerEx(handler(self, self._onButtonClickShop))
end

function GachaGoldenHeroView:_onReturnBack()
    G_UserData:getGachaGoldenHero():c2sGachaExit()
    G_SceneManager:popScene()
end

function GachaGoldenHeroView:_onButtonClickJoy()
    G_SceneManager:showDialog("app.scene.view.gachaGoldHero.PopupJoyGachaView")
end

function GachaGoldenHeroView:_onButtonClickAwards()
    G_SceneManager:showDialog("app.scene.view.gachaGoldHero.PopupGachaAwardsRank")
end

function GachaGoldenHeroView:_onButtonClickShop()
    if not Lang.checkLang(Lang.CN) then
		local startTime = G_UserData:getGachaGoldenHero():getStart_time()
		local endTime = G_UserData:getGachaGoldenHero():getEnd_time()
		local showTime = G_UserData:getGachaGoldenHero():getShow_time()
		local curTime = G_ServerTime:getTime()
		if startTime == 0 or endTime == 0 or curTime > showTime or curTime < startTime then
			G_Prompt:showTip(Lang.get("customactivity_avatar_act_end_tip"))
			return 
		end
	end
    G_SceneManager:showScene("gachaGoldShop")
end

function GachaGoldenHeroView:_initRankView()
    self._pointRankView = PointRankView.new()
    self._nodeRank:addChild(self._pointRankView)
end

function GachaGoldenHeroView:_initDanmu()
    self._danmuPanel = self._commonChat:getPanelDanmu()
	self._danmuPanel:addClickEventListenerEx(handler(self,self._onBtnDanmu))
    self._danmuPanel:setVisible(true)
    G_BulletScreenManager:setBulletScreenOpen(BullectScreenConst.GACHA_GOLDENHERO_TYPE,true)
    self:_updateBulletScreenBtn(BullectScreenConst.GACHA_GOLDENHERO_TYPE)
end

function GachaGoldenHeroView:_onBtnDanmu()
	local bulletOpen = G_UserData:getBulletScreen():isBulletScreenOpen(BullectScreenConst.GACHA_GOLDENHERO_TYPE)
	G_UserData:getBulletScreen():setBulletScreenOpen(BullectScreenConst.GACHA_GOLDENHERO_TYPE, not bulletOpen)
	self:_updateBulletScreenBtn(BullectScreenConst.GACHA_GOLDENHERO_TYPE)
end

function GachaGoldenHeroView:_updateBulletScreenBtn(bulletType)
	self._danmuPanel:getSubNodeByName("Node_1"):setVisible(false)
	self._danmuPanel:getSubNodeByName("Node_2"):setVisible(false)
    local bulletOpen = G_UserData:getBulletScreen():isBulletScreenOpen(bulletType)
    
	if bulletOpen == true then
		self._danmuPanel:getSubNodeByName("Node_1"):setVisible(true)
		G_BulletScreenManager:showBulletLayer()
		self._isBulletOpen = true
	else
		self._danmuPanel:getSubNodeByName("Node_2"):setVisible(true)
		G_BulletScreenManager:hideBulletLayer()
		self._isBulletOpen = false
	end
end

function GachaGoldenHeroView:_touchAvatar(heroId)
    G_SceneManager:showScene("gachaDrawGoldHero", heroId)
end

function GachaGoldenHeroView:_update(dt)
    self:_updateActivityEnd()
    self:_updateJoyCountDown()
end

-- i18n change lable
function GachaGoldenHeroView:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageIconTxt = UIHelper.swapWithLabel(self._imageIconTxt,{
			 style = "text_gold_hero_1",
             text = Lang.getImgText("txt_draw_01"),
             fontSize = 18,
		})
	end
end

return GachaGoldenHeroView