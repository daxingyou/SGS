local language = require("app.i18n.tw.LangTemplate")
language["sdk_platform_mantain"]            = "伺服器正在進行維護更新，維護時間請參見官方粉絲頁"
language["login_update_hint"]				= "親愛的主公，全新版本已準備就緒，本次更新约%.2fMB，建議您在WIFI環境下更新。如更新遇到問題，請聯繫客服。"




xpcall(function ()
    local RollNoticeHelper = require("app.scene.view.rollnotice.RollNoticeHelper")
    RollNoticeHelper.splitServerRollMsg2 = function(msg)
        local list = string.split(msg, ",") or {}
        local values = {}
        for i = 1, #list do
            if list[i] then
                values[i] = {}
                local subMsg = list[i]
                --local index = string.find(subMsg,"#")
                --if index then--多个名称之类
                local nameList = string.split(subMsg, "#") or {}
                for k, nameStr in ipairs(nameList) do
                    local subList = string.split(nameStr, "|") or {}
                    if #subList > 0 and subList[1] and subList[1] ~= ""  then
                        local temp = subList[1]
                        temp = string.gsub(temp, "\\\"", "\"")
                        temp = string.gsub(temp, "\"{", "{")
                        temp = string.gsub(temp, "}\"", "}")
                        subList[1] = Lang.getLangTxtFromChannel(temp)
                    end
                    table.insert(values[i], subList)
                end
            -- else
            --     local subList = string.split(subMsg, "|") or {}
            --     table.insert( values[i] , subList )
            -- end
            end
        end
        return values
    end
 end,function( ... )
 end)

 xpcall(function ()
    local RollNoticeHelper = require("app.scene.view.rollnotice.RollNoticeHelper")
    RollNoticeHelper.makeRichMsgFromServerRollMsg = function(rollMsg, colorParam) 
        local values = nil
        if rollMsg.noticeId == 403 or rollMsg.noticeId == 404 then
            values = RollNoticeHelper.splitServerRollMsg2(rollMsg.param)
        else
            values = RollNoticeHelper.splitServerRollMsg(rollMsg.param)
        end   
        --拆分服务器数据
        values = RollNoticeHelper.decodeColors(values) --将品质颜等生成颜色
        local RichTextHelper = require("app.utils.RichTextHelper")
        local subTitles = RichTextHelper.parse2SubTitleExtend(rollMsg.msg)

        subTitles = RichTextHelper.fillSubTitleUseReplaceTextColor(subTitles, values, rollMsg.noticeId)
        local richElementList =
            RichTextHelper.convertSubTitleToRichMsgArr(
            colorParam or
                {
                    textColor = Colors.PAOMADENG,
                    --跑马灯的默认字体颜色
                    outlineColor = Colors.PAOMADENG_OUTLINE,
                    outlineSize = 2,
                    fontSize = 20
                    --跑马灯的默认字体大小
                },
            subTitles
        )
        local richStr = json.encode(richElementList)
        -- logWarn(richStr)
        return richStr, richElementList
    end

end,function( ... )
end)

 xpcall(function ()
	local BuffManager = require("app.fight.BuffManager")
	BuffManager.doBuffEndOp = function(self,endOps)
		if endOps and #endOps ~= 0 then
			for i, v in pairs(endOps) do
				local unit = self._engine:getUnitById(v.stageId)
				--i18n bug
				if unit then
					if unit.to_alive then
						unit.to_alive = v.isAlive
					end
					unit:doBuffEndOp(v.type, v.damage)
				end
			end
		end
	end

end,function( ... )
end)