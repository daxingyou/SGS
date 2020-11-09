--
-- Author: hyl
-- Date: 2019-7-8 13:50:59
--
local ListViewCellBase = require("app.ui.ListViewCellBase")
local ReturnGiftsCell = class("ReturnGiftsCell", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local ReturnGifts = require("app.config.return_gift")
local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
local CustomActivityConst = require("app.const.CustomActivityConst")
local ReturnDataHelper = require("app.utils.data.ReturnDataHelper")

ReturnGiftsCell.ITEM_GAP = 106--奖励道具之间的间隔

function ReturnGiftsCell:ctor()
    self._configId = 0
    
	local resource = {
		file = Path.getCSB("ReturnDailyActivityCell", "return"),
        binding = {
			_btnGet = {
				events = {{event = "touch", method = "_onBtnGetClick"}}
            },
        },
	}
	ReturnGiftsCell.super.ctor(self, resource)
end

function ReturnGiftsCell:onCreate()
    self:_swapImageByI18n()
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end

function ReturnGiftsCell:update(data)
    self._curInfo = data
	--dump(data)
    
    local configInfo = ReturnGifts.get(data.id)
    --dump(configInfo)

    self._configId = data.id

    self:_initRewardInfo(configInfo)

    local des = configInfo.txt
    self._textPlayerName:setString(des)

    self._btnGet:setVisible(true)
    self._btnBuy:setVisible(false)
    self._btnGet:setString(Lang.get("common_receive"))

    local maxTimes = configInfo.time

    local richText = Lang.get("return_progress",
        { 
            title = Lang.get("times_title"), 
            cur = data.num, curColor = Colors.colorToNumber(data.num > 0 and Colors.NORMAL_BG_ONE or Colors.BRIGHT_BG_RED), 
            max = maxTimes, maxColor = Colors.colorToNumber(Colors.NORMAL_BG_ONE )
        }
    )
    self:_createProgressRichText(richText)

    self._nodeProgress:setVisible(data.num > 0)

    self._imageReceive:setVisible(data.num == 0)
    self._btnGet:setVisible(data.num > 0)
    self._btnGet:setEnabled(data.num > 0)
end

function ReturnGiftsCell:_onBtnGetClick ()
    if G_UserData:getReturnData():isActivityEnd() then
		G_Prompt:showTip(Lang.get("customactivity_avatar_act_end_tip"))
		return
    end
    
    G_UserData:getReturnData():c2sReceiveAwards(1, self._configId)
end

function ReturnGiftsCell:_initRewardInfo(configInfo)
    local rewards = ReturnDataHelper.getRewardConfigInfo(configInfo, 3)
    --dump(rewards)
    local rewardTypes = {}
    for i = 1, #rewards do
		rewardTypes[i] = CustomActivityConst.REWARD_TYPE_ALL
    end
    if Lang.checkLang(Lang.CN) then
		self._commonRewardListNode:setGaps(ReturnGiftsCell.ITEM_GAP)
	else
		self._commonRewardListNode:setGaps(ReturnGiftsCell.ITEM_GAP,140,140,430)
	end
    
    self._commonRewardListNode:updateInfo(rewards,rewardTypes)
end

--创建富文本
function ReturnGiftsCell:_createProgressRichText(richText)
    self._nodeProgress:removeAllChildren()
    local widget = ccui.RichText:createWithContent(richText)
    widget:setAnchorPoint(cc.p(0.5,0.5))
    self._nodeProgress:addChild(widget)
end

-- i18n change lable
function ReturnGiftsCell:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
        local UIHelper  = require("yoka.utils.UIHelper")	
        self._imageReceive = UIHelper.swapSignImage(self._imageReceive,
		{ 
			 style = "signet_8", 
			 text = Lang.getImgText("img_seal_yilingqu03") ,
			 anchorPoint = cc.p(0.5,0.5),
			 rotation = -10,
		},Path.getTextSignet("img_common_lv"))

	end
end
return ReturnGiftsCell