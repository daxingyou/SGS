
-- Author: ${USER_NAME}
-- Date:${DATE}
-- Describle：

local ${BASE_CLASS_NAME} = require("${BASE_CLASS_NAME_PATH}")
local ${FILENAME} = class("${FILENAME}", ${BASE_CLASS_NAME})
${OTHER_REQUIRE}

function ${FILENAME}:ctor()

	--csb bind var name
${CSB_BINDING}

	local resource = {
		file = Path.getCSB("${FILENAME}", "${SCENE_NAME}"),
${EVENT_BINDING}
	}
	${FILENAME}.super.ctor(self, resource)
end

${OTHER}

return ${FILENAME}