--提示文字
local PromptTip = class("PromptTip")

local PromptAction  = require("app.ui.prompt.PromptAction")

local CSHelper  = require("yoka.utils.CSHelper")

function PromptTip:ctor(callback)
    self._callback = callback
end

--[======================[
    通用tip消息弹框
    @params可以直接是一个字符串，也可以是一个富文本json格式
    local params = "xxx"
    local params = '[{"type":"text", "msg":"随便#name#", "color":16777215, "opacity":"255"}]'
]======================]

function PromptTip:_loadCsb()


    return node
end


function PromptTip:_updateRichText(node,content)

    local richText = ccui.RichText:createWithContent(content)
    local label = node:getSubNodeByName("Text_tip_content")
    richText:setPosition(label:getPosition())

    label:setVisible(false)
    richText:formatText()
    local richTextContentSize = richText:getVirtualRendererSize()
    if richTextContentSize.width > 420 then
        richText:ignoreContentAdaptWithSize(false)
        richText:setContentSize(contentSize or cc.size(440, 60))
        --richText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
        richText:setVerticalSpace(5)
    end

    local height = contentSize and contentSize.height or (richTextContentSize.width > 420 and 60)
    if height then
        local background = node:getSubNodeByName("Image_tip_background")
        local backContentSize = background:getContentSize()
        background:setContentSize(cc.size(backContentSize.width, height + 35))
    end
    node:addChild(richText)
end

function PromptTip:_updateText(node, text)
    -- 更新文本
    local label = node:updateLabel("Text_tip_content", tostring(text))
 
    -- i18n ui4
    if Lang.checkUI("ui4") then -- tips底图自适应宽高
        label:ignoreContentAdaptWithSize(true) -- 老逻辑存在文字剪裁的情况，ui4这里设置一下
        label:getVirtualRenderer():setMaxLineWidth(470) --策划要求大多情况下文字显示2行
        local labelContentSize = label:getVirtualRendererSize()

        local background = node:getSubNodeByName("Image_tip_background")
        local backContentSize = background:getContentSize()
        local bgWidth = backContentSize.width
        local bgHeight = math.max(backContentSize.height, labelContentSize.height + 45)
        if labelContentSize.width > 305 then  -- 305：tips的背景框两边多是近乎透明的，为了文字集中在不是透明的中间
            if labelContentSize.width <= bgWidth then
                bgWidth = bgWidth + (bgWidth - labelContentSize.width) + 120  -- 120：为了文字集中在不是透明的中间，背景框长度多加点
            else
                bgWidth = bgWidth + (labelContentSize.width - bgWidth) + 120
            end
        end
        background:setContentSize(cc.size(bgWidth, bgHeight))
    else
        -- 宽度超过一定范围就换行
        local labelContentSize = label:getVirtualRendererSize()
        if labelContentSize.width > 420 then
            label:setTextAreaSize(contentSize or cc.size(420, 60))
        end

        local height = contentSize and contentSize.height or (labelContentSize.width > 420 and 60)
        if height then
            local background = node:getSubNodeByName("Image_tip_background")
            local backContentSize = background:getContentSize()
            background:setContentSize(cc.size(backContentSize.width, height + 35))
        end
    end
end

-- 多行 自动居中富文本
--
function PromptTip:_updateRichTextType2(node, params)
	if params and params.str then
		local UIHelper = require("yoka.utils.UIHelper")
        local richText = UIHelper.createMultiAutoCenterRichText(params.str, params.defaultColor or Colors.OBVIOUS_YELLOW, params.fontSize or 22, 5)
       
		local label = node:getSubNodeByName("Text_tip_content")
	    richText:setPosition(label:getPosition())
	    label:setVisible(false)

		local background = node:getSubNodeByName("Image_tip_background")
		local backContentSize = background:getContentSize()
		local richSize = richText:getContentSize()
		local bgWidth = backContentSize.width > richSize.width + 40 and backContentSize.width or richSize.width + 40
		local bgHeight = backContentSize.height > richSize.height + 35 and backContentSize.height or richSize.height + 35
		background:setContentSize(cc.size(bgWidth, bgHeight))
		node:addChild(richText)
	end
end

--i18n
function PromptTip:show(params,delayTime,showTime)
    assert(params and (type(params) == "string" or type(params) == "table"),
        "Invalid params: "..tostring(params))

    -- 创建弹框
    local node =  nil
    if Lang.checkUI("ui4") then
        node =  CSHelper.loadResourceNode(Path.getCSB("PromptTipNode2", "common"))
    else
        node =  CSHelper.loadResourceNode(Path.getCSB("PromptTipNode", "common"))
    end

	if type(params) == "table" then
		self:_updateRichTextType2(node, params)
	else
		local content = json.decode(params)
		-- 如果解析json成功，这里认为是一个富文本
		if type(content) == "table" then
			self:_updateRichText(node, params)
		else
			self:_updateText(node, params)
		end
	end
    local width = G_ResolutionManager:getDesignWidth()
    local height = G_ResolutionManager:getDesignHeight()
    local scene = G_SceneManager:getRunningScene()
	scene:addTips(node)

    node:setPosition(cc.p(width/2, height/5*2.6))
    node:setCascadeOpacityEnabled(true)

    local callBackAction = cc.CallFunc:create(function()
        if self._callback then
            self._callback()
        end
    end)
    if delayTime and delayTime > 0 then
        local seq1 = cc.Sequence:create( PromptAction.tipAction(showTime), cc.RemoveSelf:create() )
        local seq2 = cc.Sequence:create( cc.DelayTime:create(delayTime), callBackAction)
        node:runAction( cc.Spawn:create(seq1,seq2) )
    else
        node:runAction(cc.Sequence:create(PromptAction.tipAction(showTime), cc.RemoveSelf:create(),callBackAction))
    end

    return node
end

function PromptTip:showOnTop(params, delayTime)
    assert(params and (type(params) == "string" or type(params) == "table"),
    "Invalid params: "..tostring(params))
    local node = nil
    -- 创建弹框
    if Lang.checkUI("ui4") then
        node =  CSHelper.loadResourceNode(Path.getCSB("PromptTipNode2", "common"))
    else
        node =  CSHelper.loadResourceNode(Path.getCSB("PromptTipNode", "common"))
    end
    if type(params) == "table" then
        self:_updateRichTextType2(node, params)
    else
        local content = json.decode(params)
        -- 如果解析json成功，这里认为是一个富文本
        if type(content) == "table" then
            self:_updateRichText(node, params)
        else
            self:_updateText(node, params)
        end
    end
    local width = G_ResolutionManager:getDesignWidth()
    local height = G_ResolutionManager:getDesignHeight()
    -- local scene = G_SceneManager:getRunningScene()
    -- scene:addTips(node)

    G_TopLevelNode:addToTipLevel(node)

    node:setPosition(cc.p(width/2, height/5*2.6))
    node:setCascadeOpacityEnabled(true)

    local callBackAction = cc.CallFunc:create(function()
        if self._callback then
            self._callback()
        end
    end)
    if delayTime and delayTime > 0 then
        local seq1 = cc.Sequence:create( PromptAction.tipAction(), cc.RemoveSelf:create() )
        local seq2 = cc.Sequence:create( cc.DelayTime:create(delayTime), callBackAction)
        node:runAction( cc.Spawn:create(seq1,seq2) )
    else
        node:runAction(cc.Sequence:create(PromptAction.tipAction(), cc.RemoveSelf:create(),callBackAction))
    end

    return node
end


return PromptTip
