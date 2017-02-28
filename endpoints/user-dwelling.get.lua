--#ENDPOINT GET /user/dwelling/
-- Get the state of all the dwellings a given user
-- can access.
local user = util.currentUser(request)
if user ~= nil and user.id ~= nil then
	locks = util.getUserAccessibleItems(user.id, 'dwellingID')
  return locks
else
	response.code = 400
	response.message = "Token invalid"
end

