-- Author: ${USER_NAME}
-- Date:${DATE}
-- Describle：

local BaseData = require("app.data.BaseData")
local ${FILENAME} = class("${FILENAME}", BaseData)

local schema = {}
--schema
${FILENAME}.schema = schema


function ${FILENAME}:ctor(properties)
	${FILENAME}.super.ctor(self, properties)

${PROTO_LISTEN}

end

function ${FILENAME}:clear()
${CLEAR_PROTO_LISTEN}
end

function ${FILENAME}:reset()

end

${PROTO_FUNCTION}

return ${FILENAME}
