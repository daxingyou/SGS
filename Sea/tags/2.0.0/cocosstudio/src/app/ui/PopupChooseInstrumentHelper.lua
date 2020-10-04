--
-- Author: Liangxu
-- Date: 2017-9-15 10:10:14
-- 选择神兵帮助类
local PopupChooseInstrumentHelper = {}
local UserDataHelper = require("app.utils.UserDataHelper")
local TextHelper = require("app.utils.TextHelper")
local InstrumentDataHelper = require("app.utils.data.InstrumentDataHelper")

PopupChooseInstrumentHelper.FROM_TYPE1 = 1 --穿戴 “+”点进来
PopupChooseInstrumentHelper.FROM_TYPE2 = 2 --更换 Icon点进来
PopupChooseInstrumentHelper.FROM_TYPE3 = 3 --重生神兵 点进来
PopupChooseInstrumentHelper.FROM_TYPE4 = 4 --从“神兵置换”点进来

local BTN_DES = {
	[1] = "instrument_btn_wear",
	[2] = "instrument_btn_replace",
	[3] = "reborn_list_btn",
	[4] = "reborn_list_btn",
}

function PopupChooseInstrumentHelper.addInstrumentDataDesc(instrumentData, fromType)
	if instrumentData == nil then
		return nil
	end
	
	local heroBaseId = UserDataHelper.getHeroBaseIdWithInstrumentId(instrumentData:getId())
	local cellData = clone(instrumentData)
	cellData.heroBaseId = heroBaseId
	cellData.btnDesc = Lang.get(BTN_DES[fromType])

	return cellData
end

function PopupChooseInstrumentHelper._FROM_TYPE1(data)
	return data
end

function PopupChooseInstrumentHelper._FROM_TYPE2(data)
	return data
end

function PopupChooseInstrumentHelper._FROM_TYPE3(data)
	return G_UserData:getInstrument():getRebornList()
end

function PopupChooseInstrumentHelper._FROM_TYPE4(param)
	local filterIds, tempData = unpack(param)
	local heroData = InstrumentDataHelper.getInstrumentTransformTarList(filterIds, tempData)
	return heroData
end

return PopupChooseInstrumentHelper