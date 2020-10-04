-- @Author panhoa
-- @Date 8.29.2018
-- @Role 

local PopupBase = require("app.ui.PopupBase")
local PopupMineCraftPrivilege = class("PopupMineCraftPrivilege", PopupBase)
local ParameterIDConst = require("app.const.ParameterIDConst")
local MineCraftHelper = require("app.scene.view.mineCraft.MineCraftHelper")


function PopupMineCraftPrivilege:ctor()
    --
    self._nodeToken = nil
    self._nodeHurt  = nil
    self._nodeDefense= nil
    self._nodeSilder = nil
    self._nodeActivedLast3 = nil
    self._imageSigned = nil
    self._imageVip5 = nil

	local resource = {
		file = Path.getCSB("PopupMineCraftPrivilege", "mineCraft"),
		binding = {
			_btnClose = {
				events = {{event = "touch", method = "_onBtnClose"}}
            },
            _fileNodeBtn = {
				events = {{event = "touch", method = "_onBtnGet"}}
			},
		}
	}
	PopupMineCraftPrivilege.super.ctor(self, resource, false, false)
end

function PopupMineCraftPrivilege:onCreate()
    if not Lang.checkLang(Lang.CN) then
        self:_swapImageByI18n()
    end

    self:_initDesc()
    self:_updateBtnDesc()
    -- 处理界面位置偏移问题
    self:_dealPosByI18n()
end

function PopupMineCraftPrivilege:onEnter()
    self._signalRechargeGetInfo = G_SignalManager:add(SignalConst.EVENT_RECHARGE_GET_INFO, handler(self, self._onEventRechargeGetInfo))     -- 购买
    self._signalWelfareMonthCardGetReward = G_SignalManager:add(SignalConst.EVENT_WELFARE_MONTH_CARD_GET_REWARD, handler(self, self._onEventWelfareMonthCardGetReward)) -- 领奖
end

function PopupMineCraftPrivilege:onExit()
    self._signalRechargeGetInfo:remove()
    self._signalRechargeGetInfo = nil
    
    self._signalWelfareMonthCardGetReward:remove()
	self._signalWelfareMonthCardGetReward = nil
end

function PopupMineCraftPrivilege:_updateBtnDesc( ... )
    local payCfg = MineCraftHelper.getPrivilegeVipCfg()
    local vipLimit  = payCfg.vip_show
    local vipLevel = G_UserData:getVip():getLevel() or 0
    local bVisible= (vipLimit > vipLevel)
    
    self._imageVip5:setVisible(bVisible)
    self._fileNodeBtn:setVisible(not bVisible)
    self._fileNodeBtn:setString("")
    self._imageSigned:setVisible(false)
    if bVisible then
        self:_updateLast(1)
        self:_updateToken(7)
        return
    end

    local cardData = G_UserData:getActivityMonthCard():getMonthCardDataById(payCfg.id)
    if cardData then
        local bReceive = cardData:isCanReceive()
        local remainDay = cardData:getRemainDay()
        local lastDay = payCfg.renew_day
        if remainDay > 0 and remainDay <= lastDay then
            self:_updateLast(3, bReceive, remainDay)
            self:_updateToken(remainDay)
        elseif remainDay > lastDay then
            self:_updateLast(2, bReceive, remainDay)
            self:_updateToken(remainDay)
        else
            self:_updateLast(1)
            self:_updateToken(7)
        end
    else
        if G_UserData:getMineCraftData():isSelfPrivilege() then
            self:_updateLast(3, false, 1)
            self:_updateToken(7)
        else
            self:_updateLast(1)
            self:_updateToken(7)
        end
    end
end

function PopupMineCraftPrivilege:_initDesc()
    local atkSelfHurt  = MineCraftHelper.getParameterContent(G_ParameterIDConst.MINE_CRAFT_ATKSELF_LOSS)
    local atkOtherHurt = MineCraftHelper.getParameterContent(G_ParameterIDConst.MINE_CRAFT_ATKENEMY_LOSS)
    local defselfHurt  = MineCraftHelper.getParameterContent(G_ParameterIDConst.MINE_CRAFT_DEFENSESELF_LOSS)
    local defOtherHurt = MineCraftHelper.getParameterContent(G_ParameterIDConst.MINE_CRAFT_DEFENSEENEMY_LOSS)
    local soilderAdd   = MineCraftHelper.getParameterContent(G_ParameterIDConst.MINE_CRAFT_SOILDERADD)

    self:_updateHurt(atkSelfHurt, atkOtherHurt)
    self:_updateDefense(defselfHurt, defOtherHurt)
    self:_updateSoilder(soilderAdd)
end

function PopupMineCraftPrivilege:_updateToken(days)
    self._nodeToken:removeAllChildren()
    local richText = ccui.RichText:createRichTextByFormatString(
		Lang.get("mine_craft_privilege_token", {num1 = 2, num2 = days}),
        {defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={[1] = {fontSize = 21}, [2] = {fontSize = 21}, [3] = {fontSize = 21}
    }})

    if not Lang.checkLang(Lang.CN) then
        richText:ignoreContentAdaptWithSize(false)
        richText:setContentSize(cc.size(390, 0))
        richText:setAnchorPoint(cc.p(0, 1))

        local UIHelper = require("yoka.utils.UIHelper")
        local image67 = UIHelper.seekNodeByName(self,"Panel_13","Image_67")
        local image68 = UIHelper.seekNodeByName(self,"Panel_13","Image_68")
        local image69 = UIHelper.seekNodeByName(self,"Panel_13","Image_69")
        local image70 = UIHelper.seekNodeByName(self,"Panel_13","Image_70")
        self._nodeToken:setPositionY(image67:getContentSize().height-4)
        richText:formatText()
        local offsetY = math.max(richText:getContentSize().height-image67:getContentSize().height+4,0)
        image68:setPositionY(image67:getPositionY() -  offsetY -  37  )
        image69:setPositionY(image67:getPositionY() -  offsetY -  37 * 2)
        image70:setPositionY(image67:getPositionY() -  offsetY-  37 * 3)
       
    else
        richText:setAnchorPoint(cc.p(0, 0.5))
    end
   
    
 
    
    
    self._nodeToken:addChild(richText)
end

function PopupMineCraftPrivilege:_updateHurt(selfHurt, otherHurt)
    -- body
    self._nodeHurt:removeAllChildren()
    local richText = ccui.RichText:createRichTextByFormatString(
		Lang.get("mine_craft_privilege_hurt", {num1 = selfHurt, num2 = otherHurt}),
        {defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={[1] = {fontSize = 21}, [2] = {fontSize = 21}
    }})

    richText:setAnchorPoint(cc.p(0, 0.5))
    self._nodeHurt:addChild(richText)
end

function PopupMineCraftPrivilege:_updateDefense(selfHurt, otherHurt)
    -- body
    self._nodeDefense:removeAllChildren()
    local richText = ccui.RichText:createRichTextByFormatString(
		Lang.get("mine_craft_privilege_defense", {num1 = selfHurt, num2 = otherHurt}),
        {defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={[1] = {fontSize = 21}, [2] = {fontSize = 21}
    }})

    richText:setAnchorPoint(cc.p(0, 0.5))
    self._nodeDefense:addChild(richText)
end

function PopupMineCraftPrivilege:_updateSoilder(soilders)
    -- body
    self._nodeSilder:removeAllChildren()
    local richText = ccui.RichText:createRichTextByFormatString(
		Lang.get("mine_craft_privilege_soilder", {num = soilders}),
        {defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={[1] = {fontSize = 21}
    }})

    richText:setAnchorPoint(cc.p(0, 0.5))
    self._nodeSilder:addChild(richText)
end

function PopupMineCraftPrivilege:_updateLast(state, canReceive, days)
    local function getRewards( ... )
        -- body
        local redImg = self._fileNodeBtn:getChildByName("privilege_card")
        if not redImg then
            local UIHelper  = require("yoka.utils.UIHelper")
            redImg = UIHelper.createImage({texture = Path.getCraftPrivilege("img_04")})
            redImg:setName("privilege_card")
            redImg:setPosition(20, 0)
            self._fileNodeBtn:addChild(redImg)
        end
        return redImg
    end

    self._nodeActivedLast3:removeAllChildren()
    local payCfg = MineCraftHelper.getPrivilegeVipCfg()
    local richText = {}
    if state == 1 then              -- 1. 未购买
        local payCfg = MineCraftHelper.getPrivilegeVipCfg()
        local content = Lang.get("mine_craft_privilege_activelast", {
            money = payCfg.gold,
            urlIcon = Path.getResourceMiniIcon("1"),
			count = 7,
		})
        richText = ccui.RichText:createWithContent(content)

        local cfg = MineCraftHelper.getPrivilegeVipCfg()
        self._fileNodeBtn:switchToNormal()
        self._fileNodeText:setString("")
        if Lang.checkLang(Lang.TW) or Lang.checkChannel(Lang.CHANNEL_SEA) then
            local UIHelper  = require("yoka.utils.UIHelper")
            local _,currency = UIHelper.convertDollar(cfg.rmb)
            self._fileNodeBtn:setString(Lang.get("mine_craft_privilege_money", {money = tostring(currency)}))
        else
            self._fileNodeBtn:setString(Lang.get("mine_craft_privilege_money", {money = tostring(cfg.rmb)}))
        end

        if not Lang.checkLang(Lang.CN) then
            self._i8RichText:setVisible(false)
        end
    elseif state == 2 then          -- 2. 已购买未倒计时
        richText = ccui.RichText:createRichTextByFormatString(
            Lang.get("mine_craft_privilege_lastday", {num = days}),
            {defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={[1] = {fontSize = 21}
        }})

        local img = getRewards()
        if canReceive then
            self._fileNodeBtn:switchToHightLight()
            self._fileNodeText:setColor(Colors.BUTTON_ONE_NORMAL)
            self._fileNodeText:enableOutline(Colors.BUTTON_ONE_NORMAL_OUTLINE, 2)   
            img:setVisible(true)
        else
            self._fileNodeBtn:switchToNormal()
            img:setVisible(false)
        end
        self._imageSigned:setVisible(not canReceive)
        self._fileNodeBtn:setVisible(canReceive)
        self._fileNodeBtn:setString("")
        self._fileNodeText:setString(Lang.get("mine_craft_privilege_get"))

        
        if not Lang.checkLang(Lang.CN) then
            self._i8RichText:setVisible(true)
            self._fileNodeText:setVisible(false)
            img:setVisible(false)
        end
    elseif state == 3 then          -- 3. 已购买已倒计时
        richText = ccui.RichText:createRichTextByFormatString(
            Lang.get("mine_craft_privilege_continue", {num1 = days, num2 = 2}),
            {defaultColor = Colors.BRIGHT_BG_TWO, defaultSize = 20, other ={[1] = {fontSize = 21}, [2] = {fontSize = 21}
        }})

        local img = getRewards()
        local payCfg = MineCraftHelper.getPrivilegeVipCfg()
        local str = (canReceive and Lang.get("mine_craft_privilege_get") or
                                    Lang.get("mine_craft_privilege_again", {num = tostring(payCfg.rmb)}))
        if Lang.checkLang(Lang.TW) or Lang.checkChannel(Lang.CHANNEL_SEA) then
            local UIHelper  = require("yoka.utils.UIHelper")
            local _,currency = UIHelper.convertDollar(payCfg.rmb)
            str = (canReceive and Lang.get("mine_craft_privilege_get") or
                    Lang.get("mine_craft_privilege_again", {num = tostring(currency)}))
        end

        if canReceive then
            self._fileNodeBtn:switchToHightLight()
            self._fileNodeBtn:setString("")
            self._fileNodeText:setString(str)
            self._fileNodeText:setColor(Colors.BUTTON_ONE_NORMAL)
            self._fileNodeText:enableOutline(Colors.BUTTON_ONE_NORMAL_OUTLINE, 2)   
            img:setVisible(true)

            if not Lang.checkLang(Lang.CN) then
                self._i8RichText:setVisible(true)
                self._fileNodeText:setVisible(false)
                img:setVisible(false)
            end
        else
            self._fileNodeBtn:switchToNormal()
            self._fileNodeBtn:setString(str)
            self._fileNodeText:setString("")
            img:setVisible(false)

            if not Lang.checkLang(Lang.CN) then
                self._i8RichText:setVisible(false)
            end
        end
    end

    richText:setAnchorPoint(cc.p(0.5, 0.5))
    self._nodeActivedLast3:addChild(richText)
end

function PopupMineCraftPrivilege:_onBtnClose()
	self:close()
end

function PopupMineCraftPrivilege:_onBtnGet()
    local payCfg = MineCraftHelper.getPrivilegeVipCfg()
    local cardData = G_UserData:getActivityMonthCard():getMonthCardDataById(payCfg.id)

    if cardData and cardData:isCanReceive() then
		G_UserData:getActivityMonthCard():c2sUseMonthlyCard(payCfg.id)
	else
		G_GameAgent:pay(payCfg.id, 
					payCfg.rmb, 
					payCfg.product_id, 
					payCfg.name, 
					payCfg.name)
	end
end

function PopupMineCraftPrivilege:_onEventRechargeGetInfo()
    self:_updateBtnDesc()
end

function PopupMineCraftPrivilege:_onEventWelfareMonthCardGetReward(event, id, message)
    local awards = rawget(message, "reward")
	if awards then
		G_Prompt:showAwards(awards)
	end
end


-- i18n change lable
function PopupMineCraftPrivilege:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")
        local image111 = UIHelper.seekNodeByName(self._imageVip5,"Image_111")
        UIHelper.swapWithLabel(image111,{
            style = "mine_privilege_1",
            text = Lang.getImgText("img_10")
       })
        
        self._imageSigned = UIHelper.swapSignImage(self._imageSigned,
        { 
                style = "sign_1", 
                text = Lang.getImgText("img_receive") ,
                anchorPoint = cc.p(0.5,0.5),
                rotation = -10,
        },Path.getTextSignet("img_common_lv"))


        local richText = ccui.RichText:createWithContent(
            Lang.getImgText("mine_privilege_award",{imgFile = Path.getCraftPrivilege("img_04")})
        )
        richText:setAnchorPoint(cc.p(0.5,0.5))
        self._fileNodeBtn:addChild(richText)
        self._i8RichText = richText
	end
end

function PopupMineCraftPrivilege:_dealPosByI18n()
    if Lang.checkLang(Lang.TH) or Lang.checkLang(Lang.EN) then 
        local UIHelper  = require("yoka.utils.UIHelper")
        local panel_13 = UIHelper.seekNodeByName(self,"Panel_13")
        panel_13:setPositionX(panel_13:getPositionX()-60)
    end
end

return PopupMineCraftPrivilege

