local PopupBase = require("app.ui.PopupBase")
local PopupCommonLimitCost = class("PopupCommonLimitCost", PopupBase)
local CSHelper = require("yoka.utils.CSHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local AudioConst = require("app.const.AudioConst")

function PopupCommonLimitCost:ctor(costKey, onClick, onStep, onStart, onStop, limitLevel, fromNode)
    self._costKey = costKey
    self._onClick = onClick
    self._onStep = onStep
    self._onStart = onStart
    self._onStop = onStop
    self._limitLevel = limitLevel
    self._fromNode = fromNode
    local resource = {
        file = Path.getCSB("HeroLimitCostPanel", "hero"),
        binding = {}
    }
    -- i18n ja change CSB
    if Lang.checkUI("ui4") then 
        resource.file = Path.getCSB("HeroLimitCostPanel2", "hero")
    end
    PopupCommonLimitCost.super.ctor(self, resource, false, true)
end

function PopupCommonLimitCost:onCreate()
    self:_initData()
    self:_initView()
    
    self:_screenAdaptation()
end
  
function PopupCommonLimitCost:_screenAdaptation()  
    --多机型适配位置
    local scene = G_SceneManager:getTopScene()   
    local view = scene:getSceneView()
    local _listView = ccui.Helper:seekNodeByName(view, "_listView")  
    local newWorldPos = _listView:getParent():convertToWorldSpace(cc.p(_listView:getPositionX(), _listView:getPositionY()))
    newWorldPos = self._imageBg:getParent():convertToNodeSpace(cc.p(newWorldPos.x - 326 - 4, newWorldPos.y - 5)) 
    self._imageBg:setPosition(newWorldPos)
end

function PopupCommonLimitCost:_initData()
    self._items = {}
    self._itemIds = {}
end

-- 初始化panel视图,需重写
function PopupCommonLimitCost:_initView()
end

function PopupCommonLimitCost:_createMaterialIcon(itemId, costCount, itemType)
    local item = CSHelper.loadResourceNode(Path.getCSB("CommonMaterialIcon", "common"))
    item:setScale(0.8)
    item:setType(itemType)
    item:updateUI(itemId, handler(self, self._onClickIcon), handler(self, self._onStepClickIcon))
    local param = TypeConvertHelper.convert(itemType, itemId)
    item:setName(param.name)
    item:setCostCountEveryTime(costCount)
    item:setStartCallback(handler(self, self._onStartCallback))
    item:setStopCallback(handler(self, self._onStopCallback))
    item:setIsShift(true)
    item:setPosition(cc.p(170, 53))         
    self._imageBg:addChild(item)
    
    table.insert(self._items, item)
    table.insert(self._itemIds, itemId)
    return item
end

function PopupCommonLimitCost:onEnter()
    -- i18n ja change 
    if Lang.checkUI("ui4") then 
        self:updateUI()
    else  
        local nodePos = self._fromNode:convertToWorldSpaceAR(cc.p(0, 0))
        local dstPos = self:convertToNodeSpace(cc.p(nodePos.x, nodePos.y))
        self._imageBg:setPosition(dstPos)   
    end
end

function PopupCommonLimitCost:onExit()
end

function PopupCommonLimitCost:updateUI()
    logWarn("PopupCommonLimitCost:updateUI")
    for i, item in ipairs(self._items) do
        self:fitterItemCount(item, self._itemIds[i])
    end
end

-- 可重写自己设置数量
function PopupCommonLimitCost:fitterItemCount(item, itemId)
    local type = item:getType()
    local count = nil
    if type==TypeConvertHelper.TYPE_HERO then
        local list = G_UserData:getHero():getSameCardCountWithBaseId(itemId)
        count = #list
    end
    item:updateCount(count)
end

function PopupCommonLimitCost:_onClickIcon(materials)
    if self._onClick then
        G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_TIANCHONG)
        self._onClick(self._costKey, materials)
    end
end

function PopupCommonLimitCost:_onStepClickIcon(itemId, itemValue, costCountEveryTime)
    if self._onStep then
        G_AudioManager:playSoundWithId(AudioConst.SOUND_LIMIT_TIANCHONG)
        local continue, realCostCount, isDo = self._onStep(self._costKey, itemId, itemValue, costCountEveryTime)
        return continue, realCostCount, isDo
    end
end

function PopupCommonLimitCost:_onStartCallback(itemId, count)
    if self._onStart then
        self._onStart(self._costKey, itemId, count)
    end
end

function PopupCommonLimitCost:_onStopCallback()
    if self._onStop then
        self._onStop()
    end
end

function PopupCommonLimitCost:_onClickPanel()
    self:close()
end

function PopupCommonLimitCost:findNodeWithItemId(itemId)
    for i, id in ipairs(self._itemIds) do
        if id == itemId then
            return self._items[i]
        end
    end
    return nil
end

function PopupCommonLimitCost:getCostKey()
    return self._costKey
end

return PopupCommonLimitCost
