local ViewBase = require("app.ui.ViewBase")
local CreateView2 = class("CreateView2", ViewBase)
local AudioConst = require("app.const.AudioConst")

local CSHelper = require("yoka.utils.CSHelper")

function CreateView2:ctor()
    self._selectIdx = 0
    self._defaultName = nil
    self._sex = 1

    self:_seekActivateCodeName()

    local resource = {
        file = Path.getCSB("CreateView2", "create"),
        size = G_ResolutionManager:getDesignSize(),
        binding = {
            _touchFemale = {
                events = {{event = "touch", method = "_onFemaleClick"}}
            },
            _touchMale = {
                events = {{event = "touch", method = "_onMaleClick"}}
            },
        }
    }
    CreateView2.super.ctor(self, resource, 9999)
end

function CreateView2:_seekActivateCodeName()
    local config = G_UserData:getCreateRole():getActivationCodeConfig()
    if not config then
        return
    end
    self._sex = config.gender
end

function CreateView2:onCreate()
    if self._sex == 1 then
        self:_onMaleClick()
    else
        self:_onFemaleClick()
    end
end

function CreateView2:onEnter()
   
end

function CreateView2:onExit()
end

function CreateView2:_onFemaleClick()
    if self._selectIdx == 2 then
        return
    end
    self._selectIdx = 2
    self:_refreshChooseBtn()
    self:_playChooseAnim()
end

function CreateView2:_onMaleClick()
    if self._selectIdx == 1 then
        return
    end
    self._selectIdx = 1
    self:_refreshChooseBtn()
    self:_playChooseAnim()
end

function CreateView2:_refreshChooseBtn()

    local nodeEffectMale = self._nodeMale:getChildByName("NodeEffect")
    local nodeEffectFemale = self._nodeFemale:getChildByName("NodeEffect")
    local imageMale = self._nodeMale:getChildByName("Image")
    local imageFemale = self._nodeFemale:getChildByName("Image")
    nodeEffectMale:removeAllChildren()
    nodeEffectFemale:removeAllChildren()
    if self._selectIdx == 1 then
        G_EffectGfxMgr:createPlayGfx(nodeEffectMale, "effect_chuangjue_icontx", nil )
        imageMale:loadTexture(Path.getCreateImage2("btn_create_male_sel"))
        imageFemale:loadTexture(Path.getCreateImage2("btn_create_female_nml"))
    elseif self._selectIdx == 2 then
        G_EffectGfxMgr:createPlayGfx(nodeEffectFemale, "effect_chuangjue_icontx", nil )
        imageMale:loadTexture(Path.getCreateImage2("btn_create_male_nml"))
        imageFemale:loadTexture(Path.getCreateImage2("btn_create_female_sel"))
    else
        imageMale:loadTexture(Path.getCreateImage2("btn_create_male_nml"))
        imageFemale:loadTexture(Path.getCreateImage2("btn_create_female_nml"))
    end
end

function CreateView2:_playChooseAnim()

    
    if self._nodeInput then
        self._defaultName = self._nodeInput:getDefaultName()
        self._nodeInput = nil
    end
    self._nodeEffect:removeAllChildren()
    self._nodeUIEffect:removeAllChildren()
    self._nodeAvatar:removeAllChildren()
    --[[
    local spineId = "999_big"
    local anim = "moving_nanzhuchuangjue_2"
    if self._selectIdx == 2 then
        spineId = "998_big"
        anim = "moving_nvzhuchuangjue_2"
    end
    local function eventFunction(event)
        if event == "ui" then
            self:_createUI()
        end
    end

    G_EffectGfxMgr:createPlayMovingGfx(self._nodeEffect, anim, nil, eventFunction)
]]

--[[

    local id = 999
    if self._selectIdx == 2 then
        id = 998
    end
    local spineNode = require("yoka.node.SpineNode").new(0.5)
    spineNode:setAsset(Path.getStorySpine(id))
    spineNode:setAnimation("idle", true)
    self._nodeAvatar:addChild(spineNode)
]]
    self:_createUI()
end

function CreateView2:_createUI()
    local anim = "moving_chuangjueui_nanzhu"
    if self._selectIdx == 2 then
        anim = "moving_chuangjueui_nvzhu"
    end
    local function effectFunction(effect)
        if effect == "juese" then
          
            local id = 999
            if self._selectIdx == 2 then
                id = 998
            end
            local heroId = 0
            local posY
            local scale
            if self._selectIdx == 1 then
                heroId = 1 --男
                posY = -260
                scale = 1/0.88
            else
                heroId = 11 --女
                posY = -240
                scale = 1/0.94
            end
            local spineNode = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar", "common"))
            spineNode:updateChatUI(heroId)
            spineNode:startTalk(self._selectIdx == 1 and  "1_voice7" or 
            "11_voice8",true)
            spineNode:setPositionY(posY)
            spineNode:setScale(scale)
           

            -- if self._nowPlayId then
            --     G_AudioManager:stopSound(self._nowPlayId)
            --     self._nowPlayId = nil
            -- end
            -- self._nowPlayId = G_AudioManager:playSound(Path.getHeroVoice(self._selectIdx == 1 and  "1_voice7" or 
            --     "11_voice8"
            -- ))
            -- local spineNode = require("yoka.node.SpineNode").new(1)
            -- spineNode:setAsset(Path.getStorySpine(id))
            -- spineNode:setAnimation("idle", true)
           
            local node = cc.Node:create()
            if self._selectIdx == 1 then
                spineNode:setScaleX(-spineNode:getScaleX())
            end
            node:addChild(spineNode)
            return node
  --[[
            local id = 1
            if self._selectIdx == 2 then
                id = 2
            end
            local CSHelper  = require("yoka.utils.CSHelper")
            local heroAvatar = CSHelper.loadResourceNode(Path.getCSB("CommonStoryAvatar2", "common"))
            heroAvatar:updateUI(id)
            return heroAvatar
            ]]
        elseif effect == "shurukuang" then
            local node = CSHelper.loadResourceNode(Path.getCSB("NodeInput2", "create"))
            self._nodeInput = require("app.scene.view.create.NodeInput2").new(node, self._selectIdx, self._defaultName)
            return node
        elseif effect == "anniu" then
            local btn = ccui.Button:create()
            btn:loadTextureNormal(Path.getCreateImage2("btn_create_startgame"))
            btn:addClickEventListenerEx(handler(self, self._onStartClick))
            return btn
        end
    end
    G_EffectGfxMgr:createPlayMovingGfx(self._nodeUIEffect, anim, effectFunction)
end

function CreateView2:_returnMainView()
    if self._nodeInput then
        self._defaultName = self._nodeInput:getDefaultName()
    end

    self._selectIdx = 0
    self:_refreshChooseBtn()
    self._nodeEffect:removeAllChildren()
    self._nodeUIEffect:removeAllChildren()
    self._nodeInput = nil
    self._imageBack:setVisible(false)
    self._imageTitle:setVisible(true)
end

function CreateView2:_onBackClick()
    if self._selectIdx ~= 0 then
        self:_returnMainView()
    end
end

function CreateView2:_onStartClick()
    local nameTxt = self._nodeInput:getName()
    G_AudioManager:playSoundWithId(AudioConst.SOUND_BUTTON_START_GAME)
    nameTxt = string.trim(nameTxt)

    logWarn(nameTxt)
    
    -- i18n change text filtration
    local getMaxLen = function()
        local maxLen = 6
        --if not Lang.checkLang(Lang.CN) then
        --    local UIHelper  = require("yoka.utils.UIHelper")
        --    maxLen = UIHelper.getInputLimitedConfig().role_length
        --end
        return maxLen
    end
   
  --  print("dsdsd "..tostring(getMaxLen()) )

    local TextHelper = require("app.utils.TextHelper")
    if TextHelper.isNameLegal(nameTxt, 2, getMaxLen()) then
        G_GameAgent:checkContent(
            nameTxt,
            function()
                G_GameAgent:createRole(nameTxt, self._selectIdx)
            end
        )
    end
end

return CreateView2
