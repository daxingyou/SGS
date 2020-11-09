local PosterGirlVoiceConst = require("app.const.PosterGirlVoiceConst")
local VipVoice = require("app.config.vip_voice")
local PosterGirlVoiceHelper = {}


function PosterGirlVoiceHelper.isConditionReach(cfgId,param)
    local config = VipVoice.get(cfgId)
    assert(config,"vip_voice can not find id :  "..tostring(cfgId))
    if not PosterGirlVoiceHelper._CONDITION_VIP(config.vip_level_min,config.vip_level_max) then
        return false
    end
    if not PosterGirlVoiceHelper._CONDITION_DATE(config.date_star,config.date_end) then
        return false
    end
    local typeId = config.requirement
    local retFunc = PosterGirlVoiceHelper.getMoudleTable(typeId)
    if retFunc then
        return retFunc(config,param)
    end
    return false
end

function PosterGirlVoiceHelper.getMoudleTable(typeId)
	local typeName = PosterGirlVoiceConst.getTypeName(typeId)
	local retFunc = PosterGirlVoiceHelper["_" .. typeName]
    
	if retFunc ~= nil and type(retFunc) == "function" then
		return retFunc
	end
	return nil
end


function PosterGirlVoiceHelper._CONDITION_DATE(sDate,eDate)    
    if sDate == 0 or eDate == 0 then
        return true
    end

    
    local sDay = sDate % 100--tonumber(string.sub(sDate,5,6))
    local sMonth = ((sDate - sDay) % 10000 )/ 100 --tonumber(string.sub(sDate,3,4))
    local sYear = (sDate - sMonth * 100 - sDay) / 10000--tonumber(string.sub(sDate,1,2))
 
    
    local eDay = eDate % 100--tonumber(string.sub(eDate,5,6))
    local eMonth =  ((eDate - eDay) % 10000 )/ 100 --tonumber(string.sub(eDate,3,4))
    local eYear =  (eDate - eMonth * 100 - eDay) / 10000--tonumber(string.sub(eDate,1,2))
    
    
    local date = G_ServerTime:getDateObject()

    if date.year < sYear or date.month < sMonth or date.day < sDay then
        return false
    end
    
    if date.year > sYear or date.month > sMonth or date.day > sDay then
        return false
    end
    return true
end

function PosterGirlVoiceHelper._CONDITION_VIP(minVip,maxVip)    
    if minVip == 0 and maxVip == 0 then
        return true
    end
    local vip = G_UserData:getVip():getLevel()
    return vip >= minVip and vip <= maxVip
end

function PosterGirlVoiceHelper._CONDITION_TODAY_VIP_UPGRADE(minVip,maxVip)
    --服务器提供登陆的最初Vip值
    local todayInitVip = G_UserData:getBase():getToday_init_vip()
    local vip = G_UserData:getVip():getLevel()
    if vip > todayInitVip and vip >= minVip and vip <= maxVip then
        return true
    end
    return false
end

function PosterGirlVoiceHelper._CONDITION_CARD_EXPIRED(vipPayId)    
    local monthlyCardData = G_UserData:getActivityMonthCard()
    local cardData = monthlyCardData:getMonthCardDataById(vipPayId)
    if cardData and cardData:getRemainDay() <= 0 then
        return true
    end
    return false
end

function PosterGirlVoiceHelper._CONDITION_UI_OPEN(name)    
    local runningScene = G_SceneManager:getRunningScene()
    if runningScene:getName() == name then
        return true
    end
    return false
end


--最后判断
function PosterGirlVoiceHelper._CONDITION_STATE(stateType,stateParam)   
    if stateType == PosterGirlVoiceConst.STATE_KEY_TODAY_FIRST then
        local key = stateParam.triggerId.."_"..stateType
        local reach = false
        local state = G_PosterGirlManager:getState(key)
        if not state then
            reach =  true
        else
            local date = G_ServerTime:getDateObject()
            if state.year ~= date.year or state.month ~= date.month or state.day ~=  date.day then
                reach =  true
            end
        end
        if reach then
            local date = G_ServerTime:getDateObject()
            G_PosterGirlManager:setState(key,{year = date.year,month = date.month,day = date.day})
        end
        return reach
    elseif stateType == PosterGirlVoiceConst.STATE_KEY_UPGRADE_VIP_FIRST then
        local key = stateParam.triggerId.."_"..stateType.."_"..stateParam.vip
        local reach = false
        local state = G_PosterGirlManager:getState(key)
        if not state then
            reach =  true
        else 
            reach =  false
        end
        --[[ --如果可以重复升级
        else 
            local date = G_ServerTime:getDateObject()
            if state.year ~= date.year or state.month ~= date.month or state.day ~=  date.day then
                reach =  true
            end
        end
        ]]
        if reach then
            local date = G_ServerTime:getDateObject()
            G_PosterGirlManager:setState(key,{year = date.year,month = date.month,day = date.day})
        end
        return reach
    elseif stateType == PosterGirlVoiceConst.STATE_KEY_REACH_VIP_FIRST then
        local key = stateParam.triggerId.."_"..stateType.."_"..stateParam.vip
        local reach = false
        local state = G_PosterGirlManager:getState(key)
        if not state then
            reach =  true
        else
            reach =  false
        end
        if reach then
            local date = G_ServerTime:getDateObject()
            G_PosterGirlManager:setState(key,{year = date.year,month = date.month,day = date.day})
        end
        return reach
    elseif stateType == PosterGirlVoiceConst.STATE_KEY_NEW_ACCOUNT then
        local key =  stateParam.triggerId.."_"..stateType
        local reach = false
        local state = G_PosterGirlManager:getState(key)
        if not state then
            reach =  true
        else
            reach =  false
        end
        if reach then
            G_PosterGirlManager:setState(key,true)
        end
        return reach
    elseif stateType == PosterGirlVoiceConst.STATE_KEY_NEW_GOODS then
        local key = stateParam.triggerId.."_"..stateType
        local reach = false
        local state = G_PosterGirlManager:getState(key)
        if not state then
            reach =  true
        else
            local hasNewGoods,newGoods = G_UserData:getVipPay():isHasNewGoods(state)
            reach = hasNewGoods
        end
        if reach then
            local newGoods = G_UserData:getVipPay():getGoodsList()
            G_PosterGirlManager:setState(key,newGoods)
        end
        return reach
    end
    
end


--打开充值界面
function PosterGirlVoiceHelper._TYPE_OPEN_RECHARGE(cfg)
   return true
end

--商店上新
function PosterGirlVoiceHelper._TYPE_NEW_GOODS(cfg)
    return PosterGirlVoiceHelper._CONDITION_STATE(PosterGirlVoiceConst.STATE_KEY_NEW_GOODS,{
        triggerId = PosterGirlVoiceConst.TRIGGER_POS_OPEN_RECHARGE_UI
    })
end

--该账号首次打开充值
function PosterGirlVoiceHelper._TYPE_NEW_ACCOUNT(cfg)
   return PosterGirlVoiceHelper._CONDITION_STATE(PosterGirlVoiceConst.STATE_KEY_NEW_ACCOUNT,{
        triggerId = PosterGirlVoiceConst.TRIGGER_POS_OPEN_RECHARGE_UI
    })
end

--充值成功
function PosterGirlVoiceHelper._TYPE_RECHARGE_SUCCESS(cfg,param)
    local payArr = string.split(cfg.pay_id,"|")
    if not payArr then
        return false
    end
    for k,v in ipairs(payArr) do
        if v ~= "" and tonumber(v) == param.vip_pay_id then
            return true
        end
    end
    return false
end

--充值失败
function PosterGirlVoiceHelper._TYPE_RECHARGE_FAILD(cfg)
    return true
end

--点击商品
function PosterGirlVoiceHelper._TYPE_CLICK_SHOP_GOODS(cfg,param)
    local payArr = string.split(cfg.pay_id,"|")
    if not payArr then
        return false
    end
    for k,v in ipairs(payArr) do
        if v ~= "" and tonumber(v) == param.vip_pay_id then
            return true
        end
    end
    return false
end

--充值界面停留
function PosterGirlVoiceHelper._TYPE_RECHARGE_STAY(cfg,param)
    if cfg.value == param.time then
        return true
    end
    return false
end

--月卡周卡到期
function PosterGirlVoiceHelper._TYPE_CARD_EXPIRED(cfg)
    local payArr = string.split(cfg.pay_id,"|")
    if not payArr or payArr == "" then
        return false
    end
    local reach = false
    for k,v in ipairs(payArr) do
        if v ~= "" then
            local isExpired = PosterGirlVoiceHelper._CONDITION_CARD_EXPIRED(tonumber(v))
            if isExpired then
                reach = true
                break
            end
        end
    end
    if reach then
        reach = PosterGirlVoiceHelper._CONDITION_STATE(PosterGirlVoiceConst.STATE_KEY_TODAY_FIRST,{
            triggerId = PosterGirlVoiceConst.TRIGGER_POS_OPEN_RECHARGE_UI
        })
    end
    return reach
end 

--点击立绘
function PosterGirlVoiceHelper._TYPE_CLICK_AVATAR(cfg)
    return true
end

--vip升级后首次点击立绘
function PosterGirlVoiceHelper._TYPE_REACH_VIP_CLICK_AVATAR(cfg)
    return PosterGirlVoiceHelper._CONDITION_STATE(PosterGirlVoiceConst.STATE_KEY_REACH_VIP_FIRST,{
        triggerId = PosterGirlVoiceConst.TRIGGER_POS_CLICK_AVATAR,
        vip = cfg.vip_level_max
    })
end

--VIP升级时
function PosterGirlVoiceHelper._TYPE_VIP_UPGRADE(cfg)
    --vip在开始时候就判断了
    return PosterGirlVoiceHelper._CONDITION_UI_OPEN("vip")    
end

--节日点击立绘
function PosterGirlVoiceHelper._TYPE_FESTIVEL_CLICK_AVATAR(cfg)
    --vip,日期都在开始判断了
    return PosterGirlVoiceHelper._CONDITION_STATE(PosterGirlVoiceConst.STATE_KEY_TODAY_FIRST,{
        triggerId = PosterGirlVoiceConst.TRIGGER_POS_CLICK_AVATAR
    })
end

--节日升级VIP后点击立绘
function PosterGirlVoiceHelper._TYPE_FESTIVEL_UPGRADE_VIP_CLICK_AVATAR(cfg)
    --判断今天升级
    local reach = PosterGirlVoiceHelper._CONDITION_TODAY_VIP_UPGRADE( cfg.vip_level_min,cfg.vip_level_max)
    if reach then
        local vip = G_UserData:getVip():getLevel()
        reach = PosterGirlVoiceHelper._CONDITION_STATE(PosterGirlVoiceConst.STATE_KEY_UPGRADE_VIP_FIRST,{
            triggerId = PosterGirlVoiceConst.TRIGGER_POS_CLICK_AVATAR,
            vip = vip,
        })
    
    end
    return reach
end

--点击衣柜
function PosterGirlVoiceHelper._TYPE_CLICK_WARDROBE(cfg)
    return true
end

 --点击换装按钮,播放换装特效时
function PosterGirlVoiceHelper._TYPE_VIP_CHANGE_CLOTHES(cfg)
    return true
end

return PosterGirlVoiceHelper