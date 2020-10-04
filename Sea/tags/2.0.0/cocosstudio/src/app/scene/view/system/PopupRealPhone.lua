local PopupBase = require("app.ui.PopupBase")
local PopupRealPhone = class("PopupRealPhone", PopupBase)

local SchedulerHelper = require ("app.utils.SchedulerHelper")

function PopupRealPhone:ctor(avoidMode)
	local resource = {
		file = Path.getCSB("PopupRealPhone", "system"),
		binding = {
			_btnOK = 
			{
				events = {{event = "touch", method = "_onOKClick"}},
			}
		}
	}
	self._avoidMode = avoidMode
	if avoidMode then
		PopupRealPhone.super.ctor(self, resource, false, false)
	else 
		PopupRealPhone.super.ctor(self, resource)
	end
end

function PopupRealPhone:onCreate()
	
	cc.bind(self._btnSend, "CommonButtonLevel0Highlight")
	self._btnSend:addClickEventListenerEx(handler(self,self._onSendClick))

	self._bg:setTitle(Lang.getImgText("txt_avoid_title"))
	self._textTitle:setString(Lang.getImgText("txt_real_phone_content"))
	self._btnOK:setString(Lang.getImgText("txt_finish"))
	self._btnSend:setString(Lang.getImgText("txt_send_phone"))
	self._btnSend:getDesc():setColor(cc.c3b(0xf3, 0xA2, 0x53))
	self._btnSend:getDesc():enableOutline(cc.c3b(0x7C, 0x2C, 0x12), 2)

	self._textTips:setString("")
	self._textPlayerName:setString("")
	self._textId:setString("")
	
	self._optTotalTime = 5 * 60
	self._optTime = 0
	self._isOptCd = false
	self._isRequest = false

	if self._avoidMode then 
		self._bg:hideCloseBtn()
	else 
		self._bg:addCloseEventListener(function() self:closeWithAction() end)
	end

	local InputUtils = require("app.utils.InputUtils")
	self._editBox = InputUtils.createInputView(
		{ 	
			bgPanel = self._panelInputName,
			fontSize = 22,
			fontColor = Colors.CHAT_MSG,
			placeholderFontColor = Colors.INPUT_CREATE_ROLE,
			placeholder = Lang.getImgText("txt_avoid_input_phone"),
			maxLength = 15,
		}
	)

	self._editBoxId = InputUtils.createInputView(
		{ 	
			bgPanel = self._panelInputId,
			fontSize = 22,
			fontColor = Colors.CHAT_MSG,
			placeholderFontColor = Colors.INPUT_CREATE_ROLE,
			placeholder = Lang.getImgText("txt_avoid_input_opt"),
			maxLength = 8,
		}
	)
end

function PopupRealPhone:onEnter()
	self._scheduler = SchedulerHelper.newSchedule(handler(self,self._update), 1)
end

function PopupRealPhone:onExit()
	if self._scheduler then
		SchedulerHelper.cancelSchedule(self._scheduler)
		self._scheduler = nil
	end
end

-- "txt_avoid_title":"手机绑定",
-- "txt_avoid_content":"主公，您今日已在线满3小时，请主公先绑定手机，再继续体验游戏哟！",
-- "txt_real_phone_content":"主公，您今日已在线满3小时，请主公先绑定手机，再继续体验游戏哟！",
-- "txt_finish":"确定",
-- "txt_send_phone":"发送otp",
-- "txt_avoid_phone":"手机号",
-- "txt_avoid_opt":"otp码",
-- "txt_avoid_input_phone":"请输入手机号",
-- "txt_avoid_input_opt":"请输入otp码",
-- "txt_avoid_time":"#count#S",
-- "txt_phone_tip_not":"请先输入手机号",
-- "txt_phone_tip_error_phone":"手机号码有误，请检查",
-- "txt_phone_tip_finish":"已发送otp到对应手机",
-- "txt_phone_tip_win":"手机绑定成功，感谢您的支持",
-- "txt_phone_tip_error_not_math":"otp码和手机号不匹配，请检查",
-- "txt_phone_http_error0":"未知错误",
-- "txt_phone_http_error2":"非法操作",
-- "txt_phone_http_error3":"您输入的号码不支持本地区使用",
-- "txt_phone_http_error4":"OTP还有效力，5分钟后才能发送新的OTP码",
-- "txt_phone_http_error5":"otp码已超时，请再次获取新的opt码",
-- "txt_phone_http_error6":"otp码有误，请检查",


function PopupRealPhone:_onSendClick()
	local strPhone = self._editBox:getText()
	if not strPhone or strPhone == ""  then
		G_Prompt:showTip(Lang.getImgText("txt_phone_tip_not"))
		return 
	else
		-- 越南手机号为10位或11位， 纯数字
		if string.len(strPhone) < 10 or not tonumber(strPhone) then 
			G_Prompt:showTip(Lang.getImgText("txt_phone_tip_error_phone"))
			return 
		end

		-- opt 发送cd中
		if self._isOptCd then 
			G_Prompt:showTip(Lang.getImgText("txt_phone_http_error4"))
			return 
		end

        -- http://127.0.0.1:8000/mobile_verify_req?zone=vn&sid=123&uid=234&uuid=xxxx&name=xxx&phone=123456778
		self._optPhone = strPhone

		local param = {}
		param["phone"] = strPhone
		G_GameAgent:setPhoneAuthCode(param,handler(self, self._onEventPhoneAuthCode))

	end
end

-- "txt_avoid_title":"Xác nhận số điện thoại",
-- "txt_avoid_content":"Bạn đã online 3 tiếng, hãy xác nhận số điện thoại để có thể tiếp tục trải nghiệm game.",
-- "txt_real_phone_content":"Bạn đã online 3 tiếng, hãy xác nhận số điện thoại để có thể tiếp tục trải nghiệm game.",
-- "txt_finish":"Tiếp tục",
-- "txt_send_phone":"Gửi OTP",
-- "txt_avoid_phone":"Số điện thoại",
-- "txt_avoid_opt":"Mã OTP",
-- "txt_avoid_input_phone":"Hãy nhập số điện thoại",
-- "txt_avoid_input_opt":"Hãy nhập mã OTP",
-- "txt_avoid_time":"#count#S",
-- "txt_phone_tip_not":"Vui lòng nhập số điện thoại",
-- "txt_phone_tip_error_phone":"Số điện thoại không chính xác, hãy thử lại",
-- "txt_phone_tip_finish":"Đã gửi mã OTP đến số điện thoại của bạn",
-- "txt_phone_tip_win":"Xác nhận thành công",
-- "txt_phone_tip_error_not_math":"Mã OTP sai, hãy thử lại",
-- "txt_phone_http_error0":"Lỗi chưa xác nhận",
-- "txt_phone_http_error2":"Thao tác sai",
-- "txt_phone_http_error3":"Số điện thoại sai",
-- "txt_phone_http_error4":"Mã OTP vẫn còn hiệu lực, sau 5 phút mới có thể gửi mã OTP mới",
-- "txt_phone_http_error5":"Mã OTP đã hết hạn, vui lòng bấm 'Gửi OTP' để nhận mã OTP mới",
-- "txt_phone_http_error6":"Mã OTP sai, hãy thử lại",

function PopupRealPhone:_onEventPhoneAuthCode(errorCode, param)
	if errorCode == 1 then 
		G_Prompt:showTip(Lang.getImgText("txt_phone_tip_finish"))
		self._optTime = self._optTotalTime
		-- self._optTime = 100

		self._isRequest = true
		self._isOptCd = true
	else
		G_Prompt:showTip(Lang.getImgText("txt_phone_http_error"..errorCode))
	end
end


function PopupRealPhone:_onOKClick()

	local strPhone = self._editBox:getText()
	local strOpt = self._editBoxId:getText()
	print("PopupRealPhone:_onOKClick()  strPhone：" .. strPhone )
	print("PopupRealPhone:_onOKClick()  strOpt" .. strOpt )

	--otp码和手机号不匹配
	if strPhone ~= self._optPhone then 
		G_Prompt:showTip(Lang.getImgText("txt_phone_tip_error_not_math"))
		return 
	end

	if not self._isOptCd and  self._isRequest then 
		G_Prompt:showTip(Lang.getImgText("txt_phone_http_error5"))
		return 
	end

 
	-- urlContent = urlContent .. "code=" .. code .. ""
	local param = {}
	param["code"] = strOpt
	G_GameAgent:setRealPhone(param,handler(self, self._onEventRealPhone))

end

function PopupRealPhone:_onEventRealPhone(errorCode, param)
	if errorCode == 1 then 
		G_Prompt:showTip(Lang.getImgText("txt_phone_tip_win"))
		self._isOptCd = false
		self:closeWithAction()
	else
		if errorCode == 5 then  -- 请求过期 重新请求
			self._isOptCd = false
			self._isRequest = false
			G_Prompt:showTip(Lang.getImgText("txt_phone_http_error5"))
			return
		end 
		if errorCode == 6 then -- 验证码错误重新输入
			self._isOptCd = false
			G_Prompt:showTip(Lang.getImgText("txt_phone_http_error6"))
			return
		end 
		G_Prompt:showTip(Lang.getImgText("txt_phone_http_error"..errorCode))
	end
end



function PopupRealPhone:_update()
	if not self._isOptCd then return end
	-- local time = G_UserData:getBase():getOnlineTime()
	-- local strTime = G_ServerTime:getTimeStringHMS(time)
	-- self._textTime:setString(Lang.getImgText("online_time", {count = strTime}))
	self._optTime = self._optTime - 1
	-- print("PopupRealPhone:_update()  optTime" .. self._optTime )
	self._btnSend:setString(Lang.getImgText("txt_avoid_time",{count=self._optTime}))

	if self._optTime < 0 then
		self._isOptCd = false
		self._btnSend:setString(Lang.getImgText("txt_send_phone"))
	end

end

return PopupRealPhone

