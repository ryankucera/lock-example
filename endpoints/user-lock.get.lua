--#ENDPOINT GET /user/lock/
-- Get the state of all the locks a given user
-- can access.
local user = util.currentUser(request)
if user ~= nil and user.id ~= nil then
	locks = util.getUserAccessibleItems(user.id, 'lockID')
  return locks
else
	response.code = 400
	response.message = "Token invalid"
end

