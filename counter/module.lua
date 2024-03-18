--
-- Cubzh Module : github.com/gdevillele/modzh/counter
--

local module = {}

local initForClient = function()
	module.counters = {} -- TODO: REMOVE THIS

	module.test = function()
		print("Hello from counter module! 🙂 (Client)")
	end

	module.increment = function(self, userID, counterName, incrementBy)
		-- args validation
		if type(userID) ~= "string" then
			error("userID must be a string", 2)
		end
		if type(counterName) ~= "string" then
			error("counterName must be a string", 2)
		end
		if type(incrementBy) ~= "number" and type(incrementBy) ~= "integer" then
			error("incrementBy must be a number", 2)
		end

		-- TODO: send event to server

		-- --- REMOVE THIS ---
		if self.counters[counterName] == nil then
			self.counters[counterName] = {}
		end
		self.counters[counterName][userID] = (self.counters[counterName][userID] or 0) + incrementBy
		-- -------------------

		return self.counters[counterName][userID]
	end

	module.get = function(self, userID, counterName)
		-- args validation
		if type(userID) ~= "string" then
			error("userID must be a string", 2)
		end
		if type(counterName) ~= "string" then
			error("counterName must be a string", 2)
		end
		return self.counters[counterName][userID] or 0
	end

	module.runUnitTests = function()
		print("Running UnitTests for counter module...")

		local userID = "user1"
		local counterName = "counter1"
		local t

		t = module:get(userID, counterName)
		if t ~= 0 then
			error("get() should return 0 when counter does not exist")
		end

		t = module:increment(userID, counterName, 1)
		if t ~= 1 then
			error("increment() should return 1")
		end

		print("UnitTests for counter module (client) passed! 🙂")
		return true
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
