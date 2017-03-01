--#ENDPOINT POST /token
-- create a token for this user, given request body
-- {"email":"<email>", "password":"<password>"}

local ret = User.getUserToken({
	email = request.body.email,
	password = request.body.password
})
if ret ~= nil and ret.status_code ~= nil then
	-- fail. respond with the status_code and message
	response.code = ret.status_code
	response.message = ret.message
else
	-- pass
	response.code = 200
	-- put the token in a session ID cookie, for browsers
	response.headers = {
		["Set-Cookie"] = "sid=" .. tostring(ret)
	}
	-- ...and in the response body, for native mobile apps,
	-- external servers, tools, etc.

  local user = User.getCurrentUser({token = ret})
  if user ~= nil and user.id ~= nil then
		user.token = ret
		response.message = user
	else
		response.code = user.status
		response.message = user
	end
end

