--#ENDPOINT POST /locks/{lockID}
-- This is a public endpoint
-- send lock-command to a particular lock
local pid = Config.solution().products[1]

local r = Device.write({
  pid=pid,
  device_sn=request.parameters.lockID,
  ['lock-command']=request.body['lock-command']
})

return r

