function ${FILENAME}:_init${LISTVIEW_NAME}()
	-- body
	self.${VAR_NAME}:setTemplate()
	self.${VAR_NAME}:setCallback(handler(self, self._on${LISTVIEW_NAME}ItemUpdate), handler(self, self._on${LISTVIEW_NAME}ItemSelected))
	self.${VAR_NAME}:setCustomCallback(handler(self, self._on${LISTVIEW_NAME}ItemTouch))

	-- self.${VAR_NAME}:resize()
end

-- Describle：
function ${FILENAME}:_on${LISTVIEW_NAME}ItemUpdate(item, index)

	-- item:updateUI()
end

-- Describle：
function ${FILENAME}:_on${LISTVIEW_NAME}ItemSelected(item, index)

end

-- Describle：
function ${FILENAME}:_on${LISTVIEW_NAME}ItemTouch(index, params)

end
