
local PopupAlert = require("app.ui.PopupAlert")
local PopupLanguage = class("PopupLanguage", PopupAlert)
local UIHelper  = require("yoka.utils.UIHelper")

local langConfig = {
    [Lang.ZH] = {name = "简体中文"},
    [Lang.EN] = {name = "English"},
    [Lang.TH] = {name = "ไทย"},
    [Lang.ENID] = {name = "Indonesia"},
}

function PopupLanguage:ctor()
    self.lang = Lang.lang
    self.optionList = {}
	PopupLanguage.super.ctor(self,Lang.getImgText("txt_language_title"), "",handler(self, self._onConfirm))
end

-- Describle：
function PopupLanguage:onCreate()
	PopupLanguage.super.onCreate(self)
    
    local langList = string.split(Lang.mathLang,"|")
    for i, v in ipairs(langList) do
        local data = langConfig[v]
        data.lang = v
        if data then
            local node = self:_createOptionNode(i,data)
            self._popupBG:addChild(node)
            self.optionList[#self.optionList+1] = {node = node,data = data}
            local posX = -215
            if i%2 == 0 then
                posX = 20
            end
            local posY = 65 - math.floor((i-1)/2)*85
            node:setPosition(cc.p(posX,posY))
        end
    end
    self:_refreshOption()

    self._descBG:setVisible(false)
    self:onlyShowOkButton()
end

function PopupLanguage:_onConfirm()
    if self.lang == Lang.lang then
        return
    end
    local lang = self.lang
    local function onConfirm()
        Lang.lang = lang
        Lang.status = Lang.STATUS_USER
        Lang._writeStorage()
        G_GameAgent:reloadModule()
    end
    local langName = ""
    for i, v in ipairs(self.optionList) do
        if v.data.lang == self.lang then
            langName = v.data.name
            break
        end
    end
    local content1 = Lang.getImgText("txt_system_content1",{name=langName})
    local content2 = Lang.getImgText("txt_system_content2")
    local alert = PopupAlert.new(Lang.getImgText("txt_language_title"), content1,onConfirm)
    local posX,posY = alert._textDesc:getPosition()
    alert._textDesc:setPositionY(posY+20)
	local label = UIHelper.createLabel({
		text = content2,
		position = cc.p(posX,posY-20),
		color = cc.c3b(0xe0, 0x4b, 0x0a),
		size = 20,
		anchorPoint = cc.p(0.5,0.5)
	})
    alert._descBG:addChild(label)
    alert:openWithAction()
    alert:onlyShowOkButton()
end

function PopupLanguage:_createOptionNode(idx,data)
    local node = display.newNode()
	local bg = UIHelper.createImage({texture = Path.getUICommon("img_com_check05c") })
	bg:setScale9Enabled(true)
	bg:setCapInsets(cc.rect(26,16,1,1))
    bg:setContentSize(cc.size(145,46))
    bg:setAnchorPoint(0,0.5)
    node:addChild(bg)
	local label = UIHelper.createLabel({
		text = data.name,
		position = cc.p(73,0),
		color = cc.c3b(0xb4, 0x64, 0x14),
		size = 22,
		anchorPoint = cc.p(0.5,0.5)
	})
    node:addChild(label)

    local btn = ccui.Button:create()
    btn:loadTextureNormal(Path.getUICommon("img_com_check05a"))
    btn:addClickEventListenerEx(handler(self, self._onClick))
    node:addChild(btn)
    btn:setZoomScale(0)
    btn:setPosition(160,0)
    btn:setTag(idx)

    local selectImg = UIHelper.createImage({texture = Path.getUICommon("img_com_check05b") })
    node:addChild(selectImg)
    selectImg:setPosition(160,0)
    node.selectImg = selectImg

    return node
end

function PopupLanguage:_onClick(sender,event)
    local data = self.optionList[sender:getTag()].data
    if data.lang == self.lang then
        return
    end
    self.lang = data.lang
    self:_refreshOption()
end

function PopupLanguage:_refreshOption()
    for i, v in ipairs(self.optionList) do
        v.node.selectImg:setVisible(v.data.lang == self.lang)
    end
end

return PopupLanguage