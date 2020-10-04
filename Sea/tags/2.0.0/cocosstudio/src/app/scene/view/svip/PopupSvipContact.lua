
local PopupBase = require("app.ui.PopupBase")
local PopupSvipContact = class("PopupSvipContact", PopupBase)

function PopupSvipContact:ctor()
	local resource = {
		file = Path.getCSB("PopupSvipContact", "svip"),
		binding = {
			_buttonAddQQ = {
				events = {{event = "touch", method = "_onButtonContact"}}
			},
            _buttonCopy = {
				events = {{event = "touch", method = "_onButtonCopy"}}
			},
		}
	}
	PopupSvipContact.super.ctor(self, resource)
end

function PopupSvipContact:onCreate()
	local nameImage = G_ConfigManager:getSvipImage()
	self._url = "https://mjzipa.sanguosha.com/images/"..nameImage..".jpg"
	-- i18n tw
	if Lang.checkLang(Lang.TW) then
		nameImage = self:_getServiceData().image
		self._url = G_ConfigManager:getVipPhotoUrl()..nameImage..".jpg"
	end
	self._fullFileName = cc.FileUtils:getInstance():getWritablePath().."userdata/"..nameImage..".jpg"

	self._popupBG:setTitle(Lang.get("svip_title"))
	self._popupBG:addCloseEventListener(handler(self, self._onClickClose))

	if not Lang.checkLang(Lang.TW) then
		self._textIntroTitle:setString(Lang.get("svip_intro_title"))
		self._imageBanner:loadTexture(Path.getSvip("service_biaoti", ".png"))
	end
    self._textIntro:setString(Lang.get("svip_text_1"))
    self._textNumTitle:setString(Lang.get("svip_num_title_1"))
    self._buttonAddQQ:setString(Lang.get("svip_button_add_qq"))

    self._textQQ:setString(G_ConfigManager:getSvipQQ())

    self:_updateImage()
	
	-- i18n tw
	self:_dealByI18n()
end

function PopupSvipContact:onEnter()
	
end

function PopupSvipContact:onExit()

end

function PopupSvipContact:_updateImage()
	local file, err = io.open(self._fullFileName)
	if file then
		self._sprite:setTexture(self._fullFileName)
	else
		self:_loadImage()
	end
end

function PopupSvipContact:_loadImage()
	local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr.fullFileName = self._fullFileName
    xhr:open("GET", self._url)

    local function onReadyStateChanged()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            print(" ---> img net load get statusText : " , xhr.response )
            local fileData = xhr.response
            local fullFileName = xhr.fullFileName
        	local file = io.open(fullFileName,"wb")
	        file:write(fileData)
        	file:close()
        	local texture2d = cc.Director:getInstance():getTextureCache():addImage(fullFileName)
	        if texture2d and self._sprite then
	            self._sprite:setTexture(fullFileName)
	        end
        else
            print(" --- > error xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
        xhr:unregisterScriptHandler()
    end

    xhr:registerScriptHandler(onReadyStateChanged)
    xhr:send()
end

function PopupSvipContact:_onButtonContact()
	local number = self._textQQ:getString()
	G_NativeAgent:clipboard(number)
	G_Prompt:showTip(Lang.get("svip_copy_success"))
end

function PopupSvipContact:_onButtonCopy()
	local number = self._textQQ:getString()
	G_NativeAgent:clipboard(number)
	G_Prompt:showTip(Lang.get("svip_copy_success"))
end

function PopupSvipContact:_onClickClose()
	self:close()
end

-- i18n tw
function PopupSvipContact:_getServiceData()
	local serverId = G_GameAgent:getLoginServer():getServer()
	local vipCfg = require("app.config.vip_game_service")
	local max = vipCfg.length()
	local serviceNum = math.ceil(serverId/2) % max
	if serviceNum == 0 then
		serviceNum = max
	end
	local serviceData = vipCfg.get(serviceNum)
	self._serviceData = serviceData
	return serviceData
end
function PopupSvipContact:_dealByI18n()
	if Lang.checkLang(Lang.TW) then
		self._textQQ:setString(self._serviceData.wechat_id)

		-- local title = ccui.Helper:seekNodeByName(self, "Image_48")
		-- title:ignoreContentAdaptWithSize(true)
		self._imageBanner:ignoreContentAdaptWithSize(true)

		local bg = ccui.Helper:seekNodeByName(self, "Image_1")
		bg:setAnchorPoint(0.5,1)
		bg:setContentSize(cc.size(560,211))
		bg:setPositionY(145)

		-- local text8 = ccui.Helper:seekNodeByName(self, "Text_8")
		-- text8:setAnchorPoint(0,0.5)
		-- text8:setPositionX(-120)
		local filePath = Path.getLangImgTextJson("editor_key")
		local jsonData = Lang.decodeJsonFile(filePath)
		local txt = jsonData["editor.svip.10"]
		self._textNumTitle:setString(txt)

        local function onCopyBtn()
			local number = self._textLine:getString()
			G_NativeAgent:clipboard(number)
			G_Prompt:showTip(Lang.get("svip_copy_success"))
		end
		local CSHelper = require("yoka.utils.CSHelper")
        local btn = CSHelper.loadResourceNode(Path.getCSB("CommonButtonLevel0Highlight", "common"))
        btn:setString(Lang.getImgText("txt_copy_line"))
        btn:addClickEventListenerEx(onCopyBtn)
        self:getResourceNode():addChild(btn)
		btn:setPosition(351,-130)
		btn:setFontSize(22)
		self._buttonAddQQ:setFontSize(22)

		local UIHelper = require("yoka.utils.UIHelper")
		local label = UIHelper.createLabel({
			text = Lang.getImgText("txt_svp_line") ,
			position = cc.p(-120,-101),
			color = cc.c3b(0xb6, 0x65, 0x11),
			size = 22,
			anchorPoint = cc.p(0,0.5)
		})
		self:getResourceNode():addChild(label)

		local imageBkParam = {
			anchorPoint = cc.p(0,0),
			position = cc.p(-120,-159),
			texture = Path.getUICommon("img_input_board01")
		}
		local imageBg = UIHelper.createImage(imageBkParam)
		imageBg:setScale9Enabled(true)
		imageBg:setCapInsets(cc.rect(4,4,4,4))
		imageBg:setContentSize(cc.size(352,41))
		self:getResourceNode():addChild(imageBg)

		self._textLine = UIHelper.createLabel({
			text = self._serviceData.line_id,
			position = cc.p(-109,-138),
			color = cc.c3b(0xb6, 0x65, 0x11),
			size = 22,
			anchorPoint = cc.p(0,0.5)
		})
		self:getResourceNode():addChild(self._textLine)
	end
end

return PopupSvipContact