-- Describle：${NOTE}
-- Param:
${PARAM_NOTE}
function ${FILENAME}:c2s${MSG_NAME}(${PARAMS})
	G_NetworkManager:send(MessageIDConst.ID_C2S_${MSG_NAME}, {
${PARAMS_LIST}
	})
end