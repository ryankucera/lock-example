--#ENDPOINT GET /_init
-- This endpoint is called when the solution is first created.
-- For demonstration it creates some sample users, roles,
-- and device permissions

-- create sample users
User.activateUser({
	code=User.createUser({
		name="judy",
		email="judy@exosite.com",
		password="judy-password1"
	})
})
User.activateUser({
	code=User.createUser({
		name="frank",
		email="frank@exosite.com",
		password="frank-password1"
	})
})

-- create initial lock states
util.setStates('lockID', '001', { 'name', 'Home' })
util.setStates('lockID', '002', { 'name', 'Studio' })

-- get user ids
local users = User.listUsers()
local judy = users[1]
local frank = users[2]

-- create roles
User.createRole({
	role_id='owner',
	parameter={
		{ name = 'lockID'},
		{ name = 'dwellingID'}
	}
})
User.createRole({
	role_id='guest',
	parameter={
		{ name='lockID'}
	}
})

-- assign roles to users (including parameters
-- for the role's permissions)
User.assignUser({
	id = judy.id,
	roles = {
		{
			role_id = 'owner',
			parameters = {
				{
					name = 'lockID',
					value = '001' 
				},
				{
					name = 'lockID',
					value = '002' 
				},
				{
					name = 'dwellingID',
					value = '1'
				}			
			}
		}		
	}
})

-- frank gets guest access to lock 001
User.assignUser({
	id = frank.id,
	roles = {
		{
			role_id = 'guest',
			parameters = {
				{
					name = 'lockID',
					value = '001' 
				}
			}
		}		
	}
})

