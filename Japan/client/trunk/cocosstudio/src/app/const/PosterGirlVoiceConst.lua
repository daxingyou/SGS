
local PosterGirlVoiceConst = {}

--类型
PosterGirlVoiceConst.TYPE_OPEN_RECHARGE= 1 --打开充值界面 ok
PosterGirlVoiceConst.TYPE_NEW_GOODS = 2 --商店上新 ok
PosterGirlVoiceConst.TYPE_NEW_ACCOUNT = 3 --该账号首次打开充值 ok
PosterGirlVoiceConst.TYPE_RECHARGE_SUCCESS= 4 --充值成功 ok
PosterGirlVoiceConst.TYPE_RECHARGE_FAILD= 5 --充值失败
PosterGirlVoiceConst.TYPE_CLICK_SHOP_GOODS = 6 --点击商品  ok
PosterGirlVoiceConst.TYPE_RECHARGE_STAY  = 7--充值界面停留 ok
PosterGirlVoiceConst.TYPE_CARD_EXPIRED  = 8--月卡周卡到期 搁置
PosterGirlVoiceConst.TYPE_CLICK_AVATAR = 9 --点击立绘  ok
PosterGirlVoiceConst.TYPE_REACH_VIP_CLICK_AVATAR = 10 --vip升级后首次点击立绘
PosterGirlVoiceConst.TYPE_VIP_UPGRADE = 11 --VIP升级时
PosterGirlVoiceConst.TYPE_FESTIVEL_CLICK_AVATAR = 12 --节日点击立绘
PosterGirlVoiceConst.TYPE_FESTIVEL_UPGRADE_VIP_CLICK_AVATAR = 13 --节日升级VIP后点击立绘
PosterGirlVoiceConst.TYPE_CLICK_WARDROBE = 14--点击衣柜  ok
PosterGirlVoiceConst.TYPE_VIP_CHANGE_CLOTHES = 15 --点击换装按钮,播放换装特效时

--触发点类型
PosterGirlVoiceConst.TRIGGER_POS_OPEN_RECHARGE_UI  = 1 --打开充值界面
PosterGirlVoiceConst.TRIGGER_POS_PAY_SUCCESS  = 2--充值成功
PosterGirlVoiceConst.TRIGGER_POS_PAY_FAILD  = 3--充值失败
PosterGirlVoiceConst.TRIGGER_POS_CLICK_RECHARGE_ITEM  = 4--点击商品
PosterGirlVoiceConst.TRIGGER_POS_RECHARGE_STAY  = 5 --充值界面停留
PosterGirlVoiceConst.TRIGGER_POS_CLICK_AVATAR  = 6 --点击立绘
PosterGirlVoiceConst.TRIGGER_POS_VIP_UPGRADE  = 7 --VIP升级时
PosterGirlVoiceConst.TRIGGER_POS_CLICK_WARDROBE  = 8 --点击衣柜按钮
PosterGirlVoiceConst.TRIGGER_POS_VIP_CHANGE_CLOTHES = 9 --点击换装按钮,播放换装特效时

--条件类型
PosterGirlVoiceConst.CONDITION_DATE = 1 --固定日期，如1月1日~10日 
PosterGirlVoiceConst.CONDITION_VIP = 2 --特定vip，如 vip0-4
PosterGirlVoiceConst.CONDITION_STATE = 3  --状态
PosterGirlVoiceConst.CONDITION_CARD_EXPIRED= 4 --卡片过期
PosterGirlVoiceConst.CONDITION_UI_OPEN = 5 --界面打开
PosterGirlVoiceConst.CONDITION_TODAY_VIP_UPGRADE = 6 --今天升级

--缓存的状态值
PosterGirlVoiceConst.STATE_KEY_TODAY_FIRST = "today" --每日首次
PosterGirlVoiceConst.STATE_KEY_UPGRADE_VIP_FIRST = "upgrade_vip" --升级vip
PosterGirlVoiceConst.STATE_KEY_REACH_VIP_FIRST = "reach_vip"  --到达VIP
PosterGirlVoiceConst.STATE_KEY_NEW_ACCOUNT = "new_account" --新帐户
PosterGirlVoiceConst.STATE_KEY_NEW_GOODS = "new_goods" --新商品

function PosterGirlVoiceConst.getTypeName(typeId)
    for key, value in pairs(PosterGirlVoiceConst) do
        if string.find(key,"TYPE_") and value == typeId then
            return key
        end
    end
    return ""
end

function PosterGirlVoiceConst.getTypeId(typeName)
    for key, value in pairs(PosterGirlVoiceConst) do
        if string.find(key,"TYPE_") and key == typeName then
            return value
        end
    end
    return 0
end

function PosterGirlVoiceConst.getTriggerName(triggerid)
    for key, value in pairs(PosterGirlVoiceConst) do
        if string.find(key,"TRIGGER_") and value == triggerid then
            return key
        end
    end
    return ""
end

function PosterGirlVoiceConst.getTriggerId(triggerName)
    for key, value in pairs(PosterGirlVoiceConst) do
        if string.find(key,"TRIGGER_") and key == triggerName then
            return value
        end
    end
    return 0
end

return readOnly(PosterGirlVoiceConst)
