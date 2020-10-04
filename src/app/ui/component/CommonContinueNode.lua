local CommonContinueNode = class("CommonContinueNode")

function CommonContinueNode:ctor()

end

local EXPORTED_METHODS = {
    "setString"
}

function CommonContinueNode:ctor()
	self._target = nil
end

function CommonContinueNode:_init()
    if Lang.checkUI("ui4") then
        local image = ccui.Helper:seekNodeByName(self._target, "Continue_Image")
        local text = ccui.Helper:seekNodeByName(self._target, "Text_continue_desc")
        image:loadTexture(Path.getUICommon("img_dianjijixu"))
        image:ignoreContentAdaptWithSize(true)
        text:setVisible(false)
    end
    
	self._target:updateLabel("Text_continue_desc",{
        text = Lang.get("common_text_click_continue"),
        -- color = Colors.CLICK_SCREEN_CONTINUE,
       -- outlineColor = Colors.COLOR_SCENE_OUTLINE,
       -- outlineSize = 2,
    })

	local fadein = cc.FadeIn:create(0.5)
	local fadeout = cc.FadeOut:create(0.5)
	local seq = cc.Sequence:create(fadein,fadeout)
	local repeatAction = cc.RepeatForever:create(seq)
    self._target:runAction(repeatAction)
    
     --  特殊处理颜色
     if Lang.checkUI("ui4") then
        self._target:updateLabel("Text_continue_desc",{
            text = Lang.get("common_text_click_continue"),
            color = Colors.NORMAL_BG_ONE,
        })
    end   
end

function CommonContinueNode:bind(target)
	self._target = target
    self:_init()
    cc.setmethods(target, self, EXPORTED_METHODS)
end

function CommonContinueNode:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
end

function CommonContinueNode:setString(s)
	self._target:updateLabel("Text_continue_desc",{
        text = s,
        color = Colors.CLICK_SCREEN_CONTINUE,
       -- outlineColor = Colors.COLOR_SCENE_OUTLINE,
       -- outlineSize = 2,
    })    
end

-- i18n change lable
function CommonContinueNode:_createLabelByI18n()
	if not Lang.checkLang(Lang.CN) then
		local UIHelper  = require("yoka.utils.UIHelper")
		local image = ccui.Helper:seekNodeByName(self._target, "Continue_Image")
        local x,y = image:getPosition()
        local anchorPoint = image:getAnchorPoint()
		local label = UIHelper.createLabel({
			 style = "common_continue",
             position = cc.p(x,y) ,
             anchorPoint = anchorPoint,
             text =  Lang.getImgText("zi_dianjipingmujixu") ,
		})
        image:getParent():addChild(label)
            --  特殊处理颜色
	end
end


return CommonContinueNode