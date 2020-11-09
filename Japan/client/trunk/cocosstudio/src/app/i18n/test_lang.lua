local test_lang = {}

local TypeConst = require("app.i18n.utils.TypeConst")
local UIHelper = require("yoka.utils.UIHelper")

test_lang.test = function()
    -- test_lang.testConfig()
    -- test_lang.testEffect()
    -- test_lang.testImgFont()

    -- test_lang._createRoleEffect()

    local textureList = {
        "img_runway_star.png",
        "img_runway_star1.png",
        "img_runway_star2.png",
        "img_runway_star3.png",
    }
    for index = 1, #textureList do
        dump(Path.getImgRunway(textureList[index]), "CommonCountdownAnimation:setTextureList: " .. index)
    end

end

function test_lang._createRoleEffect()
	local function effectFunction(effect)
		-- i18n change font
		if  not Lang.checkLang(Lang.CN) and effect == "routine_word_tupocgong_zi" then
            local UIHelper = require("yoka.utils.UIHelper")
			local subLabel = UIHelper.createBMFLabel({text=Lang.getEffectText("effect_fnt_tupochenggong"),fontName = Path.getImgFont("effect")})
			return subLabel
		end
    		
        return cc.Node:create()
    end

    local function eventFunction(event)
        if event == "finish" then
        
        end
    end

    local node = cc.Node:create()
	-- local effect = G_EffectGfxMgr:createPlayMovingGfx(node, "moving_wujiangbreak_role", effectFunction, eventFunction , false)
	local effect = G_EffectGfxMgr:createPlayMovingGfx(node, "moving_fudaowancheng_qizi", nil, nil, false)
    -- effect:setPosition(cc.p(0, 0))

    node:setPosition(cc.p(display.width/2-160, display.height/2))
    G_TopLevelNode:addToShareLevel( node )
end



test_lang.testImgFont = function()
    logWarn("------------------- test lang img font  start -------------------")
    local   testNode = cc.Node:create()
    testNode:setPosition(cc.p(display.width/2, display.height/2))

    local UIHelper  = require("yoka.utils.UIHelper")
    -- local lable = UIHelper.createBMFLabel({text="SASDASSAETRFGxcvxawseaSDASFASDFGSDFASDFGSD",fontSize=88,width=400,lineSpacing=50})
    -- local lable = UIHelper.createLabel({text=text,style="talent",styleType=TypeConst.TEXT,h_align=cc.TEXT_ALIGNMENT_CENTER})
    local text = Lang.getImgText("text_next_open",{name="testtesttest",level=10}) 
    local lable = UIHelper.createBMFLabel({text=text,fontName=Path.getImgFont("newopen"),fontSize=25,h_align=cc.TEXT_ALIGNMENT_CENTER})
    testNode:addChild(lable)
    G_TopLevelNode:addToShareLevel( testNode )
    logWarn("------------------- test lang img font  end -------------------")
end

test_lang.getTestColor = function(type)
    if type == 1 then
        return cc.c3b(0x96, 0xfa, 0x2a), cc.c3b(0x38, 0x74, 0x07)
    elseif type == 2 then
        return cc.c3b(0xfb, 0x86, 0x14), cc.c3b(0x93, 0x37, 0x05)
    end
end

test_lang.playEffect = function(effectName,effectNodeName,param)
    local testEffect = rootNode
    local styleType = param.styleType or TypeConst.TEXT
    local style = param.style or nil
    local fontName = param.fontName or nil
    local rootNode = param.rootNode or nil 
    local rootNodePos = param.rootNodePos or nil 
    if not rootNode then
        testEffect = cc.Node:create()
        testEffect:setPosition(cc.p(display.width/2-160, display.height/2))
    end
    if rootNodePos then
        testEffect:setPosition(rootNodePos)
    end

    G_TopLevelNode:addToShareLevel( testEffect )

    local function effectFunction(effect)
        if effect == effectNodeName then
            local text = param.text or "test effect"
            local label = nil
            if fontName then
                label = UIHelper.createBMFLabel({text=text,fontName = fontName})
            else
                label = UIHelper.createLabel({text=text,style=style,styleType=styleType})
            end
			-- local label = cc.Label:createWithTTF(text, Path.getCommonFont(), 37)
            -- local fontColor, fontOutline = test_lang.getTestColor(colorType)
            -- label:setColor(fontColor)
            -- label:enableOutline(fontOutline, 2)   
            dump({text=text,style=style,styleType=styleType},"label")
            dump(label,"label")
			return label
        end
    end
    local effect = G_EffectGfxMgr:createPlayMovingGfx( testEffect, effectName, effectFunction, nil ,true ) 

end

test_lang.testEffect = function()
    logWarn("------------------- test lang effect  start -------------------")
    
    -- test_lang.playEffect("moving_taofa_zi","routine_word_taofa_icon_zi",{text=Lang.getEffectText("effect_taofa"),style="effect_text_5",styleType=TypeConst.EFFECT})
    -- test_lang.playEffect("moving_wujiangbreak_role","routine_word_tupocgong_zi",{rootNodePos=cc.p(display.width/2, display.height/2),text=Lang.getEffectText("effect_fnt_tupochenggong"),fontName=Path.getImgFont("effect")})
   
    -- local subLabel = UIHelper.createLabel({text=Lang.getEffectText("effect_jiesuotianfu"),style="effect_text_36",styleType=TypeConst.EFFECT})
    -- subLabel:setPosition(cc.p(display.width/2-160, display.height/2))
    -- G_TopLevelNode:addToShareLevel( subLabel )

    -- local EffectGfxNode = require("app.effect.EffectGfxNode")
    -- local testEffect = cc.Node:create()
    -- testEffect:setPosition(cc.p(display.width/2-160, display.height/2))
    -- local subEffect = G_EffectGfxMgr:createPlayGfx(testEffect,"effect_taofa_shiwanghuoji")
    -- G_TopLevelNode:addToShareLevel( testEffect )

    -- local EffectGfxNode = require("app.effect.EffectGfxNode")
    -- local testEffect = cc.Node:create()
    -- testEffect:setPosition(cc.p(display.width/2-160, display.height/2))
    -- local function effectFunction(effect)
    --     if effect == "routine_word_taofa_icon_zi" then
    --         local TypeConst = require("app.i18n.utils.TypeConst")
	-- 		local UIHelper = require("yoka.utils.UIHelper")
    -- 		local subLabel = UIHelper.createLabel({text=Lang.getEffectText("effect_taofa"),style="effect_text_5",styleType=TypeConst.EFFECT})
    --         return subLabel
    --     end
    -- end
    -- local effect = G_EffectGfxMgr:createPlayMovingGfx( testEffect, "moving_taofa_zi", effectFunction, nil ,true ) 
    -- G_TopLevelNode:addToShareLevel( testEffect )

    

    logWarn("------------------- test lang effect  end -------------------")
end


test_lang.testConfig = function()
    logWarn("------------------- test lang config  start -------------------")

    print(os.date("%Y%m%d%H%M%S", os.time()))
    local start_time = os.time()
    print(" start time: " .. start_time)
    print(" item: " .. Lang.getConfigLanguageFullPath("act_admin") )
    -- dump(require( Lang.getConfigLanguageFullPath( "act_admin" ) ))
    local cfg = nil
    local total = 10000000
    -- local total = 10000
    for i=total,1,-1 do
        local templates = require("app.config.act_admin")
        local item = templates.get(12)
        cfg = item
    end
    local end_time = os.time()
    print(" end time: " .. end_time)
    local time = end_time - start_time
    print("读取 10000000 个 耗时： " .. time )
    print(" text cfg name: " .. cfg.name)
    print(os.date("%Y%m%d%H%M%S", os.time()))

    logWarn("------------------- test lang config  end -------------------")
end

return test_lang
