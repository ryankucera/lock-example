--#ENDPOINT GET /test-users

-- get user ids
local users = User.listUsers()

local judy = users[1]
local frank = users[2]

-- create a table to hold results
local t = {users}

-- this should be true
table.insert(t, "tests (every other line below should be 'OK')")
-- expect ok (judy has access to lock 001)
table.insert(t, User.hasUserRoleParam({
	id = judy.id, role_id = 'owner', parameter_name = 'lockID', parameter_value = '001'
}))
-- expect error (frank is not owner of lock 001)
table.insert(t, User.hasUserRoleParam({
	id = frank.id, role_id = 'owner', parameter_name = 'lockID', parameter_value = '001'
}))
-- expect ok (judy has access to lock 002)
table.insert(t, User.hasUserRoleParam({
	id = judy.id, role_id = 'owner', parameter_name = 'lockID', parameter_value = '002'
}))
-- expect error (judy does not have access to lock 999)
table.insert(t, User.hasUserRoleParam({
	id = judy.id, role_id = 'owner', parameter_name = 'lockID', parameter_value = '999'
}))
-- expect "OK" (frank has guest access to lock 001)
table.insert(t, User.hasUserRoleParam({
	id = frank.id, role_id = 'guest', parameter_name = 'lockID', parameter_value = '001'
}))
-- expect error (frank has no dwellingID param)
table.insert(t, User.hasUserRoleParam({
	id = frank.id, role_id = 'guest', parameter_name = 'dwellingID', parameter_value = 1
}))
-- expect "OK"
table.insert(t, User.hasUserRoleParam({
	id = judy.id, role_id = 'owner', parameter_name = 'dwellingID', parameter_value = 1
}))
-- expect error
table.insert(t, User.hasUserRoleParam({
	id = judy.id, role_id = 'owner', parameter_name = 'dwellingID', parameter_value = 2
}))

return t
