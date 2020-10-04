--军团战主界面
local ViewBase = require("app.ui.ViewBase")
local GuildCrossWarBattleView = class("GuildCrossWarBattleView", ViewBase)
local Path = require("app.utils.Path")
local AudioConst = require("app.const.AudioConst")
local GuildCrossWarBattleMapNode = import(".GuildCrossWarBattleMapNode")
local GuildCrossWarMiniMap = import(".GuildCrossWarMiniMap")
local GuildCrossWarConst = require("app.const.GuildCrossWarConst")
local GuildCrossWarHelper = import(".GuildCrossWarHelper")
local scheduler = require("cocos.framework.scheduler")
local GuildCrossWarRebornCDNode = import(".GuildCrossWarRebornCDNode")


-- @Role    
function GuildCrossWarBattleView:waitEnterMsg(callBack)
	local function onMsgCallBack(id, message)
		callBack()
	end

    local state, _ = GuildCrossWarHelper.getCurCrossWarStage()
    if GuildCrossWarConst.ACTIVITY_STAGE_1 == state or GuildCrossWarConst.ACTIVITY_STAGE_2 == state then
        G_UserData:getGuildCrossWar():c2sBrawlGuildsEntry()
    else
        G_Prompt:showTip(Lang.get("未开启"))
    end

	local signal = G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_ENTRY, onMsgCallBack)
	return signal
end

function GuildCrossWarBattleView:ctor()
    self._mapNode = nil --底图
    self._miniNode = nil
    self._rebornCDNode  = nil
    self._nodeRebornCDParent = nil
    self._btnReport = nil
    self._btnMail = nil
    self._commonChat = nil
    self._topbarBase = nil
    self._commonHelp = nil
    self._imgCountDown = nil
    self._commonCountDown = nil
    self._autoMovingNode = nil

    self._battleMapNode = nil
    self._miniMapNode = nil

    self._delayUpdate = 0

    
    local resource = {
        file = Path.getCSB("GuildCrossWarBattleView", "guildCrossWar"),
        size = G_ResolutionManager:getDesignSize(),
        binding = {
            _btnReport = {
                events = {{event = "touch", method = "_onBtnReport"}}
            },
        }
    }
    self:setName("GuildCrossWarBattleView")
    GuildCrossWarBattleView.super.ctor(self, resource)
end

function GuildCrossWarBattleView:onCreate()
    local mapNode = GuildCrossWarBattleMapNode.new()
    local miniMapNode = GuildCrossWarMiniMap.new()
    self._battleMapNode = mapNode
    self._mapNode:addChild(mapNode)
    self._miniMapNode = miniMapNode
    self._miniNode:addChild(miniMapNode)
    
    self._btnReport:updateUI(FunctionConst.FUNC_GUILD_CROSS_REWARDRANK)
    self._btnMail:setVisible(false)
    
    self:_initTopBar()
    self:_initCountDown()
    self:_initRebornView()
    self:_initAotuFindingEffect()
end

function GuildCrossWarBattleView:_initTopBar()
    -- body
    self._topbarBase:setImageTitle("txt_sys_qintombo")
    local TopBarStyleConst = require("app.const.TopBarStyleConst")
    self._topbarBase:updateUI(TopBarStyleConst.STYLE_SEASONSPORT)
    self._commonHelp:addClickEventListenerEx(handler(self, self._onClickHelp))
    self._topbarBase:setCallBackOnBack(handler(self, self._onReturnBack))
end

function GuildCrossWarBattleView:_initCountDown()
    local __, endTime = GuildCrossWarHelper.getCurCrossWarStage()
    if endTime == 0 then
        return
    end

    local function endCallback()
        local __, endTime = GuildCrossWarHelper.getCurCrossWarStage()
        if endTime ~= 0 then
            self._commonCountDown:startCountDown(Lang.get("groups_remaining_time"), endTime)
            G_UserData:getGuildCrossWar():c2sBrawlGuildsEntry()    
        end
    end
    self._commonCountDown:setCountdownTimeParam({color = Colors.WHITE, outlineColor = Colors.DEFAULT_OUTLINE_COLOR})
    self._commonCountDown:startCountDown(Lang.get("groups_remaining_time"), endTime, endCallback)
end

function GuildCrossWarBattleView:_initAotuFindingEffect()
    G_EffectGfxMgr:createPlayGfx(self._autoMovingNode, "effect_xianqinhuangling_zidongxunluzhong", nil, true)
    self._autoMovingNode:setVisible(false)
end

function GuildCrossWarBattleView:_initRebornView()
    local rebornCDNode = GuildCrossWarRebornCDNode.new()
    self._rebornCDNode = rebornCDNode
    self._rebornCDNode:setVisible(false)
    self._nodeRebornCDParent:addChild(rebornCDNode)
end

function GuildCrossWarBattleView:_onReturnBack()
    G_SceneManager:popScene()
end

function GuildCrossWarBattleView:_onBtnReport()
    G_SceneManager:showDialog("app.scene.view.guildCrossWar.PopupGuildCrossWarRank")
end

function GuildCrossWarBattleView:_onClickHelp(sender)
    local PopupGuildCrossWarHelp = require("app.scene.view.guildCrossWar.PopupGuildCrossWarHelp")
	local dlg = PopupGuildCrossWarHelp.new()
	dlg:updateByFunctionId(FunctionConst.FUNC_GUILD_CROSS_WAR)
	dlg:open()
end

function GuildCrossWarBattleView:_onClickButton(sender)
end

function GuildCrossWarBattleView:onEnter() 
    self._signalFightSelfDie = G_SignalManager:add(SignalConst.EVENT_GUILDCROSS_WAR_SELFDIE, handler(self, self._onEventFightSelfDie))
    
    self:scheduleUpdateWithPriorityLua(handler(self, self._onUpdate), 0)
    self._rebornCDNode:updateVisible()
end

function GuildCrossWarBattleView:onExit()
    self._signalFightSelfDie:remove()
    self._signalFightSelfDie = nil
    self:unscheduleUpdate()
end

-- @Role    Update moving Effect
function GuildCrossWarBattleView:_updateAuotMovingEffect()
	local selfUnit = G_UserData:getGuildCrossWar():getSelfUnit()
	if selfUnit == nil then
		return
	end

    if self._autoMovingNode:isVisible() ~= selfUnit:isMoving() then
        self._autoMovingNode:setVisible(selfUnit:isMoving())
    end
end

-- @Role    Update
function GuildCrossWarBattleView:_onUpdate(dt)
    local scaleFator = GuildCrossWarConst.CAMERA_SCALE_MIN
    local cameraPos, cameraSize = self._battleMapNode:getCameraPos()

    self._miniMapNode:updateCamera(cameraPos.x * scaleFator, cameraPos.y * scaleFator)
    local selfPosX, selfPosY = self._battleMapNode:getSelfPosition()
    if selfPosX and selfPosY then
        self._miniMapNode:updateSelf(selfPosX, selfPosY)
    end

    --
    --dump(dt)
    self._delayUpdate = (self._delayUpdate + dt)
    if self._delayUpdate >= 2 then
        self._delayUpdate = 0
        local userlist = self._battleMapNode:getUserList()
        self._miniMapNode:updateSelfGuildNumber(userlist)
    end

    --
    self:_updateAuotMovingEffect()

    if self._rebornCDNode:isInReborn() then
        self._rebornCDNode:refreshCdTimeView()
    end
end

function GuildCrossWarBattleView:_onEventFightSelfDie(id, message)
    self._rebornCDNode:startCD()
end


return GuildCrossWarBattleView
