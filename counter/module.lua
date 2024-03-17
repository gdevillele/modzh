--
-- Cubzh Module : github.com/gdevillele/modzh/counter
--

local module = {}

local initForClient = function()
	module.test = function()
		print("Hello from counter module! 🙂 (Client)")
	end
end

local initForServer = function()
	-- module.counters[counterName][userID] == 42
	module.counters = {}

	module.test = function()
		print("Hello from counter module! 🙂 (Server)")
	end
end

if Client ~= nil then
	-- this is the client-side code
	initForClient()
elseif Server ~= nil then
	-- this is the server-side code
	initForServer()
else
	error("This module must be required from a client or server script", 2)
end

return module

-- -- Increments a counter and return its new value
-- module.increment = function(self, counterName, incrementBy)
-- 	-- args validation
-- 	if type(counterName) ~= "string" then
-- 		error("counterName must be a string", 2)
-- 	end
-- 	if type(incrementBy) ~= "number" and type(incrementBy) ~= "integer" then
-- 		error("incrementBy must be a number", 2)
-- 	end
-- 	incrementBy = math.floor(incrementBy)

-- 	-- increment counter
-- 	self.counters[counterName] = (self.counters[counterName] or 0) + 1

-- 	return self.counters[counterName]
-- end

-- -- Returns the value of a counter
-- module.get = function(self, counterName)
-- 	return self.counters[counterName]
-- end
