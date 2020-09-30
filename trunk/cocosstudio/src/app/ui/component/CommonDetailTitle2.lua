-- i18n ja 装备 神兵 宝物 战马  神兽通用标题
-- Author: Liangxu
-- Date: 2020-07-21 13:46:28
-- 通用详情标题控件
local CommonDetailTitle = class("CommonDetailTitle")
local UIHelper = require("yoka.utils.UIHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")

local EXPORTED_METHODS = {
    "setTitle",
    "setTitleColor",
    "setTitleOutLine",
    "setFontSize",
    "setFontName",
    "setFontImageBgSize",
    "setTitleAndAdjustBgSize",
    "setImageBaseSize",
    "setName",
    "showTextBg"
}

CommonDetailTitle.EQUIP = 1
CommonDetailTitle.TREASURE = 2
CommonDetailTitle.INSTRUMENT = 3
CommonDetailTitle.HORSE = 4
CommonDetailTitle.PET = 5
function CommonDetailTitle:ctor()
	self._target = nil
end

function CommonDetailTitle:_init()
	self._textTitle = ccui.Helper:seekNodeByName(self._target, "TextTitle")
    self._imageBase = ccui.Helper:seekNodeByName(self._target, "ImageBase")
end

function CommonDetailTitle:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonDetailTitle:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonDetailTitle:setName(type)
    if type == CommonDetailTitle.EQUIP then
        local equipid = G_UserData:getEquipment():getCurEquipId() -- 装备唯一id
        local equipData =  G_UserData:getEquipment():getEquipmentDataWithId(equipid)
        local equipBaseId = equipData:getBase_id()
        local equipParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_EQUIPMENT, equipBaseId) 
        local equipName = equipParam.name
        local rLevel = equipData:getR_level()
        if rLevel > 0 then
            equipName = equipName .. "+" .. rLevel
        end
        self._textTitle:setString(equipName)
        self._textTitle:setColor(equipParam.icon_color)

        if equipParam.cfg.color == 7 then    -- 金色物品加描边
            self._textTitle:enableOutline(equipParam.icon_color_outline, 2)
        else
            self._textTitle:disableEffect(cc.LabelEffect.OUTLINE)
        end
    elseif type == CommonDetailTitle.TREASURE then
        local treasureId = G_UserData:getTreasure():getCurTreasureId()  
        local treasureData = G_UserData:getTreasure():getTreasureDataWithId(treasureId)
        local treasureBaseId = treasureData:getBase_id()
        local treasureParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_TREASURE, treasureBaseId)
        local treasureName = treasureParam.name
        local rLevel = treasureData:getRefine_level()
        if rLevel > 0 then
            treasureName = treasureName.."+"..rLevel
        end
        self._textTitle:setString(treasureName)
        self._textTitle:setColor(treasureParam.icon_color)

        UIHelper.updateTextOutline(self._textTitle, treasureParam)
    elseif type == CommonDetailTitle.INSTRUMENT then
        local instrumentId =  G_UserData:getInstrument():getCurInstrumentId()
        local instrumentData = G_UserData:getInstrument():getInstrumentDataWithId(instrumentId)
        local instrumentBaseId = instrumentData:getBase_id()
        local limitLevel = instrumentData:getLimit_level()
        local instrumentParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_INSTRUMENT, instrumentBaseId, nil, nil, limitLevel)
        local instrumentName = instrumentParam.name
        local level = instrumentData:getLevel()
        if level > 0 then
            instrumentName = instrumentName.."+"..level
        end
        self._textTitle:setString(instrumentName)
        self._textTitle:setColor(instrumentParam.icon_color)
        UIHelper.updateTextOutline(self._textTitle, instrumentParam)
    elseif type == CommonDetailTitle.HORSE then    
        local HorseDataHelper = require("app.utils.data.HorseDataHelper")
        local curHorseId = G_UserData:getHorse():getCurHorseId() 
        local horseData = G_UserData:getHorse():getUnitDataWithId(curHorseId)
        local horseBaseId = horseData:getBase_id()
        local star = horseData:getStar()
        local horseParam = TypeConvertHelper.convert(TypeConvertHelper.TYPE_HORSE, horseBaseId)
        local horseName = HorseDataHelper.getHorseName(horseBaseId, star) 
        self._textTitle:setString(horseName) 
        self._textTitle:setColor(horseParam.icon_color)  
 
        UIHelper.updateTextOutline(self._textTitle, horseParam)
    elseif type == CommonDetailTitle.PET then   
        local petId = G_UserData:getPet():getCurPetId()
        local petUnitData = G_UserData:getPet():getUnitDataWithId(petId)
        -- local config = petUnitData:getConfig()
        -- local petBaseId = config.potential_after > 0 and config.potential_after or config.id
        local petBaseId = petUnitData:getBase_id()
        local param = TypeConvertHelper.convert(TypeConvertHelper.TYPE_PET, petBaseId) 
        self._textTitle:setString(param.name) 
        self._textTitle:setColor(param.icon_color)  

        UIHelper.updateTextOutline(self._textTitle, param)
    end
end

function CommonDetailTitle:setTitleAndAdjustBgSize(title)
	self._textTitle:setString(title)
    local size = self._textTitle:getContentSize()
    local imageBaseSize = self._imageBase:getContentSize()
    self._imageBase:setContentSize(cc.size(size.width + 110, imageBaseSize.height))
end

function CommonDetailTitle:setTitle(title)
	self._textTitle:setString(title)
end

function CommonDetailTitle:setTitleColor(color)
	self._textTitle:setColor(color)
end

function CommonDetailTitle:setTitleOutLine(color)
	self._textTitle:enableOutline(color, 2)
end

function CommonDetailTitle:setFontSize(size)
	self._textTitle:setFontSize(size)
end

function CommonDetailTitle:setFontName(fontName)
	self._textTitle:setFontName(fontName)
end

function CommonDetailTitle:setFontImageBgSize(size)
    self._imageBase:setContentSize(size)
end

function CommonDetailTitle:setImageBaseSize(size)
    self._imageBase:setContentSize(size)
end

function CommonDetailTitle:showTextBg(bShow)
    self._imageBase:setVisible(bShow)
end


return CommonDetailTitle
