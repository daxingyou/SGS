-- @Author panhoa
-- @Date 12.28.2018
-- @Role

local ListViewCellBase = require("app.ui.ListViewCellBase")
local HistoricalItemCell = class("HistoricalItemCell", ListViewCellBase)
local HistoryHeroConst = require("app.const.HistoryHeroConst")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")


function HistoricalItemCell:ctor()

    local resource = {
        file = Path.getCSB("HistoricalItemCell", "historyhero"),
    }

    HistoricalItemCell.super.ctor(self, resource)
end

function HistoricalItemCell:onCreate()
    self:_updateSize()
end

function HistoricalItemCell:_updateSize()
    local size = self._resourceNode:getContentSize()
    self:setContentSize(size.width, size.height)
    self["_buttonChoose1"]:switchToNormal()
    self["_buttonChoose2"]:switchToNormal()
    self["_buttonChoose1"]:setString(Lang.get("historyhero_awake_popstate1"))
    self["_buttonChoose2"]:setString(Lang.get("historyhero_awake_popstate1"))
end

function HistoricalItemCell:synchroType(type)
    self._type = type
end

function HistoricalItemCell:updateUI(data)
    if data == nil or next(data) == nil then
        return
    end

    local function updateItem(index, itemData)
        -- body
        if type(itemData) ~= "table" or itemData.cfg == nil then
            self["_item"..index]:setVisible(false)
        else
            if self._type == nil then
                self["_item"..index]:setVisible(false)
                return
            end
            self["_item"..index]:setVisible(true)


            local type =  HistoryHeroConst.TAB_TYPE_BREAK
            local baseId = 0
            if self._type == HistoryHeroConst.TAB_TYPE_HERO then
                type = TypeConvertHelper.TYPE_HISTORY_HERO
                baseId = itemData.cfg:getSystem_id()
            elseif self._type == HistoryHeroConst.TAB_TYPE_BREAK  then 
				type = TypeConvertHelper.TYPE_HISTORY_HERO
                baseId = itemData.cfg:getSystem_id()
            elseif self._type == HistoryHeroConst.TAB_TYPE_AWAKE then
              	type = TypeConvertHelper.TYPE_HISTORY_HERO_WEAPON
                baseId = itemData.cfg:getId()
            elseif self._type == HistoryHeroConst.TAB_TYPE_REBORN then
                type = TypeConvertHelper.TYPE_HISTORY_HERO
                baseId = itemData.cfg:getSystem_id()
            end 

            self["_item"..index]:updateUI(type, baseId)
            self["_buttonChoose"..index]:setEnabled(itemData.canSelect)
            self["_buttonChoose"..index]:addClickEventListenerEx(function()
                self:dispatchCustomCallback(itemData.cfg:getId())
            end)
        end
    end

    local idx = 0
    for key, value in pairs(data) do
        idx = (idx + 1)
        updateItem(idx, value)
    end
end



return HistoricalItemCell