local HomelandPrayHandbookNode = class("HomelandPrayHandbookNode")
local HomelandConst = require("app.const.HomelandConst")
local HomelandHelp = require("app.scene.view.homeland.HomelandHelp")

function HomelandPrayHandbookNode:ctor(target)
    self._target = target
    
    self._imageEmpty = ccui.Helper:seekNodeByName(self._target, "ImageEmpty")
    self._imageBg = ccui.Helper:seekNodeByName(self._target, "ImageBg")
    self._textColor = ccui.Helper:seekNodeByName(self._target, "TextColor")
    self._textName = ccui.Helper:seekNodeByName(self._target, "TextName")
    self._textTime = ccui.Helper:seekNodeByName(self._target, "TextTime")
    self._nodeDes = ccui.Helper:seekNodeByName(self._target, "NodeDes")
    
    if not Lang.checkLang(Lang.CN) then
        self:_dealLabelByI18n()
    end
    
end

function HomelandPrayHandbookNode:updateUI(data)
    if data.isHave then
        self._imageEmpty:setVisible(false)
        self._imageBg:setVisible(true)
        local info = data.cfg
        if  Lang.checkLang(Lang.CN) then
            self._textColor:setString(info.color_text)
        elseif Lang.checkUI("ui4") then -- i18n ja change
            --self._textColor:getVirtualRenderer():setMaxLineWidth(self._textColor:getFontSize()) 
            local UTF8 = require("app.utils.UTF8")
            local strContent = ""
            local len = UTF8.utf8len(info.color_text)
            for i=1, len do  
                local strEle = UTF8.utf8sub(info.color_text, i, i)
                if i ~= len then
                    strEle = strEle .. "\n"
                end
                strContent = strContent .. strEle
            end
            self._textColor:getVirtualRenderer():setLineSpacing(-7)
            self._textColor:setString(strContent)
        else      
            local UIHelper  = require("yoka.utils.UIHelper")	
            UIHelper.dealVTextWidget(self._textColor,info.color_text)
        end

   
    
        self._textName:setString(info.name)
        local strTime = ""
        if info.type == HomelandConst.TREE_BUFF_TYPE_3 then
            strTime = Lang.get("homeland_buff_duration")
        end
        self._textTime:setString(strTime)

        local template = string.gsub(info.description, "#%w+#", "$c103_%1$")
        local value = HomelandHelp.getValueOfBuff(info.value, info.equation)
	    local times = HomelandHelp.getTimesOfBuff(info.times, info.type)
        local formatStr = Lang.getTxt(template, {value = value, times = times})
        local params = {defaultColor = Colors.NORMAL_BG_ONE, defaultSize = 20}
        if  not Lang.checkLang(Lang.CN) then
            params = {defaultColor = Colors.NORMAL_BG_ONE, defaultSize = 18}
        end
        if Lang.checkUI("ui4") then -- i18n ja change
            params = {defaultColor = Colors.NORMAL_BG_ONE, defaultSize = 16}
        end
        local richText = ccui.RichText:createRichTextByFormatString(formatStr, params)
        richText:setAnchorPoint(cc.p(0, 1))
        richText:ignoreContentAdaptWithSize(false)
        richText:setContentSize(cc.size(200,0))
        richText:formatText()
        self._nodeDes:removeAllChildren()
        self._nodeDes:addChild(richText)
    else
        self._imageEmpty:setVisible(true)
        self._imageBg:setVisible(false)
    end
end

-- i18n change lable
function HomelandPrayHandbookNode:_dealLabelByI18n()

	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")	
		local size = self._textColor:getContentSize()
		self._textColor:setContentSize(cc.size(130,size.height))
		self._textColor:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
        self._textColor:setPositionX(self._textColor:getPositionX()+2)

        
        UIHelper.setLabelStyle(self._textColor,{
            style = "homeland_7",
            fontSize = 18
         })


        local image_75 = UIHelper.seekNodeByName(self._target,"Image_75")
        image_75:setPositionX(image_75:getPositionX()+10)

        self._textName:setPositionX(self._textName:getPositionX()+15)
        self._nodeDes:setPositionX(self._nodeDes:getPositionX()+15)

        self._textTime:setAnchorPoint(cc.p(1,0.5))
        self._textTime:setPositionX(self._textTime:getPositionX()+55)

        self._textTime:setFontSize(self._textTime:getFontSize()-2)
        self._textName:setFontSize(self._textName:getFontSize()-2)
	end

    if Lang.checkUI("ui4") then -- i18n ja change
        self._textTime:setFontSize(self._textTime:getFontSize()-4)
        self._textName:setFontSize(self._textName:getFontSize()-4)
        self._textColor:setFontSize(self._textColor:getFontSize()-2)
    end
end



return HomelandPrayHandbookNode