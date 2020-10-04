local ChatConst = require("app.const.ChatConst")
-- local Chat = require("app.config.chat")
local ChatDataHelper = {}
local Chat = nil

function ChatDataHelper.getChatParameterById(id)
	--i18n config change
	if Chat == nil then Chat = require("app.config.chat") end
	local config =  Chat.get(id)
	assert(config,"chat config not find id "..tostring(id))
	return tonumber(config.content) or 0
end


function ChatDataHelper.getShowChatChannelIds()
	local FunctionCheck = require("app.utils.logic.FunctionCheck")
	local allChannelIds = { ChatConst.CHANNEL_ALL,ChatConst.CHANNEL_WORLD,ChatConst.CHANNEL_GUILD,ChatConst.CHANNEL_TEAM,
        ChatConst.CHANNEL_PRIVATE }
	local ids = {}
	for k,v in ipairs(allChannelIds) do
		if v == ChatConst.CHANNEL_TEAM then
			local isOpen = FunctionCheck.funcIsOpened(FunctionConst.FUNC_GROUPS)
			if isOpen then
				table.insert(ids,v)
			end
		else
			table.insert(ids,v)
		end
	  	
	end
	return  ids
end


return ChatDataHelper