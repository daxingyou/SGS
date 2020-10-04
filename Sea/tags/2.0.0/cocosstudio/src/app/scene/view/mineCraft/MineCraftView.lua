local ViewBase = require("app.ui.ViewBase")
local MineCraftView = class("MineCraftView", ViewBase)

local MineCraftHelper = require("app.scene.view.mineCraft.MineCraftHelper")
local TextHelper = require("app.utils.TextHelper")
local ParameterIDConst = require("app.const.ParameterIDConst")

local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local Avatar = require("app.config.avatar")


MineCraftView.SCALE_AVATAR = 0.5
MineCraftView.AVATAR_POS_FIX = cc.p(60, -40)

MineCraftView.ACTOR_SPEED = 5
MineCraftView.GET_ICON_Y_FIX = 50

MineCraftView.DIE_TYPE_ENEMY = 1
MineCraftView.DIE_TYPE_SELF = 2
MineCraftView.DIE_TYPE_DOUBLE = 3

MineCraftView.SCROLL_TIME = 0.5

MineCraftView.SCALE_PERCENT = 0.9
MineCraftView.MOVE_AVATAR_MAX = 50

local SchedulerHelper = require ("app.utils.SchedulerHelper")

function MineCraftView:waitEnterMsg(callBack)
	local function onMsgCallBack()
		callBack()
    end
    G_UserData:getMineCraftData():clearAllMineUser()
	G_UserData:getMineCraftData():c2sGetMineWorld()
    local signal = G_SignalManager:add(SignalConst.EVENT_GET_MINE_WORLD, onMsgCallBack)
	return signal
end

function MineCraftView:ctor()

    --ui
    self._scrollMapBG = nil     --地图滚动层
    self._mineBaseNode = nil    --矿坑根节点
    self._topBar = nil 	        --顶部条
    self._heroAvatar = nil      --人物avatar

    self._mapSize = cc.size(0, 0)       --大地图宽高

    --signals
    self._signalGetMineWorld = nil
    self._signalSettleMine = nil
    self._signalMineRespond = nil
    self._signalGetMineMoney = nil
    self._signalBattleMine = nil
    self._signalReConnect = nil
    self._signalFastBattle = nil
    self._signalRedPointUpdate = nil
    self._signalMineNotice = nil

    --是否在移动中
    self._ismoving = false
    self._outputMoney = 0   --产出银币
    self._mineGetMoneyIcon = nil

    self._lastUpdate = 0

    self._lastMineId = 0

    self._moveAvatars = {}      --可移动avatar数组

    self._lastDoubleActionTime = 0

    --矿区列表
    self._mines = {}

	local resource = {
		file = Path.getCSB("MineCraftView", "mineCraft"),
        size = G_ResolutionManager:getDesignSize(),
		binding = {
			_btnReport = 
			{
				events = {{event = "touch", method = "_onReportClick"}}
            },
            _btnMyPos = 
            {
                events = {{event = "touch", method = "_onMineClick"}}
            },
            _imageArmyBG = 
            {
                events = {{event = "touch", method = "_onAddArmyClick"}}
            },
            _btnPrivilege = 
            {
                events = {{event = "touch", method = "_onPrivilege"}}
            },
		}
	}
    MineCraftView.super.ctor(self, resource)
end

function MineCraftView:onCreate()
    -- i18n change lable
    self:_dealI18n()
    -- i18n pos lable
    self:_dealPosByI18n()

    self._topBar:setImageTitle("txt_sys_com_mine")
    local TopBarStyleConst = require("app.const.TopBarStyleConst")
    self._topBar:updateUI(TopBarStyleConst.STYLE_MINE_CRAFT)
    self._btnPrivilege:setVisible(false)
    self._textPrivilegeTime:setVisible(false)
    self:_updatePrivilege()

    self:_createMapBG()
    self:_createMineNode()
    self:_createAvatar()

    self._btnReport:updateUI(FunctionConst.FUNC_MINE_REPORT)
    self._btnMyPos:updateUI(FunctionConst.FUNC_MINE_POS)
    self._btnRule:updateUI(FunctionConst.FUNC_MINE_CRAFT)
    self._btnPrivilege:updateUI(FunctionConst.FUNC_MINE_CRAFT_PRIVILEGE)
end

function MineCraftView:onEnter()
    self._signalGetMineWorld = G_SignalManager:add(SignalConst.EVENT_GET_MINE_WORLD, handler(self, self._onEventGetMineWorld))
    self._signalSettleMine = G_SignalManager:add(SignalConst.EVENT_SETTLE_MINE, handler(self, self._onEventSettleMine))
    self._signalMineRespond = G_SignalManager:add(SignalConst.EVENT_GET_MINE_RESPOND, handler(self, self._onEventMineRespond))
    self._signalGetMineMoney = G_SignalManager:add(SignalConst.EVENT_GET_MINE_MONEY, handler(self, self._onEventGetMineMoney))
    self._signalBattleMine = G_SignalManager:add(SignalConst.EVENT_BATTLE_MINE, handler(self, self._onEventBattleMine))
    self._signalReConnect = G_SignalManager:add(SignalConst.EVENT_LOGIN_SUCCESS, handler(self, self._onEventFinishLogin))
    self._signalFastBattle = G_SignalManager:add(SignalConst.EVENT_FAST_BATTLE, handler(self, self._onEventFastBattle))
    self._signalRedPointUpdate  = G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self,self._onEventRedPointUpdate))
    self._signalMineNotice = G_SignalManager:add(SignalConst.EVENT_MINE_NOTICE, handler(self, self._onEventMineNotice))
    self._signalUpdateTitleInfo =
        G_SignalManager:add(SignalConst.EVENT_UPDATE_TITLE_INFO, handler(self, self._onEventTitleChange)) -- 称号更新
    self._scheduleHandler = SchedulerHelper.newSchedule(handler(self, self._update), 0.03)

    self:_refreshView()
    self:_refreshAvatar()
    self:_refreshViewPos(true)
    self:_updateMyArmy()

    self:_checkKillNotice()
    self:_onEventRedPointUpdate()

    local runningScene = G_SceneManager:getRunningScene()
    runningScene:addGetUserBaseInfoEvent()
    
    local time = G_ServerTime:getNextHourCount(12)
    self._textTime:setString(time)
    

    --服务器改成广播了，这边就不用刷了
    -- if not self._isFirstEnter then
    --     G_UserData:getMineCraftData():c2sGetMineWorld()
    -- end
    -- self._isFirstEnter = false
end

function MineCraftView:_updatePrivilege( ... )
    if self._btnPrivilege:isVisible() then
        if G_UserData:getMineCraftData():isSelfPrivilege() then
            self:_updateMyArmy()
            self._btnPrivilege:showRedPoint(G_UserData:getMineCraftData():isPrivilegeRedPoint())
            local leftSec = G_ServerTime:getLeftSeconds(G_UserData:getMineCraftData():getPrivilegeTime())
            self._textPrivilegeTime:setVisible(leftSec > 0)
            self._textPrivilegeTime:setString(G_ServerTime:getLeftDHMSFormatEx(G_UserData:getMineCraftData():getPrivilegeTime()))
        end
        return
    end
    local payCfg = MineCraftHelper.getPrivilegeVipCfg()
    local vipLimit = payCfg.vip_show
    local vipLevel = G_UserData:getVip():getLevel() or 0
    local bVisible = (vipLimit <= vipLevel)
    self._btnPrivilege:setVisible(bVisible)
    --i18n change function show
    if Lang.checkChannel(Lang.CHANNEL_SEA) then
        -- self._btnPrivilege:setVisible(false)
    end
end

function MineCraftView:onExit()
    self._signalGetMineWorld:remove()
    self._signalGetMineWorld = nil

    self._signalSettleMine:remove()
    self._signalSettleMine = nil

    self._signalMineRespond:remove()
    self._signalMineRespond = nil

    self._signalGetMineMoney:remove()
    self._signalGetMineMoney = nil
    
    self._signalBattleMine:remove()
    self._signalBattleMine = nil

    self._signalReConnect:remove()
    self._signalReConnect = nil

    self._signalFastBattle:remove()
    self._signalFastBattle = nil

    self._signalRedPointUpdate:remove()
    self._signalRedPointUpdate = nil

    self._signalMineNotice:remove()
    self._signalMineNotice = nil

    self._signalUpdateTitleInfo:remove()
    self._signalUpdateTitleInfo=nil

    if self._scheduleHandler ~= nil then
		SchedulerHelper.cancelSchedule(self._scheduleHandler)
		self._scheduleHandler = nil
	end
end

function MineCraftView:_checkKillNotice()
    local killType = G_UserData:getMineCraftData():getKillType()
    if killType ~= 0 then 
        local enemyDiePos = G_UserData:getMineCraftData():getTargetPos()
        local enemyMine = G_UserData:getMineCraftData():getMineConfigById(enemyDiePos)
        local enemyCity = ""
        if enemyMine then
            enemyCity= enemyMine.pit_name
        end

        local myData = G_UserData:getMineCraftData():getMyMineData()
        local myCityName = myData:getConfigData().pit_name

        if killType == MineCraftView.DIE_TYPE_ENEMY then 
            MineCraftHelper.openAlertDlg(Lang.get("fight_enemy_kill_title"), Lang.get("mine_enemy_kill_content", {city = enemyCity}))
        elseif killType == MineCraftView.DIE_TYPE_SELF then 
            MineCraftHelper.openAlertDlg(Lang.get("mine_self_kill_title"), Lang.get("mine_self_kill_content", {city = myCityName}))
        elseif killType == MineCraftView.DIE_TYPE_DOUBLE then 
            MineCraftHelper.openAlertDlg(Lang.get("mine_All_kill_title"), Lang.get("mine_All_kill_content", {city1 = enemyCity, city2 = myCityName}))
        end
    end
    G_UserData:getMineCraftData():setKillType(0)
end

--创建地图
function MineCraftView:_createMapBG()
    local innerContainer = self._scrollMapBG:getInnerContainer()
    --加入4副图片
    local pic1 = display.newSprite(Path.getStageBG("minebg3"))     --左下
    pic1:setAnchorPoint(cc.p(0, 0))
    pic1:setPosition(cc.p(0, 0))
    innerContainer:addChild(pic1)
    local size = pic1:getContentSize()

    local pic2 = display.newSprite(Path.getStageBG("minebg4"))     --右下
    pic2:setAnchorPoint(cc.p(0, 0))
    pic2:setPosition(cc.p(size.width, 0))
    innerContainer:addChild(pic2)
    size.width = size.width + pic2:getContentSize().width

    local pic3 = display.newSprite(Path.getStageBG("minebg1"))     --左上
    pic3:setAnchorPoint(cc.p(0, 0))
    pic3:setPosition(cc.p(0, size.height))
    innerContainer:addChild(pic3)
    size.height = size.height + pic3:getContentSize().height

    local pic4 = display.newSprite(Path.getStageBG("minebg2"))      --右上
    pic4:setAnchorPoint(cc.p(0, 0))
    pic4:setPosition(cc.p(pic3:getContentSize().width , pic1:getContentSize().height))
    innerContainer:addChild(pic4)

    self._mineBaseNode = cc.Node:create()
    innerContainer:addChild(self._mineBaseNode)
    self._mineBaseNode:setPosition(cc.p(0, 0))
    self._mapSize = size
    -- size.width = size.width * MineCraftView.SCALE_PERCENT
    -- size.height = size.height * MineCraftView.SCALE_PERCENT
    local scaleSize = cc.size(size.width * MineCraftView.SCALE_PERCENT, size.height * MineCraftView.SCALE_PERCENT)
    self._scrollMapBG:setInnerContainerSize(scaleSize)
    innerContainer:setPosition(cc.p(0, 0))
    innerContainer:setScale(MineCraftView.SCALE_PERCENT)
    -- self._scrollMapBG:setInertiaScrollEnabled(false)
    
end

--创建地图节点
function MineCraftView:_createMineNode()
    local mineDataList = G_UserData:getMineCraftData():getMines()
    for _, v in pairs(mineDataList) do 
        local mineNode = require("app.scene.view.mineCraft.MineNode").new(v)
        self._mineBaseNode:addChild(mineNode)
        self._mines[v:getId()] = mineNode
        mineNode:updateUI()
    end

    self._mineGetMoneyIcon = require("app.scene.view.mineCraft.MineGetMoneyIcon").new()
    self._mineBaseNode:addChild(self._mineGetMoneyIcon)
    self._mineGetMoneyIcon:setVisible(false)
end

--创建地图人物
function MineCraftView:_createAvatar()
    local CSHelper = require("yoka.utils.CSHelper")
    self._heroAvatar =  CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
    self._mineBaseNode:addChild(self._heroAvatar)
    local avatarId = G_UserData:getBase():getAvatar_base_id()
    local config = Avatar.get(avatarId)
    assert(config, "wront avatar id , avatarId")
    local limit = config.limit == 1 and 3
    self._heroAvatar:updateUI(G_UserData:getBase():getPlayerBaseId(), nil, nil, limit)
    self._heroAvatar:setScale(MineCraftView.SCALE_AVATAR)    
    --self._heroAvatar:turnBack()
    self:_showMineTitle()
end

-- 显示自己的称号
function MineCraftView:_showMineTitle()
    local PopupHonorTitleHelper = require("app.scene.view.playerDetail.PopupHonorTitleHelper")
    local titleItem=PopupHonorTitleHelper.getEquipedTitle()
    local titleId=titleItem and titleItem:getId() or 0
    self._heroAvatar:showTitle(titleId,self.__cname)
end

function MineCraftView:_onEventTitleChange()
    self:_showMineTitle()
end

--获得地图信息
function MineCraftView:_onEventGetMineWorld(eventName, message)
    if not self._ismoving then 
        self:_refreshView()
    end
end

--移动
function MineCraftView:_onEventSettleMine()
    self._roads = G_UserData:getMineCraftData():getRoads()
    self:_movebyPath()
end

--移动
function MineCraftView:_movebyPath()
    self._heroAvatar:setAction("run", true)
    self._ismoving = true
    self._moveIndex = 2
    -- local selfMineId = G_UserData:getMineCraftData():getSelfMineId() 
    self:_setSingleRoadConfig(self._roads[1], self._roads[self._moveIndex])
end

--单条线路移动
function MineCraftView:_setSingleRoadConfig(minPit1, minPit2)
    local midPoints = G_UserData:getMineCraftData():getMidPoints()
    local midPoint = midPoints[minPit1..minPit2]
    if not midPoint then 
        midPoint = midPoints[minPit2..minPit1]
    end
    assert(midPoint, "not midPoint between "..minPit1.."and"..minPit2)
    local startData = G_UserData:getMineCraftData():getMineDataById(minPit1):getConfigData()
    local startPos = cc.p(startData.x, startData.y)
    
    local endData = G_UserData:getMineCraftData():getMineDataById(minPit2):getConfigData()
    local endPos = cc.p(endData.x, endData.y)

    self._heroAvatar:setPosition(startPos)
    self._bezier = {
		cc.p(0, 0),
		cc.pSub(midPoint, startPos),
		cc.pSub(endPos, startPos),
    }
    self._maxdistance = cc.pGetDistance(startPos, endPos)
	self._distance = 0
    self._positionDelta = cc.pSub(endPos, startPos)
    self._startPos = startPos

    if endPos.x < startPos.x then 
		self._heroAvatar:turnBack()
	else 
		self._heroAvatar:turnBack(false)
	end
end

function MineCraftView:_actorMoving(f)
	self._distance = self._distance + MineCraftView.ACTOR_SPEED
	local t = self._distance / self._maxdistance
	t = t > 1 and 1 or t

	local posx, posy, angle = MineCraftHelper.getBezierPosition(self._bezier, t)
	local pos = cc.pAdd(self._startPos, cc.p(posx, posy))
    self._heroAvatar:setPosition(pos)
    self:_refreshViewPos()
	if t == 1 then
        if self._moveIndex == #self._roads then 
            self._ismoving = false
            self:_refreshView()
            self:_refreshAvatar()
            self:_popupSelfMine()
        else 
            self:_setSingleRoadConfig(self._roads[self._moveIndex], self._roads[self._moveIndex + 1])
            self._moveIndex = self._moveIndex + 1
        end
        
		-- self:_openPopupMine(self._targetId)
		-- self:_refreshUI()
		-- self._myAvatar:setAction("idle", true)
		-- self._myAvatar:turnBack()
	end
end

--
function MineCraftView:_update(f)
    if self._ismoving then 
        self:_actorMoving(f)
    end

    self._lastUpdate = self._lastUpdate + f 
	if self._lastUpdate > 1 then
		self:_updateMyMoney()
		-- self:_updateMoneyIcon()
		self._lastUpdate = 0
    end
    
    local curTime = G_ServerTime:getTime()
    if curTime - self._lastDoubleActionTime >= 10 then 
        self:_doDoubleIconsAnim()
        self._lastDoubleActionTime = curTime
    end

    local time = G_ServerTime:getNextHourCount(12)
    self._textTime:setString(time)
    self:_updatePrivilege()
end

function MineCraftView:_doDoubleIconsAnim()
    for i, v in pairs(self._mines) do 
        v:doDoubleAnim()
    end
end

--跟新人物坐标
function MineCraftView:_refreshAvatar()
    local selfMine = G_UserData:getMineCraftData():getMyMineData()
    local config = selfMine:getConfigData()
    local position = cc.p(config.x - MineCraftView.AVATAR_POS_FIX.x, config.y + MineCraftView.AVATAR_POS_FIX.y)
    self._heroAvatar:setPosition(position)
    --self._heroAvatar:turnBack()
    self._heroAvatar:setAction("idle", true)
end

--更新地图坐标，把avatar放在界面中央, 参数是否把矿放中心
function MineCraftView:_refreshViewPos(isMinePos, needSlow)

    local size = G_ResolutionManager:getDesignCCSize()
    local width = size.width / 2
    local height = size.height / 2

    local avatarX, avatarY 
    if isMinePos then 
        local selfMine = G_UserData:getMineCraftData():getMyMineData()
        local config = selfMine:getConfigData()
        avatarX = config.x
        avatarY = config.y
    else
        avatarX, avatarY= self._heroAvatar:getPosition()
    end

    local mapY = 0
    if avatarY < height then 
        mapY = 0
    elseif avatarY + height > self._mapSize.height then 
        mapY = -self._mapSize.height + height*2
    else 
        mapY = -avatarY + height
    end

    local mapX = 0
    if avatarX < width then 
        mapX = 0
    elseif avatarX + width > self._mapSize.width then 
        mapX = -self._mapSize.width + width*2
    else 
        mapX = -avatarX + width
    end

    local xxx = (-mapX) / (self._mapSize.width - width*2) * 100
    local yyy = 100 - (-mapY) / (self._mapSize.height - height*2) * 100
    if not needSlow then 
        self._scrollMapBG:jumpToPercentBothDirection(cc.p(xxx, yyy))
    else
        self._scrollMapBG:scrollToPercentBothDirection(cc.p(xxx, yyy), MineCraftView.SCROLL_TIME, true)
    end
end

--刷新世界
function MineCraftView:_onEventMineRespond(eventName)
    if not self._ismoving then 
        self:_refreshView()
    end
end

--刷新世界地图
function MineCraftView:_refreshView()
    self:_refreshMyMoney()
    self:_updateMyMoney()
    -- self:_updateMoneyIcon()
    self:_updateMoneyIconPos()
    for i, v in pairs(self._mines) do 
        v:updateUI()
    end
    if self._lastMineId ~= G_UserData:getMineCraftData():getSelfMineId() then
        self:_refreshAvatar()
        self:_refreshViewPos(true)
        self._lastMineId = G_UserData:getMineCraftData():getSelfMineId()
    end
    self:_updateMyArmy()
    -- self:_refreshAddBtn()
end

--刷新我的信息
function MineCraftView:_refreshMyMoney()
    self._outputMoney = MineCraftHelper.getSelfOutputSec()
end

--更新我的钱
function MineCraftView:_updateMyMoney()

    local moneyCount, moneyText, timePercent = MineCraftHelper.getMoneyDetail(self._outputMoney)
    self._mineGetMoneyIcon:setVisible(moneyCount >= 1)
    self._mineGetMoneyIcon:updateUI(moneyText)
    self._mineGetMoneyIcon:updateTimer(timePercent)
end

function MineCraftView:_updateMoneyIconPos()
    local selfMineData = G_UserData:getMineCraftData():getMyMineData()
    local config = selfMineData:getConfigData()
    self._mineGetMoneyIcon:setPosition(cc.p(config.x, config.y+MineCraftView.GET_ICON_Y_FIX))
end

--更新收获按钮
function MineCraftView:_onEventGetMineMoney(eventName, award)
    G_Prompt:showAwards(award)
    self._mineGetMoneyIcon:setVisible(false)
	-- self:_updateMoneyIcon()
end

--更新我的兵力
function MineCraftView:_updateMyArmy()
    local nowArmy = G_UserData:getMineCraftData():getMyArmyValue()
    local maxArmy = tonumber(require("app.config.parameter").get(ParameterIDConst.TROOP_MAX).content)
    if G_UserData:getMineCraftData():isSelfPrivilege() then
        local soilderAdd  = MineCraftHelper.getParameterContent(G_ParameterIDConst.MINE_CRAFT_SOILDERADD)
        maxArmy = (maxArmy + soilderAdd)
    end
    self._textSeflArmy:setString(nowArmy.." / "..maxArmy)
    
    self._barArmy:setVisible(false)
    self._barArmyY:setVisible(false)
    self._barArmyR:setVisible(false)
    local percent = nowArmy/maxArmy*100
    local armyBar = self._barArmy
    if percent < 25 then 
        armyBar = self._barArmyR
    elseif percent < 75 then 
        armyBar = self._barArmyY
    end

    armyBar:setPercent(nowArmy/maxArmy*100)
    armyBar:setVisible(true)

    self._nodeLessArmyInfo:setVisible(false)
    local myConfig = G_UserData:getMineCraftData():getMyMineConfig()
    if myConfig.pit_type == MineCraftHelper.TYPE_MAIN_CITY and nowArmy < MineCraftHelper.ARMY_TO_LEAVE then 
        self._nodeLessArmyInfo:setVisible(true)
    end
end

--弹出个人所在矿区
function MineCraftView:_popupSelfMine()
    local selfMineData = G_UserData:getMineCraftData():getMyMineData()
    G_SceneManager:showDialog("app.scene.view.mineCraft.PopupMine", nil, selfMineData:getId(), selfMineData)
end

--攻击
function MineCraftView:_onEventBattleMine(eventName, message, target)

    local config = G_UserData:getMineCraftData():getMyMineData():getConfigData()
	local fightBG = config.battle_bg
    local mineFightData = 
	{
		star = message.self_star,
        myBeginArmy = message.self_begin_army,
        myEndArmy = message.self_begin_army - message.self_red_army,

        tarBeginArmy = message.tar_begin_army,
        tarEndArmy = message.tar_begin_army - message.tar_red_army,
    }
    
    if mineFightData.tarEndArmy <= 0 and mineFightData.myEndArmy <= 0 then 
        G_UserData:getMineCraftData():setKillType(MineCraftView.DIE_TYPE_DOUBLE)
    elseif mineFightData.tarEndArmy <= 0 then 
        G_UserData:getMineCraftData():setKillType(MineCraftView.DIE_TYPE_ENEMY)
    elseif mineFightData.myEndArmy <= 0 then 
        G_UserData:getMineCraftData():setKillType(MineCraftView.DIE_TYPE_SELF)
    end

    local function enterFightView(message)
        local ReportParser = require("app.fight.report.ReportParser")
        local battleReport = G_UserData:getFightReport():getReport()
        local reportData = ReportParser.parse(battleReport)
        local battleData = require("app.utils.BattleDataHelper").parseMineBattle(target, fightBG, mineFightData )
        G_SceneManager:showScene("fight", reportData, battleData)       
    end

    G_SceneManager:registerGetReport(message.battle_report, function() enterFightView(message, target, fightBG, mineFightData) end)
    
end

function MineCraftView:_onReportClick()
	G_SceneManager:showDialog("app.scene.view.mineCraft.PopupReport")
end

function MineCraftView:_onMineClick()
    self:_refreshViewPos(true, true)
end

function MineCraftView:_onAddArmyClick()
    local myConfig = G_UserData:getMineCraftData():getMyMineConfig()
    if myConfig.pit_type ~= MineCraftHelper.TYPE_MAIN_CITY then 
        G_Prompt:showTip(Lang.get("mine_cannot_buy"))
    elseif MineCraftHelper.getNeedArmy() == 0 then 
        G_Prompt:showTip(Lang.get("mine_buy_army_full"))
    else
        local popupMineSweep = require("app.scene.view.mineCraft.PopupBuyArmy").new()
        popupMineSweep:openWithAction()
    end
end

function MineCraftView:_onPrivilege()
    G_SceneManager:showDialog("app.scene.view.mineCraft.PopupMineCraftPrivilege")
end

function MineCraftView:_onEventFinishLogin()
    G_UserData:getMineCraftData():clearAllMineUser()
    G_UserData:getMineCraftData():c2sGetMineWorld()
end

function MineCraftView:_onEventFastBattle(eventName, reportList)
    local popupMineSweep = require("app.scene.view.mineCraft.PopupMineSweep").new(reportList)
    popupMineSweep:openWithAction()
end

function MineCraftView:_onEventRedPointUpdate()
    local RedPointHelper = require("app.data.RedPointHelper")
    local newReport, count = RedPointHelper.isModuleSubReach(FunctionConst.FUNC_MINE_CRAFT, "reportRP")
    -- self._btnReport:showRedPoint(newReport)
    self._imageRP:setVisible(newReport)
    self._textRPCount:setString(count)
end

function MineCraftView:_onEventMineNotice(eventName, user, oldMineId, newMineId)
    local avatar = self:_getMoveAvatar()
    if not avatar then 
        return 
    end

    local offLevel = tonumber(user.officer_level)
    local name = user.name
    local avatarId = user.avatar_base_id
    local baseId = user.leader
    -- logWarn("MineCraftView:_onEventMineNotice")
    -- dump(user)
    local limit = nil
    if avatarId ~= 0 then
        local configData = require("app.utils.data.AvatarDataHelper").getAvatarConfig(avatarId)
        baseId = configData.hero_id
        local isRed = configData.limit
        if isRed == 1 then 
            limit = 3
        end
    end
    local titleId = user.title or 0
    avatar:updateUI(baseId, name, offLevel, limit, titleId)
    avatar:setVisible(true)
    local mineData = G_UserData:getMineCraftData():getMineDataById(oldMineId)
    local config = mineData:getConfigData()
    local position = cc.p(config.x, config.y + MineCraftView.AVATAR_POS_FIX.y)
    avatar:setPosition(position)
    local path = MineCraftHelper.getRoad(oldMineId, newMineId)
    table.insert(path, 1, oldMineId)
    self:_moveByPath(avatar, path)
end

function MineCraftView:_moveByPath(avatar, path)
    avatar:setAction("run", true)
    local actions = {}
    for i = 2, #path do 
        local minPit1 = path[i-1]
        local minPit2 = path[i]
        local midPoints = G_UserData:getMineCraftData():getMidPoints()
        local midPoint = midPoints[minPit1..minPit2]
        if not midPoint then 
            midPoint = midPoints[minPit2..minPit1]
        end
        local startData = G_UserData:getMineCraftData():getMineDataById(minPit1):getConfigData()
        local startPos = cc.p(startData.x, startData.y+MineCraftView.AVATAR_POS_FIX.y)

        local endData = G_UserData:getMineCraftData():getMineDataById(minPit2):getConfigData()
        local endPos = cc.p(endData.x, endData.y+MineCraftView.AVATAR_POS_FIX.y)

        local actionFunc = cc.CallFunc:create(function()     
            if endPos.x < startPos.x then 
                avatar:turnBack()
            else 
                avatar:turnBack(false)
            end
        end)
        local actionBezier = cc.BezierTo:create(1.5, {midPoint, endPos, endPos})
        local action = cc.Spawn:create(actionBezier, actionFunc)
        table.insert(actions, action)
    end
    local callBack = cc.CallFunc:create(function() avatar:setVisible(false) end)
    table.insert(actions, callBack)
    local action = cc.Sequence:create(actions)
    avatar:runAction(action)
end

function MineCraftView:_getMoveAvatar()
    for i, v in pairs(self._moveAvatars) do 
        if not v:isVisible() then 
            return v
        end
    end
    if #self._moveAvatars >= MineCraftView.MOVE_AVATAR_MAX then 
        return nil 
    end
    return self:_createMoveAvatar()
end

function MineCraftView:_createMoveAvatar()
    -- local CSHelper = require("yoka.utils.CSHelper")
    -- local heroAvatar = CSHelper.loadResourceNode(Path.getCSB("CommonHeroAvatar", "common"))
    local heroAvatar = require("app.scene.view.mineCraft.MineMoveAvatar").new()
    heroAvatar:setVisible(false)
    -- heroAvatar:setScale(MineCraftView.SCALE_AVATAR)
    self._mineBaseNode:addChild(heroAvatar)
    table.insert(self._moveAvatars, heroAvatar)
    return heroAvatar
end


-- i18n change lable
function MineCraftView:_dealI18n()
    if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local label = UIHelper.seekNodeByName(self,"TextNowArmy")
        label:setPositionX(label:getPositionX() + 11)
      
        self._btnRule:setPositionY(  self._btnRule:getPositionY())

        self._btnMyPos:setPositionX(self._btnMyPos:getPositionX() -33)
        self._btnReport:setPositionX(self._btnReport:getPositionX() -16)

        self._btnPrivilege:setPositionX(self._btnPrivilege:getPositionX() -48)
	end
end


-- i18n pos lable
function MineCraftView:_dealPosByI18n()
    if Lang.checkLang(Lang.EN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        local image8 = UIHelper.seekNodeByName(self,"Image_8")
        local size = image8:getContentSize()
        image8:setContentSize(cc.size(size.width+50,size.height))
    end
    if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        local image8 = UIHelper.seekNodeByName(self,"Image_8")
        local textRichMine = UIHelper.seekNodeByName(image8,"TextRichMine")
        local size = image8:getContentSize()
        local size1 = textRichMine:getContentSize()
        local size2 = self._textTime:getContentSize()
       
      
       
        textRichMine:setPositionX( size.width * 0.5 -  size2.width*0.5)
		self._textTime:setPositionX( size.width * 0.5 + size1.width * 0.5)

        local textInfo = UIHelper.seekNodeByName(self._nodeLessArmyInfo,"Text_Info")
       -- local imageInfo = UIHelper.seekNodeByName(self._nodeLessArmyInfo,"ImageInfo")

      --  textInfo:setAnchorPoint(cc.p(0,0.5))
        --textInfo:setPositionX(imageInfo:getPositionX()+imageInfo:getContentSize().width*0.5+3)


	end
end


return MineCraftView