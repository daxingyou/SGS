local PopupItemUse = require("app.ui.PopupItemUse")
local PopupItemUseNew =  class("PopupItemUseNew",PopupItemUse)

function PopupItemUseNew:ctor(title,callback )
    PopupItemUseNew.super.ctor(self,title,callback)
end

function PopupItemUseNew:onCreate()
    cc.bind(self._selectNumNode, "CommonSelectNumNodeNew")
    PopupItemUseNew.super.onCreate(self)
end

function PopupItemUseNew:setMaxLimit(max,countPerUnit)
    --if max == 0 or max == nil then
    if max == nil then
		assert(false, "PopupItemUse:setMaxLimit max can not be 0")
		return
	end
    self._selectNumNode:setMaxLimit(max,countPerUnit)

    self._useNum = self._selectNumNode:getAmount() 
end

return PopupItemUseNew