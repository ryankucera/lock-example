--#ENDPOINT GET /lock/

-- get all the locks. This illustrates a public endpoint 
-- with no authentication and therefore no associated user

-- assume only only one product associated with
-- this solution.
local solutionConfig = Config.solution()
if table.getn(solutionConfig.products) == 0 then
	response.code = 400
	response.message = 'Uh oh. No product has been associated with this solution. You can configure a product under Services->Product->Configuration.'
  return
end
local pid = solutionConfig.products[1]

-- get the list of devices for this product
local devices = Device.list({pid=pid})
local response = {}
for k, device in pairs(devices) do
	device.state = util.getStates('lockID', device.sn)
	-- this is deprecated
	device.rid = nil
	-- for consistency, match output of getUserAccessibleItems
	device.lockID = device.sn
	device.sn = nil
	-- ...except role_id, which doesn't make sense here
	
	table.insert(response, device)
end
return devices

