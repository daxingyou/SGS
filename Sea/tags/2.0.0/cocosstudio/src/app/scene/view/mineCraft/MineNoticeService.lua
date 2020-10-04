local MineNoticeService = class("MineNoticeService")

MineNoticeService.BIG_NOTICE_COLOR = 5          --需要特殊大提示

local effectName = 
{
    [100] = "effect_gongkeluoyang",
    [101] = "effect_gongkexuchang",
    [201] = "effect_gongkechangan",
    [301] = "effect_gongkeshouchun",
}

function MineNoticeService:ctor( ... )
	self._rootNode = nil
    self._signalChangeGuild = nil
    self:_createRootNode()
    self:_registerEvents()
end

function MineNoticeService:_registerEvents()
	if not self._signalChangeGuild then
		self._signalChangeGuild = G_SignalManager:add(SignalConst.EVENT_MINE_GUILD_BOARD, handler(self, self._onEventMineGuild))
	end
end

function MineNoticeService:_onEventMineGuild(eventName, mineData)
    local configData = mineData:getConfigData()
    local mineColor = configData.pit_color
    if mineColor == MineNoticeService.BIG_NOTICE_COLOR then 
        self:_createBigMineEffect(configData.pit_id)
    else 
        self:_createSmallMineEffect(configData.pit_name)
    end
end

function MineNoticeService:_createSmallMineEffect(mineName)
    if G_SceneManager:getRunningSceneName() == "mineCraft" and G_SceneManager:getRunningSceneName() ~= "fight" then 
        self:show()
        local function effectFunction(effect)
            if effect == "gongke_txt" then 
                local fontColor = Colors.getSmallMineGuild()
                local content = Lang.get("mine_notice_world", {city = mineName})
                local label = cc.Label:createWithTTF(content, Path.getFontW8(), 60)
                label:setColor(fontColor) 
                return label                       
            end
            -- i18n change effect
            if not Lang.checkLang(Lang.CN) and effect == "routine_word_kuang_9" then 
                local TypeConst = require("app.i18n.utils.TypeConst")
                local UIHelper = require("yoka.utils.UIHelper")
                local subLabel = UIHelper.createLabel({text=Lang.get("mine_notice_world", {city = mineName}),style="effect_text_20",styleType=TypeConst.EFFECT})
                return subLabel
            end
        end
        local function eventFunction(event)
            if event == "finish" then
                self:hide()
            end
        end
        G_EffectGfxMgr:createPlayMovingGfx( self._rootNode, "moving_gongkexiaocheng", effectFunction, eventFunction, true )
    end
end

function MineNoticeService:_createBigMineEffect(mineId)
    if G_SceneManager:getRunningSceneName() == "fight" then 
        return 
    end
    self:show()
    local function eventFunction(event)
        if event == "finish" then
			self:hide()
        end
    end
    -- i18n change effect
    if not Lang.checkLang(Lang.CN) then
        local function _effectFunction(_effect)
            if _effect == "routine_word_win_2" then
                local TypeConst = require("app.i18n.utils.TypeConst")
                local UIHelper = require("yoka.utils.UIHelper")
                local labelText = Lang.getEffectText("effect_shengli")
                if effectName[mineId] == "effect_gongkeluoyang" then 
                    labelText = Lang.getEffectText("effect_gongke_luoyang")
                elseif effectName[mineId] == "effect_gongkexuchang" then
                    labelText = Lang.getEffectText("effect_gongke_xuchang")
                elseif effectName[mineId] == "effect_gongkechangan" then
                    labelText = Lang.getEffectText("effect_gongke_changan")
                elseif effectName[mineId] == "effect_gongkeshouchun" then
                    labelText = Lang.getEffectText("effect_gongke_shouchun")
                end   
                local subLabel = UIHelper.createLabel({text=labelText,style="effect_text_27_1",styleType=TypeConst.EFFECT})
                return subLabel
            end
        end	
        local effect = G_EffectGfxMgr:createPlayMovingGfx(self._rootNode, "moving_jingji_shengli", _effectFunction, eventFunction , true)
    else
        local effect = G_EffectGfxMgr:createPlayGfx( self._rootNode, effectName[mineId], eventFunction, true )
        effect:play()
    end   
end

function MineNoticeService:_unRegisterEvents()
	if self._signalChangeGuild then
		self._signalChangeGuild:remove()
		self._signalChangeGuild = nil
	end
end

function MineNoticeService:start()
	self:_registerEvents()
end

function MineNoticeService:clear()
	self:_unRegisterEvents()
end

function MineNoticeService:show( ... )
	if self._rootNode ~= nil then
		self._rootNode:setVisible(true)
	end
end

function MineNoticeService:hide( ... )
	if self._rootNode ~= nil then
		self._rootNode:setVisible(false)
	end
end

function MineNoticeService:_createRootNode()
	if self._rootNode == nil then
        self._rootNode = display.newNode()
        self._rootNode:setPosition(G_ResolutionManager:getDesignCCPoint())
		local resource = {
			file = Path.getCSB("MineNotice", "mineCraft"),
			size = G_ResolutionManager:getDesignSize(),
			binding = {
			}
		}

		local CSHelper = require("yoka.utils.CSHelper")
		CSHelper.createResourceNode(self._rootNode,resource)
		G_TopLevelNode:addToSubtitleLayer(self._rootNode)

		self:hide()
	end
end

return MineNoticeService
