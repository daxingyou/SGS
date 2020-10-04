-- @Author panhoa
-- @Date 12.27 2018
-- @Role 

local PopupBase = require("app.ui.PopupBase")
local PopupChooseHistoricalItemView = class("PopupChooseHistoricalItemView", PopupBase)
local TabScrollView = require("app.utils.TabScrollView")
local HistoryHeroConst = require("app.const.HistoryHeroConst")
local HistoricalItemCell = require("app.scene.view.historyhero.HistoricalItemCell")


function PopupChooseHistoricalItemView:ctor(type, chooseData, okCallback)
    self._panelTouch        = nil
    self._scrollView        = nil
    self._listView          = nil
    self._type              = type
    self._chooseData        = chooseData
    self._okCallback        = okCallback
    self._curData           = {}        -- 当前可实现数据

    local resource = {
		file = Path.getCSB("PopupChooseHistoricalItemView", "historyhero"),
    }

	PopupChooseHistoricalItemView.super.ctor(self, resource, false, false)
end

function PopupChooseHistoricalItemView:onCreate()
	local size = G_ResolutionManager:getDesignCCSize()
    self._panelTouch:setContentSize(size)

    self:_initTitle()
    self:_initListView()
end

function PopupChooseHistoricalItemView:onEnter()
    self:_updateListView()
end

function PopupChooseHistoricalItemView:onExit()
end

function PopupChooseHistoricalItemView:_onButtonClose()
	self:close()
end

-- @Role    
function PopupChooseHistoricalItemView:_initTitle()
    if HistoryHeroConst.TAB_TYPE_HERO == self._type then
        self._commonNodeBk:setTitle(Lang.get("historyhero_equip"))
    elseif HistoryHeroConst.TAB_TYPE_REBORN == self._type then
        self._commonNodeBk:setTitle(Lang.get("historyhero_reborn"))
    else
        self._commonNodeBk:setTitle(Lang.get("historyhero_awake_poptitle"))
    end
    self._commonNodeBk:addCloseEventListener(handler(self, self._onButtonClose))
end

-- @Role   
function PopupChooseHistoricalItemView:_initListView()
	local scrollViewParam = {
        template = HistoricalItemCell,
        updateFunc = handler(self, self._onCellUpdate),
        selectFunc = handler(self, self._onCellSelected),
        touchFunc = handler(self, self._onItemTouch),
    }
	self._scrollView = TabScrollView.new(self._listView, scrollViewParam, 1)
end

-- @Role    Get CellData
function PopupChooseHistoricalItemView:_initItemData()
    if HistoryHeroConst.TAB_TYPE_AWAKE == self._type then
        self._curData = G_UserData:getHistoryHero():getWeaponList()
    elseif HistoryHeroConst.TAB_TYPE_REBORN == self._type then
        self._curData = G_UserData:getHistoryHero():getCanRebornHisoricalHero()
    elseif HistoryHeroConst.TAB_TYPE_BREAK == self._type or HistoryHeroConst.TAB_TYPE_HERO == self._type then
        self._curData = G_UserData:getHistoryHero():getHeroList()
    end
end

-- @Role
function PopupChooseHistoricalItemView:_onCellUpdate(cell, index)
    if self._curData == nil or next(self._curData) == nil then
        return
    end

    local curCellIndex = (index * 2)
    local data = {}
    if HistoryHeroConst.TAB_TYPE_HERO == self._type then                        -- 0. 名将
        --body
        local bCanSelect1 = false
        local bCanSelect2 = false
        if #self._curData >= (curCellIndex + 1) then
            bCanSelect1 = (not G_UserData:getHistoryHero():isStarSquad(self._curData[curCellIndex + 1]:getSystem_id()))
        end
        if #self._curData >= (curCellIndex + 2) then
            bCanSelect2 = (not G_UserData:getHistoryHero():isStarSquad(self._curData[curCellIndex + 2]:getSystem_id()))
        end
        local itemData1 = {
            cfg = (#self._curData >= (curCellIndex + 1) and self._curData[curCellIndex + 1] or nil),
            canSelect = bCanSelect1,  
        }
        table.insert(data, itemData1)
        local itemData2 = {
            cfg = (#self._curData >= (curCellIndex + 2) and self._curData[curCellIndex + 2] or nil),
            canSelect = bCanSelect2,
        }

        table.insert(data, itemData2)
    elseif HistoryHeroConst.TAB_TYPE_AWAKE == self._type then                   -- 1. 觉醒
        --body
        local itemData1 = {
            cfg = nil,
            canSelect = false,
        }
        local itemData2 = {
            cfg = nil,
            canSelect = false,
        }
        local i = 0
        for k,v in pairs(self._curData) do
            i = (i + 1)
            if i == (curCellIndex + 1) then
                itemData1 = {
                    cfg = v,
                    canSelect = (self._chooseData.value == v:getId()),
                }
               
            elseif i == (curCellIndex + 2) then
                itemData2 = {
                    cfg = v,
                    canSelect = (self._chooseData.value == v:getId()),
                }
            end
        end
        table.insert(data, itemData1)
        table.insert(data, itemData2)
    elseif HistoryHeroConst.TAB_TYPE_BREAK == self._type then                  -- 2. 突破
        --body
        local itemData1 = {
            cfg = nil,
            canSelect = false,
        }
        itemData1.cfg = (#self._curData >= (curCellIndex + 1) and self._curData[curCellIndex + 1] or nil)
        if self._curData[curCellIndex + 1] ~= nil then
            local bEquiped,_ = G_UserData:getHistoryHero():isStarEquiped(self._curData[curCellIndex + 1]:getId())
            local bCurHero = (self._curData[curCellIndex + 1]:getSystem_id() == self._chooseData.value 
                                and self._curData[curCellIndex + 1]:getBreak_through() == HistoryHeroConst.TAB_TYPE_AWAKE)
            itemData1.canSelect = ((not bEquiped) and bCurHero)
        end
        table.insert(data, itemData1)
     
        local itemData2 = {
            cfg = nil,
            canSelect = false
        }
        itemData2.cfg = (#self._curData >= (curCellIndex + 2) and self._curData[curCellIndex + 2] or nil)
        if self._curData[curCellIndex + 2] ~= nil then
            local bEquiped,_ = G_UserData:getHistoryHero():isStarEquiped(self._curData[curCellIndex + 2]:getId())
            local bCurHero = (self._curData[curCellIndex + 2]:getSystem_id() == self._chooseData.value
                                and self._curData[curCellIndex + 2]:getBreak_through() == HistoryHeroConst.TAB_TYPE_AWAKE)
            itemData2.canSelect = ((not bEquiped) and bCurHero)
        end
        table.insert(data, itemData2)
    elseif HistoryHeroConst.TAB_TYPE_REBORN == self._type then                  -- 2. 重生
        local itemData1 = {
            cfg = (#self._curData >= (curCellIndex + 1) and self._curData[curCellIndex + 1] or nil),
            canSelect = true,
        }

        local itemData2 = {
            cfg = (#self._curData >= (curCellIndex + 2) and self._curData[curCellIndex + 2] or nil),
            canSelect = true,
        }
        table.insert(data, itemData1)
        table.insert(data, itemData2)
    end

    cell:synchroType(self._type)
    cell:updateUI(data)
end

function PopupChooseHistoricalItemView:_onCellSelected(cell, index)
end

--@Role     Touch CallBack
function PopupChooseHistoricalItemView:_onItemTouch(index, itemId)
    if itemId == nil then
        self:close()
        return
    end

    if self._okCallback then
        self._okCallback(itemId)
    end
    self:close()
end

-- @Role    UpdateUI
function PopupChooseHistoricalItemView:_updateListView()
    self:_initItemData()
    if self._curData == nil or next(self._curData) == nil then
        return
    end
	self._scrollView:updateListView(1, math.ceil(table.nums(self._curData) / 2))
end



return PopupChooseHistoricalItemView