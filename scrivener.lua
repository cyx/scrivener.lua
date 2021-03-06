-- regex for matching emails in assert_email
local EMAIL =
	"[A-Za-z0-9%.%%%+%-]+" ..
	"@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?"

local valid = function(self)
	self:validate()

	return #self.errors == 0, self.errors
end

local assert_email = function(self, att)
	local val = self.attributes[att]

	self:assert_value(
		val and string.match(val, EMAIL),
		{att, "not_email"}
	)
end

local assert_present = function(self, att)
	local val = self.attributes[att]

	self:assert_value(val and val ~= '', {att, "not_present"})
end

local assert_value = function(self, val, tuple)
	if not val then
		table.insert(self.errors, tuple)
	end
end

local methods = {
	valid = valid,
	assert_present = assert_present,
	assert_email = assert_email,
	assert_value = assert_value,
}

-- @module interface
--
-- @example
--
--	 local scrivener = require("scrivener")
--
--	 local signup = scrivener(function (self)
--		 self:assert_email('email')
--		 self:assert_present('password')
--	 end)
--
return function(validator)
	local self = {
		validate = validator
	}

	setmetatable(self, {__index = methods})

	return function(attributes)
		self.attributes = attributes
		self.errors = {}

		return self:valid()
	end
end
