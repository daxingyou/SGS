local CommonSelectNumNode = require("app.ui.component.CommonSelectNumNode")
local CommonSelectNumNodeNew =  class("CommonSelectNumNodeNew",CommonSelectNumNode)

local EXPORTED_METHODS = {
	"updateAmount",
	"getAmount",
	"setTextDesc",
	"setMaxLimit",
	"setCallBack",
	"setAmount",
	"showButtonMax",
    "getMaxLimit",
    "setCountPerUnit",--i18n ja
}

function CommonSelectNumNodeNew:ctor()
	self._target = nil
	self._button = nil
	self._seleclCallBack = nil

	self._composeCount = 0
    self._countPerUnit = 1--i18n ja
    self._maxLimit = 999
end

function CommonSelectNumNodeNew:updateAmount(num)
	--dump( self._composeCount )
	num = num * self._countPerUnit 
	local addNum = self._composeCount + num

	self:setAmount(addNum)
end

--i18n ja
function CommonSelectNumNodeNew:setCountPerUnit(count)
    if count then
        self._countPerUnit = count 
        if self:getAmount() < self._countPerUnit  then
            self:setAmount(self._countPerUnit )
        end
    end
end

function CommonSelectNumNodeNew:setMaxLimit(max,count)
	self:setCountPerUnit(count)

    if max > 999 * self._countPerUnit then
		max = 999 * self._countPerUnit
	end
	self._maxLimit = max or 999 * self._countPerUnit

	if self:getAmount() > self._maxLimit then
		self:setAmount(self:getAmount())
	end

	if self:getAmount() < self._countPerUnit then
		self:setAmount(self._countPerUnit)
	end
end

function CommonSelectNumNodeNew:setAmount(num)
	self._composeCount = num
	
	if self._composeCount <= 0 then
		self._composeCount = self._countPerUnit
	end

	if self._composeCount >= self._maxLimit then
		self._composeCount = self._maxLimit
	end
	
	self._textAmount:setString(""..self._composeCount)
end

return CommonSelectNumNodeNew
