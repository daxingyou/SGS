--奖励
local PopupBase = require("app.ui.PopupBase")
local PopupNextFunction = class("PopupNextFunction", PopupBase)
local CSHelper  = require("yoka.utils.CSHelper")
local AudioConst = require("app.const.AudioConst")
local UIHelper  = require("yoka.utils.UIHelper")

function PopupNextFunction:ctor(data)
	self._data = data
    self._resourceNode = self
    self:setName("PopupNextFunction")
	PopupNextFunction.super.ctor(self,nil,false,true)
end

function PopupNextFunction:onCreate()
	self._titleImagePath = Path.getNextFunctionOpen("img_newopen_jijiangzi")
    self:_createTouchLayer()
    if Lang.checkUI("ui4") then
        self:_createEffectNodeByI18n(self)
        return
    end
	local effectNode = self:_createEffectNode(self)

	local commonContinueNode = CSHelper.loadResourceNode(Path.getCSB("CommonContinueNode", "common"))
	commonContinueNode:setPositionY(-289)
	commonContinueNode:setVisible(false)
	self:addChild(commonContinueNode)
	self._commonContinueNode = commonContinueNode

	local PopupNextFunctionPopInfoNode = require("app.ui.PopupNextFunctionPopInfoNode")

	local nextInfoNode = PopupNextFunctionPopInfoNode.new(self._data)
	nextInfoNode:setPositionY(-10)
	self:addChild(nextInfoNode)
end

function PopupNextFunction:onEnter()

end

function PopupNextFunction:onClose( ... )
    -- body
end

function PopupNextFunction:onExit()

end


function PopupNextFunction:_createTouchLayer()
    --创建屏蔽层
    local numAlpha =  0.75
    local layerColor = cc.LayerColor:create(cc.c4b(0, 0, 0, 255*numAlpha))
    layerColor:setIgnoreAnchorPointForPosition(false)
    layerColor:setTouchMode(cc.TOUCHES_ONE_BY_ONE)
    layerColor:setTouchEnabled(true)
    layerColor:registerScriptTouchHandler(function(event,x,y)
        if event == "began" then
            return true
        elseif event == "ended" then
			self:close()
        end
    end)
    self:addChild(layerColor)
    self._layerColor = layerColor

end

function PopupNextFunction:_createActionNode(effect)

    if effect == "txt" then
        local txtSp = display.newSprite(self._titleImagePath)
        return txtSp
    elseif effect == "all_bg" then
         local bgSp = display.newSprite(Path.getUICommon("img_board_break03b"))

         return bgSp
    elseif effect == "button" then
         self._btn = self._commonContinueNode
         self._commonContinueNode:setVisible(true)
         return display.newNode()
    elseif effect == "txt_meirilibao" then
        return display.newNode()
    elseif effect == "txt_shuoming" then
        return display.newNode()
    end
end


function PopupNextFunction:_createEffectNode(rootNode)
    local EffectGfxNode = require("app.effect.EffectGfxNode")
    local TextHelper = require("app.utils.TextHelper")
    local function effectFunction(effect)
        if TextHelper.stringStartsWith(effect,"effect_") then
			local subEffect = EffectGfxNode.new(effect)
            subEffect:play()
            return subEffect
		else
			return self:_createActionNode(effect)
		end
    end
    local function eventFunction(event,frameIndex, movingNode)
        if event == "finish" then

        end
    end
   local node =  G_EffectGfxMgr:createPlayMovingGfx( rootNode, "moving_choujiang_hude", effectFunction, eventFunction , false )
   return node
end


function PopupNextFunction:_createActionNodeByI18n(effect)
	local function effectFunction(effect)
		if effect == "icon_zi" then
			local params1 ={
				name = "label1",
				text = self._data.name,
                fontSize = 26,
                fontName = Path.getFontW8(),
				color = Colors.getSummaryStarColor(),
			}
			local label = UIHelper.createLabel(params1)
			return label
		elseif effect == "effect_xingongneng_tubiao_sangceng" then
		    local subEffect = EffectGfxNode.new("effect_xingongneng_tubiao_sangceng")
            subEffect:play()
            return subEffect
		elseif effect == "icon_tubiao" then
		    local sprite = display.newSprite(Path.getCommonIcon("main",self._data.icon))
        	return sprite
		elseif effect == "effect_xingongneng_tubiao_di" then
		    local subEffect = EffectGfxNode.new("effect_xingongneng_tubiao_di")
            subEffect:play()
            return subEffect
		end

	end
	local function eventFunction(event)

    end

	local spaceX = 0
	if Lang.checkUI("ui4") then
		spaceX = 5
	end
    if effect == "xingongneng_shuoming" then
        local strArr = string.split(self._data.text, "|")
	    local string1 = strArr[1]
        local string2 = strArr[2]
        local  str = ""
        if string1 then
           str = str .. string1
        else
            str = str
        end
        if string2 then
            str = str .. "\n" .. string2
        else
            str = str
        end
		local paramList = {
				name = "label1",
				text =str,
				fontSize = 18,
				color = Colors.getSummaryStarColor(),
		}
		local labelNode = UIHelper.createLabel(paramList)
		return labelNode
    elseif effect == "moving_xingongneng_tubiao" then
		local node = cc.Node:create()
	    local effect = G_EffectGfxMgr:createPlayMovingGfx( node, "moving_xingongneng_tubiao", effectFunction, eventFunction , false )
		effect:play()
        return node        
    elseif effect == "button" then
        return cc.Node:create() 
	end
end

function PopupNextFunction:_createEffectNodeByI18n(rootNode)
	
    local function effectFunction(effect)
            return self:_createActionNodeByI18n(effect)    
    end

    local function eventFunction(event)
        if event == "finish" then
        end
    end
	
	G_AudioManager:playSoundWithId(AudioConst.SOUND_NEW_FUNC_OPEN)
    local effect = G_EffectGfxMgr:createPlayMovingGfx( rootNode, "moving_gongnengyugao", effectFunction, eventFunction , false )
    -- local size = self:getResourceNode():getContentSize()  
    -- effect:setPosition(0, 0)
end


return PopupNextFunction
