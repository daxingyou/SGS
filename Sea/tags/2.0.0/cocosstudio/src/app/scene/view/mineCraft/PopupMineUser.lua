local PopupBase = require("app.ui.PopupBase")
local PopupMineUser = class("PopupMineUser", PopupBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local MineCraftHelper = require("app.scene.view.mineCraft.MineCraftHelper")
local MineBarNode = require("app.scene.view.mineCraft.MineBarNode")
local TextHelper = require("app.utils.TextHelper")

PopupMineUser.SWEEP_MAX = 5
PopupMineUser.SWEEP_INFINITE = 10000 --i18n 合并矿战的碾压功能

function PopupMineUser:ctor(userId, mineData)
    self._mineData = mineData
    self._userId = userId
    self._mineConfig = mineData:getConfigData()

    -- self._signalEnterMine = nil
    self._signalMineRespond = nil
    self._signalBattleMine = nil
    self._singalFastBattle = nil
    self._signalBuyItem = nil

	local resource = {
		file = Path.getCSB("PopupMineUser", "mineCraft"),
		binding = {
			_btnCancel = {
				events = {{event = "touch", method = "_onFastBattleClick"}}
			},
            _btnFight = {
                events = {{event = "touch", method = "_onFightClick"}}
            },
            _btnLook = {
                events = {{event = "touch", method = "_onBtnLookClick"}}
            }
		}
    }
    self:setName("PopupMineUser")
    PopupMineUser.super.ctor(self, resource)
end

function PopupMineUser:onCreate()
    -- i18n change lable
    self:_swapImageByI18n()
    -- i18n pos lable
    self:_dealPosByI18n()

    self._barArmy = MineBarNode.new(self._armyBar)
    self._barArmy:showIcon(true)
    --填充一下名字，战力等不会改变的东西
    local userData = self._mineData:getUserById(self._userId)
    if not userData then 
        self:closeWithAction()
        G_Prompt:showTip(Lang.get("mine_already_leave"))
        return
    end
    self._popBG:addCloseEventListener(handler(self, self.closeWithAction))
    self._popBG:setTitle(Lang.get("mine_target_info"))

    self._textUserName:setString(userData:getUser_name())
    local officerLevel = userData:getOfficer_level()
    self._textUserName:setColor(Colors.getOfficialColor(officerLevel))

    if userData:getGuild_id() == 0 then 
        self._textGuildName:setString(Lang.get("mine_user_no_guild"))
    else
        self._textGuildName:setString(userData:getGuild_name())
    end
    self._textGuildName:setColor(Colors.getMineGuildColor(2))

    local sameGuild = false
    local myGuildId = G_UserData:getGuild():getMyGuildId()
    if userData:getGuild_id() ~= 0 and myGuildId == userData:getGuild_id() then
        sameGuild = true
        self._textGuildName:setColor(Colors.getMineGuildColor(1))
    end
    self._textTip:setVisible(false)--i18n 合并矿战的碾压功能
    self._btnCancel:setVisible(not sameGuild)
    self._btnFight:setVisible(not sameGuild)
    self._textSameGuild:setVisible(sameGuild)

    local id = userData:getAvatar_base_id()
    local limit = require("app.utils.data.AvatarDataHelper").getAvatarConfig(id).limit == 1 and 3 
    local avatarId = require("app.utils.UserDataHelper").convertToBaseIdByAvatarBaseId(userData:getAvatar_base_id(), userData:getBase_id())
    self._heroAvatar:updateUI(avatarId, nil, nil, limit)
    self._textArmyValue:setString(TextHelper.getAmountText3(userData:getPower()))

    self._btnFight:setString(Lang.get("mine_fight"))
    self:_refreshBtnFastBattle()
end

function PopupMineUser:onEnter()
    self:_refreshInfo()
    -- self._signalEnterMine = G_SignalManager:add(SignalConst.EVENT_ENTER_MINE, handler(self, self._enterMine))
    self._signalBattleMine = G_SignalManager:add(SignalConst.EVENT_BATTLE_MINE, handler(self, self._onEventBattleMine))
    self._signalMineRespond = G_SignalManager:add(SignalConst.EVENT_GET_MINE_RESPOND, handler(self, self._onEventMineRespond))
    self._singalFastBattle = G_SignalManager:add(SignalConst.EVENT_FAST_BATTLE, handler(self, self._onFastBattle))
    self._signalBuyItem = G_SignalManager:add(SignalConst.EVENT_BUY_ITEM, handler(self, self._refreshBtnFastBattle))
end

function PopupMineUser:onExit()
    -- self._signalEnterMine:remove()
    -- self._signalEnterMine = nil
    if self._signalBattleMine then
        self._signalBattleMine:remove()
        self._signalBattleMine = nil
    end

    if self._signalMineRespond then 
        self._signalMineRespond:remove()
        self._signalMineRespond = nil
    end

    if self._singalFastBattle then
        self._singalFastBattle:remove()
        self._singalFastBattle = nil
    end

    if self._signalBuyItem then 
        self._signalBuyItem:remove()
        self._signalBuyItem = nil
    end
end

function PopupMineUser:_onFastBattleClick() 
    if self._mineConfig.is_battle == 0 then 
        G_Prompt:showTip(Lang.get("mine_cannont_fight"))
        return
    end
    local userData = self._mineData:getUserById(self._userId)
    if self._mineData:getId() ~= G_UserData:getMineCraftData():getSelfMineId() then      --不在自己区域
        G_Prompt:showTip(Lang.get("mine_diff_mine"))
        return    
    elseif not self._mineData:isUserInList(userData:getUser_id()) then            --该玩家已经不在本区域
        G_Prompt:showTip(Lang.get("mine_not_in_same_mine"))
        self:closeWithAction()
        return            
    end
    --i18n 合并矿战的碾压功能
    if self._sweepCount ~= PopupMineUser.SWEEP_INFINITE then
        local success = LogicCheckHelper.enoughValue(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_MINE_TOKEN, self._sweepCount)
        if not success then
            return  --令牌不足
        end
    else
        self._sweepCount = PopupMineUser.SWEEP_MAX
    end
    
    
    G_UserData:getMineCraftData():c2sBattleMineFast(self._userId, self._sweepCount)
end
--i18n 合并矿战的碾压功能
function PopupMineUser:_refreshBtnFastBattle()
    local strBtn = ""
    local tokenNum = UserDataHelper.getNumByTypeAndValue(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_MINE_TOKEN)
    if self:_isHighPower() then
        strBtn = Lang.get("mine_fast_battle", {count = PopupMineUser.SWEEP_MAX})
        self._sweepCount = PopupMineUser.SWEEP_INFINITE
    else
	    if tokenNum >= PopupMineUser.SWEEP_MAX or tokenNum == 0  then
	        strBtn = Lang.get("mine_fast_battle", {count = PopupMineUser.SWEEP_MAX})
	        self._sweepCount = PopupMineUser.SWEEP_MAX
	    else
	        strBtn = Lang.get("mine_fast_battle", {count = tokenNum})
	        self._sweepCount = tokenNum
	    end
    end
    
    self._btnCancel:setString(strBtn)

    local userData = self._mineData:getUserById(self._userId)
    if not userData then
        self._textTip:setString(Lang.get("mine_in_city")) --当前在主城，无法发起攻击
        self._textTip:setColor(Colors.SYSTEM_TARGET_RED)
		self._textTip:setVisible(true)
        self._btnCancel:setVisible(false)
        self._btnFight:setVisible(false)
        return
    end
    local sameGuild = false
    local myGuildId = G_UserData:getGuild():getMyGuildId()
    if userData:getGuild_id() ~= 0 and myGuildId == userData:getGuild_id() then
        sameGuild = true
        self._textGuildName:setColor(Colors.getMineGuildColor(1))
    end
    self:updatePowerTip()
    if sameGuild then
        self._textTip:setVisible(false)
    end
    self._btnCancel:setVisible(not sameGuild)
    self._btnFight:setVisible(not sameGuild)
    self._textSameGuild:setVisible(sameGuild)

end


--i18n 合并矿战的碾压功能
--战力不碾压才看官衔
function PopupMineUser:updatePowerTip()
    local userData = self._mineData:getUserById(self._userId)
    local enemyPower = userData:getPower()
    local myPower = G_UserData:getBase():getPower()
    
    local Parameter = require("app.config.parameter")
    local ParameterIDConst = require("app.const.ParameterIDConst")
    local powerGap = tonumber(Parameter.get(ParameterIDConst.POWER_GAP).content)

    if (myPower / enemyPower < powerGap / 1000) then
        --不如对手10%
        self._textTip:setVisible(true)
        self._textTip:setString(Lang.get("mine_power_low"))
        self._textTip:setColor(Colors.SYSTEM_TARGET_RED)
    elseif (myPower / enemyPower > 1000 / powerGap) then
        --超过对手10倍
        self._textTip:setVisible(true)
        self._textTip:setString(Lang.get("mine_power_high"))
        self._textTip:setColor(Colors.BRIGHT_BG_GREEN)
    else
        self._textTip:setVisible(false)
        self._textTip:setColor(Colors.SYSTEM_TARGET_RED)
    end

end
--i18n 合并矿战的碾压功能
--高于对手的10倍
function PopupMineUser:_isHighPower()
    local userData = self._mineData:getUserById(self._userId)
    if not userData then
        return false
    end

    local enemyPower = userData:getPower()
    local myPower = G_UserData:getBase():getPower()
    
    local Parameter = require("app.config.parameter")
    local ParameterIDConst = require("app.const.ParameterIDConst")
    local powerGap = tonumber(Parameter.get(ParameterIDConst.POWER_GAP).content)
    
    if (myPower / enemyPower < powerGap / 1000) then
        return false
    elseif (myPower / enemyPower > 1000 / powerGap) then
        return true
    end
    return false
end

function PopupMineUser:_onCancelClick()
    self:closeWithAction()
end

function PopupMineUser:_onFightClick()
    if self._mineConfig.is_battle == 0 then 
        G_Prompt:showTip(Lang.get("mine_cannont_fight"))
        return
    end
    local myGuildId = G_UserData:getGuild():getMyGuildId()
    local userData = self._mineData:getUserById(self._userId)
    -- if userData:getUser_id() == G_UserData:getBase():getId() then         --自己
    --     G_Prompt:showTip(Lang.get("mine_fight_self"))
    --     return
    -- elseif userData:getGuild_id() == myGuildId and myGuildId ~= 0 then      --自己工会
    --     G_Prompt:showTip(Lang.get("mine_fight_guild"))
    --     return
    if self._mineData:getId() ~= G_UserData:getMineCraftData():getSelfMineId() then      --不在自己区域
        G_Prompt:showTip(Lang.get("mine_diff_mine"))
        return    
    elseif not self._mineData:isUserInList(userData:getUser_id()) then            --该玩家已经不在本区域
        G_Prompt:showTip(Lang.get("mine_not_in_same_mine"))
        self:closeWithAction()
        return            
    end

    local success = LogicCheckHelper.enoughValue(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_MINE_TOKEN, 1)
    if not success then
        return  --令牌不足
    end

    G_UserData:getMineCraftData():c2sBattleMine(self._userId)
end

function PopupMineUser:_onEventMineRespond()
    self:_refreshInfo()
end

function PopupMineUser:_onFastBattle()
    self:_refreshBtnFastBattle()
    self:_refreshInfo()
    if G_UserData:getMineCraftData():getSelfMineId() ~= self._mineData:getId() then 
        self:closeWithAction()
    end
end

function PopupMineUser:_refreshInfo()
    local userData = self._mineData:getUserById(self._userId)
    if userData then
        self._barArmy:setPercent(userData:getArmy_value(), true, G_ServerTime:getLeftSeconds(userData:getPrivilege_time()) > 0)
    else 
        self:closeWithAction()
    end

    self:_refreshBtnFastBattle()--i18n 合并矿战的碾压功能
end

--攻击
function PopupMineUser:_onEventBattleMine(eventName, message)
    local myEndArmy = message.self_begin_army - message.self_red_army
    if myEndArmy <= 0 then 
        self:close()
        return
    end

    local enemyEndArmy = message.tar_begin_army - message.tar_red_army
    if enemyEndArmy <= 0 then 
        self:close()
        return
    end
end

function PopupMineUser:_onBtnLookClick()
    G_UserData:getBase():c2sGetUserDetailInfo(self._userId)
end


-- i18n change lable
function PopupMineUser:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local image1 = UIHelper.seekNodeByName(self,"ImageGuildBG","Image_20")
        local image2 = UIHelper.seekNodeByName(self,"ImageUserBG","Image_20")
        local image3 = UIHelper.seekNodeByName(self,"ImageArmyBG","Image_20")

		local label1 = UIHelper.swapWithLabel(image1,{
			 style = "mine_4",
			 text = Lang.getImgText("txt_mine_juntuan01") ,
		})

        local label2 = UIHelper.swapWithLabel(image2,{
			 style = "mine_4",
			 text = Lang.getImgText("txt_mine_wanjia01") ,
		})

        local label3 = UIHelper.swapWithLabel(image3,{
			 style = "mine_4",
			 text = Lang.getImgText("txt_mine_zhanli01") ,
        })
        
        label1:setAnchorPoint(cc.p(1,0.5))
        label2:setAnchorPoint(cc.p(1,0.5))
        label3:setAnchorPoint(cc.p(1,0.5))
        label1:setPositionX(self._textUserName:getPositionX()-8)
        label2:setPositionX(self._textGuildName:getPositionX()-8)
        label3:setPositionX(self._textArmyValue:getPositionX()-8)
	end
end


-- i18n pos lable
function PopupMineUser:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        self._textGuildName:setFontSize(self._textGuildName:getFontSize()-2)
	end
	
	--i18n 合并矿战的碾压功能
	self._textTip = self._textSameGuild:clone()
	local parent = self._textSameGuild:getParent()
    parent:addChild(self._textTip)
    self._textTip:setFontSize(20)
    self._textTip:setPositionY(126)
    if Lang.checkLang(Lang.EN) or Lang.checkLang(Lang.TH) then
        self._textTip:setPositionY(136)
        self._textTip:getVirtualRenderer():setMaxLineWidth(550)
        self._textTip:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
        if Lang.checkLang(Lang.TH) then
            self._textTip:getVirtualRenderer():setLineSpacing(4)
        elseif Lang.checkLang(Lang.EN) then
            self._textTip:getVirtualRenderer():setLineSpacing(-3)
        end
        self._armyBar:setPositionY(self._armyBar:getPositionY()+25)
    end
end





return PopupMineUser

