local PopUpPlayerFrameHelper = {}

local currentTouchIndexId = 0


function PopUpPlayerFrameHelper.getCurrentTouchIndex()
	return currentTouchIndexId
end

function PopUpPlayerFrameHelper.setCurrentTouchIndex(indexId)
	currentTouchIndexId = indexId
end




return PopUpPlayerFrameHelper
