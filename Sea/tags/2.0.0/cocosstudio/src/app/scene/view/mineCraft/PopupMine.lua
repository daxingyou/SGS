local PopupBase = require("app.ui.PopupBase")
local PopupMine = class("PopupMine", PopupBase)

local PopupMineNode = require("app.scene.view.mineCraft.PopupMineNode")
local MineCraftHelper = require("app.scene.view.mineCraft.MineCraftHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local DataConst = require("app.const.DataConst")
local Parameter = require("app.config.parameter")
local ParameterIDConst = require("app.const.ParameterIDConst")
local LogicCheckHelper = require("app.utils.LogicCheckHelper")
local UserDataHelper = require("app.utils.UserDataHelper")

PopupMine.MINE_FIX = 0     --每个矿的基准x坐标0点
PopupMine.MINE_SPACE = 220
PopupMine.POS_LINE_Y = 
{
    400, 260, 120
}
PopupMine.MINE_COUNT_LINE = 3       --每行3个

function PopupMine:waitEnterMsg(callBack, mineId)
	local function onMsgCallBack(id, message)
		callBack()
    end

    local configData = G_UserData:getMineCraftData():getMineConfigById(mineId)
    if not G_UserData:getMineCraftData():isMineHasUser(mineId) or configData.pit_type == 2 then
        G_UserData:getMineCraftData():c2sEnterMine(mineId)
        local signal = G_SignalManager:add(SignalConst.EVENT_ENTER_MINE, onMsgCallBack)
        return signal
    else 
        callBack()
    end
end

function PopupMine:ctor(data)
	self._data = data
    self._config = data:getConfigData()
    self._page = nil
    
    self._mineUsers = {}
    self._signalEnterMine = nil
    self._signalSettleMine = nil
    self._signalBattleMine = nil
    self._signalGetMineWorld = nil
    self._signalMineRespond = nil
    self._singalFastBattle = nil

    self._foodCost = 0
    self._labelState = nil -- i18n change lable
    -- self._isFirstEnter = true


	local resource = {
		file = Path.getCSB("PopupMine", "mineCraft"),
		binding = {
			_btnPagePrev = {
				events = {{event = "touch", method = "_onPagePrevClick"}}
			},
            _btnPageNext = {
                events = {{event = "touch", method = "_onPageNextClick"}}
            },
            _btnMoveIn = {
                events = {{event = "touch", method = "_onBtnMoveInClick"}}
            },
		}
    }
    self:setName("PopupMine")
	PopupMine.super.ctor(self, resource)
end

function PopupMine:onCreate()
    
-- i18n pos lable
    self:_dealPosByI18n()
    self._popBG:addCloseEventListener(handler(self,self.closeWithAction))
    self._popBG:setTitle(self._config.pit_name)

    -- i18n change lable
    self:_createLabelByI18n()

    local background = Path.getBackground(self._config.pit_bg)
    self._imageBG:loadTexture(background)

    self:_createMineNode()
    self._btnMoveIn:setString(Lang.get("mine_move_in"))

    for i = 1, 3 do 
        self["_imageInfo"..i]:setLocalZOrder(1)
    end

    if self._config.pit_type == MineCraftHelper.TYPE_MAIN_CITY then
        self._imageOutput:setVisible(false)
    end

    self._imageState:ignoreContentAdaptWithSize(true)
end

function PopupMine:onEnter()
    self._signalEnterMine = G_SignalManager:add(SignalConst.EVENT_ENTER_MINE, handler(self, self._enterMine))
    self._signalSettleMine = G_SignalManager:add(SignalConst.EVENT_SETTLE_MINE, handler(self, self._settleMine))
    self._signalBattleMine = G_SignalManager:add(SignalConst.EVENT_BATTLE_MINE, handler(self, self._onEventBattleMine))
    self._signalGetMineWorld = G_SignalManager:add(SignalConst.EVENT_GET_MINE_WORLD, handler(self, self._onEventGetMineWorld))
    self._signalMineRespond = G_SignalManager:add(SignalConst.EVENT_GET_MINE_RESPOND, handler(self, self._onEventMineRespond))
    self._singalFastBattle = G_SignalManager:add(SignalConst.EVENT_FAST_BATTLE, handler(self, self._onFastBattle))
    --self._signalUseItemMsg = G_SignalManager:add(SignalConst.EVNET_USE_ITEM_SUCCESS, handler(self, self._onEventUseItem)) -- 刷新粮草令
    local showPage = self:_getMyPage() or 1
    self:_refreshUserPage(showPage)
    self:_refreshData()
    self:_refreshRoadCost()

    if self._data:getMultiple() > 1 then 
        local doubleId = self._data:getMultiple()
        local pic = Path.getMineDoubleImg(doubleId-1)
        self._imageDouble:setVisible(true)
        self._imageDouble:loadTexture(pic)
    else 
        self._imageDouble:setVisible(false)
    end
end

function PopupMine:onExit()
    self._signalEnterMine:remove()
    self._signalEnterMine = nil	
    self._signalSettleMine:remove()
    self._signalSettleMine = nil
    self._signalBattleMine:remove()
    self._signalBattleMine = nil
    self._signalGetMineWorld:remove()
    self._signalGetMineWorld = nil
    self._signalMineRespond:remove()
    self._signalMineRespond = nil
    self._singalFastBattle:remove()
    self._singalFastBattle = nil
    --self._signalUseItemMsg:remove()
    --self._signalUseItemMsg = nil
end

function PopupMine:_onPagePrevClick()
    self._page = self._page - 1
    self:_refreshUserPage()
end

function PopupMine:_onPageNextClick()
    self._page = self._page + 1
    self:_refreshUserPage()
end

function PopupMine:_getBuyString()
    local maxValue = tonumber(require("app.config.parameter").get(G_ParameterIDConst.TROOP_MAX).content)
    if G_UserData:getMineCraftData():isSelfPrivilege() then
        local soilderAdd  = MineCraftHelper.getParameterContent(G_ParameterIDConst.MINE_CRAFT_SOILDERADD)
        maxValue = (maxValue + soilderAdd)
    end
    local str = ""
    local food, money, needFood = MineCraftHelper.getBuyArmyDetail()
    if food and money then 
        str = Lang.get("mine_not_50_army", {count1 = food, count2 = money, count3 = maxValue})
    elseif food then 
        str = Lang.get("mine_not_50_army_food", {count = food, count1 = maxValue})
    elseif money then 
        str = Lang.get("mine_not_50_army_gold", {count = money, count1 = maxValue})
    end
    return str, money, needFood
end

function PopupMine:_buyArmy(count, money)
    if money then
        local success = LogicCheckHelper.enoughValue(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_DIAMOND, money)
        if not success then
            return 
        end
    end
    G_UserData:getMineCraftData():c2sMineBuyArmy(count)    
end

function PopupMine:_onBtnClose()
    self:closeWithAction()
end

function PopupMine:_onBtnMoveInClick()
    local selfMineId = G_UserData:getMineCraftData():getSelfMineId()
    if myMineId == self._data:getId() then  --已经在这个矿里面了
        G_Prompt:showTip(Lang.get("mine_already_in"))
        return
    end

    local myArmy = G_UserData:getMineCraftData():getMyArmyValue()
    --兵力不足，且在主城
    if myArmy < MineCraftHelper.ARMY_TO_LEAVE and G_UserData:getMineCraftData():getMyMineConfig().pit_type == MineCraftHelper.TYPE_MAIN_CITY then 
        local strBuy, money, needFood = self:_getBuyString()
        local popupSystemAlert = require("app.ui.PopupSystemAlert").new(Lang.get("mine_not_army_title"), strBuy, function ()
            self:_buyArmy(needFood, money)
        end)
        popupSystemAlert:setCheckBoxVisible(false)
        popupSystemAlert:openWithAction()
        return
    end

    --缺粮草
    local nowFood = UserDataHelper.getNumByTypeAndValue(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_ARMY_FOOD)
    if nowFood < self._foodCost then 
        local title = Lang.get("mine_no_food")
        local goldToFood = tonumber(require("app.config.parameter").get(ParameterIDConst.MINE_GOLD_TO_FOOD).content)
        self._moveGold = goldToFood * (self._foodCost - nowFood)
        local strContent = Lang.get("mine_run_gold", {count = self._foodCost - nowFood, countmoney = self._moveGold})
        local popupSystemAlert = require("app.ui.PopupSystemAlert").new(title, strContent, handler(self, self._moveInGold))
        popupSystemAlert:setCheckBoxVisible()
        popupSystemAlert:openWithAction()

        --[[local itemValue = DataConst.getItemIdByResId(DataConst.RES_ARMY_FOOD)--取出资源对应的道具类型
        local popup = require("app.ui.PopupItemBuyUse").new()
		popup:updateUI(TypeConvertHelper.TYPE_ITEM, itemValue)
		popup:openWithAction()]]
    else
        G_UserData:getMineCraftData():c2sSettleMine(self._moveRoads)
        self:closeWithAction()
    end
end

function PopupMine:_moveInGold()
    local success = LogicCheckHelper.enoughValue(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_DIAMOND, self._moveGold)
    if not success then
        return 
    end
    G_UserData:getMineCraftData():c2sSettleMine(self._moveRoads)
    self:closeWithAction()
end

function PopupMine:_createMineNode()
    for i = 1, #PopupMine.POS_LINE_Y do 
        for j = 1, PopupMine.MINE_COUNT_LINE do 
            local popupMineNode = PopupMineNode.new(self._data)
            self._nodeBase:addChild(popupMineNode)
            local posX = self._config["position_x_"..i] + PopupMine.MINE_FIX + PopupMine.MINE_SPACE*(j-1)
            local posY = PopupMine.POS_LINE_Y[i]
            popupMineNode:setPosition(cc.p(posX, posY))
            table.insert(self._mineUsers, popupMineNode)
        end
    end
end

function PopupMine:_refreshUserPage(page)
    if page then
        self._page = page 
    end
    local totalPageCount = self:_getTotalPage()
    if self._page > totalPageCount then 
        self._page = totalPageCount
    end
    local beginCount, pageUserCount = self:_getPageBegin(self._page)
    local mineCount = 1
    local userList = self._data:getUsers()
    for i = beginCount, beginCount+pageUserCount-1 do 
        local user = userList[i]
        self._mineUsers[mineCount]:refreshUserData(user)
        mineCount = mineCount + 1
    end

    self._btnPagePrev:setVisible(true)
    self._btnPageNext:setVisible(true)
    if self._page == 1 then 
        self._btnPagePrev:setVisible(false)
    end
    if self._page == totalPageCount then 
        self._btnPageNext:setVisible(false)
    end

    self._textPageNum:setString(self._page.."/"..totalPageCount)
end

function PopupMine:_getTotalPage()
    local pageUserCount = PopupMine.MINE_COUNT_LINE * #PopupMine.POS_LINE_Y
    local totalPageCount = math.ceil(#self._data:getUsers() / pageUserCount)
    if totalPageCount == 0 then 
        totalPageCount = 1
    end
    return totalPageCount
end

function PopupMine:_getMyPage()
    -- local userList = self._data:getUsers()
    -- for pos = 1, #userList do 
    --     if userList[pos]:getUser_id() == G_UserData:getBase():getId() then 
    --         return pos
    --     end
    -- end
    return 1 --我永远排在第一个
end

function PopupMine:_getPageBegin(pageCount)
    local pageUserCount = PopupMine.MINE_COUNT_LINE * #PopupMine.POS_LINE_Y
    return (pageCount - 1) * pageUserCount + 1, pageUserCount
end

function PopupMine:_enterMine()
    self:_refreshUserPage()
    self:_refreshData()
end

function PopupMine:_settleMine()
    G_Prompt:showTip(Lang.get("mine_food_cost_count", {count = self._foodCost}))
end

function PopupMine:_refreshData()

    for i = 1, 3 do 
        self["_imageInfo"..i]:setVisible(false)
    end
    local change, add, onlyAdd, minus, outputDay, strOutputDay, des = MineCraftHelper.getOutputDetail(self._data:getId())
    self._resourceOutput:setTextCountSize(MineCraftHelper.RESOURCE_FONT_SIZE)
    self._resourceOutput:updateUI(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_DIAMOND, strOutputDay)
    self._resourceOutput:setTextColor(Colors.getMineStateColor(1))

    self:_refreshGuildState()
    self:_updateMineInfo(add, onlyAdd, minus, des)
    self:_updateStateNode(change)
    self:_updateMineState(change)


    if self._config.pit_type == MineCraftHelper.TYPE_MAIN_CITY then
        self._imageInfo1:setVisible(true)
        self._imageInfo2:setVisible(false)
        self._imageInfo3:setVisible(false)
        self._textInfo1:setString(Lang.get("mine_no_output"))
        self._textInfo1:setColor(Colors.getMineInfoColor(1))
    end
end

function PopupMine:_refreshGuildState()
    local myGuildId = G_UserData:getGuild():getMyGuildId()
    local guildId = self._data:getGuildId()
    if guildId ~= 0 then 
        self._textGuildName:setString(self._data:getGuildName())
        if myGuildId ~= guildId then 
            self._textGuildName:setColor(Colors.getMineGuildColor(2))
        else
            self._textGuildName:setColor(Colors.getMineGuildColor(1))
        end
    else
        self._textGuildName:setColor(Colors.getMineGuildColor(1))
        self._textGuildName:setString(Lang.get("mine_no_guild"))
    end

 	if  Lang.checkLang(Lang.CN) then
	    if self._data:isOwn() then 
	        self._imageState:setVisible(true)
	        self._imageState:loadTexture(Path.getMineNodeTxt("img_mine_occupy02"))
	    elseif self._data:getGuildId() ~= 0 then 
	        self._imageState:setVisible(true)
	        self._imageState:loadTexture(Path.getMineNodeTxt("img_mine_occupy01"))
	    else
	        self._imageState:setVisible(false)
	    end
		local iconX = self._textGuildName:getPositionX() - self._textGuildName:getContentSize().width/2 - 10
    	self._imageState:setPositionX(iconX)
    else
		if self._data:isOwn() then 
            self._imageState:setVisible(true)
            self._imageState:loadTexture(Path.getMineNodeTxt("img_mine_occupy02"))
            self._labelState:setVisible(false)
        elseif self._data:getGuildId() ~= 0 then 
                self._imageState:setVisible(false)
                self._labelState:setVisible(true)
                self._labelState:setString(Lang.getImgText("img_mine_occupy01"))
            else
                self._imageState:setVisible(false)
                self._labelState:setVisible(false)
            end
            local iconX = self._textGuildName:getPositionX() - self._textGuildName:getContentSize().width/2 - 10
            self._imageState:setPositionX(iconX)
            self._labelState:setPositionX(iconX)
	    end

end

function PopupMine:_updateMineInfo(add, addOnly, minus, des)
    for i = 1, 3 do 
        self["_imageInfo"..i]:setVisible(true)
    end
    if not self._data:isMyGuildMine() then 
        add = 0
        addOnly = 0
    end
    local titleIndex = 1
    if add == 0 then 
        local parameterContent = Parameter.get(ParameterIDConst.MINE_OUTPUT_ADD)
        assert(parameterContent, "not id, "..ParameterIDConst.MINE_OUTPUT_ADD)
        local showAdd = (tonumber(parameterContent.content)) / 10
        self._textInfo1:setString(Lang.get("mine_guild_state_show", {count = showAdd}))
        self._textInfo1:setColor(Colors.getMineInfoColor(4))
    else 
        self._textInfo1:setString(Lang.get("mine_same_guild", {count = add}))
        self._textInfo1:setColor(Colors.getMineInfoColor(1))
    end

    if addOnly == 0 then 
        local parameterContent = Parameter.get(ParameterIDConst.MINE_ONLY_GUILD)
        assert(parameterContent, "not id, "..ParameterIDConst.MINE_ONLY_GUILD)
        local showAdd = (tonumber(parameterContent.content)) / 10
        self._textInfo2:setString(Lang.get("mine_own_state_show", {count = showAdd}))
        self._textInfo2:setColor(Colors.getMineInfoColor(4))
    else 
        self._textInfo2:setString(Lang.get("mine_only_guild", {count = addOnly}))
        self._textInfo2:setColor(Colors.getMineInfoColor(1))
    end

    self._imageInfo3:setVisible(false)
    if minus ~= 0 then    
        self._textInfo3:setString(Lang.get("mine_state", {state = des, count = minus}))
        self._textInfo3:setColor(Colors.getMineInfoColor(3))
        self._imageInfo3:setVisible(true)
    end
end

function PopupMine:_updateStateNode(finalCount)
    if not self._data:isMyGuildMine() then
        self._nodeOutput:setVisible(false)
        return
    end
    -- i18n change punc
    if not Lang.checkLang(Lang.CN) then
        self._textOutputState:setString("("..finalCount.."%")
        self._textOutputState2:setString(")")
    else
        self._textOutputState:setString("（"..finalCount.."%   ）")
    end
    local posX = self._resourceOutput:getPositionX() + self._resourceOutput:getContentWidth()
    self._nodeOutput:setPositionX(posX)
    self._imageDown:setVisible(false)
    self._imageUp:setVisible(false)
    if finalCount < 0 then 
        self._nodeOutput:setVisible(true)
        self._imageDown:setVisible(true)
        
    	if not Lang.checkLang(Lang.CN) then
            local UIHelper  = require("yoka.utils.UIHelper")
            self._imageDown:setAnchorPoint(cc.p(0.5,0.5))
            UIHelper.alignRight({self._textOutputState,self._imageDown,self._textOutputState2},nil,{nil,25,nil})
            self._textOutputState2:setColor(Colors.getMineInfoColor(3))
        else
            self._imageDown:setPositionX(self._textOutputState:getPositionX())
        end
        self._textOutputState:setColor(Colors.getMineInfoColor(3))
    elseif finalCount > 0 then 
        self._nodeOutput:setVisible(true)
        self._imageUp:setVisible(true)
        
 		if not Lang.checkLang(Lang.CN) then
            local UIHelper  = require("yoka.utils.UIHelper")
            self._imageUp:setAnchorPoint(cc.p(0.5,0.5))
            UIHelper.alignRight({self._textOutputState,self._imageUp,self._textOutputState2},nil,{nil,25,nil})
            self._textOutputState2:setColor(Colors.getMineInfoColor(1))
        else
            self._imageUp:setPositionX(self._textOutputState:getPositionX())
        end
        self._textOutputState:setColor(Colors.getMineInfoColor(1))
    else
        self._nodeOutput:setVisible(false)
    end
end

function PopupMine:_updateMineState(finalCount)
    -- i18n change punc
    if not Lang.checkLang(Lang.CN) then
        self._textMineOutputState:setString("("..finalCount.."%")
        self._textMineOutputState2:setString(")")
    else
        self._textMineOutputState:setString("（"..finalCount.."%   ）")
    end
    local posX = self._textGuildName:getPositionX() + self._textGuildName:getContentSize().width/2
    self._nodeMineOutput:setPositionX(posX)
    self._imageMineDown:setVisible(false)
    self._imageMineUp:setVisible(false)
    if finalCount < 0 then 
        self._nodeMineOutput:setVisible(true)
        self._imageMineDown:setVisible(true)
        
       if not Lang.checkLang(Lang.CN) then
            local UIHelper  = require("yoka.utils.UIHelper")
            self._imageMineDown:setAnchorPoint(cc.p(0.5,0.5))
            UIHelper.alignRight({self._textMineOutputState,self._imageMineDown,self._textMineOutputState2},nil,{nil,13,nil})
            self._textMineOutputState2:setColor(Colors.getMineInfoColor(3))
        else
            self._imageMineDown:setPositionX(self._textMineOutputState:getPositionX())
        end        
        self._textMineOutputState:setColor(Colors.getMineInfoColor(3))
    elseif finalCount > 0 then 
        self._nodeMineOutput:setVisible(true)
        self._imageMineUp:setVisible(true)
       
      	if not Lang.checkLang(Lang.CN) then
            local UIHelper  = require("yoka.utils.UIHelper")
            self._imageMineUp:setAnchorPoint(cc.p(0.5,0.5))
            UIHelper.alignRight({self._textMineOutputState,self._imageMineUp,self._textMineOutputState2},nil,{nil,13,nil})
            self._textMineOutputState2:setColor(Colors.getMineInfoColor(1))
        else
            self._imageMineUp:setPositionX(self._textMineOutputState:getPositionX())
        end        
        self._textMineOutputState:setColor(Colors.getMineInfoColor(1))
    else
        self._nodeMineOutput:setVisible(false)
    end
end

function PopupMine:_refreshRoadCost()
    local selfMineId = G_UserData:getMineCraftData():getSelfMineId()
    if self._data:getId() == selfMineId then 
        self._moveResource:updateUI( TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_ARMY_FOOD,  0)
        self._moveResource:setTextColor(Colors.getMineStateColor(1))
        self._btnMoveIn:setEnabled(false)
        return
    end
    self._moveRoads = MineCraftHelper.getRoad(selfMineId, self._data:getId())
    local parameterContent = Parameter.get(ParameterIDConst.FOOD_PER_MOVE)
    assert(parameterContent, "not id, "..ParameterIDConst.FOOD_PER_MOVE)
    self._foodCost = #self._moveRoads*tonumber(parameterContent.content)
    -- self._moveResource:setTextColorToDTypeColor()
    self._moveResource:updateUI( TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_ARMY_FOOD,  self._foodCost)
    local myFood =  UserDataHelper.getNumByTypeAndValue(TypeConvertHelper.TYPE_RESOURCE, DataConst.RES_ARMY_FOOD)
    if myFood < self._foodCost then
        self._moveResource:setTextColor(Colors.getMineStateColor(3))
    else
        self._moveResource:setTextColor(Colors.getMineStateColor(1))
    end
    -- self._moveResource:showResName(true, Lang.get("mine_cost_food"))
end

--攻击
function PopupMine:_onEventBattleMine(eventName, message)
    local myEndArmy = message.self_begin_army - message.self_red_army
    if myEndArmy <= 0 then 
        self:close()
    end
end

function PopupMine:_onEventGetMineWorld()
    self:_refreshData()
end

function PopupMine:_onEventMineRespond(eventName, oldMineId, newMineId)
    -- if newMineId and newMineId == self._data:getId() then 
    --     G_UserData:getMineCraftData():c2sEnterMine(self._data:getId())
    -- elseif oldMineId == self._data:getId() then
    --     self:_refreshUserPage()
    --     self:_refreshData()
    -- end

    if oldMineId == self._data:getId() or newMineId == self._data:getId() then
        self:_refreshUserPage()
        self:_refreshData()
    end
end

function PopupMine:_onFastBattle()
    if G_UserData:getMineCraftData():getSelfMineId() ~= self._data:getId() then 
        self:closeWithAction()
    end
end

--[[function PopupMine:_onEventUseItem()
    self:_refreshRoadCost()
end]]

-- i18n change lable
function PopupMine:_createLabelByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        local x,y = self._imageState:getPosition()
        local anchorPoint = self._imageState:getAnchorPoint()
		self._labelState = UIHelper.createLabel({
			 style = "mine_1",
             position =cc.p(x,y) ,
             anchorPoint = anchorPoint,
		})
        self._imageState:getParent():addChild(self._labelState)


        local instNode = self._textMineOutputState:clone()
        instNode:setName("_textMineOutputState2")
        self._textMineOutputState2 = instNode
        self._textMineOutputState:getParent():addChild(self._textMineOutputState2)


        local instNode = self._textOutputState:clone()
        instNode:setName("_textMineOutputState2")
        self._textOutputState2 = instNode
        self._textOutputState:getParent():addChild(self._textOutputState2)

	end
end

-- i18n pos lable
function PopupMine:_dealPosByI18n()
    if not Lang.checkLang(Lang.CN) then
        local UIHelper = require("yoka.utils.UIHelper")
        local text1 = UIHelper.seekNodeByName(self._imageOutput,"Text_4")
        
		self._resourceOutput:setPositionX(text1:getPositionX()+text1:getContentSize().width+6)

        self._textInfo1:setFontSize(self._textInfo1:getFontSize()-2)
        self._textInfo2:setFontSize(self._textInfo2:getFontSize()-2)
        self._textInfo3:setFontSize(self._textInfo3:getFontSize()-2)

        self._imageDouble:setPositionY(self._imageDouble:getPositionY()+20)
    end
    if Lang.checkLang(Lang.EN) then
        local posX = self._imageOutput:getPositionX()
        self._imageInfo1:setAnchorPoint(0,0.5)
        self._imageInfo1:setPositionX(posX)
        self._imageInfo2:setAnchorPoint(0,0.5)
        self._imageInfo2:setPositionX(posX)
        self._imageInfo3:setAnchorPoint(0,0.5)
        self._imageInfo3:setPositionX(posX)
        self._imageInfo1:setContentSize(cc.size(350,25))
        self._imageInfo2:setContentSize(cc.size(350,25))
        self._imageInfo3:setContentSize(cc.size(350,25))
    end
end





return PopupMine

