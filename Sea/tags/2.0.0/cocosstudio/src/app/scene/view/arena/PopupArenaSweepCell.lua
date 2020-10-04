--竞技场扫荡界面cell

local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupArenaSweepCell = class("PopupArenaSweepCell", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

function PopupArenaSweepCell:ctor()

    self._title = title
    self._resourceNode = nil            --通用背景
    self._imageResult  = nil               --胜利Image

    self._textTitle     = nil
    self._commonInfo1 = nil             --普通奖励通用底
    self._commonInfo2 = nil
	local resource = {
		file = Path.getCSB("PopupArenaSweepCell", "arena"),
		binding = {
		}
	}
	PopupArenaSweepCell.super.ctor(self, resource)
end

function PopupArenaSweepCell:onCreate()
    -- i18n change lable
    self:_swapImageByI18n()
    -- i18n pos lable
    self:_dealPosI18n()

	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
end

function PopupArenaSweepCell:updateUI(title, rewardRes, rewardItem, isWin, addRewards)
    self._rewardRes = rewardRes
    self._rewardItem = rewardItem
    self._textTitle:setString(title)
    if isWin == true then
        
        if not Lang.checkLang(Lang.CN) then
		    local UIHelper  = require("yoka.utils.UIHelper")
             UIHelper.setLabelStyle(self._imageResult,{
                style = "ranking_2",
			    text = Lang.getImgText("img_ranking_win01") ,
             })
        else
            self._imageResult:loadTexture(Path.getRanking("img_ranking_win01"))
        end
        

    else

         if not Lang.checkLang(Lang.CN) then
		    local UIHelper  = require("yoka.utils.UIHelper")
             UIHelper.setLabelStyle(self._imageResult,{
                style = "ranking_1",
			    text = Lang.getImgText("img_ranking_lose01") ,
             })
        else
              self._imageResult:loadTexture(Path.getRanking("img_ranking_lose01"))
        end
    
    end
    --i18n
    if Lang.checkChannel(Lang.CHANNEL_SEA) then
        self._imageResult:setFontSize(36)
    end
    local critRewards = {}
    if addRewards then
        for k, v in pairs(addRewards) do
            if v.award and v.award.type and  v.award.value then
                local key = string.format("%s_%s", v.award.type, v.award.value)
                critRewards[key] = v
            end
        end
    end

    for i, value in ipairs(rewardRes) do
        self["_commonInfo"..i]:updateUI(value.type, value.value, value.size)
        self["_commonInfo"..i]:showResName(false)

        local key = string.format("%s_%s", value.type, value.value)
        local critReward = critRewards[key]
        if critReward then
            self["_commonInfo"..i]:updateCrit(critReward.index, critReward.award.size)
        else
            self["_commonInfo"..i]:setCritVisible(false)
        end
    end



    -- if rewardItem  and rewardItem[1] then
    --     local itemParams = TypeConvertHelper.convert(rewardItem[1].type, rewardItem[1].value)
    --     if itemParams== nil then
    --         return
    --     end
    --
    --
    --     self._itemIcon:unInitUI()
    --     self._itemIcon:initUI( rewardItem[1].type, rewardItem[1].value)
    --
    --     self._textItemName:setString(itemParams.name)
    --     self._textItemName:setColor(itemParams.icon_color)
    --     self._textItemName:enableOutline(itemParams.icon_color_outline, 2)
    --     local posX = self._textItemName:getContentSize().width + self._textItemName:getPositionX()
    --     self._textItemNum:setString("x "..rewardItem[1].size)
    --    -- self._textItemNum:setColor(Colors.COLOR_QUALITY[1])
    --    -- self._textItemNum:enableOutline(Colors.COLOR_QUALITY_OUTLINE[1], 2)
    --     self._textItemNum:setPositionX(posX+8)
    -- end
end

-- i18n change lable
function PopupArenaSweepCell:_swapImageByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		self._imageResult = UIHelper.swapWithLabel(self._imageResult,{
			style = "ranking_1",
			text = Lang.getImgText("img_ranking_lose01") ,
		})
	end
end


-- i18n pos lable
function PopupArenaSweepCell:_dealPosI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
        local text1 = UIHelper.seekNodeByName(self._commonInfo1,"Text_1")
		text1:setPositionX( text1:getPositionX() - 6)
	end
end



return PopupArenaSweepCell
