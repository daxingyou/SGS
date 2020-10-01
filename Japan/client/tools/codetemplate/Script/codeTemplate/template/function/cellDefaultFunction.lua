function ${FILENAME}:onCreate()
	-- body
	local size = self._resourceNode:getContentSize()
	self:setContentSize(size.width, size.height)

${ONCREATE_OTHER}
end

function ${FILENAME}:updateUI()
	-- body
end