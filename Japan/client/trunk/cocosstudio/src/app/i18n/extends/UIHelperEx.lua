
local UIHelperEx = require("yoka.utils.UIHelper")
local TypeConst = require("app.i18n.utils.TypeConst")
--创建BMFLabel
function UIHelperEx.createBMFLabel(param)
    if param.fontName and not Path.isExist(param.fontName)  then
        local _,_,imagePath,subImageName,subImageExt = string.find(param.fontName, "(.+/)(.-)(%..+)")
        logWarn("createBMFLabel "..subImageName.."  "..subImageExt)
        param.style = "effect_fnt_"..subImageName
        param.styleType = TypeConst.EFFECT 
        local label = UIHelperEx.createLabel(param)
        if param.lineSpacing ~= nil then
            label:getVirtualRenderer():setLineSpacing(param.lineSpacing)
        end
        
        if param.width ~= nil then
            label:getVirtualRenderer():setWidth(param.width)
        end

        return label
    end
    local fontPath = param.fontName or Path.getImgFont("skill")
    local text = param.text or ""
	local uiText = ccui.TextBMFont:create(text, fontPath)
    local renderLabel = uiText:getVirtualRenderer()

    if param.fontSize ~= nil then
        renderLabel:setBMFontSize(param.fontSize)
    end

    if param.h_align ~= nil then
        renderLabel:setHorizontalAlignment(param.h_align)
    end

    if param.v_align ~= nil then
        renderLabel:setVerticalAlignment(param.v_align)
    end

    if param.lineSpacing ~= nil then
        renderLabel:setLineSpacing(param.lineSpacing)
    end
    
    if param.width ~= nil then
        renderLabel:setWidth(param.width)
    end

    UIHelperEx.updateNodeInfo(uiText,param)
    return uiText
end

-- ["activity_limit_2"] = { typeConst = TypeConst.FONT_TITLE, size = 22, outlineSize = 1, color = cc.c3b(0xf3, 0xc9, 0x22), outlineColor =  cc.c3b(0x0c, 0x03, 0x4f)},         --活动夜观星象 黄字

UIHelperEx._createLabel = UIHelperEx.createLabel

--创建Label
function UIHelperEx.createLabel(param)
    local styleName = param.style or nil
    local fontSize = param.fontSize or 22
    local fontPath = param.fontName or Path.getCommonFont()
    local color = param.color or nil
    local outlineColor =  param.outlineColor or nil
    local outlineSize =  param.outlineSize or nil
    local h_align =  param.h_align or nil
    local v_align =  param.v_align or nil
    local text = param.text or ""
    local style = nil
    -- print("  UIHelperEx.createLabel  styleName: " .. styleName)
    if styleName then
        local styleType = param.styleType or nil
        -- print("  UIHelperEx.createLabel  styleType: " .. styleType)
        style = Colors.getStyle(styleName,styleType)
    end
    if style  then
        dump(style,"----------style-------------")
        fontSize = style["size"]
        outlineSize = style["outlineSize"]
        color = style["color"]
        outlineColor = style["outlineColor"]
        local fontType = style["typeConst"]
        if fontType == TypeConst.FONT_TITLE then
            fontPath = Path.getFontW8()
        elseif fontType == TypeConst.FONT_NORMAL then
            fontPath = Path.getCommonFont()
        else
            fontPath = Path.getFont(fontType)
        end
    end
  
    if param.fontSize then
        fontSize =  param.fontSize
    end


	local uiText = ccui.Text:create(text, fontPath, fontSize)

    -- cc.TEXT_ALIGNMENT_CENTER = 0x1
    -- cc.TEXT_ALIGNMENT_LEFT  = 0x0
    -- cc.TEXT_ALIGNMENT_RIGHT = 0x2   
    if h_align ~= nil then
        -- local renderLabel = uiText:getVirtualRenderer()
        uiText:setTextHorizontalAlignment(h_align)
    end

    if v_align ~= nil then
        -- cc.TEXT_ALIGNMENT_CENTER
        -- local renderLabel = uiText:getVirtualRenderer()
        uiText:setTextVerticalAlignment(v_align)
    end

    if color ~= nil then
        uiText:setColor(color)
    end
--[[
    if outlineSize ~= nil and outlineSize > 0 then
        uiText:enableOutline(outlineColor, outlineSize or 2)
    end
]]
    if outlineColor ~= nil then
         uiText:enableOutline(outlineColor, outlineSize or 2)
    end


    UIHelperEx.updateNodeInfo(uiText,param)
    return uiText
end

--交换为Label对象 文本对象
function UIHelperEx.swapWithLabel(source,param,copyChildren)
    -- local label = UIHelperEx.createLabel({style=param.style or "text_quality_2"})
    local label = UIHelperEx.createLabel(param)
    local sourceParent = source:getParent()
    source:setVisible(false)
    label:setPosition( source:getPosition() )
    if param.offsetX ~= nil then
        local posX = source:getPositionX()
        label:setPositionX(posX+param.offsetX)
    end
    if param.offsetY ~= nil then
        local posY = source:getPositionY()
        label:setPositionY(posY+param.offsetY)
    end
    label:setAnchorPoint( source:getAnchorPoint() )
    if param.anchorPoint ~= nil then
        label:setAnchorPoint( param.anchorPoint )
    end
    label:setLocalZOrder( source:getLocalZOrder() )
    label:setName(source:getName())

    if copyChildren then
        local children = source:getChildren()
		for k,v in ipairs(children) do
			v:retain()
        end
        for k,v in ipairs(children) do
			v:removeFromParent()
			label:addChild(v)
			v:release()
		end
    end
    
    sourceParent:removeChild(source)
    sourceParent:addChild(label)

  

    return label
end

--交换为Label对象 字体
function UIHelperEx.swapWithBMFLabel(source,param)
    -- local label = UIHelperEx.createLabel({style=param.style or "text_quality_2"})
    local text = param.text or ""
    local fontName = Path.getImgFont(param.fontName) or nil
    local fontSize = param.fontSize or nil
    -- local label = UIHelperEx.createBMFLabel({text=text,fontName=fontName,fontSize=fontSize})
    local label = UIHelperEx.createBMFLabel(param)
    local sourceParent = source:getParent()
    source:setVisible(false)
    label:setPosition( source:getPosition() )
    if param.offsetX ~= nil then
        local posX = source:getPositionX()
        label:setPositionX(posX+param.offsetX)
    end
    if param.offsetY ~= nil then
        local posY = source:getPositionY()
        label:setPositionY(posY+param.offsetY)
    end
    label:setAnchorPoint( source:getAnchorPoint() )
    if param.anchorPoint ~= nil then
        label:setAnchorPoint( param.anchorPoint )
    end
    label:setLocalZOrder( source:getLocalZOrder() )
    label:setName(source:getName())
    sourceParent:removeChild(source)
    sourceParent:addChild(label)
    return label
end

--交换对象
function UIHelperEx.swap(source,param)
    if not param.typeConst or  param.typeConst == "label" then
       return  UIHelperEx.swapWithLabel(source,param)
    end
    if param.typeConst == "BMFlabel" then
       return  UIHelperEx.swapWithBMFLabel(source,param)
    end
end

--重置label 样式
function UIHelperEx.setLabelStyle(label,param)
    local styleName = param.style or nil
    local fontSize = param.fontSize or nil
    local fontPath = param.fontName or nil
    local color = param.color or nil
    local outlineColor =  param.outlineColor or nil
    local outlineSize =  param.outlineSize or nil
    local text = param.text or ""
    local style = nil
    if styleName then
        style = Colors.getStyle(styleName)
    end
    if style  then
        dump(style,"setLabelStyle style:")
        fontSize = style["size"]
        outlineSize = style["outlineSize"]
        color = style["color"]
        outlineColor = style["outlineColor"]
        local fontType = style["typeConst"]
        if fontType == TypeConst.FONT_TITLE then
            fontPath = Path.getFontW8()
        elseif fontType == TypeConst.FONT_NORMAL then
            fontPath = Path.getCommonFont()
        else
            fontPath = Path.getFont(fontType)
        end
    end

    if param.fontSize then
        fontSize =  param.fontSize
    end

    if fontPath ~= nil then label:setFontName(fontPath) end
    if fontSize ~= nil then label:setFontSize(fontSize) end
    if color ~= nil then  label:setColor(color) end

    if outlineColor ~= nil then
         label:enableOutline(outlineColor, outlineSize or 2)
    else
         label:disableEffect(cc.LabelEffect.OUTLINE)     
    end

    
    label:setString(text)

    UIHelperEx.updateNodeInfo(label,param)

end

function UIHelperEx.seekNodeListByName(node,name,list)
    if not node or not name or not list then
        return 
    end
    if node:getName() == name then
        table.insert(list, node)
    end
    
    for k,v in ipairs(node:getChildren()) do
        UIHelperEx.seekNodeListByName(v,name,list)
    end
end


function UIHelperEx.seekNodeByNameEx(node,name)
    if not node or not name then
        return nil
    end
    
    for k,v in ipairs(node:getChildren()) do
        if v:getName() == name then
            return v
        end
    end
    
    for k,v in ipairs(node:getChildren()) do
        local target =  UIHelperEx.seekNodeByNameEx(v,name)
        if target then
            return target
        end
    end
    
    return nil
end


function UIHelperEx.seekNodeByName(node,...)
    local param = {...}
    for k,v in ipairs(param) do
        if v then
           node = UIHelperEx.seekNodeByNameEx(node,v)--ccui.Helper:seekNodeByName(node, v)
           if not node then
              return nil
           end
        end
    end
    return node
end

function UIHelperEx.seekNodeByTag(node,tag)
--[[
    local children = node:getChildren()
    for k,v in ipairs(children) do
        if v:getTag() == tag then
            return v
        end
        local result = UIHelperEx.seekNodeByTag(v,tag)
        if result then
            return result
        end
    end
]]
    if not node or not tag then
        return nil
    end
    for k,v in ipairs(node:getChildren()) do
        if v:getTag() == tag then
            return v
        end
    end
    
    for k,v in ipairs(node:getChildren()) do
        local target =  UIHelperEx.seekNodeByTag(v,tag)
        if target then
            return target
        end
    end
    
    return nil

end


function UIHelperEx.seekNodeByTagList(node,...)
    local param = {...}
    for k,v in ipairs(param) do
        if v then
           node = UIHelperEx.seekNodeByTag(node,v)
           if not node then
              return nil
           end
        end
    end
    return node
end

function UIHelperEx.swapSignImage(source,labelParam,filePath)

    local image = cc.Sprite:create(filePath)
    if not image then return source end
	image:setPosition(source:getPosition() )
	image:setAnchorPoint( source:getAnchorPoint() )
	image:setLocalZOrder( source:getLocalZOrder() )
	image:setName(source:getName())
    image:setVisible(source:isVisible())
	
	local label = UIHelperEx.createLabel(labelParam)
	image:addChild(label)
	
	if labelParam.anchorPoint then
        label:setAnchorPoint(labelParam.anchorPoint)
    end
    if labelParam.position then
        label:setPosition(labelParam.position.x, labelParam.position.y)
	else
		local size = image:getContentSize()
		label:setPosition(size.width * 0.5 ,size.height * 0.5)
    end

	 if labelParam.rotation then
        label:setRotation(labelParam.rotation)
    end

	source:setVisible(false)
	local sourceParent = source:getParent()
	sourceParent:removeChild(source)
    sourceParent:addChild(image)


    return image
end


function UIHelperEx.createSignImage(labelParam,filePath)

	local image = cc.Sprite:create(filePath)

	
	local label = UIHelperEx.createLabel(labelParam)
	image:addChild(label)
	
	if labelParam.anchorPoint then
        label:setAnchorPoint(labelParam.anchorPoint)
    end
    if labelParam.position then
        label:setPosition(labelParam.position.x, labelParam.position.y)
	else
		local size = image:getContentSize()
		label:setPosition(size.width * 0.5 ,size.height * 0.5)
    end

	 if labelParam.rotation then
        label:setRotation(labelParam.rotation)
    end



    return image
end




function UIHelperEx.setSignStyle(image,labelParam,filePath)
    if filePath then
        image:setTexture(filePath)
    end
    
	local label = image:getChildren()[1]
    --UIHelperEx.updateNodeInfo(label,labelParam)
    UIHelperEx.setLabelStyle(label,labelParam)

	 if labelParam.rotation then
        label:setRotation(labelParam.rotation)
    end
end


function UIHelperEx.swapWithRichText(source,json)
    -- i18n RichText
    local label = nil
    if Lang.checkLang(Lang.CN) then
        label = ccui.RichText:create()
    else
        label = ccui.RichText:createByI18n()         
    end
    label:setRichTextWithJson(json)

	label:setPosition(source:getPosition() )
	label:setAnchorPoint( source:getAnchorPoint() )
	label:setLocalZOrder( source:getLocalZOrder() )
	label:setName(source:getName())

	source:setVisible(false)
	local sourceParent = source:getParent()
	sourceParent:removeChild(source)
    sourceParent:addChild(label)


    return label
end


function UIHelperEx.dealVText(txt)
    if Lang.checkLang(Lang.ZH) then
        return txt
    else
        txt = string.gsub( txt, " ", "\n")
        -- if Lang.checkLang(Lang.EN) then
        --     txt = string.gsub( txt, "\x01", " ")
        -- end
        return txt
    end
    
end

--
function UIHelperEx.dealVTextWidget(node,txt)
    if Lang.checkLang(Lang.JA) or Lang.checkLang(Lang.ZH) then -- i18n ja change
        node:setString(txt)
    else
        local size = node:getContentSize()
        node:setContentSize(cc.size(200,size.height))
        txt = string.gsub( txt, " ", "\n")
        -- if Lang.checkLang(Lang.EN) then
        --     txt = string.gsub( txt, "\x01", " ")
        -- end
        node:setString(txt)
    end
end

--返回货币缩写
function UIHelperEx.convertCurrency(value)
    if Lang.checkLang(Lang.VN)  then
        local a1 = tostring(value)
        if value > 1000 then
             a1 = math.floor(value / 1000).."k"    
        end
        
        local a2 = Lang.getImgText("currency_symbol") 
        return a1..a2,a1,a2 
    end
    return tostring(value),tostring(value),""
end

--把经验转换成需充值货币
function UIHelperEx.convertExpToCurrency(exp)
    if Lang.checkLang(Lang.VN) then
        return exp*250
    end
    return exp / 10
end

--返回输入字数限制的配置
function UIHelperEx.getInputLimitedConfig()
    local LanguageLength = require("app.i18n."..Lang.lang..".language_length")
    local id = 1
    local config = LanguageLength.get(id)
    for index = 1,LanguageLength.length(),1 do
        local config = LanguageLength.indexOf(index)
        if Lang.checkLang(config.language) then
              return config 
        end
    end
    return nil
end

--子node剧中对齐
function UIHelperEx.alignNodeByI18n(node,child1,child2)
	local size = node:getContentSize()
	local size1 = child1:getContentSize()
    local size2 = child2:getContentSize()
    if not child2:isVisible() then
        size2.width = 0
    end
	child1:setPositionX(size.width*0.5-size2.width*0.5)
	child2:setPositionX(size.width*0.5+size1.width*0.5)
    child1:setAnchorPoint(cc.p(0.5,0.5))
    child2:setAnchorPoint(cc.p(0.5,0.5))
end

function UIHelperEx.alignCenter(parentNode,nodes,addSpaces,specialWidths,nodes2)
    local size = parentNode:getContentSize()
    specialWidths = specialWidths or {}
    addSpaces = addSpaces or {}
    local totalWidth = 0
    for k,v in ipairs(nodes) do
        local width = (specialWidths[k] or v:getContentSize().width)
        local anchor = v:getAnchorPoint()
        v:setPositionX(totalWidth + width * anchor.x)
        width = width + (addSpaces and addSpaces[k]  or 0) 
        totalWidth =  totalWidth + width
    end

    local startX = (size.width - totalWidth) * 0.5
   
    for k,v in ipairs(nodes2 or nodes) do
        local x = v:getPositionX() + startX
        local newWorldPos = parentNode:convertToWorldSpace(cc.p(x,0))
        newWorldPos = v:getParent():convertToNodeSpace(newWorldPos)
        v:setPositionX(newWorldPos.x)
    end
    return totalWidth
end

function UIHelperEx.alignCenterToFixPos(centerX,nodes,addSpaces)
    local totalWidth = 0
    for k,v in ipairs(nodes) do
        local width = v:getContentSize().width
        local anchor = v:getAnchorPoint()
        v:setPositionX(totalWidth + width * anchor.x)
        width = width + (addSpaces and addSpaces[k]  or 0) 
        totalWidth =  totalWidth + width
    end

    local startX = centerX  -  totalWidth * 0.5
    for k,v in ipairs(nodes) do
        local x = v:getPositionX() + startX
        v:setPositionX(x)
    end
end

--返回美元显示
function UIHelperEx.convertDollar(value)
    return value,value
end

--CommonMainMenu 根据 function_level_1 显示名字
function UIHelperEx.showMenuName(node,id)
    local textImage = ccui.Helper:seekNodeByName(node, "TextImage")
    -- local FunctionLevel = require( "app.i18n.".. Lang.lang  .. ".function_level_1" )
    local FunctionLevel = require("app.config.function_level_1")
    local functionId = id
    local langInfo = FunctionLevel.get(functionId)
    assert(langInfo, "Invalid function_level_1 can not find funcId "..functionId)
    local posArr = string.split(langInfo.place,",")
    UIHelperEx.setLabelStyle( textImage,{
        style = "icon_txt_"..langInfo.script,
        text = langInfo.name,
    })
    if posArr and #posArr == 2 then
        textImage:setPosition(tonumber(posArr[1]), tonumber(posArr[2]))
    end
    if langInfo.alignment ~= "" then
        textImage:setTextHorizontalAlignment( tonumber(langInfo.alignment) )
    end
     if langInfo.space ~= "" then
        textImage:getVirtualRenderer():setLineSpacing(tonumber(langInfo.space) )
    end
    textImage:setVisible(true)
end

function UIHelperEx.alignRight(nodes,addSpaces,specialWidths,nodes2)
    local firstNode = nodes[1]
    if not firstNode then
        return 
    end
   
    addSpaces = addSpaces or {}
    specialWidths = specialWidths or {}
    local totalWidth = 0
    for k,v in ipairs(nodes) do
        local width = (specialWidths[k] or v:getContentSize().width)
        if k ~= 1 then
            local anchor = v:getAnchorPoint()
            v:setPositionX(totalWidth + width * anchor.x)
        end
        width = width + (addSpaces and addSpaces[k]  or 0) 
        totalWidth =  totalWidth + width
    end

    for k,v in ipairs(nodes2 or nodes) do
        if k ~= 1 then
            local x = v:getPositionX() 
            local newWorldPos = firstNode:convertToWorldSpace(cc.p(x,0))
            newWorldPos = v:getParent():convertToNodeSpace(newWorldPos)
            v:setPositionX(newWorldPos.x)
        end
    end
end


function UIHelperEx.changeRichTextFontSize(richText,fontSize)
    local content = json.decode(richText)
    assert(content, "Invalid json string: "..tostring(content).." with name: "..tostring(richText))
    for k,v in ipairs(content) do
        v.fontSize = fontSize
    end
    return json.encode(content)
end
--
function UIHelperEx.loadCommonBgImageByI18n(img,text)
    img:loadTexture(Path.getHomelandUI("img_com_labelbg_01"))
    local _, count = string.gsub(text, "[^\128-\193]", "")     
    if count <= 2 then
        img:loadTexture(Path.getHomelandUI("img_com_labelbg_01"))
    elseif count ==3 then
        img:loadTexture(Path.getHomelandUI("img_com_labelbg_02"))
    elseif count ==4 then
        img:loadTexture(Path.getHomelandUI("img_com_labelbg_03"))
    elseif count >=5 then
        img:loadTexture(Path.getHomelandUI("img_com_labelbg_04"))
    end
end

function UIHelperEx.getUTF8TxtList(content,wordNum)
    local tempList = {}
    local wordNum = 16--一排文字数
    local UTF8 = require("app.utils.UTF8")
    local length = UTF8.utf8len(content)
    local lineNum = math.ceil(length / wordNum) 
    local startPos = 1
    for k = 1,lineNum,1 do
        local UTF8 = require("app.utils.UTF8")
        local txt = UTF8.utf8sub(content,startPos,math.min(startPos + wordNum-1,length) )
        startPos = startPos + wordNum
        table.insert(tempList,txt)
    end
    dump(tempList)
    return tempList
end

function UIHelperEx.convertToVerticalTxt(content)
    if Lang.checkLang(Lang.JA) then
        local UTF8 = require("app.utils.UTF8")
        content = string.gsub(content, ":", UTF8.unicode_to_utf8("\\u2025"))
        content = string.gsub(content, "%[", UTF8.unicode_to_utf8("\\uFE47"))
        content = string.gsub(content, "%]", UTF8.unicode_to_utf8("\\uFE48"))
        content = string.gsub(content, "。", UTF8.unicode_to_utf8("\\uFE12"))
        content = string.gsub(content, "ー", UTF8.unicode_to_utf8("\\uFE31") )
        content = string.gsub(content, "『", UTF8.unicode_to_utf8("\\uFE43") )
        content = string.gsub(content, "』", UTF8.unicode_to_utf8("\\uFE44") )
        --content = string.gsub(content, "、", UTF8.unicode_to_utf8("\\uFE11") )
        
        return content
    end
    return content
end