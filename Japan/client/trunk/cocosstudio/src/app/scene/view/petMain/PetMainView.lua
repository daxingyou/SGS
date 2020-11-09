--
-- Author: hedili
-- Date: 2018-01-23 13:32:07
-- 神兽之家
local ViewBase = require("app.ui.ViewBase")
local PetMainView = class("PetMainView", ViewBase)
local PetListCell = require("app.scene.view.pet.PetListCell")
local PetFragListCell = require("app.scene.view.pet.PetFragListCell")

local UIPopupHelper = require("app.utils.UIPopupHelper")
local TypeConvertHelper = require("app.utils.TypeConvertHelper")
local UserDataHelper = require("app.utils.UserDataHelper")
local FUNC_ID_LIST = {
	FunctionConst.FUNC_PET_LIST,
	FunctionConst.FUNC_PET_SHOP,
	--FunctionConst.FUNC_PET_TRAIN_TYPE1,
	--FunctionConst.FUNC_PET_TRAIN_TYPE2,
	FunctionConst.FUNC_PET_HAND_BOOK,
	FunctionConst.FUNC_PET_HELP,
}
function PetMainView:ctor(index)
	self._fileNodeEmpty = nil --空置控件
	local PetConst = require("app.const.PetConst")
	self._selectTabIndex = index or PetConst.PET_LIST_TYPE1

	local resource = {
		file = Path.getCSB("PetMainView", "pet"),
		size = G_ResolutionManager:getDesignSize(),
		binding = {
			
		},
	}
	PetMainView.super.ctor(self, resource,109)
end

function PetMainView:onCreate()
	self._topbarBase:setImageTitle("txt_sys_com_shenshou")
	local TopBarStyleConst = require("app.const.TopBarStyleConst")
	self._topbarBase:updateUI(TopBarStyleConst.STYLE_COMMON)

	for i=1, 4 do
		self["_funcIcon"..i]:updateUI(FUNC_ID_LIST[i])
		self["_funcIcon"..i]:addClickEventListenerEx(handler(self, self._onButtonClick))
		
		-- i18n ja
		if Lang.checkUI("ui4") and i == 4 then  
			local str = self["_funcIcon"..i]:getTextImage():getString() 
			str = string.gsub(str, "出陣", "出陣\n")
			self["_funcIcon"..i]:getTextImage():setString(str) 
		end
	end
	-- i18n ja
	if Lang.checkUI("ui4") then
		self._funcIcon5:updateUI(FunctionConst.FUNC_RED_PET)
		self._funcIcon5:addClickEventListenerEx(handler(self, self._onButtonClick))

		local visible, customData = self:_getRedPetVisibleAndCustomData()
		self._funcIcon5:setVisible(visible)
        if customData then
            if customData.callFunc then
                customData.callFunc(self._funcIcon5)
            end
		end
	end

	-- i18n ja pos
	self:_dealPosByI18n()

	local PetConst = require("app.const.PetConst")
	local PetMainAvatorsNode = require("app.scene.view.petMain.PetMainAvatorsNode")

    local showNum = G_UserData:getPet():getShowPetNum()
	local mainAvatorsNode = {}
    if showNum <= PetConst.SCROLL_AVATART_NUM  then
		 mainAvatorsNode = PetMainAvatorsNode.new(
			PetConst.SCROLL_SIZE,
			PetConst.ANGLE_CONTENT,
			PetConst.START_INDEX, 
			self, 
			PetConst.ANGLE_OFFSET,
			PetConst.CIRCLE,
			PetConst.SCALE_RANGE)
		mainAvatorsNode:setPosition(PetConst.SCROLL_POSITION)
	else
		local petInfo = PetConst["PET_INFO"..showNum]
		
		 mainAvatorsNode = PetMainAvatorsNode.new(
			petInfo.SCROLL_SIZE,
			petInfo.ANGLE_CONTENT,
			petInfo.START_INDEX, 
			self, 
			petInfo.ANGLE_OFFSET,
			petInfo.CIRCLE,
			petInfo.SCALE_RANGE)
		mainAvatorsNode:setPosition(petInfo.SCROLL_POSITION)
	end


	mainAvatorsNode:setName("PetMainAvatorsNode")


	--local offset = (display.width - PetConst.SCROLL_SIZE.width)* 0.5
	--mainAvatorsNode:setPositionX(offset)

	local groundNode = self:getGroundNode()
	groundNode:addChild(mainAvatorsNode)
	

end

function PetMainView:onEnter()
	self:_onEventRedPointUpdate()

	if Lang.checkUI("ui4") then
		self._signalRedPointUpdate =
        G_SignalManager:add(SignalConst.EVENT_RED_POINT_UPDATE, handler(self, self._onEventRedPointUpdate))
	end
end


function PetMainView:_onEventRedPointUpdate(event,funcId,param)
	self:_refreshRedPoint()
end

function PetMainView:_refreshRedPoint()

	local function checkShopRedPoint( funcNode )
		--dump(funcNode:getFuncId())
		
		if funcNode:getFuncId() == FunctionConst.FUNC_PET_SHOP then
			local RedPointHelper = require("app.data.RedPointHelper")
			local redValue = RedPointHelper.isModuleSubReach( FunctionConst.FUNC_SHOP_SCENE, "petShop" )
			funcNode:showRedPoint(redValue)
		end

		if funcNode:getFuncId() == FunctionConst.FUNC_PET_LIST then
			local redValue = G_UserData:getFragments():hasRedPoint({fragType = TypeConvertHelper.TYPE_PET}) --是否有神兽合成
			funcNode:showRedPoint(redValue)
		end

		if funcNode:getFuncId() == FunctionConst.FUNC_PET_HAND_BOOK then
			local RedPointHelper = require("app.data.RedPointHelper")
			local redValue =RedPointHelper.isModuleSubReach(FunctionConst.FUNC_PET_HOME, "petMapRP")
			funcNode:showRedPoint(redValue)
		end
	end

	for i=1, 4 do
		local funcNode =  self["_funcIcon"..i]
		checkShopRedPoint(funcNode)
	end
	if Lang.checkUI("ui4") then
		self:_updateRedPetRedPoint()
	end
end

function PetMainView:onExit()
	if Lang.checkUI("ui4") then
		self._signalRedPointUpdate:remove()
		self._signalRedPointUpdate = nil
	end
end

function PetMainView:_onButtonClick( sender )

	local funcId =  sender:getTag()
	if funcId > 0 then
		 local WayFuncDataHelper = require("app.utils.data.WayFuncDataHelper")
	    WayFuncDataHelper.gotoModuleByFuncId(funcId)
	end
end

-- i18n ja qiling start
function PetMainView:_getRedPetVisibleAndCustomData()
    local FunctionCheck = require("app.utils.logic.FunctionCheck")
    local isOpen = FunctionCheck.funcIsOpened(FunctionConst.FUNC_RED_PET)
    if not isOpen then
        return false
    end
    
    local customData = {}
    local isVisible, callFunc = self:_getVisibleAndCountDownCallbackForRedPet()
    if isVisible then
        customData.callFunc = callFunc
        return true, customData
    end
    return false, customData
end

function PetMainView:_getVisibleAndCountDownCallbackForRedPet()
    local isVisible = G_UserData:getRedPetData():isActivityOpen()
    local callBack = function(menuBtn, menuData)
        menuBtn:removeCustomLabel()
        menuBtn:playBtnMoving()
        menuBtn:playFuncGfx()
    end

    return isVisible, callBack
end

function PetMainView:_updateRedPetRedPoint()
	local RedPointHelper = require("app.data.RedPointHelper")
	local valueBool = RedPointHelper.isModuleReach(FunctionConst.FUNC_RED_PET)
	self._funcIcon5:getSubNodeByName("RedPoint"):setVisible(valueBool)
end

-- i18n ja qiling end

-- i18n ja pos
function PetMainView:_dealPosByI18n()
	if Lang.checkLang(Lang.JA) then
		local posDeltaY = 105
		self._funcIcon2:setPosition(self._funcIcon4:getPosition())
		-- 祈灵开不开启
		local visible, customData = self:_getRedPetVisibleAndCustomData()
		if visible then
			self._funcIcon5:setPosition(self._funcIcon4:getPosition(), self._funcIcon2:getPositionY() - posDeltaY)
			self._funcIcon1:setPosition(self._funcIcon4:getPosition(), self._funcIcon5:getPositionY() - posDeltaY)
		else
			self._funcIcon1:setPosition(self._funcIcon4:getPosition(), self._funcIcon2:getPositionY() - posDeltaY)
		end
		self._funcIcon3:setPosition(self._funcIcon4:getPosition(), self._funcIcon1:getPositionY() - posDeltaY)
		self._funcIcon4:setPosition(self._funcIcon4:getPosition(), self._funcIcon3:getPositionY() - posDeltaY)
	end
	
end

return PetMainView
