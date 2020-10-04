--
-- Author: JerryHe
-- Date: 2019-01-29
-- 战马图鉴Cell中的标头
local HorseKarmaCellTitle = class("HorseKarmaCellTitle")

local COLOR_ATTR = {
    cc.c3b(182,101,17),cc.c3b(47,159,7)
}

local POS_ATTR = {
    cc.p(54,219),cc.p(170,219),cc.p(54,198),cc.p(170,198)
}

local MAX_ATTR_NUM = 4

function HorseKarmaCellTitle:ctor(target, callback)
	self._target = target
	self._callback = callback

	self._textDes = nil
    self._buttonActive = nil
    
    self._attrLabelList = {}

	self:_init()
end

function HorseKarmaCellTitle:_init()
	-- self._textDes = ccui.Helper:seekNodeByName(self._target, "TextDes")
	self._buttonActive = ccui.Helper:seekNodeByName(self._target, "ButtonActive")
	cc.bind(self._buttonActive, "CommonButtonLevel2Highlight")
	self._buttonActive:setString(Lang.get("hero_karma_btn_active"))
	self._buttonActive:addClickEventListenerEx(handler(self, self._onClickButton))
    self._imageActivated = ccui.Helper:seekNodeByName(self._target, "ImageActivated")

    for i = 1, MAX_ATTR_NUM do
        local labelAttr = ccui.Helper:seekNodeByName(self._target, "TextAttr_"..i)
        -- labelAttr:setPosition(POS_ATTR[i])
        table.insert(self._attrLabelList,labelAttr)
        labelAttr:setVisible(false)
    end

    if not Lang.checkLang(Lang.CN) then
        self:_createLabelByI18n()
    end
    if not Lang.checkLang(Lang.CN) then
		self:_dealPosI18n()
	end
end

function HorseKarmaCellTitle:setDes(desInfo, isActivated, isCanActivate, attrId)
    -- self._textDes:setString(des)

	if isActivated then
		self._imageActivated:setVisible(true)
		self._buttonActive:setVisible(false)
	else
		self._imageActivated:setVisible(false)
		self._buttonActive:setVisible(true)
		self._buttonActive:setEnabled(isCanActivate)
    end
    
    self:_setAttrColor(isActivated)
    self:_setAttrDesc(desInfo)
end

function HorseKarmaCellTitle:_setAttrColor(isActivated)
    local color = COLOR_ATTR[1]          --非激活状态
    if isActivated then
        color = COLOR_ATTR[2]            --已激活状态
    end
    for i, labelAttr in ipairs(self._attrLabelList) do
        labelAttr:setColor(color)
    end
end

function HorseKarmaCellTitle:_setAttrDesc(desInfo)
    for i, labelAttr in ipairs(self._attrLabelList) do
        if desInfo[i] then
            labelAttr:setVisible(true)
            labelAttr:setString(desInfo[i])
        end
    end
    if Lang.checkChannel(Lang.CHANNEL_SEA) then
        local line = ccui.Helper:seekNodeByName(self._target, "Image_7")
		line:setVisible(not self._attrLabelList[4]:isVisible())
	end
end

function HorseKarmaCellTitle:_onClickButton()
	if self._callback then
		self._callback()
	end
end

-- i18n change lable
function HorseKarmaCellTitle:_createLabelByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local size = self._imageActivated:getContentSize()
		local label = UIHelper.createLabel({
			style = "fetter_1",
			text = Lang.getImgText("img_fatter_yijihuo") ,
			position = cc.p(size.width * 0.5,20),
		})
		self._imageActivated:addChild(label)
	end
end

-- i18n pos lable
function HorseKarmaCellTitle:_dealPosI18n()
	if not Lang.checkLang(Lang.CN)  then
		local UIHelper  = require("yoka.utils.UIHelper")
        self._buttonActive:setPositionY(self._buttonActive:getPositionY())	
        
        for i = 1, MAX_ATTR_NUM do
            local textAttr = UIHelper.seekNodeByName(self._target,"TextAttr_"..i)
            textAttr:setPositionX(textAttr:getPositionX()+22)
        end
      
            
            
    end
    
    if Lang.checkChannel(Lang.CHANNEL_SEA) then
		local posX = self._attrLabelList[1]:getPositionX()+30
		self._attrLabelList[1]:setPositionX(posX)
		self._attrLabelList[2]:setPositionX(posX+100)
		self._attrLabelList[3]:setPositionX(posX)
		self._attrLabelList[4]:setPosition(posX,self._attrLabelList[3]:getPositionY()-19)
    end
    
    if Lang.checkLang(Lang.ENID) then
         local posX = self._attrLabelList[1]:getPositionX()
         --local  width  = self._attrLabelList[1]:getVirtualRendererSize().width
		-- self._attrLabelList[1]:setPositionX(posX)
		self._attrLabelList[2]:setPositionX(posX+115)
		-- self._attrLabelList[3]:setPositionX(posX)
		-- self._attrLabelList[4]:setPosition(posX,self._attrLabelList[3]:getPositionY()-19)
    end
end

return HorseKarmaCellTitle