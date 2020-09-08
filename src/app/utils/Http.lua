local Http = {}


Http.OK = 200
Http.ERROR_CODE_LOWER = 207
Http.READY_STATE_OK = 4

function Http.sendRequest(type, url, callback)

	local xhr = cc.XMLHttpRequest:new()
	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
	xhr:open(type or "POST", url)

	local function onReadyStateChanged()
		
		if xhr.readyState == Http.READY_STATE_OK and (xhr.status >= Http.OK and xhr.status < Http.ERROR_CODE_LOWER) then
			print(" ---> get statusText : " , xhr.response )

			local response = json.decode(xhr.response)
			local ret = tonumber(response.ret)
			dump(ret, "http ret=>")
			if ret == 1 then
				if callback then
					callback(response)
				end
			end

		else
			print(" --- > error xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
		end
		xhr:unregisterScriptHandler()
	end

	xhr:registerScriptHandler(onReadyStateChanged)
	xhr:send()
end



return Http