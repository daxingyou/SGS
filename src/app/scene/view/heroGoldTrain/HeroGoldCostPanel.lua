local PopupCommonLimitCost = require("app.ui.PopupCommonLimitCost")
local HeroGoldCostPanel = class("HeroGoldCostPanel", PopupCommonLimitCost)
local LimitCostConst = require("app.const.LimitCostConst")

function HeroGoldCostPanel:ctor(costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
    HeroGoldCostPanel.super.ctor(self, costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
end

function HeroGoldCostPanel:_initView()
    local HeroGoldHelper = require("app.scene.view.heroGoldTrain.HeroGoldHelper")
    local heroId = G_UserData:getHero():getCurHeroId()
    local unitData = G_UserData:getHero():getUnitDataWithId(heroId)
    local costInfo, baseId = HeroGoldHelper.heroGoldTrainCostInfo(unitData)
    local DataConst = require("app.const.DataConst")
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    if self._costKey == LimitCostConst.LIMIT_COST_KEY_2 then
        local tbPos = {
            [1] = {46, 148},
            [2] = {110, 56},
            [3] = {225, 56},
            [4] = {290, 148}
        }
        
        -- i18n ja pos materialIcon
        if Lang.checkUI("ui4") then
			tbPos = {
				[1] = {82 + 5, -220},
				[2] = {3 + 5, -220},
				[3] = {-76 + 5, -220},
				[4] = {-156 + 5, -220},
			}
        end
        
        for i = 1, 4 do
            local item =
                self:_createMaterialIcon(
                DataConst["ITEM_HERO_LEVELUP_MATERIAL_" .. i],
                costInfo["consume_" .. self._costKey],
                TypeConvertHelper.TYPE_ITEM
            )
            item:setPosition(cc.p(tbPos[i][1], tbPos[i][2]))
        end
    elseif self._costKey == LimitCostConst.LIMIT_COST_KEY_1 then
        self:_createMaterialIcon(baseId, costInfo.consume_hero, TypeConvertHelper.TYPE_HERO)
    else
        self:_createMaterialIcon(
            costInfo["value_" .. self._costKey],
            costInfo["consume_" .. self._costKey],
            costInfo["type_" .. self._costKey]
        )
    end
    self._panelTouch:setContentSize(G_ResolutionManager:getDesignCCSize())
    self._panelTouch:addClickEventListener(handler(self, self._onClickPanel)) --避免0.5秒间隔
end

function HeroGoldCostPanel:fitterItemCount(item)
    local type = item:getType()
    local TypeConvertHelper = require("app.utils.TypeConvertHelper")
    if type == TypeConvertHelper.TYPE_HERO then
        local value = item:getItemId()
        local PetTrainHelper = require("app.scene.view.petTrain.PetTrainHelper")
        local UserDataHelper = require("app.utils.UserDataHelper")
        item:updateCount(UserDataHelper.getSameCardCount(type, value, G_UserData:getHero():getCurHeroId()))
    else
        item:updateCount()
    end
end

-- i18n ja add func
function HeroGoldCostPanel:onEnter()
	if not Lang.checkUI("ui4") then   
		return
    end   

    local num = #self._items
    local width = self._items[1]:getChildByName("PanelTouch"):getBoundingBox().width*0.8

    width = 10 + num*(width + 15) - 2
    if #self._items == 1 then   		-- 仅一个材料，背景框要适配描述字
        width = 210
        self._items[1]:setPositionX(25)
    end
    self._imageBg:setContentSize(cc.size(width, 140))
    self._imageBg:getChildren()[1]:setPositionX(width/2)
    self:adjustI18n()
end

-- i18n ja change line
function HeroGoldCostPanel:adjustI18n()
    local ActWeekDiscount = require("app.config.act_week_discount")
    local model = ActWeekDiscount.get(5).name      
    if Lang["lang"] == Lang.JA then    
        model = string.split(model, "の")[2]
    elseif Lang["lang"] == Lang.CN then
        model = "杜康"
    end    
    
	for i=1, #self._items do
		local strName = self._items[i]:getChildByName("TextValue"):getString()  -- 杜康酒超框 特殊处理
		if strName.find(strName, model) then
			-- strName = string.gsub(strName, model, "")  第一种方法
			-- strName = strName .. "\n"
			-- strName = strName .. model
            self._items[i]:getChildByName("TextValue"):getVirtualRenderer():setMaxLineWidth(18*4)  --第二种方法
            self._items[i]:getChildByName("TextValue"):setString(strName)
			self._items[i]:getChildByName("TextValue"):setPositionY(-53 - 2)
			self._items[i]:getChildByName("TextValue"):getVirtualRenderer():setLineSpacing(0)
		end
	end 
end

return HeroGoldCostPanel
