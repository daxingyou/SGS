local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupHurtRewardCell = class("PopupHurtRewardCell", ListViewCellBase)

local Color = require("app.utils.Color")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local TextHelper = require("app.utils.TextHelper")

PopupHurtRewardCell.HURT_SCALE_SIZE = 10000     --总伤害需要*一个统一的倍率

function PopupHurtRewardCell:ctor()
    -- self._rewardData = rewardData
    self._nodeBG = nil  --背景框
    self._btnGet = nil  --领取
    self._textHurtNum = nil --累计伤害数值
    self._textItemName = nil    --物品名字
    self._imageGot = nil        --已领取图标
    self._itemIcon = nil        --物品图标
	local resource = {
		file = Path.getCSB("PopupHurtRewardCell", "siege"),
		binding = {
            --[[ --需要连续点击
            _btnGet = {
				events = {{event = "touch", method = "_onGetClick"}}
			},
            ]]
		}
	}
	PopupHurtRewardCell.super.ctor(self, resource)
end

function PopupHurtRewardCell:onCreate()
    -- i18n change lable
    self:_dealI18n()
    -- i18n pos lable
    self:_dealPosByI18n()

    local size = self._nodeBG:getContentSize()
    self:setContentSize(size)
    self:setSwallowTouches(false)

    self._btnGet:addClickEventListenerExDelay(handler(self,self._onGetClick),100)

end

function PopupHurtRewardCell:updateUI(rewardData)
    self._rewardData = rewardData
    local showBtnGet = true
    if G_UserData:getSiegeData():isHurtRewardGet(self._rewardData.id) then
        showBtnGet = false
    end
    self._btnGet:setVisible(showBtnGet)
    self._btnGet:setString(Lang.get("siege_reward_get"))
    self._imageGot:setVisible(not showBtnGet)

    self._itemIcon:unInitUI()
    self._itemIcon:initUI(self._rewardData.award_type, self._rewardData.award_value, self._rewardData.award_size)
    local item = TypeConvertHelper.convert(self._rewardData.award_type, self._rewardData.award_value, self._rewardData.award_size)
    print("1112233 item name = ", item.name)
    self._textItemName:setString(item.name)
 	self._textItemName:setColor(item.icon_color)
	-- self._textItemName:enableOutline(item.icon_color_outline, 2)   

    local targetHurt = self._rewardData.target_size * PopupHurtRewardCell.HURT_SCALE_SIZE
    local targetHurtStr = TextHelper.getAmountText2(targetHurt)
   
    if not Lang.checkLang(Lang.CN) then
        self._textHurtNum:removeAllChildren()
        local widget = ccui.RichText:createWithContent(
            Lang.getImgText("popup_hurt_reward_cell",{value = targetHurtStr})
        )
        widget:setAnchorPoint(cc.p(0,0.5))
        self._textHurtNum:addChild(widget)
        if Lang.checkLang(Lang.JA) then
	        widget:ignoreContentAdaptWithSize(false)
            widget:setContentSize(cc.size(260, 0))
        end
    else    
    self._textHurtNum:setString(targetHurtStr)

    end
    local totalDamage = G_UserData:getSiegeData():getTotal_hurt()
    if totalDamage < targetHurt then
        self._btnGet:setEnabled(false)
        self._btnGet:setString(Lang.get("siege_reward_not_reach"))
    else 
        self._btnGet:setEnabled(true)
    end
end

function PopupHurtRewardCell:_onGetClick(sender)
	local offsetX = math.abs(sender:getTouchEndPosition().x - sender:getTouchBeganPosition().x)
	local offsetY = math.abs(sender:getTouchEndPosition().y - sender:getTouchBeganPosition().y)
    if offsetX < 20 and offsetY < 20  then
        if G_UserData:getSiegeData():isExpired() then
            G_UserData:getSiegeData():refreshRebelArmy() 
            return
        end
        G_UserData:getSiegeData():c2sRebArmyHurtReward(self._rewardData.id)
	end
end


-- i18n change lable
function PopupHurtRewardCell:_dealI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
        self._imageGot = UIHelper.swapSignImage(self._imageGot,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("img_yilingqu02") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))
	end
end


-- i18n pos lable
function PopupHurtRewardCell:_dealPosByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local textHurt = UIHelper.seekNodeByName(self._nodeBG,"TextHurt")
		local size = textHurt:getContentSize()
        textHurt:setVisible(false)
        self._textHurtNum:setPositionX(textHurt:getPositionX())
    end
end

return PopupHurtRewardCell