local ViewBase = require("app.ui.ViewBase")
local ListViewCellBase = require("app.ui.ListViewCellBase")
local TreasureTrainJadeLayer = class("TreasureTrainJadeLayer", ListViewCellBase)
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local TreasureTrainHelper = require("app.scene.view.treasureTrain.TreasureTrainHelper")
local TreasureConst = require("app.const.TreasureConst")
local EquipJadeIcon = require("app.scene.view.equipmentJade.EquipJadeIcon2")
local UIConst = require("app.const.UIConst")

TreasureTrainJadeLayer.INJECT = 1 -- 玉石镶嵌
TreasureTrainJadeLayer.UNALOAD = 2 -- 玉石卸下

local EFFECT_BG_RES = "moving_shuijingxiangqian_bg"
local EFFECT_BAGUA = "effect_shuijingxiangqian_bg_bagua"
local EFFECT_TEXING = "moving_zhanma_chengse_up"

function TreasureTrainJadeLayer:ctor(parentView)
    self._parentView = parentView

    local resource = {
        file = Path.getCSB("TreasureTrainJadeLayer2", "treasure"),
        size = G_ResolutionManager:getDesignSize(),
        binding = {}
    }
    self:enableNodeEvents()  
    TreasureTrainJadeLayer.super.ctor(self, resource)
end

function TreasureTrainJadeLayer:onCreate()
    self:_doLayout()
    self:_initUI()	
    self._recordAttr = G_UserData:getAttr():createRecordData(FunctionConst.FUNC_TREASURE_TRAIN_TYPE3)
end

function TreasureTrainJadeLayer:onEnter()
    self._signalJadeEquipSuccess =
        G_SignalManager:add(SignalConst.EVENT_JADE_TREASURE_SUCCESS, handler(self, self._onEventEquipJadeSuccess)) --
    self:_playBgEffect()
end

function TreasureTrainJadeLayer:onExit()
    self._signalJadeEquipSuccess:remove()
    self._signalJadeEquipSuccess = nil
end

function TreasureTrainJadeLayer:_doLayout()

	local contentSize = self._parentView._listView:getContentSize()
	self:setContentSize(contentSize)                   --  设置node节点尺寸
end

function TreasureTrainJadeLayer:_playBgEffect()
    G_EffectGfxMgr:createPlayMovingGfx(
        self._parentView._effectNode1,
        EFFECT_BG_RES,
        nil,
        function()
        end
    )
end

-- message S2C_JadeEquip {
-- 	required uint32 ret = 1;
-- 	optional uint64 id = 2;
-- 	optional uint64 equipment_id = 3;
-- 	optional uint32 pos = 4;
-- }
function TreasureTrainJadeLayer:_onEventEquipJadeSuccess(id, message)
    if self and self._parentView.checkRedPoint then
        self._parentView:checkRedPoint()
    end
    
    local id = rawget(message, "id")
    local pos = rawget(message, "pos")
    self:_updateData()
    self:_updateJadeSlot()

    local text = ""
    if id > 0 then
        text = Lang.get("jade_inject_success")
        self["_equipJadeIcon" .. (pos + 1)]:playEquipEffect()
    else
        text = Lang.get("jade_unload_success")
    end
    self:_playPrompt(text, isSuitable)
	if self._parentView and self._parentView.checkRedPoint then
		self._parentView:checkRedPoint(TreasureConst.TREASURE_TRAIN_JADE)
	end
end

function TreasureTrainJadeLayer:_playPrompt(text, isSuitable)
    if not self._unitData:isInBattle() then
        return
    end
    local summary = {}
    local param = {
        content = text,
        anchorPoint = cc.p(0.5, 0.5),
        --startPosition = {x = UIConst.SUMMARY_OFFSET_X_ATTR}
    }
    if #summary == 0 then
        table.insert(summary, param)
    end
    --属性飘字
    self:_addBaseAttrPromptSummary(summary)
    G_Prompt:showSummary(summary)
    --总战力
    if #summary > 0 then
        G_UserData:getAttr():recordPowerWithKey(FunctionConst.FUNC_TEAM)
        G_Prompt:playTotalPowerSummaryWithKey(FunctionConst.FUNC_TEAM, UIConst.SUMMARY_OFFSET_X_TRAIN, -5)
    end
end

--加入基础属性飘字内容
function TreasureTrainJadeLayer:_addBaseAttrPromptSummary(summary)
    local TextHelper = require("app.utils.TextHelper")
    local AttrDataHelper = require("app.utils.data.AttrDataHelper")
    local attr = TextHelper.getAttrInfoBySort(self._recordAttr:getAttr())
    local attr2 = TextHelper.getAttrInfoBySort(self._recordAttr:getLastAttr())
    for i, info in ipairs(attr2) do
        if not self:_ishaveIdInAttr(info.id, attr) then
            table.insert(attr, info)
        end
    end
    local desInfo = attr
    for i, info in ipairs(desInfo) do
        local attrId = info.id
        local diffValue = self._recordAttr:getDiffValue(attrId)
        if diffValue ~= 0 then
            local param = {
                content = AttrDataHelper.getPromptContent(attrId, diffValue),
                anchorPoint = cc.p(0.5, 0.5),
              --  startPosition = {x = UIConst.SUMMARY_OFFSET_X_ATTR}
            }
            table.insert(summary, param)
        end
    end

    return summary
end

function TreasureTrainJadeLayer:_ishaveIdInAttr(id, attr)
    for i, info in ipairs(attr) do
        if id == info.id then
            return true
        end
    end
    return false
end

function TreasureTrainJadeLayer:_initUI()
    for index = 1, TreasureConst.MAX_JADE_SLOT do
        self["_equipJadeIcon" .. index] = EquipJadeIcon.new(self["_jadeSlot" .. index], index, FunctionConst.FUNC_TREASURE_TRAIN_TYPE3)
    end
    --self._treasureAvatar:showShadow(false)
    self._textTips:setString(Lang.get("treasure_cannot_inject_jade"))
    self._parentView._buttonShow:updateLangName("treasure_jade_help_txt")

    self._parentView:changeJadeZorder(true)	
    -- 显示背景
    local bgres = Path.getJadeImg("bg_01")
    bgres = string.gsub(bgres, "png", "jpg")
    local scene = G_SceneManager:getTopScene()    
    scene:getSceneView():changeBackground(bgres)	
    -- 名字 标题
    self._fileNodeDetailTitle:setFontSize(22)
    self._fileNodeDetailTitle:setTitle(Lang.get("treasure_jade_detail_title"))
    self:_adjustScaleAndPos()
end

function TreasureTrainJadeLayer:_adjustScaleAndPos()
    self._parentView._nodeJade:setVisible(true)  	
    self._parentView._nodeDetail:setVisible(true)
    self._parentView._nodeDetail:getChildByName("_buttonShow"):setVisible(true)
    self._parentView._nodeDetail:getChildByName("_buttonPreview"):setVisible(false)

end

function TreasureTrainJadeLayer:updateInfo()
    self:_updateData()
    self:_updateView()
    self:_updateItem()
    self:_updateJadeSlot()
end

function TreasureTrainJadeLayer:_updateData()
    local treasureId = G_UserData:getTreasure():getCurTreasureId() -- 装备唯一id
    self._unitData = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
    local TreasureDataHelper = require("app.utils.data.TreasureDataHelper")
    local attrInfo = TreasureDataHelper.getTreasureJadeAttrInfo(self._unitData, G_UserData:getBase():getLevel())
    self._recordAttr:updateData(attrInfo)
end

function TreasureTrainJadeLayer:_updateView()
    local treasureBaseId = self._unitData:getBase_id()
    local treasureParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_TREASURE, treasureBaseId)

    --名字
    self._nodeTitle:setName(2)

    local heroUnitData = UserDataHelper.getHeroDataWithTreasureId(self._unitData:getId())

    -- if heroUnitData == nil then
    --     self._textFrom:setVisible(false)
    -- else
    --     local baseId = heroUnitData:getBase_id()
    --     local limitLevel = heroUnitData:getLimit_level()
    --     local limitRedLevel = heroUnitData:getLimit_rtg()
    --     self._textFrom:setVisible(true)
    --     local heroParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HERO, baseId, nil, nil, limitLevel, limitRedLevel)
    --     self._textFrom:setString(Lang.get("treasure_detail_from", {name = heroParam.name}))
    -- end
end

function TreasureTrainJadeLayer:_updateItem()
    local treasureBaseId = self._unitData:getBase_id()
    self._treasureAvatar:updateUI(treasureBaseId)

    if self._unitData:getJadeSlotNums() > 0 then
        self._nodeSlot:setVisible(true)
        self._textTips:setVisible(false)
    else
        self._nodeSlot:setVisible(false)
        self._textTips:setVisible(true)
    end
end

function TreasureTrainJadeLayer:_updateJadeSlot()
    local config = self._unitData:getConfig()
    local slotInfo = string.split(config.inlay_type, "|")
    for i = 1, #slotInfo do
        if tonumber(slotInfo[i]) == 0 then
            self["_equipJadeIcon" .. i]:lockIcon()
        else
            local jades = self._unitData:getJades()
            local jadeId = jades[i]
            self["_equipJadeIcon" .. i]:updateIcon(self._unitData:getId(), jadeId and jadeId or 0)
        end
    end
    self:_updateLvEffect()

  --[[  local config = self._unitData:getConfig()
    local slotInfo = string.split(config.inlay_type, "|")
    for i = 1, #slotInfo do
        if tonumber(slotInfo[i]) == 0 then
            self["_equipJadeIcon" .. i]:lockIcon()

            if i ~= 2 then  -- 非第二个装备位置 （提示：突破至金色....）
                local JadeTip = ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "JadeTip")
                JadeTip:getVirtualRenderer():setMaxLineWidth(18*6)     
                JadeTip:getVirtualRenderer():setLineSpacing(-2)
            end
        else
            local jades = self._unitData:getJades()
            local jadeId = jades[i]
            self["_equipJadeIcon" .. i]:updateIcon(self._unitData:getId(), jadeId and jadeId or 0)

            self._jadeSlotbg:setVisible((i == 2 and jadeId ~= 0))       -- i18n ja change
            ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "JadeName"):setFontSize(18)
            ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "ImageDesBg"):setVisible(false) 
            -- ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "ImageJade"):setScale(0.3)    -- 玉石icon缩放  暂时还有bug  不同玉石尺寸不一样
 
            if jadeId ~= 0 and i ~= 2 then  -- 存在玉石时  描述换行
                local JadeName = ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "JadeName")
                JadeName:getVirtualRenderer():setMaxLineWidth(18*6)  
                JadeName:getVirtualRenderer():setLineSpacing(-7)

                local NodeRich =  ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "NodeRich")  
                for t_index = 1, NodeRich:getChildrenCount() do 
                    NodeRich:getChildren()[t_index]:setVisible(false)
                end
                ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "Text_des"):setVisible(true)
                ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "Text_value"):setVisible(true)
                local posY = JadeName:getPositionY() - JadeName:getContentSize().height
                ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "Text_des"):setPositionY(posY - 2)
                ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "Text_value"):setPositionY(ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "Text_des"):getPositionY() - 18 )
                
            else   
                ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "Text_des"):setVisible(false)
                ccui.Helper:seekNodeByName(self["_jadeSlot" .. i], "Text_value"):setVisible(false) 
            end
        end
    end
    self:_updateLvEffect()
    ]]
end

function TreasureTrainJadeLayer:_updateLvEffect()
    self._parentView._effectNode2:removeAllChildren()
    self._parentView._effectNode3:removeAllChildren()
    if self._unitData:isFullAttrJade() then
        G_EffectGfxMgr:createPlayGfx(self._parentView._effectNode2, EFFECT_BAGUA)
    end
    if self._unitData:isFullJade() then
        G_EffectGfxMgr:createPlayMovingGfx(
            self._parentView._effectNode3,
            EFFECT_TEXING,
            nil,
            function()
            end
        )
    end
end

return TreasureTrainJadeLayer
