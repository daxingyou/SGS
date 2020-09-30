-- Author: conley
local ListViewCellBase = require("app.ui.ListViewCellBase")
local PopupTowerSuperStageCell = class("PopupTowerSuperStageCell", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
function PopupTowerSuperStageCell:ctor()
    self._textOpen = nil
    self._textStageName = nil
    self._imageArrow = nil
    self._heroIcon = nil
    self._imageLight = nil
	local resource = {
		file = Path.getCSB("PopupTowerSuperStageCell", "tower"),
		binding = {
            _resourceNode = {events = {{event = "touch", method = "_onTouchCallBack"}}}
		},
	}
    PopupTowerSuperStageCell.super.ctor(self,resource)
end

function PopupTowerSuperStageCell:onCreate()
    -- i18n pos lable
    self:_dealPosI18n()
    local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)
    --self._resourceNode:setSwallowTouches(false)
end

function PopupTowerSuperStageCell:_onItemClick(sender)
	local curSelectedPos = self:getTag()
	logWarn("PopupTowerSuperStageCell:_onIconClicked  "..curSelectedPos)
	self:dispatchCustomCallback(curSelectedPos)
end

function PopupTowerSuperStageCell:_getEquipStageConfig(id)
    if id == 0 then 
        return nil
    end
    local EquipStage = require("app.config.equip_stage")
    local equipStageConfig = EquipStage.get(id) 
    assert(equipStageConfig, "equip_stage can not find id "..tostring(id))
    return equipStageConfig
end

function PopupTowerSuperStageCell:updateInfo(data,index,selectIndex,lastOpenIndex)
    self._index = index
    local open = G_UserData:getTowerData():isSuperStageOpen(data:getId())
    local config = data:getConfig()
    local name = data:getConfig().name
    
    local needStageUnit = G_UserData:getTowerData():getSuperStageUnitData(config.need_id)
    local preStageName = needStageUnit and needStageUnit:getConfig().name or ""

    local needShowNormalStageName = false --是否显示爬塔普通关卡名
    if needStageUnit and needStageUnit:isPass() then
        needShowNormalStageName = true
    end
    if not needStageUnit then
        needShowNormalStageName = true
    end
    --第三个未开启的关卡
    if lastOpenIndex + 3 ==  index then
        needShowNormalStageName = true
    end

    if needShowNormalStageName and config.need_equip_stage ~= 0 then
        --[[
        --不在需要显示普通关卡名
         --preStageName = Lang.get("challenge_tower_stage_simple_name",{value = config.need_equip_stage})
         ]]
    end
   

    self:setSelected(index == selectIndex)
    
    self._heroIcon:unInitUI()
	self._heroIcon:initUI( TypeConvertHelper.TYPE_HERO, config.res_id)
    self._heroIcon:setIconMask(not open)
    self._heroIcon:setImageTemplateVisible(true)

    local itemParams = self._heroIcon:getItemParams()

    self._textOpen:setString(Lang.get("challenge_tower_pass_condition",{name = preStageName}))
    self._textStageName:setString(name)
    self._textStageName:setColor(itemParams.icon_color)

    self._textOpen:setVisible(not open)
    self._textStageName:setVisible(open)

    if Lang.checkLang(Lang.JA) then
        self._textStageName:setVisible(true)
        self._textOpen:setVisible(false)
        local UTF8 = require("app.utils.UTF8")
        local tempLen = UTF8.utf8len(name)
        local nameNew = name
        if tempLen == 2 then
            nameNew = UTF8.utf8sub(name, 1, 1).." "..UTF8.utf8sub(name, 2, 2)
        end
        self._textStageName:setString(nameNew)
    end
end


function PopupTowerSuperStageCell:setSelected(selected)
    self._imageArrow:setVisible(selected)
    self._imageLight:setVisible(selected)
end

function PopupTowerSuperStageCell:_onTouchCallBack(sender,state)
	-----------防止拖动的时候触发点击
	if(state == ccui.TouchEventType.ended) or not state then
		local moveOffsetX = math.abs(sender:getTouchEndPosition().x-sender:getTouchBeganPosition().x)
		local moveOffsetY = math.abs(sender:getTouchEndPosition().y-sender:getTouchBeganPosition().y)
		if moveOffsetX < 20 and moveOffsetY < 20 then
			self:_onItemClick(sender)
		end
	end

end



-- i18n pos lable
function PopupTowerSuperStageCell:_dealPosI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")

		self._textStageName:setFontSize(
            self._textStageName:getFontSize()-4
        )
        
		self._textOpen:setFontSize(
            self._textOpen:getFontSize()-4
        )

        if Lang.checkUI("ui4") then
            self._textOpen:setAnchorPoint(cc.p(0.5,0.5))
            self._textOpen:setPositionX(self._textStageName:getPositionX())
        else
            self._textStageName:setAnchorPoint(cc.p(0,0.5))
            self._textStageName:setPositionX(self._textOpen:getPositionX())
        end
    end

end


return PopupTowerSuperStageCell
