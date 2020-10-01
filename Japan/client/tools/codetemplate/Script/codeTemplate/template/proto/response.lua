-- Describle：${NOTE}
function ${FILENAME}:_s2c${MSG_NAME}(id, message)
	if message.ret ~= MessageErrorConst.RET_OK then
		return
	end
	--check data
${CHECK_DATA}

	G_SignalManager:dispatch(SignalConst.${MSG_EVENT_NAME})
end