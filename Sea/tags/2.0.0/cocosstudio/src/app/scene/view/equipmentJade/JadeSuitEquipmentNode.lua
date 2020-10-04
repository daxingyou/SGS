--
-- Author: liushiyin
local ListViewCellBase = require("app.ui.ListViewCellBase")
local JadeSuitEquipmentNode = class("JadeSuitEquipmentNode", ListViewCellBase)
local CSHelper = require("yoka.utils.CSHelper")
local TextHelper = require("app.utils.TextHelper")
local EquipConst = require("app.const.EquipConst")
local UIHelper = require("yoka.utils.UIHelper")

function JadeSuitEquipmentNode:ctor(jadeConfig, rangeType)
    self._jadeConfig = jadeConfig
    self._rangeType = rangeType or EquipConst.EQUIP_RANGE_TYPE_1

    local resource = {
        file = Path.getCSB("EquipDetailDynamicModule", "equipment"),
        binding = {}
    }
    JadeSuitEquipmentNode.super.ctor(self, resource)
end

function JadeSuitEquipmentNode:onCreate()
    local title = self:_createTitle()
    self._listView:pushBackCustomItem(title)
    self:_addSuitEquipments()
    self._listView:doLayout()
    local contentSize = self._listView:getInnerContainerSize()
    contentSize.height = contentSize.height
    self._listView:setContentSize(contentSize)
    self:setContentSize(contentSize)
end

function JadeSuitEquipmentNode:_createTitle()
    local title = CSHelper.loadResourceNode(Path.getCSB("CommonDetailTitleWithBg", "common"))
    title:setFontSize(24)
    title:setTitle(Lang.get("jade_suit_equipment"))
    local widget = ccui.Widget:create()
    local titleSize = cc.size(402, 50)
    widget:setContentSize(titleSize)
    title:setPosition(titleSize.width / 2, 30)
    widget:addChild(title)

    return widget
end

function JadeSuitEquipmentNode:_addSuitEquipments()
    local equipmentInfos = string.split(self._jadeConfig.equipment, "|")
    for k, value in pairs(equipmentInfos) do
        local equipmentConfig = require("app.config.equipment").get(tonumber(value))
        if equipmentConfig then
            local widget = ccui.Widget:create()
            local imageParam = {texture = Path.getTeamUI("img_teamtrain_bg_icon01"), adaptWithSize = true}
            local imageBg = UIHelper.createImage(imageParam)
            local size = imageBg:getContentSize()
            imageBg:setPosition(size.width * 0.5, size.height * 0.5+9)
            widget:addChild(imageBg)
            local node = CSHelper.loadResourceNode(Path.getCSB("CommonEquipIcon", "common"))
            node:updateUI(tonumber(value))
            node:setPosition(65, 60)
            local params = {}
            params.text = equipmentConfig.name
            params.color = Colors.getColor(equipmentConfig.color)

            if equipmentConfig.color == 7 then
                params.outlineColor = Colors.getColorOutline(equipmentConfig.color)
                params.outlineSize = 2
            end

            local name = UIHelper.createLabel(params)
            name:setAnchorPoint(cc.p(0, 0.5))
            name:setPosition(135, 90)
            local richText =
                Lang.get(
                "lang_equipment_des",
                {
                    value = equipmentConfig.description
                }
            )
            local des = ccui.RichText:createWithContent(richText)
            des:ignoreContentAdaptWithSize(false)
            des:setContentSize(cc.size(270, 0))
            des:formatText()
            des:setAnchorPoint(cc.p(0, 1))
            des:setPosition(120, 75)
            widget:addChild(node)
            widget:addChild(name)
            widget:addChild(des)
            widget:setContentSize(cc.size(402, 110))

            if not Lang.checkLang(Lang.CN) then
                local desSize = des:getContentSize()
                local overHeight = math.max(desSize.height-63,0)
                if overHeight > 0 then
                    imageBg:ignoreContentAdaptWithSize(false)
                    imageBg:setContentSize(cc.size(size.width,size.height + overHeight))
                    name:setPositionY(name:getPositionY()+overHeight)
                    des:setPositionY(des:getPositionY()+overHeight)
                    imageBg:setPosition(size.width * 0.5, (size.height + overHeight) * 0.5+9)
                    node:setPositionY(node:getPositionY()+overHeight * 0.5)
                    widget:setContentSize(cc.size(402, 110 + overHeight))
                end
            end

            self._listView:pushBackCustomItem(widget)
        end
    end
end

return JadeSuitEquipmentNode
