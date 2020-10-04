-- iphoneX公告清除缓存
local NativeAgent = require("app.agent.NativeAgent")
local name = NativeAgent.callStaticFunction("getDeviceModel", nil, "string")
if name == "iPhone10,3" or name == "iPhone10,6" then
	local PopupNotice = require("app.ui.PopupNotice")
	PopupNotice.onShowFinish = function(self)
		local discSize = self._webLayer:getContentSize()
		if ccexp.WebView then
	        self._webView = ccexp.WebView:create()
	        self._webView:setPosition(cc.p(discSize.width/2,  discSize.height/2))
	        self._webView:setContentSize(discSize.width,  discSize.height)
	        self._webView:loadURL(self._url, true)
	        self._webView:setScalesPageToFit(false)
	        self._webView:setBounces(false)

	        self._webLayer:addChild(self._webView)
	    end
	end
end


xpcall(function (  )
    local NativeAgent = require("app.agent.NativeAgent")
    G_ResolutionManager.getDeviceOffset = function(self)
        local name = NativeAgent.callStaticFunction("getDeviceModel", nil, "string")
        logWarn("ResolutionManager:getDeviceOffset native model name ", name)
        local function matchIPhoneXS(name)
            local matchTable = {}
            matchTable["iPhone11,2"] = 50
            matchTable["iPhone11,4"] = 50
            matchTable["iPhone11,6"] = 50
            matchTable["iPhone11,8"] = 50
            if matchTable[name] ~= nil then
                return matchTable[name]
            end
            return nil
        end
    
        -- name = "iPhone10,3"
        if name ~= nil and name ~= "" then
            local iPhonexs_offset = matchIPhoneXS(name)
            if iPhonexs_offset then
                return iPhonexs_offset
            end
    
            local device = require("app.config.device")
            local cfg = device.get(name)
            if cfg then
                return cfg.offset
            end
        end
        return 0 
    end
    
    --获取设备刘海偏移量
    G_ResolutionManager.getBangOffset = function( self )
        return self:getDeviceOffset()
    end
    
end,function( ... )
end)
    

xpcall(function (  )
	local StateDamage = require("app.fight.states.StateDamage")
	local BuffManager = require("app.fight.BuffManager")

	StateDamage.onFinish = function(self)
		if self._isLastBuff then 
			local buffManager = BuffManager.getBuffManager()
			buffManager:checkDelBefore()
			buffManager:clearBuffEffect(self._entity.stageID)
		end
		self._entity.is_alive = self._entity.to_alive
		if not self._entity.is_alive then
			self._entity:dispatchDie()
		end
		StateDamage.super.onFinish(self)
	end
	
	local LoopAttackBase = require("app.fight.loop.LoopAttackBase")
	LoopAttackBase._processBuffEffect = function(self)
		for _, buffData in pairs(self._data.buffEffects) do
			local data = self:_processBuff(buffData)
			self._buffManager:addBuffEffect(data, self._unit.stageID)
		end		
	end

	LoopAttackBase.execute = function(self)
		for i, v in pairs(self._targets.cell) do
			v.unit.attackIndex = self._index
	   end
	   -- 计算伤害
	   for i,v in ipairs(self._targets.list) do
		   local target = v.unit
		   local info = v.info
		   if info.type == 1 then
			   target.hp = target.hp - info.value
			   if target.hp < 0 then
				   target.hp = 0
			   end
		   else
		   
		   end
	   end
	   self._finish = false
	   self:_startSkill()
	end

	BuffManager.addBuffEffect = function(self, data, stageID)
		if not self._buffEffect[stageID] then 
			self._buffEffect[stageID] = {}
		end
		table.insert(self._buffEffect[stageID], data)	
	end

	BuffManager._checkBuffEffect = function(self, stageId)
		if not self._buffEffect[stageId] or #self._buffEffect[stageId] == 0 then 
			return 
		end
		local unit = self._engine:getUnitById(stageId)
		assert(unit, "stage id is nil = "..stageId)    
		unit:damage(self._buffEffect[stageId])
	end

	BuffManager.clearBuffEffect = function(self, stageId)
		self._buffEffect[stageId] = {}
	end


end,function( ... )
end)

local BlackList = require("app.utils.BlackList")
BlackList.filterBlack = function(text)
	return text
end

local HeroSkillEffect = require("app.config.hero_skill_effect")
HeroSkillEffect.set(2376, "buff_pos", 12)

local ConfigManager = require("app.manager.ConfigManager")
ConfigManager.schema["blackListOpen"]             = {"boolean", true}         -- 已接入
ConfigManager.isBlackListOpen = function(self)
    return true
end

xpcall(function (  )

    local silkbag = require("app.config.silkbag")
    silkbag.setLang = function(id, key, value)
        local record = silkbag.get(id)
        if record then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
            end
        end
    end

    

    local silk_mapping = require("app.config.silk_mapping")
    silk_mapping.setLang = function(silk_id,hero_id, key, value)
        local record = silk_mapping.get(silk_id,hero_id)
        if record then
            local keyIndex =  record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
            end
        end
    end
    
    
    silkbag.setLang(1313,"description", "Khi tướng trị liệu thi triển kỹ năng, hồi HP cho 3 đồng đội yếu nhất và tăng thêm 32% tấn công cho tướng trị liệu." )
  

    silk_mapping.setLang(11313,102,"description", "Hồi HP và tăng thêm 32% tấn công cho tướng trị liệu." )
    silk_mapping.setLang(11313,202,"description", "Hồi HP và tăng thêm 32% tấn công cho tướng trị liệu." )
    silk_mapping.setLang(11313,302,"description", "Hồi HP và tăng thêm 32% tấn công cho tướng trị liệu." )
    silk_mapping.setLang(11313,402,"description", "Hồi HP và tăng thêm 32% tấn công cho tướng trị liệu." )
    silk_mapping.setLang(11313,216,"description", "Hồi HP và tăng thêm 32% tấn công cho tướng trị liệu." )
    

end,function( ... )
end)


xpcall(function (  )

    local hero_rank = require("app.config.hero_rank")
    hero_rank.setLang = function(id,rank,limit, key, value)
        local record = hero_rank.get(id,rank,limit)
        if record then
            local keyIndex = record._lang_key_map[key]
            if keyIndex then
                record._lang[keyIndex] = value
            end
        end
    end

    
    hero_rank.setLang(401,8,0,"talent_description", "Đánh thường, giảm 1 nộ địch" )
  

end,function( ... )
end)


xpcall(function (  )

local ConfigManager = require("app.manager.ConfigManager")
ConfigManager.schema["appstoreFeatureOpen"]             = {"boolean", true}         -- 已接入
ConfigManager.isAppstoreFeatureOpen = function(self)
    return true
end


local ChatConst = require("app.const.ChatConst")
local ChatSetting = require("app.data.ChatSetting")
ChatSetting.getCheckBoxValue = function(self,id)
	local checkboxData = self:_getSettingValue("checkbox") 
	local checkValue = nil
	if  checkboxData then
		  checkValue = checkboxData[id] --checkboxData[id] or   ChatConst.SETTING_CHECK_BOX_DEFAULT[id]
	end
	if not checkValue then
		if id == ChatConst.SETTING_KEY_AUTO_VOICE_WORLD  or 
			id == ChatConst.SETTING_KEY_AUTO_VOICE_GANG  then
			checkValue = G_ConfigManager:isVoiceAutoPay() and 1 or 0
		else
			checkValue = ChatConst.SETTING_CHECK_BOX_DEFAULT[id]	
		end

		--i18n
		if G_ConfigManager:isAppstoreFeatureOpen() and G_NativeAgent:getNativeType() == "ios"  then 
			checkValue = 0
		end
		

	end
--	checkValue = checkValue or 0
	return checkValue
end	

local RollNoticeConst = require("app.const.RollNoticeConst")
local RollNoticeData = require("app.data.RollNoticeData")
 RollNoticeData._s2cRollNotice = function(self,id,message)
	--optional string msg = 1;
	--optional uint32 notice_type = 2;
    --optional uint32 notice_id = 3;
	--repeated uint32 location = 4;

    --paomadeng not find id 0
       print("-------------xxxxsd")
    if RollNoticeConst.NOTICE_TYPE_GM ~= message.notice_type and message.notice_id == 0 then 
        local msg = rawget(message,"msg")
        local noticeType = rawget(message,"notice_type")
        local noticeId = rawget(message,"notice_id")
        assert(nil,string.format("RollNoticeData test %s %s %s",tostring(msg),tostring(noticeType),tostring(noticeId)))
        return
    end

 

    local location = rawget(message,"location")  or {}
    local rollMsg = {msg = nil,noticeType = message.notice_type,param = "",sendId = message.send_id}
    if RollNoticeConst.NOTICE_TYPE_GM == message.notice_type then
        rollMsg.msg = message.msg
    else
        local PaoMaDeng = require("app.config.paomadeng")
        local cfg = PaoMaDeng.get(message.notice_id)
        assert(cfg,"paomadeng not find id "..tostring(message.notice_id))

        rollMsg.msg = cfg.description
        rollMsg.param = message.msg
				rollMsg.noticeId = message.notice_id
    end

    for k,v in ipairs(location) do
        
         --i18n 
         if not (G_ConfigManager:isAppstoreFeatureOpen() and G_NativeAgent:getNativeType() == "ios" ) and v ==  RollNoticeConst.ROLL_POSITION_ROLL_MSG then
            G_SignalManager:dispatch(SignalConst.EVENT_ROLLNOTICE_RECEIVE,rollMsg)
         end
    

        if v == RollNoticeConst.ROLL_POSITION_CHAT_MSG then
             self:_onAddNewMessage(rollMsg)

        end
    end
 
end

G_UserData:getRollNotice()._s2cRollNoticeListener:remove()
G_UserData:getRollNotice()._s2cRollNoticeListener = nil
G_UserData:getRollNotice()._s2cRollNoticeListener = G_NetworkManager:add(MessageIDConst.ID_S2C_RollNotice, handler(G_UserData:getRollNotice(), G_UserData:getRollNotice()._s2cRollNotice))


end,function( ... )
end)


local language = require("app.i18n.vn.LangTemplate")
language[ "FUNC_MAUSOLEUM"] = {{title ="Tổ đội", list ={"Vào Hoàng Lăng cần tổ đội, số người trong đội tối thiểu 1 người.","Trong Hoàng Lăng chỉ có đội trưởng có thể tiến hành thao tác di chuyển và tấn công, thành viên không thể thao tác.",} },{ title ="Thủ Vệ và Phần Thưởng", list ={"Tổ đội diệt Hoàng Lăng Thủ Vệ khác nhau sẽ nhận thưởng khác nhau.","Tổ đội gây sát thương cho Thủ Vệ lớn hơn 60% và kết liễu Thủ Vệ mới được nhận thưởng.","Hoàng Lăng-Thượng: Diệt Tiên Tần Giáp Sĩ có xác suất nhận Xuân Thu.","Hoàng Lăng-Trung: Diệt Tiên Tần Đồ Binh có xác suất nhận Xuân Thu hoặc Chiến Quốc.","Hoàng Lăng-Hạ: Diệt Tiên Tần Xa Binh có xác suất nhận Chiến Quốc.","Diệt Hoàng Lăng Mộng Yểm có xác suất cao nhận Xuân Thu Chiến Quốc.",} },{ title ="Tranh đoạt", list ={"Tiểu đội có thể diệt đội đang đánh Thủ Vệ, tranh đoạt thưởng Hoàng  Lăng.","Chiến đấu áp dụng cơ chế 3 trận thắng 2, người chơi ở vị trí tương ứng trong mỗi đội lần lượt chiến đấu.","Đội chiến đấu thất bại sẽ trở về điểm sinh ra và vào thời gian chờ hồi sinh.",} },{ title ="Thời gian hoạt động cá nhân và hỗ trợ", list ={"Mỗi người mỗi ngày có 10 phút thời gian hoạt động cá nhân và 10 phút thời gian hỗ trợ.","Sau khi dùng hết thời gian hoạt động cá nhân sẽ tự động bắt đầu tốn thời gian hỗ trợ; sau khi hết hai thời gian trên sẽ tự động thoát Hoàng Lăng, trong ngày không được vào nữa.","Thời gian hoạt độn cá nhân và thời gian hỗ trợ hôm trước chưa dùng hết có thể tích lũy đến hôm sau, mỗi loại thời gian có thể tích lũy tối đa 70 phút, đạt đến 70 phút, thời gian sẽ không tăng nữa.","Trong thời gian hoạt động cá nhân diệt Thủ Vệ được nhận thưởng, trong thời gian hỗ trợ diệt Thủ Vệ không được nhận thưởng.",} },{ title ="Thưởng rơi cộng thêm", list ={"Khi tất cả người chơi trong đội đều đến cùng một Quân Đoàn, xác suất thưởng rơi khi diệt Thủ Vệ +20%.",} },}


xpcall(
    function()
        local NativeAgent = require("app.agent.NativeAgent")
        G_ResolutionManager.getDeviceOffset = function(self)
            local name = NativeAgent.callStaticFunction("getDeviceModel", nil, "string")
            logWarn("ResolutionManager:getDeviceOffset native model name ", name)
            local function matchIPhoneXS(name)
                local matchTable = {}
                matchTable["iPhone11,2"] = 50
                matchTable["iPhone11,4"] = 50
                matchTable["iPhone11,6"] = 50
                matchTable["iPhone11,8"] = 50
                matchTable["iPhone12,1"] = 50
                matchTable["iPhone12,3"] = 50
                matchTable["iPhone12,5"] = 50
                if matchTable[name] ~= nil then
                    return matchTable[name]
                end
                return nil
            end

            -- name = "iPhone10,3"
            if name ~= nil and name ~= "" then
                local iPhonexs_offset = matchIPhoneXS(name)
                if iPhonexs_offset then
                    return iPhonexs_offset
                end

                local device = require("app.config.device")
                local cfg = device.get(name)
                if cfg then
                    return cfg.offset
                end
            end
            return 0
        end

        --获取设备刘海偏移量
        G_ResolutionManager.getBangOffset = function(self)
            return self:getDeviceOffset()
        end

        local Engine = require("app.fight.Engine")
        Engine.playFeatures = function (self, stageId, skillId, callback)
            local unit = self:getUnitById(stageId)
            -- assert(unit, "stageid = "..stageId.." skillid = "..skillId)
            if unit then
                unit:playFeature(skillId, callback)
            end
        end

    end,
    function(...)
    end
)
BlackUnits.get = function(self,key)
    if self._unit_data[key] then
        return self._unit_data[key]
    end
        return {}
end

